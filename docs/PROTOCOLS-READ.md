# Documents read, and at which version

Asked by the owner (2026-09-25): read the documentation, note here what was read at which version, and which documents
were of no use, so that they are not read again if they have not moved. A version is the last commit that touched the
file, in the repository that carries it (`git log -1 --format='%h %ad' -- <file>`); `git status --short -- <file>` was
empty for every file below (no uncommitted change). **The protocol documents are not in the monorepo any more**: their
history is `vbardales/Rimworld-protocols` (git dir `../rimworld-protocols.git`, work tree = the monorepo root), and a
`git log` from the monorepo returns the commit that removed them (`Rimworld-Ticket-Dispatcher/docs/WELCOME.md`, point 5).

## Read on 2026-09-25, in full

| File | Version | Repository | Of use to this mod? |
| --- | --- | --- | --- |
| `AGENTS.md` | `3a1d2cb` (24/09 12:08) | protocols | Yes: test evidence (one text line per run in `docs/runs/`), publishing by CI |
| `AUDIT.md` | `49cd841` (25/09 17:09) | protocols | Yes: the chain, `tested -> prepublished`, fail fast, the Pickle rules, captures for publication, the queue |
| `PUBLISHING.md` | `0743ff9` (25/09 17:52) | protocols | Yes: images folder (`01-`, `02-`), Steam change note format, thanks and the comments register, the CI section, `1.0.0` to production. The git-hygiene and GitHub topics sections apply as a checklist only |
| `TRANSLATIONS.md` | `b83933b` (23/09 20:46) | protocols | **No.** The mod owns no player-facing text (`localization`, `translation_en`, `translation_fr`: `not_applicable` in `STATUS.md`). Reread only if the mod gains a text |
| `STYLE_RIMWORLD.md` | `7311308` (25/09 15:50) | protocols | Partly. Only the preview overlay metrics and the placement rule; the prompt blocks and the palette study do not apply to a mod that has its preview |
| `scripts/SEARCHING.md` | `372c447` (23/09 21:01) | protocols | **No.** No corpus search was needed |
| `PickleTools/README.md` | `2b7b6d0` (25/09 17:22) | PickleTools | Little: the table of tools; `docs/steps.md` says the same with the steps |
| `PickleTools/Headless/README.md` | `b2712fc` (25/09 15:03) | PickleTools | Yes for the filter terms, the exit codes, "one mod, several passes", the traps list. **The sections on the lock, sleep, orphan games and the two views of AppData are not used by a mod session** |
| `PickleTools/docs/steps.md` | `d6d8db1` (25/09 17:44) | PickleTools | Yes: it holds `developer mode is turned off for the capture` (see below). Generated: do not edit |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `85bab46` (25/09 18:44) | Release-Admin | Yes: the dry-run, the publish workflow template and its options, what the CI can send. The credentials and Codespace sections are Virginie's |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `8aa32a1` (25/09 18:44) | Ticket-Dispatcher | Yes: what to run when, no watcher, a request carries no SHA |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `79668cc` (25/09 17:16) | Ticket-Dispatcher | Yes: every option of `Submit-PickleRun.ps1`, the exit codes |
| `WORKSHOP_COMMENTS.md` (referenced by `PUBLISHING.md`) | not tracked by git | monorepo | Yes: the register; no row yet for Mlie (3417093756) or Dubwise (836308268) |
| `STATUS.md` | `039eae2` (24/09 09:43) | this repo | Written by this session. Rechecked: front matter and the `remaining` list are consistent with the rest |
| `README.md` | `61afec0` (13/09) | this repo | Two statements are stale (see below) |
| `CHANGELOG.md`, `ATTRIBUTION.md`, `LICENSE`, `BACKLOG.md` | `039eae2`, `0652ea2`, `b23b20b`, `f55f9db` | this repo | Read. `ATTRIBUTION.md` and `LICENSE` are identical to their copies in `Mod/` (SHA-256 `ebb16f50...` and `ae6ae5fa...`), which `PUBLISHING.md` asks to compare before a publication |
| `PUBLICATION.md`, `TESTING.md`, `docs/runs/README.md`, `Tests/Pickle/` | `12c17db`, `bc55953`, `039eae2`, `c6ed14d` | this repo | Written by this session |
| `Mod/About/About.xml` | `212757c` (19/09) | this repo | Read; its description is already on Steam |

`NOTES.md` and `BUGS.md` do not exist in this repository.

## What the reading changed

1. **Steam change notes start with the version alone on the first line** (`[b]1.0.0[/b]`, `PUBLISHING.md`, "À chaque mise à jour"):
   the block in `PUBLICATION.md` did not. Fixed.
2. **The summary width of the preview is 430 px in `STYLE_RIMWORLD.md`**, the anchor is top-left or bottom-right only, and
   the owner validated those metrics on 2026-09-25. The narrowing to 290 px made on 2026-09-24 (commit `039eae2`) is a
   deviation from a validated specification, made before this reading. It is recorded in `PUBLICATION.md` and left for the
   owner to keep or revert.
3. **The thanks of the sent description do not name the test tools** (Pickle, RimLogging, and PickleTools since the `tools`
   pass stages three of its packages), which `PUBLISHING.md` asks for, with "development only, never a dependency". Listed
   among the hand corrections in `PUBLICATION.md`. Harmony is not used by this mod (no patch), so it is not thanked.
4. **The comments register** (`WORKSHOP_COMMENTS.md`): Pickle and RimLogging are `posted`, so this mod is only added to their
   `Covers` and posts nothing; Mlie and Dubwise have no row, so they need `drafted` rows and drafts in `PUBLICATION.md` as
   fenced BBCode blocks with real emojis, under 1000 characters. The drafts were prose and are rewritten.
5. **A request carries no SHA** (`WELCOME.md`, point 4): the tree must not move until the `RUN_DONE`, and the SHA belongs in
   the `-Label`. The explorations of 2026-09-24 and 25 were submitted without one, and the tree moved in between: the
   third exploration ran on the tree as it stood when it was played, which was `c6ed14d`.
6. **Evidence**: `report.html` and `messages.ndjson` of a superseded build are not kept, `summary.json` and `junit.xml` are
   enough (`WELCOME.md`, point 4); deleting long capture names needs `robocopy /MIR` first.
7. **`update_description` exists** in the publish workflow (`--description-file PUBLICATION.md --description-heading ...`
   sends a fenced BBCode block as the description, only when the input is on, behind the `steam-production` approval). It
   would replace the hand edit of the two wrong sentences, but the workflow would have to be regenerated and the owner
   decides.
8. **`developer mode is turned off for the capture` already exists** in PickleTools ScreenshotMode and is used by
   `07-workshop-captures.feature`; only the letters and alerts step is this suite's own.
9. **`README.md` of this mod repeats two statements** that `PUBLICATION.md` corrects for the Steam page ("Nothing throws either
   way", and the save validation still required). Fixed.
10. **Fail fast** (2026-09-25): the full replay of the suite on the final build can follow the publication; what cannot be
    skipped is a scenario red without a green replay (none is), the Workshop gallery and the owner's manual validations.
    `1.0.0` to production is three manual steps of the owner (visibility, subscribe to the comments, watch the mod and its
    parents), to be written in `STATUS.md` before `published`.

## Reread only if it moves

`AGENTS.md`, `AUDIT.md`, `PUBLISHING.md`, `PickleTools/Headless/README.md`, `OPERATIONS.md`, `WELCOME.md` and `SUBMIT.md` are
the ones that carry rules used here. The others above have not been of use, or only in the parts named.
