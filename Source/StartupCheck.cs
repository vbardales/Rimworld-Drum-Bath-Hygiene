using Verse;

namespace DrumBathHygiene
{
    // The mod hard-depends on MMDrumcanMOD only: Dubs Bad Hygiene and Dubs Bad Hygiene Lite replace each
    // other (Lite declares the full mod incompatible), so neither can be a hard dependency. With neither
    // installed the patch grafts a component that finds no BadHygiene assembly and stays inert, and the
    // mod silently does nothing. This check says so to the player, once, at startup.
    [StaticConstructorOnStartup]
    public static class StartupCheck
    {
        public const string FullPackageId = "Dubwise.DubsBadHygiene";
        public const string LitePackageId = "Dubwise.DubsBadHygiene.Lite";

        static StartupCheck()
        {
            if (IsLoaded(FullPackageId) || IsLoaded(LitePackageId)) return;

            string title = "DrumBathHygiene_NoDbhTitle".Translate();
            string text = "DrumBathHygiene_NoDbhText".Translate();
            Log.Error("[DrumBathHygiene] Neither Dubs Bad Hygiene (Workshop 836308268) nor Dubs Bad Hygiene Lite " +
                      "(Workshop 2570319432) is active: this mod does nothing without one of them.");
            DelayedErrorWindowRequest.Add(text, title);
        }

        // A local copy of a Workshop mod takes the "_steam" suffix on its package id.
        private static bool IsLoaded(string packageId)
        {
            return ModsConfig.IsActive(packageId) || ModsConfig.IsActive(packageId + "_steam");
        }
    }
}
