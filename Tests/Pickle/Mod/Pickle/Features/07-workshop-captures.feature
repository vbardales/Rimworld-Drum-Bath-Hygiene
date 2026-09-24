# Two images for the Workshop page, taken by the suite so that each is proved to show what it claims (PUBLICATION.md).
#
# READ THE TAG BEFORE THE COLOUR. @review asserts nothing about the image; what makes these worth opening is the
# assertion made on the frame before each shot, and even that does not say what the image looks like.
#
# WHY NOT THE CAPTURE OF 04. That one is filmed, and the two stills the first passes produced came out different: the
# French one full-frame, the English one drawn in the lower-left quarter of a 1920x1080 file with the rest black, the
# film of both being 960x540. The cause was not looked into. These two are not filmed, so if the quarter-frame
# comes back here the film is not what causes it, and that is worth knowing.
#
# THE STEPS OF THE INSPECT TAB are the PickleTools package `nelim.pickletools.inspecttabs`, staged by
# `wsl-deps.tools.map`; that is why this feature belongs to the `tools` pass. They carry the `Nelim's Pickle Tools: `
# prefix. The tab is named by its short form, `Needs`.
@review
Feature: the images of the Workshop page

  Background:
    Given the save "test-colony" is loaded

  # The first image of the page: a colonist in the drum, and nothing to explain.
  @timeout:240
  Scenario: a colonist soaking in a burning drum, framed for the page
    Given a colonist "Bather" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Bather" needs "Hygiene" is set to 10 percent
    And "Bather" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    When I select "Bather"
    And I follow "Bather"
    And I zoom all the way in
    And Drum Bath Hygiene: "Bather" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I wait 200 ticks
    # The bath is the last thing asserted before the shot, and nothing is waited in between (see 04).
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
    Given a colonist "Bather" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Bather" needs "Hygiene" is set to 10 percent
    And "Bather" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    When I select "Bather"
    And I follow "Bather"
    And I zoom all the way in
    And Nelim's Pickle Tools: I open the "Needs" inspect tab
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    When Drum Bath Hygiene: I remember "Bather" hygiene
    And Drum Bath Hygiene: "Bather" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I wait 600 ticks
    Then Drum Bath Hygiene: "Bather" hygiene rose
    And Nelim's Pickle Tools: the "Needs" inspect tab is open
    And Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I take a screenshot "workshop-2-the-needs-tab"
    And I stop following
    And I zoom all the way out
    And no warnings from mod "Drum Bath Hygiene"
    Then no errors were logged
