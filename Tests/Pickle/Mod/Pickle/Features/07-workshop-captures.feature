# Two images for the Workshop page, taken by the suite so that each is proved to show what it claims (PUBLICATION.md).
# Read 04-review-capture.feature for why a green @review says nothing about the image, and why the bath is the last
# thing asserted before each shot, with the game paused.
#
# (2026-10-05: the place is now Nelim's Sanctuary, "podium", not the flower glade described below; kept as history.)
# THE PLACE IS THE OWNER'S PHOTOGRAPHIC COLONY, not the test colony. The first two images of this feature were taken on
# `test-colony` and refused: it carries a skeleton beside the drum (and the skull the colonist wears for having seen it),
# and it is a working save, not a set. `nelim-zen-meadow-studio`, from the PickleTools package
# `nelim.pickletools.screenshotstudio`, is the default fixture for presentation shots: a meadow, and in it, at
# (154,98), a glade of grass ringed with flowers, with its own colonist, Nelim. The bath is built in that glade and
# Nelim takes it, so the drum stands on grass with red and orange flowers around it that identify the place.
#
# These are not filmed, unlike 04: the first passes gave a French still of the whole frame and an English one drawn
# in the lower-left quarter of the file, the film of both being 960x540, and the unfilmed shots were whole. The
# Needs tab is opened by `nelim.pickletools.inspecttabs`. Both packages are staged by `wsl-deps.tools.map`, which
# makes this feature belong to the `tools` pass. Their steps carry the `Nelim's Pickle Tools: ` prefix.
@review
Feature: the images of the Workshop page

  Background:
    # The set is NELIM'S SANCTUARY (fixture Nelims-tribe, PickleTools docs/SANCTUAIRE-LIEUX.md), at "water-garden", its brown bank, measured on the capture of run 8 (the first try at 139,173 stood in shallow water): the brown earth starts about 5 cells east of 139,173: a bare square of
    # The map has one colonist, Nelim (Virginie): she is the subject of the series. The estimated
    # bank is bare earth. The save loads paused; the shots pause the game again just before the camera.
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    # She is dressed BEFORE she is placed: the first "wears" undresses her, and her old clothes fall where she stands (the pale blue heap seen
    # beside the drum in runs 8 and 9 was her own old clothes, not the dyed ones, which she wears under the water). Here, in her house, out of frame.
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (30, 98, 104)
    And Nelim's Pickle Tools: I am at the sanctuary "water-garden"
    And Nelim's Pickle Tools: the animals are removed from the sanctuary "water-garden"
    And Nelim's Pickle Tools: "Nelim" stands at (146, 171) facing East
    And Drum Bath Hygiene: a drum bath stands at x=147 z=172
    And Drum Bath Hygiene: the drum at x=147 z=172 is burning
    And "Nelim" needs "Hygiene" is set to 10 percent
    And "Nelim" needs "Joy" is set to 10 percent
    # THE SERIES' STORY (rule of 2026-10-02: every gallery shot is a staged photograph, except the menus). Nelim (Virginie, the only colonist of the sanctuary,
    # kept as she is: her own look is not changed) takes her evening bath in the drum on the brown bank of the water garden.
    # Cream shirt and deep teal trousers (they end beside the drum when she undresses for the bath), and a little set around it: a torch
    # lamp, a shelf and two plants on patches of soil, placed for the shot and removed by the suite's own AfterScenario.
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (146, 174)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (149, 170)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (150, 172) to (150, 172)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (150, 172)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (149, 175) to (149, 175)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (149, 175)
    And Nelim's Pickle Tools: the plants from (149, 175) to (150, 172) are fully grown
    # A StandingLamp needs power and the sanctuary has none, so "is lit" waited its 10 s for a glow that never came (run 008b); the torch lamp burns on fuel.
    And Nelim's Pickle Tools: the decor "TorchLamp" at (146, 174) is lit
    # The "hole" two cells east of the drum, at (149, 173), is a natural SteamGeyser (run 850a): it cannot be covered or cleared, and it is what puffs steam in the second image. It stays: a hot spring beside the bath.
    And game speed is ultrafast

  # The first image of the page: a colonist in the drum, on grass, and nothing to explain. The interface is hidden
  # with the studio's own presentation mode.
  @timeout:240
  Scenario: a colonist soaking in a burning drum on the west bank of the water garden, framed for the page
    When Drum Bath Hygiene: "Nelim" is ordered to bathe in the drum at x=147 z=172
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    When I wait 200 ticks
    And game speed is paused
    # The first take showed the drum small, with a wall on the left and the drum light drawn as a square around it:
    # the light is switched off and the camera comes to zoom six, centred on the drum, as in the second image.
    And Drum Bath Hygiene: the drum's light is switched off at x=147 z=172
    # MMDrumcanMOD's own steam motes (Mote_Bombardment, found by the 2026-09-26 diagnostic) draw the same square: cleared too.
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    And Drum Bath Hygiene: the camera looks at the drum at x=147 z=172, shifted 0 cells west, at zoom 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    # The motes keep respawning: cleared again right before the shot, after presentation mode waited its frames.
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    When I take a screenshot "workshop-1-the-bath"
    And Drum Bath Hygiene: the camera's zoom limits are restored
    # (No "no warnings from mod" here: the sanctuary rolls 157 vanilla warnings out of Pickle's buffer, so an absent warning cannot be told from a dropped one; 01-06 assert it on the test colony.)
    Then no errors were logged

  # The second image: what the mod actually does. The drum alone says nothing about hygiene; the Needs tab shows the
  # gauge, started at ten per cent, partway up after 600 ticks of the real bath (0.0005 per tick, so about forty per
  # cent). The rise is asserted before the shot, so the image cannot be of a gauge that never moved. The interface
  # stays, since the tab is the subject.
  @timeout:300
  Scenario: the Needs tab of a colonist soaking in the drum, the hygiene gauge partway up
    Given I select "Nelim"
    And Nelim's Pickle Tools: I open the "Needs" inspect tab
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    When Drum Bath Hygiene: I remember "Nelim" hygiene
    And Drum Bath Hygiene: "Nelim" is ordered to bathe in the drum at x=147 z=172
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    When I wait 600 ticks
    Then Drum Bath Hygiene: "Nelim" hygiene rose
    When game speed is paused
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    # The tab has to stay, so what clutters the frame is cleared one by one: the first attempt kept the alerts, the stack of
    # letters and the developer controls, and PickleTools' screenshot mode, tried next, hid the tab with them. PickleTools
    # has a step for the developer controls alone; the letters and the alerts are cleared by a step of this suite.
    When Nelim's Pickle Tools: developer mode is turned off for the capture
    And Drum Bath Hygiene: the letters and the alerts are cleared from the screen
    # The tab fills the left third of the frame: the drum goes to the right of the screen and close. The first try
    # (nine cells of shift, zoom nine) left the drum small on bare grass, with a wall, a room and a wall torch (whose
    # light is drawn in a semi-transparent square) in the corner; zoom six is twice as close, and four cells of shift
    # put the drum about 360 px east of the middle, with the glade's flowers around it and the wall out of the frame.
    # The drum's own light (radius 5) is drawn as a darker rotated square around it in a close shot: switched off.
    And Drum Bath Hygiene: the drum's light is switched off at x=147 z=172
    # Same square from MMDrumcanMOD's own steam motes (Mote_Bombardment): cleared too.
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    And Drum Bath Hygiene: the camera looks at the drum at x=147 z=172, shifted 4 cells west, at zoom 6
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    And Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    # The motes keep respawning: cleared again right before the shot.
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    When I take a screenshot "workshop-2-the-needs-tab"
    And Drum Bath Hygiene: the camera's zoom limits are restored
    # (No "no warnings from mod" here: the sanctuary rolls 157 vanilla warnings out of Pickle's buffer, so an absent warning cannot be told from a dropped one; 01-06 assert it on the test colony.)
    Then no errors were logged
