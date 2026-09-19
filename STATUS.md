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
stage:        done
settings_audit: not_applicable
build_audit: complete
automated_tests: complete
xml_tests: complete
functional_scenarios: complete
in_game_tests: unchecked
audit_revision: 5758baa7c07581f7db27726ffbe1a5add0c8720d
licence:      open
license_spdx: MIT
licence_at:   LICENSE and Mod/LICENSE; original integration code, third-party dependencies credited in ATTRIBUTION.md
owner:        Codex, task attached to this local repository
dependencies: declared
showcase:     preview approved by user; visual QA passed at full size and thumbnail; not verified in game
tested_on:    Release rebuild and automated/XML checks on Windows, 2026-09-13; no in-game validation recorded
workshop:
remaining:
  - unverified: execute final validation on a new colony and an existing save, recording dependency versions, per-scenario results and Player.log; no game session was run in this audit.
  - unverified: English and French in-game integration display checks described in _tools/FUNCTIONAL-SCENARIOS.md; dependency translations have not been certified by this audit.
  - unverified: manual scenarios 0 through 12, including startup, hygiene, thoughts, privacy, filth, missing dependencies and saves.
  - unverified: live compatibility of reflection calls with the installed dependency versions; historical inspection is not a current automated integration test.
  - unverified: cold water on arrival and removal of the mod from a mid-bath save.
  - feature: fire intensity, deferred in BACKLOG.md.
updated:      2026-09-13
---

# Drum Bath Hygiene — status

## Workflow audit — 2026-09-13

Follow-up documentation corrections, 2026-09-13, on the same base revision: corrected
About.xml and CHANGELOG.md to describe the temporary bath state and leave save compatibility
explicitly unverified; aligned README.md with that limitation. Corrected the changelog's
hygiene direction and both attribution copies' SoakingWet entry timing. Replaced the
scenario introduction's unconditional failure attribution with a dependency-version check.
The documentation defects listed later in this dated audit are now resolved. Existing audit
edits were preserved. The audit-only change description below records the earlier audit,
not this follow-up. No gameplay code, patch behavior or images changed; `done` and the
justified settings/localization exclusions remain valid. The automated/XML suite was rerun
successfully after these edits; attribution copies match and `git diff --check` passes.
In-game checks remain pending. Optional repository housekeeping remains a recommendation.

Audited revision: `5758baa7c07581f7db27726ffbe1a5add0c8720d`. The working tree was
clean before the audit. Only this STATUS.md is changed by the audit; the forced Release
rebuild reproduced the shipped DLL byte for byte. No source, XML, image, scenario or
historical result was changed; nothing was committed or published.

Applied `../PUBLISHING.md`, `../STYLE_RIMWORLD.md`, `../MOD_SETTINGS.md` and
`../TRANSLATIONS.md`, with the user's ordered workflow and interpretation taking precedence.
The previous `validation` value was a legacy label, not evidence of any particular gate.
The new `stage: done` uses the workflow's literal state: all gates through `preTest -> done`
are established, ready for final in-game validation, **not** `tested`.

