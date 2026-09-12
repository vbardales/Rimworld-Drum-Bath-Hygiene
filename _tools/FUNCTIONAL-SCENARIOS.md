# Functional scenarios, to be played in game

This mod adds no def, no building and no texture of its own. All it does is notice that a pawn is
soaking in a drum bath and hand that fact over to Dubs Bad Hygiene. Nothing about that can be read
in a def file: it takes a map, a colonist, a drum and a clock. These are the scenarios that read
it, written so each one has a single thing to watch and a single way of being wrong.

**What was already checked out of game**, on 2026-09-11 against Dubs Bad Hygiene 1.6 and
MMDrumcanMOD (Continued) 3417093756, by loading both assemblies and resolving the members by
reflection:

- `Need_Hygiene.clean(float)`, `PrivacyUtil.BathingPrivacyLOS(Pawn, float)`,
  `SanitationUtil.WaterTempCheck(Pawn, bool, bool)` and
  `SanitationUtil.ApplyBathroomThought(Pawn, Thing)` all exist, with exactly the signatures the
  bridge asks for;
- `DubDef.SoakingWet` exists and is a `ThoughtDef`. The def itself is **vanilla**, declared in
  Core, so it resolves whatever Dubs Bad Hygiene does with it;
- the drum bath still declares `Hed_BathingAtDrumBathPassive` with no `hediffClass` of its own,
  which is the whole reason the patch has a first half;
- the drum is `DrumBath`, it carries a `CompRefuelable` on wood, and the bath job runs for
  `joyDuration` 4000 ticks;
- the joy giver rejects any drum whose fuel is at or below ten per cent, and the bath driver never
  reads the fuel at all. The fire has two states and only two, lit and out: nothing in the drum,
  in the bath job or in Dubs Bad Hygiene knows a fire that is too strong.

So a failure seen below is not a renamed member. It is the mod.

---

## Setup for everything here

Development mode on. Both source mods active alongside this one, this one loaded after them.
One drum bath built and fuelled with wood, in a room. One colonist whose hygiene bar is low —
drive it down with the dev need editor rather than waiting.

Empty `Player.log` before launching, as always, and read it afterwards rather than during.

Two clocks worth knowing, because several scenarios below are over before you find the right
tab: a bath lasts 4000 ticks, that is about 66 seconds at normal speed or 1.6 in-game hours, and
the onlooker check runs every 300 ticks, that is about five seconds.

The bathing hediff is declared `becomeVisible false`, so it shows in the Health tab **only**
while dev mode is on. That is how you tell a pawn is really carrying it.

---

## 0. It loads, and both halves of the patch take

**Do.** Start the game with the three mods. Load any save with a drum bath on the map. Send a
colonist to bathe and open their Health tab while they soak.

**Expect.** No red text at startup. An invisible `Bathing` hediff on the pawn in the Health tab.

**Watch for in `Player.log`.** Four lines, each meaning a different failure:

- `has comps but hediffClass is not HediffWithComps`, naming `Hed_BathingAtDrumBathPassive` — the
  first half of the patch did not take. The comps were added to a hediff that cannot carry them.
- `Could not find type named DrumBathHygiene.HediffCompProperties_DrumBathHygiene` — the assembly
  did not load. In 1.6 an unknown `Class=` takes the whole def down with it, so the bath itself
  will be missing, not just the washing.
- `[Drum Bath Hygiene] Dubs Bad Hygiene found, but Need_Hygiene.clean could not be resolved` —
  the bridge broke on a Dubs Bad Hygiene update. The bath still gives joy and warmth, and washes
  nobody. This is the one line that says the mod is inert while everything looks fine.
- `FieldAccessException` naming `carriedFilth`, at the **end** of a bath rather than at startup —
  the assembly was built without its access waiver. That fault shipped once, on 2026-09-12, and
  was caught by reading the assembly's attributes rather than by playing; see
  `Source/AccessChecks.cs`. It would take scenario 7 down, and the last onlooker check with it.
- Any other line beginning `[Drum Bath Hygiene]`. Each names the DBH call that failed.

**If it fails here, stop.** Everything below assumes the component is on the hediff.

---

## 1. The bath washes — the scenario the mod exists for

**Do.** Note the hygiene percentage of a filthy colonist. Send them to bathe. Note it again the
moment they climb out.

**Expect.** They come out clean. From an empty gauge the fill takes 2000 ticks, half the bath, so
a colonist who starts at zero is full before they are done soaking.

**Why it matters.** This is the whole mod. If the gauge has not moved, the component is on the
hediff — scenario 0 said so — and the need was never bound. Look for the warning line above; if
the log is silent as well, the pawn has no hygiene need at all, which is the quiet exit an animal
takes.

## 2. Half a bath is enough, and nothing spills over

**Do.** Send a colonist in at about half hygiene. Watch the bar rather than the clock.

**Expect.** Full at around a quarter of the bath, then flat for the rest of it. No warning
repeating in the log while it sits at full.

**Why it matters.** The fill is a fixed amount per tick with no stop condition of its own: it
leans on Dubs Bad Hygiene clamping its own need. A gauge that overshoots, or a log that fills up
during the second half of every bath, means it does not.

## 3. Hot water, and the cold water nobody can order

**Do.** Bathe once in a drum with wood burning. For the cold case, wait until a colonist is
walking toward a bath of their own accord, and empty the drum's fuel with the dev gizmo **while
they are still on their way**.

**Expect.** The `hot bath` memory the first time, `cold bath` the second, both in the mood tab,
both from Dubs Bad Hygiene and both worth +3.

