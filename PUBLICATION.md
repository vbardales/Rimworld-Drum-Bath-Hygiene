# Publication sheet

**Updated 2026-10-10. The mod is published: item `3806137182` public, 1.0.0 (2026-09-28), 1.0.1 (2026-10-02) and 1.0.2 (2026-10-08) sent by the CI, thanks to Mlie and Dubwise posted. This sheet is now the template for the next update.** The Steam description below is the source for the next version: its save sentence (removal tested) is not yet on the page nor in `About.xml`, and goes out with the next `update_description`.
This sheet holds what the Workshop page asks for and the repository holds nowhere else, so that it can be used again at
the next update and by whoever picks the mod up.

## Before an update

This is an update of an existing item (`../PUBLISHING.md`, "Publier par la CI"; `Rimworld-Release-Admin/docs/OPERATIONS.md`). The 1.0.0 preparation, the first change notes and the production steps of 1.0.0 are in `docs/runs/publication-history.md`.

- **Repository.** Working tree clean and pushed, the distributed DLL matches `Source/` (SHA256 `865ACC8A...`, rebuilt and compared 2026-10-10).
- **CHANGELOG.** The section of the version stays `## [Unreleased]` until the dry-run, then becomes `## [x.y.z] - date`. The tag and the GitHub release are made by the CI after a successful upload, never by hand.
- **Workflow.** `publish-tag.yml` and its scripts are written by `Rimworld-Release-Admin/scripts/generate-publish-workflow.sh` (keep every option, `--gallery-dir` included; `--check` first). Dry-run on the exact commit, then `dispatch-publish.sh <SHA> <version>`; only the owner approves `steam-production`. Any commit after the dry-run needs a new dry-run.
- **What the CI sends.** `Mod/` as it stands. Opt-in inputs, off unless the owner asks: `update_preview`, `update_description`, `update_title`, `update_tags`. The gallery images stay hand work on the Steam page.
- **Description.** The block under "Steam description" is the single source; `About.xml` is generated from it (`node .github/scripts/sync-about-description.mjs --write`).

## Steam description

*Historical: September 2026 (migration to the Markdown source).* **One source, decided by the owner on 2026-09-25** (`../PUBLISHING.md`; `Rimworld-Release-Admin/docs/OPERATIONS.md`,
"Changing where the Steam description comes from"): the description is written once, in Markdown, in the fenced block
below. The CI converts it to Steam BBCode and generates the plain-text `<description>` of `Mod/About/About.xml` from it
(`node .github/scripts/sync-about-description.mjs --write`), and every dry-run and publish stops if `About.xml` differs
from it. The block cannot contain a code fence, and its last line is the source link. Adopted on 2026-09-26, migrating
from the BBCode block sent since 2026-09-25 under the old heading "The description text": until the workflow is
regenerated with the options above, `About.xml` stays as it is, and the first `sync-about-description.mjs --write` after
regenerating rewrites its text (read the diff). The item being private, the dry-run cannot diff the converted text
against the page, so it is read by hand once. Every publish with `update_description` on overwrites the Steam page: a
later hand edit there would be lost, so this block stays the single source.

*Historical: September 2026.* What changed against the text of 0.1.0 (before the 2026-09-25 corrections, still readable in `git log -p -- Mod/About/About.xml`):

1. *"Nothing breaks if you load this without them … No error is thrown either way."* No run showed it and none can (a
   Pickle pass excludes only DLCs; RimWorld's handling of a missing dependency is not this mod's). Now: both mods are
   declared as dependencies, RimWorld flags a missing one, and the mod has no content of its own.
2. *"Adding it to an existing game and removing it … still require in-game validation."* A bath in progress goes on
   washing after a save and a reload (played and green, runs 10 and 11). Adding the mod to a save or removing it is the
   game's handling of its mod list and has not been played. Now said so.
3. **The test tools are thanked** (`../PUBLISHING.md`, "development only, never a dependency"): Pickle (`3791648678`),
   RimLogging (`3733484696`) and Nelim's PickleTools (`3806142401`, three of its packages are staged by the `tools` pass).
4. **Codex (OpenAI) is named in AI-GENERATED**, confirmed by the owner on 2026-09-25 as having contributed to the
   repository. The line "Claude Code (Anthropic) and DALL-E (OpenAI)." that used to close the old THANKS is gone:
   `../PUBLISHING.md` asks not to repeat in the thanks the tools already named in the AI mention.

One claim kept as it was: *"the room gives its usual bathroom thought"*. The call goes through without a warning, but the
thought itself is Dubs Bad Hygiene's grading of a room and no scenario asserts a stage (TESTING.md, scenario 4, not
applicable).

