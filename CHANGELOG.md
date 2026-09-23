# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it in game.

## [1.0.0] — unreleased

On release: create the `v1.0.0` tag and the matching GitHub release.

First version. RimWorld 1.6.

### Added

- Soaking in a drum can bath now fills the Dubs Bad Hygiene hygiene need, at a rate that fills an empty gauge over half a bath rather than turning it into a quick shower.
- Onlookers react to a colonist bathing, re-checked while the bath lasts, as with any DBH bathing.
- The water counts as hot or cold depending on whether the drum still has fuel burning.
- The room gives its usual DBH bathroom thought on entering the bath.
- The "soaking wet" memory is cleared, and so is the filth carried on the body when the colonist climbs out.

### Notes

- The mod adds no building, texture or def of its own: it is a bridge between MMDrumcanMOD (Continued) and Dubs Bad Hygiene, and does nothing without both.
- No Harmony patch. The component is grafted by XML onto the hediff the drum bath mod already applies while a pawn is soaking, and the patch is conditional on that hediff existing rather than on a mod identifier.
- The Dubs Bad Hygiene side is reached entirely by reflection, so a rework on their end degrades the mod instead of breaking it.
- The component saves two temporary values (`started` and `ticks`) on the bathing hediff. Adding the mod to an existing game and removing it outside or during a bath still require in-game validation.

## [0.1.0] — 2026-09-22

Prepublication: the first upload to the Steam Workshop, made to create the item and obtain its `PublishedFileId.txt`. Steam creates every new item private, and RimWorld never changes that.

### Added

- `Mod/About/PublishedFileId.txt`, holding the Workshop item ID `3806137182`, committed in `d7e1737`. Without it the next upload would create a second item.

### Notes

- The uploaded content is `Mod/` as it stood at `7b65a4f`. Nothing in `Mod/` has changed since apart from that file, and the DLL is the one built from `Source/` (SHA256 `865ACC8A…F017003`).
- The release of the features listed under 1.0.0 is still to come. The `tested` and `prepublished` states have not been reached: see `STATUS.md`.
