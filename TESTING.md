# Testing Drum Bath Hygiene

Two layers, plus shared checks. `scripts/Test-Mod.ps1` was removed 2026-10-26 (owner): offline checks now come from the protocols repo scripts (`../scripts/`), not from a local script. Pickle run takes over machine tens of minutes.

| Layer | What runs it | What it covers |
| --- | --- | --- |
| Shared offline check | `powershell -NoProfile -ExecutionPolicy Bypass -File ../scripts/Check-ModBasics.ps1 -ModRoot .` | `About.xml`, notices, images, XML well-formedness (PASS 2026-10-26: 2 XML files, 0 defs). `Run-UnitTests.ps1` needs a `Tests/*.Tests.csproj`, none here |
| Shared XML checks | `../scripts/Check-XmlFields.ps1 -ModPath Mod`, `Check-TypeRefs.ps1 -ModPath Mod`, `Check-DefRefs.ps1 -ModPath Mod` | every element maps to a game field; no unguarded third-party type; every `ParentName` resolves (all clean 2026-10-26). `Check-XmlClasses.ps1` needs `-TypeLists`, not run |
| In-game suite | `Tests/Pickle/` | what needs map, pawn, clock. See `Tests/Pickle/README.md` for scenario-by-scenario reason |
| Prose scenarios | nobody, now | `Tests/FUNCTIONAL-SCENARIOS.md` is written source Pickle scenarios drawn from. What not played listed **not applicable, with its reason**, in "What covers what" below: `tested` leaves no manual test to validate |

```powershell
dotnet build Source/DrumBathHygiene.csproj -c Release
dotnet build Tests/Pickle/Source/DrumBathHygiene.PickleSteps.csproj -c Release
```

The removed offline suite (patch XPath and payload over nine synthetic shapes, metadata, licence copies, packaging, component types, `IgnoresAccessChecksTo` waiver) is not replaced by a shared script: none runs a patch over synthetic defs. Last version in git history (`git show 2d675b8:scripts/Test-Mod.ps1`). The waiver is still executed by `03-climbing-out`; the patch is still observed on the loaded hediff by `01`.

## How many passes

`../AUDIT.md` asks three families: one without optional mods, one per exclusive combination of optional mods, one per declared incompatibility. This mod needs **four runs in three sets (`tools` in two languages, `sanctuary` in two, `removal`), and neither of last two families applies.** Count small because mod small; reasons are sort that expire:

| Pass | Command | What it proves |
| --- | --- | --- |
| `tools`, English | `scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene -DepMap wsl-deps.tools.map -Filter '!07-workshop-captures,!08-removal-write'` | features `01` to `06`: 19 scenarios against Core, DLC, Harmony, RimLogging, Pickle, both hard dependencies and this mod, plus two step packages (below). Mod loaded as is, nothing else |
| `tools`, French | same with `-Language French` | same 19 scenarios under French game. No step spells English label, so features unchanged; what differs is capture person then opens |
| `sanctuary`, English then French | `scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene -DepMap wsl-deps.sanctuary.map -Filter '::framed for the page' -Then '::the Needs tab of a colonist'` (and `-Language French`) | `07-workshop-captures`: two Workshop images, taken in Nelim's Sanctuary (SanctuaryBacklot) with Backlot's staging packages |
| `removal`, two launches | `wsl-deps.removal.map`, `-ThenWithout` | `08-removal-write` saves with colonist in bath, then `Removal/` loads that save without mod (row 12 below). Played once, 2026-10-08; replay when component or patch changes |

