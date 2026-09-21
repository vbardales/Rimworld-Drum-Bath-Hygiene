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
        public const string BathHediff = "Hed_BathingAtDrumBathPassive";
        public const string BathJob = "Job_BathingAtDrumBath";
        public const string DrumDef = "DrumBath";
        public const string HygieneNeed = "Hygiene";

        /// <summary>
        /// Hygiene levels remembered by "I remember ... hygiene", keyed by the name the scenario
        /// uses. A plain dictionary rather than the scenario bag: two pawns are remembered at once
        /// in the control scenario, and each overwrite is meant to be the latest reading.
        /// </summary>
        private static readonly Dictionary<string, float> Remembered = new Dictionary<string, float>();

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
            ctx.Assert(found != null,
                $"no spawned pawn named \"{name}\"; the map holds: "
                + string.Join(", ", spawned.Select(p => p.LabelShort)));
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
            ctx.Assert(drum != null,
                $"no {DrumDef} at x={x} z={z}; the cell holds: "
                + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
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
            bool Bathing() => pawn.CurJob != null
                && pawn.CurJob.def.defName == BathJob
                && pawn.CurJob.targetA.Thing == drum
                && pawn.health.hediffSet.hediffs.Any(h => h.def.defName == BathHediff);

            await ctx.WaitUntil(Bathing, 90f);
            ctx.Assert(Bathing(),
                $"{name} is not bathing in the drum: job {pawn.CurJob?.def.defName ?? "none"}, "
                + "hediffs: " + string.Join(", ",
                    pawn.health.hediffSet.hediffs.Select(h => h.def.defName)));
        }

        /// <summary>
        /// Joy pulled low, on any pawn by the name a scenario gave it and quietly ignored if the pawn
        /// has no such need. NOT optional before ordering a REAL bath: the drum mod's driver ends the job
        /// through JoyUtility.JoyTickCheckEnd the moment joy is full, and a test colonist arrives with
        /// it full. The hediff is removed with the job, so a bath that ends at once leaves the
        /// component with no first tick at all - no memory, no hygiene, nothing - and the scenario
        /// reads as a defect of the mod when it is a bath that never lasted. The first run of the
        /// real-job scenarios, 2026-09-21, failed exactly so, three times.
        /// </summary>
        [Given("Drum Bath Hygiene: {string} is bored")]
        public void Bored(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Need joy = pawn.needs?.AllNeeds.FirstOrDefault(n => n.def.defName == "Joy");
            if (joy != null) joy.CurLevelPercentage = 0.1f;
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
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail("Hypothermia");
            ctx.Require(def != null, "no HediffDef \"Hypothermia\" in this game");
            Hediff hediff = HediffMaker.MakeHediff(def, pawn);
            hediff.Severity = severity;
            pawn.health.AddHediff(hediff);
            ctx.Assert(pawn.health.hediffSet.HasHediff(def), $"{name} is not chilled after being given Hypothermia");
        }

        /// <summary>
        /// A muffalo, named so a scenario can refer to it. It is here for one reason: Dubs Bad
        /// Hygiene gives animals no hygiene need, so an animal in the bath is the live case for the
        /// component's quietest branch - `ResolveCleanAction` returning null and staying null.
        /// </summary>
        [Given("Drum Bath Hygiene: an animal {string} stands at x={int} z={int}")]
        public void SpawnAnimal(PickleContext ctx, string name, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"x={x} z={z} is off the map");

            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail("Muffalo");
            ctx.Require(kind != null, "no PawnKindDef \"Muffalo\" in this game");

            Pawn animal = PawnGenerator.GeneratePawn(kind, Faction.OfPlayer);
            animal.Name = new NameSingle(name);
            GenSpawn.Spawn(animal, cell, map);
            ctx.Assert(animal.Spawned, $"{name} did not spawn at x={x} z={z}");
        }

        [Given("Drum Bath Hygiene: {string} is carrying filth")]
        public void GiveFilth(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Require(pawn.filth != null, $"{name} has no filth tracker");

            ThingDef dirt = DefDatabase<ThingDef>.GetNamedSilentFail("Filth_Dirt");
            ctx.Require(dirt != null, "no ThingDef \"Filth_Dirt\" in this game");

            pawn.filth.GainFilth(dirt);
            ctx.Assert(pawn.filth.CarriedFilthListForReading.Count > 0,
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

        [Then("Drum Bath Hygiene: {string} hygiene is below {float}")]
        public void HygieneBelow(PickleContext ctx, string name, float level)
        {
            float now = RequireHygiene(ctx, PawnNamed(ctx, name), name).CurLevel;
            ctx.Assert(now < level, $"{name} hygiene is {now:0.###}, not below {level:0.###}");
        }

        [Then("Drum Bath Hygiene: {string} has a hygiene need")]
        public void HasHygiene(PickleContext ctx, string name)
        {
            RequireHygiene(ctx, PawnNamed(ctx, name), name);
        }

        /// <summary>
        /// The precondition of the animal scenario, asserted rather than assumed: if a future Dubs
        /// Bad Hygiene gives animals the need, that scenario stops being about the null branch and
        /// has to be rewritten. This line is what says so.
        /// </summary>
        [Then("Drum Bath Hygiene: {string} has no hygiene need")]
        public void HasNoHygiene(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Assert(HygieneOf(pawn) == null,
                $"{name} does carry a \"{HygieneNeed}\" need, so this is no longer the case of a "
                + "pawn the mod has nothing to fill");
        }

        // ------------------------------------------------------------------ carried filth

        [Then("Drum Bath Hygiene: {string} carries no filth")]
        public void CarriesNoFilth(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Require(pawn.filth != null, $"{name} has no filth tracker");
            List<Filth> carried = pawn.filth.CarriedFilthListForReading;
            ctx.Assert(carried.Count == 0,
                $"{name} still carries {carried.Count} filth: "
                + string.Join(", ", carried.Select(f => f.def.defName)));
        }

        [Then("Drum Bath Hygiene: {string} carries filth")]
        public void CarriesFilth(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Require(pawn.filth != null, $"{name} has no filth tracker");
            ctx.Assert(pawn.filth.CarriedFilthListForReading.Count > 0,
                $"{name} carries no filth, so there is nothing for the bath to take off");
        }
    }
}
