# One capture, for a person to look at, once per language pass.
#
# READ THE TAG BEFORE THE COLOUR. @review asserts nothing about the image. Its green says the
# trajectory ran - a colonist was made, put in a drum, given the bath hediff, selected, and a file
# was written. It does not say the image shows a bath, a pawn, or anything at all. Counting it as a
# visual check performed is exactly the mistake this comment exists to prevent.
#
# WHY IT EARNS ITS PLACE ANYWAY. This mod owns no translatable text: STATUS.md records
# localization, translation_en and translation_fr as not_applicable, and an inventory of all three
# C# files and both XML branches found no label, no description and no Keyed key of its own. What a
# player reads while bathing is Dubs Bad Hygiene's - the hygiene need, the hot and cold bath
# memories - driven by this bridge. That text cannot be certified from this repository, and the
# in-game English and French display check is carried in STATUS.md as `unverified` for exactly that
# reason. This capture is what that check looks at.
#
# No step in this suite spells an English label. Every one of them names a defName, a need def or a
# thought def, so the whole suite runs unchanged under -Language French and the two passes differ
# only in what the captures show. A scenario that read a translated word would pass in one language
# and fail in the other for a reason that is not a defect.
@review
Feature: a capture of a colonist in the bath

  Background:
    Given the save "test-colony" is loaded

  Scenario: a colonist soaking in a burning drum, in whichever language the pass was staged with
    Given a colonist "Bather" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Bather" needs "Hygiene" is set to 10 percent
    When Drum Bath Hygiene: "Bather" climbs into the drum at x=142 z=155
    And "Bather" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 300 ticks
    And I select "Bather"
    Then the inspect pane shows "Bather"
    When I take a screenshot "bather-in-the-drum"
    Then no errors were logged
