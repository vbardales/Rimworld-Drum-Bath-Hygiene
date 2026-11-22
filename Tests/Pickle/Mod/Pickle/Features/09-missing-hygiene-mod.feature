# Drum Bath Hygiene hard-depends on MMDrumcanMOD only: Dubs Bad Hygiene and Dubs Bad Hygiene Lite replace each other, so
# neither is a dependency (2026-11-23). With neither installed the mod would silently do nothing, so a startup check
# (Source/StartupCheck.cs) raises Log.Error once and a startup error window naming both mods (Keyed DrumBathHygiene_NoDbh*).
#
# This feature plays the game with NEITHER mod: pass wsl-deps.nodbh.map (and wsl-deps.nodbh-17.map), which stages the marker
# below and no Dubs Bad Hygiene. It is skipped in every other pass (the requires tag). The Log.Error is expected here:
# this scenario does not assert "no errors were logged".
@requires:nelim.drumbathhygiene.picklenodbh
Feature: the mod tells the player when neither Dubs Bad Hygiene nor Lite is installed

  @timeout:120
  Scenario: the startup alert names both mods
    Given the save "test-colony" is loaded
    Then Nelim's Pickle Tools: the window "Dialog_MessageBox" is open
    And Nelim's Pickle Tools: the window "Dialog_MessageBox" contains "Dubs Bad Hygiene Lite"
    And Nelim's Pickle Tools: the window "Dialog_MessageBox" contains "2570319432"
    And Nelim's Pickle Tools: the window "Dialog_MessageBox" contains "836308268"
