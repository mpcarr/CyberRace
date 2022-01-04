'***********************************************************************************************************************
'*****  GAME                                                  	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Dim DebugScore

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

	StartLightSeq(lSeqAugmentation)
	StartLightSeq(lSeqCaptive)
	
	StartLightSeq(lSeqLeftDrain)

	DebugScore = "0"


	DISPATCH LIGHTS_RESEARCH_RESET, null
	DISPATCH GAME_START_OF_BALL, null
	gameStarted = True
End Sub

'*********************************************************************
'           Game Timer, Ball Rolling, Ball Shadows, Ball Drop
'*********************************************************************

Const tnob = 10 ' total number of balls
ReDim rolling(tnob)
InitRolling

'Dim BallShadow, BallRefl
'BallShadow = Array (BallShadow1,BallShadow2,BallShadow3,BallShadow4,BallShadow5,BallShadow6,BallShadow7,BallShadow8,BallShadow9,BallShadow10,BallShadow11)
'BallRefl = Array (BallRefl1,BallRefl2,BallRefl3,BallRefl4,BallRefl5,BallRefl6,BallRefl7,BallRefl8,BallRefl9,BallRefl10,BallRefl11)

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

		'***Ball Reflections***
		'dim shift
		'If BallReflections = 1 Then
		'	shift = (BOT(b).X - tablewidth/2)/20 * 1 / Bot(b).Y
		'	BallRefl(b).z = BOT(b).z - 24
		'	BallRefl(b).Size_z = 40 - BOT(b).y/130
		'	BallRefl(b).X = BOT(b).X - shift
		'	BallRefl(b).Y = BOT(b).Y + 5 - abs(shift)	
		'	BallRefl(b).RotY = 180 + (BOT(b).X - tablewidth/2)/15
		'End If

		'***Ball Shadows***	
		'If BallShadowOn = 1 Then
		'	BallShadow(b).X = BOT(b).X
		'	ballShadow(b).Y = BOT(b).Y + 10
		'End If

		'If BOT(b).Z > 24 and BOT(b).Z < 35 and BOT(b).radius > 23  and not inrect(BOT(b).x,BOT(b).y,183,925,227,925,227,969,183,969) Then
		'	BallShadow(b).visible = 1
		'	BallRefl(b).visible = 1
		'Else
		'	BallShadow(b).visible = 0
		'	BallRefl(b).visible = 0
		'End If

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
