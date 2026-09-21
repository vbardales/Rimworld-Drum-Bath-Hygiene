# One capture, for a person to look at, once per language pass.
#
# READ THE TAG BEFORE THE COLOUR. @review asserts nothing about the image. Its green says the
# trajectory ran - a colonist was made, ordered into a drum, selected, and a file was written. It
# does not say the image shows a bath, a pawn, or anything at all, and this suite has already caught
# itself on exactly that: the first capture, 2026-09-21, showed a colonist standing BESIDE the drum
# with the info panel reading "Washing.", green. She had been teleported onto the drum and, at 10 per
# cent hygiene, given a job of her own by Dubs Bad Hygiene one tick later.
#
# SO THIS ONE ASKS THE GAME FOR A REAL BATH, and asserts it is under way before it shoots: the drum
# mod's own job is running and the hediff is on the pawn. The assertion is what makes the image
# worth opening - a pawn walking toward the drum has neither - though it still does not say what the
# image looks like, which only a person opening it can.
#
# WHY IT EARNS ITS PLACE ANYWAY. This mod owns no translatable text: STATUS.md records
# localization, translation_en and translation_fr as not_applicable, and an inventory of all three
# C# files and both XML branches found no label, no description and no Keyed key of its own. What a
# player reads while bathing is Dubs Bad Hygiene's - the hygiene need, the water memories - driven
# by this bridge. That text cannot be certified from this repository, and the in-game English and
# French display check is carried in STATUS.md as unverified for exactly that reason. This capture
# is what that check looks at.
#
# No step in this suite spells an English label. Every one of them names a defName, a need def or a
# thought def, so the whole suite runs unchanged under -Language French and the two passes differ
# only in what the captures show. A scenario that read a translated word would pass in one language
# and fail in the other for a reason that is not a defect.
@review
Feature: a capture of a colonist in the bath

  Background:
    Given the save "test-colony" is loaded

  @timeout:240
  Scenario: a colonist soaking in a burning drum, in whichever language the pass was staged with
    Given a colonist "Bather" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Bather" needs "Hygiene" is set to 10 percent
    And "Bather" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Bather" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I wait 300 ticks
    # Asserted AGAIN, after the wait, and it is the line that keeps this capture honest. The first
    # two runs of this scenario were green over an image of a colonist a long way from the drum with
    # the info panel reading "Washing.": the bath had started, ended almost at once, and Dubs Bad
    # Hygiene had sent her off to wash elsewhere. Asserting the bath at the start says it began; only
    # asserting it at the shot says it is still what the image shows.
    Then Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    When I select "Bather"
    And I follow "Bather"
    And I zoom all the way in
    And I wait 30 ticks
    Then the inspect pane shows "Bather"
    When I take a screenshot "bather-in-the-drum"
    And I stop following
    And I zoom all the way out
    Then no errors were logged
