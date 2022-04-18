'***********************************************************************************************************************
'*****  COLORS                                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim c_augmentationResearch,c_augmentationResearchFull,c_black, c_normal,c_normal_full, c_multiball, c_race, c_perkshot
Dim gameColors(6), gameDomes(6)

gameColors(0) = RGB(207, 11, 198)
gameColors(1) = RGB(17, 247, 255)
gameColors(2) = RGB(173, 112, 20)
gameColors(3) = RGB(4, 120, 255)
gameColors(4) = RGB(255, 0, 0)
gameColors(5) = RGB(64,62,2)
gameColors(6) = RGB(207, 194, 11)

gameDomes(0) = "dome2litpurple"
gameDomes(1) = "dome2litcyan"
gameDomes(2) = "dome2litorange"
gameDomes(3) = "dome2litblue"
gameDomes(4) = "dome2litred"
gameDomes(5) = "dome2litblack"
gameDomes(6) = "dome2lityellow"

const ColorMultiplier = 0.8
const FullColorMultiplier = 0.95


c_augmentationResearch = RGB(8,247,254)
c_multiball = RGB(45, 207, 53)
c_race = RGB(207, 194, 11)
'c_empire_full = RGB(61*FullColorMultiplier,12*FullColorMultiplier,97*FullColorMultiplier)
'c_soviet = RGB(133*ColorMultiplier,12*ColorMultiplier,12*ColorMultiplier)
'c_soviet_full = RGB(133*FullColorMultiplier,12*FullColorMultiplier,12*FullColorMultiplier)

'c_allied = RGB(29*ColorMultiplier,44*ColorMultiplier,144*ColorMultiplier)
'c_allied_full = RGB(29*FullColorMultiplier,44*FullColorMultiplier,144*FullColorMultiplier)

c_black = RGB(0,0,0)
c_normal = RGB(243*ColorMultiplier,242*ColorMultiplier, 255*ColorMultiplier)
c_normal_full = RGB(243*ColorMultiplier,242*ColorMultiplier, 255*ColorMultiplier)

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  GAME                                                  	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Dim DebugScore
Dim gameState

Sub StartGame()

    Dim colors,materials,army,laneLights,lights,gameLogic,switches
    Set gameState = CreateObject("Scripting.Dictionary")
    Set materials=CreateObject("Scripting.Dictionary")


	
    Set laneLights = InitLaneLightsState
    Set lights = InitLightsState
	Set switches = InitSwitchesState
    Set gameLogic = InitGameLogicState

    materials.Add "allied", mat_allied
    materials.Add "soviet", mat_soviet
    materials.Add "empire", mat_empire
    materials.Add "rgb", mat_rgb
    gameState.Add "materials", materials
    gameState.Add "laneLights", laneLights
    gameState.Add "lights", lights
	gameState.Add "switches", switches
    gameState.Add "game", gameLogic

    Dispatch RESET_LANE_LIGHTS, Null
    'Dispatch LIGHTS_RESET_COMMANDERS, Null

	StartLightSeq(lSeqHyperJump)
	StartLightSeq(lSeqLeftOrbit)
	StartLightSeq(lSeqLeftRamp)
	StartLightSeq(lSeqSpinner)
	StartLightSeq(lSeqCenterRamp)
	StartLightSeq(lSeqBumpers)
	StartLightSeq(lSeqBumpersFlash)
	StartLightSeq(lSeqRightRamp)
	StartLightSeq(lSeqRightOrbit)
	StartLightSeq(lSeqShortcut)
	StartLightSeq(lSeqPlungerLane)
	StartLightSeq(lSeqMultiballC)
	StartLightSeq(lSeqMultiballY)
	StartLightSeq(lSeqMultiballB)
	StartLightSeq(lSeqMultiballE)
	StartLightSeq(lSeqMultiballR)
	StartLightSeq(lSeqMultiballCYBER)

	gameState("game")("playerName") = "Player 1"
  	gameState("game")("playerBall") = 1
	
	StartLightSeq(lSeqAugmentation)
	StartLightSeq(lSeqCaptive)
	
	gameState("switches")("lightlock") = 1

	StartLightSeq(lSeqLeftDrain)
	StartLightSeq(lSeqRightDrain)

	DebugScore = "0"

	LockPin.IsDropped = False

	DISPATCH LIGHTS_RESEARCH_RESET, null
	DISPATCH GAME_START_OF_BALL, null
	DISPATCH GAME_CHECK_BET, Null
	gameStarted = True
End Sub

'*********************************************************************
'           Game Timer, Ball Rolling, Ball Shadows, Ball Drop
'*********************************************************************

Const tnob = 10 ' total number of balls
ReDim rolling(tnob)
InitRolling

Function BallSpeed(ball) 'Calculates the ball speed
    BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

Sub InitRolling
    Dim i
    For i = 0 to tnob
        rolling(i) = False
    Next
End Sub

Const PlayFDivStart = 180.7

Sub GameTimer_timer()

	Dim BOT, b
	BOT = GetBalls

    Diverter.RotZ = DiverterFlipper.CurrentAngle
    Diverter001.RotZ = DiverterFlipper.CurrentAngle

	For b = UBound(BOT) + 1 to tnob
		if rolling(b) Then
			rolling(b) = False
			StopSound("fx_ballrolling" & b)
		End if 
    Next

	' play the rolling sound for each ball
	For b = 0 to UBound(BOT)
		If BallSpeed(BOT(b) ) > 1 AND BOT(b).z < 27 and BOT(b).radius > 23  Then
			rolling(b) = True
			PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b))*RollingSoundFactor, AudioPan(BOT(b)), 0, Pitch(BOT(b)), 1, 0, AudioFade(BOT(b))
		Else
			If rolling(b) = True Then
				StopSound("fx_ballrolling" & b)
				rolling(b) = False
			End If
		End If

		'***Ball Drop Sounds***
		If BOT(b).radius > 23 and BOT(b).VelZ < -1 and BOT(b).z < 55 and BOT(b).z > 27 Then 'height adjust for ball drop sounds
			PlaySound "fx_ball_drop" & b, 0, (ABS(BOT(b).velz)/17)^2, AudioPan(BOT(b)), 0, Pitch(BOT(b)), 1, 0, AudioFade(BOT(b))
		End If

	Next

	cor.update

	FlipperTimer

End Sub

Sub FrameTimer_Timer()
	If gameStarted Then
	'BallShadowUpdate
	'RDampen
	'GatesTimer
	'RollingSound
		LampTimer
		If DynamicBallShadowsOn=1 Then DynamicBSUpdate 'update ball shadows
	'VR_Primary_plunger.Y = -50 + (5* Plunger.Position) -20
	End IF
End Sub

'******************************************************
'						FUNCTIONS
'******************************************************

'Tracks ball velocity for judging bounce calculations & angle
'apologies to JimmyFingers is this is what his script does. I know his tracks ball velocity too but idk how it works in particular
dim cor : set cor = New CoRTracker
cor.debugOn = False
'cor.update() - put this on a low interval timer
Class CoRTracker
	public DebugOn 'tbpIn.text
	public ballvel

	Private Sub Class_Initialize : redim ballvel(0) : End Sub 
	'TODO this would be better if it didn't do the sorting every ms, but instead every time it's pulled for COR stuff
	Public Sub Update()	'tracks in-ball-velocity
		dim str, b, AllBalls, highestID : allBalls = getballs
		'if uBound(allballs) < 0 then if DebugOn then str = "no balls" : TBPin.text = str : exit Sub else exit sub end if: end if
		for each b in allballs
			if b.id >= HighestID then highestID = b.id
		Next

		if uBound(ballvel) < highestID then redim ballvel(highestID)	'set bounds

		for each b in allballs
			ballvel(b.id) = BallSpeed(b)
'			if DebugOn then 
'				dim s, bs 'debug spacer, ballspeed
'				bs = round(BallSpeed(b),1)
'				if bs < 10 then s = " " else s = "" end if
'				str = str & b.id & ": " & s & bs & vbnewline 
'				'str = str & b.id & ": " & s & bs & "z:" & b.z & vbnewline 
'			end if
		Next
		'if DebugOn then str = "ubound ballvels: " & ubound(ballvel) & vbnewline & str : if TBPin.text <> str then TBPin.text = str : end if
	End Sub
