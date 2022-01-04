'***********************************************************************************************************************
'*****  Lights Dispatch                                   	                                                        ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub SwitchHitAugmentation()
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        Exit Sub
    End If

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If gameState("switches")("augmentation") = 0 And gameState("game")("augmentationHold") = 1 Then
            Dim c: c = RndNum(0,8)

            LightOff(lcAugmentations(gameState("game")("augmentationActive")))
            
            gameState("game")("augmentationActive") = c
            gameState("switches")("augmentation") = 1
            
            PlaySoundAt "fx_aug_switch_hit", ActiveBall
    
            Dim lActiveAug: Set lActiveAug = New LightChangeItem
            lActiveAug.Init c,1,20,"pal_blue"
            
            'Dim lSeqReset: Set lSeqReset = new LightSeqItem
            'lSeqReset.Name = "lSeqReset"
            'lSeqReset.Sequence = Array(Array(lsAug1Off,lsAug2Off,lsAug3Off,lsAug4Off,lsAug5Off,lsAug6Off,lsAug7Off,lsAug8Off,lsAug9Off),lActiveAug)
            'lSeqAugmentation.ResetSequence = lSeqReset
            lSeqAugmentation.AddItem(lSeqAugmentationFlicker)
            
            vpmTimer.addtimer 600, "SwitchSetAugmentation True, ""pal_orange"" '"
            vpmTimer.addtimer 1200, "SwitchSetAugmentationCooldown '"
    
        End If
    End If

End Sub

Sub SwitchSetAugmentationCooldown()

    gameState("switches")("augmentation") = 0

End Sub

