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
stage:        published
workflow_stage: published
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
workshop:      3806137182; 0.1.0 prepublished 2026-09-22 (item creation only), 1.0.0 sent by CI 2026-09-28, 1.0.1 2026-10-02; public per the owner
remaining:
  - published 2026-10-02 (1.0.0 and 1.0.1 on the page, item public per the owner); thanks to Mlie and Dubwise posted 2026-10-02 (WORKSHOP_COMMENTS.md). Left: the owner's manual steps of PUBLISHING.md "Mise en production d'une 1.0.0" (comment subscription, watching the mod and its parents), not confirmed.
  - open: no scenario asserts the bathroom-thought stage (Dubs Bad Hygiene's own grading of a room); adding or removing the mod on an existing save has not been played.
  - feature: fire intensity, deferred in BACKLOG.md.
  - open: upstream pull request sent 2026-10-02 (emipa606/MMDrumcanMOD/pull/2), awaiting Mlie; BACKLOG.md.
updated:      2026-10-02
---

# Drum Bath Hygiene — status

`stage: published` = `tested -> prepublished -> published` established (2026-10-02). Older audits, test runs and the
2026-09-12 preview notes were moved to `docs/runs/history.md` on 2026-10-02 (the full text stays in git).

## Current state (2026-10-02)

- **On Steam:** item `3806137182`, public per the owner. `1.0.0` sent by CI 2026-09-28 (tag `v1.0.0`, `c6a0939`); `1.0.1`
  (new preview and icon) sent 2026-10-02 (tag `v1.0.1`, `55d5928`, dry-run 37032154323, publish 37032402412).
- **Tested:** 21 scenarios of 21 green in English and French on `271365b` (runs 22 and 23). The offline suite
  (`pwsh -NoProfile -File _tools/Test-Mod.ps1`, after `dotnet build Source/DrumBathHygiene.csproj -c Release`) passes.
  No `@wip`, no `@requires:`, no manual test left. The distributed DLL has not changed since `d7e1737`.
- **Dependencies:** `Mlie.MMDrumcanMOD` and `Dubwise.DubsBadHygiene`, both hard and declared; no Harmony, no DLC.
- **Settings and translation:** none (`not_applicable`); the mod owns no setting and no player-facing text.
- **Thanks:** to Mlie and Dubwise posted 2026-10-02 (`../WORKSHOP_COMMENTS.md`).
- **Upstream:** PR emipa606/MMDrumcanMOD#2 sent 2026-10-02, awaiting Mlie (`BACKLOG.md`).
- **Evidence:** on disk only, `.build/evidence/final-english-2/` and `final-french-2/` (summary, junit, log, the
  `@review` still and film), ignored by git.

## Ownership and repository

Independent repository, `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`, remote above, public. Update this file
whenever a check or a remaining item changes; record only checks actually performed.