End Class

'*** PI returns the value for PI
Function PI()
	PI = 4*Atn(1)
End Function

'*** Determines if a Points (px,py) is inside a 4 point polygon A-D in Clockwise/CCW order
Function InRect(px,py,ax,ay,bx,by,cx,cy,dx,dy)
	Dim AB, BC, CD, DA
	AB = (bx*py) - (by*px) - (ax*py) + (ay*px) + (ax*by) - (ay*bx)
	BC = (cx*py) - (cy*px) - (bx*py) + (by*px) + (bx*cy) - (by*cx)
	CD = (dx*py) - (dy*px) - (cx*py) + (cy*px) + (cx*dy) - (cy*dx)
	DA = (ax*py) - (ay*px) - (dx*py) + (dy*px) + (dx*ay) - (dy*ax)
 
	If (AB <= 0 AND BC <=0 AND CD <= 0 AND DA <= 0) Or (AB >= 0 AND BC >=0 AND CD >= 0 AND DA >= 0) Then
		InRect = True
	Else
		InRect = False       
	End If
End Function

Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

Function DistancePL(px,py,ax,ay,bx,by) ' Distance between a point and a line where point is px,py
	DistancePL = ABS((by - ay)*px - (bx - ax) * py + bx*ay - by*ax)/Distance(ax,ay,bx,by)
End Function

Function AnglePP(ax,ay,bx,by)
	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
End Function

Function Atn2(dy, dx)
	If dx > 0 Then
		Atn2 = Atn(dy / dx)
	ElseIf dx < 0 Then
		Atn2 = Sgn(dy) * (PI - Atn(Abs(dy / dx)))
	ElseIf dy = 0 Then
		Atn2 = 0
	Else
		Atn2 = Sgn(dy) * Pi / 2
	End If
End Function

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  GAME DISPATCH                                         	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Dispatch(action, options)
		
    'DebugPost action

    Select Case action

        Case RESET_LANE_LIGHTS:
            ResetLaneLights
        Case ROTATE_LANE_LIGHTS_CLOCKWISE:
            RotateLaneLightsClockwise    
        Case ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE:
            RotateLaneLightsAntiClockwise
        Case LIGHTS_UPDATE:
            LightsUpdate
        Case LIGHTS_GI_ON:
            LightsGiOn
        Case LIGHTS_GI_OFF:
            LightsGiOff
        Case LIGHTS_GI_NORMAL:
            LightsGiNormal
        Case LIGHTS_GI_DOMES:
            LightsGiDomes options
        Case LIGHTS_GI_AUGMENTATION_RESEARCH:
            LightsGiAugmentationResearch     
        Case LIGHTS_GI_MULTIBALL:
            LightsGiMultiball  
        Case LIGHTS_GI_HURRYUP:
            LightsGiHurryup                                        
        Case LIGHTS_START_SEQUENCE:
            LightsStartSequence            
        Case LIGHTS_RESEARCH_OFF:
            LightsResearchOff
        Case LIGHTS_RESEARCH_RESET:
            LightsResearchReset
        Case LIGHTS_RESEARCH_READY_OFF:
            LightsResearchReadyOff            
        Case LIGHTS_AUGMENTATIONS_OFF:
            LightsAugmentationsOff
        Case LIGHTS_PAUSE:
            LightsPause
        Case SWITCH_HIT_AUGMENTATION:
            SwitchHitAugmentation
        Case SWITCH_HIT_CAPTIVE:
            SwitchHitCaptive
        Case SWITCH_HIT_RESEARCH_1:
            SwitchHitResearch1
        Case SWITCH_HIT_RESEARCH_2:
            SwitchHitResearch2
        Case SWITCH_HIT_RESEARCH_3:
            SwitchHitResearch3
        Case SWITCH_HIT_PRE_LEFT_ORBIT:
            SwitchHitPreLeftOrbit
        Case SWITCH_HIT_LEFT_ORBIT:
            SwitchHitLeftOrbit
        Case SWITCH_HIT_PRE_RIGHT_ORBIT:
            SwitchHitPreRightOrbit            
        Case SWITCH_HIT_RIGHT_ORBIT:
            SwitchHitRightOrbit            
        Case SWITCH_LEFT_FLIPPER_DOWN:
            SwitchLeftFlipperDown
        Case SWITCH_RIGHT_FLIPPER_DOWN:
            SwitchRightFlipperDown
        Case SWITCH_HIT_CONSOLE:
            SwitchHitConsole
        Case SWITCH_HIT_SPINNER2:
            SwitchHitSpinner2        
        Case SWITCH_HIT_HYPERJUMP:
            SwitchHitHyperJump
        Case SWITCH_HIT_BUMPER:
            SwitchHitBumper          
        Case SWITCH_HIT_LEFT_RAMP:
            SwitchHitLeftRamp
        Case SWITCH_HIT_RIGHT_RAMP:
            SwitchHitRightRamp
        Case SWITCH_HIT_CENTER_RAMP:
            SwitchHitCenterRamp            
        Case SWITCH_HIT_SHORTCUT:
            SwitchHitShortcut     
        Case SWITCH_HIT_RAMP_PIN:
            SwitchHitRampPin
        Case SWITCH_HIT_PLUNGER_LANE:
            SwitchHitPlungerLane    
        Case SWITCH_HIT_LIGHT_LOCK:
            SwitchHitLightLock
        Case SWITCH_HIT_LEFT_OUTLANE:
            SwitchHitLeftOutlane
        Case SWITCH_HIT_LEFT_INLANE:
            SwitchHitLeftInlane
        Case SWITCH_HIT_RIGHT_INLANE:
            SwitchHitRightInlane
        Case SWITCH_HIT_RIGHT_OUTLANE:
            SwitchHitRightOutlane
        Case SWITCH_HIT_BALL_LOCK:
            SwitchHitBallLock
        Case SWITCH_HIT_SECRET_UPGRADE:
            SwitchHitSecretUpgrade
        Case SWITCH_HIT_BET
            SwitchHitBet
        Case GAME_START_OF_BALL:
            GameStartOfBall
        Case GAME_END_OF_BALL:
            GameEndOfBall        
        Case GAME_AUGMENTATION_READY:
            GameAugmentationReady
        Case GAME_RACE_READY
            GameRaceReady
        Case GAME_START_AUGMENTATION_RESEARCH:
            GameStartAugmentationResearch
        Case GAME_LOCK_AUGMENTATIONS:
            GameLockAugmentations
        Case GAME_UNLOCK_AUGMENTATIONS:
            GameUnLockAugmentations            
        Case GAME_SHOW_LABELS:
            GameShowLabels
        Case GAME_HIDE_LABELS:
            GameHideLabels
        Case GAME_MODE_NORMAL
            GameModeNormal
        Case GAME_MODE_ADVANCE_AUGMENTATION:
            GameModeAdvanceAugmentation
        Case GAME_START_MODE_HURRYUP:
            GameStartModeHurryUp
        Case GAME_MODE_FINISH_AUGMENTATION:
            GameModeFinishAugmentation       
        Case GAME_COMBO
            GameCombo options
        Case GAME_AWARD_HURRYUP
            GameAwardHurryup
        Case GAME_MODE_COLLECT_AUGMENTATION:
            GameModeCollectAugmentation
        Case GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE:
            GameRotateSkillshotAntiClockwise
        Case GAME_ROTATE_SKILLSHOT_CLOCKWISE:
            GameRotateSkillshotClockwise            
        Case GAME_AWARD_SKILLSHOT:
            GameAwardSkillshot
        Case GAME_BALL_SAVE_ENDED:
            GameBallSaveEnded
        Case GAME_ENABLE_BALL_SAVE
            GameEnableBallSave
        Case GAME_ENABLE_BALL_LOCK
            GameEnableBallLock
        Case GAME_DISABLE_BALL_LOCK
            GameDisableBallLock
        Case GAME_CHECK_LOCKS
            GameCheckLocks
        Case GAME_CHECK_LANES
            GameCheckLanes
        Case GAME_CHECK_BET
            GameCheckBet
        Case GAME_CLEAR_SHOTS
            GameClearShots
        Case GAME_MULTIBALL_JACKPOT
            GameMultiballJackpot
        Case GAME_AWARD_PERKSHOT
            GameAwardPerkShot
        Case GAME_END
            GameEnd
        Case Else
            MsgBox("Action Unknown")
    End Select

