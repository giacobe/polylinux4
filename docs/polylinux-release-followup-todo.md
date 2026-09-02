# PolyLinux Release Follow-up To-do List

Use this file to track unresolved findings from testing the standardized PolyLinux release. Completed findings are removed after acceptance; deferred work remains until completed or explicitly cancelled.

## Status values

- `New`: reported but not yet investigated
- `Confirmed`: reproduced and scoped
- `In progress`: actively being addressed
- `Ready to retest`: corrected locally or in GitHub and awaiting server testing
- `Complete`: corrected and successfully tested on the server
- `Deferred`: intentionally postponed, with the reason recorded

## Current findings

| ID | Status | Lab or component | Finding | Expected behavior | Evidence or reproduction | Resolution | Retest result |
| --- | --- | --- | --- | --- | --- | --- | --- |
| LAB7-001 | Deferred | Lab 7 - Processes and Job Control | The participant guide is missing a code-submission form. | The authoritative guide, manifest, and generated site page should reference the current external Microsoft Form, and the form should load from the published page. | Reported during server testing. | Recover or create the intended form URL, record it in the lab manifest, and generate the guide and site link from that single value. | Deferred until a Microsoft Form URL is available. |
| UI-002 | Complete | All published labs | Instruction boxes use the former 80-column layout and lack a clear divider between metadata and level instructions. | Render each box at exactly 40 terminal columns, including borders. Add a full row of `*` characters between the identity metadata block and the case or level instructions. | Reported during server testing. | Change the shared renderer once, migrate every generated README/profile box to it, and add exact-width tests for every rendered line. | Passed server testing. |
| LAB13-001 | Complete | Lab 13 - PolyBandit | All 13 parallel level builders fail because `render_box_file` is unavailable inside the level-script processes. | All 13 levels should build successfully; the learner may enter bandit1 after its README is replaced with the completed instructions. | `/root/bandit1.sh` through `/root/bandit13.sh` report `line 59: render_box_file: not found`; the build log ends with `13 level builds failed`. | Make the renderer available at the subprocess boundary by sourcing the shared helper from each builder or invoking a standalone renderer. Add a test that launches each builder exactly as `install.sh` does. | Passed server testing. |
| LAB8-001 | Complete | Lab 8 | The instructions include the redundant line `Generated for: <email> (exercise <code>)`. | Display participant identity and exercise code only in the canonical metadata block. | Reported during server testing with exercise code `13527DF`. | Remove the extra generated-for line at its template source and test the generated instructions for a single metadata occurrence. | Passed server testing. |
| META-001 | Complete | All published labs; observed in Labs 3, 5, and 7 | Some instructions repeat exercise code, learner/participant, and theme after the canonical metadata block. | Each level should contain exactly one canonical metadata set: Level, PolyLinux, Participant, Exercise code, and Theme where applicable. PolyBandit remains unthemed. | Lab 7 repeats `Exercise code`, `Learner`, and `Theme`; Labs 3 and 5 were also reported. | Remove duplicate per-level template fragments and add cross-lab generated-output assertions that each canonical field occurs once. | Passed server testing. |
| UI-003 | Complete | All published labs; observed in Labs 6 and 8 | Long profile/instruction lines produce a ragged or displaced right-hand `*` border. | Every boxed line should wrap within the 40-column layout and place its right border in column 40. | The line beginning `Use the external answer form...` extends beyond the other Lab 8 lines; Lab 6 has similar output. | Route all text through the shared wrapping renderer rather than hand-padding strings; test line lengths and both border columns. | Passed server testing. |
| TERMS-001 | Complete | All published labs; especially Lab 1 | Some VM and participant-guide instructions call a submitted level answer a "password," inheriting the original Bandit progression model. | Use "answer" for information submitted to the external form. Use "password" only when a value is technically an authentication credential, and clearly distinguish it from the submitted answer. | Reported in Lab 1 hints; a repository-wide content audit is required. | Audit VM README templates, profile text, hints, and every `participant-guide.md`; correct the terminology and add a prohibited-phrase check with explicit credential-context exceptions. | Passed server testing. |
| LAB14-001 | Complete | Lab 14 - Compression | The lab is still named "Compression Bandit," although it is a PolyLinux exercise and should not inherit the Bandit identity. | Use "PolyLinux Compression" as the canonical full name and "Compression" where a shorter display label is needed. | Reported during release review. | Update the lab repository, participant guide, manifest, website navigation and page title, VM instructions and banners, generated artifact metadata, and release tests; retain old names only in historical records where necessary. | Passed server testing. |
| LAB14-002 | Complete | Lab 14 - Compression | Participant-facing text says "Submit answers to the exercise grader," which may imply submission to a person or unspecified grading system. | Say "Submit answers to the exercise grading form." | Reported during server testing. | Change the phrase at its authoritative template source, regenerate the VM instructions and participant guide, and verify it is absent from the packaged root filesystem. | Passed server testing. |
| FORM-LANG-001 | Complete | All published labs | Submission language is not consistently explicit that learners should fill out an external form. | Participant-facing instructions should consistently direct learners to the "exercise grading form" or "external answer form," never merely an "external grader," "exercise grader," or ambiguous submission destination. | Repository audit found "external grader" in the PolyBandit README and "code-submission panel" in the Lab 10 guide. Most other active guides already use clear form language. Generated VM content still requires inspection. | Audit guides, READMEs, VM templates, banners, and packaged instructions; normalize ambiguous phrases while preserving technical grader documentation that is not participant-facing. Add a participant-content terminology check. | Passed server testing. |
| COLOR-001 | Ready to retest | Labs 7, 10, 13, and 14; lab creation baseline | `ls` output does not use the established high-contrast PolyLinux color scheme in these labs. | Labs 7, 10, 13, and 14 should use the same accessible, high-contrast `ls` colors as the other published labs. The shared lab-creation baseline should install and validate this scheme for every future lab. | Root cause confirmed: these baselines provide GNU Coreutils `ls`, which does not inherit BusyBox's color-by-default behavior. | Install one byte-identical `polylinux-colors.sh` through `/etc/profile.d`, source it from learner profiles, use `ls --color=auto`, enforce it in source/package contracts, and package fresh root filesystems. | Source and packaged-image checks passed; awaiting visual confirmation on the test server. |
| LAB6-001 | Ready to retest | Lab 6 - File Manipulation | The standardized migration removed the `validate` filesystem-state key generator and changed levels to request individual filenames, breaking the lab's original grading concept. | Learners complete each filesystem task, run `validate`, and submit its exact 10-character state key. The VM generates a key for every state but never reports correctness; the external grader performs comparison. | The original live rootfs contains `/root/validate` and installs it as `/usr/bin/validate`; commit `a58a468` deleted it while the participant guide continued to document it. | Restore the state-fingerprint generator, installer integration, per-level and web instructions, regression tests, contract exception, GitHub source, and packaged Lab 6 image. | Source and packaged-image checks passed; awaiting test-server execution and grader reconciliation. |

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
