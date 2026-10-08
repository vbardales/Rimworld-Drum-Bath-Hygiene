# Audit history, one line per audit

Moved out of `STATUS.md` on 2026-10-02 (AUDIT.md, step 11: before putting the mod to sleep). The full text of each section
is in git: `git log -p -- STATUS.md`. Pickle runs are in `README.md` of this folder.

- 2026-09-12 — first static audit: Release build clean; XML parse, metadata, licence copies and packaging pass; ten XML patch cases; DLL carries `IgnoresAccessChecksTo("Assembly-CSharp")`; `_tools/Test-Mod.ps1` created. Thirteen written scenarios, none played yet.
- 2026-09-12 — preview recomposed from `Art/Preview-source.png` with `Art/preview.html` and `render-preview.cjs`; contrast 11.04 (title), 5.96 (summary), 10.51 (badge); approved by the owner. Since replaced (summary narrowed 2026-09-24; ModIcon cutout and `Art/preview-copy.json` on 2026-10-02).
- 2026-09-13 — audit: stage `done`; translation audit: no player-facing text, `not_applicable`; settings `not_applicable`.
- 2026-09-21 — audit: `done` unchanged (author respelled `Nelim`); no game launched.
- 2026-09-22 — audit: `done` unchanged; 0.1.0 prepublished by the owner (item `3806137182`, `PublishedFileId.txt`); PEReader needs PowerShell 7.
- 2026-09-23 — audit: `done` -> `tested` on runs 8 and 9 (19 of 19, EN and FR), all `done -> tested` criteria met.
- 2026-10-02 — audit: `tested` confirmed (no `@wip`/`@requires`, offline suite replayed, evidence trimmed 24 -> 8 MB, `.dds`/`desktop.ini`/evidence ignored); then 1.0.1 published and thanks posted: `published`.
- 2026-10-05 — code review (low effort, one diff pass) from 0.1.0 (`d7e1737`) to `61207940149cf94cc61f9506982d11ae378ff405`: 0 findings; `Source/`, `Mod/Patches/` and `Mod/Assemblies/` unchanged since 0.1.0, CI scripts (template-generated) and tests not examined in detail.
- 2026-10-08 — code review (low effort, one diff pass) from 1.0.0 (`c6a0939`) to 1.0.2, `93539d13a9cb9e959f469956614114f2edb59b3c`: 0 findings; only `Mod/About/About.xml` (description) and images changed, DLL, `Source/` and `Mod/Patches/` identical.
- 2026-10-08 — gallery captures (feature 07, SanctuaryBacklot map): runs 606c (scenario 1) and e17f (scenario 2) green, they produced `Art/Gallery/1-the-bath.jpg` and `2-the-needs-tab.jpg` (accepted by the owner); their evidence folders were deleted, the committed images are the result. 1.0.2 (description) published 2026-10-08 from `93539d1`.