End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Games Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const GAME_AUGMENTATION_READY = "Game Augmentation Ready"
Const GAME_RACE_READY = "Game Race Ready"
Const GAME_START_AUGMENTATION_RESEARCH = "Game Start Augmentation Research"
Const GAME_LOCK_AUGMENTATIONS = "Game Lock Augmentations"
Const GAME_UNLOCK_AUGMENTATIONS = "Game UnLock Augmentations"
Const GAME_SHOW_LABELS = "Game Show Labels"
Const GAME_HIDE_LABELS = "Game Hide Labels"
Const GAME_MODE_ADVANCE_AUGMENTATION = "Game Mode Advance Augmentation"
Const GAME_MODE_FINISH_AUGMENTATION = "Game Mode Finish Augmentation"
Const GAME_MODE_COLLECT_AUGMENTATION = "Game Mode Collect Augmentation"
Const GAME_START_MODE_HURRYUP = "Game Start Mode Hurryup"
Const GAME_COMBO = "Game Combo"
Const GAME_AWARD_HURRYUP = "Game Award Hurry Up"

Const GAME_START_OF_BALL = "Game Start of Ball"
Const GAME_END_OF_BALL = "Game End of Ball"
Const GAME_END = "Game End"

Const GAME_ROTATE_SKILLSHOT_CLOCKWISE = "Game Rotate Skillshot Clockwise"
Const GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE = "Game Rotate Skillshot Anti Clockwise"

Const GAME_AWARD_SKILLSHOT = "Game Award Skillshot"
Const GAME_BALL_SAVE_ENDED = "Game Ball Save Ended"
Const GAME_ENABLE_BALL_SAVE = "Game Enable Ball Save"
Const GAME_ENABLE_BALL_LOCK = "Game Enable Ball Lock"
Const GAME_DISABLE_BALL_LOCK = "Game Disable Ball Lock"

Const GAME_CHECK_LOCKS = "Game Check Locks"
Const GAME_CHECK_LANES = "Game Check Lanes"
Const GAME_CLEAR_SHOTS = "Game Clear Shots"
Const GAME_MULTIBALL_JACKPOT = "Game Multiball Jackpot"
Const GAME_AWARD_PERKSHOT = "Game Award Perkshot"
Const GAME_CHECK_BET = "Game Check Bet"

'***********************************************************************************************************************

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
  DISPATCH GAME_CHECK_BET, Null
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
    GameModeSetShot -1, "pal_purple"
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
  SwitchSetAugmentation False, "pal_yellow"

End Sub

Sub GameRotateSkillshotClockwise()

  Dim i:i=gameState("game")("augmentationActive")+1
  If i>8 Then
    i = 0
  End If
  gameState("game")("augmentationActive") = i
  SwitchSetAugmentation False, "pal_yellow"

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
  gameState("game")("modes")(GAME_MODE_HURRYUP) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True
  'gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = 0
  gameState("game")("augmentationReady") = False
  TurnOffFluxFlasher(1)
  TurnOffFluxFlasher(2)
  LightOff(lsBet1)
  LightOff(lsBet2)
  LightOff(lsBet3)
  DISPATCH LIGHTS_RESEARCH_OFF, null
  DISPATCH LIGHTS_RESEARCH_READY_OFF, null
  DISPATCH GAME_HIDE_LABELS, null
  DISPATCH LIGHTS_AUGMENTATIONS_OFF, null
  DISPATCH GAME_CHECK_LOCKS, Null
  GameModeSetShot -1, "pal_purple"
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
    'consoleKicker.Kick 0, 30, 1.36
    vukCenterRamp.Kick 0, 120, .5
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
  DISPATCH GAME_CHECK_BET, Null
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
      GameModeSetShot gameState("game")("augmentationActive"), "pal_purple"
    Case 1:
      Dim s1: s1 = RndNum(0,8)
      Do While s1=gameState("game")("augmentationActive")
        s1=RndNum(0,8)
      Loop
      'Random Two Shots
      GameModeSetShot s1, "pal_purple"

      Dim s2: s2 = RndNum(0,8)
      Do While s2=gameState("game")("augmentationActive") Or s2=s1
        s2=RndNum(0,8)
      Loop
      'Random Two Shots
      GameModeSetShot s2, "pal_purple"
    Case 2:
      GameModeSetShot gameState("game")("augmentationActive"), "pal_purple"
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
  DISPATCH GAME_CHECK_BET, Null
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  
  DISPATCH GAME_MODE_NORMAL, Null
  
  If gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 2 Then
    'TODO DISPATCH OVERDRIVE MULTIBALL
    gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 1
  End If

  SwitchSetAugmentation True, "pal_orange"
End Sub

