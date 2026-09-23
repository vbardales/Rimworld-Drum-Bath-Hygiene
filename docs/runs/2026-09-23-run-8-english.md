# 2026-09-23, run 8: English, the suite after the order fix, 19 of 19 green

`sans-facultatifs`, English, through `Run-PickleWsl.ps1`, staged from `9df3305` (the step assembly built from that
revision). Core, the five DLC, Harmony, RimLogging, Pickle, Dubs Bad Hygiene 3.1.2800, MMDrumcanMOD (Continued) and
the companion `Drum Bath Hygiene - Pickle tests`.

| `exitReason` | Played of written | Passed | Failed | Skipped |
| --- | --- | --- | --- | --- |
| **passed** | 19 of 19 | 19 | 0 | 0 |

`@wip`: none. `@requires:`: none (checked by a search of the features, not assumed). Every scenario ran once, no retry.
The wrapper's exit code was 0 and it printed no `No data available` (the line the English pass of run 6 printed after
another session had edited the launcher).

## Scenarios

All nineteen passed, from 11 s to 32 s each; the longest is the save-and-reload (31.6 s) and the two-baths scenario
(30.0 s). The five that go through the order to bathe passed in 17 to 30 s where the previous suite left most of them
waiting 90 s: the malformed job was the whole difference between runs 6 and 7 and this one. (The scenario with no
hygiene need no longer orders a bath: it gives the hediff, then removes the need.) One line per scenario is in
`summary.md` beside the Evidence.

## The capture and the film, opened

- **Still** (`manual--bather-in-the-drum--step0.png`): the colonist stands in the red drum, the inspect panel reads
  "Relaxing in the bath while watching the passing clouds.", the tooltip names her as Bather, Healthy. This is what the
  French capture of run 7 failed to show. One flaw, cosmetic: the game is drawn in the lower-left quarter of the 1920x1080
  image, the rest black; the cause was not looked into. It is legible; it is not a picture to publish.
- **Film** (16.8 s, sampled every 3 s): the loading screens, then the colonist walking across the map with the panel
  already on the bath's report line, then sitting in the drum. The order, the walk and the arrival are what the film
  shows; the bath's own length is not in it.

## What this run settles, and what it does not

It settles that the suite's order to bathe now takes, that the null-need branch is reached by the single step, and that
the capture shows a bath. It **does not** certify anything for French, nor `tested` alone: the French pass of the same
suite is still owed and queued.

## Evidence

`.build/evidence/tested-english-1/` (named that way because the empty folder of the earlier pass could not be
removed at launch): `summary.json`, `summary.md`, `report.html.gz` (1.9 MB), `messages.ndjson.gz`, `Player.log.gz`,
`junit.xml.gz`, the still and the film (3.1 MB together). The small copies of runs 6 and 7 in
`.build/evidence/run-english-2026-09-23/` and `run-french-2026-09-23/` stay until the French pass of this suite has run.
