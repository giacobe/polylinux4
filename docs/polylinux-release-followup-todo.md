# PolyLinux Release Follow-up To-do List

Use this file to track findings from testing the standardized PolyLinux release.
Add new findings without removing completed history.

## Status values

- `New`: reported but not yet investigated
- `Confirmed`: reproduced and scoped
- `In progress`: actively being addressed
- `Ready to retest`: corrected locally or in GitHub and awaiting server testing
- `Complete`: corrected and successfully retested
- `Deferred`: intentionally postponed, with the reason recorded

## Findings

| ID | Status | Lab or component | Finding | Expected behavior | Evidence or reproduction | Resolution | Retest result |
| --- | --- | --- | --- | --- | --- | --- | --- |
| LAB1-001 | Ready to retest | Lab 1 - Basic Linux Commands | The generated wordlist does not appear to correspond to the selected theme. | Each of the 16 themes should supply a reviewed, theme-appropriate wordlist while preserving the level's learning objective, deterministic seed behavior, and unique intended answer. | Server test used the `Transit Operations` theme; the exercise wordlist appeared unrelated to that theme. Inspect all ten levels and all 16 theme selections. | Lab 1 now materializes sixteen 16-entry dictionaries from the selected theme's catalog fields. All dictionary names remain deterministic and unique, and the legacy level mechanisms consume the themed dictionaries through `THEME_DICTIONARY_ROOT`. | Automated checks passed for all 16 themes, 16 dictionaries per theme, 16 unique entries per dictionary, and 256 unique entries per theme. Awaiting server retest. |
| LAB1-002 | Ready to retest | Lab 1 - Basic Linux Commands | Every learner home contains `Theme-context.txt`, although the selected theme is already displayed by the login profile. | Remove `Theme-context.txt` unless a particular level requires that file as intentional exercise evidence. The theme may remain visible in the profile and in level-specific instructions or data where useful. | Observed in each Lab 1 user directory during server testing. | Removed shared-runtime generation of `theme-context.txt`; theme remains in the boxed level README metadata. Added a release check preventing reintroduction. | Repository and release-contract tests passed. Awaiting server retest. |
| UI-001 | Ready to retest | All published labs and levels | The star-bordered terminal instructions are not laid out consistently. The metadata block is outside the border, and the level prompt has left, right, and bottom borders but no top border. Widths and offsets also differ between sections. | Use one shared, deterministic text-box renderer for every level in every lab. Each intended box should have aligned top, side, and bottom borders; metadata and prompt placement should follow one documented layout and handle variable text lengths without breaking alignment. | Lab 1 Level 5 screenshot: `C:/Users/nxg13/AppData/Local/Temp/codex-clipboard-d89c6130-a54d-4fe0-ae2a-a9b58dba572d.png`. The introductory box is complete, `Level` through `Theme` is unboxed, and the prompt begins with side borders but lacks a top border. | Added a shared 80-column renderer that strips partial legacy borders, wraps text, and boxes metadata plus instructions. Pending and failed messages use it as well. Removed redundant unboxed level lines from profiles; PolyBandit uses the renderer without themes. | Renderer width test and local Lab 2 v86 display test passed. Awaiting cross-lab server retest. |
| LAB2-001 | Ready to retest | Lab 2 - Text Manipulation | The VM does not boot on the test server. | The published Lab 2 page should load its `bzImage` and `rootfs.cpio.gz`, boot in v86, reach the root login, and automatically start `/root/install.sh` after root login. | Reported during server acceptance testing. Capture the browser console/network errors and distinguish missing or corrupt artifacts from a guest boot failure during investigation. | Repackaged Lab 2 from the validated `basic` baseline and current LF-normalized payload. Verified that the kernel, gzip/newc rootfs, root profile, installer, and runtime are present. | Exact packaged images returned HTTP 200 locally, booted in v86, reached the Buildroot login, launched the installer automatically after root login, accepted a test identity, and reached Level 1. Awaiting deployment/server retest. |
| FORMS-001 | Ready to retest | Published lab participant guides | Existing Microsoft Forms links were dropped from the active Markdown guides for Labs 3, 5, 6, 8, 10, 13, and 14. | Preserve the currently published form URL when replacing or revising a lab. The active `participant-guide.md`, lab manifest, site copy, and repository source should agree. A URL should be removed only by an explicit publication decision. | In `polylinux4` commit `a4be29c`, Labs 3, 5, 6, 8, 10, 13, and 14 each had a populated `form_url`; their current active guides use `form_url: ""`. Labs 1 and 2 retained their links. Lab 7 had no form URL in that captured baseline and remains a deliberate exception pending a form decision. | Restored the exact captured URLs in each authoritative guide, manifest, site copy, and manifest-generation script. Lab 7 remains empty. Added a release check that rejects changed or removed URLs. | Guide validators and release-contract test passed. Awaiting server form-loading retest. |
| GUIDE-001 | Ready to retest | Labs 5, 10, and 14 participant guides | Substantive participant instructions and level guidance were truncated during guide standardization. | Preserve the full instructional content of the last published guide while adapting obsolete operational details to the standardized exercise-code, automatic-installation, navigation, and external-form workflow. Each current guide must retain its lab overview, level-by-level tasks and hints, command guidance, answer-format rules, and troubleshooting content. | Compared current `participant-guide.md` files with the live-site capture in `polylinux4` commit `a4be29c`. Lab 5 fell from 1,986 to 272 words; Lab 10 from 1,700 to 149; Lab 14 from 1,025 to 143. The captured source files are `lab5/grepawksed.md`, `lab10/logs.md`, and `lab14/compression.md`. | Restored all three captured guides and merged current exercise-code, automatic-installation, parallel-build, theme, navigation, and external-grading language. Corrected word counts are 2,011, 1,734, and 1,080 respectively. | Markdown validators, required-heading checks, and site/source equality checks passed. Awaiting server visual retest. |
| GUIDE-002 | Ready to retest | All published lab participant guides | The migration lacked an explicit content-preservation audit, allowing complete-looking but materially shortened guides to pass release checks. | Before publication, compare every active guide with the prior published guide and require a documented review of removed headings, level instructions, hints, command examples, form links, and troubleshooting sections. Intentional curriculum changes may alter content, but must be recorded rather than silently discarded. | Word-count audit of captured versus current guides: Lab 1 `1308 -> 1348`; Lab 2 `1145 -> 1111`; Lab 3 `636 -> 616`; Lab 5 `1986 -> 272`; Lab 6 `1883 -> 1812`; Lab 7 `210 -> 2581`; Lab 8 `606 -> 609`; Lab 10 `1700 -> 149`; Lab 13 `643 -> 643`; Lab 14 `1025 -> 143`. This identifies Labs 5, 10, and 14 as clear truncations. Labs 1, 2, 3, 6, 7, 8, and 13 still require semantic review before being marked preserved; word-count proximity alone is not proof. | Completed and documented the preservation review in `docs/participant-guide-preservation-audit-20260831.md`. Added minimum-content, required-heading, Forms-link, and exact site/source-copy release checks. | Audit and release-contract checks passed for all ten published labs. Awaiting server visual retest. |