Sub GameModeSetShot(s, palette)
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
      lSeqHyperJumpActiveShot.Image = palette
      lSeqHyperJump.AddItem(lSeqHyperJumpActiveShot)
      AddGameTargetShot GAME_SHOT_HYPER_JUMP
    Case 1:
      lSeqLeftOrbitActiveShot.Image = palette
      lSeqLeftOrbit.AddItem(lSeqLeftOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_ORBIT
    Case 2:
      lSeqLeftRampActiveShot.Image = palette
      lSeqLeftRamp.AddItem(lSeqLeftRampActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_RAMP
    Case 3:
      lSeqSpinnerActiveShot.Image = palette
      lSeqSpinner.AddItem(lSeqSpinnerActiveShot)
      AddGameTargetShot GAME_SHOT_SPINNER
    Case 4:
      lSeqBumpersActiveShot.Image = palette
      lSeqBumpers.AddItem(lSeqBumpersActiveShot)
      AddGameTargetShot GAME_SHOT_BUMPERS
    Case 5:
      lSeqCenterRampActiveShot.Image = palette
      lSeqCenterRamp.AddItem(lSeqCenterRampActiveShot)
      AddGameTargetShot GAME_SHOT_CENTER_RAMP
    Case 6:
      lSeqRightRampActiveShot.Image = palette
      lSeqRightRamp.AddItem(lSeqRightRampActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_RAMP
    Case 7:
      lSeqRightOrbitActiveShot.Image = palette
      lSeqRightOrbit.AddItem(lSeqRightOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_ORBIT
    Case 8:
      lSeqShortcutActiveShot.Image = palette
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
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
  PlayGameCallout("skillshot")
  DOF 251, DOFOn
  SwitchSetAugmentation False, "pal_orange"
  lSeqLightsOverride.AddItem(lSeqSkillshot)
	DISPATCH LIGHTS_START_SEQUENCE, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
  DISPATCH GAME_CHECK_BET, Null
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

  gameState("game")("ballSave") = False

End Sub

Sub GameEnableBallSave()

  EnableBallSaver(15)
  gameState("game")("ballSave") = True
  p_watchdisplay_left.blenddisablelighting = 5
  p_watchdisplay_right.blenddisablelighting = 5

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

Sub GameCheckBet()

  LightOff(lsBet1)  
  LightOff(lsBet2)
  LightOff(lsBet3)

  If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Or gameState("game")("modes")(GAME_MODE_NORMAL) = False Then
    Exit Sub
  End If

  If gameState("switches")("betB") = 1 Then
    LightOn(lsBet1)
    LightBlink(lsBet2)
    LightBlink(lsBet3)
  End If
  If gameState("switches")("betE") = 1 Then
    LightOn(lsBet1)
    LightOn(lsBet2)
    LightBlink(lsBet3)
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
      'TODO Check combo isn't already in gamestate
      If Not gameState("game")("combosMade").Exists(gameState("game")("currentCombo")) Then 
        gameState("game")("combosMade").Add gameState("game")("currentCombo"), GameCombos(gameState("game")("currentCombo"))
      End If
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

Sub GameStartModeHurryUp
 
  gameState("game")("modes")(GAME_MODE_HURRYUP) = True
  gameState("switches")("betB") = 0
  gameState("switches")("betE") = 0
  gameState("switches")("betT") = 0
  DISPATCH GAME_CHECK_BET, Null
  'pupevent music
  LightOff(lsSpeeder)
  lsSpeeder.Image="pal_yellow"
  LightOn(lsSpeeder)
  StopBGAudio()
  pupevent 510 ' hurryup
  DISPATCH LIGHTS_GI_HURRYUP, null
  vpmTimer.AddTimer 30000, "vpmTimerEndHurryUp '"
  p_watchdisplay_left.blenddisablelighting = 5
  p_watchdisplay_right.blenddisablelighting = 5
  EnableWatchTimer(30)
  'Add two random shots to make
  Dim s1: s1 = RndNum(0,8)
  'Random Two Shots
  GameModeSetShot s1, "pal_yellow"
  Dim s2: s2 = RndNum(0,8)
  'Random Two Shots
  GameModeSetShot s2, "pal_yellow"

End Sub

Sub vpmTimerEndHurryUp

  If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
    gameState("game")("modes")(GAME_MODE_HURRYUP) = False
    'pupevent music
    StopBGAudio()
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
    LightOff(lsSpeeder)
    lsSpeeder.Image="pal_blue"
    LightOn(lsSpeeder)
    StopWatchDisplay()
    PlayBGAudioNext()
    DISPATCH GAME_MODE_NORMAL, Null
  End If
End Sub

Sub GameAwardHurryup
  vpmTimerEndHurryUp()
  FlashDomes 6, 2
  GameAddScore GAME_POINTS_HURRYUP
End Sub

'Sub vpmTimerDOFOff(DOFCode)
'  Execute "DOF "&code&", DOFOff"
'End Sub

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Game State                                           	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitGameLogicState()
    Dim gameLogic: Set gameLogic=CreateObject("Scripting.Dictionary")
    gameLogic.Add "playerName", ""
    gameLogic.Add "playerBall", 0
    gameLogic.Add "augmentationReady", False
    gameLogic.Add "raceReady", False
    gameLogic.Add "augmentationActive", 0
    gameLogic.Add "augmentationHold", 1
    gameLogic.Add "augmentationHoldCountdown", 0
    gameLogic.Add "currentSound", ""
    gameLogic.Add "hideScore", False
    gameLogic.Add "pauseLights", False
    gameLogic.Add "ballSave", False
    gameLogic.Add "multiballPlayed", False
    gameLogic.Add "multiballJackpots", 0
    Dim targetShots: Set targetShots=CreateObject("Scripting.Dictionary")
    gameLogic.Add "targetShots", targetShots
    gameLogic.Add "perkShot", ""
    gameLogic.Add "perkShotActive", false
    gameLogic.Add "augmentationResearch0Stage", 0
    gameLogic.Add "augmentationResearch1Stage", 0
    gameLogic.Add "augmentationResearch2Stage", 0
    gameLogic.Add "augmentationResearch3Stage", 0
    gameLogic.Add "augmentationResearch4Stage", 0
    gameLogic.Add "augmentationResearch5Stage", 0
    gameLogic.Add "augmentationResearch6Stage", 0
    gameLogic.Add "augmentationResearch7Stage", 0
    gameLogic.Add "augmentationResearch8Stage", 0
    gameLogic.Add "augTigerLvl", 0
    gameLogic.Add "augBatLvl", 0
    gameLogic.Add "augBullLvl", 0
    gameLogic.Add "augLionLvl", 0
    gameLogic.Add "augHawkLvl", 0
    gameLogic.Add "augDeerLvl", 0
    gameLogic.Add "augPantherLvl", 0
    gameLogic.Add "augOwlLvl", 0
    gameLogic.Add "augRhinoLvl", 0
    gameLogic.Add "ballsLocked", 0
    gameLogic.Add "outlaneDrain", False
    gameLogic.Add "ballsInPlay", 0
    gameLogic.Add "combo", 0
    gameLogic.Add "comboTime", 0
    gameLogic.Add "currentCombo", ""
    Dim combosMade: Set combosMade = CreateObject("Scripting.Dictionary")
    gameLogic.Add "combosMade", combosMade
    Dim gameModes: Set gameModes=CreateObject("Scripting.Dictionary")
    gameLogic.Add "betHits", 2
    gameLogic.Add "betTimesRan", 0
    gameModes.Add GAME_MODE_NORMAL, False
    gameModes.Add GAME_MODE_CHOOSE_SKILLSHOT, False
    gameModes.Add GAME_MODE_SKILLSHOT_ACTIVE, False
    gameModes.Add GAME_MODE_AUGMENTATION_RESEARCH, False
    gameModes.Add GAME_MODE_MULTIBALL, False
    gameModes.Add GAME_MODE_HURRYUP, False
    gameLogic.Add "modes", gameModes
    Set InitGameLogicState = gameLogic
End Function

Dim AugmentationNames: AugmentationNames = Array("Tiger", "Bat", "Bull","Lion","Hawk","Deer","Panther","Owl","Rhino")
Dim AugmentationLvlNames: AugmentationLvlNames = Array("augTigerLvl", "augBatLvl", "augBullLvl","augLionLvl","augHawkLvl","augDeerLvl","augPantherLvl","augOwlLvl","augRhinoLvl")
Dim AugmentationPerksLvl1: AugmentationPerksLvl1 = Array("2x Hyper Jump", "2x Left Orbit", "2x Left Ramp","2x Spinner","2x Bumpers","2x Center Ramp","2x Right Right","2x Right Orbit","2x Shortcut")
Dim AugmentationPerksLvl2: AugmentationPerksLvl2 = Array("Advance Playfield Multiplier", "1 Million Orbits", "2x Left Ramp","Super Spinner","Increase Bet Limit","Advance Extra Ball","Increase Ball Save","Light Mystery","Activate Lane Save")
Dim AugmentationPerksLvl3: AugmentationPerksLvl3 = Array("Hyper Jump Overdrive", "Left Orbit Overdrive", "Left Ramp Overdrive","Spinner Overdrive","Bumpers Overdrive","Center Ramp Overdrive","Right Right Overdrive","Right Orbit Overdrive","Shortcut Overdrive")
Dim PaletteToLampLookup: Set PaletteToLampLookup = CreateObject("Scripting.Dictionary")
PaletteToLampLookup.Add "pal_purple", gameColors(0)
PaletteToLampLookup.Add "pal_orange", gameColors(2)
PaletteToLampLookup.Add "pal_red", gameColors(4)
PaletteToLampLookup.Add "pal_yellow", gameColors(5)
Dim AugmentationSounds : AugmentationSounds = Array(Array("2x_hyperjump", "2x_hyperjump", "2x_hyperjump"), Array("2x_leftorbit", "1million_orbits", "2x_leftorbit"), Array("2x_left_ramp","2x_left_ramp", "2x_left_ramp"), Array("2x_spinners","2x_spinners", "2x_spinners"), Array("2x_bumpers","2x_bumpers", "2x_bumpers"), Array("2x_centerramp", "2x_centerramp", "2x_centerramp"), Array("2x_rightramp", "2x_rightramp", "2x_rightramp"), Array("2x_rightorbit", "2x_rightorbit", "2x_rightorbit"), Array("2x_shortcut", "2x_shortcut","2x_shortcut"))

'Light Collections
Dim lcAugmentations: lcAugmentations = Array(lsAug1,lsAug4,lsAug7,lsAug2,lsAug5,lsAug8,lsAug3,lsAug6,lsAug9)

'Shots
Const GAME_SHOT_HYPER_JUMP = "Game Shot Hyper Jump"
Const GAME_SHOT_LEFT_ORBIT = "Game Shot Left Orbit"
Const GAME_SHOT_LEFT_RAMP = "Game Shot Left Ramp"
Const GAME_SHOT_SPINNER = "Game Shot Spinner"
Const GAME_SHOT_CENTER_RAMP = "Game Shot Center Ramp"
Const GAME_SHOT_BUMPERS = "Game Shot Bumpers"
Const GAME_SHOT_RIGHT_RAMP = "Game Shot Right Ramp"
Const GAME_SHOT_RIGHT_RAMP_COLLECT = "Game Shot Right Ramp Collect"
Const GAME_SHOT_RIGHT_ORBIT = "Game Shot Right Oribt"
Const GAME_SHOT_SHORTCUT = "Game Shot Shortcut"

Dim GameShots: GameShots = Array(GAME_SHOT_HYPER_JUMP, GAME_SHOT_LEFT_ORBIT,GAME_SHOT_LEFT_RAMP,GAME_SHOT_SPINNER,GAME_SHOT_BUMPERS,GAME_SHOT_CENTER_RAMP,GAME_SHOT_RIGHT_RAMP,GAME_SHOT_RIGHT_ORBIT,GAME_SHOT_SHORTCUT)
Dim GameCombos: Set GameCombos = CreateObject("Scripting.Dictionary")

GameCombos.Add "116118", "Left Ramp -> Right Ramp"
GameCombos.Add "118116", "Right Ramp -> Left Ramp"

Const GAME_MODE_NORMAL = "Game Mode Normal"
Const GAME_MODE_CHOOSE_SKILLSHOT = "Game Mode Choose Skillshot"
Const GAME_MODE_SKILLSHOT_ACTIVE = "Game Mode Skillshot Active"
Const GAME_MODE_AUGMENTATION_RESEARCH = "Game Mode Augmentation Research"
Const GAME_MODE_MULTIBALL = "Game Mode Multiball"
Const GAME_MODE_HURRYUP = "Game Mode Hurry Up"

Const GAME_BET_MAX_HITS = 20

'Base Points
Const GAME_POINTS_BASE = 10000
Const GAME_POINTS_JACKPOT = 250000
Const GAME_POINTS_BUMPERS = 2000
Const GAME_POINTS_SPINNER = 2000
Const GAME_POINTS_COMBO = 75000
Const GAME_POINTS_RESEARCH_NODE = 10000
Const GAME_POINTS_HURRYUP = 1000000

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lane Lights Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const ROTATE_LANE_LIGHTS_CLOCKWISE = "ROTATE_LANE_LIGHTS_CLOCKWISE"
Const ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE = "ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE"
Const RESET_LANE_LIGHTS = "RESET_LANE_LIGHTS"

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lane Lights Dispatch                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub RotateLaneLightsClockwise()
    Dim temp : temp = gameState("laneLights")("leftOuter")
    gameState("laneLights")("leftOuter") = gameState("laneLights")("rightOuter")
    gameState("laneLights")("rightOuter") = gameState("laneLights")("rightInner")
    gameState("laneLights")("rightInner") = gameState("laneLights")("leftInner")
    gameState("laneLights")("leftInner") = temp
    CheckLaneLights()
End Sub

Sub RotateLaneLightsAntiClockwise()
    Dim temp : temp = gameState("laneLights")("leftOuter")
    gameState("laneLights")("leftOuter") = gameState("laneLights")("leftInner")
    gameState("laneLights")("leftInner") = gameState("laneLights")("rightInner")
    gameState("laneLights")("rightInner") = gameState("laneLights")("rightOuter")
    gameState("laneLights")("rightOuter") = temp
    CheckLaneLights()
End Sub

Sub ResetLaneLights()
    gameState("laneLights")("leftOuter") = 0
    gameState("laneLights")("leftInner") = 0
    gameState("laneLights")("rightInner") = 0
    gameState("laneLights")("rightOuter") = 0
    CheckLaneLights()
End Sub


'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Lane Lights State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitLaneLightsState()
    
    Dim laneLights: Set laneLights=CreateObject("Scripting.Dictionary")
    
    laneLights.Add "leftOuter", 0
    laneLights.Add "leftInner", 0
    laneLights.Add "rightOuter", 0
    laneLights.Add "rightInner", 0

    Set InitLaneLightsState = laneLights
End Function
'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lights Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const LIGHTS_UPDATE = "Lights Update"
Const LIGHTS_GI_ON = "Lights GI ON"
Const LIGHTS_GI_OFF = "Lights GI OFF"
Const LIGHTS_GI_NORMAL = "Lights GI Normal"
Const LIGHTS_GI_DOMES = "Lights GI Domes"
Const LIGHTS_GI_AUGMENTATION_RESEARCH = "Lights GI Augmentation Research"
Const LIGHTS_GI_HURRYUP = "Lights GI Hurry Up"
Const LIGHTS_GI_MULTIBALL = "Lights GI Multiball"
Const LIGHTS_GI_SOVIET = "Lights GI Soviet"
Const LIGHTS_GI_ALLIED = "Lights GI Allied"
Const LIGHTS_RESEARCH_OFF = "Lights Research Off"
Const LIGHTS_RESEARCH_RESET = "Lights Research Reset"
Const LIGHTS_RESEARCH_READY_OFF = "Lights Research Ready Off"
Const LIGHTS_AUGMENTATIONS_OFF = "Lights Augmentations Off"
Const LIGHTS_START_SEQUENCE = "Lights Start Sequence"
Const LIGHTS_PAUSE = "Lights Pause"

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lights Dispatch                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub LightsStartSequence()

    LightsPause()

End Sub

Sub LightsPause()

    Lampz.TurnOffStates()
    FlasherFluxTimer1.Enabled = False
    objFluxBase(1).BlendDisableLighting = FluxFlasherOffBrightness
    FlasherFluxTimer2.Enabled = False
    objFluxBase(2).BlendDisableLighting = FluxFlasherOffBrightness

End Sub

Sub RunLightSeq(lightSeq, k)

    Dim light: Set light = lightSeq.CurrentItem
    'DebugOut(k)
    'DebugOut(light.CurrentIdx)
    'DebugOut(UBound(light.Sequence))
    If UBound(light.Sequence)<light.CurrentIdx Then
        light.CurrentIdx = 0
        lightSeq.NextItem()
    Else
        Dim framesRemaining, seq
        seq = light.Sequence
        If IsArray(seq(light.CurrentIdx)) Then
            Dim ls, x
            
            'DebugOut(light.CurrentIdx)
            For x = 0 To UBound(seq(light.CurrentIdx))
                'DebugOut("X:" & Cstr(x))    
                Set ls = seq(light.CurrentIdx)(x)
                If Not IsNull(light.Image) Then
                    ls.Image = light.Image
                    'ls.LampColor = PaletteToLampLookup(light.Image)
                End If
                If Not IsNull(light.LampColor) Then
                    ls.LampColor = light.LampColor
                End If
                gameState("lights")("changedLamps").Add k+cStr(ls.Idx), ls
                'framesRemaining = ls.Update(FrameTime)
                'If framesRemaining < 0 Then
                '    ls.ResetFrames()
                '    If x = UBound(seq(light.CurrentIdx)) Then
                '        light.CurrentIdx = light.CurrentIdx + 1
                '    End If
                'End If            
            Next
        Else
            If Not IsNull(light.Image) Then
                seq(light.CurrentIdx).Image = light.Image
            End If
            If Not IsNull(light.LampColor) Then
                seq(light.CurrentIdx).LampColor = light.LampColor
            End If
            gameState("lights")("changedLamps").Add k+cStr(seq(light.CurrentIdx).Idx), seq(light.CurrentIdx)
            'framesRemaining = seq(light.CurrentIdx).Update(FrameTime)
            'If framesRemaining < 0 Then
            '    seq(light.CurrentIdx).ResetFrames()
            '    light.CurrentIdx = light.CurrentIdx + 1
            'End If
        End If

        framesRemaining = light.Update(FrameTime)
        If framesRemaining < 0 Then
            light.ResetFrames()
            light.CurrentIdx = light.CurrentIdx + 1
        End If
        
    End If



End Sub



Sub LightsUpdate()
    
    If gameState("game")("pauseLights") = True Then
        Exit Sub
    End If

    If Not IsNull(lSeqLightsOverride.CurrentItem) Then
        RunLightSeq lSeqLightsOverride, "lightsOverride"
    Else

        If HasKeys(gameState("lights")("lightSeqs")) Then
            Dim k
            For Each k in gameState("lights")("lightSeqs").Keys()
                Dim lightSeq: Set lightSeq = gameState("lights")("lightSeqs")(k)
                If Not IsNull(lightSeq.CurrentItem) Then
                    RunLightSeq lightSeq, k
                End If
            Next
        End If

        If HasKeys(gameState("lights")("lightBlinks")) Then
            Dim blinkKey
            For Each blinkKey in gameState("lights")("lightBlinks").Keys()

                Dim blinkLight: Set blinkLight = gameState("lights")("lightBlinks")(blinkKey)
                gameState("lights")("changedLamps").Add blinkKey, blinkLight
                Dim blinkFramesRemaining
                blinkFramesRemaining = blinkLight.Update(FrameTime)
                If blinkFramesRemaining < 0 Then
                    blinkLight.Blink()
                End If
            
            Next

        End If

        If HasKeys(gameState("lights")("lightOn")) Then
            Dim lightKey
            For Each lightKey in gameState("lights")("lightOn").Keys()
                Dim light: Set light = gameState("lights")("lightOn")(lightKey)
                light.State = 1
                gameState("lights")("changedLamps").Add lightKey, light
            Next
        End If

        If HasKeys(gameState("lights")("lightFlash")) Then
            Dim flashKey
            For Each flashKey in gameState("lights")("lightFlash").Keys()

                Dim flashLight: Set flashLight = gameState("lights")("lightFlash")(flashKey)
                
                If flashLight.Enabled = False Then
                    flashLight.Enabled = True
                    FluxObjlevel(flashKey) = 0.1
                End If

            Next

        End If

    End If

    If HasKeys(gameState("lights")("changedLamps")) Then
        Dim changedLamp
        For Each changedLamp in gameState("lights")("changedLamps").Keys()
            Lampz.state(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).State
            'MsgBox(gameState("lights")("changedLamps")(changedLamp).lampColor)
            If Not IsNull(gameState("lights")("changedLamps")(changedLamp).lampColor) Then   
                Lampz.lampColor(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).lampColor
            End If
            If Not IsNull(gameState("lights")("changedLamps")(changedLamp).Image) Then   
                Lampz.image(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).Image
            End If
        Next
    End If
	gameState("lights")("changedLamps").RemoveAll
    
End Sub

Sub LightsStartFlicker()
    
    'Dim fOn1: Set fOn1 = New LightChangeItem
    'fOn1.Init 0,1,62,"pal_purple"
    'Dim fOff1: Set fOff1 = new LightChangeItem
    'fOff1.Init 0,0,62,"pal_purple"

    'Dim fOn2: Set fOn2 = New LightChangeItem
    'fOn2.Init 0,1,62,"pal_purple"
    'Dim fOff2: Set fOff2 = new LightChangeItem
    'fOff2.Init 0,0,62,"pal_purple"

    'Dim fOn3: Set fOn3 = New LightChangeItem
    'fOn3.Init 0,1,62,"pal_purple"
    'Dim fOff3: Set fOff3 = new LightChangeItem
    'fOff3.Init 0,0,62,"pal_purple"

    'Dim fOn4: Set fOn4 = New LightChangeItem
    'fOn4.Init 0,1,62,"pal_purple"
    'Dim fOff4: Set fOff4 = new LightChangeItem
    'fOff4.Init 0,0,62,"pal_purple"

    'Dim flicker: Set flicker=CreateObject("Scripting.Dictionary")
    'flicker.Add "currentIdx", 0
    'flicker.Add "sequence", Array(fOn1, fOff1, fOn2, fOff2, fOn3, fOff3, fOn4, fOff4)
    'If Not gameState("lights")("lightSeqs").Exists("flicker") Then
    '    gameState("lights")("lightSeqs").Add "flicker", flicker
    'End If
    
End Sub

Sub LightsAugmentationAttract()

    'Dim x
    'for each x in insertsAugmentations
    '    Dim l: Set l = New LightChangeItem
    '    l.Init x.Uservalue,1,0,"pal_purple"
    '    If gameState("lights")("changedLamps").Exists(x.Name) Then
    '        gameState("lights")("changedLamps").Remove x.Name
    '    End If
        'MsgBox(x.IntensityScale)
    '    gameState("lights")("changedLamps").Add x.Name, l
    'next
    
    'LightSeqInsertsAugmentations.StopPlay
    'LightSeqInsertsAugmentations.Play SeqAllOn
    'LightSeqInsertsAugmentations.UpdateInterval = 12
    'LightSeqInsertsAugmentations.Play SeqFanLeftUpOn, 24, 10
    'LightSeqInsertsAugmentations.UpdateInterval = 15
    'LightSeqInsertsAugmentations.Play SeqUpOn, 12, 2
    'LightSeqInsertsAugmentations.UpdateInterval = 15
    'LightSeqInsertsAugmentations.Play SeqRadarRightOn, 12, 2
    

    'LightSeqInsertsCyber.StopPlay
    'LightSeqInsertsCyber.UpdateInterval = 10
    'LightSeqInsertsCyber.Play SeqLeftOn, 16, 10
    'LightSeqInsertsCyber.UpdateInterval = 20
    'LightSeqInsertsCyber.Play SeqRightOn, 8, 10
    'LightSeqInsertsCyber.UpdateInterval = 20
    'LightSeqInsertsCyber.Play SeqUpOn, 8, 10
    'LightSeqInsertsCyber.Play SeqDownOn, 8, 10


    LightSeqAttract.StopPlay
    LightSeqAttract.UpdateInterval = 10
    LightSeqAttract.Play SeqLeftOn, 16, 2
    LightSeqAttract.UpdateInterval = 20
    LightSeqAttract.Play SeqRightOn, 8, 1
    LightSeqAttract.UpdateInterval = 20
    LightSeqAttract.Play SeqUpOn, 8, 1
    LightSeqAttract.Play SeqDownOn, 8, 1
    
    
    'Dim aug1On: Set aug1On = New LightChangeItem
    'aug1On.Init 0,1,180,"pal_purple"
    'Dim aug1Off: Set aug1Off = new LightChangeItem
    'aug1Off.Init 0,0,180,"pal_purple"

    'Dim aug2On: Set aug2On = New LightChangeItem
    'aug2On.Init 3,1,180,"pal_purple"
    'Dim aug2Off: Set aug2Off = new LightChangeItem
    'aug2Off.Init 3,0,180,"pal_purple"

    'Dim aug3On: Set aug3On = New LightChangeItem
    'aug3On.Init 6,1,180,"pal_purple"
    'Dim aug3Off: Set aug3Off = new LightChangeItem
    'aug3Off.Init 6,0,180,"pal_purple"

    'Dim flicker: Set flicker=CreateObject("Scripting.Dictionary")
    'flicker.Add "currentIdx", 0
    'flicker.Add "repeat", 1
    'flicker.Add "sequence", Array(aug1On, aug1Off, aug2On, aug2Off, aug3On, aug3Off)
    'If Not gameState("lights")("lightSeqs").Exists("augAttract") Then
    '    gameState("lights")("lightSeqs").Add "augAttract", flicker
    'End If
    
End Sub

Sub LightSeqInsertsAugmentations_PlayDone()
    PlaySound "fx-spinner2"
    'LightSeqInsertsAugmentations.Play SeqAllOff
    'LightSeqInsertsAugmentations.StopPlay
    'DISPATCH LIGHTS_RESET_COMMANDERS, null
End Sub

Sub LightsGIOn()
    gameState("lights")("gi") = 1
    
    'LightsAugmentationAttract()
    'TurnOffFluxFlasher(3)
    'FluxObjlevel(3) = 2
    LightOn(lsSpeeder)

    playfield_lm.visible = True
    'p_artblades_back.Image = "artbladesbackgion"
    p_plastics.Image = "plastics-new"
    ModLampz.SetGI 0, 9
    SetGI 0,9
    SetGIPerk 0,0
    'Dispatch LIGHTS_GI_NORMAL, Null
    for each GIxx in GI
        GIxx.Color = gameState("lights")("GIColor")
        GIxx.ColorFull = gameState("lights")("GIColor")
        GIxx.Intensity = 2
    next
End Sub

Sub LightsGIOff()
    gameState("lights")("gi") = 0
    playfield_lm.visible = False
    'p_artblades_back.Image = "artbladesbackgioff"
    p_plastics.Image = "plastics-off"
    ModLampz.SetGI 0, 0
    LightOff(lsSpeeder)
End Sub

Sub LightsGINormal()
    for each GIxx in GI
        GIxx.Color = c_normal
        GIxx.ColorFull = c_normal_full
        GIxx.Intensity = 2
    next
    p_plastics.Image = "plastics-new"
    gameState("lights")("GIColor") = c_normal
End Sub

Sub LightsGIDomes(color)
    for each GIxx in GISLings
        GIxx.Color = gameColors(color)
        GIxx.ColorFull = gameColors(color)
        GIxx.Intensity = 2
    next
    'p_plastics.Image = gamePlastics(color)
    SetGIPerk 0,9
End Sub

Sub LightsGiAugmentationResearch()
    for each GIxx in GI
        GIxx.Color = c_augmentationResearch
        GIxx.ColorFull = c_augmentationResearch
        GIxx.Intensity = 3
    next
    'p_plastics.Image = "plastics-blue"
    gameState("lights")("GIColor") = c_augmentationResearch
End Sub

Sub LightsGiHurryUp()
    for each GIxx in GI
        GIxx.Color = gameColors(6)
        GIxx.ColorFull = gameColors(6)
        GIxx.Intensity = 3
    next
    p_plastics.Image = "plastics-yellow"
    gameState("lights")("GIColor") = gameColors(6)
End Sub

Sub LightsGiMultiball()
    for each GIxx in GI
        GIxx.Color = c_multiball
        GIxx.ColorFull = c_multiball
    next
    'p_plastics.Image = "plastics-green"
    gameState("lights")("GIColor") = c_multiball
End Sub

Sub LightsResearchReset()
    LightBlink(lsResearch1)
    LightBlink(lsResearch2)
    LightBlink(lsResearch3)
    If gameState("lights")("activeResearch").Exists("aug1") Then
        gameState("lights")("activeResearch").Remove "aug1"
    End If
    If gameState("lights")("activeResearch").Exists("aug2") Then
        gameState("lights")("activeResearch").Remove "aug2"
    End If
    If gameState("lights")("activeResearch").Exists("aug3") Then
        gameState("lights")("activeResearch").Remove "aug3"
    End If
End Sub

Sub LightsResearchOff()
    StopLightBlink(lsResearch1)
    StopLightBlink(lsResearch2)
    StopLightBlink(lsResearch3)
    If gameState("lights")("activeResearch").Exists("aug1") Then
        gameState("lights")("activeResearch").Remove "aug1"
    End If
    If gameState("lights")("activeResearch").Exists("aug2") Then
        gameState("lights")("activeResearch").Remove "aug2"
    End If
    If gameState("lights")("activeResearch").Exists("aug3") Then
        gameState("lights")("activeResearch").Remove "aug3"
    End If
End Sub

Sub LightsResearchReadyOff()
    StopLightBlink(lSeqResearchLit)
    Lampz.state(25) = 0
End Sub

Sub LightsAugmentationsOff()
    Lampz.State(0) = 0
    Lampz.State(1) = 0
    Lampz.State(2) = 0
    Lampz.State(3) = 0
    Lampz.State(4) = 0
    Lampz.State(5) = 0
    Lampz.State(6) = 0
    Lampz.State(7) = 0
    Lampz.State(8) = 0
End Sub

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Lane Lights State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitLightsState()
    
    Dim lights: Set lights=CreateObject("Scripting.Dictionary")

    lights.Add "lightSeqs", InitLightSeqs()
    lights.Add "lightBlinks", InitLightBlinks()
    lights.Add "lightOn", InitLightOn()
    lights.Add "lightFlash", InitLightFlash()

    lights.Add "GIColor", c_normal
    lights.Add "activeResearch", CreateObject("Scripting.Dictionary")

    lights.Add "changedLamps", CreateObject("Scripting.Dictionary")

    lights.Add "gi", 0

    Set InitLightsState = lights
End Function


Function InitLightSeqs()
    Dim lightSeqs: Set lightSeqs=CreateObject("Scripting.Dictionary")
    Set InitLightSeqs = lightSeqs
End Function

Function InitLightBlinks()
    Dim lightBlinks: Set lightBlinks=CreateObject("Scripting.Dictionary")
    Set InitLightBlinks = lightBlinks
End Function

Function InitLightOn()
    Dim lightOn: Set lightOn=CreateObject("Scripting.Dictionary")
    Set InitLightOn = lightOn
End Function

Function InitLightFlash()
    Dim lightFlash: Set lightFlash=CreateObject("Scripting.Dictionary")
    Set InitLightFlash = lightFlash
End Function

'***********************************************************************************************************************


Sub SwitchHitBumper()
    
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BUMPERS
        If gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 4 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_BUMPERS) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_BUMPERS) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
End Sub
Sub SwitchHitCenterRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_CENTER_RAMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 5 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If
    

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_CENTER_RAMP) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_CENTER_RAMP) Then
            RemoveGameTargetShot(GAME_SHOT_CENTER_RAMP)
            LightOn(lsCyber3)
            lSeqMultiballB.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_CENTER_RAMP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
        DISPATCH GAME_COMBO, lsCombo3
    End If
