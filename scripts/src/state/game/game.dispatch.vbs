'***********************************************************************************************************************
'*****  Game Dispatch                                   	                                                        ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub GameStartOfBall()

  RPin.IsDropped = 1

	Dispatch LIGHTS_GI_ON, Null
	Dispatch LIGHTS_GI_NORMAL, null

  PlayBGAudioNext()

  DOF 210, DOFOn

  DOF 235, DOFPulse
  
	ballRelease.CreateSizedball BallSize / 2
  ballRelease.Kick 90, 4
  gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True
  gameState("game")("modes")(GAME_MODE_NORMAL) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  gameState("game")("modes")(GAME_MODE_MULTIBALL) = False
  gameState("game")("pauseLights") = False
  'Set Random Aug
  Dim c: c = RndNum(0,8)
  gameState("game")("augmentationActive") = c
  PlayGameCallout("choose_skillshot")
  SwitchSetAugmentation False, "pal_yellow"
  gameState("game")("ballsInPlay") = 1
  FlexDMDGameModeSkillshot()

	lSeqPlungerLane.RemoveAll()
  lSeqPlungerLane.AddItem(lSeqPlungerLaneItem)

  DISPATCH GAME_CHECK_LOCKS, Null
  DISPATCH GAME_CHECK_LANES, Null
  DISPATCH GAME_SHOW_LABELS, null
  diverterWall3On.IsDropped = True
  diverterWall3Off.IsDropped = False
  
End Sub

Sub GameEndOfBall()
  EndMusic
  Dispatch LIGHTS_GI_OFF, Null
  If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
    DISPATCH LIGHTS_RESEARCH_OFF, Null
    StopLightBlink(lSeqFinish)
    GameModeAugmentationSetShot(-1)
  End If
  DISPATCH GAME_CLEAR_SHOTS, Null
  gameState("game")("pauseLights") = True
  StopBallSaver()
  DISPATCH LIGHTS_PAUSE, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
  lsSpeeder.Image="pal_cyan"
  LightOff(lsSpeeder)
  'play pup
  StopBGAudio()
  vpmTimer.addtimer 3000, "vpmTimerGameEndOfBallStage2 '"

End Sub

Sub vpmTimerGameEndOfBallStage2()

  If gameState("game")("playerBall") = 3 Then
    DISPATCH GAME_END, Null
  Else
    gameState("game")("playerBall") = gameState("game")("playerBall") + 1
    DISPATCH GAME_START_OF_BALL, Null
  End If
End Sub

Sub GameEnd
  'END GAME
  gameStarted = false
  LockPin.IsDropped = True
End Sub

Sub GameRotateSkillshotAntiClockwise()

  Dim i:i=gameState("game")("augmentationActive")-1
  If i<0 Then
    i = 8
  End If
  gameState("game")("augmentationActive") = i
  SwitchSetAugmentation True, "pal_yellow"

End Sub

Sub GameRotateSkillshotClockwise()

  Dim i:i=gameState("game")("augmentationActive")+1
  If i>8 Then
    i = 0
  End If
  gameState("game")("augmentationActive") = i
  SwitchSetAugmentation True, "pal_yellow"

End Sub

Sub GameAugmentationReady()
    gameState("game")("augmentationReady") = True
    LightBlink(lSeqResearchLit)
    objFluxTimer(1).UserValue = 1
    objFluxBase(1).UserValue = 0.4
    FluxObjlevel(1) = 0.1 : FlasherFluxTimer1_Timer
    LightFluxFlash 1, FlasherFluxTimer1
    objFluxTimer(2).UserValue = 1
    objFluxBase(2).UserValue = 0.4
    FluxObjlevel(2) = 0.1 : FlasherFluxTimer2_Timer
    LightFluxFlash 2, FlasherFluxTimer2
End Sub

Sub GameRaceReady()
    gameState("game")("raceReady") = True
End Sub

