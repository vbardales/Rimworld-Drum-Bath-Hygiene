# Two images for the Workshop page, taken by the suite so that each is proved to show what it claims (PUBLICATION.md).
# Read 04-review-capture.feature for why a green @review says nothing about the image, and why the bath is the last
# thing asserted before each shot, with the game paused.
#
# THE PLACE IS THE OWNER'S PHOTOGRAPHIC COLONY, not the test colony. The first two images of this feature were taken on
# `test-colony` and refused: it carries a skeleton beside the drum (and the skull the colonist wears for having seen it),
# and it is a working save, not a set. `nelim-zen-meadow-studio`, from the PickleTools package
# `nelim.pickletools.screenshotstudio`, is the default fixture for presentation shots: a meadow, and in it, at
# (154,98), a glade of grass ringed with flowers, with its own colonist, Miel. The bath is built in that glade and
# Miel takes it, so the drum stands on grass with red and orange flowers around it that identify the place.
#
# These are not filmed, unlike 04: the first passes gave a French still of the whole frame and an English one drawn
# in the lower-left quarter of the file, the film of both being 960x540, and the unfilmed shots were whole. The
# Needs tab is opened by `nelim.pickletools.inspecttabs`. Both packages are staged by `wsl-deps.tools.map`, which
# makes this feature belong to the `tools` pass. Their steps carry the `Nelim's Pickle Tools: ` prefix.
@review
Feature: the images of the Workshop page

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    # The bath stands three cells west of the glade's centre, where Miel is, so that she walks into it and
    # both are inside the frame of the "flowers" preset (centred on 154,98, twelve cells across).
    And Drum Bath Hygiene: a drum bath stands at x=151 z=98
    And Drum Bath Hygiene: the drum at x=151 z=98 is burning
    And "Miel" needs "Hygiene" is set to 10 percent
    And "Miel" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    And Nelim's Pickle Tools: I frame the studio "flowers"

  # The first image of the page: a colonist in the drum, on grass, and nothing to explain. The interface is hidden
  # with the studio's own presentation mode.
  @timeout:240
  Scenario: a colonist soaking in a burning drum in the flower glade, framed for the page
    When Drum Bath Hygiene: "Miel" is ordered to bathe in the drum at x=151 z=98
    Then Drum Bath Hygiene: "Miel" is bathing in the drum at x=151 z=98
    When I wait 200 ticks
    And game speed is paused
    And Nelim's Pickle Tools: studio presentation mode is enabled
    Then Drum Bath Hygiene: "Miel" is bathing in the drum at x=151 z=98
    When I take a screenshot "workshop-1-the-bath"
    And no warnings from mod "Drum Bath Hygiene"
    Then no errors were logged

  # The second image: what the mod actually does. The drum alone says nothing about hygiene; the Needs tab shows the
  # gauge, started at ten per cent, partway up after 600 ticks of the real bath (0.0005 per tick, so about forty per
  # cent). The rise is asserted before the shot, so the image cannot be of a gauge that never moved. The interface
  # stays, since the tab is the subject.
  @timeout:300
  Scenario: the Needs tab of a colonist soaking in the drum, the hygiene gauge partway up
    Given I select "Miel"
    And Nelim's Pickle Tools: I open the "Needs" inspect tab
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    When Drum Bath Hygiene: I remember "Miel" hygiene
    And Drum Bath Hygiene: "Miel" is ordered to bathe in the drum at x=151 z=98
    Then Drum Bath Hygiene: "Miel" is bathing in the drum at x=151 z=98
    When I wait 600 ticks
    Then Drum Bath Hygiene: "Miel" hygiene rose
    When game speed is paused
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    # The tab has to stay, so what clutters the frame is cleared one by one: the first attempt kept the alerts, the stack of
    # letters and the developer controls, and PickleTools' screenshot mode, tried next, hid the tab with them. PickleTools
    # has a step for the developer controls alone; the letters and the alerts are cleared by a step of this suite.
    When Nelim's Pickle Tools: developer mode is turned off for the capture
    And Drum Bath Hygiene: the letters and the alerts are cleared from the screen
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    And Drum Bath Hygiene: "Miel" is bathing in the drum at x=151 z=98
    When I take a screenshot "workshop-2-the-needs-tab"
    And no warnings from mod "Drum Bath Hygiene"
    Then no errors were logged
