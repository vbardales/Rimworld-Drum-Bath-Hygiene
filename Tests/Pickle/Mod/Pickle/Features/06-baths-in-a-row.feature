# Prose scenario 9, "Two baths in a row behave alike", as a scenario a run can play.
#
# The prose scenario says why it matters: "the bridge to Dubs Bad Hygiene is resolved once for the whole
# game session and shared; the per-bath state is not. A first bath that works and a second that does
# nothing would mean those two lifetimes have been confused." The shared part is DbhBridge, resolved on
# first use and cached in statics. The per-bath part is the component: `started`, `ticks`, and the
# delegate bound to the pawn's hygiene need, all on a hediff that is made anew each bath.
#
# WHAT MAKES "ALIKE" CHECKABLE. Three effects fire on the way in and one accrues during the bath:
#
#   - the water temperature memory - `ColdWater` here, because the drum is burnt out: warm water grants
#     a healthy pawn nothing at all (see 02-the-thoughts.feature), so a burning drum would leave the
#     second bath nothing to be seen by;
#   - the soaking wet memory, cleared;
#   - hygiene, rising.
#
# The memory from the first bath is forgotten before the second, otherwise `has thought ColdWater`
# would pass on what the first bath left behind and prove nothing about the second. Everything is
# asserted for the same colonist twice, and then for a colonist who has not bathed yet: "for both
# pawns", which is what tells a per-pawn failure from a per-session one.
#
# THE REAL JOB throughout, and joy pulled low before each order, as in 01-the-bath-washes.feature: the
# drum mod's driver ends the bath when joy is full, and a test colonist arrives with it full.
Feature: baths in a row behave alike

  Background:
    Given the save "test-colony" is loaded

  @timeout:600
  Scenario: the second bath washes as well as the first, for the same colonist and for another
    Given a colonist "Twice" exists
    And a colonist "Other" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 has burnt out
    And game speed is ultrafast
    # The first bath of the first colonist.
    And "Twice" needs "Hygiene" is set to 10 percent
    And "Twice" needs "Joy" is set to 10 percent
    And "Twice" is given thought "SoakingWet"
    When Drum Bath Hygiene: I remember "Twice" hygiene
    And Drum Bath Hygiene: "Twice" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Twice" is bathing in the drum at x=142 z=155
    When I wait 10 ticks
    Then "Twice" has thought "ColdWater"
    And "Twice" has no thought "SoakingWet"
    When I wait 300 ticks
    Then Drum Bath Hygiene: "Twice" hygiene rose
    And Drum Bath Hygiene: "Twice" has climbed out of the drum
    # The same colonist again, from the same starting point.
    When Drum Bath Hygiene: "Twice" forgets "ColdWater"
    And "Twice" needs "Hygiene" is set to 10 percent
    And "Twice" needs "Joy" is set to 10 percent
    And "Twice" is given thought "SoakingWet"
    And Drum Bath Hygiene: I remember "Twice" hygiene
    And Drum Bath Hygiene: "Twice" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Twice" is bathing in the drum at x=142 z=155
    When I wait 10 ticks
    Then "Twice" has thought "ColdWater"
    And "Twice" has no thought "SoakingWet"
    When I wait 300 ticks
    Then Drum Bath Hygiene: "Twice" hygiene rose
    And Drum Bath Hygiene: "Twice" has climbed out of the drum
    # A colonist who has not bathed at all, after two baths have gone through the same bridge.
    When "Other" needs "Hygiene" is set to 10 percent
    And "Other" needs "Joy" is set to 10 percent
    And "Other" is given thought "SoakingWet"
    And Drum Bath Hygiene: I remember "Other" hygiene
    And Drum Bath Hygiene: "Other" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Other" is bathing in the drum at x=142 z=155
    When I wait 10 ticks
    Then "Other" has thought "ColdWater"
    And "Other" has no thought "SoakingWet"
    When I wait 300 ticks
    Then Drum Bath Hygiene: "Other" hygiene rose
    And no warnings from mod "Drum Bath Hygiene"
    And no errors were logged
