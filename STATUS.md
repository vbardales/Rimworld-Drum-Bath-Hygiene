---
mod:          Drum Bath Hygiene
packageId:    nelim.drumbathhygiene
repo:         Rimworld-Drum-Bath-Hygiene
remote:       https://github.com/vbardales/Rimworld-Drum-Bath-Hygiene.git
folder:       C:/Users/nelim/Documents/rimworld/DrumBathHygiene
visibility:   public
repo_visibility: public
detached:     yes
stage:        validation
licence:      open
license_spdx: MIT
licence_at:   LICENSE and Mod/LICENSE; original integration code, third-party dependencies credited in ATTRIBUTION.md
owner:        Codex, task attached to this local repository
dependencies: declared
showcase:     preview approved by user; visual QA passed at full size and thumbnail; not verified in game
tested_on:    automated checks on Windows, 2026-09-12; no in-game validation recorded
workshop:
remaining:
  - unverified: manual scenarios 0 through 12, including startup, hygiene, thoughts, privacy, filth, missing dependencies and saves.
  - unverified: live compatibility of reflection calls with the installed dependency versions; historical inspection is not a current automated integration test.
  - unverified: cold water on arrival and removal of the mod from a mid-bath save.
  - feature: fire intensity, deferred in BACKLOG.md.
updated:      2026-09-12
---

# Drum Bath Hygiene — status

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

The actual license is **MIT**, copyright 2026 nelim. `LICENSE` and the distributed `Mod/LICENSE`
are identical. The status category is `open`; `original` describes provenance, not the license
name. The previous claim that this mod owed no names or ideas to another mod was too broad.

Justification for retaining MIT: the repository documents independently written integration
code and distributes no copied source files from the two dependency mods. It references their
identifiers and calls DBH methods; both dependencies are credited in `ATTRIBUTION.md`. MIT is
consistent with the author's stated permission to reuse and continue this code with attribution.
It does not relicense RimWorld, MMDrumcanMOD or Dubs Bad Hygiene. Preview/icon generation is
credited separately in the attribution file. This audit retains the existing license.

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