| Transition | Result | Current evidence |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Independent Git top level and `.git`, no superproject; configured GitHub origin; live public repository and remote HEAD equal audited revision. English README, attribution, MIT license and changelog exist; distributed license and attribution match root copies. Original bridge code, no bundled dependency/game code; public/open classification remains justified. Package ID, display name, repository and directory consistently identify this integration; no continuation/private suffix applies. |
| horsMonoRepo -> ModIcon generated | Validated | Current scoped implementation complete; fire intensity is explicitly deferred, not unfinished promised functionality. Forced Release rebuild passes and matches shipped DLL. Directly inspected PNG icon: 128 x 128, 22,318 bytes, mascot and bathing objects recognizable. |
| ModIcon generated -> Preview generated | Validated | Directly inspected delivered PNG: 896 x 504, 518,417 bytes, below 1 MB. Original and composition files preserved in Art/. No concrete camera defect identified; no historical generation report or recorded game-camera comparison required. |
| Preview generated -> preOptions | Validated | Inspected full-size preview and existing 268-pixel thumbnail; title/version readable, no clipping, subject identifiable. Cool turquoise accent separates from warm ochre secondary ink in the palette; HTML consumes that JSON. English description and title; no prefix, suffix or linking word requires reduction. |
| preOptions -> options | Justified not applicable | Settings inventory below: no relevant user settings, empty page or MainButtons shortcut. In-game checks are not required for this gate under the user's interpretation. |
| options -> l10n | Justified not applicable | Re-read all three C# files and shipped XML: no owned UI text or translatable Def fields introduced/overridden. All three translation fields remain not_applicable. |
| l10n -> preTest | Validated | Installed dependency About files match both declared IDs and support 1.6; both are loaded before this integration. Actual upstream root Defs contain DrumBath and Hed_BathingAtDrumBathPassive. No own LoadFolders or additional version/optional patches. Both mods are required for useful behavior; graceful absence handling does not make their dependency declarations incorrect. |
| preTest -> done | Validated | Existing thirteen functional scenarios have setup, actions and expected outcomes. Existing automated metadata/packaging tests and ten XML patch cases executed successfully against the identical shipped DLL and XML. |
| done -> tested | Unverified | No gameplay execution, bilingual UI inspection, session log validation or new/existing-save runtime result produced. Settings UI, persistence and shortcut checks are not applicable; bath-state save/reload remains required. |

### Settings audit

Reviewed all of Source/ and Mod/, including component properties, bridge calls and both
XML branches. `cleanPerTick = 0.0005` is the internal integration rate (2000 ticks to fill
an empty gauge); `privacyCheckInterval = 300` is an internal polling cadence. These are
fixed compatibility defaults, not a documented player configuration contract. No concrete
need to expose the polling interval or introduce a separate balancing interface was found.
Water temperature, room and privacy effects delegate to dependency behavior. There is no
inherited settings class, config file, settings window or MainButtonDef in this package.
The only saved values are per-bath `started` and `ticks`, not user settings. Searches for
ModSettings, SettingsCategory, DoSettingsWindowContents, MainButton and MainTabWindow,
plus full source/XML reading, confirm absence of an empty page and shortcut.
Therefore `settings_audit: not_applicable`; no RIMMSQOL or other customization integration
was tested or is claimed. Option input/reset/migration and option persistence tests have
no target. The shipped XML defaults are checked by the executed XML suite.

### Executed checks and limits

- `git rev-parse --show-toplevel --git-dir --show-superproject-working-tree`,
  `git status --short`, `git remote -v`, `git log -1`: independent repository at the
  recorded folder; clean starting tree. No requirement to restore a monorepo remote.
- `gh repo view vbardales/Rimworld-Drum-Bath-Hygiene --json name,visibility,url` and
  `git ls-remote origin HEAD`: PUBLIC, correct URL, remote HEAD equals audited revision.
- `dotnet build Source/DrumBathHygiene.csproj -c Release --no-restore -t:Rebuild`:
  passed, zero warnings/errors, cached Krafs.Rimworld.Ref 1.6.4871 and Publicizer 2.3.2.
  Initial sandbox attempts could not access GitHub/SDK paths; the authorized retry succeeded.
  These initial environment errors are not mod build defects.
- DLL SHA256 before and after rebuild:
  `865ACC8A92D27700C182C48F6BE82346F43EA73D4A644B68D9A486E57F017003`.
- `pwsh -NoProfile -File _tools/Test-Mod.ps1`: passed before and after the successful
  rebuild. Ten XML cases, metadata/licensing/packaging, component types and access waiver.
  The XML interpreter is not the game patch engine; metadata tests do not execute gameplay.
  No isolated gameplay harness exists. Pawn/map/DBH runtime behavior is assigned to the
  written game scenarios, not falsely reported as automated coverage or non-applicable.
