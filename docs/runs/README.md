# Pickle runs: what is kept, and where

A Pickle run writes a report of tens of megabytes: `report.html` (about 20 MB), `messages.ndjson` (13 to 19 MB) and
a `screenshots/` folder of hundreds of PNG files of about 3 MB each, shared by every mod on the machine. That does
not belong in a public repository, so it is split in two:

| What | Where | In git |
| --- | --- | --- |
| **Evidence**: the full report, the captures, the films, `Player.log` | `.build/evidence/<pass>/`, written by `Run-PickleWsl.ps1 -EvidenceDir DrumBathHygiene/.build/evidence/<pass>` | **No.** `.build/` is ignored |
| **Summary**: a short text file per run or per pass | `docs/runs/<date>-<pass>.md`, this folder | Yes |

The Evidence is a working copy: it survives on this machine only, and `PickleReports-archive` purges after five runs, so
copying it with `-EvidenceDir` at launch is what keeps it. The summary is what anyone else, or a later session, can read.

## What a summary must say

Written from the report, in this order, and only what was read:

1. **The pass**: date, `setName`, language, and the commit of the repository the run staged (`git rev-parse HEAD` at launch).
2. **`exitReason` first**, then scenarios played against scenarios written, then passed and failed. A run killed in
   flight leaves a `summary.json` that looks like a result; `exitReason` is the field that says.
3. **One line per scenario**: outcome and duration. For each failure, the message as the report gives it, and what it
   turned out to be (a defect of the mod, of the suite, of the environment, or not yet known).
4. **The captures**: which were opened and looked at, and what they actually show. A green `@review` scenario proves
   the path ran, not that the image shows a bath.
5. **Where the Evidence is** on disk, and what was not kept.

A summary does not restate what `TESTING.md` says about coverage, and it does not claim a scenario is covered: it says
what a run did.
