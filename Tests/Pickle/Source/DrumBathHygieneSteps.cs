using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace DrumBathHygiene.PickleSteps
{
    /// <summary>
    /// The handful of things Pickle's own steps cannot say about this mod.
    ///
    /// Every step text starts with "Drum Bath Hygiene:". Pickle loads the steps of every active
    /// suite into one namespace, and two suites declaring the same text make healthy scenarios
    /// fail with "Ambiguous step". No text here uses parentheses or slashes either, which Cucumber
    /// expressions read as optional text and alternatives: cells are spelled x=.. z=...
    ///
    /// WHY THERE IS AN ASSEMBLY AT ALL. Pickle ships `{string} needs {string} is below {int}
    /// percent` and no matching "is above". This mod exists to make a gauge go UP, so its central
    /// assertion has no built-in form, and inventing one would cost a whole run on an undefined
    /// step. Everything else below is here for the same reason: a fixture the built-ins cannot
    /// build, or a reading they cannot take.
    ///
    /// NOTHING HERE REFERENCES DUBS BAD HYGIENE. The hygiene need is found by its defName and read
    /// through `Need.CurLevel`, which is vanilla and public; carried filth is read through
    /// `Pawn_FilthTracker.CarriedFilthListForReading`, likewise. So this assembly compiles against
    /// the game alone, and a DBH rework degrades the scenarios the same way it degrades the mod,
    /// instead of failing to load the test suite.
    /// </summary>
    [PickleSteps]
    public class DrumBathHygieneSteps
    {
        private const string BathHediff = "Hed_BathingAtDrumBathPassive";
        private const string BathJob = "Job_BathingAtDrumBath";
        private const string DrumDef = "DrumBath";
        private const string HygieneNeed = "Hygiene";
        private const string JoyNeed = "Joy";
        private const string HypothermiaHediff = "Hypothermia";
        private const string DirtFilth = "Filth_Dirt";

        /// <summary>
        /// Hygiene levels remembered by "I remember ... hygiene", keyed by the name the scenario
        /// uses. Static, because a step class is instantiated per call; and therefore cleared before
        /// every scenario by <see cref="ResetRemembered"/>. Pickle reloads the saved colony for each
        /// scenario, but a static in this assembly outlives the reload: without the reset, a scenario
        /// that asserted a rise without remembering first would compare against another scenario's
        /// reading of a pawn that no longer exists, and the "remember first" guard would never fire.
        /// </summary>
        private static readonly Dictionary<string, float> Remembered = new Dictionary<string, float>();

        /// <summary>
        /// What the world looked like the instant an order to bathe was given, keyed like
        /// <see cref="Remembered"/> and cleared with it: a bath job that ends inside `StartJob` (a failed
        /// pre-toil reservation does that) still lets `TryTakeOrderedJob` return true, so the order step
        /// passes and only the wait after it can tell, ninety seconds later, without knowing why.
        /// </summary>
        private static readonly Dictionary<string, string> OrderNotes = new Dictionary<string, string>();

        [BeforeScenario]
        public void ResetRemembered()
        {
            Remembered.Clear();
            OrderNotes.Clear();
        }

        /// <summary>
        /// Polls a condition once per rendered frame against a deadline in real seconds, and reports
        /// whether it held. The steps that wait use this rather than `ctx.WaitUntil`, which THROWS on
        /// timeout before any message of ours can run: catching that exception meant catching every
        /// exception, including a NullReferenceException thrown inside the condition and a scenario
        /// abort, and re-evaluating the same condition afterwards to report a bare failure with no
        /// trace. Here a timeout is an ordinary `false`, and anything the condition throws is a real
        /// failure that propagates as itself.
        /// </summary>
        private static async Task<bool> PollUntil(PickleContext ctx, System.Func<bool> condition, float seconds)
        {
            float deadline = UnityEngine.Time.realtimeSinceStartup + seconds;
            while (!condition())
            {
                if (UnityEngine.Time.realtimeSinceStartup >= deadline) return false;
                await ctx.WaitFrames(1);
            }
            return true;
        }

        private static bool HasBathHediff(Pawn pawn)
        {
            List<Hediff> hediffs = pawn.health.hediffSet.hediffs;
            for (var i = 0; i < hediffs.Count; i++)
            {
                if (hediffs[i].def.defName == BathHediff) return true;
            }
            return false;
        }

        private static string HediffNames(Pawn pawn)
        {
            return string.Join(", ", pawn.health.hediffSet.hediffs.Select(h => h.def.defName));
        }

        // ------------------------------------------------------------------ finding things

        private static Map CurrentMap(PickleContext ctx)
        {
            ctx.Require(Current.Game != null && Find.CurrentMap != null, "load a save first");
            return Find.CurrentMap;
        }

        /// <summary>
        /// A pawn by the name a scenario gave it. Colonists made by Pickle carry a NameTriple and
        /// answer to their nickname; the animals below are given a NameSingle. Both are matched,
        /// and so is the label, so a scenario never has to know which kind of name it holds.
        /// </summary>
        private static Pawn PawnNamed(PickleContext ctx, string name)
        {
            IReadOnlyList<Pawn> spawned = CurrentMap(ctx).mapPawns.AllPawnsSpawned;
            Pawn found = spawned.FirstOrDefault(p =>
                (p.Name is NameTriple triple && triple.Nick == name)
                || (p.Name is NameSingle single && single.Name == name)
                || p.LabelShort == name);
            // The message lists every pawn on the map: built only when the lookup failed, not on
            // every step that resolves a name.
            if (found == null)
            {
                ctx.Assert(false,
                    $"no spawned pawn named \"{name}\"; the map holds: "
                    + string.Join(", ", spawned.Select(p => p.LabelShort)));
            }
            return found;
        }

        private static Need HygieneOf(Pawn pawn)
        {
            if (pawn.needs == null) return null;
            List<Need> needs = pawn.needs.AllNeeds;
            for (var i = 0; i < needs.Count; i++)
            {
                if (needs[i].def.defName == HygieneNeed) return needs[i];
            }
            return null;
        }

        private static Need RequireHygiene(PickleContext ctx, Pawn pawn, string name)
        {
            Need need = HygieneOf(pawn);
            ctx.Assert(need != null,
                $"{name} has no \"{HygieneNeed}\" need. Either Dubs Bad Hygiene is out of the "
                + "modlist, or this pawn is not the kind it gives the need to.");
            return need;
        }

        private static Thing DrumAt(PickleContext ctx, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"x={x} z={z} is off the map");
            Thing drum = cell.GetThingList(map).FirstOrDefault(t => t.def.defName == DrumDef);
            if (drum == null)
            {
                ctx.Assert(false,
                    $"no {DrumDef} at x={x} z={z}; the cell holds: "
                    + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            }
            return drum;
        }

        private static CompRefuelable FireAt(PickleContext ctx, int x, int z)
        {
            Thing drum = DrumAt(ctx, x, z);
            CompRefuelable fire = drum.TryGetComp<CompRefuelable>();
            ctx.Assert(fire != null,
                "the drum carries no CompRefuelable, so nothing here can say whether it burns. "
                + "The mod reads that comp to decide hot water from cold.");
            return fire;
        }

        // ------------------------------------------------------------------ the fixture

        /// <summary>
        /// A drum bath, built rather than ordered: a scenario that waited for a colonist to build
        /// one would be testing the construction system. Steel because the def is stuffed and a
        /// stuffless spawn throws; the material changes nothing this suite looks at.
        ///
        /// It arrives burning, as a freshly built one does - the def declares
        /// initialFuelPercent 1 - so "is burning" below is a statement of intent rather than a
        /// correction, and "has burnt out" is the only branch that has to change anything.
        /// </summary>
        [Given("Drum Bath Hygiene: a drum bath stands at x={int} z={int}")]
        public void SpawnDrum(PickleContext ctx, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"x={x} z={z} is off the map");

            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(DrumDef);
            ctx.Assert(def != null,
                $"no ThingDef \"{DrumDef}\": MMDrumcanMOD is out of the modlist, and without it "
                + "this mod patches nothing at all.");

            Thing drum = ThingMaker.MakeThing(def, ThingDefOf.Steel);
            GenSpawn.Spawn(drum, cell, map);
            ctx.Assert(drum.Spawned, $"the drum did not spawn at x={x} z={z}");
        }

        [Given("Drum Bath Hygiene: the drum at x={int} z={int} is burning")]
        public void LightDrum(PickleContext ctx, int x, int z)
        {
            CompRefuelable fire = FireAt(ctx, x, z);
            fire.Refuel(fire.Props.fuelCapacity);
            ctx.Assert(fire.HasFuel, "the drum still reads empty after being refuelled");
        }

        [Given("Drum Bath Hygiene: the drum at x={int} z={int} has burnt out")]
        public void DouseDrum(PickleContext ctx, int x, int z)
        {
            CompRefuelable fire = FireAt(ctx, x, z);
            fire.ConsumeFuel(fire.Fuel);
            ctx.Assert(!fire.HasFuel, $"the drum still holds {fire.Fuel} fuel after being emptied");
        }

        /// <summary>
        /// Puts the pawn on the drum's own cell, which is where the drum bath mod lays a bather
        /// down and therefore where this mod looks for the drum: it reads the thing list under the
        /// pawn's feet. Teleporting rather than ordering is deliberate - a walk would make every
        /// scenario below depend on pathing, reservations and the joy giver's own fuel threshold,
        /// none of which this mod touches.
        /// </summary>
        [When("Drum Bath Hygiene: {string} climbs into the drum at x={int} z={int}")]
        public void ClimbIn(PickleContext ctx, string name, int x, int z)
        {
            Thing drum = DrumAt(ctx, x, z);
            Pawn pawn = PawnNamed(ctx, name);
            pawn.Position = drum.Position;
            pawn.Notify_Teleported();
            ctx.Assert(pawn.Position.GetThingList(pawn.Map).Contains(drum),
                $"{name} is not standing on the drum after being moved onto it");
        }

        /// <summary>
        /// The REAL bath: the drum bath mod's own job, ordered the way a player's right-click
        /// would, so the drum mod's driver walks the pawn over, places them, and applies the
        /// hediff itself. Nothing else in this suite goes through it, and that is the point of
        /// this step.
        ///
        /// Why the teleport is not enough. The component finds the drum by looking at the things
        /// under the pawn's feet, and answers "cold" when it finds none. A pawn teleported onto
        /// the drum's origin cell is under those feet by construction. A pawn placed by the real
        /// driver is wherever the drum mod puts a bather, which is a different question - and if
        /// the answer were "a cell the lookup misses", every real bath would be judged cold, hot
        /// water would never happen, and no teleport could see it.
        ///
        /// The bath driver never reads the fuel, so this reaches a COLD bath on purpose too,
        /// which the joy giver's ten-per-cent threshold makes unreachable by play.
        /// </summary>
        [When("Drum Bath Hygiene: {string} is ordered to bathe in the drum at x={int} z={int}")]
        public void OrderBath(PickleContext ctx, string name, int x, int z)
        {
            Thing drum = DrumAt(ctx, x, z);
            Pawn pawn = PawnNamed(ctx, name);
            JobDef def = DefDatabase<JobDef>.GetNamedSilentFail(BathJob);
            ctx.Assert(def != null,
                $"no JobDef \"{BathJob}\": MMDrumcanMOD is out of the modlist, or renamed its job");

            Job job = JobMaker.MakeJob(def, drum);
            bool taken = pawn.jobs.TryTakeOrderedJob(job, JobTag.Misc);
            var holders = pawn.Map.reservationManager.ReservationsReadOnly
                .Where(r => r.Target.Thing == drum)
                .Select(r => $"{r.Claimant?.LabelShort ?? "?"} ({r.Job?.def.defName ?? "no job"})");
            OrderNotes[name] = $"Right after the order: job {pawn.CurJob?.def.defName ?? "none"}, "
                + $"the drum can be reserved by {name}: {pawn.CanReserve(drum)}, "
                + $"reserved by [{string.Join(", ", holders)}]";
            ctx.Assert(taken,
                $"{name} refused the order to bathe in the drum at x={x} z={z}. Current job: "
                + (pawn.CurJob?.def.defName ?? "none"));
        }

        /// <summary>
        /// Waits for the bath to be under way, as the drum mod sees it: the job is running AND the
        /// hediff is on the pawn. Both, because the hediff is what this mod hangs its component on,
        /// and a pawn who merely walks toward the drum has neither.
        ///
        /// AN `async Task`, AND THE `await` IS THE STEP. This was first written as a `void` calling
        /// `ctx.AssertEventually(...)` and discarding what it returned. That method returns a Task -
        /// its own documentation says "completes once the condition holds, faulted with the described
        /// failure when it never does" - so nothing was ever awaited: the step returned at once, never
        /// waited, and never failed. Every scenario that used it ran its next step on the same frame,
        /// before the colonist had taken a single step toward the drum, and the capture was green over
        /// an image of a colonist nowhere near it. Three runs in a row, 2026-09-21, before the log
        /// showed the whole scenario lasting 9.9 seconds.
        /// </summary>
        [Then("Drum Bath Hygiene: {string} is bathing in the drum at x={int} z={int}")]
        public async Task IsBathing(PickleContext ctx, string name, int x, int z)
        {
            Thing drum = DrumAt(ctx, x, z);
            Pawn pawn = PawnNamed(ctx, name);

            // THE COMPONENT'S OWN QUESTION: is the drum among the things on the pawn's cell? That is
            // exactly what `FindBath` reads to decide hot water from cold, and the real-path scenarios
            // exist to prove it holds for a pawn the drum mod's driver placed. The first version asked
            // `CurJob.targetA.Thing == drum`, which the driver rewrites once it has the pawn; the second
            // used a radius of 2.5 cells, which also accepts a pawn standing BESIDE the drum, where the
            // lookup would miss and `cold` would silently default to true.
            bool Bathing() => pawn.CurJob != null
                && pawn.CurJob.def.defName == BathJob
                && pawn.Position.GetThingList(pawn.Map).Contains(drum)
                && HasBathHediff(pawn);

            // A TRACE, because a timeout says nothing and each run costs a ticket in a queue of other
            // sessions: whether the colonist never set off, was sent elsewhere, or reached the drum and
            // left it was unrecoverable from a bare "timed out". Every CHANGE of job is noted with where
            // the colonist stood and whether the hediff was on them. The comparison is made on the two
            // things that change, and the string is only built when one of them did.
            var trace = new List<string>();
            JobDef lastJob = null;
            bool lastHediff = false;
            bool first = true;
            float t0 = UnityEngine.Time.realtimeSinceStartup;
            bool Sample()
            {
                JobDef job = pawn.CurJob?.def;
                bool hediff = HasBathHediff(pawn);
                if (first || job != lastJob || hediff != lastHediff)
                {
                    LocalTargetInfo target = pawn.CurJob?.targetA ?? LocalTargetInfo.Invalid;
                    string aim = target.HasThing ? target.Thing.def.defName
                        + (target.Thing == drum ? "(the drum)" : "") : target.Cell.IsValid ? "a cell" : "-";
                    trace.Add($"+{UnityEngine.Time.realtimeSinceStartup - t0:0.0}s "
                        + $"{job?.defName ?? "none"}{(hediff ? "+hediff" : "")} at "
                        + $"({pawn.Position.x},{pawn.Position.z}) target {aim}");
                    lastJob = job;
                    lastHediff = hediff;
                    first = false;
                }
                return Bathing();
            }

            const float seconds = 90f;
            if (await PollUntil(ctx, Sample, seconds)) return;

            bool reachable = pawn.Spawned && drum.Spawned
                && pawn.CanReach(drum, Verse.AI.PathEndMode.Touch, Danger.Deadly);
            Need joy = pawn.needs?.AllNeeds.FirstOrDefault(n => n.def.defName == JoyNeed);
            ctx.Assert(false,
                $"{name} is not bathing in the drum at x={x} z={z} after {seconds:0} seconds. "
                + $"Now: job {pawn.CurJob?.def.defName ?? "none"} "
                + $"(driver {pawn.jobs?.curDriver?.GetType().Name ?? "none"}), "
                + $"at ({pawn.Position.x},{pawn.Position.z}), drum at ({drum.Position.x},{drum.Position.z}), "
                + $"reachable {reachable}, drafted {pawn.Drafted}, downed {pawn.Downed}, "
                + $"mental state {(pawn.InMentalState ? "yes" : "no")}, "
                + $"hediffs [{HediffNames(pawn)}], joy {(joy != null ? joy.CurLevelPercentage.ToString("0.00") : "n/a")}. "
                + (OrderNotes.TryGetValue(name, out string note) ? note + ". " : "")
                + "Job trace: " + (trace.Count == 0 ? "(nothing sampled)" : string.Join(" | ", trace)));
        }

        /// <summary>
        /// Hypothermia at a severity the scenario chooses, because Pickle's own hediff step gives it
        /// whatever the def starts at, and the drum mod's bath driver adjusts Hypothermia's severity
        /// on every tick of the bath: a hediff that starts near zero can be gone before the
        /// component's first tick, and Dubs Bad Hygiene then sees a healthy pawn and grants no
        /// hot-bath memory at all.
        /// </summary>
        [Given("Drum Bath Hygiene: {string} is chilled to severity {float}")]
        public void Chilled(PickleContext ctx, string name, float severity)
        {
            Pawn pawn = PawnNamed(ctx, name);
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail(HypothermiaHediff);
            ctx.Require(def != null, $"no HediffDef \"{HypothermiaHediff}\" in this game");
            Hediff hediff = HediffMaker.MakeHediff(def, pawn);
            hediff.Severity = severity;
            pawn.health.AddHediff(hediff);
            ctx.Assert(pawn.health.hediffSet.HasHediff(def), $"{name} is not chilled after being given Hypothermia");
        }

        /// <summary>
        /// Takes the hygiene need off a colonist, so the component meets a pawn it has nothing to
        /// fill: `ResolveCleanAction` returns null and has to stay null for the whole bath.
        ///
        /// This replaced an animal. The drum mod does bathe animals, but through its own component
        /// (CompDrumBathAnimalJobManager) and not through an ordered job: the fifth run ordered a
        /// muffalo into the drum and its job trace shows nothing but wandering, the order never taking.
        /// Reaching that path would mean driving the drum mod's gizmo, which is testing its code. The
        /// branch this mod owns is the missing need, and a colonist without one reaches it through the
        /// real job.
        /// </summary>
        [Given("Drum Bath Hygiene: {string} loses the hygiene need")]
        public void LoseHygiene(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Need need = HygieneOf(pawn);
            ctx.Require(need != null, $"{name} has no hygiene need to lose: Dubs Bad Hygiene is out of the modlist");
            pawn.needs.AllNeeds.Remove(need);
            ctx.Assert(HygieneOf(pawn) == null, $"{name} still has a hygiene need after losing it");
        }

        private static Pawn_FilthTracker FilthOf(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Require(pawn.filth != null, $"{name} has no filth tracker");
            return pawn.filth;
        }

        [Given("Drum Bath Hygiene: {string} is carrying filth")]
        public void GiveFilth(PickleContext ctx, string name)
        {
            Pawn_FilthTracker filth = FilthOf(ctx, name);

            ThingDef dirt = DefDatabase<ThingDef>.GetNamedSilentFail(DirtFilth);
            ctx.Require(dirt != null, $"no ThingDef \"{DirtFilth}\" in this game");

            filth.GainFilth(dirt);
            ctx.Assert(filth.CarriedFilthListForReading.Count > 0,
                $"{name} picked up no filth; the tracker still reads empty");
        }

        // ------------------------------------------------------------------ the component

        /// <summary>
        /// The patch, observed on the hediff the game actually built rather than on the document a
        /// headless run patched. `_tools/Test-Mod.ps1` proves the XPath and the payload over
        /// synthetic defs; whether the loaded hediff ends up carrying the component is decided by
        /// the real patch engine, in load order, with every other active mod's operations in the
        /// same document.
        /// </summary>
        [Then("Drum Bath Hygiene: the bathing hediff of {string} carries the component")]
        public void HediffCarriesComp(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Hediff hediff = pawn.health?.hediffSet?.hediffs
                .FirstOrDefault(h => h.def.defName == BathHediff);
            ctx.Assert(hediff != null, $"{name} is not carrying \"{BathHediff}\"");

            var withComps = hediff as HediffWithComps;
            ctx.Assert(withComps != null,
                $"\"{BathHediff}\" loaded as {hediff.GetType().Name}, not HediffWithComps: the "
                + "first half of the patch did not take, so the component could not be added.");
            ctx.Assert(withComps.comps != null
                    && withComps.comps.Any(c => c is HediffComp_DrumBathHygiene),
                "the bathing hediff carries no HediffComp_DrumBathHygiene; it carries: "
                + string.Join(", ", (withComps.comps ?? new List<HediffComp>())
                    .Select(c => c.GetType().Name)));
        }

        // ------------------------------------------------------------------ the gauge

        [When("Drum Bath Hygiene: I remember {string} hygiene")]
        public void RememberHygiene(PickleContext ctx, string name)
        {
            Remembered[name] = RequireHygiene(ctx, PawnNamed(ctx, name), name).CurLevel;
        }

        /// <summary>
        /// The assertion the whole mod is for, and the one Pickle has no built-in form of: its
        /// catalogue offers "needs ... is below" and no "above".
        ///
        /// A margin, not a bare comparison. Dubs Bad Hygiene runs its own slow decay on this need
        /// the whole time, so a gauge that merely failed to fall would read as a rise on an exact
        /// test. 0.02 is forty ticks of the mod's own rate: far below anything a scenario here
        /// waits for, far above a few intervals of decay.
        /// </summary>
        [Then("Drum Bath Hygiene: {string} hygiene rose")]
        public void HygieneRose(PickleContext ctx, string name)
        {
            ctx.Assert(Remembered.ContainsKey(name),
                $"nothing remembered for {name}: use \"I remember {name} hygiene\" first");
            float before = Remembered[name];
            float now = RequireHygiene(ctx, PawnNamed(ctx, name), name).CurLevel;
            ctx.Assert(now > before + 0.02f,
                $"{name} hygiene went from {before:0.###} to {now:0.###}, which is not a rise");
        }

        /// <summary>
        /// The control. Not the negation of the step above: a gauge that fell is not a gauge that
        /// stood still, and this mod could only ever push it up. The window allows DBH's own decay
        /// downwards and nothing at all upwards.
        /// </summary>
        [Then("Drum Bath Hygiene: {string} hygiene did not rise")]
        public void HygieneDidNotRise(PickleContext ctx, string name)
        {
            ctx.Assert(Remembered.ContainsKey(name),
                $"nothing remembered for {name}: use \"I remember {name} hygiene\" first");
            float before = Remembered[name];
            float now = RequireHygiene(ctx, PawnNamed(ctx, name), name).CurLevel;
            ctx.Assert(now <= before + 0.02f,
                $"{name} hygiene rose from {before:0.###} to {now:0.###} with nothing to wash them");
        }

        [Then("Drum Bath Hygiene: {string} hygiene is above {float}")]
        public void HygieneAbove(PickleContext ctx, string name, float level)
        {
            float now = RequireHygiene(ctx, PawnNamed(ctx, name), name).CurLevel;
            ctx.Assert(now > level, $"{name} hygiene is {now:0.###}, not above {level:0.###}");
        }

        /// <summary>
        /// The precondition of the no-need scenario, asserted rather than assumed, and asserted AGAIN
        /// after the bath has run for a while: the need is taken off the pawn's list by hand, and
        /// the game could give it back (a need refresh) between the walk and the component's first
        /// tick, in which case the bath would wash and the null branch would never run while the
        /// scenario stayed green.
        /// </summary>
        [Then("Drum Bath Hygiene: {string} has no hygiene need")]
        public void HasNoHygiene(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Assert(HygieneOf(pawn) == null,
                $"{name} carries a \"{HygieneNeed}\" need, so this is not the case of a pawn the mod has "
                + "nothing to fill: the game gave it back, or Dubs Bad Hygiene now does");
        }

        // ------------------------------------------------------------------ carried filth

        [Then("Drum Bath Hygiene: {string} carries no filth")]
        public void CarriesNoFilth(PickleContext ctx, string name)
        {
            List<Filth> carried = FilthOf(ctx, name).CarriedFilthListForReading;
            ctx.Assert(carried.Count == 0,
                $"{name} still carries {carried.Count} filth: "
                + string.Join(", ", carried.Select(f => f.def.defName)));
        }

        [Then("Drum Bath Hygiene: {string} carries filth")]
        public void CarriesFilth(PickleContext ctx, string name)
        {
            ctx.Assert(FilthOf(ctx, name).CarriedFilthListForReading.Count > 0,
                $"{name} carries no filth, so there is nothing for the bath to take off");
        }

        // ------------------------------------------------------------------ onlookers

        /// <summary>
        /// Teleports a pawn to a cell some distance east of the drum, on the same row, and checks it
        /// lands inside the six cells the bridge asks Dubs Bad Hygiene to look over. East, because the
        /// drum is two cells long and the fixture around it is open ground on that side.
        /// </summary>
        [When("Drum Bath Hygiene: {string} stands {int} cells east of the drum at x={int} z={int}")]
        public void StandsEastOf(PickleContext ctx, string name, int cells, int x, int z)
        {
            Thing drum = DrumAt(ctx, x, z);
            Pawn pawn = PawnNamed(ctx, name);
            var cell = new IntVec3(x + cells, 0, z);
            ctx.Require(cell.InBounds(pawn.Map) && cell.Standable(pawn.Map),
                $"x={cell.x} z={cell.z} is not open ground: the cell holds "
                + string.Join(", ", cell.GetThingList(pawn.Map).Select(t => t.def.defName)));
            pawn.Position = cell;
            pawn.Notify_Teleported();
            ctx.Assert(pawn.Position.DistanceTo(drum.Position) <= 6f,
                $"{name} stands {pawn.Position.DistanceTo(drum.Position):0.#} cells from the drum, outside "
                + "the six the bridge asks Dubs Bad Hygiene to look over");
        }

        /// <summary>
        /// A precondition, and a loud one: no colonist other than the named one stands within the six
        /// cells the bridge asks Dubs Bad Hygiene to look over. Dubs Bad Hygiene gives the BATHER the
        /// privacy memory as soon as any opposite-gender human with a line of sight is in that radius,
        /// so a baseline of "nobody is watching" is only a baseline if nobody is. Drafting a pawn does
        /// not move it: this checks where everyone actually is, and reports who, so that a failure
        /// reads as a setup problem and not as a defect of the mod.
        /// </summary>
        [Given("Drum Bath Hygiene: no one but {string} stands within 6 cells of the drum at x={int} z={int}")]
        public void NoOneButNear(PickleContext ctx, string name, int x, int z)
        {
            Thing drum = DrumAt(ctx, x, z);
            Pawn allowed = PawnNamed(ctx, name);
            List<Pawn> near = CurrentMap(ctx).mapPawns.AllPawnsSpawned
                .Where(p => p != allowed && p.RaceProps.Humanlike && p.Position.DistanceTo(drum.Position) <= 6f)
                .ToList();
            ctx.Require(near.Count == 0,
                "the baseline needs an empty neighbourhood, but within six cells of the drum stand: "
                + string.Join(", ", near.Select(p => $"{p.LabelShort} at ({p.Position.x},{p.Position.z})")));
        }

        [Then("Drum Bath Hygiene: {string} has at least {int} memories of {string}")]
        public void HasMemories(PickleContext ctx, string name, int atLeast, string defName)
        {
            ThoughtDef def = DefDatabase<ThoughtDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThoughtDef \"{defName}\" in this game");
            Pawn pawn = PawnNamed(ctx, name);
            MemoryThoughtHandler memories = pawn.needs?.mood?.thoughts?.memories;
            ctx.Require(memories != null, $"{name} has no memory handler");
            int count = memories.NumMemoriesOfDef(def);
            ctx.Assert(count >= atLeast,
                $"{name} has {count} memories of {defName}, not at least {atLeast}; memories: "
                + string.Join(", ", memories.Memories.Select(m => m.def.defName)));
        }

        [When("Drum Bath Hygiene: {string} forgets {string}")]
        public void Forgets(PickleContext ctx, string name, string defName)
        {
            ThoughtDef def = DefDatabase<ThoughtDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThoughtDef \"{defName}\" in this game");
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Require(pawn.needs?.mood?.thoughts?.memories != null, $"{name} has no memory handler");
            pawn.needs.mood.thoughts.memories.RemoveMemoriesOfDef(def);
            ctx.Assert(pawn.needs.mood.thoughts.memories.NumMemoriesOfDef(def) == 0,
                $"{name} still remembers {defName}");
        }

        // ------------------------------------------------------------------ the end of a bath

        /// <summary>
        /// Waits for a real bath to be over: no bath job and no bathing hediff. A second bath can only
        /// be ordered once the first is, and it is the end of the first that removes the hediff the
        /// component hangs on - so this is also what lets a scenario prove the component starts afresh.
        /// A scenario that has finished with a bath sets the pawn's joy to full first, which ends the
        /// job on its next tick; without that the wait is as long as the drum mod's driver keeps a
        /// pawn, and a slow simulation would be blamed on the mod.
        /// </summary>
        [Then("Drum Bath Hygiene: {string} has climbed out of the drum")]
        public async Task ClimbedOut(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            bool Out() => !HasBathHediff(pawn)
                && (pawn.CurJob == null || pawn.CurJob.def.defName != BathJob);

            const float seconds = 120f;
            if (await PollUntil(ctx, Out, seconds)) return;

            ctx.Assert(false,
                $"{name} is still in the bath {seconds:0} seconds after the wait began: job "
                + $"{pawn.CurJob?.def.defName ?? "none"}, hediffs [{HediffNames(pawn)}]");
        }
    }
}