End Sub

Sub SwitchHitHyperJump()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_HYPER_JUMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 0 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_HYPER_JUMP) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_HYPER_JUMP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
    
End Sub
Sub SwitchHitPreLeftOrbit()
    If gameState("switches")("leftOrbit") = 1 Then
        gameState("switches")("preLeftOrbit") = 0
        gameState("switches")("leftOrbit") = 0
    Else
        gameState("switches")("preLeftOrbit") = 1
    End If
End Sub

Sub SwitchHitLeftOrbit()
    If gameState("switches")("preLeftOrbit") = 1 Then

        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            PlaySound "left_orbit"    
            'LightSeqGIUpperLeft.StopPlay   
            'LightSeqGIUpperLeft.UpdateInterval = 2
            'LightSeqGIUpperLeft.Play SeqArcTopLeftUpOn, 2, 0
            'LightSeqGIUpperLeft.Play SeqArcTopLeftUpOff, 2, 0
            GameAddScore GAME_POINTS_BASE
            If gameState("game")("perkShot") = GAME_SHOT_LEFT_ORBIT Then
                DISPATCH GAME_AWARD_PERKSHOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
            If gameState("game")("augmentationActive") = 1 Then
                DISPATCH GAME_AWARD_SKILLSHOT, Null
            End If
        End If
    
        If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_LEFT_ORBIT) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_LEFT_ORBIT) Then
                RemoveGameTargetShot(GAME_SHOT_LEFT_ORBIT)
                LightOn(lsCyber1)
                lSeqMultiballC.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_LEFT_ORBIT) Then
                DISPATCH GAME_AWARD_HURRYUP, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
            DISPATCH GAME_COMBO, lsCombo1
        End If
    Else
        gameState("switches")("leftOrbit") = 1
    End If
    gameState("switches")("preLeftOrbit") = 0
    gameState("switches")("preRightOrbit") = 0
