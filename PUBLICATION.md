# Publication sheet

**Written 2026-09-24. The mod is at `tested`. The Workshop item exists (`3806137182`, created by the 0.1.0
prepublication of 2026-09-22, private as Steam creates them) and `Mod/About/PublishedFileId.txt` is committed. What is
still ahead: the items below marked TO DO, the upload of 1.0.0 by the CI, the switch to public, and the two thanks.**
This sheet holds what the Workshop page asks for and the repository holds nowhere else, so that it can be used again at
the next update and by whoever picks the mod up.

This is an **update of an existing item**, not a first creation (`../PUBLISHING.md`, "Publier par la CI", and
`Rimworld-Release-Admin/docs/OPERATIONS.md`, the Skill Icons section). Steam already holds the 0.1.0 content
(`Mod/` as of `7b65a4f`); nothing in `Mod/` has changed since apart from the id file and `About/Preview.png` (below), so
1.0.0 uploads the same payload plus that image.

## Before the upload

- **Repository.** Working tree clean and pushed, and the distributed DLL matches the sources (SHA256 `865ACC8A…`, built
  from `Source/`, checked 2026-09-22; `git diff 7b65a4f HEAD -- Mod Source` on 2026-09-24 shows only the id file, and `git diff d7e1737 HEAD -- Mod Source` nothing at all).
- **CHANGELOG.** `## [1.0.0] — unreleased` must be given its date before the upload: the release notes of the GitHub
  release are that section. The tag `v1.0.0` and the release are created **by the CI after a successful upload**, on the
  exact SHA it uploaded, never by hand.
- **The workflow.** Written on 2026-09-24 by `Rimworld-Release-Admin/scripts/generate-publish-workflow.sh` (the single
  source, from a mod repository: `--workshop-id 3806137182 --package-id nelim.drumbathhygiene --release-title "Drum Bath
  Hygiene {version}" --require Assemblies/DrumBathHygiene.dll`), which writes `.github/workflows/publish-tag.yml`,
  `script-tests.yml`, `.github/scripts`, `.github/tests` and `publish.config.json`; 48 tests pass. It must be on `main` to be
  dispatched. `dry-run` first, on the exact commit, its log read for the `publish template:` and `options:` lines; the run
  id and the SHA go into `STATUS.md`. `publish` takes the full 40-character SHA
  (`Rimworld-Release-Admin/scripts/dispatch-publish.sh vbardales/Rimworld-Drum-Bath-Hygiene publish-tag.yml <SHA> 1.0.0`,
  which refuses without a green dry-run of that SHA); **only Virginie approves `steam-production`**, which already exists
  with its reviewer and the two secrets (checked read-only by the CI session). The dry-run also needs `## [1.0.0]` in
  `CHANGELOG.md` to be dated, the change note below to be a fenced block under `### 1.0.0`, and no tag `v1.0.0`.
  **Any commit after the dry-run changes the SHA and needs a new one.** That includes the commit that dates the CHANGELOG,
  so date it first, and it is the commit that carries the Pickle-validated suite.
- **Regenerating the workflow: keep every option.** The full command, `--gallery-dir` included (a later `--replace` typed from
  memory without it would silently drop `galleryDir` from `.github/publish.config.json`), from a shell; add `--check` first to see
  whether the template moved (stamp `683151266dd1`, Rimworld-Release-Admin `da4e786`; regenerated on 2026-09-26 with
  `--description-markdown` and `--about-from-description`, adopting the Markdown description standard other mods already use,
  which moved the stamp from `683151266dd1`; the earlier move, on 2026-09-25 with `--description-file`, had come from `eba6b3fdf670`):

  ```
  bash /c/Users/nelim/Documents/rimworld/Rimworld-Release-Admin/scripts/generate-publish-workflow.sh /c/Users/nelim/Documents/rimworld/DrumBathHygiene --replace --workshop-id 3806137182 --package-id nelim.drumbathhygiene --release-title "Drum Bath Hygiene {version}" --require Assemblies/DrumBathHygiene.dll --gallery-dir Art/WorkshopScreenshots --description-markdown PUBLICATION.md --description-heading '^## Steam description$' --about-from-description
  ```

  The dry-run lists the images of `Art/WorkshopScreenshots` (alphabetical, only png, jpg, jpeg and gif, not recursive) as a
  reminder of the manual gallery upload; it reads the folder from the pinned commit, so the images are committed in the final
  commit, not left in `.build/evidence`, and nothing else stays in that folder.
