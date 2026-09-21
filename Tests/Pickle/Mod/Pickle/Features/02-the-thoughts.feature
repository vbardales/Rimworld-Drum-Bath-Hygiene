# The memories the bridge hands to Dubs Bad Hygiene on the way in.
#
# All of them are set once, on the component's first tick, by OnEnterBath. None can be read from a
# def file: what decides them is the state of a real drum on a real map, and what applies them is a
# reflected call into another mod's assembly. The offline suite can prove the member exists; only a
# running game proves the memory arrives.
#
# WHAT THE BRIDGE ACTUALLY DECIDES, AND WHAT DBH DOES WITH IT. The mod passes one boolean, `cold`,
# read off CompRefuelable.HasFuel on the drum under the pawn's feet. What Dubs Bad Hygiene 3.1.2800
# then grants is its own rule, read from the IL of SanitationUtil.WaterTempCheck on 2026-09-21 after
# the first run of this suite asserted the wrong thing:
#
#   pawn has Heatstroke   -> relieved, and gains ColdBath, whatever `cold` says
#   pawn has Hypothermia  -> cold: worsened, gains ColdWater.   warm: healed, gains HotBath
#   neither               -> cold: gains ColdWater.              warm: NOTHING AT ALL
#
# So a HEALTHY colonist in a hot bath gets no water thought, and the first version of these
# scenarios, which expected a `HotBath` memory for one, was wrong about Dubs Bad Hygiene rather
# than about this mod. The fuel reading is therefore proved in two places, each with a positive
# assertion on both sides so that neither can pass by doing nothing:
#
#   - healthy pawn:  burning -> no ColdWater;  burnt out -> ColdWater
#   - hypothermic:   burning -> HotBath;       burnt out -> ColdWater
#
# A component that ignored the fuel passes at most one of each pair, and one that inverted it fails
# all four. The Heatstroke branch is not played: it ignores `cold`, so it says nothing about the one
# thing this bridge decides.
#
# WHAT IS DELIBERATELY NOT HERE: the bathroom thought. ApplyBathroomThought grades the ROOM the
# fixture stands in, and its stage is Dubs Bad Hygiene's own judgement of impressiveness. A
# scenario naming a stage would be asserting DBH's room rules rather than this bridge's one call,
# and it would need a built, roofed, scored room that Pickle's fixture does not provide. It stays
# in _tools/FUNCTIONAL-SCENARIOS.md, scenario 4, where a person looks at it. Every scenario here
# ends on "no errors were logged", which is what covers the call itself going through.
Feature: the memories a bath leaves

  Background:
    Given the save "test-colony" is loaded

  # Healthy pawn, drum burning: DBH grants nothing for warm water on a pawn with neither heatstroke
  # nor hypothermia. The assertion is the ABSENCE of the cold memory - which is what an inverted
  # fuel reading would produce - not the absence of every memory.
  Scenario: a healthy colonist in a drum that still burns gets no cold-water memory
    Given a colonist "Warm" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    When Drum Bath Hygiene: "Warm" climbs into the drum at x=142 z=155
    And "Warm" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then "Warm" has no thought "ColdWater"
    And "Warm" has no thought "HotBath"
    And no errors were logged

  # The other half of the pair: the same colonist, the drum burnt out. This is the one that says
  # the fuel was read at all.
  Scenario: a healthy colonist in a drum that has burnt out gets the cold-water memory
    Given a colonist "Chilly" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 has burnt out
    When Drum Bath Hygiene: "Chilly" climbs into the drum at x=142 z=155
    And "Chilly" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then "Chilly" has thought "ColdWater"
    And no errors were logged

  # The only case where warm water leaves a memory, and so the only positive assertion for a
  # burning drum: hot water is a remedy for someone who is cold.
  Scenario: a chilled colonist in a drum that still burns gets the hot-bath memory
    Given a colonist "Frozen" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Frozen" is given hediff "Hypothermia"
    When Drum Bath Hygiene: "Frozen" climbs into the drum at x=142 z=155
    And "Frozen" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then "Frozen" has thought "HotBath"
    And "Frozen" has no thought "ColdWater"
    And no errors were logged

  # And its mirror: the same chilled colonist in cold water is made worse, and remembers it.
  Scenario: a chilled colonist in a drum that has burnt out gets the cold-water memory
    Given a colonist "Numb" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 has burnt out
    And "Numb" is given hediff "Hypothermia"
    When Drum Bath Hygiene: "Numb" climbs into the drum at x=142 z=155
    And "Numb" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then "Numb" has thought "ColdWater"
    And "Numb" has no thought "HotBath"
    And no errors were logged

  # Climbing into a bath means being wet by definition, so the malus for it is cleared on the way
  # IN - not on the way out, which is what both ATTRIBUTION copies used to say. SoakingWet is a
  # vanilla memory, so this scenario holds whatever Dubs Bad Hygiene does with the def.
  Scenario: the soaking wet memory is forgotten on the way in
    Given a colonist "Damp" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And "Damp" is given thought "SoakingWet"
    Then "Damp" has thought "SoakingWet"
    When Drum Bath Hygiene: "Damp" climbs into the drum at x=142 z=155
    And "Damp" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then "Damp" has no thought "SoakingWet"
    And no errors were logged

  # THE REAL PATH, WARM. The component finds the drum by looking at the things under the pawn's feet
  # and answers "cold" when it finds none. Every scenario above teleports the pawn onto the drum's
  # origin cell, which is under their feet by construction, so none of them can see that lookup
  # miss. A pawn placed by the drum mod's own driver is wherever the drum mod puts a bather. If that
  # were a cell the lookup misses, every real bath would be judged cold and hot water would never
  # happen - and only a scenario that lets the driver do the placing could say so. Here `cold`
  # would default to true and this scenario would get ColdWater instead.
  @timeout:240
  Scenario: a chilled colonist ordered into a burning drum gets the hot-bath memory
    Given a colonist "Shivering" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Shivering" is given hediff "Hypothermia"
    And game speed is ultrafast
    When Drum Bath Hygiene: "Shivering" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Shivering" is bathing in the drum at x=142 z=155
    And "Shivering" has thought "HotBath"
    And "Shivering" has no thought "ColdWater"
    And no errors were logged

  # THE REAL PATH, COLD. Reachable by no player: the joy giver refuses a drum at or below ten per cent
  # fuel, and the bath driver never looks at the fuel again once it has the job. Ordering the job
  # directly is the only way to reach this branch on purpose.
  @timeout:240
  Scenario: a chilled colonist ordered into a drum that has burnt out gets the cold-water memory
    Given a colonist "Shaking" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 has burnt out
    And "Shaking" is given hediff "Hypothermia"
    And game speed is ultrafast
    When Drum Bath Hygiene: "Shaking" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Shaking" is bathing in the drum at x=142 z=155
    And "Shaking" has thought "ColdWater"
    And "Shaking" has no thought "HotBath"
    And no errors were logged
