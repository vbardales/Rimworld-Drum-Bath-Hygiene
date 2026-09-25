---
localization: not_applicable
translation_en: not_applicable
translation_fr: not_applicable
mod:          Drum Bath Hygiene
packageId:    nelim.drumbathhygiene
repo:         Rimworld-Drum-Bath-Hygiene
remote:       https://github.com/vbardales/Rimworld-Drum-Bath-Hygiene.git
folder:       C:/Users/nelim/Documents/rimworld/DrumBathHygiene
visibility:   public
repo_visibility: public
detached:     yes
stage:        tested
settings_audit: not_applicable
build_audit: complete
automated_tests: complete
xml_tests: complete
functional_scenarios: complete
in_game_tests: complete
audit_revision: 759aa3716b4cbff3d071c691f6903bac5ebc3307
licence:      open
license_spdx: MIT
licence_at:   LICENSE and Mod/LICENSE; original integration code, third-party dependencies credited in ATTRIBUTION.md
owner:        Codex, task attached to this local repository
dependencies: declared
showcase:     preview approved by user; visual QA passed at full size and thumbnail; not verified in game
tested_on:    Pickle suite in game (RimWorld 1.6, Linux under WSL, Xvfb), English (run 8) and French (run 9), 2026-09-23: 19 scenarios of 19 played and green in each, exitReason passed, from revision 9df3305; earlier: Release rebuild and the Windows PowerShell XML/packaging suite, 2026-09-22
workshop:      3806137182; 0.1.0 prepublication by the owner on 2026-09-22: an upload that only creates the item (private, as Steam creates them) and its PublishedFileId.txt. An act, not the `prepublished` stage; visibility and the live page were not queried
remaining:
  - publication: CHANGELOG.md records 0.1.0 (the prepublication) and keeps 1.0.0 as unreleased above it; 1.0.0 is the version that arrives with `published`. No tag and no GitHub release exist yet, PUBLICATION.md written on 2026-09-24; the workflow, the Workshop images, the two corrections to the sent description and the release notes' upload are still to do (see it).
  - open: the Workshop description, already sent with the 0.1.0 prepublication, says nothing breaks without the two dependencies. No run shows it and none can (a pass excludes only DLCs); it can only be corrected by hand on the Steam page.
  - unverified: `07-workshop-captures.feature` (2 scenarios, the two Workshop images) has never run, and neither has the `tools` pass it needs (`wsl-deps.tools.map`: the bare pass plus the step package `nelim.pickletools.inspecttabs`). The suite is now 21 scenarios in 7 features; the `tested` stage rests on the first 19 (runs 8 and 9, revision 9df3305). Since then the order step fails at once on a dead job, the no-need scenario reads what the component bound, and the captures pause the game before the shot (all of it suite, not mod). English and French `tools` passes are queued.
  - open: `Mod/About/Preview.png` was re-rendered on 2026-09-24 with the summary narrowed from 430 to 290 px so it no longer sits on the bath's rim (contrast of the summary 5.96 -> 10.55); `Mod/` differs from the 0.1.0 upload by that image, and the Steam page keeps the old one until it is replaced by hand.
  - feature: fire intensity, deferred in BACKLOG.md.
updated:      2026-09-23
---

# Drum Bath Hygiene — status

`stage` uses the workflow's own state names: `tested` = `done -> tested` established, the next
state is `prepublished`. Codes used by this file: `done`, `tested` (this one), `prepublished`, `published`.

## Workflow audit — 2026-09-23: `done` -> `tested`

Audited revision: `759aa37` (`main`); the two passes were staged from `9df3305`. `Mod/` and `Source/` have not changed since `d7e1737` other than the Workshop id file (the distributed DLL is still SHA256 `865ACC8A…`), so the runs are of the mod as it stands. Only the suite changed between the first Pickle runs and these two.

Result: **`done` -> `tested`.**

| `done -> tested` criterion (AUDIT.md, section 9) | Result | Evidence |
| --- | --- | --- |
| Functional scenarios played in game and passed | Met | Pickle plays prose scenarios 0-3 and 5-9; 11 is offline (`Test-Mod.ps1`); 4, 10, 12 are not applicable with their reasons (TESTING.md, "What covers what") |
| Pickle suites run and green, `@review` captures actually opened | Met | Run 8 (English) and run 9 (French): `exitReason: passed`, 19 of 19 played, 0 failed, 0 skipped. Both stills and both films opened: the colonist sits in the drum, the panel reads the bath line in each language |
| Scenarios played against features discovered; `exitReason` read first | Met | 19 written in 6 features at `9df3305`, 19 played, in both passes; `exitReason` read before the counts. `07` (2 scenarios) was added afterwards and has not run: see `remaining` |
| Logs checked, interface in FR and EN | Met | Every bath scenario ends on `no warnings from mod` and `no errors were logged`; the one `[ERROR]` in each log is start-up, the companion test mod having no def |
| Options, persistence, MainButtons | Met, not applicable | No settings and no shortcut (`settings_audit: not_applicable`); persistence is the two scribed values, covered by the save-and-reload scenario |
| New game and existing save | Partly, by judgement | Existing save loaded in every scenario and reloaded mid-bath. A new colony was not played and adds no case (no scenario part, no world generation, no game component); this is an argument, not a run |
| Fixes followed by regression tests | Met | The fixes since the first runs were to the suite only; the mod is unchanged; the offline suite passes |
| No `@wip` | Met | Searched: none |
| Every conditional scenario ran | Met, vacuous | None is `@requires:`: the mod declares no optional mod |
| No manual test left to validate | Met | Every prose scenario is automated and green or not applicable with its reason |

Details of the judgements above, as they stood in `remaining` before this audit:

- existing save covered, new colony not played (a judgement, not a run). Every Pickle scenario loads the `test-colony` save and one reloads it mid-bath (runs 8 and 9). A new colony adds no case: the mod has no scenario part, no world generation and no game component, so nothing in it depends on how a colony began. Dependency versions and Player.log are in docs/runs/README.md (runs 8 and 9).
- English and French display, by the `@review` capture of each pass, opened (runs 8 and 9): the colonist sits in the drum and the panel reads the drum mod's bath line in each language. The text is Dubs Bad Hygiene's and the drum mod's, not this mod's (translation fields above); what was established is that both languages render it, not that this repository translates anything.
- the thirteen prose scenarios no longer wait for a person (TESTING.md, "What covers what"): Pickle played 0-3 and 5-9 and both passes are green (scenarios 5 and 9 included), `Test-Mod.ps1` covers 11, and 4, 10 and 12 are not applicable with their reasons. One consequence of 10 stays open below (the Workshop description).
- no scenario is `@wip` and none is `@requires:` (the mod declares no optional mod), by a search of the features on 2026-09-23 before this stage was claimed; 19 scenarios in 6 features at `9df3305`, 19 played in each pass (feature `07` was added after, and carries no such tag either).
- the first 19 scenarios of the Pickle suite under Tests/Pickle/ (6 features, revision `9df3305`) are green in full in English and French on 2026-09-23 (runs 8 and 9, `docs/runs/README.md`), after seven earlier runs that were not: the sixth and seventh passed 15 of 19 each, four different ones, all failures of the suite (the ordered bath job was malformed; a removed need came back), both fixed in 9df3305. Both `@review` captures were opened and show the bath. Runs 8 and 9 were replaced on 2026-09-25 by the final passes of the suite with `07` (21 of 21, English and French, `docs/runs/README.md` runs 10 and 11); the verdict files are in `.build/evidence/final-english/` and `final-french/` (ignored by git), and the Workshop stills in `studio-images-3/`.
- runtime behaviour of the reflection calls, in the scenarios that assert their effect: the water memory (`ColdWater`, `HotBath`), `SoakingWet` cleared, `WashPrivacy` stacking with an onlooker, the hygiene gauge rising, and no warning from the mod in any bath scenario. The call to `ApplyBathroomThought` is not asserted (Dubs Bad Hygiene's own grading of a room, not applicable, TESTING.md scenario 4); it goes through without a warning. The five targets were also re-read statically on 2026-09-21 in BadHygiene.dll 3.1.2800.
- cold water on arrival (the burnt-out drum scenarios, ordered and teleported). Removal of the mod from a mid-bath save is the game's handling of its mod list, not applicable (TESTING.md scenario 12).

What this stage does **not** say: nothing about `prepublished` (PUBLICATION.md, the ordered captures, thanks, release notes, the adult-content answers and the tag are not started), and the Workshop description, already sent with the 0.1.0 prepublication, still claims nothing breaks without the two dependencies, which no run shows and only a hand edit on the Steam page can correct.

## Workflow audit — 2026-09-22

Audited revision: `d7e1737b56b44b560ae3eeb71401f03f5dfd353f` (`main`). The working tree was clean
before the audit. The only audit action before the checks was the requested local commit of
`Mod/About/PublishedFileId.txt`, which contains Workshop item `3806137182`; the owner reports
that version `0.1.0` has been published. At the time of that audit, `main` was seven commits ahead
of `origin/main`, including that ID commit. The audit record was subsequently committed as
`b4b6480` and pushed; `git ls-remote origin refs/heads/main` confirmed that the remote points to
the same commit. No Steam page, visibility or subscription was queried, and RimWorld was not launched.

Result: **`done` -> `done`, unchanged.** A Workshop item existing does not establish the
intermediate `done -> tested` and `tested -> prepublished` criteria retroactively. The current
Pickle suite was changed after its recorded runs and has not been rerun; the documented manual
scenarios, bilingual in-game display, Player.log, new-colony and existing-save validation remain
unverified. `CHANGELOG.md` also still describes an unreleased `1.0.0`, so it does not document
the owner-reported `0.1.0` publication or provide release notes for it. That is a publication
record discrepancy, not evidence of a gameplay defect.

| Transition / control | Result | Evidence checked on 2026-09-22 |
| --- | --- | --- |
| horsMonoRepo -> ModIcon | Validated | `dotnet build Source/DrumBathHygiene.csproj -c Release --no-restore -t:Rebuild`: 0 warnings, 0 errors. Distributed DLL SHA256 remains `865ACC8A92D27700C182C48F6BE82346F43EA73D4A644B68D9A486E57F017003`. `ModIcon.png` decoded as PNG, 128 x 128, 22,318 bytes, and was directly inspected. |
| ModIcon -> Preview | Validated | `Preview.png` decoded as PNG, 896 x 504, 518,417 bytes (< 1 MB), and was directly inspected: title, summary, 1.6 badge and drum bath are legible; no clipping was found. |
| preOptions -> options | Justified not applicable | Current source/XML search again found no settings class, settings window, `MainButtonDef` or `MainTabWindow`; only technical log text was found. No empty settings UI or shortcut is warranted. |
| options -> l10n | Justified not applicable | Current source/XML search found no owned `Translate()`/Keyed/DefInjected player-facing resource. The technical `Log.Warning` strings remain outside the player-translation gate. |
| preTest -> done | Validated, retained | The source and distributed mod artefacts remain unchanged since the earlier static validation; the build above succeeded. Windows PowerShell 5.1 ran the metadata, licence, packaging and ten XML patch cases successfully, then could not load `System.Reflection.PortableExecutable.PEReader`; PowerShell 7 remains the reproducible route for its final metadata section. |
| done -> tested | Unverified | No game was launched. The changed Pickle suite, manual scenarios 0-12, EN/FR in-game display, logs and save coverage have not been newly established. |
| tested -> prepublished / prepublished -> published | Not established | The committed ID is now pushed to `origin/main` (remote HEAD confirmed at `b4b6480`). A release tag, matching published release, aligned `0.1.0` changelog/release notes, live-item subscription test, Steam visibility check and required publication materials are not established by this audit. |

`git diff --check` passed and the tree remained clean after the rebuild. The build initially
needed access to the local Windows SDK cache; once permitted, it completed successfully. This
environment restriction is not a mod defect.

## Workflow audit — 2026-09-21

Audited revision: `b23b20b32afe60086e64120e4db4594ec08b9eed` (HEAD of `main`, equal to the
remote HEAD). Working tree clean before the audit; the only local change is this STATUS.md,
left uncommitted. Nothing was published, generated or launched: **no RimWorld process was
started**, and none was running on the Windows side when checked (`Get-Process RimWorldWin64`
found nothing). The WSL side was not queried because nothing here needs a game.

Result: **`done` → `done`, unchanged.** The previous audit was on `5758baa`; two commits
followed (`212757c`, `b23b20b`) that only respell the author and copyright holder as
`Nelim` in `About.xml`, `LICENSE`, `Mod/LICENSE` and STATUS.md. No source, patch, image or
DLL changed, so no independent validation from the 2026-09-13 audit was invalidated. The
workflow's 2026-09-21 clarification (no in-game test is required to reach `done`; every
in-game check, Pickle included, belongs to `done → tested`) matches how this mod was already
classified: the `done` criteria were met without any game session.

