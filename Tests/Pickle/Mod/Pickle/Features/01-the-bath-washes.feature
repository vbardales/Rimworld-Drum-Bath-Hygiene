# What only a running game can say about Drum Bath Hygiene.
#
# Everything provable without the game is proved without it, by _tools/Test-Mod.ps1: the patch
# XPath and payload run over synthetic defs in all nine shapes the upstream hediff could take, the
# metadata, the licence copies, and the access waiver read off the compiled assembly. None of that
# is repeated here. A run confiscates the machine for tens of minutes; a scenario restating a check
# that takes two seconds offline buys nothing with it.
#
# What is left is what needs a map, a pawn and a clock:
#
#   - the component ON the hediff the loaded game built. The offline suite applies the patch to a
#     document it wrote itself. Whether the real engine, in load order, with every other active
#     mod's operations in the same document, ends up with a HediffWithComps carrying this comp is
#     another question - and a PatchOperationConditional that matched nothing says so in no way.
#   - the gauge going up, tick by tick, through Dubs Bad Hygiene's own Need_Hygiene.clean. Nothing
#     but a running need answers that, and the binding is by reflection, so a DBH rework shows up
#     here and nowhere else.
#   - the rate. 0.0005 per tick is a number in a file until 2000 ticks have actually passed.
#   - the control: a colonist who is NOT in a bath. Without it, a rise proves nothing about this
#     mod, since the game moves that need on its own.
#   - a pawn with no hygiene need at all, which is the component's quietest branch and the one that
#     throws if it is wrong.
#   - a save and a reload in the middle of a bath, which is the one thing the component scribes.
#
# TWO WAYS TO PUT A COLONIST IN THE BATH, AND WHY BOTH.
#
#   - GIVEN: the scenario teleports the pawn onto the drum and gives the hediff itself. That is the
#     mod's actual contract - the component does its work for as long as Hed_BathingAtDrumBathPassive
#     is there, however it got there - and it isolates it from pathing and the joy giver.
#   - ORDERED: the drum mod's own job, so its driver walks the pawn over, places them and applies the
#     hediff. Exactly one scenario below, the last, and the two hot-and-cold ones in the next file.
#     It is what proves the component finds the drum under a pawn placed by the REAL driver.
#
# A GIVEN PAWN IS PINNED. The first run of this suite, 2026-09-21, showed a capture of a colonist
# standing beside the drum with the info panel reading "Washing.": at 10 per cent hygiene Dubs Bad
# Hygiene gives a free colonist a job of their own, and the teleport had put them there for one tick
# and not one more. A pawn free to walk away makes every hygiene and filth reading depend on
# something that is not this mod, so each is drafted the moment it is in place, and the control
# below is drafted the same way: the ONLY difference between them is the bath.
Feature: the drum bath washes the colonist soaking in it

  Background:
    Given the save "test-colony" is loaded

  # The foundation. If the patch did not land, nothing else in this suite means anything, and the
  # failure message says which half of it failed: a plain Hediff, or a HediffWithComps with no comp.
  Scenario: the patch lands on the hediff the game built, and the gauge climbs
    Given a colonist "Soaker" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Soaker" needs "Hygiene" is set to 10 percent
    When Drum Bath Hygiene: "Soaker" climbs into the drum at x=142 z=155
    And I draft "Soaker"
    And Drum Bath Hygiene: I remember "Soaker" hygiene
    And "Soaker" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 600 ticks
    Then Drum Bath Hygiene: the bathing hediff of "Soaker" carries the component
    And Drum Bath Hygiene: "Soaker" hygiene rose
    And no errors were logged

  # The control, and it is not optional: Dubs Bad Hygiene moves this need by itself, so a rise in
  # the scenario above says nothing until a colonist standing outside a bath has been watched for
  # the same stretch. This is the scenario that makes the other one an assertion.
  Scenario: a colonist who is not bathing is not washed
    Given a colonist "Dusty" exists
    And "Dusty" needs "Hygiene" is set to 10 percent
    When I draft "Dusty"
    And Drum Bath Hygiene: I remember "Dusty" hygiene
    And I wait 600 ticks
    Then Drum Bath Hygiene: "Dusty" hygiene did not rise
    And no errors were logged

  # The rate, which is the one design decision in this mod: 0.0005 per tick fills an empty gauge in
  # 2000 ticks, half of the bath's 4000. The colonist climbs out clean without the bath being
  # reduced to a quick shower. This also crosses six privacy intervals - the component re-checks
  # onlookers every 300 ticks - so a component that stopped ticking, or threw on one of those
  # re-checks, fails here rather than going unnoticed.
  @timeout:180
  Scenario: half a bath fills an empty gauge
    Given a colonist "Patient" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Patient" needs "Hygiene" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Patient" climbs into the drum at x=142 z=155
    And I draft "Patient"
    And "Patient" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 2000 ticks
    Then Drum Bath Hygiene: "Patient" hygiene is above 0.9
    And no errors were logged

  # The quiet branch: ResolveCleanAction returns null for a pawn with no hygiene need, and has to
  # keep returning nothing for the rest of the bath rather than looking again every tick. It is
  # reached through a colonist who has lost the need, and through the REAL job.
  #
  # IT WAS AN ANIMAL, AND IT COULD NOT STAY ONE. The drum mod does bathe animals, but through its own
  # component and not through an ordered job. Given the hediff by hand, a muffalo made the drum mod's
  # own render patch (DrumBath_Harmony.PawnRenderer_RenderPawnAt) throw on a pawn with the hediff and
  # no job - a state no player produces. Ordered into the drum, it never took the order: its job trace
  # in the fifth run is wandering and nothing else. The branch this mod owns is the missing need, and
  # a colonist without one reaches it just as well.
  @timeout:240
  Scenario: a colonist with no hygiene need is left alone in the bath, and nothing is logged
    Given a colonist "Shaggy" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And Drum Bath Hygiene: "Shaggy" loses the hygiene need
    Then Drum Bath Hygiene: "Shaggy" has no hygiene need
    Given "Shaggy" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Shaggy" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Shaggy" is bathing in the drum at x=142 z=155
    When I wait 300 ticks
    Then no errors were logged

  # The two scribed values, and the delegate that is deliberately not scribed. A save loaded in the
  # middle of a bath has to bind again, against whatever Dubs Bad Hygiene is loaded that time - so
  # the gauge has to keep climbing AFTER the reload, not merely have climbed before it.
  @timeout:180
  Scenario: a bath survives a save and a reload, and goes on washing
    Given a colonist "Keeper" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Keeper" needs "Hygiene" is set to 10 percent
    When Drum Bath Hygiene: "Keeper" climbs into the drum at x=142 z=155
    And I draft "Keeper"
    And "Keeper" is given hediff "Hed_BathingAtDrumBathPassive"
    And I wait 300 ticks
    And I save and reload
    Then "Keeper" has hediff "Hed_BathingAtDrumBathPassive"
    And Drum Bath Hygiene: the bathing hediff of "Keeper" carries the component
    When Drum Bath Hygiene: I remember "Keeper" hygiene
    And I wait 600 ticks
    Then Drum Bath Hygiene: "Keeper" hygiene rose
    And no errors were logged

  # The whole path, played by the drum mod's own driver. Everything above hands the component a
  # hediff; this asks the game to give it one. It proves the hediff the driver creates is the one
  # the patch grafted onto, that the component starts on it, and that a colonist ordered into a
  # burning drum at low hygiene comes out washed - through nothing but the real job.
  @timeout:240
  Scenario: a colonist ordered into the drum by the real job is washed
    Given a colonist "Bather" exists
    And Drum Bath Hygiene: a drum bath stands at x=142 z=155
    And Drum Bath Hygiene: the drum at x=142 z=155 is burning
    And "Bather" needs "Hygiene" is set to 10 percent
    And "Bather" needs "Joy" is set to 10 percent
    And game speed is ultrafast
    When Drum Bath Hygiene: "Bather" is ordered to bathe in the drum at x=142 z=155
    Then Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    And Drum Bath Hygiene: the bathing hediff of "Bather" carries the component
    When Drum Bath Hygiene: I remember "Bather" hygiene
    And I wait 600 ticks
    Then Drum Bath Hygiene: "Bather" hygiene rose
    And Drum Bath Hygiene: "Bather" is bathing in the drum at x=142 z=155
    And no errors were logged
