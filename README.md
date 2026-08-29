# PolyLinux browser site

This repository captures the browser-delivered PolyLinux catalog and lab pages
published at <https://polylab.ist.psu.edu/polylinux/>.

It contains:

- the 14-lab catalog;
- the shared page template, CSS, JavaScript, v86 runtime, WebAssembly module,
  and BIOS files;
- launch pages and participant Markdown for every currently published lab;
- a repeatable public-site synchronization script.

See [`RECREATE-SITE.md`](RECREATE-SITE.md) for the complete reconstruction,
server-configuration, VM-artifact placement, dependency, validation, and
deployment workflow.

## Published lab pages

The current public site has individual launch pages for Labs 1, 2, 3, 5, 6,
7, 8, 10, 13, and 14. Labs 4, 9, 11, and 12 are catalog entries marked as
planned and do not yet have individual public pages.

Each published lab directory contains an `index.html` configuration that links
the shared template to:

- a participant-facing Markdown instruction file;
- a lab-specific `bzImage` kernel;
- a lab-specific `*.cpio.gz` initrd;
- an answer form referenced by the Markdown when one is published.

Lab 7 currently has no answer-form link in its published Markdown. This mirror
preserves that live state rather than inventing a form URL.

## VM image policy

Lab-specific kernels and initrds are deliberately excluded from this repository:

```text
**/*bzImage
**/*.cpio.gz
```

Their paths remain in the launch-page configuration so the institutionally
managed files can be uploaded manually. The smaller shared v86 runtime,
WebAssembly, and BIOS dependencies are included.

## Refreshing the public snapshot

From PowerShell:

```powershell
& .\scripts\sync-live-polylinux.ps1
```

The script downloads public HTML, Markdown, CSS, JavaScript, and shared runtime
dependencies. It refuses to download lab kernels or initrds and writes capture
details to `LIVE-SNAPSHOT.md`.

After refreshing, review the diff, verify every instruction/form link, and
commit only after confirming no VM image was added.
