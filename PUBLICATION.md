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

One more claim to keep in mind rather than change: *"the room gives its usual bathroom thought"*. The call goes through
without a warning, but the thought itself is Dubs Bad Hygiene's grading of a room and no scenario asserts a stage
(TESTING.md, scenario 4, not applicable).

## Release notes (the change note of each upload)

The change note sent to Steam with an upload, under the heading of its version: the manual workflow reads the block
under `### <version>` (`../PUBLISHING.md`, "Publier par la CI"), and the `## [<version>]` section of `CHANGELOG.md` goes
into the GitHub release.

### 1.0.0

```
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

Steam shows the first one large: put the most demonstrative there, not the prettiest. **TO DO: waiting on the `tools`
passes, English and French, queued on 2026-09-24.** `07-workshop-captures.feature` takes the two images, not filmed, each
with the bath as the last thing asserted and the game paused before the shot: **1. the colonist in the drum** and **2. the
Needs tab with the hygiene gauge partway up** (started at ten per cent, asserted risen after 600 ticks of the real bath).
Each image is opened before it is uploaded: a green capture scenario shows that the trajectory ran, not that the picture
shows anything. The page is English, so the English shots are the ones to use; the French ones are for the French check.

What was opened on 2026-09-23, from the earlier `04` capture, and why a re-shot is wanted:

- French pass, `.build/evidence/tested-french/screenshots/manual--bather-in-the-drum--step0.png`: 1920x1080, whole
  frame, the colonist sitting in the red drum with the fire under it, the panel reading "Se détendre dans le bain en
  regardant passer les nuages." Good, and in French.
- English pass, `.build/evidence/tested-english-1/screenshots/manual--bather-in-the-drum--step0.png`: the same picture with
  the panel in English, but the game fills only the lower-left quarter of the 1920x1080 file, the rest black (the film of
  the same run is 960x540). Not fit for the page. Not diagnosed; `07` is not filmed, so if it comes back there, the
  film is not the cause.

Proposed order once `07` has run: 1. the colonist in the drum; 2. the Needs tab with the gauge partway up. Both stills
opened so far show a person sitting in a barrel, clothed as far as the sprite shows, nothing else.

## The preview image

`Mod/About/Preview.png` was re-rendered on 2026-09-24 (`Art/preview.html`, `Art/render-preview.cjs`, run with the bundled
Node runtime that carries playwright and sharp): the summary was narrowed from 430 to 290 px, so it wraps on two shorter
lines and no longer sits on the rim of the bath, which began about 400 px from the left; the title, the rule and the badge
did not move. Measured contrast of the summary over its whole rectangle rose from 5.96 to 10.55, size 518,698 bytes. This
is a change to `Mod/`. The workflow does not send the preview unless `update_preview` is turned on (off by default): **either
Virginie turns it on for the dispatch, or the image is replaced by hand on the Steam page**, if the new one is wanted there.

## Content boxes (adult content, violence)

The `Preview.png`, the `ModIcon.png` and the two capture stills were opened. None shows nudity, gore or anything sexual;
the subject is a colonist in a metal drum, drawn head and shoulders. Answer **no adult content**. Re-answer only after
opening any image added later, because the boxes commit the page.

## Thanks to post, after the item is public

A link to a private item opens for nobody, so post only once it is public. One recipient each, under 1000 characters,
BBCode allowed. The item link is `https://steamcommunity.com/sharedfiles/filedetails/?id=3806137182`.

**Mlie, on MMDrumcanMOD (Continued)** (`https://steamcommunity.com/sharedfiles/filedetails/?id=3417093756`), comment page
(662 characters):

> Thank you for keeping MMDrumcanMOD alive. I made a small bridge, Drum Bath Hygiene, so that soaking in your drum bath
> actually washes a colonist when Dubs Bad Hygiene is loaded: the hygiene gauge fills, onlookers notice, and the water
> counts as hot or cold by whether the drum still burns. It adds no building, texture or def, and none of your files are
> copied or shipped: a component is grafted by XML onto your bathing hediff, and I read your bath driver only to learn
> that this was the safe way in. Credited in its attribution file. If anything in it bothers you, tell me and I will
> change it. https://steamcommunity.com/sharedfiles/filedetails/?id=3806137182

**Dubwise, on Dubs Bad Hygiene** (`https://steamcommunity.com/sharedfiles/filedetails/?id=836308268`), comment page
(607 characters):

> Thank you for Dubs Bad Hygiene. I made a small bridge, Drum Bath Hygiene, that hands the drum can bath of MMDrumcanMOD
> over to your hygiene system: it fills your hygiene need, asks your privacy check whether anyone is watching, lets your
> water rule pick the memory, and clears soaking wet, all through reflection. Nothing of yours is copied or shipped, and if
> a member ever changes the bridge reports it once and does nothing rather than break your game. Credited in its
> attribution file. If you would rather I did this differently, tell me.
> https://steamcommunity.com/sharedfiles/filedetails/?id=3806137182

Neither message is posted; posting to another author's page is the owner's act.

## After the upload, and it cannot be undone

- **`Mod/About/PublishedFileId.txt` is committed and pushed** (done, `d7e1737`): lost, the next upload creates a second item.
- **The item is private** until the owner switches it to public by hand, after subscribing to it and testing the content
  she receives. RimWorld and the CI never call `SetItemVisibility`.
- Check the public page (description, change note, images) and record the evidence in `STATUS.md`: a green GitHub release
  does not prove that Steam is up to date.
- Record the run ids and SHAs of the dry-run and of the publish in `STATUS.md`, then post the two messages above.