End Sub
Sub SwitchHitLeftRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_LEFT_RAMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 2 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_LEFT_RAMP) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_LEFT_RAMP) Then
            RemoveGameTargetShot(GAME_SHOT_LEFT_RAMP)
            LightOn(lsCyber2)
            lSeqMultiballY.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_LEFT_RAMP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
        DISPATCH GAME_COMBO, lsCombo2
    End If
End Sub
Sub SwitchHitPreRightOrbit()
    If gameState("switches")("rightOrbit") = 1 Then
        gameState("switches")("preRightOrbit") = 0
        gameState("switches")("rightOrbit") = 0
    Else
        gameState("switches")("preRightOrbit") = 1
    End If
End Sub

Sub SwitchHitRightOrbit()
    If gameState("switches")("preRightOrbit") = 1 Then
        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            PlaySound "left_orbit"
            'LightSeqGIUpperLeft.StopPlay
            'LightSeqGIUpperLeft.UpdateInterval = 2
            'LightSeqGIUpperLeft.Play SeqArcTopRightUpOn, 2, 0
            'LightSeqGIUpperLeft.Play SeqArcTopRightUpOff, 2, 0
            GameAddScore GAME_POINTS_BASE
            If gameState("game")("perkShot") = GAME_SHOT_RIGHT_ORBIT Then
                DISPATCH GAME_AWARD_PERKSHOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
            If gameState("game")("augmentationActive") = 7 Then
                DISPATCH GAME_AWARD_SKILLSHOT, Null
            End If
        End If
    
        If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_ORBIT) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_ORBIT) Then
                RemoveGameTargetShot(GAME_SHOT_RIGHT_ORBIT)
                LightOn(lsCyber5)
                lSeqMultiballR.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_ORBIT) Then
                DISPATCH GAME_AWARD_HURRYUP, null
            End If
        End If

        
        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
            DISPATCH GAME_COMBO, lsCombo5
        End If
    Else
        gameState("switches")("rightOrbit") = 1
    End If
    gameState("switches")("preRightOrbit") = 0
    gameState("switches")("preLeftOrbit") = 0
