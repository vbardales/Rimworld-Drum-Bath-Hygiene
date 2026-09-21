# In-game scenarios, run by Pickle

A short suite, run inside a running RimWorld by
[Pickle](https://github.com/RimWorks/Rimworld-Pickle) (`rimworks.pickle`, Workshop 3791648678).

**Read `_tools/Test-Mod.ps1` first.** It applies this mod's real patch XPath and payload over
synthetic upstream defs, in all nine shapes the drum bath hediff could arrive in, plus the
metadata, licence and packaging checks and the access waiver read off the compiled assembly — in
about a second, with no game. A Pickle run takes over a machine for tens of minutes. Nothing lives
here that can be proved outside the game, and the one feature that was drafted and cut said so:
a scenario re-asserting the patch over the same nine shapes would have confiscated the machine to
repeat a check that already runs on every build.

`Mod/` is a companion mod, **Drum Bath Hygiene - Pickle tests**, never published. It holds the
feature files and the step assembly, so nothing test-related ships in the Workshop folder — which
matters here more than usual: `SteamUGC.SetItemContent` sends `Mod/` whole, with no filtering.

## What is left, and why it needs the game

| Scenario | Why nothing offline can say it |
| --- | --- |
| the patch lands on the hediff the game built | the offline suite patches a document it wrote itself; the real engine patches one holding every active mod's operations, in load order. A `PatchOperationConditional` that matched nothing reports success either way |
| the gauge climbs | the fill goes through `Need_Hygiene.clean`, bound by reflection into another mod's assembly. Only a running need moves |
| a colonist who is not bathing is not washed | Dubs Bad Hygiene moves that need by itself. Without this control, a rise proves nothing |
| half a bath fills an empty gauge | `0.0005` per tick is a number in a file until 2000 ticks have passed. It also crosses six privacy re-checks |
| an animal is left alone | `ResolveCleanAction` returning null for a pawn with no hygiene need, and staying null. The branch that throws if it is wrong |
| a save and a reload mid-bath | the two scribed values, and the delegate deliberately not scribed, which has to bind again after the load |
| hot water and cold water | `cold` is read off `CompRefuelable.HasFuel` on the drum under the pawn's feet. What follows is DBH's rule, so it is played as two pairs, each asserting on both sides: a healthy colonist (burning: no `ColdWater`; burnt out: `ColdWater`) and a chilled one (burning: `HotBath`; burnt out: `ColdWater`) |
| soaking wet forgotten on the way in | a reflected `ThoughtDef` lookup and a memory removal on a live pawn |
| carried filth cleared on the way out | **the access waiver, executing.** See below |
| the gauge stops when the bath does | a comp that had outlived its hediff would pass every other scenario and fail this one |

### The one that pays for the whole suite

`Source/AccessChecks.cs` records a defect that a clean build, a clean startup and a successful
patch all hid: with the `IgnoresAccessChecksTo` waiver missing, every bath **ended** on a
`FieldAccessException` thrown out of the hediff's removal. `Test-Mod.ps1` reads the waiver off the
compiled assembly, which is cheap and catches the waiver being absent. It cannot catch a waiver
that is present and names the wrong assembly. `03-climbing-out.feature` executes the instruction,
on a real filth tracker with real filth in it.

## How many passes

`../../TESTING.md` holds the table. In short, and the count is small on purpose:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene -Language French
```

`wsl-ids.map` holds the Workshop ids of the two hard dependencies, which the shared table in `stage-pickle-wsl.sh` does not know; without it the staging stops with `no Workshop id known for Mlie.MMDrumcanMOD`. It is read in every pass and only resolves: nothing on it is activated, and it is **not** a set of optional mods, so no option is needed.

There is **no pass with optional mods**: `About.xml` declares `loadAfter` on Core and its two hard
dependencies and nothing else. There is **no incompatibility pass** either:
this mod declares no `incompatibleWith`, and neither the README nor the changelog claims anything
fails with it. Both of those change the day the mod declares an optional mod or an
incompatibility, and `TESTING.md` says so where a reader will meet it.

The second pass is a language pass, not a second mod set. No step in this suite spells an English
label — every one names a defName, a need def or a thought def — so the same features run
unchanged in French, and the two passes differ only in what `04-review-capture.feature` shows.

## The step assembly, and why there is one

`Source/` builds `DrumBathHygiene.PickleSteps.dll` into `Mod/Pickle/Assemblies/`.

It exists because Pickle ships `{string} needs {string} is below {int} percent` and **no matching
"is above"**. This mod's whole job is to make a gauge go up, so its central assertion has no
built-in form, and a plausible-looking invention would be an undefined step and a wasted run. The
rest of the assembly is fixtures the built-ins cannot build — a stuffed drum spawned with its fire
lit or out, a named animal — and readings they cannot take.

Every step text starts with `Drum Bath Hygiene:`. Pickle loads the steps of every active suite into
one namespace, and two suites declaring the same text make healthy scenarios fail with "Ambiguous
step". No step text uses parentheses or slashes, which Cucumber expressions read as optional text
and alternatives; cells are spelled `x=.. z=..`.

**It references no Dubs Bad Hygiene type.** Hygiene is found by its defName and read through
`Need.CurLevel`; carried filth through `Pawn_FilthTracker.CarriedFilthListForReading`. Both are
vanilla and public. So a DBH rework degrades the scenarios the way it degrades the mod, instead of
stopping the suite from loading at all.

```powershell
dotnet build Tests/Pickle/Source/DrumBathHygiene.PickleSteps.csproj -c Release
```

Step DLLs are read at game start: a report produced without restarting after a rebuild does not
test what was just changed.

## What is deliberately not here

- **The bathroom thought.** `ApplyBathroomThought` grades the room the fixture stands in, and the
  stage it picks is Dubs Bad Hygiene's judgement of impressiveness. A scenario naming a stage would
  assert DBH's room rules rather than this bridge's one call, and would need a built, roofed,
  scored room the fixture does not provide. It stays in `_tools/FUNCTIONAL-SCENARIOS.md`,
  scenario 4.
- **Running without Dubs Bad Hygiene, and without the drum bath mod** — scenarios 10 and 11 of the
  prose file. Both are declared hard dependencies, and `stage-pickle-wsl.sh` stages every hard
  dependency on every pass. The harness cannot build the modlist these two need, so they stay
  where a person can set them up by hand.
- **Removing the mod from a save in progress**, prose scenario 12. A run cannot change its own
  modlist.
- **Anything `_tools/Test-Mod.ps1` already proves.** A scenario that restates an offline check
  costs a machine and buys nothing.

## Setup, once

1. Subscribe to Pickle, and enable it.
2. Link the companion mod into RimWorld's `Mods` folder. A junction needs no elevation:

   ```powershell
   New-Item -ItemType Junction -Path "C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Mods\DrumBathHygienePickleTests" -Target "<repo>\Tests\Pickle\Mod"
   ```

3. Enable it below Drum Bath Hygiene and Pickle.

The WSL harness does all of this itself; the junction is only for running the suite by hand on the
Windows install, which a session never does.

## Running

Through `scripts/Run-PickleWsl.ps1` in the rimworld folder, and through nothing else: it takes the
machine lock, archives the previous report, stages, launches under `xvfb-run`, and releases the
lock in a `finally`. `powershell.exe`, never `pwsh` — PowerShell 7 is not installed on this
machine.

**A session never starts the Windows RimWorld**, in any form. One machine, one game, one runner.
Before reading any report, read `exitReason`: a run killed in flight leaves a `summary.json` that
looks like a result. Before reading the numbers, compare scenarios played against features
discovered: `-pickle-include-wip` has been seen to truncate a run to its first feature and report
`passed`.

## Status

**First run, 2026-09-21, English, `sans-facultatifs`: 11 of 11 scenarios played, 8 passed, 3 failed,
`exitReason: failed`.** None of the three was a defect of the mod, and each taught the suite
something:

| Failed scenario | Cause | Fix |
| --- | --- | --- |
| an animal in the bath | Pickle's own `is given hediff` finds pawns by nickname among colonists, so it could not find a muffalo | a step of this suite, `is given the bathing hediff` |
| a burning drum makes the water hot | **my assumption about Dubs Bad Hygiene was wrong.** `WaterTempCheck` grants `HotBath` only to a pawn with hypothermia; warm water on a healthy pawn grants nothing | the pair is now played twice, on a healthy and on a chilled colonist, with a positive assertion on both sides |
| a drum that burnt out makes the water cold | I named the memory `ColdBath`; DBH's is `ColdWater`. The report showed `ColdWater (-3)` on the pawn, so the mod did what it should | the right name |

The run also showed a capture of a colonist standing **beside** the drum, info panel reading
"Washing.", with the scenario green — the `@review` trap in person. Free colonists at low hygiene get
a job of their own from DBH, so every `given` scenario now drafts its pawn (control included), and the
capture asks the game for a real bath and asserts it is under way before shooting.

Three scenarios now go through the drum mod's own job, which the first run did not: an end-to-end
wash, and the chilled pair in a burning and a burnt-out drum. They are the only ones that can see the
component's drum lookup miss under a pawn the real driver placed — in which case `cold` defaults to
`true` and hot water never happens.

**Second run, same day: 16 of 16 played, 12 passed, 4 failed, `exitReason: failed`.** The four
scenarios that stayed on the teleport path all passed, including the chilled pair — which confirms
the reading of Dubs Bad Hygiene above. The four that failed were all new, and all came from the
suite meeting the drum mod's real behaviour:

| Failed scenario | Cause |
| --- | --- |
| an animal in the bath | still given the hediff by hand. The stack said `DrumBath_Harmony.PawnRenderer_RenderPawnAt.Prefix`: **the drum mod's own render patch** reads `pawn.CurJob.targetA` as soon as the hediff is present and finds no job. Not this mod. And not an impossible state either: the drum mod ships a `CompDrumBathAnimalJobManager`, animals really do bathe |
| the end-to-end wash, and the chilled pair through the real job | **cause first guessed wrong, see the third run.** I read "the bath ended at once" - a test colonist arrives with joy full and the driver ends the job through `JoyUtility.JoyTickCheckEnd` - and set joy low. That is a real property of the driver and the setting stays, but it was not what failed here |

Changed in response: joy is set low before a real bath, the animal goes through the real job, the
chilled colonist gets a hypothermia of chosen severity (the driver adjusts it every tick), and the
capture and the end-to-end scenario assert the bath a second time after the wait.

**Third run, same day: 16 of 16 played, 13 passed, 3 failed, `exitReason: failed`.** The animal and the
capture passed; the three real-job scenarios failed exactly as before, on the step right after "is
bathing". That was the tell. The whole scenario had lasted 9.9 seconds in the game log, with no
warning about a job: nothing had waited for anything. **`is bathing` was a `void` step calling
`ctx.AssertEventually(...)` and discarding its result.** That method returns a `Task` - "faulted with
the described failure when it never does" - so it was never awaited: the step returned at once,
never waited, and could never fail. Every use of it was vacuous, the capture's second assertion
included: the capture was green a third time over an image of a colonist far from the drum reading
"Washing.". The step is now `async Task` with `await ctx.WaitUntil(...)` and a real assertion, the
pattern AnimaSong uses. Its failure message names the colonist's actual job and hediffs, so if the bath
really never starts (unreachable drum, refused reservation) the report says what happened instead of
guessing.

**The suite as it stands now has not been run.** `STATUS.md` carries the execution as `unverified`,
and it belongs to `done -> tested`.