**`tools` pass not whole suite, whole suite not one run.** `tools` map stages
`nelim.pickletools.inspecttabs` (`PickleTools/InspectTabs`, steps opening pawn's inspect tabs, stock Pickle lacks) and `nelim.pickletools.screenshotstudio`. Neither optional mod, so still pass without optional
mods, named after its map. Since `a39e287` (2026-10-07) `07` no longer runs there: dresses colonist with
`wears … dyed rgb` (`nelim.pickletools.colonistrace`) and builds in Sanctuary, so on `tools` map fails on undefined
steps. `08` carries `@requires:nelim.drumbathhygiene.pickleremoval`, skipped without companion. Run of `tools`
map without `-Filter` above therefore reports 22 scenarios, 19 passed, 2 failed (`07`), 1 skipped (`08`): that
wrong pass, not mod defect (2026-10-11). Runs 8 and 9 (2026-09-23, 19 scenarios, before `07`) in
`docs/runs/history.md`. Filter also exists to retake one image (`PickleTools/Headless/README.md`, "Choosing what to run").

**No pass with optional mods.** `Mod/About/About.xml` declares `loadAfter` on `Ludeon.RimWorld`,
`Dubwise.DubsBadHygiene` and `Mlie.MMDrumcanMOD`, Core and two hard dependencies. No optional mod to add, so no second set. **Day `loadAfter` names mod not hard
dependency, this table wrong** and that mod needs named set of its own.

**`Tests/Pickle/wsl-ids.map` holds two hard dependencies, needs no option.** Shared table in `stage-pickle-wsl.sh` does not know their Workshop ids, and dependency it cannot place stops run before anything launched, which first attempt 2026-09-21 did (`no Workshop id known for Mlie.MMDrumcanMOD`). File read in every pass, bare one included, only *resolves*: nothing on it activated, so not optional set, does not rename pass. Earlier version named `wsl-deps.sans-facultatifs.map`, had to be passed with `-DepMap`; it mislabelled resolution table as mod set and staged both mods twice, and harness now has place made for it (`scripts/PICKLE-WSL.md`, "Hard dependencies the shared table does not know").

**No incompatibility pass.** Mod declares no `incompatibleWith`, and neither `README.md` nor
`CHANGELOG.md` claims it breaks with anything. No assertion to re-check. Day
one written down, in either file, or Workshop description, it needs
`wsl-deps.incompat-<mod>.map` and pass that **asserts documented symptom** rather than
expecting red: `an error matching {string} was logged`, `mod {string} is not loaded`,
`no def {string} was patched`, with `@allow-errors`. Suite where some reds wanted, others
not, cannot be read at glance.

**Language pass not mod set**, and only place two runs differ by more
than name. Language fixed at staging by `-Language`; scenario switching language
mid-run would hang on game torn down under runner.

## What covers what

`Tests/FUNCTIONAL-SCENARIOS.md` holds thirteen scenarios (0-12) and language check, written for person.
`done -> tested` asks no manual test left to validate: what used to be ticked by hand **automated and
green, or listed as not applicable with its reason**. This is that list. Row covered only when
Pickle scenario it names has passed: **both passes of 2026-09-23 green, so rows covered.**

| Prose scenario | Covered by | Not applicable, and why |
| --- | --- | --- |
| 0. It loads, both halves of the patch take | `01`: patch lands on hediff game built; every scenario ends on `no errors were logged` | |
| 1. The bath washes | `01`: gauge climbs (with its control), and end-to-end wash through real job | |
| 2. Half a bath is enough, nothing spills over | `01`: half a bath fills empty gauge (above 0.9 after 2000 ticks); gauge full for last 200 of them, no warning from mod | **"Nothing spills over" not observable.** Fill goes through `Need_Hygiene.clean`, which reads `CurLevel = Min(CurLevel + x, 1)`, and vanilla `CurLevel` setter clamps to `MaxLevel` as well (both read from IL 2026-09-23). Dependency's guarantee, so no assertion on level can fail. Earlier version asserted "below 1.001" after 3000 ticks: could not fail, and lowered floor of rate check from 0.0004 to 0.00027 per tick |
| 3. Hot water, and the cold water nobody can order | `02`: two pairs, pair through real job (cold branch reached on purpose, which no player can), and emptying drum in middle of hot bath, which must not turn it cold because fuel read once | |
| 4. The room is judged | nothing | **Not applicable.** `ApplyBathroomThought` is Dubs Bad Hygiene's grading of scored room: asserting stage tests DBH, can only fail for reason not this mod's. Bridge owns call going through. Bridge reports failed reflected call with `Log.WarningOnce`, never as error, so `no errors were logged` cannot see it; every scenario entering bath therefore also ends on `no warnings from mod`, and must be every one, because `WarningOnce` prints once per session and only first scenario to trigger it would show it |
| 5. Onlookers keep noticing | `05`: alone for full check interval, then onlooker arrives halfway, memory stacked at next checks while bath still running | |
| 6. Soaking wet is forgotten on the way in | `02` | |
| 7. The mud comes off on the way out | `03`: carried filth cleared. Executes `IgnoresAccessChecksTo` waiver | |
| 8. It survives a save, and a reload | `01`: bath survives save and reload, goes on washing | |
| 9. Two baths in a row behave alike | `06`: two baths for one colonist and one for another, each asserted for water memory, soaking wet and hygiene | |
| 10. Without Dubs Bad Hygiene | nothing | **Not applicable.** DBH is **hard dependency**: what RimWorld does when one missing (warning in mod list, load) is game's, not mod's: game itself not under test. Mod answers for what it **declares**: `modDependencies` carries right package id and Workshop id, `loadAfter` right order. Checked in sources against installed `About.xml` files 2026-09-21. Pass could not play it anyway: pass map excludes only DLCs. **One open consequence:** Workshop description, already sent, says nothing breaks without them, which no run has shown |
| 11. Without the drum bath mod | nothing | **Not applicable in game**, same reason as 10. Was checked offline (patch against upstream with no such hediff leaves every def unchanged) until `scripts/Test-Mod.ps1` was removed 2026-10-26: no check left, the patch is guarded by `PatchOperationConditional` |
| 12. Into a running save, and out of one | `01`: two scribed values survive save and reload | **Removal played 2026-10-08** (run 28cc, `536e4bf`): `08-removal-write` saves with colonist in bath, `removal-check` loads it without mod (`-ThenWithout`): both green, no error logged, game runs 250 ticks and saves again. Adding mod to save made without it: every scenario loads Pickle's `test-colony`, not made with mod, but not asserted as such; not played as own case. What mod writes into save is two scribed values |
| Language check, English and French | French pass, and capture of each language | Text on screen is Dubs Bad Hygiene's and drum mod's, not this bridge's (see `STATUS.md`, translation fields). What remains is **reading two captures**, not further manual test: reading image scenario already proved to show colonist in bath |

**Scenario tags.** Nothing in suite is `@wip`. One scenario is `@requires:` (`08-removal-write`, needs companion mod `nelim.drumbathhygiene.pickleremoval`, played by `removal` pass, never skipped there); mod declares no optional mod, so no other scenario conditional. Only tags are `@review` and `@film` on capture, and `@timeout`. Both facts
checked by search of features before report quoted, not assumed.

So Pickle plays scenarios 0 to 3 and 5 to 9; **4, 10, 11 and 12 not applicable**, each with reason above.

## Reading a report

- `exitReason` first, before any number. Run killed in flight leaves `summary.json` looking like result: "6 passed, 0 failed" over seventeen scenarios, with `exitReason: in-progress`.
- Scenarios played against features discovered, second. `-pickle-include-wip` has truncated run to one feature of nineteen and reported `passed`. Nothing else catches that.
- `@review` green last, never as verification. `04-review-capture.feature` attaches image for person to open. Its green says trajectory ran, not that image shows anything.
- Run overwrites previous report, captures included. Copy what needed before launching
  again; `PickleReports-archive` keeps five runs, nothing survives past that. Launch with
  `-EvidenceDir DrumBathHygiene/.build/evidence/<pass>`: full report stays on disk and out of git
  (`.build/` ignored), and **text summary** goes to `docs/runs/`, see `docs/runs/README.md`, which also says which Evidence to keep after run (summary, log, `@review` capture and film, small) and what to delete.

## Status

No offline suite (removed 2026-10-26). Pickle suite is 22 scenarios in 8 features, played by three sets above. Runs 22 and 23
(`271365b`, 21 of 21, `tools`) predate Sanctuary migration of `07` and removal chain: no longer certify
suite as it stands. Current certification is non-regression of 2026-10-11 on `02b3cb8`, in `docs/runs/README.md`,
which keeps one line per run.
First run's findings in `Tests/Pickle/README.md`.