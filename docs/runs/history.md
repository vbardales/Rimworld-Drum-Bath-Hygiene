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
