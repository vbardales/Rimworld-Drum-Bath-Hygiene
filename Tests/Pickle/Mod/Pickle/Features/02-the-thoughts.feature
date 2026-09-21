# The memories the bridge hands to Dubs Bad Hygiene on the way in.
#
# All three are set once, on the component's first tick, by OnEnterBath. None of them can be read
# from a def file: what decides them is the state of a real drum on a real map, and what applies
# them is a reflected call into another mod's assembly. The offline suite can prove the member
# exists; only a running game proves the memory arrives.
#
# The water temperature is the one with a fixture behind it. `cold` is not a setting: the component
# reads CompRefuelable.HasFuel on the drum under the pawn's feet, once, as they get in. So the two
# scenarios differ by one line - a drum that burns, a drum that has burnt out - and assert opposite
# memories. A component that ignored the fuel would pass one of them and fail the other, which is
# the only arrangement that can tell "reads the fire" from "always says hot".
#
# WHAT IS DELIBERATELY NOT HERE: the bathroom thought. ApplyBathroomThought grades the ROOM the
# fixture stands in, and its stage is Dubs Bad Hygiene's own judgement of impressiveness. A
# scenario naming a stage would be asserting DBH's room rules rather than this bridge's one call,
# and it would need a built, roofed, scored room that Pickle's fixture does not provide. It stays
# in _tools/FUNCTIONAL-SCENARIOS.md, scenario 4, where a person looks at it. Every scenario in this
# suite ends on "no errors were logged", which is what covers the call itself going through.
Feature: the memories a bath leaves

  Background:
    Given the save "test-colony" is loaded

  Scenario: a drum that still burns makes the water hot
    Given a colonist "Warm" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    When Drum Bath Hygiene: "Warm" climbs into the drum at x=142 z=155
    And "Warm" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then "Warm" has thought "HotBath"
    And "Warm" has no thought "ColdBath"
    And no errors were logged

  Scenario: a drum that has burnt out makes the water cold
    Given a colonist "Chilly" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 has burnt out
    When Drum Bath Hygiene: "Chilly" climbs into the drum at x=142 z=155
    And "Chilly" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 10 ticks
    Then "Chilly" has thought "ColdBath"
    And "Chilly" has no thought "HotBath"
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