| Transition | Result | Evidence re-checked today |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Top level `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`, git dir `.git`, no superproject. `origin` = `github.com/vbardales/Rimworld-Drum-Bath-Hygiene`; `gh repo view` says PUBLIC, `git ls-remote origin HEAD` = local HEAD. README, ATTRIBUTION, CHANGELOG, MIT LICENSE present; `LICENSE`/`Mod/LICENSE` and both `ATTRIBUTION.md` copies byte-identical (`diff`). Licence `open`, visibility `public`, package ID / name / repo / folder coherent. |
| horsMonoRepo -> ModIcon | Validated | Forced Release rebuild: 0 warnings, 0 errors, DLL SHA256 `865ACC8A…F017003`, identical to the shipped one before and after (git status stays clean). `Mod/About/ModIcon.png` opened: 128 x 128, 22,318 bytes, mascot with towel and duck legible. |
| ModIcon -> Preview | Validated | `Mod/About/Preview.png` opened at full size: 896 x 504, 518,417 bytes (< 1 MB); title, summary, 1.6 badge readable, bath and lantern identifiable, no clipping. |
| Preview -> preOptions | Validated | Turquoise accent rule vs warm ochre stone visibly distinct in the opened image. `About.xml`: English description, no prefix/suffix/linking word issue, ends with `[url=https://github.com/vbardales/Rimworld-Drum-Bath-Hygiene]Source code on GitHub[/url]`, same repository as `<url>` and the remote. |
| preOptions -> options | Justified not applicable | Unchanged source: no settings class, window, `MainButtonDef` or empty page (`settings_audit: not_applicable`, see the 2026-09-13 section). Nothing in this audit touches options. |
| options -> l10n | Justified not applicable | Unchanged source: no owned Keyed key, DefInjected path or player-facing string; logs are technical English. All three translation fields stay `not_applicable`. |
| l10n -> preTest | Validated | Installed dependency `About.xml` files still match `Mlie.MMDrumcanMOD` (1.6 listed) and `Dubwise.DubsBadHygiene` (modVersion 3.1.2800, 1.6 listed); both DLL SHA256 values are the ones recorded on 2026-09-13, so nothing moved. Both are in `modDependencies` and `loadAfter`. `DrumBath` and `Hed_BathingAtDrumBathPassive` are still defined in `Defs/Drumcan_Bath.xml` of the drum mod. No own `LoadFolders.xml`. |
| preTest -> done | Validated | Thirteen functional scenarios (0-12) plus the language check are written in `_tools/FUNCTIONAL-SCENARIOS.md`. XML suite: ten patch cases, metadata, licence/packaging checks pass (see below). Pickle suite written on 2026-09-21 under `Tests/Pickle/`, with its scope justified in `TESTING.md` and `Tests/Pickle/README.md`; it is not executed, which this transition does not ask for. |
| done -> tested | Unverified | No scenario played in game, no bilingual display check, no Player.log, no new-colony or existing-save run. Requires a RimWorld run, which this audit does not perform. |

### Executed checks and limits

- `git rev-parse --show-toplevel --git-dir --show-superproject-working-tree`, `git status
  --short`, `git ls-remote origin HEAD`, `gh repo view ... --json name,visibility,url`,
  `git diff --check`: as described above.
- `dotnet build Source/DrumBathHygiene.csproj -c Release --no-restore -t:Rebuild`: passed.
- `_tools/Test-Mod.ps1`: `pwsh` (PowerShell 7) is **not installed** on this machine today, so
  the script was not run as written. Under Windows PowerShell 5.1 its first half **passed**
  (metadata, licensing, packaging, ten XML patch cases); its second half stops there because
  `System.Reflection.PortableExecutable` is not available in 5.1. That second half (access
  waiver and component types in the compiled DLL) was replaced by an equivalent throwaway
  .NET 8 metadata reader that lives outside the repository: `IgnoresAccessChecksTo("Assembly-CSharp")`
  present, both `HediffCompProperties_DrumBathHygiene` and `HediffComp_DrumBathHygiene`
  present. `_tools/Test-Mod.ps1` was not modified; running it under PowerShell 7 remains the
  reproducible route.
