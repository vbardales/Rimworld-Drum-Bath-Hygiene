# Testing Drum Bath Hygiene

Three layers, and the order matters: everything provable without the game is proved without it,
because a Pickle run takes over a machine for tens of minutes and a headless check takes a second.

| Layer | What runs it | What it covers |
| --- | --- | --- |
| Offline suite | `_tools/Test-Mod.ps1` | the patch XPath and payload over synthetic defs in all nine shapes the upstream hediff could take; metadata, licence copies, packaging; the compiled assembly's component types and its `IgnoresAccessChecksTo` waiver |
| In-game suite | `Tests/Pickle/` | what needs a map, a pawn and a clock. See `Tests/Pickle/README.md` for the scenario-by-scenario reason |
| Prose scenarios | a person, by hand | what neither can reach: the bathroom thought, the two missing-dependency cases, and removing the mod from a save in progress. `_tools/FUNCTIONAL-SCENARIOS.md` |

```powershell
dotnet build Source/DrumBathHygiene.csproj -c Release
dotnet build Tests/Pickle/Source/DrumBathHygiene.PickleSteps.csproj -c Release
powershell.exe -ExecutionPolicy Bypass -File _tools/Test-Mod.ps1
```

`_tools/Test-Mod.ps1` reads compiled assembly metadata through
`System.Reflection.PortableExecutable`, which Windows PowerShell 5.1 does not carry. Under 5.1 its
first half passes and it stops at the metadata section. Run it under PowerShell 7 for the whole of
it; PowerShell 7 is not installed on this machine, which is why that limit is written here rather
than discovered again.

## How many passes

`../AUDIT.md` asks for three families: one without the optional mods, one per exclusive
combination of optional mods, and one per declared incompatibility. This mod needs **two passes,
and neither of the last two families applies.** The count is small because the mod is small, and
the reasons are the sort that expire:

| Pass | Command | What it proves |
| --- | --- | --- |
| `sans-facultatifs` | `scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene ` | the whole suite against Core, the DLC, Harmony, RimLogging, Pickle, both hard dependencies and this mod. This is the only set the mod can be loaded in today |
| French | `scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene -Language French` | the same suite under a French game. No step spells an English label, so the features are unchanged; what differs is the capture a person then opens |

**No pass with optional mods.** `Mod/About/About.xml` declares `loadAfter` on `Ludeon.RimWorld`,
`Dubwise.DubsBadHygiene` and `Mlie.MMDrumcanMOD` — Core and the two hard dependencies. There is no
optional mod to add, so no second set exists. **The day `loadAfter` names a mod that is not a hard
dependency, this table is wrong** and that mod needs a named set of its own.

**`Tests/Pickle/wsl-ids.map` holds the two hard dependencies, and needs no option.** The shared table in `stage-pickle-wsl.sh` does not know their Workshop ids, and a dependency it cannot place stops the run before anything is launched — which is what the first attempt on 2026-09-21 did (`no Workshop id known for Mlie.MMDrumcanMOD`). That file is read in every pass, the bare one included, and it only *resolves*: nothing on it is activated, so it is not an optional set and it does not rename the pass. An earlier version of it was named `wsl-deps.sans-facultatifs.map` and had to be passed with `-DepMap`; it mislabelled a resolution table as a mod set and staged both mods twice, and the harness now has a place made for it (`scripts/PICKLE-WSL.md`, "Hard dependencies the shared table does not know").

**No incompatibility pass.** The mod declares no `incompatibleWith`, and neither `README.md` nor
`CHANGELOG.md` claims it breaks with anything. There is no assertion to go and re-check. The day
one is written down — in either file, or in the Workshop description — it needs a
`wsl-deps.incompat-<mod>.map` and a pass that **asserts the documented symptom** rather than
expecting a red: `an error matching {string} was logged`, `mod {string} is not loaded`,
`no def {string} was patched`, with `@allow-errors`. A suite where some reds are wanted and others
are not cannot be read at a glance.

**The language pass is not a mod set**, and it is the one place where the two runs differ by more
than their name. Language is fixed at staging by `-Language`; a scenario that switched language
mid-run would hang on a game being torn down under the runner.

## Reading a report

- `exitReason` first, before any number. A run killed in flight leaves a `summary.json` that looks
  like a result: "6 passed, 0 failed" over seventeen scenarios, with `exitReason: in-progress`.
- Scenarios played against features discovered, second. `-pickle-include-wip` has truncated a run
  to one feature of nineteen and reported `passed`. Nothing else catches that.
- `@review` green last, and never as a verification. `04-review-capture.feature` attaches an image
  for a person to open. Its green says the trajectory ran, not that the image shows anything.
- A run overwrites the previous report, captures included. Copy what is needed before launching
  again; `PickleReports-archive` keeps five runs and nothing survives past that.

## Status

The offline suite passes. The Pickle suite has **run twice** — English, 2026-09-21, 8 of 11 and then 12 of 16
passed, no failure a defect of the mod — and was **changed after each run**, so the suite as it
stands has not been run. `STATUS.md` carries the two passes owed as `unverified` under the
`done -> tested` transition, where they belong: writing the scenarios is what `preTest -> done`
asks for; running them is not. The first run's findings are in `Tests/Pickle/README.md`.
