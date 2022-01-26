'***********************************************************************************************************************
'*****  Game Dispatch                                   	                                                        ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub GameStartOfBall()

  RPin.IsDropped = 1

	Dispatch LIGHTS_GI_NORMAL, null
	Dispatch LIGHTS_GI_ON, Null
	DiverterOff.IsDropped=0
	DiverterOn.IsDropped=1

	diverterWall3Off.IsDropped = 0
	diverterWall3On.IsDropped = 1
	
	'pupevent 500
  PlayMainBGMusic()
	
	ballRelease.CreateSizedball BallSize / 2
  ballRelease.Kick 90, 4
	

  gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True
  gameState("game")("modes")(GAME_MODE_NORMAL) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  gameState("game")("pauseLights") = False
  'Set Random Aug
  Dim c: c = RndNum(0,8)
  gameState("game")("augmentationActive") = c
  PlayGameCallout("choose_skillshot")
  SwitchSetAugmentation False, "pal_yellow"
  '

  

End Sub

Sub GameEndOfBall()
  EndMusic
  Dispatch LIGHTS_GI_OFF, Null
  If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
    DISPATCH LIGHTS_RESEARCH_OFF, Null
    StopLightBlink(lSeqFinish)
    GameModeAugmentationSetShot(-1)
  End If
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
  gameState("game")("pauseLights") = True
  StopBallSaver()
  DISPATCH LIGHTS_PAUSE, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
  
  'play pup
  vpmTimer.addtimer 3000, "vpmTimerGameEndOfBallStage2 '"

End Sub

Sub vpmTimerGameEndOfBallStage2()
  DISPATCH GAME_START_OF_BALL, Null
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
  If gameState("game")("augmentationReady") = False Then
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
  End If
End Sub

Sub GameStartAugmentationResearch()
  
  gameState("game")("modes")(GAME_MODE_NORMAL) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True
  gameState("game")("augmentationResearchStage") = 0
  gameState("game")("augmentationReady") = False
  TurnOffFluxFlasher(1)
  TurnOffFluxFlasher(2)
  DISPATCH LIGHTS_RESEARCH_OFF, null
  DISPATCH LIGHTS_RESEARCH_READY_OFF, null
  DISPATCH GAME_HIDE_LABELS, null
  DISPATCH LIGHTS_AUGMENTATIONS_OFF, null
  GameModeAugmentationSetShot(-1)
  
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
  'pupevent 505 'stop music
  EndMusic
  vpmTimer.addtimer Timings(TIMINGS_START_AUG_RESEARCH), "vpmTimerGameStartAugmentationResearchStage2 '"
End Sub

Sub vpmTimerGameStartAugmentationResearchStage2
    pupevent 600 'main  - bg
    'pupevent 504 'music - hackers
    PlayAugmentationBGMusic()
    DISPATCH GAME_SHOW_LABELS, null
    DISPATCH GAME_LOCK_AUGMENTATIONS, null
    DISPATCH LIGHTS_GI_AUGMENTATION_RESEARCH, null
    LightBlink(lsResearch1)
    LightBlink(lsResearch2)
    LightBlink(lsResearch3)
    'Setup Shots
    GameModeAugmentationSetShot(gameState("game")("augmentationActive"))

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

  lcAugmentations(gameState("game")("augmentationActive")).Image = "pal_blue"
  LightBlink(lcAugmentations(gameState("game")("augmentationActive")))
  lSeqCaptive.RemoveItem(lSeqCaptiveAugHold)
  StopLightBlink(lSeqHoldAug)
  gameState("switches")("captive") = 1
End Sub

Sub GameUnlockAugmentations()
  gameState("game")("augmentationHold") = 1
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
End Sub

Sub GameHideLabels()
  gameState("game")("hideScore") = True

  if (usePUP=false or PUPStatus=false) then Exit Sub
  
  PuPlayer.LabelSet   pBackglass, "lblAug",         "PupOverlays\\augLion.png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':100}"
  PuPlayer.LabelSet   pBackglass, "lblPlayer",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblBall",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblPerk",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "CurScore1",      "",   1,  "{}"