Sub SwitchSetAugmentation(playCallout, palette)
    
    If usePUP = True Then
        PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\aug" & AugmentationNames(gameState("game")("augmentationActive")) & ".png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"
        PuPlayer.LabelSet   pBackglass, "lblPerk",      "Perk: " & AugmentationPerksLvl1(gameState("game")("augmentationActive")) & "",            1,  "{}"
    End If

    LightOff(lsAug1)
    LightOff(lsAug2)
    LightOff(lsAug3)
    LightOff(lsAug4)
    LightOff(lsAug5)
    LightOff(lsAug6)
    LightOff(lsAug7)
    LightOff(lsAug8)
    LightOff(lsAug9)

    LightOn(lcAugmentations(gameState("game")("augmentationActive")))

    lSeqHyperJump.RemoveItem(lSeqHyperJumpPerkShot)
    lSeqLeftOrbit.RemoveItem(lSeqLeftOrbitPerkShot)
    lSeqShortcut.RemoveItem(lSeqShortcutPerkShot)
    lSeqRightOrbit.RemoveItem(lSeqRightOrbitPerkShot)
    lSeqRightRamp.RemoveItem(lSeqRightRampPerkShot)
    lSeqCenterRamp.RemoveItem(lSeqCenterRampPerkShot)
    lSeqSpinner.RemoveItem(lSeqSpinnerPerkShot)
    lSeqBumpers.RemoveItem(lSeqBumpersPerkShot)
    lSeqLeftRamp.RemoveItem(lSeqLeftRampPerkShot)

    Select Case gameState("game")("augmentationActive")
        Case 0:
            lSeqHyperJumpPerkShot.Image = palette
            lSeqHyperJump.AddItem(lSeqHyperJumpPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(0)(gameState("game")("augTigerLvl")) End If
        Case 1:
            lSeqLeftOrbitPerkShot.Image = palette
            lSeqLeftOrbit.AddItem(lSeqLeftOrbitPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(1)(gameState("game")("augBatLvl")) End If
        Case 2:
            lSeqLeftRampPerkShot.Image = palette
            lSeqLeftRamp.AddItem(lSeqLeftRampPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(2)(gameState("game")("augBullLvl")) End If
        Case 3:
            lSeqSpinnerPerkShot.Image = palette
            
            lSeqSpinner.AddItem(lSeqSpinnerPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(3)(gameState("game")("augLionLvl")) End If
        Case 4:
            lSeqBumpersPerkShot.LampColor = PaletteToLampLookup(palette)
            lSeqBumpers.AddItem(lSeqBumpersPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(4)(gameState("game")("augHawkLvl")) End If
        Case 5:
            lSeqCenterRampPerkShot.Image = palette
            lSeqCenterRamp.AddItem(lSeqCenterRampPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(5)(gameState("game")("augDeerLvl")) End If
        Case 6:
            lSeqRightRampPerkShot.Image = palette
            lSeqRightRamp.AddItem(lSeqRightRampPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(6)(gameState("game")("augPAntherLvl")) End If
        Case 7:
            lSeqRightOrbitPerkShot.Image = palette
            lSeqRightOrbit.AddItem(lSeqRightOrbitPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(7)(gameState("game")("augOwlLvl")) End If
        Case 8:
            lSeqShortcutPerkShot.Image = palette
            lSeqShortcut.AddItem(lSeqShortcutPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(8)(gameState("game")("augRhinoLvl")) End If
    End Select

End Sub

Sub SwitchHitCaptive()
    
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If gameState("switches")("captive") = 0 Then
    
            If gameState("game")("augmentationHold") = 1 Then
                'Turn off lights
                DISPATCH GAME_LOCK_AUGMENTATIONS, null
                PlayGameCallout "augmentation_held"
                'Activate Timer.
            End If
            PlaySoundAt "fx_target", ActiveBall
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        DebugScore = DebugScore + 1500
    End If
End Sub

Sub SwitchHitResearch1()

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug1") Then
            LightOn(lsResearch1)
            PlayGameCallout "research_node_collected"
            gameState("lights")("activeResearch").Add "aug1", True
            CheckResearchLights
        End If
        DebugScore = DebugScore + 1500
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug1") Then
            StopLightBlink(lsResearch1)
            Lampz.state(21) = 1
            gameState("lights")("activeResearch").Add "aug1", True
        End If
        DebugScore = DebugScore + 1500
    End If
End Sub

Sub SwitchHitResearch2()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug2") Then
            LightOn(lsResearch2)
            PlayGameCallout "research_node_collected"
            gameState("lights")("activeResearch").Add "aug2", True
            CheckResearchLights
        End If
        DebugScore = DebugScore + 1500
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug2") Then
            StopLightBlink(lsResearch2)
            Lampz.state(22) = 1
            gameState("lights")("activeResearch").Add "aug2", True
        End If
        DebugScore = DebugScore + 1500
    End If
End Sub

Sub SwitchHitResearch3()  
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug3") Then
            LightOn(lsResearch3)
            PlayGameCallout "research_node_collected"
            gameState("lights")("activeResearch").Add "aug3", True
            CheckResearchLights
        End If
        DebugScore = DebugScore + 1500
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug3") Then
            StopLightBlink(lsResearch3)
            Lampz.state(23) = 1
            gameState("lights")("activeResearch").Add "aug3", True
        End If
        DebugScore = DebugScore + 1500
    End If
End Sub

Sub CheckResearchLights()

    Dim powerLights: powerLights = gameState("lights")("activeResearch").Count
    If powerLights=3 Then
        PlayGameCallout "research_ready"
        Dispatch GAME_AUGMENTATION_READY, Null
    End If

End Sub

Sub SwitchLeftFlipperDown()

    If gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True Then
        'Rotate Skillshot
        DISPATCH GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE, Null
    End If

    Dispatch ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE, Null
End Sub

Sub SwitchRightFlipperDown()

    If gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True Then
        'Rotate Skillshot
        DISPATCH GAME_ROTATE_SKILLSHOT_CLOCKWISE, Null
    End If

    Dispatch ROTATE_LANE_LIGHTS_CLOCKWISE, Null
End Sub

Sub SwitchHitConsole()
    
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        Dim waittime
        If gameState("game")("augmentationReady") = True Then
            DISPATCH GAME_START_AUGMENTATION_RESEARCH, null
            Exit Sub
        Else
            'flash red. kick out.
            PlaySound "console_off"
            objFluxTimer(1).UserValue = 0
            objFluxBase(1).UserValue = 1
            objFluxBase(1).Material = "Console_HUD_Red"
            FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
            waittime = 400
            vpmTimer.addtimer waittime, "exitConsoleKickerWithFlash '"
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        'flash red. kick out.
        PlaySound "console_off"
        objFluxTimer(1).UserValue = 0
        objFluxBase(1).UserValue = 1
        objFluxBase(1).Material = "Console_HUD_Red"
        FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
        waittime = 400
        vpmTimer.addtimer waittime, "exitConsoleKickerWithFlash '"
    End If

End Sub

Sub exitConsoleKickerWithFlash
    objFluxTimer(1).UserValue = 0
    objFluxBase(1).UserValue = 1
    objFluxBase(1).Material = "Console_HUD_Red"
    FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
    consoleKicker.Kick 0, 30, 1.36
End Sub

Sub SwitchHitRampPin()
    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP_COLLECT) Then
            DISPATCH GAME_MODE_COLLECT_AUGMENTATION, null
        End If
    End If
End Sub

Sub SwitchHitPlungerLane()
    If gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True Then
        gameState("game")("modes")(GAME_MODE_NORMAL) = True
        gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = False
        DISPATCH GAME_LOCK_AUGMENTATIONS, null
        DISPATCH GAME_ENABLE_BALL_SAVE, null
    End If
End Sub

'***********************************************************************************************************************