- Static check of the reflection targets, same throwaway reader, against the installed
  `BadHygiene.dll`: `Need_Hygiene.clean(Single)` public instance; `PrivacyUtil.BathingPrivacyLOS
  (Pawn, Single)` public static; `SanitationUtil.WaterTempCheck(Pawn, Boolean, Boolean)` and
  `ApplyBathroomThought(Pawn, Thing)` public static; `DubDef.SoakingWet` public static
  `ThoughtDef`. This is metadata only: it says nothing about behavior at runtime.
- The three images were opened and looked at directly; sizes read from disk and from
  `System.Drawing`.

### Correction of the same day: the Pickle suite was missing, and its absence was wrongly justified

The first version of this audit passed `preTest -> done` while recording that no Pickle suite
existed, on the grounds that "a Gherkin suite would only restate what a game must show". That
reads the criterion backwards. `preTest -> done` asks that what **only a running game can show**
stay in Gherkin, and for this mod that is nearly everything it does: a gauge filled through
another mod's method bound by reflection, two memories decided by the fuel in a real drum, filth
cleared out of a live tracker. None of it can be read in a def file. The suite was therefore owed,
not excluded, and the transition was not established when it was declared.

`Tests/Pickle/` now holds it: a companion mod that is never published, four feature files, and a
step assembly. What it covers, and why each scenario needs the game, is in
`Tests/Pickle/README.md`; how many passes it takes, and why two rather than the three families
`../AUDIT.md` asks about, is in `TESTING.md`.

- **A step assembly was necessary.** Pickle ships `{string} needs {string} is below {int} percent`
  and no matching "is above". This mod's central claim is that a gauge goes UP, so its main
  assertion had no built-in form; inventing a plausible one would have been an undefined step and
  a wasted run. `DrumBathHygiene.PickleSteps.csproj` builds clean, 0 warnings, 0 errors, into
  `Tests/Pickle/Mod/Pickle/Assemblies/`. It references no Dubs Bad Hygiene type: hygiene is read
  through vanilla `Need.CurLevel` and filth through `Pawn_FilthTracker.CarriedFilthListForReading`,
  both public.
- **Every step line was checked against the catalogue before being written down.** The 201
  built-in patterns were read out of the Pickle assemblies' own attribute blobs and the 16 own
  patterns out of the built step DLL, then matched against all 110 step lines in the four feature
  files. All resolve. Five lines matched nothing in that scan — `the save {string} is loaded` and
  `I save and reload` — because Pickle registers those through its fluent API rather than an
  attribute; both appear verbatim in Pickle's own shipped sample features, which is what
  establishes them. This is a static check, not a run: it proves no step is undefined, not that
  any scenario passes.
- **Three prose scenarios stay out of the suite, and are named where a reader meets them:** the
  bathroom thought, which asserts DBH's room grading rather than this bridge's call and needs a
  scored room the fixture has not got; and prose scenarios 10, 11 and 12, which need a modlist
  without a hard dependency, or the mod removed mid-save, neither of which a run can arrange for
  itself.
- **Two passes, not three families.** No pass with optional mods: `loadAfter` names only Core and
  the two hard dependencies, all staged on every pass, so a named set would be a second name for
  the first one. No incompatibility pass: nothing declares an `incompatibleWith` and no document
  claims a conflict, so there is no assertion to go and re-check. The second pass is
  `-Language French`, which the suite supports because no step spells an English label.

### First Pickle run — 2026-09-21, English pass

Run through `scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene` in the WSL, under Xvfb, after a queue
wait behind other sessions; nothing was launched on the Windows install. Read in the order the
protocol requires: `exitReason: failed` (the run went to the end, it was not killed), then scenarios
played against scenarios written — **11 of 11** — then the numbers: **8 passed, 3 failed**.

None of the three failures was a defect of the mod, and STATUS records them as findings, not as
corrections to the mod: an animal scenario whose hediff step (Pickle's, which looks colonists up by
nickname) could not find a muffalo; and two water scenarios that asserted a Dubs Bad Hygiene
behaviour DBH does not have. `WaterTempCheck`, read from the IL of BadHygiene.dll 3.1.2800, grants a
hot-bath memory only to a pawn with hypothermia, and nothing for warm water on a healthy one. The
cold case was mis-named (`ColdBath` for `ColdWater`); the report showed `ColdWater (-3)` on the
pawn, so the mod did what it should.

What passed, and is worth stating plainly: the patch lands on the hediff the game built; the gauge
climbs, with a control that does not; half a bath fills an empty gauge; a bath survives a save and a
reload and goes on washing; the soaking-wet memory is forgotten on the way in; the carried filth is
cleared on the way out — which is the `IgnoresAccessChecksTo` waiver executing on a live tracker; and
the gauge stops when the bath does.

**The `@review` capture, opened: it did not show a colonist in the bath.** The colonist stands beside
the drum with the info panel reading "Washing." while the scenario was green. Cause: free colonists at
low hygiene get a job of their own from Dubs Bad Hygiene, and the scenario had teleported one onto
the drum and let go. This is the trap the audit protocol names, met in this session. It also means the
green `hygiene rose` assertions of that run were not fully insulated from a colonist doing something
else, so the suite was changed rather than trusted: every scenario that puts a pawn in the bath by
teleport now drafts it, the control included, and four scenarios go through the drum mod's own
job — one end-to-end wash, the chilled pair in a burning and in a burnt-out drum, and the capture.
The chilled pair is the only thing that can see the component's drum lookup miss under a pawn the
real driver placed; if it did, `cold` would default to true and hot water would never happen.