End Sub

Sub GameShowLabels()
  gameState("game")("hideScore") = False

  if (usePUP=false or PUPStatus=false) then Exit Sub
  
  PuPlayer.LabelSet   pBackglass, "lblPlayer",    "Player 1",                 1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblBall",      "Ball 1",                   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\aug" & AugmentationNames(gameState("game")("augmentationActive")) & ".png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"
  PuPlayer.LabelSet   pBackglass, "lblPerk",      "Perk: " & AugmentationPerksLvl1(gameState("game")("augmentationActive")) & "",            1,  "{}"
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

  gameState("game")("augmentationResearchStage") = gameState("game")("augmentationResearchStage") + 1
  Select Case gameState("game")("augmentationResearchStage")
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

  
  lSeqRightRamp.RemoveItem(lSeqRightRampCollectShot)
  StopLightBlink(lSeqFinish)
  RPin.IsDropped = 0
  LightSeqAllLights.StopPlay
  LightSeqAllLights.UpdateInterval = 8
  LightSeqAllLights.Play SeqStripe1VertOn , 10, 0
  LightSeqAllLights.Play SeqStripe1HorizOn , 10, 0
  
End Sub

Sub GameModeCollectAugmentation()

  DISPATCH LIGHTS_GI_OFF, Null
  'pupevent 503 'stop music hackers
  EndMusic
  gameState("game")("targetShots").RemoveAll()
  DISPATCH GAME_HIDE_LABELS, null
  PlaySound "shothit2"
  pupevent 410
  vpmTimer.addtimer Timings(TIMINGS_COLLECT_AUGMENTATION), "vpmTimerGameFinishAugmentationResearchStage2 '"

End Sub

Sub vpmTimerGameFinishAugmentationResearchStage2
  pupevent 600
  pupevent 500
  PlayMainBGMusic()
  RPin.IsDropped = 1
  DISPATCH LIGHTS_GI_ON, Null
  DISPATCH LIGHTS_GI_NORMAL, null
  DISPATCH GAME_SHOW_LABELS, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, null
  DISPATCH LIGHTS_RESEARCH_OFF, null
  gameState("game")("modes")(GAME_MODE_NORMAL) = True
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  Select Case gameState("game")("augmentationActive")
    Case 0:
      gameState("game")("augTigerLvl")=gameState("game")("augTigerLvl")+1
    Case 1:
      gameState("game")("augBatLvl")=gameState("game")("augBatLvl")+1
    Case 2:
      gameState("game")("augBullLvl")=gameState("game")("augBullLvl")+1
    Case 3:
      gameState("game")("augLionLvl")=gameState("game")("augLionLvl")+1
    Case 4:
      gameState("game")("augHawkLvl")=gameState("game")("augHawkLvl")+1
    Case 5:
      gameState("game")("augDeerLvl")=gameState("game")("augDeerLvl")+1
    Case 6:
      gameState("game")("augPantherLvl")=gameState("game")("augPantherLvl")+1
    Case 7:
      gameState("game")("augOwlLvl")=gameState("game")("augOwlLvl")+1
    Case 8:
      gameState("game")("augRhinoLvl")=gameState("game")("augRhinoLvl")+1
  End Select 
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

Sub GameAwardSkillshot()

  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
  PlayGameCallout("skillshot")
  SwitchSetAugmentation False, "pal_orange"
  lSeqLightsOverride.AddItem(lSeqSkillshot)
	DISPATCH LIGHTS_START_SEQUENCE, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null

End Sub


Sub GameBallSaveEnded()

  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
  SwitchSetAugmentation False, "pal_orange"
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null

End Sub

Sub GameEnableBallSave()

  EnableBallSaver(15)
  p_watchdisplay_left.blenddisablelighting = 15
  p_watchdisplay_right.blenddisablelighting = 15
  'LightOn(lsBallSaverClock1)
  'LightOn(lsBallSaverClock2)
  'LightOn(lsBallSaverClock3)

End Sub

'***********************************************************************************************************************

