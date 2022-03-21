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
        GameSetAugmentationPerkLabels()
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

    If palette = "pal_orange" Then
        gameState("game")("perkShot") = GameShots(gameState("game")("augmentationActive"))
    End If

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
End Sub

Sub SwitchHitResearch1()

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug1") Then
            LightOn(lsResearch1)
            PlayGameCallout "research_node_collected"
            gameState("lights")("activeResearch").Add "aug1", True
            CheckResearchLights
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug1") Then
            LightOn(lsResearch1)
            gameState("lights")("activeResearch").Add "aug1", True
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
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
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug2") Then
            LightOn(lsResearch2)
            gameState("lights")("activeResearch").Add "aug2", True
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
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
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug3") Then
            LightOn(lsResearch3)
            gameState("lights")("activeResearch").Add "aug3", True
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If
End Sub

Sub CheckResearchLights()

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        Dim powerLights: powerLights = gameState("lights")("activeResearch").Count

        If gameState("lights")("activeResearch").Exists("aug1") Then
            LightOn(lsResearch1)
        End If
        If gameState("lights")("activeResearch").Exists("aug2") Then
            LightOn(lsResearch2)
        End If
        If gameState("lights")("activeResearch").Exists("aug3") Then
            LightOn(lsResearch3)
        End If

        If powerLights=3 Then
            PlayGameCallout "research_ready"
            Dispatch GAME_AUGMENTATION_READY, Null
        End If
    End If

End Sub

Sub CheckLaneLights()

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        Dim lanesOn: lanesOn = 0

        If gameState("laneLights")("leftOuter")=1 Then
            LightOn(lsLane1)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane1)
        End If
        If gameState("laneLights")("leftInner")=1 Then
            LightOn(lsLane2)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane2)            
        End If
        If gameState("laneLights")("rightInner")=1 Then
            LightOn(lsLane3)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane3)            
        End If
        If gameState("laneLights")("rightOuter")=1 Then
            LightOn(lsLane4)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane4)
        End If

        If lanesOn=4 And gameState("game")("raceReady") = 0 Then
            PlayGameCallout "race_ready"
            Dispatch GAME_RACE_READY, Null
        End If
    Else
        LightOff(lsLane1)
        LightOff(lsLane2)
        LightOff(lsLane3)
        LightOff(lsLane4)
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
    Dim waittime
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then        
        If gameState("game")("augmentationReady") = True Then
            DISPATCH GAME_START_AUGMENTATION_RESEARCH, null
            Exit Sub
        End If
    End If

    PlaySound "console_off"
    objFluxTimer(1).UserValue = 0
    objFluxBase(1).UserValue = 1
    objFluxBase(1).Material = "Console_HUD_Red"
    DOF 235, DOFPulse
    FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
    waittime = 400
    vpmTimer.addtimer waittime, "exitConsoleKickerWithFlash '"

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
        DISPATCH GAME_MODE_NORMAL, Null
        DOF 210, DOFOff 'Plunger Lane Off
        gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = False
        DISPATCH GAME_LOCK_AUGMENTATIONS, null
        DISPATCH GAME_ENABLE_BALL_SAVE, null
        lSeqPlungerLane.RemoveAll()
        FlexDMDGameModeNormal()
    End If
End Sub

Sub SwitchHitLightLock()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If gameState("switches")("lightlock") = 0 Then 'Off
            gameState("switches")("lightlock") = 1
        ElseIf gameState("switches")("lightlock") = 1 Then 'Blinking
            PlayGameCallout "locks_lit"
            LockPin.IsDropped = False
            gameState("switches")("lightlock") = 2
            TurnOffFluxFlasher(4)
            FluxObjlevel(4) = 1.5
            TurnOnFluxFlasher(4)
        
            objFluxTimer(5).UserValue = 2
            objFluxBase(5).UserValue = 1
            objFluxOffBrightness(5) = 0.5
            FluxObjlevel(5) = 0.1 : FlasherFluxTimer5_Timer
            LightFluxFlash 5, FlasherFluxTimer5

        ElseIf gameState("switches")("lightlock") = 2 Then 'On
            ' Callout locks already activate
        End If
        DISPATCH GAME_CHECK_LOCKS, Null
    End If
    
End Sub

Sub SwitchHitLeftOutlane()
    gameState("laneLights")("leftOuter") = 1
    'gameState("game")("outlaneDrain") = True
    CheckLaneLights()
    lSeqLeftDrain.AddItem(lSeqLeftDrainBlink)
    PlaySound "drain"
    DOF 220, DOFPulse
    If gameState("game")("ballSave") = True Then
        ballRelease.CreateSizedball BallSize / 2
        ballRelease.Kick 90, 4
        vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
        PlungerIM.AutoFire
    End If
End Sub

Sub SwitchHitLeftInlane()
    gameState("laneLights")("leftInner") = 1
    CheckLaneLights()
End Sub