- Direct image inspection and System.Drawing decoding established PNG formats/dimensions;
  file sizes checked from disk. Historical contrast/font measurements remain historical;
  they were not rerun, and no visual issue was identified requiring a new render.
- Installed dependency metadata read under
  `C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/`:
  `3417093756` (MMDrumcanMOD, root Defs plus 1.6 assembly) and `836308268`
  (DBH modVersion 3.1.2800, 1.6 assembly). Both About IDs match the shipped declarations;
  neither has a LoadFolders.xml. MMDrumcanMOD declares its own Harmony dependency;
  this bridge does not directly use Harmony and need not duplicate that transitive dependency.
  No unestablished minimum dependency version is invented.
- Current dependency DLL SHA256: DrumBath.dll
  `EAF75AE3DFE08285F0018D275E9858D290EB599BF7F2F780CA0E3A70CF399D8F`;
  BadHygiene.dll `511A4EC97D04C232F09E3F1E7EFDE20C44B66B52563E03FB4359E3823AAAB597`.
  Runtime reflection compatibility is still unverified; the historical reflection check
  is not a current integration test.
- Localization tracing confirms zero owned Keyed keys, DefInjected paths or parameterized
  messages. Technical logs/internal names are excluded. Native dependency text is neither
  copied nor explicitly translated here; no redundant EN/FR resources or path checker needed.

### Remaining gate and separate findings

To reach `tested`, execute scenarios 0-12 and the English/French language display check
in `_tools/FUNCTIONAL-SCENARIOS.md`, explicitly covering a new colony and an existing save.
Record game/dependency versions, observed outcomes, hygiene values and Player.log. Include
cold arrival, mid-bath reload/removal and missing dependencies; fix any failures actually
observed and rerun affected regressions. The installed files do not substitute for an
interactive game session. No gameplay failure is established by this audit.

Separate documentation defects, not failures of the next runtime gate: About.xml says
no save data of its own and CHANGELOG.md says no data is added to the save, whereas
CompExposeData writes two values. CHANGELOG.md says the rate empties a full gauge instead
of filling an empty one. Both attribution copies place SoakingWet removal on exit,
whereas OnEnterBath invokes it on entry. Historical scenario prose saying a future failure
cannot be a renamed member is too absolute; dependency signatures were not rechecked here.
These statements should be corrected before publication; no gameplay correction is inferred.

Optional repository housekeeping: the autonomous repository lacks the suggested
`.gitattributes` and IDE ignore patterns. No damaged artifact or tracked IDE file was found;
these are not promoted to extra mandatory workflow gates. Fire intensity remains optional
backlog work. The historical sections below are preserved as dated evidence, superseded
by this audit where they describe the old stage or old execution date.

## Ownership and repository

Codex now maintains this file as part of work on this repository. Update it whenever changes,
checks or remaining issues change; only record checks actually performed. This responsibility
applies to this local task, without an automatic background schedule.

The Git top level is `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`. Its Git directory is
`.git`, and Git reports no superproject. This is an independent local repository, outside the
former monorepo. Both fetch and push use the remote above. GitHub visibility was verified as
`PUBLIC` using `gh repo view` on 2026-09-12.

## Title, description and license

`visibility` describes the mod's intended distribution, not GitHub repository visibility.
This mod is intended for public distribution: it is an original MIT-licensed integration,
with no copied dependency source files reported in ATTRIBUTION.md. This decision is independent
of the repository being public, recorded separately as `repo_visibility`.
No Workshop ID is recorded locally; current Steam visibility has not been verified.
Public distribution remains pending in-game validation.

Rules rechecked in `../PUBLISHING.md` (License section, 2026-09-12): `alive` requires a private
mod and `(prohibited)`; any private mod requires `(prohibited)` and the personal-use notice;
a public `silent` mod requires `(unofficial)` and the unofficial notice. Neither case applies
to this original MIT integration. A dependency being maintained does not itself make this
independently written bridge an `alive` reuse of unlicensed source content.