**This is a change to `Mod/`** (`About/About.xml`, the description only; no code, no asset): the payload of 1.0.0 is the
0.1.0 one plus `About/Preview.png`, the id file and this text.

```markdown
Makes the drum can bath actually wash people, by connecting [MMDrumcanMOD (Continued)](https://steamcommunity.com/sharedfiles/filedetails/?id=3417093756) to [Dubs Bad Hygiene](https://steamcommunity.com/sharedfiles/filedetails/?id=836308268).

On its own, soaking in a drum bath is pure recreation: it gives joy, a warm mood buff and a rest bonus, but a colonist climbs out exactly as filthy as when they got in. This bridges the two.

While a colonist is in the bath:

- their hygiene need fills,
- onlookers react to the sight, as with any DBH bathing,
- the water is judged hot or cold depending on whether fuel is still burning in the drum,
- the room gives its usual bathroom thought,
- the "soaking wet" memory is cleared, and so is the filth on their body when they climb out.

Both mods are declared as dependencies, so RimWorld will flag a missing one in the mod list. This mod has no content of its own and does nothing without both.

The mod stores two temporary values on the bathing hediff while a pawn is in the bath. A bath in progress continues washing after a save and reload. Removing the mod from an existing save has been tested; adding it to a save made without it has not been tested separately.

## IF I GO QUIET

If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

## AI-GENERATED

This mod's code was written with Claude Code (Anthropic) and Codex (OpenAI), and its images generated with DALL-E (OpenAI), under human direction, review and testing. Stated openly: designing with these tools is my job.

## THANKS

- [Mlie](https://steamcommunity.com/sharedfiles/filedetails/?id=3417093756), for keeping MMDrumcanMOD (Continued) alive, and [dragon](https://steamcommunity.com/sharedfiles/filedetails/?id=2100895553), who made the drum bath in the first place. The drum bath is theirs; this mod is nothing without it, and adds no content of its own.
- [Dubwise](https://steamcommunity.com/sharedfiles/filedetails/?id=836308268), for Dubs Bad Hygiene, to which this mod simply hands the bath over — the hygiene need, the privacy reactions, the water temperature and the bathroom thoughts are all theirs.
- [Pickle](https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678), [RimLogging](https://steamcommunity.com/sharedfiles/filedetails/?id=3733484696) and [Nelim's PickleTools](https://steamcommunity.com/sharedfiles/filedetails/?id=3806142401), used for the in-game tests: development tools, never a dependency of this mod.

No code from either mod is reused here. See ATTRIBUTION.md in the mod folder.

[Source code on GitHub](https://github.com/vbardales/Rimworld-Drum-Bath-Hygiene)
```

## Release notes (the change note of each upload)

The change note sent to Steam with an upload, which **starts with the version alone on its first line** (`[b]1.0.0[/b]`: the Workshop page does not show the version of a note that does not say it, `../PUBLISHING.md`), under the heading of its version: the manual workflow reads the block
under `### <version>` (`../PUBLISHING.md`, "Publier par la CI"), and the `## [<version>]` section of `CHANGELOG.md` goes
into the GitHub release.

### 1.0.2

```
[b]1.0.2[/b]
The description now links to the two mods this one requires and credits their authors. No change to how the mod plays.
```

## Dependencies and DLC

Checked in the sources on 2026-09-24, not from intention.

- **MMDrumcanMOD (Continued), Mlie, `Mlie.MMDrumcanMOD`, Workshop `3417093756`: hard, declared** in `modDependencies`
  with its Steam URL and in `loadAfter`. The patch grafts the component onto that mod's `Hed_BathingAtDrumBathPassive`
  and the code reads its `DrumBath` building: without it there is nothing to patch.
- **Dubs Bad Hygiene, Dubwise, `Dubwise.DubsBadHygiene`, Workshop `836308268`: hard, declared** likewise. The code reaches
  it by reflection only, which is a choice about breakage (a rework degrades the mod instead of stopping the game), not
  a sign that it is optional: without it the component binds nothing and the mod does nothing.
- **DLC: none required.** `supportedVersions` is `1.6`; no `LoadFolders.xml`, so no `IfModActive` branch to check. Every
  Pickle pass runs on Core plus the five DLC and passes, which shows the mod does not object to them, not that it needs
  them.
- **Incompatibilities: none declared** (`incompatibleWith` absent, and neither README nor CHANGELOG claims one).
- **Not checked from here:** whether the two Workshop pages list a 1.6 build; the declarations were verified against the
  installed `About.xml` files.

## Captures for the Workshop page