Sub GameStartAugmentationResearch()
  
  gameState("game")("modes")(GAME_MODE_NORMAL) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True
  'gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = 0
  gameState("game")("augmentationReady") = False
  TurnOffFluxFlasher(1)
  TurnOffFluxFlasher(2)
  DISPATCH LIGHTS_RESEARCH_OFF, null
  DISPATCH LIGHTS_RESEARCH_READY_OFF, null
  DISPATCH GAME_HIDE_LABELS, null
  DISPATCH LIGHTS_AUGMENTATIONS_OFF, null
  DISPATCH GAME_CHECK_LOCKS, Null
  GameModeAugmentationSetShot(-1)
  LightOff(lsSpeeder)
  Select Case gameState("game")("augmentationActive")
    Case 0:
      pupevent 404 'tiger, spinner
    Case 1:
      pupevent 401 'bumpers,bat
    Case 2:
      pupevent 400 'hyperjump,bull
    Case 3:
      pupevent 405 'left orbit, lion
    Case 4:
      pupevent 402 'right orbit,hawk
    Case 5:
      pupevent 407 'shortcut,deer
    Case 6:
      pupevent 403 'panther, left ramp
    Case 7:
      pupevent 406 'rightramp,owl
    Case 8:
      pupevent 408 'centerramp,rhino
  End Select  
  StopBGAudio()
  vpmTimer.addtimer Timings(TIMINGS_START_AUG_RESEARCH), "vpmTimerGameStartAugmentationResearchStage2 '"
End Sub

Sub vpmTimerGameStartAugmentationResearchStage2
    pupevent 600 'main bg
    pupevent 504 'music - hackers
    DISPATCH GAME_SHOW_LABELS, null
    DISPATCH GAME_LOCK_AUGMENTATIONS, null
    DISPATCH LIGHTS_GI_AUGMENTATION_RESEARCH, null
    LightBlink(lsResearch1)
    LightBlink(lsResearch2)
    LightBlink(lsResearch3)
    'Setup Shots
    SetAugmentationResearchShots()
    lsSpeeder.Image="pal_purple"
    LightOn(lsSpeeder)
    DISPATCH GAME_ENABLE_BALL_SAVE, Null
    consoleKicker.Kick 0, 30, 1.36
End Sub

Sub GameLockAugmentations()
  gameState("game")("augmentationHold") = 2
  
  'Set Aug Lights to Hold Mode.
  Dim aug
  For Each aug in lcAugmentations
      aug.Image = "pal_red"
      LightOn(aug)
  Next

  If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
    LightOn(lsAugSign1)
    LightOn(lsAugSign2)
    LightOn(lsAugSign3)
    LightOn(lsAugSign4)
    LightBlink(lsAugSign5)
    gameState("game")("augmentationHoldCountdown") = 5
    vpmTimer.addtimer 10000, "vpmTimerGameAugmentationHeldCountdown '"
  End If

  lcAugmentations(gameState("game")("augmentationActive")).Image = "pal_blue"
  LightBlink(lcAugmentations(gameState("game")("augmentationActive")))
  lSeqCaptive.RemoveItem(lSeqCaptiveAugHold)
  StopLightBlink(lSeqHoldAug)
  gameState("switches")("captive") = 1
End Sub

Sub vpmTimerGameAugmentationHeldCountdown

  If gameState("game")("modes")(GAME_MODE_NORMAL) = False Then
    LightOff(lsAugSign1)
    LightOff(lsAugSign2)
    LightOff(lsAugSign3)
    LightOff(lsAugSign4)
    LightOff(lsAugSign5)
    Exit Sub
  End If

  Dim x: x = gameState("game")("augmentationHoldCountdown")
  If gameState("game")("augmentationHold") = 2 Then
    If x > 1 Then
      Execute "LightOff(lsAugSign"&x&") : LightBlink(lsAugSign"&x-1&")"
      vpmTimer.addtimer 10000, "vpmTimerGameAugmentationHeldCountdown '"
      gameState("game")("augmentationHoldCountdown") = x-1
    Else
      Execute "LightOff(lsAugSign"&x&")"
      DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
      gameState("game")("augmentationHoldCountdown") =0
    End If
  End If