**Why the detour.** A colonist cannot be ordered into a bath: joy is scheduled, and the drum
offers no right-click option. The only thing that hands out the job refuses any drum at or below
ten per cent fuel, so nobody ever sets off toward a cold bath. The job, once given, never looks
at the fuel again — and this mod reads it at the moment the pawn gets in. Emptying the drum
during the walk is therefore the only way to reach the cold branch on purpose.

**It is reachable by accident too, and worth knowing.** The drum burns no fuel standing idle, but
it loses about eighteen wood a day when rain falls on it unroofed, which empties a full one in
half a day. An outdoor drum just above the ten per cent line can be dry by the time its bather
arrives.

**Also check.** Emptying the fuel *mid-bath* must **not** turn a hot bath cold. The reading
happens once, on the way in.

## 4. The room is judged

**Do.** Bathe in a filthy cramped room. Then bathe in a clean, large, well-lit one.

**Expect.** Dubs Bad Hygiene's own bathroom memory in both cases, `awful bathroom` in the first
and a better stage in the second.

**Why it matters.** The thought is asked for with the drum as the fixture, so it is the drum's
room that is judged. No memory at all means the drum was not found under the pawn's feet, which
is the same lookup scenario 3 depends on.

## 5. Onlookers keep noticing

**Do.** Bathe in a room other colonists walk through, in plain sight. Then bathe alone behind a
closed door.

**Expect.** The `embarrassed` memory in the first case, and it stacks — the check runs every five
seconds for the length of the bath, and that memory stacks up to six times. Nothing in the second
case.

**Why it matters.** One check at the door would be cheaper and wrong: someone walking in halfway
through is exactly the situation the memory is for.

## 6. Soaking wet is forgotten on the way in

**Do.** Get a colonist soaked — send them across a river, or leave them out in the rain — until
they carry the vanilla `soaking wet` memory. Send them straight to the bath. Watch the mood tab
while they get in.

**Expect.** The memory goes as they enter, not when they climb out.

**Why it matters.** One does not climb into a bath and complain of being wet. Dubs Bad Hygiene
clears it after its own baths; this is the same gesture. If it survives the whole bath, the
clearing is running at the wrong end.

## 7. The mud comes off on the way out

**Do.** Walk a colonist through mud or blood until they leave a trail of footprints behind them.
Send them to bathe. Watch the floor behind them afterwards.

**Expect.** No more trail. The filth they were carrying is dropped when the bath ends.

**Why it matters.** This is the only thing the mod does on the way out. A pawn who walks out of a
bath still printing mud means the removal hook never ran, which would also mean the last onlooker
check never ran.

---

## 8. It survives a save, and a reload

**Do.** Save with a colonist in the bath. Quit to the menu. Reload. Watch the hygiene bar.

**Expect.** The bath resumes and the bar keeps filling at the same pace.

**Why it matters.** The delegate that fills the need cannot be saved, so it is deliberately not
saved: it is looked up again on the first tick after the load. A bar that freezes after a reload
and only after a reload means that second lookup is not happening.

## 9. Two baths in a row behave alike

**Do.** Let the same colonist bathe twice, back to back, and a second colonist bathe after them.

**Expect.** The second bath washes as well as the first, for both pawns. Entry effects — water
temperature, room, soaking wet, the first onlooker check — fire again each time.

**Why it matters.** The bridge to Dubs Bad Hygiene is resolved once for the whole game session
and shared; the per-bath state is not. A first bath that works and a second that does nothing
would mean those two lifetimes have been confused.

---

## 10. Without Dubs Bad Hygiene, the mod says nothing

**Do.** Disable Dubs Bad Hygiene, keep the drum bath mod and this one. Bathe.

**Expect.** The bath behaves exactly as it does without this mod: joy, the warm memory, the rest
bonus, nobody washed.

**Watch for.** Any line at all beginning `[Drum Bath Hygiene]` is a bug here. A missing assembly
is the expected case, not a fault, and the bridge is meant to exit on it without a word.

## 11. Without the drum bath mod, the patch does not fire

**Do.** Disable MMDrumcanMOD, keep Dubs Bad Hygiene and this one. Start a game.

**Expect.** RimWorld flags the missing dependency in the mod list, which is intended and is the
only complaint. No XML error naming `Hed_BathingAtDrumBathPassive`, and no unresolved type.

**Why it matters.** The patch guards itself on the hediff existing rather than on a mod
identifier, so it is also insensitive to the `_steam` suffix, to a rename and to a local copy of
the drum bath mod. If the log complains, the guard is being skipped rather than evaluated.

## 12. It goes into a running save, and comes back out of one

**Do.** Add the mod to a save made without it. Play, and bathe. Then save **outside** a bath,
disable the mod, and load again.

**Expect.** Nothing disturbed either way. The mod declares no def of its own, so removing it
leaves nothing unresolved behind.

**A save made mid-bath is the one case to look at.** The component writes two small values into
the hediff. Taking the mod out with a pawn still soaking may leave one orphan-node warning on the
next load. One warning, once, and no repeat.

---

## Language display check — English and French

Execution status: not run. Repeat scenarios 0–6 with English selected, then with French
selected, restarting the game after changing language. Record RimWorld and dependency
versions and the language for each result.

Inspect the drum bath's label and description, the bathing hediff, the hygiene need,
and the hot/cold bath, bathroom and privacy thoughts produced by the integration.
These texts belong to MMDrumcanMOD or Dubs Bad Hygiene; this bridge adds no text of its
own. Check for raw keys, unexpected English fallback in French, broken formatting and
clipping. Record any issue with the owning dependency and a screenshot; do not treat
the bridge's `not_applicable` translation fields as proof of dependency coverage.
Technical `[Drum Bath Hygiene]` logs intentionally remain English.

## What to send back

The `Player.log` of the session, and for scenario 1 the two hygiene percentages, before and
after. That pair is the only number in the list; everything else is read off a mood tab or a
floor.
