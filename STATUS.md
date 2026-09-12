---
mod:        Drum Bath Hygiene
packageId:  nelim.drumbathhygiene
repo:       Rimworld-Drum-Bath-Hygiene
visibility: public
detached:   yes
stage:      done
licence:    original
licence_at: original work, MIT. Nothing is reused from either source mod - no code, no def, no texture. The mod is the wire between MMDrumcanMOD and Dubs Bad Hygiene, both credited in ATTRIBUTION.
showcase:   complete
tested_on:
workshop:
remaining:
  - unverified: the thirteen scenarios of `_tools/FUNCTIONAL-SCENARIOS.md`, none played, starting
    with the zeroth: until that one passes, the other twelve prove nothing.
  - unverified: the cold water branch, which is reached only by emptying the drum while the
    bather is still walking to it (scenario 3). No colonist ever sets off toward a cold bath -
    the joy giver rejects any drum at or below ten per cent fuel.
  - unverified: whether a save made mid-bath, with the mod removed afterwards, leaves an orphan
    node warning on the next load (scenario 12).
  - feature: a fire that could be too strong, parked in `BACKLOG.md` rather than forgotten. The
    drum has two states today, lit and out, and nothing anywhere models an intensity.
session:    local_86846e45-ee66-436e-978d-5b312225c26f
updated:    2026-09-12, the mod's own session
---

# Drum Bath Hygiene — status

Status card, read by a pass over every mod rather than by asking each thread one at a time. It
lives at the root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Three could not be, and waited for the
session that holds this mod. They were filled the same day:

- **`stage`** — `done`, confirmed. The mod is written, it compiles, it is detached and
  documented. What is left is not development, it is the in-game check.
- **`tested_on`** — left empty, and that is exact rather than an omission: this mod has never run
  in a game. Nothing it does has ever been observed by anyone, neither a hygiene bar moving nor a
  memory cleared.
- **`remaining`** — the catch-all line the sweep leaves there is replaced by four real ones, now
  that `_tools/FUNCTIONAL-SCENARIOS.md` says precisely what has not been checked. Two of them are
  questions the disk cannot answer, which is why they are scenarios rather than tests.

The `remaining` categories: `feature` for something missing from the first pass, `defect` for a
known fault left unfixed, `unverified` for what could not be checked.

**There is nothing to translate here.** The mod declares no def, no label and no texture, so the
missing `Languages/` folder is not a gap, and no `feature` line records one.

What is left fits in a sentence: **everything is written, nothing has been played.** One play
session will empty most of that list at once. Until then, no Workshop item should be created —
the showcase has never been seen in place.

The `session` field was not touched: it comes from the sweep and names the session group, not this
conversation.

The `licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` nothing reused.