**A second run, the same afternoon, on the changed suite: 16 of 16 played, 12 passed, 4 failed.** The teleported scenarios all passed, chilled pair included, which confirms the reading of `WaterTempCheck` above. The four failures were all in what the changed suite had added, and again none was a defect of this mod: the animal scenario still gave the hediff by hand and the drum mod's own render patch (`DrumBath_Harmony.PawnRenderer_RenderPawnAt.Prefix`) threw on a pawn with the hediff and no job; and the three real-job scenarios failed on the step right after "is bathing". I first attributed that to the bath ending at once on full joy, set joy low, and reran: **the same three failed the same way**, which refuted the explanation. The game log then showed the whole scenario lasting 9.9 seconds with no job warning. The cause was mine: the "is bathing" step was a `void` calling `AssertEventually` and discarding the `Task` it returns, so it never waited and could never fail. Every use of it, the capture's second assertion included, was vacuous, and the capture was green over the colonist far from the drum reading "Washing." three runs in a row. The step now awaits (`async Task`, `await ctx.WaitUntil`), as AnimaSong's do. Whether the bath then holds for the length the capture needs is still unknown: what the real driver does with a colonist ordered into the drum has not yet been observed.

**A fourth run followed, with the step awaiting: 11 of 16 passed, 5 failed** - exactly the five scenarios that go through the drum mod's real job, each timing out at about 98 seconds with nothing in the game log but the timeout. The bath the drum mod's driver runs has therefore **not been observed once**, and the reason is open (never set off, sent elsewhere, unreachable drum, a job that ends unseen). It is not a finding about this mod: nothing has yet shown the component running under a real bath at all. The eleven scenarios that hand the component a hediff pass, including hot and cold water on a healthy and on a chilled colonist. The step now reports a job trace on timeout so that the next run answers the question.

**A fifth run, with the step reporting a job trace and the capture filmed, reversed the fourth run's reading: the real bath works.** The trace has the colonist walk across the map, take `Job_BathingAtDrumBath`, and stand on the drum's own cell (142,155) with the job running and the hediff on for about ten seconds; the film shows her sitting in the drum, panel "Relaxing in the bath while watching the passing clouds". The five failures were the suite's: its condition demanded `CurJob.targetA.Thing == drum`, which the drum mod's driver evidently rewrites, and the animal never took its ordered job (the drum mod bathes animals through its own component). Both changed; the animal scenario is now a colonist without a hygiene need through the real job. That the driver places the bather on the cell this mod looks under is the first real evidence that hot water can happen in play at all, and it is still to be confirmed by the chilled-colonist scenarios.

**Sixth and seventh runs, 2026-09-23 (English, French): 15 of 19 passed in each, four different ones.** The thirteen scenarios that order no bath all passed. The order had never worked: the drum mod's job has the drum's cell in target A and the drum in target B, the suite put the drum in A, the job ended inside `StartJob`, and colonists bathed only when the drum mod's own joy giver happened to send them. The fifth run's reading above ("the driver rewrites `targetA`") was a wrong inference from that. The French capture was green over a screenshot of a colonist cleaning sand. Details in `docs/runs/README.md` (runs 6 and 7) and `Tests/Pickle/README.md`. Fixed in `9df3305`, not yet run.

**Those runs are superseded and the suite as it now stands has not been run.** The French pass is also
owed. Both remain `unverified` under `done -> tested`. Nothing about the mod was changed; the
documents that asserted the wrong DBH behaviour were: scenario 3 of
`_tools/FUNCTIONAL-SCENARIOS.md` (which expected a `hot bath` memory for a healthy colonist) and both
`ATTRIBUTION.md` copies (which spoke of "the hot-bath or cold-bath thought").

### Remaining gate and separate items

To reach `tested`: run the Pickle suite twice, once per language, through
`scripts/Run-PickleWsl.ps1 -Mod DrumBathHygiene` and the same with `-Language French` (the Workshop ids of the two hard dependencies, which the shared staging table does not know, are in `Tests/Pickle/wsl-ids.map`; a first attempt on 2026-09-21 stopped in staging for lack of them, before launching anything), reading
`exitReason` before the numbers and scenarios played against features discovered before either;
then open the `@review` capture of each pass rather than counting its green. Then play
scenarios 0-12 and the English/French display check of
`_tools/FUNCTIONAL-SCENARIOS.md` in a game the owner starts, on a new colony and an existing
save, recording game and dependency versions, per-scenario outcome, hygiene values and
Player.log; include cold arrival, mid-bath reload and removal, and both missing-dependency
cases; rerun the regressions of any fix.

Optional, not blocking any transition up to `tested`: no `.gitattributes` and no IDE ignore
patterns; `CHANGELOG.md` still says `1.0.0 — unreleased` with no tag or release; `About.xml`
credits Claude Code for the code while the `owner` field above names Codex, worth aligning
the next time the file is edited. Items belonging to `tested → prepublished` (a
`PUBLICATION.md`, thank-you messages, Steam release notes, adult-content answers, capture
order) were not evaluated and are not defects.

## Workflow audit — 2026-09-13

Follow-up documentation corrections, 2026-09-13, on the same base revision: corrected
About.xml and CHANGELOG.md to describe the temporary bath state and leave save compatibility
explicitly unverified; aligned README.md with that limitation. Corrected the changelog's
hygiene direction and both attribution copies' SoakingWet entry timing. Replaced the
scenario introduction's unconditional failure attribution with a dependency-version check.
The documentation defects listed later in this dated audit are now resolved. Existing audit
edits were preserved. The audit-only change description below records the earlier audit,
not this follow-up. No gameplay code, patch behavior or images changed; `done` and the
justified settings/localization exclusions remain valid. The automated/XML suite was rerun
successfully after these edits; attribution copies match and `git diff --check` passes.
In-game checks remain pending. Optional repository housekeeping remains a recommendation.