Steam shows the first one large: put the most demonstrative there, not the prettiest. The gallery folder is `Art/Gallery/`, numbered on one digit (`0-preview.png` is a byte copy of the Preview; `1-the-bath.jpg`, `2-the-needs-tab.jpg`).

**State on 2026-10-10: the gallery on the Steam page is the second series** (`1-the-bath.jpg`, `2-the-needs-tab.jpg`, accepted by the owner 2026-10-08 and uploaded by hand with 1.0.2). The first series (taken 2026-09-28 in the flower glade of the studio with the colonist Miel) predated the rules of 2026-10-02 and 2026-10-06 (`../PUBLISHING.md`, "Images": every gallery shot is a staged photograph except menus, the series tells one story in the shared place, the images are opened and their anomalies reported) and was replaced.

The new series is played by `07-workshop-captures.feature` on **Nelim's Sanctuary** (fixture `Nelims-tribe`, `PickleTools/docs/SANCTUAIRE-LIEUX.md`, `GALERIE.md`), pass map `Tests/Pickle/wsl-deps.sanctuary.map`, English only: **the colonist is Nelim herself** (Virginie, the only colonist; her own look is kept, she is dressed in a cream shirt and deep teal trousers, her old clothes put in her inventory), in the drum on the brown bank of `water-garden` (x 143-158, z 168-176; the burrow at 149,173 is avoided), with a torch lamp lit, a shelf and two grown plants around. Image 1 is the colonist in the bath, interface hidden; image 2 is the Needs tab with the hygiene gauge risen after 600 ticks of the real bath (a menu, not staged).
Earlier runs of this feature (8 to 12 on the sanctuary, before the accepted runs 606c and e17f below) were trials and taught what to fix (the first spot stood in shallow water; the "hole" is a SteamGeyser (run 850a); StandingLamp needs power and `is lit` waited for a glow that never came; the pale blue clothes on the ground were her old clothes, dropped where she stood by the first `wears`).

Each image is opened before it is uploaded, against what the owner asked for. The page is English, so the English shots are used; they are converted to JPEG into `Art/Gallery/`. The dry-run lists that folder as a reminder of the manual gallery upload; Steam answers "file upload fail: 29" for an image already on the page, so only new or changed images are sent.

**Accepted by the owner (2026-10-08), renumbered 3 -> 1 and 4 -> 2 once the first series was deleted.** `Art/Gallery/1-the-bath.jpg` (run 606c, scenario 1) and `2-the-needs-tab.jpg` (run e17f, scenario 2), taken on the Backlot map, each under 2 MB (322 and 367 KB; the folder is 3.1 MB of 8). Accepted candidates lose the word `candidate` and take their final index; refused ones are deleted. The first series was rejected by the owner on 2026-10-08, deleted locally and replaced on the Steam page.

Not asserted in this feature: `no warnings from mod` (the sanctuary rolls 157 vanilla warnings out of Pickle's buffer; scenarios `01` to `06` assert it on the test colony).

## The preview image

`Mod/About/Preview.png` is generated by the shared `scripts/Render-Preview.cjs` renderer from
`Art/Preview-source.png`, `Art/Preview.config.json` (copy, typography, layout, palette), `Art/echo-source.png`, and
`Art/ModIcon-source.png`. The compact top-left panel uses the RimWorld title font and Segoe UI description.
The echo is based on the actual vertical drum bath shown in `Art/Gallery/1-the-bath.jpg`, not on the wider
illustrative bath in the background; the final transparent mask is used unchanged, coloured with the accent,
flipped horizontally, and kept below half the panel width. The true-alpha mascot sits bottom-left at `+15°`,
without outline, over its local radial veil. Placement is explicit, never selected by an "emptiest corner" rule.
`Art/Gallery/0-preview.png` is a byte-identical copy of the generated Preview. The workflow does not send the preview unless `update_preview` is turned on (off by default): **the owner
chose it on 2026-09-28**: `update_preview` is turned on for the `publish` dispatch, so the new image replaces the one of 0.1.0.

## Content boxes (adult content, violence)

The `Preview.png`, the `ModIcon.png` and the two capture stills were opened. None shows nudity, gore or anything sexual;
the subject is a colonist in a metal drum, drawn head and shoulders. Answer **no adult content**. Re-answer only after
opening any image added later, because the boxes commit the page.

## Thanks (posted 2026-10-02)

Mlie (crediting dragon too) and Dubwise: posted, texts in the git history of this file; `../WORKSHOP_COMMENTS.md` (rows `posted`). Pickle, RimLogging and PickleTools: this mod added to their `Covers`, nothing posted. Harmony: not used.

