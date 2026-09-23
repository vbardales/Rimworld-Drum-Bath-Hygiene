# Testing Drum Bath Hygiene

Three layers, and the order matters: everything provable without the game is proved without it,
because a Pickle run takes over a machine for tens of minutes and a headless check takes a second.

| Layer | What runs it | What it covers |
| --- | --- | --- |
| Offline suite | `_tools/Test-Mod.ps1` | the patch XPath and payload over synthetic defs in all nine shapes the upstream hediff could take; metadata, licence copies, packaging; the compiled assembly's component types and its `IgnoresAccessChecksTo` waiver |
| In-game suite | `Tests/Pickle/` | what needs a map, a pawn and a clock. See `Tests/Pickle/README.md` for the scenario-by-scenario reason |
| Prose scenarios | nobody, now | `_tools/FUNCTIONAL-SCENARIOS.md` is the written source the Pickle scenarios are drawn from. What is not played is listed **not applicable, with its reason**, in "What covers what" below: `tested` leaves no manual test to validate |

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

## What covers what

`_tools/FUNCTIONAL-SCENARIOS.md` holds thirteen scenarios (0-12) and a language check, written for a person.
`done -> tested` asks that no manual test be left to validate: what used to be ticked by hand is **automated and
green, or listed as not applicable with its reason**. This is that list. **It is a plan: a row is covered only when
the Pickle scenario it names has passed, and the suite as it now stands has not yet run.**

| Prose scenario | Covered by | Not applicable, and why |
| --- | --- | --- |
| 0. It loads, both halves of the patch take | `01`: the patch lands on the hediff the game built; every scenario ends on `no errors were logged` | |
| 1. The bath washes | `01`: the gauge climbs (with its control), and the end-to-end wash through the real job | |
| 2. Half a bath is enough, nothing spills over | `01`: half a bath fills an empty gauge (above 0.9), then stays below 1.001 after 3000 ticks (1.60 if unclamped) with no warning from the mod | |
| 3. Hot water, and the cold water nobody can order | `02`: two pairs, and the pair through the real job. The cold branch is reached on purpose, which no player can | |
| 4. The room is judged | nothing | **Not applicable.** `ApplyBathroomThought` is Dubs Bad Hygiene's grading of a scored room: asserting a stage tests DBH, which can only fail for a reason that is not this mod's. What the bridge owns is the call going through, and every scenario ends on `no errors were logged` (the half-bath and the baths-in-a-row ones also on `no warnings from mod`), which is where a failed reflected call would show |
| 5. Onlookers keep noticing | `05`: alone for a full check interval, then an onlooker arrives halfway, and the memory has stacked at the next checks while the bath is still running | |
| 6. Soaking wet is forgotten on the way in | `02` | |
| 7. The mud comes off on the way out | `03`: carried filth cleared. It executes the `IgnoresAccessChecksTo` waiver | |
| 8. It survives a save, and a reload | `01`: a bath survives a save and a reload and goes on washing | |
| 9. Two baths in a row behave alike | `06`: two baths for one colonist and one for another, each asserted for its water memory, soaking wet and hygiene | |
| 10. Without Dubs Bad Hygiene | nothing | **Not applicable.** DBH is a **hard dependency**: what RimWorld does when one is missing (the warning in the mod list, the load) is the game's, not the mod's, and "on ne teste pas le jeu". What the mod answers for is what it **declares**: `modDependencies` carries the right package id and Workshop id, and `loadAfter` the right order. That was checked in the sources against the installed `About.xml` files on 2026-09-21. A pass could not play it anyway: the pass map excludes only DLCs. **One open consequence:** the Workshop description, already sent, says nothing breaks without them, which no run has shown |
| 11. Without the drum bath mod | `_tools/Test-Mod.ps1`: the patch against an upstream that has no such hediff leaves every def unchanged | **Not applicable in game**, same reason as 10 |
| 12. Into a running save, and out of one | `01`: the two scribed values survive a save and a reload | **Not applicable.** Adding or removing a mod from a save is RimWorld's handling of its own mod list. The mod's share is what it writes into the save, which is those two values |
| Language check, English and French | the French pass, and the capture of each language | The text on screen is Dubs Bad Hygiene's and the drum mod's, not this bridge's (see `STATUS.md`, translation fields). What remains is **reading the two captures**, which is not a further manual test: it is reading an image that a scenario has already proved to show a colonist in the bath |

**Scenario tags.** Nothing in the suite is `@wip`, and nothing is `@requires:`: the mod declares no optional mod, so
no scenario is conditional. The only tags are `@review` and `@film` on the capture, and `@timeout`. Both facts are
checked by a search of the features before a report is quoted, not assumed.

So Pickle plays scenarios 0 to 3 and 5 to 9, and 11 offline; **4, 10 and 12 are not applicable**, each with its reason above.

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