Audited revision: `5758baa7c07581f7db27726ffbe1a5add0c8720d`. The working tree was
clean before the audit. Only this STATUS.md is changed by the audit; the forced Release
rebuild reproduced the shipped DLL byte for byte. No source, XML, image, scenario or
historical result was changed; nothing was committed or published.

Applied `../PUBLISHING.md`, `../STYLE_RIMWORLD.md`, `../MOD_SETTINGS.md` and
`../TRANSLATIONS.md`, with the user's ordered workflow and interpretation taking precedence.
The previous `validation` value was a legacy label, not evidence of any particular gate.
The new `stage: done` uses the workflow's literal state: all gates through `preTest -> done`
are established, ready for final in-game validation, **not** `tested`.

| Transition | Result | Current evidence |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Independent Git top level and `.git`, no superproject; configured GitHub origin; live public repository and remote HEAD equal audited revision. English README, attribution, MIT license and changelog exist; distributed license and attribution match root copies. Original bridge code, no bundled dependency/game code; public/open classification remains justified. Package ID, display name, repository and directory consistently identify this integration; no continuation/private suffix applies. |
| horsMonoRepo -> ModIcon generated | Validated | Current scoped implementation complete; fire intensity is explicitly deferred, not unfinished promised functionality. Forced Release rebuild passes and matches shipped DLL. Directly inspected PNG icon: 128 x 128, 22,318 bytes, mascot and bathing objects recognizable. |
| ModIcon generated -> Preview generated | Validated | Directly inspected delivered PNG: 896 x 504, 518,417 bytes, below 1 MB. Original and composition files preserved in Art/. No concrete camera defect identified; no historical generation report or recorded game-camera comparison required. |
| Preview generated -> preOptions | Validated | Inspected full-size preview and existing 268-pixel thumbnail; title/version readable, no clipping, subject identifiable. Cool turquoise accent separates from warm ochre secondary ink in the palette; HTML consumes that JSON. English description and title; no prefix, suffix or linking word requires reduction. |
| preOptions -> options | Justified not applicable | Settings inventory below: no relevant user settings, empty page or MainButtons shortcut. In-game checks are not required for this gate under the user's interpretation. |
| options -> l10n | Justified not applicable | Re-read all three C# files and shipped XML: no owned UI text or translatable Def fields introduced/overridden. All three translation fields remain not_applicable. |
| l10n -> preTest | Validated | Installed dependency About files match both declared IDs and support 1.6; both are loaded before this integration. Actual upstream root Defs contain DrumBath and Hed_BathingAtDrumBathPassive. No own LoadFolders or additional version/optional patches. Both mods are required for useful behavior; graceful absence handling does not make their dependency declarations incorrect. |
| preTest -> done | Validated | Existing thirteen functional scenarios have setup, actions and expected outcomes. Existing automated metadata/packaging tests and ten XML patch cases executed successfully against the identical shipped DLL and XML. |
| done -> tested | Unverified | No gameplay execution, bilingual UI inspection, session log validation or new/existing-save runtime result produced. Settings UI, persistence and shortcut checks are not applicable; bath-state save/reload remains required. |

### Settings audit

Reviewed all of Source/ and Mod/, including component properties, bridge calls and both
XML branches. `cleanPerTick = 0.0005` is the internal integration rate (2000 ticks to fill
an empty gauge); `privacyCheckInterval = 300` is an internal polling cadence. These are
fixed compatibility defaults, not a documented player configuration contract. No concrete
need to expose the polling interval or introduce a separate balancing interface was found.
Water temperature, room and privacy effects delegate to dependency behavior. There is no
inherited settings class, config file, settings window or MainButtonDef in this package.
The only saved values are per-bath `started` and `ticks`, not user settings. Searches for
ModSettings, SettingsCategory, DoSettingsWindowContents, MainButton and MainTabWindow,
plus full source/XML reading, confirm absence of an empty page and shortcut.
Therefore `settings_audit: not_applicable`; no RIMMSQOL or other customization integration
was tested or is claimed. Option input/reset/migration and option persistence tests have
no target. The shipped XML defaults are checked by the executed XML suite.

### Executed checks and limits

- `git rev-parse --show-toplevel --git-dir --show-superproject-working-tree`,
  `git status --short`, `git remote -v`, `git log -1`: independent repository at the
  recorded folder; clean starting tree. No requirement to restore a monorepo remote.
- `gh repo view vbardales/Rimworld-Drum-Bath-Hygiene --json name,visibility,url` and
  `git ls-remote origin HEAD`: PUBLIC, correct URL, remote HEAD equals audited revision.
- `dotnet build Source/DrumBathHygiene.csproj -c Release --no-restore -t:Rebuild`:
  passed, zero warnings/errors, cached Krafs.Rimworld.Ref 1.6.4871 and Publicizer 2.3.2.
  Initial sandbox attempts could not access GitHub/SDK paths; the authorized retry succeeded.
  These initial environment errors are not mod build defects.
- DLL SHA256 before and after rebuild:
  `865ACC8A92D27700C182C48F6BE82346F43EA73D4A644B68D9A486E57F017003`.
- `pwsh -NoProfile -File _tools/Test-Mod.ps1`: passed before and after the successful
  rebuild. Ten XML cases, metadata/licensing/packaging, component types and access waiver.
  The XML interpreter is not the game patch engine; metadata tests do not execute gameplay.
  No isolated gameplay harness exists. Pawn/map/DBH runtime behavior is assigned to the
  written game scenarios, not falsely reported as automated coverage or non-applicable.
- Direct image inspection and System.Drawing decoding established PNG formats/dimensions;
  file sizes checked from disk. Historical contrast/font measurements remain historical;
  they were not rerun, and no visual issue was identified requiring a new render.
