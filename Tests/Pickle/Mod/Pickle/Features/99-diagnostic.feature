@review
Feature: 99 temporary diagnostic of the light square and the spark

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And Drum Bath Hygiene: a drum bath stands at x=151 z=98
    And Drum Bath Hygiene: the drum at x=151 z=98 is burning
    And game speed is ultrafast

  Scenario: what is around the drum
    When I wait 200 ticks
    And Drum Bath Hygiene: I list what is around the drum at x=151 z=98
    Then no errors were logged
