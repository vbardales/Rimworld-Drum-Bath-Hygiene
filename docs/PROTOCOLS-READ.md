# Documents read, and at which version

Asked by the owner (2026-09-25): read the documentation, note here what was read at which version, and which documents
were of no use, so that they are not read again if they have not moved. A version is the last commit that touched the
file, in the repository that carries it (`git log -1 --format='%h %ad' -- <file>`); `git status --short -- <file>` was
empty for every file below (no uncommitted change). **The protocol documents are not in the monorepo any more**: their
history is `vbardales/Rimworld-protocols` (git dir `../rimworld-protocols.git`, work tree = the monorepo root), and a
`git log` from the monorepo returns the commit that removed them (`Rimworld-Ticket-Dispatcher/docs/WELCOME.md`, point 5).

## Read on 2026-10-02 (all of `AUDIT.md`; the others as a diff since the version above)

Versions are `git log -1` in the repository that carries each file (protocols: `../rimworld-protocols.git`, work tree
= the monorepo root). Only what moved since 2026-09-25 was read; a file not listed here did not move or was not needed.

| File | Version | Of use to this mod? |
| --- | --- | --- |
| `AUDIT.md` | `7fd7475` (29/09 09:37) | Yes, in full. New for `tested`: no `@wip`, every `@requires` played, no manual test left; icon/preview rules; step 12 (rewind) and the session title |
| `AGENTS.md` | `7fd7475` (29/09 09:37) | Yes. Evidence rules unchanged in substance; `docs/runs/history.md` is trimmed after publication |
| `PUBLISHING.md` | `02394c0` (01/10 04:41) | Yes. **Pull request to the upstream repository is systematic** (BACKLOG); gallery folder is `0-`, `1-`, `2-`, with `0-` a byte copy of `Preview.png`; the Preview carries the ModIcon cutout; Steam answers "file upload fail: 29" for an image already in the gallery. The animal-mod integrations do not apply (the mod adds no animal) |
| `STYLE_RIMWORLD.md` | `c105a43` (01/10 05:15) | Little: the preview and colonist/animal drawing rules; the preview is the owner's migration (`91717a0`) |
| `TRANSLATIONS.md` | `af8427f` (02/10 09:51) | **No.** Plural keys and the neutral French forms; the mod owns no player-facing text (`not_applicable`). Reread only if it gains a text |
| `MOD_SETTINGS.md` | `b83933b` (23/09 20:46) | No: unchanged, `settings_audit: not_applicable` stands |
| `scripts/SEARCHING.md` | `50de695` (28/09 21:04) | **No** |
| `PickleTools/README.md`, `Headless/README.md`, `docs/steps.md` | `ff20d89`, `ed4e73a`, `da7c3b0` | Not reread: no run was submitted. Reread before the next pass |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `3c03f51` (26/09 23:20) | Yes: rewritten shorter. Dry-run of the exact commit first, `publish` takes the 40-character SHA, only the owner approves `steam-production`, the gallery is never sent by the CI. A new dry-run is needed for the SHA to publish |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `77ca9d7` (27/09 23:26) | Yes: state now in `.pickle-state\` at the repository root; `path:` points at the folder that holds `About/`; **no `desktop.ini` or `.ico` in `Mod/`** (gitignored here) |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `d07b2b8` (26/09 18:25) | Not reread: no run was submitted |
| `WORKSHOP_COMMENTS.md` | not tracked | Not reread; Mlie and Dubwise rows are still to add |

The mod's own files (`STATUS.md`, `BACKLOG.md`, `.gitignore`, `CHANGELOG.md`, `PUBLICATION.md`, `docs/runs/`, `Tests/Pickle/`, `About.xml`) were read. `README.md`, `ATTRIBUTION.md`, `LICENSE`, `TESTING.md` were not changed. `NOTES.md` and `BUGS.md` do not exist.


_The 2026-09-25 table and "what the reading changed" were removed on 2026-10-02 (published); they are in git. Not useful then and still not: TRANSLATIONS.md, MOD_SETTINGS.md, scripts/SEARCHING.md._

## Reread only if it moves

`AGENTS.md`, `AUDIT.md`, `PUBLISHING.md`, `PickleTools/Headless/README.md`, `OPERATIONS.md`, `WELCOME.md` and `SUBMIT.md` are
the ones that carry rules used here. The others above have not been of use, or only in the parts named.