End Sub

Sub GameUnlockAugmentations()
  gameState("game")("augmentationHold") = 1
  gameState("game")("augmentationHoldCountdown") =0
  Dim aug
  For Each aug in lcAugmentations
      aug.Image = "pal_blue"
  Next
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
  lSeqCaptive.AddItem(lSeqCaptiveAugHold)
  LightBlink(lSeqHoldAug)
  gameState("switches")("captive") = 0
  LightOff(lsAugSign1)
  LightOff(lsAugSign2)
  LightOff(lsAugSign3)
  LightOff(lsAugSign4)
  LightOff(lsAugSign5)
End Sub

Sub GameHideLabels()
  gameState("game")("hideScore") = True

  if (usePUP=false or PUPStatus=false) then Exit Sub
  
  PuPlayer.LabelSet   pBackglass, "lblAug",         "PupOverlays\\augLion.png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':100}"
  PuPlayer.LabelSet   pBackglass, "lblPlayer",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblBall",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblPerk1",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblPerk2",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "CurScore1",      "",   1,  "{}"

  PuPlayer.LabelSet   pBackglass, "lblResearchNode",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblLocks",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblSpeeder",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombos",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombosMade",      "",   1,  "{}"
End Sub

Sub GameShowLabels()
  gameState("game")("hideScore") = False

  if (usePUP=false or PUPStatus=false) then Exit Sub
  
  PuPlayer.LabelSet   pBackglass, "lblPlayer",    gameState("game")("playerName"),                 1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblBall",      "Ball "&gameState("game")("playerBall"),                   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\aug" & AugmentationNames(gameState("game")("augmentationActive")) & ".png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"

  PuPlayer.LabelSet   pBackglass, "lblResearchNode",      "Research Nodes",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblLocks",      "Locks",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblSpeeder",      "Speeder Parts",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombos",      "Combos",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombosMade",  gameState("game")("combosMade").Count & " / " & GameCombos.Count,                        1,  "{}"

End Sub

Sub GameSetAugmentationPerkLabels()

  Dim augName
  Select Case gameState("game")("augmentationActive")
    Case 0:
      augName = "Tiger"
    Case 1:
      augName = "Bat"
    Case 2:
      augName = "Bull"
    Case 3:
      augName = "Lion"
    Case 4:
      augName = "Hawk"
    Case 5:
      augName = "Deer"
    Case 6:
      augName = "Panther"
    Case 7:
      augName = "Owl"
    Case 8:
      augName = "Rhino"
  End Select
  Dim augLvl
  Execute "augLvl = AugmentationPerksLvl"&  gameState("game")("aug" & augName & "Lvl")+1 &"(gameState(""game"")(""augmentationActive""))"
  Execute "PuPlayer.LabelSet   pBackglass, ""lblPerk1"",      ""Perk :             " & augLvl & """,                        1,  ""{}"""
  If Not gameState("game")("aug" & augName & "Lvl") = 2 Then
    Dim augLvl2
    Execute "augLvl2 = AugmentationPerksLvl"&  gameState("game")("aug" & augName & "Lvl")+2 &"(gameState(""game"")(""augmentationActive""))"
    Execute "PuPlayer.LabelSet   pBackglass, ""lblPerk2"",      ""Next Level :   " & augLvl2 & """,                        1,  ""{}"""
  Else
    PuPlayer.LabelSet   pBackglass, "lblPerk2",      "Next Level :   Frenzy",                   1,  "{}"
  End If

End Sub

Sub GameModeNormal()
  gameState("game")("modes")(GAME_MODE_NORMAL) = True
  DISPATCH LIGHTS_GI_NORMAL, null
  DISPATCH GAME_SHOW_LABELS, null
  DISPATCH GAME_CHECK_LOCKS, Null
  DISPATCH GAME_CHECK_LANES, Null
  'TODO CHECK RESEARCH NODES
End Sub

