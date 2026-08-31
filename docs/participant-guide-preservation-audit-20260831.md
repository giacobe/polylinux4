# Participant Guide Preservation Audit - 2026-08-31

This audit compares the participant guides in the captured live-site commit
`a4be29c` with the authoritative guides used for the corrected release. The
review covers front matter, Microsoft Forms linkage, level guidance, command
examples, answer-format instructions, navigation, and troubleshooting.

| Lab | Captured words | Corrected words | Level coverage | Result |
| --- | ---: | ---: | --- | --- |
| 1 | 1,308 | 1,348 | 10 levels | Preserved; standardized workflow additions retained. |
| 2 | 1,145 | 1,111 | 10 levels | Preserved for the standardized ten-level curriculum; the obsolete eleventh level is intentionally excluded. |
| 3 | 636 | 616 | 10 levels | Preserved; operational wording updated for the standardized VM. |
| 5 | 1,986 | 2,011 | 10 levels | Restored from `lab5/grepawksed.md`; current exercise-code, theme, navigation, and external-grading language added. |
| 6 | 1,883 | 1,812 | 10 levels | Preserved; current level workflow retained. |
| 7 | 210 | 2,581 | 10 levels | Expanded guide retained; no prior Microsoft Form URL existed. |
| 8 | 606 | 609 | 10 levels | Preserved. |
| 10 | 1,700 | 1,734 | 10 levels | Restored from `lab10/logs.md`; current exercise-code, theme, parallel-build, and external-grading language added. |
| 13 | 643 | 643 | 13 Bandit levels | Preserved without thematic conversion; Microsoft Form URL restored. |
| 14 | 1,025 | 1,080 | 10 levels | Restored from `lab14/compression.md`; automatic installation, theme, parallel-build, and external-grading language added. |

## Release safeguards

`tools/test-release-contract.ps1` now rejects a release when:

- an authoritative guide and its `polylinux4` site copy differ;
- an established Microsoft Forms URL is removed or changed;
- a guide falls below ninety percent of its captured word count;
- Labs 5, 10, or 14 lose their essential reference, level-guidance, or
  troubleshooting headings;
- shared runtime files drift between repositories;
- a shipped shell entry point contains a carriage-return byte; or
- Lab 1 reintroduces `theme-context.txt` generation.

The Markdown validator is also run against every published participant guide.

