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
workflow_stage: playTests[1.1.0]
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
  - idea: fire intensity, deferred in BACKLOG.md (not part of 1.1.0).
  - audit 2026-10-10: state written `followUp[1.0.2]` (old `published`); protocols read at `b4bb8a9` (AUDIT, AGENTS, PUBLISHING, WELCOME read; TRANSLATIONS, MOD_SETTINGS, SEARCHING, STYLE_RIMWORLD, PICKLE not reread, per `docs/PROTOCOLS-READ.md`).
  - defect (audit 2026-10-10, partly fixed): the save sentence said removal from a save was untested; played 2026-10-08 (run 28cc). Fixed in `PUBLICATION.md` (Steam description source) and `README.md`; `Mod/About/About.xml` (generated from that block, `sync-about-description.mjs --write`) and the Steam page still carry the old sentence until the next version, not shipped on 2026-10-10 (owner). A `Mod/` change reopens `code_review_sha` and the `x.y` review of the description.
  - checked 2026-10-17: no em dash (U+2014) left in README.md, PUBLICATION.md, TESTING.md, Tests/, Source/ (line scan); Mod/About/About.xml and the Steam description not scanned by hand (Check-Status flags them, no warning 2026-10-17); CHANGELOG.md append-only.
  - known, accepted 2026-10-15: `Art/Preview-source.png` palette Vmean 0.184 (below 0.30, AUDIT.md 2.e), Preview already accepted and published, not reopened; `.build/` at the mod root (ignored, holds evidence).
  - unverified: `echo_review_sha` (keep or redo decision), `social_preview_sha256` (a custom share image exists, `og:image` checked 2026-10-10; the sha of the file sent is not recorded). `publication_changelog_review_sha` set to `93539d1` on the owner's confirmation (2026-10-10); the new save sentence in the description reopens it for the next version.
  - followUp left: 14.a non-regression ticket on the published build (DLL unchanged since `d7e1737`; `Mod/` differs from runs 22 and 23 only by the `About.xml` description), 14.c clean-up of `STATUS.md`, `TESTING.md`, `PUBLICATION.md`, 14.d branches (only `main`, nothing to delete).
  - open (1.7 pass, 2026-10-13 to 15, tickets 27c9, 2722, d108, 9910 done): `tested_1_7` not decided. Feature 01: 6 of 6 pass on 1.7 (4 in `d108`, last 2 in replay `9910`, 2 of 2 green, evidence `p17-dbh-01-replay3`, digested 2026-10-17). Features 02 to 06: ticket `f485` filed 2026-10-17 on `09e41a0` (`wsl-deps.tools-17.map`, evidence `p17-dbh-02-06`), waiting in queue; 07 needs a 1.7 Sanctuary Backlot.
  - done: upstream pull request emipa606/MMDrumcanMOD#2 declined by Mlie 2026-10-03, who will link this mod in his description; closed, BACKLOG.md.
updated:      2026-10-17
protocols_read_sha: 6ccbec78fcd0a68c950b820dccaf062038bfff8a
---
# Drum Bath Hygiene: status

`workflow_stage: code[1.1.0]` (version 1.1.0 opened 2026-10-13 for RimWorld 1.7 pass; was `followUp[1.0.2]`, audit 2026-10-10). Older audits, test runs, 2026-09-12 preview notes moved to `docs/runs/history.md` on 2026-10-02 (full text stays in git).

## Current state (2026-10-10)

- **On Steam:** item `3806137182`, public per owner. `1.0.2` (description: links, credits; tag `v1.0.2`, `93539d1`, dry-run 37757004462, publish 37757179159) sent 2026-10-08. `1.0.0` sent by CI 2026-09-28 (tag `v1.0.0`, `c6a0939`); `1.0.1`
  (new preview, icon) sent 2026-10-02 (tag `v1.0.1`, `55d5928`, dry-run 37032154323, publish 37032402412).
- **Tested:** non-regression 2026-10-11 on `02b3cb8` (runs 24 to 27): 19 `tools` scenarios pass in English and French, 2 gallery scenarios (`sanctuary` map) pass in both; removal chain passed 2026-10-08 (run 28cc, `536e4bf`). Runs 22 and 23 (`271365b`, 21 of 21) predate Sanctuary migration, no longer certify suite. Offline suite Audit 7 replayed 2026-10-17 on `09e41a0` (Mod/ and Source/ unchanged): `Test-Mod.ps1` green (metadata, licensing, packaging, 10 XML patch cases, compiled types), DLL SHA256 `865ACC8A...` reproduced, Pickle suites written (features 01 to 08, maps `tools`, `tools-17`, `sanctuary`, `removal`), `scripts/Test-Mod.ps1` catalogued in `scripts/LOCAL_SCRIPTS.md`, scenarios in `Tests/FUNCTIONAL-SCENARIOS.md`, translations `not_applicable`.
  (`pwsh -NoProfile -File scripts/Test-Mod.ps1`, after `dotnet build Source/DrumBathHygiene.csproj -c Release`) passes.
  No `@wip`; one `@requires` (08, `pickleremoval`); no manual test left. Distributed DLL unchanged since `d7e1737`.
- **Dependencies:** `Mlie.MMDrumcanMOD` and `Dubwise.DubsBadHygiene`, both hard and declared (`modDependencies` and `loadAfter` in `About.xml`, no `LoadFolders.xml`); no Harmony, no DLC. Rechecked 2026-10-15 on `0aac039`; Workshop pages tag 1.6 at most (read 2026-10-15), both load on 1.7.4976 (tickets `27c9`, `d108`). Audit 4.a to 4.g replayed 2026-10-17 on `09e41a0`: sources use no Harmony and no DLC; DBH reached only by reflection (`DbhBridge`, inert if absent), drum bath only by XML guarded on `Hed_BathingAtDrumBathPassive` (`PatchOperationConditional`, quiet without it); both stay hard because the mod does nothing without both (stated in the description); `loadAfter` only, no cycle possible, no `incompatibleWith`; not an animal mod (4.f n/a); `sort-load-order.py` not run (no python on this machine).
- **Settings and translation:** none (`not_applicable`); mod owns no setting, no player-facing text. Audit 5 and 6 replayed 2026-10-17 on `09e41a0`: `Mod/` ships only `About/`, `Assemblies/`, `Patches/AddComp.xml`, no `Languages/`; `Source/` holds 3 classes (`AccessChecks`, `DbhBridge`, `HediffComp_DrumBathHygiene`), no `Mod` or `ModSettings` subclass, no `Translate()`, no `Messages`/`Letters` text; the two tuning values (`cleanPerTick`, `privacyCheckInterval`) are fixed in the patch, no player-facing option wanted (5.b); no empty settings page, no MainButtons shortcut; `FRENCH_REVIEW.md` present.
- **Thanks:** to Mlie and Dubwise posted 2026-10-02 (`../WORKSHOP_COMMENTS.md`).
- **Upstream:** PR emipa606/MMDrumcanMOD#2 declined by Mlie (2026-10-03), who links this mod in his description; closed.
- **Evidence:** on disk only, `.build/evidence/final-english-2/` and `final-french-2/` (summary, junit, log, `@review` still and film), ignored by git.

## Ownership and repository

Independent repository, `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`, remote above, public. Update file whenever check or remaining item changes; record only checks actually performed.