- Installed dependency metadata read under
  `C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/`:
  `3417093756` (MMDrumcanMOD, root Defs plus 1.6 assembly) and `836308268`
  (DBH modVersion 3.1.2800, 1.6 assembly). Both About IDs match the shipped declarations;
  neither has a LoadFolders.xml. MMDrumcanMOD declares its own Harmony dependency;
  this bridge does not directly use Harmony and need not duplicate that transitive dependency.
  No unestablished minimum dependency version is invented.
- Current dependency DLL SHA256: DrumBath.dll
  `EAF75AE3DFE08285F0018D275E9858D290EB599BF7F2F780CA0E3A70CF399D8F`;
  BadHygiene.dll `511A4EC97D04C232F09E3F1E7EFDE20C44B66B52563E03FB4359E3823AAAB597`.
  Runtime reflection compatibility is still unverified; the historical reflection check
  is not a current integration test.
- Localization tracing confirms zero owned Keyed keys, DefInjected paths or parameterized
  messages. Technical logs/internal names are excluded. Native dependency text is neither
  copied nor explicitly translated here; no redundant EN/FR resources or path checker needed.

### Remaining gate and separate findings

To reach `tested`, execute scenarios 0-12 and the English/French language display check
in `_tools/FUNCTIONAL-SCENARIOS.md`, explicitly covering a new colony and an existing save.
Record game/dependency versions, observed outcomes, hygiene values and Player.log. Include
cold arrival, mid-bath reload/removal and missing dependencies; fix any failures actually
observed and rerun affected regressions. The installed files do not substitute for an
interactive game session. No gameplay failure is established by this audit.

Separate documentation defects, not failures of the next runtime gate: About.xml says
no save data of its own and CHANGELOG.md says no data is added to the save, whereas
CompExposeData writes two values. CHANGELOG.md says the rate empties a full gauge instead
of filling an empty one. Both attribution copies place SoakingWet removal on exit,
whereas OnEnterBath invokes it on entry. Historical scenario prose saying a future failure
cannot be a renamed member is too absolute; dependency signatures were not rechecked here.
These statements should be corrected before publication; no gameplay correction is inferred.

Optional repository housekeeping: the autonomous repository lacks the suggested
`.gitattributes` and IDE ignore patterns. No damaged artifact or tracked IDE file was found;
these are not promoted to extra mandatory workflow gates. Fire intensity remains optional
backlog work. The historical sections below are preserved as dated evidence, superseded
by this audit where they describe the old stage or old execution date.

## Ownership and repository

Codex now maintains this file as part of work on this repository. Update it whenever changes,
checks or remaining issues change; only record checks actually performed. This responsibility
applies to this local task, without an automatic background schedule.

The Git top level is `C:/Users/nelim/Documents/rimworld/DrumBathHygiene`. Its Git directory is
`.git`, and Git reports no superproject. This is an independent local repository, outside the
former monorepo. Both fetch and push use the remote above. GitHub visibility was verified as
`PUBLIC` using `gh repo view` on 2026-09-12.

## Title, description and license

`visibility` describes the mod's intended distribution, not GitHub repository visibility.
This mod is intended for public distribution: it is an original MIT-licensed integration,
with no copied dependency source files reported in ATTRIBUTION.md. This decision is independent
of the repository being public, recorded separately as `repo_visibility`.
No Workshop ID is recorded locally; current Steam visibility has not been verified.
Public distribution remains pending in-game validation.

Rules rechecked in `../PUBLISHING.md` (License section, 2026-09-12): `alive` requires a private
mod and `(prohibited)`; any private mod requires `(prohibited)` and the personal-use notice;
a public `silent` mod requires `(unofficial)` and the unofficial notice. Neither case applies
to this original MIT integration. A dependency being maintained does not itself make this
independently written bridge an `alive` reuse of unlicensed source content.

Keep **Drum Bath Hygiene** without a suffix. This repository implements an original compatibility
bridge, not a continuation or republication of MMDrumcanMOD. The dependency retains its own
name, **MMDrumcanMOD (Continued)**. No evidence in this repository calls for a title suffix.

`Mod/About/About.xml` contains the GitHub URL both in `<url>` and, since this audit, in the
visible `<description>` as its final Steam-formatted source link, as required by
`../PUBLISHING.md`. The package ID stays `nelim.drumbathhygiene`.

The actual license is **MIT**, copyright 2026 Nelim. `LICENSE` and the distributed `Mod/LICENSE`
are identical. The status category is `open`; `original` describes provenance, not the license
name. The previous claim that this mod owed no names or ideas to another mod was too broad.

Justification for retaining MIT: the repository documents independently written integration
code and distributes no copied source files from the two dependency mods. It references their
identifiers and calls DBH methods; both dependencies are credited in `ATTRIBUTION.md`. MIT is
consistent with the author's stated permission to reuse and continue this code with attribution.
It does not relicense RimWorld, MMDrumcanMOD or Dubs Bad Hygiene. Preview/icon generation is
credited separately in the attribution file. This audit retains the existing license.

## Translation audit — 2026-09-13

Applied `../PUBLISHING.md` and `../TRANSLATIONS.md` to revision
`b9d23a8b1594cd55191271dd6153be667217fccc` (source and shipped XML unchanged).
All three translation fields are `not_applicable`: the inventory found no owned
player-facing text added or changed by this integration.

- Reviewed all three C# files in `Source/`, the project/build configuration, and every
  file under `Mod/`. There are no alternate version folders, LoadFolders, language
  resources, settings, gizmos, menus, messages, inspect strings or generated sentences.