Keep **Drum Bath Hygiene** without a suffix. This repository implements an original compatibility
bridge, not a continuation or republication of MMDrumcanMOD. The dependency retains its own
name, **MMDrumcanMOD (Continued)**. No evidence in this repository calls for a title suffix.

`Mod/About/About.xml` contains the GitHub URL both in `<url>` and, since this audit, in the
visible `<description>` as its final Steam-formatted source link, as required by
`../PUBLISHING.md`. The package ID stays `nelim.drumbathhygiene`.

The actual license is **MIT**, copyright 2026 Nelim. `LICENSE` and the distributed `Mod/LICENSE`
are identical. The status category is `open`; `original` describes provenance, not the license
name. The previous claim that this mod owed no names or ideas to another mod was too broad.

Justification for retaining MIT: the repository documents independently written integration
code and distributes no copied source files from the two dependency mods. It references their
identifiers and calls DBH methods; both dependencies are credited in `ATTRIBUTION.md`. MIT is
consistent with the author's stated permission to reuse and continue this code with attribution.
It does not relicense RimWorld, MMDrumcanMOD or Dubs Bad Hygiene. Preview/icon generation is
credited separately in the attribution file. This audit retains the existing license.

## Translation audit — 2026-09-13

Applied `../PUBLISHING.md` and `../TRANSLATIONS.md` to revision
`b9d23a8b1594cd55191271dd6153be667217fccc` (source and shipped XML unchanged).
All three translation fields are `not_applicable`: the inventory found no owned
player-facing text added or changed by this integration.

- Reviewed all three C# files in `Source/`, the project/build configuration, and every
  file under `Mod/`. There are no alternate version folders, LoadFolders, language
  resources, settings, gizmos, menus, messages, inspect strings or generated sentences.
- Traced `HediffComp_DrumBathHygiene` through `DbhBridge`: it updates the existing hygiene
  need and delegates temperature, bathroom and privacy effects to DBH. The existing
  need, thoughts and drum-bath hediff retain their dependency-owned texts. No dependency
  translation keys are explicitly resolved, copied or overridden here.
- Reviewed both branches of `Mod/Patches/AddComp.xml`: they only set `hediffClass` and
  add the component with numeric tuning values. No label, description or other
  translatable field is added or replaced.
- The five logging call sites in `DbhBridge.cs` are technical diagnostics and remain
  English. Reflection names, defNames and the save keys `started`/`ticks` are internal
  identifiers. About metadata, documentation, licences and promotional image text are
  outside the in-game translation gate under the shared protocol.

Inventory commands: `rg --files --hidden -g '!.git'`,
`Get-ChildItem Mod -Recurse -File`, and
`rg -n 'Translate|label|description|Message|Log\.' Source Mod`, followed by full source
and XML review and tracing of the delegated calls. Owned Keyed keys: 0; owned
DefInjected paths: 0; owned grammar/string resources: 0. Parameter, duplicate-key and
injection-path checks therefore have no targets; `Check-DefInjected.ps1` is not applicable.
No empty language folders or duplicate dependency translations are needed.

This passes the translation gate by justified non-applicability, without changing the
historical `validation` stage. It does not certify the installed dependencies' English
or French coverage. Their visible integration effects still require the bilingual
in-game check recorded in `remaining`. No in-game language tests were run. Repeat this
inventory after source, Def, patch or text changes; reset affected fields to `unchecked`
until reviewed again.

## Reproducible automated checks

Run from this repository with .NET SDK and PowerShell 7:

```powershell
dotnet build Source/DrumBathHygiene.csproj -c Release
pwsh -NoProfile -File _tools/Test-Mod.ps1
```

Audit results on 2026-09-12:

- Release build with `--no-restore`: passed, zero warnings and errors, using the existing NuGet cache.
- All shipped XML files parse successfully; title, package ID, source link, dependency load order,
  matching license copies and exclusion of `Assembly-CSharp.dll` from the mod package pass.
- Ten XML patch cases pass: missing target def, plus all nine combinations of absent/plain/comp-capable
  hediff class and absent/empty/populated comps. Checks cover the final class, a single comps
  container, a single added component, tuning values, and preservation of existing content.
- Compiled DLL metadata checks pass: both component types exist and the assembly actually carries
  `IgnoresAccessChecksTo("Assembly-CSharp")`, needed for access to carried filth.

The XML suite applies the real patch XPath and payload through a small test interpreter. It is
not the RimWorld patch engine. Compilation and metadata checks do not execute the C# gameplay
or DBH reflection calls. Automated gameplay integration coverage remains absent; manual checks
below are required before claiming the mod works in game. No test project or reproducible
script was present before this audit; `_tools/Test-Mod.ps1` now provides the checks above.

## Manual functional validation

The thirteen scenarios in `_tools/FUNCTIONAL-SCENARIOS.md` exist and specify setup, actions and
expected outcomes. They cover startup and patch loading, hygiene progression/clamping, hot/cold
water, room thoughts, privacy, soaking-wet removal, carried filth, save/reload, successive baths,
missing dependencies, and adding/removing the mod from a save.

**Execution status: not run in this audit; no recorded in-game results.** Start with scenario 0,
then complete 1–12. Record game and dependency versions, pass/fail per scenario, hygiene values
for scenario 1 and the session Player.log. A prior reflection inspection is documented in the
scenario file, but its conclusions must be rechecked if dependency versions change.

Do not mark the mod ready for Workshop based solely on a successful build. No new Workshop
publication was performed. Fire intensity remains a deferred feature in `BACKLOG.md`.

## Preview overlay — 2026-09-12

Recomposed according to `../STYLE_RIMWORLD.md`. Retained the original illustration from
`Art/Preview-source.png` and copied it unchanged to canonical source `Art/Preview.png`.
No illustration was replaced; the existing full-resolution original remains preserved.
The title and summary were preserved exactly. No status tag or reduced title words apply.
The user approved the final preview and requested commit and push of this audit and its assets.

- Delivered image: `Mod/About/Preview.png`, 896 × 504, 518,417 bytes (under 900 KB).
- Composition and layout parameters: `Art/preview.html`; renderer: `Art/render-preview.cjs`.
- Single color reference: `Art/preview-palette.json`, loaded directly by the HTML.
- QA artifacts: `Art/preview-qa.json`, `Art/preview-background.png` (text hidden),
  and `Art/preview-268.png` (thumbnail).

The veil comes from the broad dark stone floor. The secondary ink is a lightened warm ochre
from the dominant stone/metal material family. The accent comes from the blue-green bath water,
with saturation and brightness increased: its cool turquoise clearly separates from the warm
stone family instead of repeating the orange lantern/fire. No secondary-colored text is needed
for this title, but its palette value is retained for future use.

Chrome rendered directly at final resolution after `document.fonts.ready` and source-image load.
Actual platform fonts were checked through Chrome DevTools: Segoe UI Semibold for the title,
Segoe UI regular for the summary, and Segoe UI Bold for the badge; no fallback was used.
The badge reads the highest stable version declared in the shipped About.xml: currently 1.6.

Contrast was measured against the text-hidden rendered PNG across every pixel of the full title
and summary rectangles, not merely their corners: minimum 11.04:1 for title and 5.96:1 for summary.
Badge contrast is 10.51:1. Tag contrast is not applicable because no tag is displayed.
Visual inspection at 896 × 504 and 268 px wide confirmed identifiable title/version, a visible
rule, no clipped glyphs or overlaps, and the bath remaining recognizable. The summary is intended
for the full-size image, as specified by the guide. Nothing was published.
