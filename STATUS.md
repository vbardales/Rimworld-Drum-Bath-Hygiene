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
tested_1_7:   yes
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
  - known, accepted 2026-10-15: `Art/Preview-source.png` palette Vmean 0.184 (below 0.30, AUDIT.md 2.e), Preview already accepted and published, not reopened; `Build/` at the mod root (ignored; renamed from `.build/` 2026-11-02). 7.b reason for no unit-test project written in `TESTING.md` 2026-11-02.
  - unverified: `echo_review_sha` (keep or redo decision), `social_preview_sha256` (a custom share image exists, `og:image` checked 2026-10-10; the sha of the file sent is not recorded). `publication_changelog_review_sha` set to `93539d1` on the owner's confirmation (2026-10-10); the new save sentence in the description reopens it for the next version.
  - followUp left: 14.a non-regression ticket on the published build (DLL unchanged since `d7e1737`; `Mod/` differs from runs 22 and 23 only by the `About.xml` description), 14.c clean-up of `STATUS.md`, `TESTING.md`, `PUBLICATION.md`, 14.d branches (only `main`, nothing to delete).
  - done 2026-11-13: 1.7 pass, features 01 to 08 green on 1.7, `tested_1_7: yes`; ticket-by-ticket log in `Docs/runs/history.md` (entry 2026-11-13).
  - done: upstream pull request emipa606/MMDrumcanMOD#2 declined by Mlie 2026-10-03, who will link this mod in his description; closed, BACKLOG.md.
updated:      2026-11-13
upstream_synced: 2026-11-13 emipa606/MMDrumcanMOD@cf7d438 (Dubs Bad Hygiene: no repo, N/A)
protocols_read_sha: e4c9afffdd67faa80688c7f2aa9ad78ee01b949a
---
# Drum Bath Hygiene: status

`workflow_stage: code[1.1.0]` (version 1.1.0 opened 2026-10-13 for RimWorld 1.7 pass; was `followUp[1.0.2]`, audit 2026-10-10). Older audits, test runs, 2026-09-12 preview notes moved to `docs/runs/history.md` on 2026-10-02 (full text stays in git).

## Current state (2026-10-10)

- **On Steam:** item `3806137182`, public per owner. `1.0.2` (description: links, credits; tag `v1.0.2`, `93539d1`, dry-run 37757004462, publish 37757179159) sent 2026-10-08. `1.0.0` sent by CI 2026-09-28 (tag `v1.0.0`, `c6a0939`); `1.0.1`
  (new preview, icon) sent 2026-10-02 (tag `v1.0.1`, `55d5928`, dry-run 37032154323, publish 37032402412).
- **Tested:** non-regression 2026-10-11 on `02b3cb8` (runs 24 to 27): 19 `tools` scenarios pass in English and French, 2 gallery scenarios (`sanctuary` map) pass in both; removal chain passed 2026-10-08 (run 28cc, `536e4bf`). Runs 22 and 23 (`271365b`, 21 of 21) predate Sanctuary migration, no longer certify suite. Offline suite Audit 7 replayed 2026-10-17 on `09e41a0` (Mod/ and Source/ unchanged): `Test-Mod.ps1` green (metadata, licensing, packaging, 10 XML patch cases, compiled types), DLL SHA256 `865ACC8A...` reproduced, Pickle suites written (features 01 to 08, maps `tools`, `tools-17`, `sanctuary`, `removal`), `scripts/Test-Mod.ps1` catalogued in `scripts/LOCAL_SCRIPTS.md`, scenarios in `Tests/FUNCTIONAL-SCENARIOS.md`, translations `not_applicable`.
  `scripts/Test-Mod.ps1` removed 2026-10-26 (owner): offline checks now by shared `../scripts/Check-ModBasics.ps1` (PASS 2026-10-26), `Check-XmlFields`, `Check-TypeRefs`, `Check-DefRefs` (`-ModPath Mod`, clean 2026-10-26), `Check-XmlClasses` (`-SourceDirs Source`, 6 types resolved 2026-10-26); the patch-shape and waiver checks have no replacement, last version `git show 2d675b8:scripts/Test-Mod.ps1`; scripts/LOCAL_SCRIPTS.md row dropped; docs rewritten in the same commit.
  No `@wip`; one `@requires` (08, `pickleremoval`); no manual test left. Distributed DLL unchanged since `d7e1737`.
