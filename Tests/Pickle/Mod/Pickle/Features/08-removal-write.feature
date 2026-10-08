# Launch 1 of the removal chain (pass wsl-deps.removal.map; launch 2 is Removal/Mod/Pickle/Features/removal-check.feature).
# A colonist is IN the bath when the game is saved, so the save holds the bathing hediff with this mod's component. The
# game is saved, then handed to the removal companion, which does not depend on this mod. Launch 2 loads it without the
# mod: the component's class is gone, the drum mod (MMDrumcanMOD) and Dubs Bad Hygiene are not.
@requires:nelim.drumbathhygiene.pickleremoval
Feature: a save with Drum Bath Hygiene and a colonist in the bath, prepared for removal

  @timeout:300
  Scenario: save mid-bath, hand over
    Given the save "test-colony" is loaded
    And a colonist "Soaker" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And "Soaker" needs "Hygiene" is set to 10 percent
    And "Soaker" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Soaker" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Soaker" is bathing in the drum at x=142 z=155
    When I wait 60 ticks
    And game speed is paused
    And Drum Bath Hygiene: the game is saved as "dbh-removal-with-mod"
    And Drum Bath Hygiene: the saved game "dbh-removal-with-mod" is handed to the mod "nelim.drumbathhygiene.pickleremoval"
    Then no errors were logged
