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
  whether the template moved (stamp `eba6b3fdf670`, Rimworld-Release-Admin `31fe605`):

  ```
  bash /c/Users/nelim/Documents/rimworld/Rimworld-Release-Admin/scripts/generate-publish-workflow.sh /c/Users/nelim/Documents/rimworld/DrumBathHygiene --replace --workshop-id 3806137182 --package-id nelim.drumbathhygiene --release-title "Drum Bath Hygiene {version}" --require Assemblies/DrumBathHygiene.dll --gallery-dir Art/WorkshopScreenshots
  ```

  The dry-run lists the images of `Art/WorkshopScreenshots` (alphabetical, only png, jpg, jpeg and gif, not recursive) as a
  reminder of the manual gallery upload; it reads the folder from the pinned commit, so the images are committed in the final
  commit, not left in `.build/evidence`, and nothing else stays in that folder.
- **The CI sends `Mod/`** (everything in it: `About`, `Assemblies`, `Patches`, `ATTRIBUTION.md`, `LICENSE`; there is no
  `.steamignore` and nothing else to exclude). The workflow has four opt-in inputs, **off by default and left off unless
  Virginie asks**: `update_preview`, `update_description`, `update_title`, `update_tags`; visibility is never sent. So the
  description corrections and the images below stay hand work on the Steam page, unless she turns `update_preview` (the
  new `Preview.png`) or `update_description` (which needs the whole description as a fenced block under a heading of this
  file) on for that dispatch.

## The description: already sent, and two sentences in it are now wrong

`SetItemDescription` ran once, with the 0.1.0 prepublication, so what is in `Mod/About/About.xml` is what the page
says until someone edits it by hand. It has the removal commitment (`IF I GO QUIET`, adoption clause verbatim),
`AI-GENERATED`, `THANKS`, the pointer to the attribution file, and `[url=…]Source code on GitHub[/url]` at the end, in
that order. Two paragraphs need correcting **by hand on the Steam page** (an edit of `About.xml` does not reach it,
though it is what the mod list shows in game, so it should say the same):

1. *"Nothing breaks if you load this without them: with no drum bath mod nothing is patched, and with no Dubs Bad
   Hygiene the component sits inert. No error is thrown either way."* No run has shown it and none can: a Pickle pass
   excludes only DLCs, and RimWorld's own handling of a missing dependency is not this mod's. Suggested text: *"Both
   mods are declared as dependencies, so RimWorld will flag a missing one in the mod list. This mod has no content of its
   own and does nothing without both."*
2. *"The mod stores two temporary values on the bathing hediff while a pawn is in the bath. Adding it to an existing game
   and removing it outside or during a bath still require in-game validation."* A bath in progress goes on washing
   after a save and reload (played and green, runs 8 and 9), though the scenario cannot tell restored values from reset
   ones. Adding the mod to a running save or removing it is the game's handling of its mod list, and has not been
   played. Suggested text: *"The mod stores two temporary values on the bathing hediff while a pawn is in the bath. A bath
   in progress goes on washing after a save and a reload. Adding it to, or removing it from, an existing save has not been
   tested."*

3. *The `THANKS` block* names the two mods and the AI tools, but not the test tools, which `../PUBLISHING.md` asks for with the
   words "development only, never a dependency": **Pickle** (Workshop `3791648678`), **RimLogging** (`3733484696`) and, since the
   `tools` pass stages three of its packages, **PickleTools** (`3806142401`), each as a `[url=...]` link. Suggested addition, before
   the attribution line: *"Tested with Pickle, RimLogging and Nelim's PickleTools, thanks to their authors: development only, never
   a dependency of this mod."* Also to settle with the owner: `../PUBLISHING.md` asks to name Codex (OpenAI) in `AI-GENERATED` when it
   contributed to the repository; `STATUS.md` names Codex as owner of the audit task, and the description names Claude Code and
   DALL-E only.

One more claim to keep in mind rather than change: *"the room gives its usual bathroom thought"*. The call goes through
without a warning, but the thought itself is Dubs Bad Hygiene's grading of a room and no scenario asserts a stage
(TESTING.md, scenario 4, not applicable).

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

Steam shows the first one large: put the most demonstrative there, not the prettiest. **TO DO: waiting on the final `tools`
passes.** The images are not to be taken on the test colony: it is a working save with a skeleton beside the drum, and a
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
