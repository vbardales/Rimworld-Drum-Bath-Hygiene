---
localization: not_applicable
translation_en: not_applicable
translation_fr: not_applicable
mod:          Drum Bath Hygiene
packageId:    nelim.drumbathhygiene
repo:         Rimworld-Drum-Bath-Hygiene
remote:       https://github.com/vbardales/Rimworld-Drum-Bath-Hygiene.git
folder:       C:/Users/nelim/Documents/rimworld/DrumBathHygiene
visibility:   public
repo_visibility: public
detached:     yes
workflow_stage: code[1.1.0]
code_review_sha: 93539d13a9cb9e959f469956614114f2edb59b3c
publication_changelog_review_sha: 93539d13a9cb9e959f469956614114f2edb59b3c
settings_audit: not_applicable
build_audit: complete
automated_tests: complete
xml_tests: complete
functional_scenarios: complete
in_game_tests: complete
audit_revision: 271365b630a9d2b1f4101edacaa1ec1e4bc72f08
licence:      open
license_spdx: MIT
licence_at:   LICENSE and Mod/LICENSE; original integration code, third-party dependencies credited in ATTRIBUTION.md
upstream_mod_remotes:
  - MMDrumcanMOD (Continued), Mlie: https://github.com/emipa606/MMDrumcanMOD
  - Dubs Bad Hygiene, Dubwise: N/A (not found)
