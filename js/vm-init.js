"use strict";

function getPolyLinuxLabConfig() {
  return window.POLYLINUX_LAB_CONFIG || {
    bzimage: "./images/bzImage",
    initrds: ["./images/rootfs.cpio.gz"],
    assetBase: "./"
  };
}

function joinAssetPath(base, path) {
  if (/^(https?:)?\/\//i.test(path) || path.startsWith("/")) return path;
  return String(base || "./") + path.replace(/^\.\//, "");
}

async function loadInitrd(initrdUrls) {
  const urls = Array.isArray(initrdUrls) ? initrdUrls : [initrdUrls];
  if (urls.length === 0 || urls.some((url) => typeof url !== "string" || !url.trim())) {
    throw new Error("At least one initrd URL is required.");
  }

  const archives = await Promise.all(urls.map(async (url) => {
    const response = await fetch(url, { cache: "no-store" });
    if (!response.ok) {
      throw new Error(`Could not load initrd ${url}: ${response.status} ${response.statusText}`);
    }
    return new Uint8Array(await response.arrayBuffer());
  }));
  const totalLength = archives.reduce((total, archive) => total + archive.byteLength, 0);
  const combined = new Uint8Array(totalLength);
  let offset = 0;
  for (const archive of archives) {
    combined.set(archive, offset);
    offset += archive.byteLength;
  }
  return combined.buffer;
}

async function createVM({ screen_container, serial_container, bzimage_url, initrd_urls, assetBase }) {
  const initrdBuffer = await loadInitrd(initrd_urls);
  return new V86({
    wasm_path: joinAssetPath(assetBase, "lib/v86.wasm"),
    memory_size: 256 * 1024 * 1024,
    vga_memory_size: 8 * 1024 * 1024,
    screen_container,
    serial_container,
    use_worker: true,
    use_shared_memory: false,
    disable_speaker: true,
    network_relay: null,
    bios: { url: joinAssetPath(assetBase, "bios/seabios.bin") },
    vga_bios: { url: joinAssetPath(assetBase, "bios/vgabios.bin") },
    bzimage: { url: bzimage_url },
    initrd: { buffer: initrdBuffer },
    cmdline: "console=tty0 console=ttyS0,115200 loglevel=3 acpi=off noapic nolapic panic=-1 root=/dev/ram0 rw quiet net.ifnames=0 biosdevname=0",
    autostart: true
  });
}

window.addEventListener("load", async function () {
  const linuxSerial = document.getElementById("linux_serial");
  const linuxCont = document.getElementById("linux_container");

  if (!linuxSerial || !linuxCont) {
    console.error("Linux VM containers are missing from lab-template.html");
    if (typeof updateStatus === "function") updateStatus("VM container missing");
    return;
  }

  try {
    const cfg = getPolyLinuxLabConfig();

    const terminalBridge = initXtermTerminal(linuxSerial, () => window.emulator);

    window.emulator = await createVM({
      screen_container: null,
      serial_container: null,
      bzimage_url: cfg.bzimage,
      initrd_urls: cfg.initrds || cfg.initrd,
      assetBase: cfg.assetBase || "./"
    });

    attachV86SerialToXterm(window.emulator, terminalBridge);

    linuxCont.addEventListener("mousedown", () => {
      if (terminalBridge) terminalBridge.focus();
    });

    if (terminalBridge) terminalBridge.focus();
  } catch (e) {
    console.error("Linux VM error:", e);
    if (typeof updateStatus === "function") {
      updateStatus("Linux VM failed to start. Check console and file paths.");
    }
  }
});
