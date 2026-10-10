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
workflow_stage: published
code_review_sha: 93539d13a9cb9e959f469956614114f2edb59b3c
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
tested_on:    Pickle suite in game (RimWorld 1.6, Linux under WSL, Xvfb), English (run 22) and French (run 23), 2026-09-28: 21 scenarios of 21 played and green in each, exitReason passed, from revision 271365b (runs 8 and 9, 2026-09-23, revision 9df3305, were the 19-scenario passes before the Workshop images); earlier: Release rebuild and the Windows PowerShell XML/packaging suite, 2026-09-22
workshop:      3806137182; 0.1.0 prepublished 2026-09-22 (item creation only), 1.0.0 sent by CI 2026-09-28,  1.0.1 2026-10-02, 1.0.2 2026-10-08 (description); public per the owner
remaining:
  - published 2026-10-02 (1.0.0 and 1.0.1 on the page, item public per the owner); thanks to Mlie and Dubwise posted 2026-10-02 (WORKSHOP_COMMENTS.md). Owner's manual steps of PUBLISHING.md "Mise en production d'une 1.0.0" (visibility, comment subscription, watching the mod and its parents MMDrumcanMOD and Dubs Bad Hygiene) confirmed done by the owner 2026-10-08.
  - open (BACKLOG.md "Tests still to write"): no scenario asserts the bathroom-thought stage (Dubs Bad Hygiene's own grading of a room); removing the mod from a save was played 2026-10-08 (run 28cc, green, `536e4bf`); adding it to a save made without it is not played as its own case.
  - feature: fire intensity, deferred in BACKLOG.md.
  - audit 2026-10-10, state to write: `followUp[1.0.2]` (old `published`). Not written yet: `Mark-ProtocolsRead.ps1` refuses while `WORKSHOP_COMMENTS.md` (protocols repository, another session's change) is uncommitted.
  - defect (audit 2026-10-10): the Steam description (`## Steam description` of `PUBLICATION.md`, `Mod/About/About.xml`) and `README.md` still say removing the mod from a save is untested; it was played 2026-10-08 (run 28cc). Fixing the description is a change to `Mod/` and a new version.
  - defect (audit 2026-10-10): em dashes (U+2014) in `Mod/About/About.xml` and in the Steam description (THANKS, Dubwise line), also in `README.md`, `PUBLICATION.md`, `TESTING.md`, `Tests/` and `Source/` comments (rule of 2026-10-10; `CHANGELOG.md` is append-only).
  - unverified: `publication_changelog_review_sha` (needs the owner's confirmation in chat; `93539d1` was her wording pass), `echo_review_sha` (keep or redo decision), `social_preview_sha256` (a custom share image exists, `og:image` checked 2026-10-10; the sha of the file sent is not recorded).
  - followUp left: 14.a non-regression ticket on the published build (DLL unchanged since `d7e1737`; `Mod/` differs from runs 22 and 23 only by the `About.xml` description), 14.c clean-up of `STATUS.md`, `TESTING.md`, `PUBLICATION.md`, 14.d branches (only `main`, nothing to delete).
  - done: upstream pull request emipa606/MMDrumcanMOD#2 declined by Mlie 2026-10-03, who will link this mod in his description; closed, BACKLOG.md.
updated:      2026-10-10
---

# Drum Bath Hygiene — status

`stage: published` = `tested -> prepublished -> published` established (2026-10-02). Older audits, test runs and the
2026-09-12 preview notes were moved to `docs/runs/history.md` on 2026-10-02 (the full text stays in git).

## Current state (2026-10-02)

- **On Steam:** item `3806137182`, public per the owner. `1.0.2` (description: links, credits; tag `v1.0.2`, `93539d1`, dry-run 37757004462, publish 37757179159) sent 2026-10-08. `1.0.0` sent by CI 2026-09-28 (tag `v1.0.0`, `c6a0939`); `1.0.1`
  (new preview and icon) sent 2026-10-02 (tag `v1.0.1`, `55d5928`, dry-run 37032154323, publish 37032402412).
- **Tested:** 21 scenarios of 21 green in English and French on `271365b` (runs 22 and 23). The offline suite
  (`pwsh -NoProfile -File scripts/Test-Mod.ps1`, after `dotnet build Source/DrumBathHygiene.csproj -c Release`) passes.
  No `@wip`, no `@requires:`, no manual test left. The distributed DLL has not changed since `d7e1737`.
- **Dependencies:** `Mlie.MMDrumcanMOD` and `Dubwise.DubsBadHygiene`, both hard and declared; no Harmony, no DLC.
- **Settings and translation:** none (`not_applicable`); the mod owns no setting and no player-facing text.
- **Thanks:** to Mlie and Dubwise posted 2026-10-02 (`../WORKSHOP_COMMENTS.md`).
- **Upstream:** PR emipa606/MMDrumcanMOD#2 declined by Mlie (2026-10-03), who links this mod in his description; closed.
- **Evidence:** on disk only, `.build/evidence/final-english-2/` and `final-french-2/` (summary, junit, log, the
  `@review` still and film), ignored by git.

## Ownership and repository

Independent repository, `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`, remote above, public. Update this file
whenever a check or a remaining item changes; record only checks actually performed.


## Preview source migration — 2026-10-02

Copy, typography, layout and palette are consolidated in `Art/Preview.config.json`. The canonical inputs are `Art/Preview-source.png`, `Art/echo.png` and `Art/ModIcon-source.png`; the shared renderer writes temporary diagnostics under ignored `Art/.render/`. Existing distributed Preview, gallery and ICO outputs were preserved because they were present and coherent; no render was run for this migration. Superseded JSON files and generated QA intermediates were removed. Nothing published.
