# Five images for the Workshop page (three on the base mods, shots 4 and 5 on a retexture each, added 2026-11-18 on the owner's order), taken by the suite so that each is proved to show what it claims (PUBLICATION.md).
# Read 04-review-capture.feature for why a green @review says nothing about the image, and why the bath is the last
# thing asserted before each shot, with the game paused. Rewritten 2026-11-14 from the shotlist of STATUS.md (plan scored
# 4.5 / 5 / 4.5 by score-gallery); the two images of 2026-10-08 (Art/Gallery/1-the-bath.jpg, 2-the-needs-tab.jpg) belonged to the
# previous series and are removed with this rewrite.
#
# THE STORY (shotlist). Nelim (Virginie, founder of the Sanctuary, the only colonist of the save, played as her roster says)
# ends a day on the brown west bank of the water garden: she brings a log to the burning drum bath, soaks in it, and the
# Needs tab shows the water washing her. One evening, 18:00 to about 18:10 game time, weather Clear, one place
# (fixture Nelims-tribe, place "water-garden", drum at (147, 172)). The hour is set once per scenario (the save is
# reloaded for each), then cumulative waits: shot 1 setup only (60 ticks), shot 2 +208 ticks (5 min), shot 3 +417 ticks (10 min).
# Rhythm: wide opener (the place and the fire), tight (the bath), medium with the Needs tab (the proof, closing).
# One outfit all evening, laid BEFORE she is placed (the first "wears" undresses her): Apparel_BasicShirt and Apparel_Pants,
# dyed below; the game undresses her in the bath, no garment is claimed on the ground. Hair: her roster hairstyle Highpony, no hat.
# Face, after the bath job is asserted: her own face, MouthSmile, LidCheerful, map at 20 degrees, then "normal+blink" in ONE last call
# (owner rules 2026-10-25 and 2026-11-03: she smiles, no sweat). Mods: the DepMap wsl-deps.sanctuary-17.map as it is.
# Shared corner, laid in each scenario and removed by the suite's own AfterScenario: drum burning, TorchLamp lit, Shelf, Stool,
# WoodLog stack, soil with Plant_Rose and soil with Plant_Daylily fully grown; the natural hole at (149, 173) stays (part of the place).
#
# SHOTLIST (drift-checked against the scenarios by scripts/Check-ShotlistVsScenario.ps1):
#   1. workshop-1-the-bank, story scene, wide opener. West bank of the water garden, evening hour 18, Clear, setup 60 ticks.
#        Nelim in Apparel_BasicShirt dyed rgb (238, 224, 190) and Apparel_Pants dyed rgb (30, 98, 104), MouthSmile, stands at (146, 172)
#        facing East carrying the WoodLog, just before she feeds the fire. Drum burning at (147, 172), TorchLamp (146, 174) lit,
#        Shelf (149, 170), Stool (145, 172), WoodLog stack (146, 170), Plant_Rose on soil (150, 172), Plant_Daylily on soil (149, 175),
#        hole (149, 173). Zoom 7 centred on (147, 170), drum on the right third, torch left, bamboo behind, reeds in front.
#        Says: Nelim brings a log to feed the burning drum bath.
#   2. workshop-2-the-bath, story scene, tight. Same bank, +208 ticks (about 18:05), Clear.
#        Nelim in the drum, Apparel_BasicShirt rgb (238, 224, 190), Apparel_Pants rgb (30, 98, 104) laid before the bath, MouthSmile, no sweat.
#        Same corner: drum (147, 172), TorchLamp (146, 174), Shelf (149, 170), Stool (145, 172), WoodLog (146, 170),
#        Plant_Rose (150, 172), Plant_Daylily (149, 175), hole (149, 173). Bath job asserted before the shot, game paused.
#        Zoom 3.5 centred on (147, 172), drum centre-left, fire low in the foreground.
#        Says: Nelim soaks in the burning drum bath, smiling.
#   3. workshop-3-the-needs-tab, story scene with an inspector tab, medium, closing. Same bank, +417 ticks (about 18:10), Clear.
#        Nelim in the drum, Apparel_BasicShirt rgb (238, 224, 190), Apparel_Pants rgb (30, 98, 104) laid before the bath, MouthSmile.
#        Same corner: drum (147, 172), TorchLamp (146, 174), Shelf (149, 170), Stool (145, 172), WoodLog (146, 170),
#        Plant_Rose (150, 172), Plant_Daylily (149, 175). Hygiene set to 10 percent at the start, partway up now, Needs tab open at the left.
#        Zoom 5, drum shifted right of centre for the inspector.
#        Says: The Needs tab shows her hygiene climbing while she bathes.
#   4. workshop-4-the-retextured-drum, story scene, medium (owner order 2026-11-18). Same bank, +313 ticks (about 18:07), Clear. DepMap
#        wsl-deps.sanctuary-drumretex-17.map (1.6: wsl-deps.sanctuary-drumretex.map): MMDrumcanMOD Retexture, drilledhead.MMDrumcanMODRetexture
#        3713171862, texture-only, redraws Drumcan.png and DrumcanBath.png of Mlie.MMDrumcanMOD.
#        Nelim in the drum, Apparel_BasicShirt rgb (238, 224, 190), Apparel_Pants rgb (30, 98, 104) laid before the bath, MouthSmile, no sweat.
#        Same corner: drum (147, 172), TorchLamp (146, 174), Shelf (149, 170), Stool (145, 172), WoodLog (146, 170),
#        Plant_Rose (150, 172), Plant_Daylily (149, 175). Zoom 3 centred on (147, 172), tighter than shot 2, the retextured drum fills the centre; instant: just after she stepped in, the water starts to wash her, paused at the asserted tick, job given by the order to bathe.
#        Says: The same bath, drawn by MMDrumcanMOD Retexture.
#   5. workshop-5-the-dubs-corner, story scene, medium (owner order 2026-11-18). Same bank, +365 ticks (about 18:09), Clear. DepMap
#        wsl-deps.sanctuary-dbhup-17.map (1.6: wsl-deps.sanctuary-dbhup.map): [CF] Dubs Bad Hygiene Upscaled, DBH.Upscaled 3163175368,
#        texture-only, redraws Dubs objects, not the drum. Props from Cat and NPT (StageDecor, read not played): Dubs BathMat at (146, 171) and
#        Dubs WashBucket (water tub) at (148, 171), each on the nearest free cell, facing south; no pipe, no power.
#        Nelim in the drum, Apparel_BasicShirt rgb (238, 224, 190), Apparel_Pants rgb (30, 98, 104), MouthSmile. Same corner as shot 2:
#        drum at x=147 z=172, TorchLamp (146, 174), Shelf (149, 170), Stool (145, 172), WoodLog (146, 170), Plant_Rose (150, 172),
#        Plant_Daylily (149, 175). Zoom 4 centred on (147, 171), mat and tub in the foreground left and right of the drum; instant: she soaks, the tub just filled beside her, paused at the asserted tick, job given by the order to bathe.
#        Says: The Dubs mat and water tub beside the drum, redrawn by Dubs Bad Hygiene Upscaled.
#   Subtitles (PUBLICATION.md, "Gallery subtitles", written at the end): 1 "Nelim brings a log to feed the burning drum bath."
#   2 "Nelim soaks in the burning drum bath, smiling." 3 "The Needs tab shows her hygiene climbing while she bathes."
#   4 "The same bath, drawn by MMDrumcanMOD Retexture." 5 "A Dubs mat and water tub beside the drum, drawn by Dubs Bad Hygiene Upscaled."
#
# WHO OWNS WHICH STEP (2026-10-08, the Sanctuary has its own repository, SanctuaryBacklot):
#   "Nelim's Sanctuary: ..."     SB, place steps (frame a named place, animals removed); fixture Nelims-tribe, catalogue SanctuaryBacklot/docs/steps.md
#   "Nelim's Pickle Tools: ..."  NPT, tool steps (colonist looks and clothes, decor, Needs tab, presentation mode); catalogue PickleTools/docs/steps.md
#   "Drum Bath Hygiene: ..."     this suite's own steps (drum, bath, camera on the drum)
@review
Feature: the images of the Workshop page

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  # The first image of the page: the place and the fire, Nelim about to feed the drum. The interface is hidden with the
  # studio's own presentation mode; the drum's light and motes are cleared (they draw a square in a close shot).
  @timeout:300
  Scenario: Nelim brings a log to the burning drum on the west bank of the water garden, wide opener
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (30, 98, 104)
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    # The drum stands at (147, 172); the natural hole at (149, 173) is a SteamGeyser that cannot be covered: it stays in frame.
    And Drum Bath Hygiene: a drum bath stands at x=147 z=172
    And Drum Bath Hygiene: the drum at x=147 z=172 is burning
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (146, 174)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (149, 170)
    And Nelim's Pickle Tools: I place the decor "Stool" at (145, 172)
    And Nelim's Pickle Tools: I place the decor "WoodLog" at (146, 170)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (150, 172) to (150, 172)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (150, 172)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (149, 175) to (149, 175)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (149, 175)
    And Nelim's Pickle Tools: the plants from (149, 175) to (150, 172) are fully grown
    # The torch burns on fuel (a StandingLamp needs power, the sanctuary has none).
    And Nelim's Pickle Tools: the decor "TorchLamp" at (146, 174) is lit
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    # Setup only: 60 ticks for the light and the plants, then the game is paused before she is placed.
    And game speed is ultrafast
    When I wait 60 ticks
    And game speed is paused
    # She carries the log toward the drum, facing it: the instant is just before she feeds the fire.
    And Nelim's Pickle Tools: "Nelim" stands at (146, 172) facing East
    And Nelim's Pickle Tools: "Nelim" carries the item "WoodLog"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Drum Bath Hygiene: the drum's light is switched off at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    And Nelim's Pickle Tools: I frame the cell (147, 170) at zoom 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I move the mouse to (0, 0)
    Then Nelim's Pickle Tools: "Nelim" is in the camera view
    # The motes keep respawning: cleared again right before the shot, after presentation mode waited its frames.
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    When I take a screenshot "workshop-1-the-bank"
    And Drum Bath Hygiene: the camera's zoom limits are restored
    # (No "no warnings from mod" here: the sanctuary rolls vanilla warnings out of Pickle's buffer; 01-06 assert it on the test colony.)
    Then no errors were logged

  # The second image: Nelim in the burning drum, tight on the fire and the head, smiling, five minutes in.
  @timeout:360
  Scenario: Nelim soaks in the burning drum, tight on the bath, smiling
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (30, 98, 104)
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    And Nelim's Pickle Tools: "Nelim" stands at (146, 172) facing East
    # The drum stands at (147, 172); the natural hole at (149, 173) is a SteamGeyser that stays: a hot spring beside the bath.
    And Drum Bath Hygiene: a drum bath stands at x=147 z=172
    And Drum Bath Hygiene: the drum at x=147 z=172 is burning
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (146, 174)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (149, 170)
    And Nelim's Pickle Tools: I place the decor "Stool" at (145, 172)
    And Nelim's Pickle Tools: I place the decor "WoodLog" at (146, 170)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (150, 172) to (150, 172)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (150, 172)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (149, 175) to (149, 175)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (149, 175)
    And Nelim's Pickle Tools: the plants from (149, 175) to (150, 172) are fully grown
    And Nelim's Pickle Tools: the decor "TorchLamp" at (146, 174) is lit
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And "Nelim" needs "Hygiene" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Nelim" is ordered to bathe in the drum at x=147 z=172
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    # Five minutes of game time (208 ticks) after she stepped in; the water has started to wash her.
    When I wait 208 ticks
    And game speed is paused
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    # Face AFTER the bath job is asserted, in this order, "normal+blink" last in one call, no tick before the shot.
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Drum Bath Hygiene: the drum's light is switched off at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    And Nelim's Pickle Tools: I frame the cell (147, 172) at zoom 3.5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I move the mouse to (0, 0)
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    When I take a screenshot "workshop-2-the-bath"
    And Drum Bath Hygiene: the camera's zoom limits are restored
    Then no errors were logged

  # The third image: what the mod does. The Needs tab shows the hygiene gauge started at ten per cent, partway up ten
  # minutes in (417 ticks of the real bath, 0.0005 per tick). The rise is asserted before the shot. The interface stays,
  # since the tab is the subject: what clutters the frame is hidden one by one, not by presentation mode.
  @timeout:420
  Scenario: the Needs tab of Nelim soaking in the burning drum, hygiene partway up, medium and closing
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (30, 98, 104)
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    And Nelim's Pickle Tools: "Nelim" stands at (146, 172) facing East
    # The drum stands at (147, 172); the natural hole at (149, 173) stays.
    And Drum Bath Hygiene: a drum bath stands at x=147 z=172
    And Drum Bath Hygiene: the drum at x=147 z=172 is burning
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (146, 174)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (149, 170)
    And Nelim's Pickle Tools: I place the decor "Stool" at (145, 172)
    And Nelim's Pickle Tools: I place the decor "WoodLog" at (146, 170)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (150, 172) to (150, 172)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (150, 172)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (149, 175) to (149, 175)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (149, 175)
    And Nelim's Pickle Tools: the plants from (149, 175) to (150, 172) are fully grown
    And Nelim's Pickle Tools: the decor "TorchLamp" at (146, 174) is lit
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And "Nelim" needs "Hygiene" is set to 10 percent
    And I select "Nelim"
    And Nelim's Pickle Tools: I open the "Needs" inspect tab
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    When Drum Bath Hygiene: I remember "Nelim" hygiene
    And game speed is ultrafast
    And Drum Bath Hygiene: "Nelim" is ordered to bathe in the drum at x=147 z=172
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    # Ten minutes of game time (417 ticks) after she stepped in: the bath is half done.
    When I wait 200 ticks
    And I wait 217 ticks
    Then Drum Bath Hygiene: "Nelim" hygiene rose
    When game speed is paused
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Nelim's Pickle Tools: developer mode is turned off for the capture
    And Drum Bath Hygiene: the letters and the alerts are cleared from the screen
    And Nelim's Pickle Tools: I hide the colonist bar
    And Nelim's Pickle Tools: I hide the tooltips
    And Nelim's Pickle Tools: I hide the resource readout
    And Nelim's Pickle Tools: I hide the alerts
    And Nelim's Pickle Tools: I hide the selection brackets
    And Nelim's Pickle Tools: I hide the learning helper
    And Drum Bath Hygiene: the drum's light is switched off at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    # The tab fills the left third: the drum goes right of centre, two cells of shift at zoom 5, the torch above it, the corner around.
    And Drum Bath Hygiene: the camera looks at the drum at x=147 z=172, shifted 2 cells west, at zoom 5
    And Nelim's Pickle Tools: I move the mouse to (0, 0)
    Then Nelim's Pickle Tools: the "Needs" inspect tab is open
    And Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    When I take a screenshot "workshop-3-the-needs-tab"
    And Drum Bath Hygiene: the camera's zoom limits are restored
    Then no errors were logged

  # The fourth image (owner order 2026-11-18): the same bank and the same bath, the drum drawn by MMDrumcanMOD Retexture
  # (drilledhead.MMDrumcanMODRetexture 3713171862, texture-only, loads after Mlie.MMDrumcanMOD). Run ONLY with the DepMap
  # wsl-deps.sanctuary-drumretex.map (1.6) or wsl-deps.sanctuary-drumretex-17.map (1.7). The title carries no colonist name on
  # purpose: the filter ::Nelim of the three base shots must not pick it up on a map without the retexture.
  @timeout:360
  Scenario: the drum retextured by MMDrumcanMOD Retexture, medium on the bath, smiling
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (30, 98, 104)
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    And Nelim's Pickle Tools: "Nelim" stands at (146, 172) facing East
    And Drum Bath Hygiene: a drum bath stands at x=147 z=172
    And Drum Bath Hygiene: the drum at x=147 z=172 is burning
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (146, 174)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (149, 170)
    And Nelim's Pickle Tools: I place the decor "Stool" at (145, 172)
    And Nelim's Pickle Tools: I place the decor "WoodLog" at (146, 170)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (150, 172) to (150, 172)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (150, 172)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (149, 175) to (149, 175)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (149, 175)
    And Nelim's Pickle Tools: the plants from (149, 175) to (150, 172) are fully grown
    And Nelim's Pickle Tools: the decor "TorchLamp" at (146, 174) is lit
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And "Nelim" needs "Hygiene" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Nelim" is ordered to bathe in the drum at x=147 z=172
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    # About 18:07: 313 ticks after she stepped in, the water is washing her.
    When I wait 200 ticks
    And I wait 113 ticks
    And game speed is paused
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Drum Bath Hygiene: the drum's light is switched off at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    And Nelim's Pickle Tools: I frame the cell (147, 172) at zoom 3
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I move the mouse to (0, 0)
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    When I take a screenshot "workshop-4-the-retextured-drum"
    And Drum Bath Hygiene: the camera's zoom limits are restored
    Then no errors were logged

  # The fifth image (owner order 2026-11-18): [CF] Dubs Bad Hygiene Upscaled (DBH.Upscaled 3163175368, texture-only, loads after
  # dubwise.dubsbadhygiene) redraws the Dubs objects, not the drum: a Dubs BathMat and a Dubs WashBucket (water tub) stand beside the
  # drum so that the retexture is in the frame. Run ONLY with wsl-deps.sanctuary-dbhup.map (1.6) or wsl-deps.sanctuary-dbhup-17.map (1.7).
  @timeout:360
  Scenario: a Dubs bath mat and water tub beside the burning drum, Dubs Bad Hygiene Upscaled, medium on the corner
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (30, 98, 104)
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    And Nelim's Pickle Tools: "Nelim" stands at (146, 172) facing East
    And Drum Bath Hygiene: a drum bath stands at x=147 z=172
    And Drum Bath Hygiene: the drum at x=147 z=172 is burning
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (146, 174)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (149, 170)
    And Nelim's Pickle Tools: I place the decor "Stool" at (145, 172)
    And Nelim's Pickle Tools: I place the decor "WoodLog" at (146, 170)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (150, 172) to (150, 172)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (150, 172)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (149, 175) to (149, 175)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (149, 175)
    And Nelim's Pickle Tools: the plants from (149, 175) to (150, 172) are fully grown
    And Nelim's Pickle Tools: the building "BathMat" is spawned on the nearest free cell around (146, 171) facing south
    And Nelim's Pickle Tools: the building "WashBucket" is spawned on the nearest free cell around (148, 171) facing south
    And Nelim's Pickle Tools: the decor "TorchLamp" at (146, 174) is lit
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And "Nelim" needs "Hygiene" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Nelim" is ordered to bathe in the drum at x=147 z=172
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    # About 18:09: 365 ticks after she stepped in (chunks under the 5 s step limit).
    When I wait 200 ticks
    And I wait 165 ticks
    And game speed is paused
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Drum Bath Hygiene: the drum's light is switched off at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    And Nelim's Pickle Tools: I frame the cell (147, 171) at zoom 4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I move the mouse to (0, 0)
    Then Drum Bath Hygiene: "Nelim" is bathing in the drum at x=147 z=172
    And Drum Bath Hygiene: the drum's motes are cleared at x=147 z=172
    When I take a screenshot "workshop-5-the-dubs-corner"
    And Drum Bath Hygiene: the camera's zoom limits are restored
    Then no errors were logged
