#Player variables

playervar skill_resetSlash 0
playervar skill_countSlash 1


#Only remove the following directive if the gamemode does not use tricks such as A+0, A*0, "am" == "**", etc which would otherwise be optimized out.
#!optimizeStrict


rule "":
    @Event playerJoined
    
    eventPlayer.skill_resetSlash = false
    eventPlayer.skill_countSlash = 0


rule "22":
    @Event eachPlayer
    @Condition (eventPlayer.isFiringPrimaryFire() or eventPlayer.isUsingAbility2() or eventPlayer.skill_resetSlash) == true
    
    if eventPlayer.isHoldingButton(Button.ABILITY_1):
        return
    if eventPlayer.isUsingAbility2() or eventPlayer.skill_resetSlash:
        goto lbl_0
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 0.6)
    if eventPlayer.isFiringSecondaryFire() or eventPlayer.skill_resetSlash:
        goto lbl_1
    eventPlayer.skill_countSlash++
    if eventPlayer.skill_countSlash >= 3:
        goto lbl_2
    lbl_1:
    waitUntil(eventPlayer.skill_resetSlash or eventPlayer.isUsingAbility2() or eventPlayer.isFiringPrimaryFire(), 1)
    lbl_0:
    if eventPlayer.skill_resetSlash:
        goto lbl_2
    if eventPlayer.skill_countSlash <= 1 and eventPlayer.isFiringPrimaryFire() and not eventPlayer.isUsingAbility2():
        loop()
    if eventPlayer.isUsingAbility2() or eventPlayer.skill_countSlash >= 3:
        __skipIf__(eventPlayer.skill_countSlash > 3, 3 * (eventPlayer.skill_countSlash - 4))
        eventPlayer.skill_countSlash = 3
        waitUntil(eventPlayer.isFiringPrimaryFire(), 1)
        if eventPlayer.isOnGround():
        goto lbl_2
        __loopIf__(eventPlayer.isFiringPrimaryFire())
        eventPlayer.skill_countSlash = 4
        waitUntil(eventPlayer.isFiringPrimaryFire(), 1)
        if eventPlayer.isOnGround():
        goto lbl_2
        __loopIf__(eventPlayer.isFiringPrimaryFire())
        eventPlayer.skill_countSlash = 5
        waitUntil(eventPlayer.isFiringPrimaryFire(), 1)
        if eventPlayer.isOnGround():
        goto lbl_2
        __loopIf__(eventPlayer.isFiringPrimaryFire())
        eventPlayer.skill_countSlash = 6
        waitUntil(eventPlayer.isFiringPrimaryFire(), 1)
        if eventPlayer.isOnGround():
        goto lbl_2
        __loopIf__(eventPlayer.isFiringPrimaryFire())
        eventPlayer.skill_countSlash = 7
        waitUntil(eventPlayer.isFiringPrimaryFire(), 1)
    pass 
    lbl_2:
    eventPlayer.skill_countSlash = 0
    eventPlayer.skill_resetSlash = false


rule "":
    hudHeader(localPlayer if localPlayer.skill_countSlash >= 2 else null, "好了好了", HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)

