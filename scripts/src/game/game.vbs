'***********************************************************************************************************************
'*****  GAME                                                  	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Dim DebugScore
Dim gameState: Set gameState = CreateObject("Scripting.Dictionary")

'----- Phsyics Mods -----
Const RubberizerEnabled = 1			'0 = normal flip rubber, 1 = more lively rubber for flips, 2 = a different rubberizer
Const FlipperCoilRampupMode = 0   	'0 = fast, 1 = medium, 2 = slow (tap passes should work)
Const TargetBouncerEnabled = 1 		'0 = normal standup targets, 1 = bouncy targets, 2 = orig TargetBouncer
Const TargetBouncerFactor = 0.7 	'Level of bounces. Recommmended value of 0.7 when TargetBouncerEnabled=1, and 1.1 when TargetBouncerEnabled=2

Dim FlexDMD
' FlexDMD constants
Const 	FlexDMD_RenderMode_DMD_GRAY = 0, _
		FlexDMD_RenderMode_DMD_GRAY_4 = 1, _
		FlexDMD_RenderMode_DMD_RGB = 2, _
		FlexDMD_RenderMode_SEG_2x16Alpha = 3, _
		FlexDMD_RenderMode_SEG_2x20Alpha = 4, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num = 5, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num_4x1Num = 6, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num = 7, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_10x1Num = 8, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num_gen7 = 9, _
		FlexDMD_RenderMode_SEG_2x7Num10_2x7Num10_4x1Num = 10, _
		FlexDMD_RenderMode_SEG_2x6Num_2x6Num_4x1Num = 11, _
		FlexDMD_RenderMode_SEG_2x6Num10_2x6Num10_4x1Num = 12, _
		FlexDMD_RenderMode_SEG_4x7Num10 = 13, _
		FlexDMD_RenderMode_SEG_6x4Num_4x1Num = 14, _
		FlexDMD_RenderMode_SEG_2x7Num_4x1Num_1x16Alpha = 15, _
		FlexDMD_RenderMode_SEG_1x16Alpha_1x16Num_1x7Num = 16

Const 	FlexDMD_Align_TopLeft = 0, _
		FlexDMD_Align_Top = 1, _
		FlexDMD_Align_TopRight = 2, _
		FlexDMD_Align_Left = 3, _
		FlexDMD_Align_Center = 4, _
		FlexDMD_Align_Right = 5, _
		FlexDMD_Align_BottomLeft = 6, _
		FlexDMD_Align_Bottom = 7, _
		FlexDMD_Align_BottomRight = 8

Sub StartGame()
	
    Dim colors,materials,army,laneLights,lights,gameLogic,switches
    Set gameState = CreateObject("Scripting.Dictionary")
    Set materials = CreateObject("Scripting.Dictionary")

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
	DISPATCH RESET_LANE_LIGHTS, Null
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

    'Diverter.RotZ = DiverterFlipper.CurrentAngle
    'Diverter001.RotZ = DiverterFlipper.CurrentAngle

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

End Sub

Sub FrameTimer_Timer()
	If gameStarted Then
	'BallShadowUpdate
	'RDampen
	'GatesTimer
	'RollingSound
		LampTimer
		FlipperVisualUpdate
		If DynamicBallShadowsOn=1 Then DynamicBSUpdate 'update ball shadows
	'VR_Primary_plunger.Y = -50 + (5* Plunger.Position) -20
	End IF
End Sub

'******************************************************
'						FUNCTIONS
'******************************************************

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
