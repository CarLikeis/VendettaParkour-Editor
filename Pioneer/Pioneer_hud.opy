#Global variables

globalvar BanBhop 2
globalvar BanStand 3
globalvar Count_Ability1 4
globalvar Count_Ability2 5
globalvar Count_Ultimate 6
globalvar EditorOn 7
globalvar MapVectorArray 8
globalvar PortalLoc 9
globalvar PortalDest 10
globalvar PortalNames 11
globalvar NANBA 12
globalvar SaveEnt 13
globalvar SaveName 14
globalvar SaveCp 15
globalvar TimeRemaining 16
globalvar Toggle_Update 17
globalvar Pos_View 18
globalvar Edit_Time 19
globalvar Edit_Timer 20


#Player variables

playervar checkpoint_current 0
playervar checkpoint_practice 1
playervar checkpoint_notLast 3
playervar toggle_invincible 4
playervar toggle_spectate 5
playervar toggle_edit 6
playervar toggle_practice 7
playervar toggle_invisible 8
playervar toggle_guide 9
playervar toggle_quickRestart 10
playervar count_ability1 13
playervar count_ability2 14
playervar count_ultimate 15
playervar ban_string 16
playervar ban_bhop 17
playervar ban_standcreate 18
playervar skill_countBhops 21
playervar skill_usedHop 22
playervar skill_usedBhop 23
playervar skill_usingshift 24
playervar cache_startAbility1 25
playervar cache_startAbility2 26
playervar cache_startUlt 27
playervar pioneer_bhop 28
playervar pioneer_countbhops 29


rule "HUD | Global Localplayer":
    @Event global

    #剩余时间 版本号
    hudSubheader(localPlayer,f"房间将在 {TimeRemaining} 分钟后重启 - v1.0.0A",HudPosition.RIGHT,-99,Color.RED,HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(localPlayer.toggle_guide,"斩仇帕克萌新群: 614016408\n",HudPosition.ACTUALLY_LEFT,-99,Color.AQUA,HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(localPlayer,f"长按 {inputBindingString(Button.SECONDARY_FIRE)} 切换显示HUD",HudPosition.RIGHT,-98,Color.WHITE,HudReeval.VISIBILITY_STRING_AND_COLOR)
    hudSubtext(localPlayer.toggle_guide,f"长按 {inputBindingString(Button.ULTIMATE)} | 隐身模式 {'| 启用' if localPlayer.toggle_invisible else []}",HudPosition.RIGHT,-97,Color.GREEN if localPlayer.toggle_invisible else Color.WHITE,HudReeval.VISIBILITY_STRING_AND_COLOR)
    hudSubtext(localPlayer.toggle_guide,f"{[] if localPlayer.toggle_quickRestart else ['长']}按 {inputBindingString(Button.RELOAD)} | {[] if localPlayer.toggle_quickRestart else '启用'} 快速回点",HudPosition.RIGHT,-96,Color.WHITE,HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(localPlayer.toggle_guide,f"长按 {inputBindingString(Button.INTERACT)} | 观战模式 {'| 启用' if localPlayer.toggle_spectate else []}",HudPosition.RIGHT,-95,Color.GREEN if localPlayer.toggle_spectate else Color.WHITE,HudReeval.VISIBILITY_STRING_AND_COLOR)
    hudSubtext(localPlayer.toggle_guide,f"{inputBindingString(Button.RELOAD)} + {inputBindingString(Button.MELEE)} | 探点模式 {'| 启用' if localPlayer.toggle_invincible else []}",HudPosition.RIGHT,-94,Color.GREEN if localPlayer.toggle_invincible else Color.WHITE,HudReeval.VISIBILITY_STRING_AND_COLOR)
    hudSubtext(localPlayer.toggle_guide,"{0} + {1} | 练习模式{2}".format(inputBindingString(Button.ULTIMATE),inputBindingString(Button.MELEE),f" | ({localPlayer.checkpoint_practice})" if localPlayer.toggle_practice else []),HudPosition.RIGHT,-93,Color.GREEN if localPlayer.toggle_practice else Color.WHITE,HudReeval.VISIBILITY_STRING_AND_COLOR)

    #开拓信息
    progressBarHud(localPlayer, Edit_Timer/Edit_Time * 100,f"请房主按 {inputBindingString(Button.INTERACT)} 确认起始点位" if A == [] else (f"当前开拓者 {EditorOn} , 请等待开拓 , {Edit_Time - Edit_Timer}s 后自动中止" if EditorOn != null else f"当前没有开拓者, 长按 {inputBindingString(Button.ULTIMATE)} + {inputBindingString(Button.RELOAD)} 成为开拓者"),HudPosition.TOP,-110,Color.WHITE if EditorOn == null else Color.GREEN,Color.WHITE,ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR)

rule "HUD | Each Player":
    @Event playerJoined

    wait(1)

    #关卡封禁\n当前关卡
    hudSubheader(eventPlayer,"{0}{1}".format(f"{eventPlayer.ban_string}\n" if eventPlayer.ban_string != [] else [], f"关卡 {eventPlayer.checkpoint_current} / {len(A) - 1}"),HudPosition.TOP,-111,Color.WHITE,HudReeval.STRING)
    hudHeader(eventPlayer,"小跳",HudPosition.ACTUALLY_LEFT,-90,Color.RED if eventPlayer.skill_usedBhop else Color.GREEN,HudReeval.VISIBILITY_STRING_AND_COLOR)

    #技能次数
    hudSubtext(eventPlayer,f"\n{abilityIconString(Hero.VENDETTA,Button.ABILITY_1)} 本关可用次数 {Count_Ability1[eventPlayer.checkpoint_current]}\n{abilityIconString(Hero.VENDETTA,Button.ABILITY_2)} 本关可用次数 {Count_Ability2[eventPlayer.checkpoint_current]}\n{abilityIconString(Hero.VENDETTA,Button.ULTIMATE)} 本关可用次数 {Count_Ultimate[eventPlayer.checkpoint_current]}",HudPosition.ACTUALLY_LEFT,-89,Color.WHITE,HudReeval.VISIBILITY_STRING_AND_COLOR)

    #BE ID Title - 战网ID称号 <---- DISPLAY ID & Lvl
    createInWorldText([player for player in getAllPlayers() if player.toggle_guide and player != eventPlayer], "{0}{1}".format(eventPlayer[0].split([]), " ({0})".format(eventPlayer.checkpoint_current) if eventPlayer.checkpoint_current else []), 2 * Vector.UP + eventPlayer, 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)