Sub GameModeAdvanceAugmentation()

  LightSeqAttract.StopPlay
  LightSeqAttract.UpdateInterval = 8
  LightSeqAttract.Play SeqStripe1VertOn , 10, 0
  PlaySound "shothit2"

  lSeqHyperJump.RemoveItem(lSeqHyperJumpActiveShot)
  lSeqLeftOrbit.RemoveItem(lSeqLeftOrbitActiveShot)
  lSeqShortcut.RemoveItem(lSeqShortcutActiveShot)
  lSeqRightOrbit.RemoveItem(lSeqRightOrbitActiveShot)
  lSeqRightRamp.RemoveItem(lSeqRightRampActiveShot)
  lSeqCenterRamp.RemoveItem(lSeqCenterRampActiveShot)
  lSeqSpinner.RemoveItem(lSeqSpinnerActiveShot)
  lSeqBumpers.RemoveItem(lSeqBumpersActiveShot)
  lSeqLeftRamp.RemoveItem(lSeqLeftRampActiveShot)

  gameState("game")("targetShots").RemoveAll()

  gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") + 1
  SetAugmentationResearchShots()
End Sub

Sub SetAugmentationResearchShots()

  Select Case gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage")
    Case 0:
      GameModeAugmentationSetShot(gameState("game")("augmentationActive"))
    Case 1:
      Dim s1: s1 = RndNum(0,8)
      Do While s1=gameState("game")("augmentationActive")
        s1=RndNum(0,8)
      Loop
      'Random Two Shots
      GameModeAugmentationSetShot(s1)

      Dim s2: s2 = RndNum(0,8)
      Do While s2=gameState("game")("augmentationActive") Or s2=s1
        s2=RndNum(0,8)
      Loop
      'Random Two Shots
      GameModeAugmentationSetShot(s2)
    Case 2:
      GameModeAugmentationSetShot(gameState("game")("augmentationActive"))
    Case 3:
      'Finish Shot
      lSeqRightRamp.AddItem(lSeqRightRampCollectShot)
      LightBlink(lSeqFinish)
      AddGameTargetShot GAME_SHOT_RIGHT_RAMP_COLLECT
  End Select

End Sub

Sub GameModeFinishAugmentation()
  gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = 0
  lSeqRightRamp.RemoveItem(lSeqRightRampCollectShot)
  StopLightBlink(lSeqFinish)
  RPin.IsDropped = 0
End Sub

Sub GameModeCollectAugmentation()

  DISPATCH LIGHTS_GI_OFF, Null
  'pupevent 503 'stop music hackers
  EndMusic
  gameState("game")("targetShots").RemoveAll()
  DISPATCH GAME_HIDE_LABELS, null
  PlaySound "shothit2"
  
  gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) + 1
  If gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 2 Then
    'TODO PUPEVENT OVERDRIVE MULTIBALL

  Else

    Select Case gameState("game")("augmentationActive")
      Case 0:
        pupevent 411 'tiger, hyperjump
      Case 1:
        pupevent 413 'leftorbit,bat
      Case 2:
        'pupevent 400 'leftramp,bull
      Case 3:
        pupevent 410 'spinner, lion
      Case 4:
        pupevent 414 'bumpers,hawk
      Case 5:
        'pupevent 407 'center ramps,deer
      Case 6:
        'pupevent 403 'rightramp,panther
      Case 7:
        'pupevent 406 'right orbit,owl
      Case 8:
        'pupevent 408 'shortcut,rhino
    End Select

  End If

  vpmTimer.addtimer Timings(TIMINGS_COLLECT_AUGMENTATION), "vpmTimerGameFinishAugmentationResearchStage2 '"

End Sub

Sub vpmTimerGameFinishAugmentationResearchStage2
  pupevent 600
  PlayBGAudioNext()
  RPin.IsDropped = 1
  DISPATCH LIGHTS_GI_ON, Null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, null
  DISPATCH LIGHTS_RESEARCH_RESET, null
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  
  DISPATCH GAME_MODE_NORMAL, Null
  
  If gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 2 Then
    'TODO DISPATCH OVERDRIVE MULTIBALL
    gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 1
  End If

  SwitchSetAugmentation True, "pal_orange"
