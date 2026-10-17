# Backlog

Ideas for this mod not started. Each entry say what mechanic would be, what already cover part of it, what must settle before first line of code.

Idea earn place here only if change **what pawns do**. Anything shipped go in changelog. Anything needing watch in play go in `Tests/FUNCTIONAL-SCENARIOS.md`. Two entry kinds exempt: upstream proposals (pull requests, answers from other mod authors) and tests still to write, since part of keeping mod honest, not ideas for new pawn behaviour.

---

## Pull request to the upstream drum bath mod

**Closed 2026-10-03: PR https://github.com/emipa606/MMDrumcanMOD/pull/2 declined by Mlie (no Publicizer dependency wanted); Mlie will link this mod in description of MMDrumcanMOD. Fork branch deleted. Nothing left to do upstream.** Opened 2026-10-02 (PUBLISHING.md: once origin repository exists, pull request systematic, stays here until done; independent of Workshop publication).

Done, closed. Upstream repo `https://github.com/emipa606/MMDrumcanMOD` (MMDrumcanMOD (Continued), Mlie; MIT; `main`; `1.6/` folder). No repo found for Dubs Bad Hygiene (`upstream_mod_remotes` in `STATUS.md`). PR proposed with owner's agreement, declined; this mod stay bridge, so drum mod not depend on Dubs Bad Hygiene.

## A drum bath fire that can be too strong

Proposed 2026-09-11.

**Fire has two states today, lit and out.** Read in drum bath assembly, not assumed: joy giver test fuel against ten per cent threshold, bath driver never read fuel, this mod read it once as pawn get in. Nowhere notion of how hard drum burning. Water hot or cold, never too hot.

**Mechanic would be.** Drum stoked past some point heat water beyond comfort, bath stop being plain good. What bather does about it is interesting half, choice between four designs:

- refuse get in until cool, making stoking something you can overdo;
- get in, climb out early, lose rest of joy;
- get in and take it, mood penalty scaling with how far past comfort;
- get in and take small burn, only version with lasting cost.

Second and third change what pawn does without punishing player for building working as built.

### What is already there, and what it blocks

| Piece | What it gives | What it leaves |
| --- | --- | --- |
| `CompRefuelable` on the drum | fuel present or absent, burn rate never varies | no intensity to read |
| `CompProperties_HeatPusher` on the drum | room heating, capped at 28 °C | cap mean room never say water dangerous |
| `Hed_BathingAtDrumBathPassive` | `ComfyTemperatureMax` +10 and `Flammability` -1.0 while soaking | game **actively protects** bather, idea must work against that |
| Dubs Bad Hygiene | hot bath thought and cold bath thought, both +3 | no third state, no scalding, nothing to reuse |

Third row real obstacle, reason not five-line patch. Bathing hediff written to make bath comfortable in any weather. Idea whose point is discomfort must either suspend that stat offset or measure heat somewhere offset not reach.

### Before starting

1. **Decide where intensity come from**, nothing supply it. Fuel level as proxy cheapest, recent stoking truest, second comp on drum most honest. Decision shape everything else.
2. **Decide whose territory it is.** This mod patch hediff of someone else's mod, touch nothing else of theirs. Adding heat to their building larger intrusion, may argue for separate mod rather than fifth feature here.
3. Check what happen to animal or pawn without hygiene need, as always here: existing component take quiet exit, any new effect must take same one.
4. Apply usual duplicate search on Workshop before writing anything.

### Duplicate search — 2026-09-22

Checked current Workshop results for drum baths, overheating/scalding, Dubs Bad Hygiene, hot-spring compatibility. MMDrumcanMOD (Continued) remain fuelled recreation bath; Dubs Bad Hygiene provide hot/cold bathing and heating systems; DBH & VFEC/Hot Spring Compatibility mod make hot springs raise hygiene. No result identified RimWorld 1.6 feature turning excessive fuel in MMDrumcanMOD drum bath into overheating consequence. Clear duplicate-search prerequisite only; not decide intensity source or whether belong in present bridge rather than separate mod.

Pages reviewed: [MMDrumcanMOD (Continued)](https://steamcommunity.com/sharedfiles/filedetails/?id=3417093756),
[Dubs Bad Hygiene](https://steamcommunity.com/sharedfiles/filedetails/?id=836308268), and
[DBH & VFEC/Hot Spring Compatibility](https://steamcommunity.com/sharedfiles/filedetails/?id=2949772583).

### Design decision — 2026-09-22

**Source of intensity: dedicated heat component on drum. Scope: separate mod.** Decision follow fresh read of installed MMDrumcanMOD (Continued) 1.6 `Drumcan_Bath.xml`: `CompProperties_Refuelable` have capacity `10.0`, fixed consumption rate `5.0`, `initialFuelPercent` of `1`, `consumeFuelOnlyWhenUsed` enabled. More stored wood not make flame stronger. Fuel percentage therefore not defensible temperature proxy, `HasFuel` alone remain correct hot/cold input for this hygiene bridge. Heat pusher capped at 28 °C, so room temperature not expose water temperature either.

Separate mod should attach persistent component to `DrumBath`, with bounded thermal state that rise while fueled bath occupied, cool while idle. Should explicitly model *heat retained after sustained use*, not claim refuelling intensify flame. First gameplay consequence should be discomfort thought with severity tied to heat excess. Avoid unproven job interruption and permanent burn while still making long succession of baths costly. Do not alter upstream hediff's temperature offsets or DBH hot/cold integration. Animals and pawns without hygiene need need own explicit behavior in new mod; existing bridge's quiet exit not sufficient test for them.

Before implementation, establish upstream driver's actual occupied state and how its `CompRefuelable` report use, then set heating/cooling rates and thresholds from observed bath duration (`joyDuration` is 4000 ticks). Write offline tests for component's state transitions, save/reload, threshold math; keep real bath and mood display as in-game scenarios. New mod require own repository, package ID, rights/attribution review, localization, publication audit. No source code or distributed files for that separate mod belong in this bridge's `Mod/` folder.

Installed 1.6 `DrumBath.dll` decompiled for occupied-state question. Its `JobDriver_BathingAtDrumBath` add `Hed_BathingAtDrumBathPassive` in bath toil's `initAction`, remove it in that toil's finish action, give that toil 4000-tick duration for humanlike pawns or 2000 ticks for other pawns. This is specific occupancy signal new component can read without guessing from `CurJob.targetA` (driver rewrite its targets). `Building_DrumBath.Tick()` delegate to `ThingWithComps.Tick()`; not report variable fire intensity. Whether `CompRefuelable` burn and how signal active use remain to verify before choosing thermal rates. No game process started for this inspection.

## Tests still to write

Proposed 2026-10-08. Both come from "open" line of `STATUS.md`; neither change what pawns do.

- **Bathroom thought.** No scenario assert thought stage of Dubs Bad Hygiene's own grading of room, given on entering bath. Write once step can read pawn's thought and room's grade.
- **Adding mod to save made without it.** Removal played 2026-10-08 (`TESTING.md` row 12, run 28cc). Launcher only remove mod after first launch (`-ThenWithout`), so "saved without mod, loaded with it" have no chain of own; need save known made without mod, which `test-colony` probably is but nothing assert. Low value: mod add no def of own, graft component by patch.