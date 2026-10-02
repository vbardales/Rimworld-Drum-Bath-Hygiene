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
_Trimmed 2026-10-02 (published): runs 1-21 were development-era (suite in flux, failures of the suite fixed by `9df3305`; two 19-scenario green passes 8 and 9 on 2026-09-23, `tools` passes 10-11 on `c839751`, the Workshop-image scenarios 12-21). Superseded by the two final passes below, which prove the published state; `git log -p -- docs/runs/README.md` has the lines._

| Run | Date | Pass | Staged from | `exitReason` | Played / passed / failed | What it was, and what was opened | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 22 | 2026-09-28 | `tools`, EN, full suite | `271365b` | **passed** | 21 of 21 / 21 / 0 | Final pass of the frozen 1.0.0 revision (changelog dated, images committed). Both `07` stills of the run are the images that were validated | `final-english-2/` (summary, junit, log, the `@review` still, film; the two Workshop stills deleted 2026-10-02, kept as `Art/Gallery/1-`, `2-`) |
| 23 | 2026-09-28 | `tools`, FR, full suite | `271365b` | **passed** | 21 of 21 / 21 / 0 | Same revision, French | `final-french-2/` (summary, junit, log, the `@review` still, film; the two Workshop stills deleted 2026-10-02, kept as `Art/Gallery/1-`, `2-`) |

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
