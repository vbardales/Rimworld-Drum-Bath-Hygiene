# Backlog

Ideas for this mod that are not started. Each entry says what the mechanic would be, what already
covers part of it, and what has to be settled before the first line of code.

An idea earns a place here only if it changes **what pawns do**. Anything already shipped is in
the changelog instead, and anything that needs watching in play is in
`_tools/FUNCTIONAL-SCENARIOS.md`.

---

## A drum bath fire that can be too strong

Proposed 2026-09-11.

**The fire has two states today, lit and out.** Read in the drum bath assembly rather than
assumed: the joy giver tests the fuel against a ten per cent threshold, the bath driver never
reads the fuel at all, and this mod reads it once as the pawn gets in. Nowhere is there a notion
of how hard the drum is burning. So the water is hot or it is cold, and it is never too hot.

**What the mechanic would be.** A drum stoked past some point heats the water beyond comfort, and
the bath stops being a straightforward good. What a bather does about it is the interesting half,
and it is a choice between four different mods:

- they refuse to get in until it cools, which makes stoking a thing you can overdo;
- they get in and climb out early, losing the rest of the joy;
- they get in and take it, for a mood penalty that scales with how far past comfort it went;
- they get in and take a small burn, which is the only version with a lasting cost.

The second and third are the ones that change what a pawn does without punishing a player for a
building working as built.

### What is already there, and what it blocks

| Piece | What it gives | What it leaves |
| --- | --- | --- |
| `CompRefuelable` on the drum | fuel present or absent, and a burn rate that never varies | no intensity of any kind to read |
| `CompProperties_HeatPusher` on the drum | room heating, capped at 28 °C | the cap means the room can never say the water is dangerous |
| `Hed_BathingAtDrumBathPassive` | `ComfyTemperatureMax` +10 and `Flammability` -1.0 while soaking | the game **actively protects** the bather, and the idea has to work against that |
| Dubs Bad Hygiene | a hot bath thought and a cold bath thought, both +3 | no third state, no scalding, nothing to reuse |

That third row is the real obstacle and the reason this is not a five-line patch. The bathing
hediff was written to make a bath comfortable in any weather. An idea whose whole point is
discomfort has to either suspend that stat offset or measure heat somewhere the offset does not
reach.

### Before starting

1. **Decide where intensity comes from**, since nothing supplies it. Fuel level as a proxy is the
   cheapest, recent stoking is the truest, and a second comp on the drum is the most honest. This
   decision shapes everything else.
2. **Decide whose territory it is.** This mod patches a hediff of someone else's mod and touches
   nothing else of theirs. Adding heat to their building is a larger intrusion, and may argue for
   a separate mod rather than a fifth feature here.
3. Check what happens to an animal or a pawn without a hygiene need, as always here: the existing
   component takes a quiet exit, and any new effect has to take the same one.
4. Apply the usual duplicate search on the Workshop before writing anything.

### Duplicate search — 2026-09-22

Checked the current Workshop results for drum baths, overheating/scalding, Dubs Bad Hygiene and
hot-spring compatibility. MMDrumcanMOD (Continued) remains a fuelled recreation bath; Dubs Bad
Hygiene provides hot/cold bathing and heating systems; and the DBH & VFEC/Hot Spring Compatibility
mod makes hot springs raise hygiene. None of the results identified a RimWorld 1.6 feature that
turns excessive fuel in the MMDrumcanMOD drum bath into an overheating consequence. This clears
the duplicate-search prerequisite only; it does not decide the intensity source or whether this
belongs in the present bridge rather than a separate mod.

Pages reviewed: [MMDrumcanMOD (Continued)](https://steamcommunity.com/sharedfiles/filedetails/?id=3417093756),
[Dubs Bad Hygiene](https://steamcommunity.com/sharedfiles/filedetails/?id=836308268), and
[DBH & VFEC/Hot Spring Compatibility](https://steamcommunity.com/sharedfiles/filedetails/?id=2949772583).

### Design decision — 2026-09-22

**Source of intensity: a dedicated heat component on the drum. Scope: a separate mod.** This
decision follows a fresh read of the installed MMDrumcanMOD (Continued) 1.6 `Drumcan_Bath.xml`:
`CompProperties_Refuelable` has capacity `10.0`, a fixed consumption rate `5.0`,
`initialFuelPercent` of `1`, and `consumeFuelOnlyWhenUsed` enabled. More stored wood does not
make the flame stronger. Fuel percentage is therefore not a defensible temperature proxy, and
`HasFuel` alone remains the correct hot/cold input for this hygiene bridge. The heat pusher is
capped at 28 °C, so room temperature does not expose the water temperature either.

The separate mod should attach a persistent component to `DrumBath`, with a bounded thermal
state that increases while a fueled bath is occupied and cools while idle. It should explicitly
model *heat retained after sustained use*, rather than claim that refuelling intensifies the
flame. Its first gameplay consequence should be a discomfort thought with severity tied to the
heat excess. That avoids an unproven job interruption and permanent burn while still making a
long succession of baths costly. Do not alter the upstream hediff's temperature offsets or the
DBH hot/cold integration. Animals and pawns without a hygiene need need their own explicit
behavior in the new mod; the existing bridge's quiet exit is not a sufficient test for them.

Before implementation, establish the upstream driver's actual occupied state and how its
`CompRefuelable` reports use, then set heating/cooling rates and thresholds from observed bath
duration (`joyDuration` is 4000 ticks). Write offline tests for the component's state transitions,
save/reload and threshold math; keep the real bath and mood display as in-game scenarios. The
new mod requires its own repository, package ID, rights/attribution review, localization and
publication audit. No source code or distributed files for that separate mod belong in this
bridge's `Mod/` folder.

The installed 1.6 `DrumBath.dll` was decompiled for the occupied-state question. Its
`JobDriver_BathingAtDrumBath` adds `Hed_BathingAtDrumBathPassive` in the bath toil's
`initAction`, removes it in that toil's finish action, and gives that toil a 4000-tick duration
for humanlike pawns or 2000 ticks for other pawns. This is the specific occupancy signal the
new component can read without guessing from `CurJob.targetA` (the driver rewrites its targets).
`Building_DrumBath.Tick()` delegates to `ThingWithComps.Tick()`; it does not report a variable
fire intensity. Whether `CompRefuelable` burns and how it signals active use remain to be
verified before choosing thermal rates. No game process was started for this inspection.
