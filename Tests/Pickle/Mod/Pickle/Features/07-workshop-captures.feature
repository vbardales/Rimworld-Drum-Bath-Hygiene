# Two images for the Workshop page, taken by the suite so that each is proved to show what it claims (PUBLICATION.md).
# Read 04-review-capture.feature for why a green @review says nothing about the image, and why the bath is the last
# thing asserted before each shot, with the game paused.
#
# These are not filmed, unlike 04: the first passes gave a French still of the whole frame and an English one drawn
# in the lower-left quarter of the file, the film of both being 960x540. If the quarter-frame comes back here, the
# film is not what causes it.
#
# The Needs tab is opened by the PickleTools package `nelim.pickletools.inspecttabs`, staged by
# `wsl-deps.tools.map`: this feature belongs to the `tools` pass. Its steps carry the `Nelim's Pickle Tools: ` prefix.
@review
Feature: the images of the Workshop page

  Background:
    Given the save "test-colony" is loaded
    # The skeleton the test colony keeps a few cells from the drum was in the frame of the first images, with the
    # skull the colonist carries for having seen it: not for a page about washing.
    And Drum Bath Hygiene: the corpses of the map are removed
    And a colonist "Bather" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Bather" needs "Hygiene" is set to 10 percent
    And "Bather" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    And I select "Bather"
    And I follow "Bather"
    And I zoom all the way in

  # The first image of the page: a colonist in the drum, and nothing to explain.
  @timeout:240
  Scenario: a colonist soaking in a burning drum, framed for the page
    When Drum Bath Hygiene: "Bather" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I wait 200 ticks
    And game speed is paused
    Then the inspect pane shows "Bather"
    And Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I take a screenshot "workshop-1-the-bath"
    And I stop following
    And I zoom all the way out
    And no warnings from mod "Drum Bath Hygiene"
    Then no errors were logged

  # The second image: what the mod actually does. The drum alone says nothing about hygiene; the Needs tab shows the
  # gauge, started at ten per cent, partway up after 600 ticks of the real bath (0.0005 per tick, so about forty per
  # cent). The rise is asserted before the shot, so the image cannot be of a gauge that never moved.
  @timeout:300
  Scenario: the Needs tab of a colonist soaking in the drum, the hygiene gauge partway up
    Given Nelim's Pickle Tools: I open the "Needs" inspect tab
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    When Drum Bath Hygiene: I remember "Bather" hygiene
    And Drum Bath Hygiene: "Bather" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I wait 600 ticks
    Then Drum Bath Hygiene: "Bather" hygiene rose
    When game speed is paused
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    And Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I take a screenshot "workshop-2-the-needs-tab"
    And I stop following
    And I zoom all the way out
    And no warnings from mod "Drum Bath Hygiene"
    Then no errors were logged