- **The CI sends `Mod/`** (everything in it: `About`, `Assemblies`, `Patches`, `ATTRIBUTION.md`, `LICENSE`; there is no
  `.steamignore` and nothing else to exclude). The workflow has four opt-in inputs, **off by default and left off unless
  Virginie asks**: `update_preview`, `update_description`, `update_title`, `update_tags`; visibility is never sent. The
  owner chose `update_description` on 2026-09-25: it is turned on for the `publish` dispatch (the block is under "The
  description text" below). `update_preview` (the new `Preview.png`) is her call too; the images of the gallery stay hand work on the
  Steam page.

## Steam description

**One source, decided by the owner on 2026-09-25** (`../PUBLISHING.md`; `Rimworld-Release-Admin/docs/OPERATIONS.md`,
"Changing where the Steam description comes from"): the description is written once, in Markdown, in the fenced block
below. The CI converts it to Steam BBCode and generates the plain-text `<description>` of `Mod/About/About.xml` from it
(`node .github/scripts/sync-about-description.mjs --write`), and every dry-run and publish stops if `About.xml` differs
from it. The block cannot contain a code fence, and its last line is the source link. Adopted on 2026-09-26, migrating
from the BBCode block sent since 2026-09-25 under the old heading "The description text": until the workflow is
regenerated with the options above, `About.xml` stays as it is, and the first `sync-about-description.mjs --write` after
regenerating rewrites its text (read the diff). The item being private, the dry-run cannot diff the converted text
against the page, so it is read by hand once. Every publish with `update_description` on overwrites the Steam page: a
later hand edit there would be lost, so this block stays the single source.

What changed against the text of 0.1.0 (before the 2026-09-25 corrections, still readable in `git log -p -- Mod/About/About.xml`):

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
Makes the drum can bath actually wash people, by connecting MMDrumcanMOD to Dubs Bad Hygiene.

On its own, soaking in a drum bath is pure recreation: it gives joy, a warm mood buff and a rest bonus, but a colonist climbs out exactly as filthy as they got in. This bridges the two.

While a colonist is in the bath:

- their hygiene need fills,
- onlookers react to the sight, as with any DBH bathing,
- the water is judged hot or cold depending on whether the drum still has fuel burning,
- the room gives its usual bathroom thought,
- the "soaking wet" memory is cleared, and so is the filth carried on their body when they climb out.

Both mods are declared as dependencies, so RimWorld will flag a missing one in the mod list. This mod has no content of its own and does nothing without both.

The mod stores two temporary values on the bathing hediff while a pawn is in the bath. A bath in progress goes on washing after a save and a reload. Adding it to, or removing it from, an existing save has not been tested.

## IF I GO QUIET

If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

## AI-GENERATED

This mod's code was written with Claude Code (Anthropic) and Codex (OpenAI), and its images generated with DALL-E (OpenAI), under human direction, review and testing. Stated openly: designing with these tools is my job.

## THANKS

- [Mlie](https://steamcommunity.com/sharedfiles/filedetails/?id=3417093756), for keeping MMDrumcanMOD (Continued) alive. The drum bath is theirs; this mod is nothing without it, and adds no content of its own.
- [Dubwise](https://steamcommunity.com/sharedfiles/filedetails/?id=836308268), for Dubs Bad Hygiene, to which this mod simply hands the bath over — the hygiene need, the privacy reactions, the water temperature and the bathroom thoughts are all theirs.
- [Pickle](https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678), [RimLogging](https://steamcommunity.com/sharedfiles/filedetails/?id=3733484696) and [Nelim's PickleTools](https://steamcommunity.com/sharedfiles/filedetails/?id=3806142401), used for the in-game tests: development tools, never a dependency of this mod.

No code from either mod is reused here. See ATTRIBUTION.md in the mod folder.

[Source code on GitHub](https://github.com/vbardales/Rimworld-Drum-Bath-Hygiene)
```

## Release notes (the change note of each upload)

The change note sent to Steam with an upload, which **starts with the version alone on its first line** (`[b]1.0.0[/b]`: the Workshop page does not show the version of a note that does not say it, `../PUBLISHING.md`), under the heading of its version: the manual workflow reads the block
under `### <version>` (`../PUBLISHING.md`, "Publier par la CI"), and the `## [<version>]` section of `CHANGELOG.md` goes
into the GitHub release.

### 1.0.0

```
[b]1.0.0[/b]
First release. Makes the drum can bath wash: while a colonist soaks, their Dubs Bad Hygiene hygiene need fills (an
empty gauge over half a bath), onlookers react as with any Dubs Bad Hygiene bathing, the water counts as hot or cold by
whether the drum still burns, the "soaking wet" memory is cleared on the way in and the filth carried on the body on the
way out. No content of its own: a bridge between MMDrumcanMOD (Continued) and Dubs Bad Hygiene, both required.
RimWorld 1.6.
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

Steam shows the first one large: put the most demonstrative there, not the prettiest. **Done 2026-09-28: both images taken and validated by the owner** (run 21, commit `cdb7968`, English,
`Art/WorkshopScreenshots/`; the two passes on the final revision are the last check). The images are not to be taken on the test colony: it is a working save with a skeleton beside the drum, and a
first pair taken there on 2026-09-24 was **refused by the owner**. They are taken on her photographic colony,
`nelim-zen-meadow-studio` (package `nelim.pickletools.screenshotstudio`), in its flower glade: a bath on grass with red and
orange flowers around it that identify the place. `07-workshop-captures.feature` takes them, not filmed, each with the bath
as the last thing asserted and the game paused before the shot: **1. the colonist (Miel) in the drum**, interface hidden by
the studio's presentation mode, and **2. the Needs tab with the hygiene gauge partway up** (ten per cent at the start,
asserted risen after 600 ticks of the real bath), interface kept since the tab is the subject.
Each image is opened before it is uploaded, against what the owner asked for: the studio colony, on grass with flowers
around (or a plain orange zone), no skeleton, the bath visible. The page is English, so the English shots are the ones to
use; they are copied, converted to JPEG, into `Art/WorkshopScreenshots/` (`01-the-bath.jpg`, `02-the-needs-tab.jpg`: the
dry-run lists that folder as a reminder of the manual gallery upload, in that alphabetical order, which is also the order
of the page).

Proposed order: 1. the colonist in the drum; 2. the Needs tab with the gauge partway up.

What the first takes taught, so as not to relearn it: the studio camera cannot come closer than root size 11 (the suite lowers the floor for
the shot and puts it back), and a close shot draws a semi-transparent square around every light and every mote: the drum's own light
(`CompGlower`) and the `Mote_Bombardment` motes that MMDrumcanMOD spawns around it respawn every few frames, so both are removed
immediately before each screenshot (`07-workshop-captures.feature`).

## The preview image

`Mod/About/Preview.png` was re-rendered on 2026-09-24 (`Art/preview.html`, `Art/render-preview.cjs`, run with the bundled
Node runtime that carries playwright and sharp): the summary was narrowed from 430 to 290 px, so it wraps on two shorter
lines and no longer sits on the rim of the bath, which began about 400 px from the left; the title, the rule and the badge
did not move. Measured contrast of the summary over its whole rectangle rose from 5.96 to 10.55, size 518,698 bytes. **This
is a deviation** from `../STYLE_RIMWORLD.md`, which fixes the summary width at 430 px (metrics validated by the owner on
2026-09-25, top-left or bottom-right anchor only); it was made before that guide was read again. Reverting is `width:430px` in
`Art/preview.html` and one run of `Art/render-preview.cjs`; the owner decides. This
is a change to `Mod/`. The workflow does not send the preview unless `update_preview` is turned on (off by default): **either
Virginie turns it on for the dispatch, or the image is replaced by hand on the Steam page**, if the new one is wanted there.

## Content boxes (adult content, violence)

The `Preview.png`, the `ModIcon.png` and the two capture stills were opened. None shows nudity, gore or anything sexual;
the subject is a colonist in a metal drum, drawn head and shoulders. Answer **no adult content**. Re-answer only after
opening any image added later, because the boxes commit the page.

## Thanks to post, after the item is public

One main comment per recipient page for the whole collection: `../WORKSHOP_COMMENTS.md` is read first, keyed by Workshop id.
A link to a private item opens for nobody, so nothing is posted before the item is public. BBCode, under 1000 characters,
real emojis, a bare item URL at the end for the thumbnail. The item link is `https://steamcommunity.com/sharedfiles/filedetails/?id=3806137182`.

| Recipient | Workshop id | Register today | What to do |
| --- | --- | --- | --- |
| MMDrumcanMOD (Continued), Mlie | `3417093756` | no row | add a `drafted` row, post the first draft below, then `posted` with the date |
| Dubs Bad Hygiene, Dubwise | `836308268` | no row | same, second draft |
| Pickle | `3791648678` | `posted` | add `Drum Bath Hygiene` to `Covers`, post nothing (development and test tool) |
| RimLogging | `3733484696` | `posted` | same |
| PickleTools | `3806142401` | `not_applicable` | the author's own project; add to `Covers` |
| Harmony | `2009463077` | `posted` | not used by this mod (no patch): nothing to add |

**Mlie, on MMDrumcanMOD (Continued)** (774 characters):

```
[b]Thank you for keeping the drum bath alive! 🛁🔥[/b]
Soaking in a barrel over a wood fire, watching the clouds go by, is the coziest thing a colonist can do, and your Continued version is why 😊
I made a tiny bridge, Drum Bath Hygiene, so that the bath also [i]washes[/i] people when Dubs Bad Hygiene is loaded: the hygiene gauge fills, onlookers notice, and the water counts as hot or cold by whether your fire still burns. It adds no building, texture or def, and none of your files are copied or shipped: a component is grafted by XML onto your bathing hediff, and I read your driver only to learn that this was the safe way in ✨
If anything in it bothers you, tell me and I will change it right away 💛
https://steamcommunity.com/sharedfiles/filedetails/?id=3806137182
```

**Dubwise, on Dubs Bad Hygiene** (679 characters):

```
[b]Thank you for Dubs Bad Hygiene! 🚿💛[/b]
Hygiene, privacy, water temperature, bathroom thoughts: a bath feels alive in RimWorld because of you 😊
My little bridge, Drum Bath Hygiene, hands the drum can bath of MMDrumcanMOD over to your system: it fills your hygiene need, asks your privacy check whether anyone is watching, lets your water rule pick the memory, and clears soaking wet. All through reflection, so nothing of yours is copied or shipped, and if a member ever changes, the bridge says so once and does nothing rather than break your game ✨
If you would rather I did this differently, just tell me!
https://steamcommunity.com/sharedfiles/filedetails/?id=3806137182
```

Neither is posted, and the register has no row for them yet: both are the owner's acts.

## When 1.0.0 goes to production: by hand, by the owner

The CI never sends the visibility, and `../PUBLISHING.md` ("Mise en production d'une 1.0.0") lists three things only she does on
Steam: change the visibility of the item after testing it subscribed, subscribe to its comments, and "Watch all activity" of
the mod and of its parent mods (MMDrumcanMOD and Dubs Bad Hygiene). They are written in `STATUS.md` (date, the three points)
before the stage is `published`.

## After the upload, and it cannot be undone

- **`Mod/About/PublishedFileId.txt` is committed and pushed** (done, `d7e1737`): lost, the next upload creates a second item.
- **The item is private** until the owner switches it to public by hand, after subscribing to it and testing the content
  she receives. RimWorld and the CI never call `SetItemVisibility`.
- Check the public page (description, change note, images) and record the evidence in `STATUS.md`: a green GitHub release
  does not prove that Steam is up to date.
- Record the run ids and SHAs of the dry-run and of the publish in `STATUS.md`, then post the two messages above.
