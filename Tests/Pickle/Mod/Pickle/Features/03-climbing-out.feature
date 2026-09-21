# The way out, which is the half of this mod that a clean startup hides.
#
# CompPostPostRemoved does two things, and the first of them is the reason Source/AccessChecks.cs
# exists. Clearing carried filth reads pawn.filth.carriedFilth, a member that is not public in the
# real Assembly-CSharp: the compiler emits a cross-assembly access either way, and the CLR allows
# the instruction only because the assembly declares IgnoresAccessChecksTo. When that waiver went
# missing, nothing said so - the build stayed clean, the patch applied, every bath started
# normally, and every bath ENDED on a FieldAccessException thrown out of the hediff's removal.
#
# _tools/Test-Mod.ps1 reads the waiver off the compiled assembly, which is the cheap half of the
# guard. This feature is the other half: the instruction actually executing, on a real tracker,
# with real filth in it. A waiver present but pointing at the wrong assembly would pass the offline
# check and fail here.
#
# The second scenario is the mirror of the first feature's control. The gauge has to STOP when the
# hediff goes, and nothing in the component says so explicitly: it stops because the comp stops
# ticking with the hediff that carries it. A comp that had somehow outlived its hediff - bound to
# the pawn rather than to the bath - would pass every scenario in 01 and fail this one alone.
Feature: climbing out of the bath

  Background:
    Given the save "test-colony" is loaded

  Scenario: the mud carried on the body comes off at the end of the bath
    Given a colonist "Muddy" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: "Muddy" is carrying filth
    Then Drum Bath Hygiene: "Muddy" carries filth
    When Drum Bath Hygiene: "Muddy" climbs into the drum at x=142 z=155
    And "Muddy" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 60 ticks
    Then Drum Bath Hygiene: "Muddy" carries filth
    When "Muddy" is cured of hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then Drum Bath Hygiene: "Muddy" carries no filth
    And no errors were logged

  Scenario: the gauge stops when the bath does
    Given a colonist "Done" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Done" needs "Hygiene" is set to 10 percent
    When Drum Bath Hygiene: "Done" climbs into the drum at x=142 z=155
    And "Done" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 300 ticks
    And "Done" is cured of hediff "Hed_BathingAtDrumBathPassive"
    Then "Done" has no hediff "Hed_BathingAtDrumBathPassive"
    When Drum Bath Hygiene: I remember "Done" hygiene
    And I wait 600 ticks
    Then Drum Bath Hygiene: "Done" hygiene did not rise
    And no errors were logged
