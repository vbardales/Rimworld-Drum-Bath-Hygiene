# Drum Bath Hygiene

Makes the drum can bath actually wash people, by connecting **MMDrumcanMOD (Continued)** to
**Dubs Bad Hygiene**. RimWorld 1.6.

## What the mod does

On its own, soaking in a drum bath is pure recreation. It gives joy, a warm mood buff and a rest
bonus — and the colonist climbs out exactly as filthy as they got in, because the drum bath mod
knows nothing about DBH's hygiene need. This mod is the missing wire between the two.

While a colonist is in the bath:

- their hygiene need fills, at 0.0005 per tick — an empty gauge takes 2000 ticks, half the length
  of a bath (`joyDuration` 4000). They climb out clean without the bath becoming a quick shower;
- onlookers react to the sight, re-checked every 300 ticks, as with any DBH bathing;
- the water counts as hot or cold depending on whether the drum still has fuel burning, read from
  the building's own `CompRefuelable`;
- the room gives its usual DBH bathroom thought;
- the "soaking wet" memory is cleared — one climbs out of a bath wet by definition, and DBH does
  the same after its own baths;
- the filth carried on the body is cleared when the hediff is removed, again as DBH does.

It adds no building, no texture and no def of its own.

## How it hooks in

**Where.** The drum bath mod applies `Hed_BathingAtDrumBathPassive` for the whole length of a
bath and removes it on the way out. That is already an exact marker for "this pawn is in the
water", so the mod grafts a `HediffComp` onto it (`Mod/Patches/AddComp.xml`) rather than patching
the bath driver. The driver's `tickAction` is a lambda locked inside an iterator: a Harmony patch
aimed at it would break on the mod's first update. There is no Harmony patch here at all.

Two wrinkles the patch has to handle, and both are conditional rather than assumed:

- that hediff declares no `hediffClass`, so it defaults to plain `Hediff`, which cannot carry
  components — RimWorld refuses it with *"has comps but hediffClass is not HediffWithComps"*. Its
  twin `Hed_BathingAtDrumBath` does declare it; the author simply had no need for it here. What
  we want is an "add or replace", and RimWorld 1.6 has no `PatchOperationAddOrReplace`, so it is
  written as a `PatchOperationConditional` on the field itself;
- same for `<comps>`: append to the list if it exists, create it otherwise. A second `<comps>`
  node would not be merged.

The whole operation is guarded on the **hediff existing**, not on a mod identifier — so it
survives the `_steam` suffix, a rename, or a local copy of the drum bath mod.

**How.** Everything on the DBH side goes through `Source/DbhBridge.cs`, by reflection, resolved
once and cached. DBH is a soft dependency in practice: a hard reference would make the assembly
fail to load without it, and the members used (`SanitationUtil`, `PrivacyUtil`) are internal, so a
hard reference would also break the first time their author reworks them. If `Need_Hygiene.clean`
cannot be resolved, the bridge logs one warning and the component goes inert; every other call
guards itself separately.

Both mods are declared in `<modDependencies>`, so RimWorld flags a missing one in the mod list.
Nothing throws either way.

## Saves

The component stores two values (`started`, `ticks`) on a hediff that only exists while a pawn is
in the bath. Nothing persists beyond that, and the mod can be added to or removed from a game in
progress.

## Repository layout

```
Mod/       published to the Workshop; target of the junction into RimWorld/Mods
Source/    never published
Art/       full-size originals of the preview and icon; never published
.build/    build intermediates, ignored by git
```

The Workshop uploader sends the mod folder as it stands, with no filtering —
`SteamUGC.SetItemContent` takes the root directory and nothing else. Keeping the sources out of
`Mod/` is the only way not to publish them, and `Source/Directory.Build.props` keeps `obj/` out
too: without it, the publicised `Assembly-CSharp.dll` it contains — about 6 MB of Ludeon's own
code — would ship to every subscriber.

## Build

    dotnet build Source/DrumBathHygiene.csproj -c Release

The assembly lands in `Mod/Assemblies/`. Reference assemblies come from NuGet
(`Krafs.Rimworld.Ref`), so no RimWorld installation is needed to compile.

See `ATTRIBUTION.md` for what is borrowed and what is not, and `CHANGELOG.md` for the history.