- Traced `HediffComp_DrumBathHygiene` through `DbhBridge`: it updates the existing hygiene
  need and delegates temperature, bathroom and privacy effects to DBH. The existing
  need, thoughts and drum-bath hediff retain their dependency-owned texts. No dependency
  translation keys are explicitly resolved, copied or overridden here.
- Reviewed both branches of `Mod/Patches/AddComp.xml`: they only set `hediffClass` and
  add the component with numeric tuning values. No label, description or other
  translatable field is added or replaced.
- The five logging call sites in `DbhBridge.cs` are technical diagnostics and remain
  English. Reflection names, defNames and the save keys `started`/`ticks` are internal
  identifiers. About metadata, documentation, licences and promotional image text are
  outside the in-game translation gate under the shared protocol.

Inventory commands: `rg --files --hidden -g '!.git'`,
`Get-ChildItem Mod -Recurse -File`, and
`rg -n 'Translate|label|description|Message|Log\.' Source Mod`, followed by full source
and XML review and tracing of the delegated calls. Owned Keyed keys: 0; owned
DefInjected paths: 0; owned grammar/string resources: 0. Parameter, duplicate-key and
injection-path checks therefore have no targets; `Check-DefInjected.ps1` is not applicable.
No empty language folders or duplicate dependency translations are needed.

This passes the translation gate by justified non-applicability, without changing the
historical `validation` stage. It does not certify the installed dependencies' English
or French coverage. Their visible integration effects still require the bilingual
in-game check recorded in `remaining`. No in-game language tests were run. Repeat this
inventory after source, Def, patch or text changes; reset affected fields to `unchecked`
until reviewed again.

## Reproducible automated checks

Run from this repository with .NET SDK and PowerShell 7:

```powershell
dotnet build Source/DrumBathHygiene.csproj -c Release
pwsh -NoProfile -File _tools/Test-Mod.ps1
```

Audit results on 2026-09-12:

- Release build with `--no-restore`: passed, zero warnings and errors, using the existing NuGet cache.
- All shipped XML files parse successfully; title, package ID, source link, dependency load order,
  matching license copies and exclusion of `Assembly-CSharp.dll` from the mod package pass.
- Ten XML patch cases pass: missing target def, plus all nine combinations of absent/plain/comp-capable
  hediff class and absent/empty/populated comps. Checks cover the final class, a single comps
  container, a single added component, tuning values, and preservation of existing content.
- Compiled DLL metadata checks pass: both component types exist and the assembly actually carries
  `IgnoresAccessChecksTo("Assembly-CSharp")`, needed for access to carried filth.

The XML suite applies the real patch XPath and payload through a small test interpreter. It is
not the RimWorld patch engine. Compilation and metadata checks do not execute the C# gameplay
or DBH reflection calls. Automated gameplay integration coverage remains absent; manual checks
below are required before claiming the mod works in game. No test project or reproducible
script was present before this audit; `_tools/Test-Mod.ps1` now provides the checks above.

## Manual functional validation

The thirteen scenarios in `_tools/FUNCTIONAL-SCENARIOS.md` exist and specify setup, actions and
expected outcomes. They cover startup and patch loading, hygiene progression/clamping, hot/cold
water, room thoughts, privacy, soaking-wet removal, carried filth, save/reload, successive baths,
missing dependencies, and adding/removing the mod from a save.

**Execution status: not run in this audit; no recorded in-game results.** Start with scenario 0,
then complete 1–12. Record game and dependency versions, pass/fail per scenario, hygiene values
for scenario 1 and the session Player.log. A prior reflection inspection is documented in the
scenario file, but its conclusions must be rechecked if dependency versions change.

Do not mark the mod ready for Workshop based solely on a successful build. No new Workshop
publication was performed. Fire intensity remains a deferred feature in `BACKLOG.md`.

## Preview overlay — 2026-09-12

Recomposed according to `../STYLE_RIMWORLD.md`. Retained the original illustration from
`Art/Preview-source.png` and copied it unchanged to canonical source `Art/Preview.png`.
No illustration was replaced; the existing full-resolution original remains preserved.
The title and summary were preserved exactly. No status tag or reduced title words apply.
The user approved the final preview and requested commit and push of this audit and its assets.

- Delivered image: `Mod/About/Preview.png`, 896 × 504, 518,417 bytes (under 900 KB).
- Composition and layout parameters: `Art/preview.html`; renderer: `Art/render-preview.cjs`.
- Single color reference: `Art/preview-palette.json`, loaded directly by the HTML.
- QA artifacts: `Art/preview-qa.json`, `Art/preview-background.png` (text hidden),
  and `Art/preview-268.png` (thumbnail).

The veil comes from the broad dark stone floor. The secondary ink is a lightened warm ochre
from the dominant stone/metal material family. The accent comes from the blue-green bath water,
with saturation and brightness increased: its cool turquoise clearly separates from the warm
stone family instead of repeating the orange lantern/fire. No secondary-colored text is needed
for this title, but its palette value is retained for future use.

Chrome rendered directly at final resolution after `document.fonts.ready` and source-image load.
Actual platform fonts were checked through Chrome DevTools: Segoe UI Semibold for the title,
Segoe UI regular for the summary, and Segoe UI Bold for the badge; no fallback was used.
The badge reads the highest stable version declared in the shipped About.xml: currently 1.6.

Contrast was measured against the text-hidden rendered PNG across every pixel of the full title
and summary rectangles, not merely their corners: minimum 11.04:1 for title and 5.96:1 for summary.
Badge contrast is 10.51:1. Tag contrast is not applicable because no tag is displayed.
Visual inspection at 896 × 504 and 268 px wide confirmed identifiable title/version, a visible
rule, no clipped glyphs or overlaps, and the bath remaining recognizable. The summary is intended
for the full-size image, as specified by the guide. Nothing was published.