## Previously identified deferred work

| ID | Status | Lab or component | Finding | Next action |
| --- | --- | --- | --- | --- |
| FUT-001 | Deferred | Labs 4 and 12 | Labs remain planned and unpublished. | Design and implement them in a later effort. |
| FUT-002 | Deferred | Labs 9 and 11 | Images and repositories exist, but the labs remain unpublished. | Complete curriculum and publication review before enabling their catalog pages. |
| FUT-003 | Deferred | Microsoft Forms and Power Automate | External grading workflows are outside the VM/site migration. | Build and validate the grader workflows separately. |
| FUT-004 | New | Lab 2 - Text Manipulation form | The existing Microsoft Form still describes the former eleven-level exercise. | Update it to the standardized ten-level exercise when grading work begins. |
| FUT-005 | Deferred | Buildroot configurations | Four existing baselines are retained; consolidation has not been evaluated. | Measure boot time and command requirements before proposing consolidation. |
| FUT-006 | Deferred | Production deployment | The final production site must use HTTPS; the test server may remain HTTP. | Confirm HTTPS and security headers during production publication. |

## Testing notes

When recording a server finding, include when practical:

- test URL and lab number;
- browser and version;
- exercise code and normalized test email;
- visible theme, except for PolyBandit;
- level number;
- exact error text or unexpected behavior;
- whether reloading the VM reproduces it;
- screenshot or console/network evidence;
- date and approximate time of the test.

Do not record real participant passwords or other sensitive participant data.