- **Dependencies:** `Mlie.MMDrumcanMOD` and `Dubwise.DubsBadHygiene`, both hard and declared (`modDependencies` and `loadAfter` in `About.xml`, no `LoadFolders.xml`); no Harmony, no DLC. Rechecked 2026-10-15 on `0aac039`; Workshop pages tag 1.6 at most (read 2026-10-15), both load on 1.7.4976 (tickets `27c9`, `d108`). Audit 4.a to 4.g replayed 2026-10-17 on `09e41a0`: sources use no Harmony and no DLC; DBH reached only by reflection (`DbhBridge`, inert if absent), drum bath only by XML guarded on `Hed_BathingAtDrumBathPassive` (`PatchOperationConditional`, quiet without it); both stay hard because the mod does nothing without both (stated in the description); `loadAfter` only, no cycle possible, no `incompatibleWith`; not an animal mod (4.f n/a); `sort-load-order.py` not run (no python on this machine).
- **Settings and translation:** none (`not_applicable`); mod owns no setting, no player-facing text. Audit 5 and 6 replayed 2026-10-17 on `09e41a0`: `Mod/` ships only `About/`, `Assemblies/`, `Patches/AddComp.xml`, no `Languages/`; `Source/` holds 3 classes (`AccessChecks`, `DbhBridge`, `HediffComp_DrumBathHygiene`), no `Mod` or `ModSettings` subclass, no `Translate()`, no `Messages`/`Letters` text; the two tuning values (`cleanPerTick`, `privacyCheckInterval`) are fixed in the patch, no player-facing option wanted (5.b); no empty settings page, no MainButtons shortcut; `FRENCH_REVIEW.md` present.
- **Thanks:** to Mlie and Dubwise posted 2026-10-02 (`../WORKSHOP_COMMENTS.md`).
- **1.7 pass:** features 01 to 08 all played green on 1.7 (last: `4f90` 07, `21c4` 08, 2026-11-13; evidence `Tests/Pickle/Evidence/p17-dbh-07-captures-2`, `p17-dbh-08-removal-2`, `p17-dbh-waits-3`, `p17-dbh-06-seventh`). Scenario fixes: pawn spawned 3 cells from drum, `@timeout:60` plus chunked waits (02, 03, 06, 08). Full ticket log in `Docs/runs/history.md`. `tested_1_7: yes` decided by the owner 2026-11-13; `<li>1.7</li>` not yet in `supportedVersions` (later publication gesture, with the Preview redo).
- **1.7 pass, results read 2026-11-13:** `4f90` GREEN (07 Sanctuary gallery, 2 of 2, azure lane, `0dd5d16`, SaB Build17 `7725fe2`; scenarios "burning drum on the west bank" 328 s and "Needs tab" 422 s; the water-garden place step now passes with the 400 s timeout; minified in `Evidence/p17-dbh-07-captures-2`, two captures only seen as proof of the run, gallery captures stay for `shootGallery`). `21c4` GREEN (08 removal chain, 1 of 1 each: seq1 "save mid-bath, hand over" 187 s, seq2 "the save loads and runs without the mod" 73 s; minified in `Evidence/p17-dbh-08-removal-2`). Features 01 to 08 are now all played green on 1.7; Inbox empty. `tested_1_7: yes` decided by the owner 2026-11-13 ("go"); `<li>1.7</li>` not added to `supportedVersions` yet (later publication gesture, with the Preview redo). Protocols read at `72a7e40` 2026-11-13 (AGENTS: Inbox check before waiting, REPLAY via TM, stale PR rule; AUDIT 8.0 ecosystem refresh at start of `playTests`, applies to `alive` sources only, not done here).
- **Translation review, 2026-11-13:** ChatGPT page 1 of 1, 4 English proposals on the mod's own texts: 3 applied (PUBLICATION.md note "were posted", Dubwise sentence comma to semicolon also in `Mod/About/About.xml`, README.md stray space), 1 rejected (AI-GENERATED "its images generated": elliptical "was" is correct, keep). No upstream PR: the fixes concern our own PUBLICATION and README, not text of MMDrumcanMOD. No proper noun to decide. The `About.xml` change reopens `code_review_sha` for the next version.
- **Ecosystem (PiI, 2026-11-13, protocols `3975801`, `docs/inventory/ecosystem-steam/DrumBathHygiene.md`):** no duplicate by title; patch-only mod, so no defName scan. Dependencies alive on 1.6: MMDrumcanMOD (Continued) 3417093756 (original 2100895553 dead since 2021), Dubs Bad Hygiene 836308268. Dubs neighbours to test for load order: Dubs Bad Hygiene Lite 2570319432, Dubs Thirst 2582878800, Spring Water Patch 3531641684. Nothing subscribed.
- **Upstream:** PR emipa606/MMDrumcanMOD#2 declined by Mlie (2026-10-03), who links this mod in his description; closed.
- **Evidence:** on disk only, `Tests/Pickle/Evidence/` (minified, each with `RELEASE.md`): `final-french-2/`, `p17-dbh-01-replay3/`, `p17-dbh-02-06-b/`; ignored by git. Inbox sorted 2026-10-19, reds and unjudged runs deleted.

## Ownership and repository

Independent repository, `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`, remote above, public. Update file whenever check or remaining item changes; record only checks actually performed.