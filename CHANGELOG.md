# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it in game.

## [1.0.0] — unreleased

On release: create the `v1.0.0` tag and the matching GitHub release.

First version. RimWorld 1.6.

### Added

- Soaking in a drum can bath now fills the Dubs Bad Hygiene hygiene need, at a rate that empties a full gauge over half a bath rather than turning it into a quick shower.
- Onlookers react to a colonist bathing, re-checked while the bath lasts, as with any DBH bathing.
- The water counts as hot or cold depending on whether the drum still has fuel burning.
- The room gives its usual DBH bathroom thought on entering the bath.
- The "soaking wet" memory is cleared, and so is the filth carried on the body when the colonist climbs out.

### Notes

- The mod adds no building, texture or def of its own: it is a bridge between MMDrumcanMOD (Continued) and Dubs Bad Hygiene, and does nothing without both.
- No Harmony patch. The component is grafted by XML onto the hediff the drum bath mod already applies while a pawn is soaking, and the patch is conditional on that hediff existing rather than on a mod identifier.
- The Dubs Bad Hygiene side is reached entirely by reflection, so a rework on their end degrades the mod instead of breaking it.
- No data is added to the save: the mod can be added to or removed from an ongoing game.
