# Attribution

No third-party code is reused in this mod. It contains no textures, no defs and no content of
its own: it is a bridge, and everything it does is done by calling into two other mods.

## MMDrumcanMOD (Continued), by Mlie

https://steamcommunity.com/sharedfiles/filedetails/?id=3417093756

The drum bath itself belongs to that mod. This one only reads two of its identifiers:

- the hediff `Hed_BathingAtDrumBathPassive`, applied for the whole length of a bath and removed
  on the way out, which is used here as the marker for "this pawn is soaking";
- the building defName `DrumBath`, looked up on the pawn's own cell to reach its
  `CompRefuelable` and tell hot water from cold.

Its defs were read to find those two names, and its bath driver was read to establish that
hooking onto the hediff was the sound way in — its `tickAction` is a lambda locked inside an
iterator, which no patch should be aimed at. **No file from that mod is copied or shipped
here**, and the patch is conditional on the hediff existing rather than on the mod being
installed, so a rename, a local copy or the `_steam` suffix all keep working.

## Dubs Bad Hygiene, by Dubwise

https://steamcommunity.com/sharedfiles/filedetails/?id=836308268

Everything a bath is supposed to do is handed over to DBH, through reflection only
(`Source/DbhBridge.cs`):

| Member | What it is used for |
| --- | --- |
| `Need_Hygiene.clean(float)` | filling the hygiene need while soaking |
| `PrivacyUtil.BathingPrivacyLOS(Pawn, float)` | onlookers reacting to the sight |
| `SanitationUtil.WaterTempCheck(Pawn, bool, bool)` | the hot-bath or cold-bath thought |
| `SanitationUtil.ApplyBathroomThought(Pawn, Thing)` | the room's own bathroom thought |
| `DubDef.SoakingWet` | clearing the "soaking wet" memory on entering the bath |

These members are internal to DBH. Reflection is deliberate, and for two reasons: a hard
reference would make DBH a hard dependency, when this mod is meant to sit inert without it; and
it would break outright the first time their author reworks any of them, where reflection only
degrades. If a member cannot be resolved, the bridge reports it once in the log and the
component does nothing.

**No file from that mod is copied or shipped here.** The behaviour reproduced is the one a DBH
bath already produces — this mod only makes the drum bath ask for it.

## Everything else

- The mod's own code (`Source/`) is written from scratch, with Claude Code (Anthropic).
- The Workshop preview and the mod icon were generated with DALL-E (OpenAI), under human
  direction. The original of the preview is kept in `Art/`, outside the published folder.
- No Harmony patch: the component is grafted on by XML (`Mod/Patches/AddComp.xml`).
- RimWorld 1.6. Reference assemblies come from NuGet (`Krafs.Rimworld.Ref`), which is why no
  RimWorld installation is needed to build.

**Licence:** MIT (`LICENSE`).