End Sub
Sub SwitchHitRightRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_RIGHT_RAMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 6 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP_COLLECT) Then
            DISPATCH GAME_MODE_FINISH_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP) Then
            RemoveGameTargetShot(GAME_SHOT_RIGHT_RAMP)
            LightOn(lsCyber4)
            lSeqMultiballE.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
        DISPATCH GAME_COMBO, lsCombo4
    End If
End Sub

Sub SwitchHitShortcut()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_SHORTCUT Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 8 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_SHORTCUT) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_SHORTCUT) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    gameState("switches")("shortcut") = 1
End Sub
Sub SwitchHitSpinner2()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        PlaySoundAt "fx-spinner2", Spinner2
        GameAddScore GAME_POINTS_SPINNER
        If gameState("game")("perkShot") = GAME_SHOT_SPINNER Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 3 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        PlaySoundAt "fx-spinner2", Spinner2
        If gameState("game")("targetShots").Exists(GAME_SHOT_SPINNER) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_SPINNER) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
End Sub

'***********************************************************************************************************************
'*****  Switches Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const SWITCH_HIT_AUGMENTATION = "Switches Hit Augmentation"
Const SWITCH_HIT_CAPTIVE = "Switches Hit Captive"
Const SWITCH_HIT_RESEARCH_1 = "Switches Hit Research 1"
Const SWITCH_HIT_RESEARCH_2 = "Switches Hit Research 2"
Const SWITCH_HIT_RESEARCH_3 = "Switches Hit Research 3"
Const SWITCH_LEFT_FLIPPER_DOWN = "Switches Left Flipper Down"
Const SWITCH_RIGHT_FLIPPER_DOWN = "Switches Right Flipper Down"
Const SWITCH_HIT_PRE_LEFT_ORBIT = "Switches Hit Pre Left Orbit"
Const SWITCH_HIT_LEFT_ORBIT = "Switches Hit Left Orbit"
Const SWITCH_HIT_PRE_RIGHT_ORBIT = "Switches Hit Pre Right Orbit"
Const SWITCH_HIT_RIGHT_ORBIT = "Switches Hit Right Orbit"
Const SWITCH_HIT_CONSOLE = "Switches Hit Console"
Const SWITCH_HIT_SPINNER2 = "Switches Hit Spinner 2"
Const SWITCH_HIT_HYPERJUMP = "Switches Hit Hyper Jump"
Const SWITCH_HIT_BUMPER = "Switches Hit Bumper"
Const SWITCH_HIT_LEFT_RAMP = "Switches Hit Left Ramp"
Const SWITCH_HIT_RIGHT_RAMP = "Switches Hit Right Ramp"
Const SWITCH_HIT_CENTER_RAMP = "Switches Hit Center Ramp"
Const SWITCH_HIT_SHORTCUT = "Switches Hit Shortcut"
Const SWITCH_HIT_RAMP_PIN = "Switches Hit Ramp Pin"
Const SWITCH_HIT_PLUNGER_LANE = "Switches Hit Plunger Lane"
Const SWITCH_HIT_LIGHT_LOCK = "Switches Hit Light Lock"
Const SWITCH_HIT_LEFT_OUTLANE = "Switches Hit Left Outlane"
Const SWITCH_HIT_LEFT_INLANE = "Switches Hit Left Inlane"
Const SWITCH_HIT_RIGHT_INLANE = "Switches Hit Right Inlane"
Const SWITCH_HIT_RIGHT_OUTLANE = "Switches Hit Right Outlane"
Const SWITCH_HIT_BALL_LOCK = "Switches Hit Ball Lock"
Const SWITCH_HIT_SECRET_UPGRADE = "Switches Hit Secret Upgrade"
Const SWITCH_HIT_BET = "Switches Hit Bet"


