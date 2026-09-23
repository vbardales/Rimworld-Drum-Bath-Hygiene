# Prose scenario 5, "Onlookers keep noticing", as a scenario a run can play.
#
# The bridge asks Dubs Bad Hygiene to look over the six cells around the bather three times: on the
# way in, every `privacyCheckInterval` ticks (300) while the bath lasts, and on the way out. The
# periodic check is this mod's own design, and the reason for it is the one sentence the prose
# scenario gives: "someone walking in halfway through is exactly the situation the memory is for". One
# check at the door would be cheaper, and wrong.
#
# WHAT DBH DOES WITH THE CALL, read from the IL of PrivacyUtil.BathingPrivacyLOS and
# CaresIfSeenBathingBy in BadHygiene.dll 3.1.2800 on 2026-09-23. The memory `WashPrivacy` goes to the
# BATHER, not to the onlooker, once another pawn within the radius satisfies all of:
#
#   - it is not an animal, not a colony mech, and not the bather's lover;
#   - the map is a player home, and there is a line of sight from the bather to it (a drum at
#     fillPercent 0.90 can be seen over, so the drum itself does not block it);
#   - and its gender differs from the bather's - or the bather dislikes men or women and the onlooker is
#     one.
#
# The check returns at once, with no memory, for a bather who is a prisoner, an animal, a nudist, or
# whose ideo prefers nudity. So the scenario fixes the two things it controls: opposite genders, and
# no Nudist trait on the bather.
#
# THE BATH IS GIVEN, NOT ORDERED. This is about the component's cadence, not about how a colonist gets
# into a drum, and a given hediff lasts as long as the scenario needs. A real bath ends when joy is
# full, which would end the scenario's window on its own.
Feature: onlookers notice the bather, and keep noticing

  Background:
    Given the save "test-colony" is loaded

  # Alone first, for as long as it takes to cross one periodic check (tick 300): nothing. Then someone
  # arrives, and only the periodic check can find them - the entry check has long gone. Seven hundred
  # ticks later two checks have passed (600 and 900), so the memory has stacked, and the bath is still
  # running, so it was not the exit check that produced it.
  @timeout:240
  Scenario: an onlooker who arrives halfway is noticed at the next check, and the memory stacks
    Given a colonist "Modest" exists
    And "Modest" gender is female
    And Drum Bath Hygiene: "Modest" is easily embarrassed
    And a colonist "Watcher" exists
    And "Watcher" gender is male
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And game speed is ultrafast
    When Drum Bath Hygiene: "Modest" climbs into the drum at x=142 z=155
    And I draft "Modest"
    And "Modest" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 400 ticks
    Then "Modest" has no thought "WashPrivacy"
    When Drum Bath Hygiene: "Watcher" stands 3 cells east of the drum at x=142 z=155
    And I draft "Watcher"
    And I wait 700 ticks
    Then Drum Bath Hygiene: "Modest" has at least 2 memories of "WashPrivacy"
    And Drum Bath Hygiene: the bathing hediff of "Modest" carries the component
    And no errors were logged
