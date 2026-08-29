# Recreating the PolyLinux website

This runbook recreates the currently published PolyLinux site from its GitHub
sources. It intentionally preserves unfinished labs in their current catalog
state. Microsoft Forms remain externally hosted, and the institutionally
managed `bzImage` and `*.cpio.gz` files are copied to the server manually.

## What is reproducible

This repository contains the catalog, shared page template, CSS, JavaScript,
published lab launchers and instructions, v86 browser runtime, WebAssembly
module, and BIOS files. The following files are deliberately not stored here:

```text
**/*bzImage
**/*.cpio.gz
```

The current public site has launch pages for Labs 1, 2, 3, 5, 6, 7, 8, 10,
13, and 14. Labs 4, 9, 11, and 12 remain in their existing incomplete catalog
state. Do not create placeholder launchers for them as part of a routine site
reconstruction.

## Source repositories

| Lab | Payload repository | Buildroot configuration | Site directory |
| --- | --- | --- | --- |
| 1 | `giacobe/polylinux-basic` | `basic` | `lab1/` |
| 2 | `giacobe/polylinux-text-manipulation` | `basic` | `lab2/` |
| 3 | `giacobe/filesystem-navigation` | `basic` | `lab3/` |
| 5 | `giacobe/polylinux-grep-awk-sed` | `basic` | `lab5/` |
| 6 | `giacobe/polylinux-fm` | `basic` | `lab6/` |
| 7 | `giacobe/polylinux-processes` | `basic-processes` | `lab7/` |
| 8 | `giacobe/polylinux-redirection` | `basic` | `lab8/` |
| 10 | `giacobe/polylinux-logs` | `basic-compression` | `lab10/` |
| 13 | `giacobe/polybandit3.1` | `basic-compression` | `lab13/` |
| 14 | `giacobe/polylinux-compression` | `basic-compression` | `lab14/` |