'***********************************************************************************************************************

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
        gameState("switches")("lastFlipperDown") = GameTime
        DISPATCH GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE, Null
    End If

    Dispatch ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE, Null
End Sub

Sub SwitchRightFlipperDown()

    If gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True Then
        'Rotate Skillshot
        gameState("switches")("lastFlipperDown") = GameTime
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
    'consoleKicker.Kick 0, 30, 1.36
    vukCenterRamp.Kick 0, 120, .5
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
        vpmTimer.addtimer 10000, "vpmTimerEndSkillshot '"
    End If
End Sub

Sub vpmTimerEndSkillshot()
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            SwitchSetAugmentation False, "pal_orange"
            DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
            DISPATCH GAME_CHECK_BET, Null
        End If
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
        gameState("game")("modes")(GAME_MODE_HURRYUP) = False
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

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Or gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Or gameState("game")("modes")(GAME_MODE_NORMAL) = False Then
        Exit Sub
    End If

    gameState("game")("betHits") = gameState("game")("betHits") - 1
    If gameState("switches")("betB") = 0 Then
        gameState("switches")("betB") = 1
        gameState("switches")("betE") = 0
        gameState("switches")("betT") = 0
        DisplayFlexBetHitScreen("BetFrameB")
    ElseIf gameState("switches")("betE") = 0 Then
        gameState("switches")("betB") = 1
        gameState("switches")("betE") = 1
        gameState("switches")("betT") = 0
        DisplayFlexBetHitScreen("BetFrameE")
    ElseIf gameState("switches")("betT") = 0 Then
        gameState("switches")("betB") = 0
        gameState("switches")("betE") = 0
        gameState("switches")("betT") = 0
        DisplayFlexBetHitScreen("BetFrameT")
    End If

    DISPATCH GAME_CHECK_BET, Null

    vpmTimer.addtimer 3000, "vpmTimerFlexUpdateMain '"

    If gameState("game")("betHits") = 0 Then
        gameState("game")("betTimesRan") = gameState("game")("betTimesRan") + 1
        gameState("game")("betHits") = 3 * (gameState("game")("betTimesRan")+1)
        If gameState("game")("betHits") > GAME_BET_MAX_HITS Then
            gameState("game")("betHits") = GAME_BET_MAX_HITS
        End If
        DISPATCH GAME_START_MODE_HURRYUP, Null
    End If
End Sub


'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Switches State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitSwitchesState()
    Dim switches:Set switches=CreateObject("Scripting.Dictionary")

    switches("preLeftOrbit") = 0
    switches("leftOrbit") = 0
    switches("preRightOrbit") = 0
    switches("rightOrbit") = 0
    switches("augmentation") = 0
    switches("captive") = 0
    switches("shortcut") = 0
    switches("lightlock") = 0
    switches("betB") = 1
    switches("betE") = 0
    switches("betT") = 0
    switches("lastFlipperDown") = 0

    Set InitSwitchesState = switches
End Function

'***********************************************************************************************************************
