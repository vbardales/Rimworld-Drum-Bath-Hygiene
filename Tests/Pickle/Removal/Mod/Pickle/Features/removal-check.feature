# Launch 2 of the removal chain (see wsl-deps.removal.map): Drum Bath Hygiene and its test companion are taken out of
# the mod list (-ThenWithout). The save was taken with a colonist in the bath, the bathing hediff carrying the mod's
# component. The drum mod (MMDrumcanMOD) and Dubs Bad Hygiene stay loaded: only the component's class is gone.
Feature: A game saved with Drum Bath Hygiene, a colonist in the bath, loaded without it

  Scenario: the save loads and runs without the mod
    Given mod "nelim.drumbathhygiene" is not loaded
    And the save "dbh-removal-with-mod" is loaded
    And game speed is fast
    When I wait 250 ticks
    Then no errors were logged
    And the engine is alive
    When I save and reload as "dbh-removal-without-mod"
    Then no errors were logged
    And the engine is alive
