# Publication sheet, historical parts (moved from PUBLICATION.md on 2026-10-10, followUp clean-up)

Text kept verbatim: the 1.0.0 preparation, the 1.0.0 and 1.0.1 change notes and the 1.0.0 production steps. The current sheet is `../../PUBLICATION.md`.

## 1.0.0 preparation (was the opening and "Before the upload")

the next update and by whoever picks the mod up.

*Historical (1.0.0 preparation).* This is an **update of an existing item**, not a first creation (`../PUBLISHING.md`, "Publier par la CI", and
`Rimworld-Release-Admin/docs/OPERATIONS.md`, the Skill Icons section). Steam already holds the 0.1.0 content
(`Mod/` as of `7b65a4f`); nothing in `Mod/` has changed since apart from the id file and `About/Preview.png` (below), so
1.0.0 uploads the same payload plus that image.

## Before the upload (historical: 1.0.0)

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
  bash /c/Users/nelim/Documents/rimworld/Rimworld-Release-Admin/scripts/generate-publish-workflow.sh /c/Users/nelim/Documents/rimworld/DrumBathHygiene --replace --workshop-id 3806137182 --package-id nelim.drumbathhygiene --release-title "Drum Bath Hygiene {version}" --require Assemblies/DrumBathHygiene.dll --gallery-dir Art/Gallery --description-markdown PUBLICATION.md --description-heading '^## Steam description$' --about-from-description
  ```

  The dry-run lists the images of `Art/Gallery` (alphabetical, only png, jpg, jpeg and gif, not recursive) as a
  reminder of the manual gallery upload; it reads the folder from the pinned commit, so the images are committed in the final
  commit, not left in `.build/evidence`, and nothing else stays in that folder.
- **The CI sends `Mod/`** (everything in it: `About`, `Assemblies`, `Patches`, `ATTRIBUTION.md`, `LICENSE`; there is no
  `.steamignore` and nothing else to exclude). The workflow has four opt-in inputs, **off by default and left off unless
  Virginie asks**: `update_preview`, `update_description`, `update_title`, `update_tags`; visibility is never sent. The
  owner chose `update_description` on 2026-09-25 and **`update_preview` on 2026-09-28**: both are turned on for the `publish`
  dispatch (the description is the block under "Steam description" below; `update_title` and `update_tags` stay off). The images
  of the gallery stay hand work on the Steam page.

## Change notes sent with 1.0.1 and 1.0.0

### 1.0.1

```
[b]1.0.1[/b]
New preview image and mod icon. No change to how the mod plays.
```

### 1.0.0

```
[b]1.0.0[/b]
First release. Makes the drum can bath wash: while a colonist soaks, their Dubs Bad Hygiene hygiene need fills (an
empty gauge over half a bath), onlookers react as with any Dubs Bad Hygiene bathing, the water counts as hot or cold by
whether the drum still burns, the "soaking wet" memory is cleared on the way in and the filth on the body on the
way out. No content of its own: a bridge between MMDrumcanMOD (Continued) and Dubs Bad Hygiene, both required.
RimWorld 1.6.
```

## When 1.0.0 goes to production: by hand, by the owner (historical: done, confirmed 2026-10-08)

The CI never sends the visibility, and `../PUBLISHING.md` ("Mise en production d'une 1.0.0") lists three things only she does on
Steam: change the visibility of the item after testing it subscribed, subscribe to its comments, and "Watch all activity" of
the mod and of its parent mods (MMDrumcanMOD and Dubs Bad Hygiene). They are written in `STATUS.md` (date, the three points)
before the stage is `published`.

## After the upload, and it cannot be undone (historical: 1.0.0; the item is public since)

- **`Mod/About/PublishedFileId.txt` is committed and pushed** (done, `d7e1737`): lost, the next upload creates a second item.
- **The item is private** until the owner switches it to public by hand, after subscribing to it and testing the content
  she receives. RimWorld and the CI never call `SetItemVisibility`.
- Check the public page (description, change note, images) and record the evidence in `STATUS.md`: a green GitHub release
  does not prove that Steam is up to date.
- Record the run ids and SHAs of the dry-run and of the publish in `STATUS.md`, then post the two messages above.
