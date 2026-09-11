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