End Sub

Sub GameModeAugmentationSetShot(s)
  Select Case s
    Case -1:
      StopLightBlink(lSeqHoldAug)
      lSeqHyperJump.RemoveItem(lSeqHyperJumpPerkShot)
      lSeqLeftOrbit.RemoveItem(lSeqLeftOrbitPerkShot)
      lSeqShortcut.RemoveItem(lSeqShortcutPerkShot)
      lSeqRightOrbit.RemoveItem(lSeqRightOrbitPerkShot)
      lSeqRightRamp.RemoveItem(lSeqRightRampPerkShot)
      lSeqCenterRamp.RemoveItem(lSeqCenterRampPerkShot)
      lSeqSpinner.RemoveItem(lSeqSpinnerPerkShot)
      lSeqBumpers.RemoveItem(lSeqBumpersPerkShot)
      lSeqLeftRamp.RemoveItem(lSeqLeftRampPerkShot)
    Case 0:
      lSeqHyperJump.AddItem(lSeqHyperJumpActiveShot)
      AddGameTargetShot GAME_SHOT_HYPER_JUMP
    Case 1:
      lSeqLeftOrbit.AddItem(lSeqLeftOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_ORBIT
    Case 2:
      lSeqLeftRamp.AddItem(lSeqLeftRampActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_RAMP
    Case 3:
      lSeqSpinner.AddItem(lSeqSpinnerActiveShot)
      AddGameTargetShot GAME_SHOT_SPINNER
    Case 4:
      lSeqBumpers.AddItem(lSeqBumpersActiveShot)
      AddGameTargetShot GAME_SHOT_BUMPERS
    Case 5:
      lSeqCenterRamp.AddItem(lSeqCenterRampActiveShot)
      AddGameTargetShot GAME_SHOT_CENTER_RAMP
    Case 6:
      lSeqRightRamp.AddItem(lSeqRightRampActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_RAMP
    Case 7:
      lSeqRightOrbit.AddItem(lSeqRightOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_ORBIT
    Case 8:
      lSeqShortcut.AddItem(lSeqShortcutActiveShot)
      AddGameTargetShot GAME_SHOT_SHORTCUT
  End Select
End Sub

Sub AddGameTargetShot(shot)

	If Not gameState("game")("targetShots").Exists(shot) Then
		gameState("game")("targetShots").Add shot, True
	End If

End Sub

Sub RemoveGameTargetShot(shot)

	If gameState("game")("targetShots").Exists(shot) Then
		gameState("game")("targetShots").Remove shot
	End If

End Sub

Sub GameAwardSkillshot()

  PlayGameCallout("skillshot")
  DOF 251, DOFOn
  SwitchSetAugmentation False, "pal_orange"
  lSeqLightsOverride.AddItem(lSeqSkillshot)
	DISPATCH LIGHTS_START_SEQUENCE, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
  FlashDomes 6, 2
  vpmTimer.AddTimer 1200, "vpmTimerAwardEarlyResearch '"
  vpmTimer.AddTimer 400, "vpmTimerAwardSkillshotDof1 '"
End Sub

Sub vpmTimerAwardSkillshotDof1
  DOF 251, DOFOff
  DOF 252, DOFOn
  vpmTimer.AddTimer 400, "vpmTimerAwardSkillshotDof2 '"
End Sub

Sub vpmTimerAwardSkillshotDof2
  DOF 252, DOFOff 
End Sub

Sub vpmTimerAwardEarlyResearch()
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
  If gameState("lights")("activeResearch").Count < 3 Then
    gameState("lights")("activeResearch").RemoveAll()  
    gameState("lights")("activeResearch").Add "aug1", True
    gameState("lights")("activeResearch").Add "aug2", True
    gameState("lights")("activeResearch").Add "aug3", True
    LightOn(lsResearch1)
    LightOn(lsResearch2)
    LightOn(lsResearch3)
    CheckResearchLights
  End If
End Sub


Sub GameBallSaveEnded()

  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
  If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
    SwitchSetAugmentation False, "pal_orange"
    DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
  End If

  gameState("game")("ballSave") = False

End Sub

Sub GameEnableBallSave()

  EnableBallSaver(15)
  gameState("game")("ballSave") = True
  p_watchdisplay_left.blenddisablelighting = 15
  p_watchdisplay_right.blenddisablelighting = 15

End Sub

Sub GameEnableBallLock()

  DiverterDir = -1
  DiverterOff.IsDropped=1
  DiverterOn.IsDropped=0
  timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
  PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002

End Sub

Sub GameDisableBallLock()

  DiverterDir = 1
  DiverterOff.IsDropped=0
  DiverterOn.IsDropped=1
  timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
  PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002

End Sub

Sub GameCheckLocks()

  If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
    If gameState("switches")("lightlock") = 2 Then 'Lock Open
      'Set Diverters
      LightOn(lsLightLock)
      DISPATCH GAME_ENABLE_BALL_LOCK, Null
    Else
      LightBlink(lsLightLock)
      DISPATCH GAME_DISABLE_BALL_LOCK, Null
    End If
  Else
    LightOff(lsLightLock)
    DISPATCH GAME_DISABLE_BALL_LOCK, Null
  End If

End Sub

Sub GameCheckLanes()

  CheckLaneLights()

End Sub

Sub GameClearShots()
  lSeqHyperJump.RemoveAll()
  lSeqLeftOrbit.RemoveAll()
  lSeqShortcut.RemoveAll()
  lSeqRightOrbit.RemoveAll()
  lSeqRightRamp.RemoveAll()
  lSeqCenterRamp.RemoveAll()
  lSeqSpinner.RemoveAll()
  lSeqBumpers.RemoveAll()
  lSeqLeftRamp.RemoveAll()
  gameState("game")("targetShots").RemoveAll
  gameState("game")("perkShot") = ""
End Sub

Sub GameMultiballJackpot
  GameAddScore GAME_POINTS_JACKPOT
  gameState("game")("multiballJackpots") = gameState("game")("multiballJackpots") +1
  If gameState("game")("multiballJackpots")=5 Then
    LightOff(lsCyber1)
    LightOff(lsCyber2)
    LightOff(lsCyber3)
    LightOff(lsCyber4)
    LightOff(lsCyber5)
    lSeqMultiballCShot.Image = "pal_orange"
    lSeqMultiballYShot.Image = "pal_orange"
    lSeqMultiballBShot.Image = "pal_orange"
    lSeqMultiballEShot.Image = "pal_orange"
    lSeqMultiballRShot.Image = "pal_orange"
    lSeqMultiballC.AddItem(lSeqMultiballCShot)
    lSeqMultiballY.AddItem(lSeqMultiballYShot)
    lSeqMultiballB.AddItem(lSeqMultiballBShot)
    lSeqMultiballE.AddItem(lSeqMultiballEShot)
    lSeqMultiballR.AddItem(lSeqMultiballRShot)
    AddGameTargetShot(GAME_SHOT_LEFT_ORBIT)
    AddGameTargetShot(GAME_SHOT_LEFT_RAMP)
    AddGameTargetShot(GAME_SHOT_CENTER_RAMP)
    AddGameTargetShot(GAME_SHOT_RIGHT_RAMP)
    AddGameTargetShot(GAME_SHOT_RIGHT_ORBIT)
  End If
  If gameState("game")("multiballJackpots")=6 Then
    'Super Jackpot
    LightOff(lsCyber1)
    LightOff(lsCyber2)
    LightOff(lsCyber3)
    LightOff(lsCyber4)
    LightOff(lsCyber5)
    AddGameTargetShot(GAME_SHOT_LEFT_ORBIT)
    AddGameTargetShot(GAME_SHOT_LEFT_RAMP)
    AddGameTargetShot(GAME_SHOT_CENTER_RAMP)
    AddGameTargetShot(GAME_SHOT_RIGHT_RAMP)
    AddGameTargetShot(GAME_SHOT_RIGHT_ORBIT)
    lSeqMultiballCShot.Image = "pal_green"
    lSeqMultiballYShot.Image = "pal_green"
    lSeqMultiballBShot.Image = "pal_green"
    lSeqMultiballEShot.Image = "pal_green"
    lSeqMultiballRShot.Image = "pal_green"
    lSeqMultiballC.AddItem(lSeqMultiballCShot)
    lSeqMultiballY.AddItem(lSeqMultiballYShot)
    lSeqMultiballB.AddItem(lSeqMultiballBShot)
    lSeqMultiballE.AddItem(lSeqMultiballEShot)
    lSeqMultiballR.AddItem(lSeqMultiballRShot)
    gameState("game")("multiballJackpots") = 0
  End If
End Sub

Sub GameAwardPerkShot()
  FlashDomes 2, 2
  DOF 230, DOFOn
  gameState("game")("perkShotActive") = True
  vpmTimer.AddTimer 1000, "vpmTimerAwardPerkShotCooldown '"
  If gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 0 Then
    
    Select Case gameState("game")("augmentationActive")
      Case 0:
        GameAddScore GAME_POINTS_BASE    
      Case 1:
        GameAddScore GAME_POINTS_BASE
      Case 2:
        GameAddScore GAME_POINTS_BASE
      Case 3:
        GameAddScore GAME_POINTS_SPINNER
      Case 4:
        GameAddScore GAME_POINTS_BUMPERS
      Case 5:
        GameAddScore GAME_POINTS_BASE
      Case 6:
        GameAddScore GAME_POINTS_BASE
      Case 7:
        GameAddScore GAME_POINTS_BASE
      Case 8:
        GameAddScore GAME_POINTS_BASE
    End Select

  ElseIf gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 1 Then
  
    Select Case gameState("game")("augmentationActive")
      Case 0:

      Case 1:
          
      Case 2:
          
      Case 3:
          
      Case 4:
          
      Case 5:
          
      Case 6:
          
      Case 7:
          
      Case 8:
          
    End Select

  End IF


  

End Sub

Sub vpmTimerAwardPerkShotCooldown

  gameState("game")("perkShotActive") = False
  DOF 230, DOFOff

End Sub


Sub GameAddScore(score)

  'Apply any modifiers

  DebugScore = DebugScore + score

End Sub

Sub GameCombo(combo)

  If IsLightOn(combo) Or gameState("game")("combo") = 0 Then
    gameState("game")("combo") = gameState("game")("combo") + 1
    gameState("game")("comboTime") = GameTime
    If gameState("game")("combo") = 1 Then
      LightBlink(lsCombo1)
      LightBlink(lsCombo2)
      LightBlink(lsCombo3)
      LightBlink(lsCombo4)
      LightBlink(lsCombo5)
    Else
      GameAddScore GAME_POINTS_COMBO * gameState("game")("combo")
    End If
    LightOff(combo)
    comboTimer.Enabled = True
    gameState("game")("currentCombo") = gameState("game")("currentCombo") & CStr(combo.Idx)
    Debug.print gameState("game")("currentCombo")
    If GameCombos.Exists(gameState("game")("currentCombo")) Then
      Debug.print "add combo"
      gameState("game")("combosMade").Add gameState("game")("currentCombo"), GameCombos(gameState("game")("currentCombo"))
    End If
  End If
  
End Sub

Sub comboTimer_Timer

  If GameTime - gameState("game")("comboTime") > 6000 Then
    comboTimer.Enabled = False
    LightOff(lsCombo1)
    LightOff(lsCombo2)
    LightOff(lsCombo3)
    LightOff(lsCombo4)
    LightOff(lsCombo5)
    gameState("game")("combo") = 0
    gameState("game")("currentCombo") = ""
  End If

End Sub

'Sub vpmTimerDOFOff(DOFCode)
'  Execute "DOF "&code&", DOFOff"
'End Sub

'***********************************************************************************************************************

