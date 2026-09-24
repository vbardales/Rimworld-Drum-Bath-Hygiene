# Pickle runs: one line per run, and what Evidence is kept

A Pickle run writes a report of tens of megabytes: `report.html` (about 20 MB), `messages.ndjson` (13 to 19 MB) and a
`screenshots/` folder of PNG files of about 3 MB each, shared by every mod on the machine. That does not belong in a
public repository, and the root `AGENTS.md` ("Test evidence") asks for the history as **one text line per run in this
folder, never as folders**. So it is split in two:

| What | Where | In git |
| --- | --- | --- |
| **Evidence**: the report, the captures, the films, `Player.log` | `.build/evidence/<pass>/`, written by `Run-PickleWsl.ps1 -EvidenceDir DrumBathHygiene/.build/evidence/<pass>` | **No.** `.build/` is ignored |
| **History**: one line per run | the table below | Yes |

The Evidence is a working copy: it survives on this machine only, and `PickleReports-archive` purges after five runs, so
copying it with `-EvidenceDir` at launch is what keeps it.

## What a line must say

Written from the report, and only what was read: the run and the date; the pass (`setName`, language); the commit the run
staged from; **`exitReason` first**, then scenarios played of written, passed and failed (a run killed in flight leaves a
`summary.json` that looks like a result); what it turned out to be for each failure (of the mod, the suite, the
environment, or not yet known); which `@review` captures were opened and what they actually show (a green `@review`
proves the path ran, not that the image shows a bath); and where the Evidence is. A line does not say what `TESTING.md`
says about coverage: it says what a run did. The longer account of what each failure taught is in
`Tests/Pickle/README.md`.

## The runs

| Run | Date | Pass | Staged from | `exitReason` | Played / passed / failed | What it was, and what was opened | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 2026-09-21 | sans-facultatifs, EN | suite in flux | failed | 11 of 11 / 8 / 3 | An animal not found by Pickle's pawn steps, a healthy colonist wrongly expected a `HotBath`, and `ColdBath` for `ColdWater`: all the suite. Capture opened: colonist beside the drum, panel "Washing." | none kept |
| 2 | 2026-09-21 | sans-facultatifs, EN | suite in flux | failed | 16 of 16 / 12 / 4 | Teleported scenarios pass; the animal threw in the drum mod's render patch (a hediff given by hand to a pawn with no job); three through the real job failed | none kept |
| 3 | 2026-09-21 | sans-facultatifs, EN | suite in flux | failed | 16 of 16 / 13 / 3 | The `is bathing` step was a `void` dropping its `Task`: it never waited, so every use had been vacuous, the capture green over a colonist far from the drum | none kept |
| 4 | 2026-09-21 | sans-facultatifs, EN | suite in flux | failed | 16 of 16 / 11 / 5 | With the step awaiting, the five real-job scenarios timed out at about 98 s; log silent | none kept |
| 5 | 2026-09-21 | sans-facultatifs, EN | suite in flux | failed | 16 of 16 / 11 / 5 | Job trace and film added: a colonist reached the drum and bathed for ten seconds, wrongly credited to the order (see run 6); the step's `targetA` condition was wrong. Film opened: colonist in the drum, "Relaxing in the bath…" | 60 s film and one frame kept in a session scratch folder, none in the repository |
| 6 | 2026-09-23 | sans-facultatifs, EN | `5600eb8` | failed | 19 of 19 / 15 / 4 | The order never worked: the drum mod's job has the cell in target A and the drum in B, the suite put the drum in A, the job ended inside `StartJob`, colonists bathed only when the joy giver sent them. Also: the game hands a removed need back. Capture opened: colonist beside a building, "Wandering." | small copy deleted 2026-09-23 |
| 7 | 2026-09-23 | sans-facultatifs, FR | `5600eb8` | failed | 19 of 19 / 15 / 4 | Same causes, a different four failing. **Capture green over a colonist cleaning sand, not bathing**; film (60 s) never shows the drum | small copy deleted 2026-09-23 |
| 8 | 2026-09-23 | sans-facultatifs, EN | `9df3305` | **passed** | 19 of 19 / 19 / 0 | The five real-job scenarios in 17 to 30 s. Still opened: colonist in the drum, "Relaxing in the bath…", but the game drawn in the lower-left quarter of the file; film opened (960x540): the walk and the arrival. The one `[ERROR]` in the log is start-up, the companion mod having no def | `.build/evidence/tested-english-1/` |
| 9 | 2026-09-23 | sans-facultatifs, FR | `9df3305` | **passed** | 19 of 19 / 19 / 0 | Still opened, whole 1920x1080 frame: colonist in the drum, panel "Se détendre dans le bain…". Film opened: the walk and the drum. Same single start-up `[ERROR]` | `.build/evidence/tested-french/` |

## What Evidence to keep, and in what form

Decided 2026-09-23 with the owner, under the same rule: keep what still proves something, small, and delete the rest.
Confirmed against the reports of runs 8 and 9. Applied to `.build/evidence/<pass>/` after each run, once the line above
is written.

| Keep | Form | Why |
| --- | --- | --- |
| `summary.json`, `summary.md`, `junit.xml.gz` | as is or gzip, a few KB | `exitReason`, scenarios played against written, the outcomes: the report's verdict |
| `Player.log.gz` | gzip | what `no errors` and `no warnings from mod` were asserted against |
| `messages.ndjson.gz` | gzip, a few KB when green | the step-level record |
| The `@review` capture (`manual--….png`) and the frames of any failed scenario | as Pickle writes them, 1 to 3 MB | the image a person opens |
| The film (`@film`) | as Pickle writes it, under 1 MB | proof that the real bath works, seen and not inferred |
| `report.html` | **deleted when the run is green**; gzip and kept only while a failure remains to re-examine (2 to 4 MB) | the page of a green run repeats `summary.md` |
| Nothing else | deleted | the hundreds of other PNGs are the shared folder's, not this mod's |

Only the **latest report per pass, for the revision now in the repository**, stays. A report replaced by a newer run is
deleted at once, unless it is the sole proof of a check the newer one did not repeat. Never delete what a `STATUS.md`
field points to: repoint it first. Before deleting, list what goes and what stays.