owner:        Codex, task attached to this local repository
dependencies: declared
showcase:     preview approved by user; visual QA passed at full size and thumbnail; not verified in game
tested_on:    Pickle suite in game (RimWorld 1.6, Linux under WSL, Xvfb), non-regression 2026-10-11 on revision 02b3cb8 (runs 24 to 27): the 19 tools scenarios pass in English and French, the 2 gallery scenarios (sanctuary map) pass in both, removal chain passed 2026-10-08 (run 28cc, 536e4bf); runs 22 and 23 (271365b, 21 of 21) predate the Sanctuary migration; earlier: Release rebuild and the Windows PowerShell XML/packaging suite, 2026-09-22
workshop:      3806137182; 0.1.0 prepublished 2026-09-22 (item creation only), 1.0.0 sent by CI 2026-09-28,  1.0.1 2026-10-02, 1.0.2 2026-10-08 (description); public per the owner
remaining:
  - published 2026-10-02 (1.0.0 and 1.0.1 on the page, item public per the owner); thanks to Mlie and Dubwise posted 2026-10-02 (WORKSHOP_COMMENTS.md). Owner's manual steps of PUBLISHING.md "Mise en production d'une 1.0.0" (visibility, comment subscription, watching the mod and its parents MMDrumcanMOD and Dubs Bad Hygiene) confirmed done by the owner 2026-10-08.
  - open (BACKLOG.md "Tests still to write"): no scenario asserts the bathroom-thought stage (Dubs Bad Hygiene's own grading of a room); removing the mod from a save was played 2026-10-08 (run 28cc, green, `536e4bf`); adding it to a save made without it is not played as its own case.
  - feature: fire intensity, deferred in BACKLOG.md.
  - audit 2026-10-10: state written `followUp[1.0.2]` (old `published`); protocols read at `b4bb8a9` (AUDIT, AGENTS, PUBLISHING, WELCOME read; TRANSLATIONS, MOD_SETTINGS, SEARCHING, STYLE_RIMWORLD, PICKLE not reread, per `docs/PROTOCOLS-READ.md`).
  - defect (audit 2026-10-10, partly fixed): the save sentence said removal from a save was untested; played 2026-10-08 (run 28cc). Fixed in `PUBLICATION.md` (Steam description source) and `README.md`; `Mod/About/About.xml` (generated from that block, `sync-about-description.mjs --write`) and the Steam page still carry the old sentence until the next version, not shipped on 2026-10-10 (owner). A `Mod/` change reopens `code_review_sha` and the `x.y` review of the description.
  - defect (audit 2026-10-10): em dashes (U+2014) in `Mod/About/About.xml` and in the Steam description (THANKS, Dubwise line), also in `README.md`, `PUBLICATION.md`, `TESTING.md`, `Tests/` and `Source/` comments (rule of 2026-10-10; `CHANGELOG.md` is append-only).
  - known, accepted 2026-10-15: `Art/Preview-source.png` palette Vmean 0.184 (below 0.30, AUDIT.md 2.e), Preview already accepted and published, not reopened; `.build/` at the mod root (ignored, holds evidence).
  - unverified: `echo_review_sha` (keep or redo decision), `social_preview_sha256` (a custom share image exists, `og:image` checked 2026-10-10; the sha of the file sent is not recorded). `publication_changelog_review_sha` set to `93539d1` on the owner's confirmation (2026-10-10); the new save sentence in the description reopens it for the next version.
  - followUp left: 14.a non-regression ticket on the published build (DLL unchanged since `d7e1737`; `Mod/` differs from runs 22 and 23 only by the `About.xml` description), 14.c clean-up of `STATUS.md`, `TESTING.md`, `PUBLICATION.md`, 14.d branches (only `main`, nothing to delete).
  - open (1.7 pass, 2026-10-13 to 15, tickets 27c9, 2722, d108, 9910 queued): `tested_1_7` not decided. Feature 01: 4 of 6 scenarios pass on 1.7; the 2 left failed on Pickle's 5 s `I wait N ticks` deadline, replaced by `I let 600 ticks pass` (replay 9910). Features 02 to 06 not played on 1.7 (need `wsl-deps.tools-17.map` and a 1.7 Sanctuary Backlot for 07).
  - done: upstream pull request emipa606/MMDrumcanMOD#2 declined by Mlie 2026-10-03, who will link this mod in his description; closed, BACKLOG.md.
updated:      2026-10-13
protocols_read_sha: c25ae06225bd8489c501cf0fa400deac97b54192
---

# Drum Bath Hygiene: status

`workflow_stage: code[1.1.0]` (version 1.1.0 opened 2026-10-13 for the RimWorld 1.7 pass; was `followUp[1.0.2]`, audit 2026-10-10). Older audits, test runs and the
2026-09-12 preview notes were moved to `docs/runs/history.md` on 2026-10-02 (the full text stays in git).

## Current state (2026-10-10)

- **On Steam:** item `3806137182`, public per the owner. `1.0.2` (description: links, credits; tag `v1.0.2`, `93539d1`, dry-run 37757004462, publish 37757179159) sent 2026-10-08. `1.0.0` sent by CI 2026-09-28 (tag `v1.0.0`, `c6a0939`); `1.0.1`
  (new preview and icon) sent 2026-10-02 (tag `v1.0.1`, `55d5928`, dry-run 37032154323, publish 37032402412).
- **Tested:** non-regression 2026-10-11 on `02b3cb8` (runs 24 to 27): the 19 `tools` scenarios pass in English and French, the 2 gallery scenarios (`sanctuary` map) pass in both; removal chain passed 2026-10-08 (run 28cc, `536e4bf`). Runs 22 and 23 (`271365b`, 21 of 21) predate the Sanctuary migration and no longer certify the suite. The offline suite
  (`pwsh -NoProfile -File scripts/Test-Mod.ps1`, after `dotnet build Source/DrumBathHygiene.csproj -c Release`) passes.
  No `@wip`; one `@requires` (08, `pickleremoval`); no manual test left. The distributed DLL has not changed since `d7e1737`.
- **Dependencies:** `Mlie.MMDrumcanMOD` and `Dubwise.DubsBadHygiene`, both hard and declared (`modDependencies` and `loadAfter` in `About.xml`, no `LoadFolders.xml`); no Harmony, no DLC. Rechecked 2026-10-15 on `0aac039`; their Workshop pages tag 1.6 at most (read 2026-10-15), both load on 1.7.4976 (tickets `27c9`, `d108`).
- **Settings and translation:** none (`not_applicable`); the mod owns no setting and no player-facing text.
- **Thanks:** to Mlie and Dubwise posted 2026-10-02 (`../WORKSHOP_COMMENTS.md`).
- **Upstream:** PR emipa606/MMDrumcanMOD#2 declined by Mlie (2026-10-03), who links this mod in his description; closed.
- **Evidence:** on disk only, `.build/evidence/final-english-2/` and `final-french-2/` (summary, junit, log, the
  `@review` still and film), ignored by git.

## Ownership and repository

Independent repository, `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`, remote above, public. Update this file
whenever a check or a remaining item changes; record only checks actually performed.