Buildroot configurations and packaging scripts are maintained in
[`giacobe/buildroot-builder2`](https://github.com/giacobe/buildroot-builder2).
Each payload repository README contains its complete build and packaging
command.

## 1. Prepare the static site

Clone this repository into a staging directory, not directly over the live web
root:

```sh
git clone https://github.com/giacobe/polylinux4.git
cd polylinux4
```

Confirm that these shared runtime files are present:

```text
index.html
common.css
polylinux.css
lab-template.html
css/polylinux-vm.css
js/lab-loader.js
js/instructions.js
js/terminal.js
js/ui.js
js/vm-init.js
lib/libv86.js
lib/v86.wasm
bios/seabios.bin
bios/vgabios.bin
```

The top-level `libv86.js` is retained as part of the captured site, but the
shared lab template loads `lib/libv86.js`.

Do not open the lab HTML directly with a `file://` URL. The interface uses
browser `fetch()` calls for its shared template, Markdown, VM images, and other
assets, so it must be tested through HTTP or HTTPS.

## 2. Build the VM artifacts

Run Buildroot on a Linux host using a real Linux filesystem. The checked-in
profiles are validated against Buildroot `2025.02.15`:

```sh
git clone https://github.com/giacobe/buildroot-builder2.git
cd buildroot-builder2
BUILDROOT_VERSION=2025.02.15 scripts/01-setup-buildroot.sh
scripts/02-build-baseline.sh --config <configuration>
```

Then run the packaging command documented in the selected lab repository. It
combines that lab payload with the appropriate baseline and produces a kernel,
initrd, and manifest. Review the manifest and boot-test the exact output pair
before deployment.

## 3. Install the VM artifacts

Copy or rename the generated files to the exact names referenced by each
launcher:

| Lab | Kernel destination | Initrd destination |
| --- | --- | --- |
| 1 | `lab1/bzImage` | `lab1/rootfs.cpio.gz` |
| 2 | `lab2/bzImage` | `lab2/rootfs.cpio.gz` |
| 3 | `lab3/packaged.bzImage` | `lab3/packaged.rootfs.cpio.gz` |
| 5 | `lab5/packaged.bzImage` | `lab5/packaged.rootfs.cpio.gz` |
| 6 | `lab6/packaged.bzImage` | `lab6/packaged.rootfs.cpio.gz` |
| 7 | `lab7/packaged.bzImage` | `lab7/packaged.rootfs.cpio.gz` |
| 8 | `lab8/redirection-pipelines.bzImage` | `lab8/redirection-pipelines.rootfs.cpio.gz` |
| 10 | `lab10/packaged.bzImage` | `lab10/packaged.rootfs.cpio.gz` |
| 13 | `lab13/packaged.bzImage` | `lab13/packaged.rootfs.cpio.gz` |
| 14 | `lab14/packaged.bzImage` | `lab14/packaged.rootfs.cpio.gz` |

These files are ignored by Git. Their manual placement is the only required
deployment step that cannot be reproduced by cloning this repository.

## 4. Configure the web server

PolyLinux is a static client-side application. Apache, nginx, IIS, or another
static HTTPS server is sufficient. It does not require PHP, Node.js, Python, a
database, or a server-side v86 process.

Configure these content types:

| Extension | Content type |
| --- | --- |
| `.html` | `text/html; charset=utf-8` |
| `.css` | `text/css; charset=utf-8` |
| `.js` | `text/javascript; charset=utf-8` |
| `.md` | `text/markdown; charset=utf-8` |
| `.wasm` | `application/wasm` |
| `.bin` | `application/octet-stream` |
| `.bzImage` | `application/octet-stream` |
| `.cpio.gz` | `application/gzip` |

Serve the `*.cpio.gz` file as the stored binary. Do not configure it with an
HTTP `Content-Encoding: gzip` rule that makes the browser transparently
decompress it before v86 receives it.

Also ensure that:

- HTTPS is enabled with a valid certificate;
- the server permits files as large as the lab initrds;
- all files are readable by the web-server account;
- lab assets remain on the same origin to avoid CORS requirements;
- a Content Security Policy, if present, permits the external sources listed
  below and permits Microsoft Forms in a frame.

The current v86 configuration sets `use_shared_memory: false` and
`network_relay: null`. It therefore does not require cross-origin isolation, a
WebSocket relay, or a server-side networking service.

## 5. External browser dependencies

These dependencies are intentionally allowed to remain external. Participant
browsers, rather than the PolyLinux server, retrieve them.

| Host | Dependency | Reference |
| --- | --- | --- |
| `cdn.jsdelivr.net` | xterm.js CSS and JavaScript | `xterm@5.3.0` |
| `cdn.jsdelivr.net` | xterm fit add-on | `xterm-addon-fit@0.8.0` |
| `cdn.jsdelivr.net` | Markdown renderer | `marked/marked.min.js` |
| `cdn.jsdelivr.net` | Rendered-HTML sanitizer | `dompurify/dist/purify.min.js` |
| `fonts.googleapis.com` | Font stylesheet | Inter and Fira Code |
| `fonts.gstatic.com` | Font files | Inter and Fira Code |
| `forms.office.com` | Per-lab Microsoft Forms | URLs in Markdown front matter |
| `forms.microsoft.com` | Per-lab Microsoft Forms | URLs in Markdown front matter |

The `marked` and `DOMPurify` URLs are currently unpinned and may resolve to a
newer library release in the future. This reflects the captured site. Pinning
them should be handled as a reviewed site change, not silently during
reconstruction.

Microsoft Forms and their grading workflows remain external by design. This
repository preserves only the form URLs used by the published instructions.
Lab 7 currently has no form URL, matching the published site.

## 6. Stage and verify

For a local smoke test, start any static HTTP server from the repository root.
For example, if Python is already available on the staging machine:

```sh
python3 -m http.server 8000
```

Then open `http://localhost:8000/` and test every published lab. Before copying
to production, verify:

1. The catalog loads with its expected styles.
2. Every published lab launcher opens without a JavaScript console error.
3. The instruction timeline renders from the lab Markdown.
4. The terminal appears and the VM reaches its login prompt.
5. Keyboard input reaches the serial console.
6. The expected Microsoft Form loads, or the intentional Lab 7 placeholder is
   shown.
7. Browser network responses for `lib/v86.wasm`, the kernel, and initrd return
   HTTP 200 and nonzero content lengths.
8. Labs 4, 9, 11, and 12 remain in their intended incomplete catalog state.

Test at least one lab in every baseline family: `basic`, `basic-processes`, and
`basic-compression`. The current published pages do not yet exercise the
`basic-compression-networking` profile.

## 7. Publish

After the staging checks pass, copy the static repository files and the manual
VM artifacts to the production `/polylinux/` web directory using the
institutionally approved process. Preserve the directory names and filename
case exactly.

Re-run the verification checklist against the production HTTPS URL. Keep the
previous production directory or a server backup until the new deployment has
been verified, so rollback does not depend on rebuilding VM images.

## Future update workflow

For an existing lab:

1. Update and test the payload in its individual repository.
2. Build it with the Buildroot configuration named in that repository README.
3. Package and boot-test the generated VM pair.
4. Update the launcher or Markdown in this repository when necessary.
5. Review all external links and exact VM filenames.
6. Commit and push source changes.
7. Stage the site and manually add the generated VM artifacts.
8. Run the complete verification checklist before production deployment.

For a lab that is currently incomplete, leave its catalog state unchanged
until its payload, instructions, launcher, answer-form decision, and tested VM
pair are ready to be published together.

The `scripts/sync-live-polylinux.ps1` script is a disaster-recovery snapshot
tool, not the normal forward-deployment mechanism. It downloads the public
site while refusing to download VM images. Running it can replace repository
files with the current live versions, so always inspect its Git diff before
committing.