Sub SwitchHitRightInlane()
    gameState("laneLights")("rightInner") = 1
    CheckLaneLights()
End Sub

Sub SwitchHitRightOutlane()
    gameState("laneLights")("rightOuter") = 1
    'gameState("game")("outlaneDrain") = True
    CheckLaneLights()
    lSeqRightDrain.AddItem(lSeqRightDrainBlink)
    PlaySound "drain"
    DOF 221, DOFPulse
    If gameState("game")("ballSave") = True Then
        ballRelease.CreateSizedball BallSize / 2
        ballRelease.Kick 90, 4
        vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
        PlungerIM.AutoFire
    End If
End Sub

Sub SwitchHitBallLock()
    'If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
    'gameState("switches")("lockPinHit") = True

    If gameState("game")("ballsLocked")=2 Then
        'StartMultiball
        PlayGameCallout "ball_3_locked"
        DOF 255, DOFOn
        gameState("game")("modes")(GAME_MODE_MULTIBALL) = True
        gameState("game")("modes")(GAME_MODE_NORMAL) = False
        gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
        DISPATCH GAME_CLEAR_SHOTS, Null
        AddGameTargetShot(GAME_SHOT_LEFT_ORBIT)
        AddGameTargetShot(GAME_SHOT_LEFT_RAMP)
        AddGameTargetShot(GAME_SHOT_CENTER_RAMP)
        AddGameTargetShot(GAME_SHOT_RIGHT_RAMP)
        AddGameTargetShot(GAME_SHOT_RIGHT_ORBIT)
        gameState("game")("ballsInPlay") = 3
        'Turn Scoop off
        StopBGAudio()
        TurnOffFluxFlasher(1)
        TurnOffFluxFlasher(2)
        LightOff(lsResearchReady)
        DISPATCH GAME_HIDE_LABELS, null
        pupevent 506 'music multiball
        pupevent 412 'backglass multiball
        gameState("game")("multiballPlayed") = True
        vpmTimer.addtimer Timings(TIMINGS_START_MULTIBALL), "vpmTimerMultiBallStage2 '"
        gameState("switches")("lightlock") = 0
        gameState("game")("ballsLocked") = 0
        DISPATCH GAME_DISABLE_BALL_LOCK, Null
        DISPATCH GAME_CHECK_LOCKS, Null
    Else
        gameState("game")("ballsLocked")=gameState("game")("ballsLocked")+1
        If gameState("game")("ballsLocked")=1 Then
            DOF 253, DOFOn
        Else
            DOF 254, DOFOn
        End If
        PlayGameCallout "ball_" & gameState("game")("ballsLocked") & "_locked"
        ballRelease.CreateSizedball BallSize / 2
        ballRelease.Kick 90, 4
        If gameState("game")("multiballPlayed") = True Then
            DISPATCH GAME_DISABLE_BALL_LOCK, Null
            gameState("switches")("lightlock") = 1
            DISPATCH GAME_CHECK_LOCKS, Null
        End If
    End If
    vpmTimer.addtimer Timings(TIMINGS_START_MULTIBALL), "vpmTimerMultiBallDOFOff '"
    'End If
End Sub

Sub vpmTimerMultiBallDOFOff
    DOF 253, DOFOff
    DOF 254, DOFOff
    DOF 255, DOFOff
End Sub

Sub vpmTimerMultiBallStage2
    DISPATCH LIGHTS_GI_MULTIBALL, Null
    DISPATCH GAME_ENABLE_BALL_SAVE, Null
    pupevent 600
    DISPATCH GAME_SHOW_LABELS, null
    LockPin.IsDropped = True
    lSeqMultiballC.AddItem(lSeqMultiballCShot)
	lSeqMultiballY.AddItem(lSeqMultiballYShot)
	lSeqMultiballB.AddItem(lSeqMultiballBShot)
	lSeqMultiballE.AddItem(lSeqMultiballEShot)
	lSeqMultiballR.AddItem(lSeqMultiballRShot)
End Sub	

Sub SwitchHitSecretUpgrade()

    diverterWall3Off.IsDropped = 1
	diverterWall3On.IsDropped = 0
    vpmTimer.addtimer 1000, "vpmTimerCloseSecretUpgrade '"
End Sub

Sub vpmTimerCloseSecretUpgrade()
    diverterWall3Off.IsDropped = 0
    diverterWall3On.IsDropped = 1
End Sub

Sub SwitchHitBet
    If IsLightOn(lsBet1) Then
        If IsLightOn(lsBet2) Then
            If IsLightOn(lsBet3) Then
                LightOff(lsBet1)
                LightOff(lsBet2)
                LightOff(lsBet3)
            Else
                LightOn(lsBet3)
            End If
        Else
            LightOn(lsBet2)
        End If
    Else
        LightOn(lsBet1)
    End If
    gameState("game")("betHits") = gameState("game")("betHits") - 1
    If gameState("game")("betHits") = 0 Then
        'TODO Start Hurry Up
    End If
End Sub
'***********************************************************************************************************************

