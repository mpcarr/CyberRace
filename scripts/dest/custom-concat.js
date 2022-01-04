Option Explicit
Randomize

'Region Player Options


	Class DOFClass

		Private m_b2sOn
		Private m_b2sAlt

		Public Property Let B2SOn(ByVal value)
			m_b2sOn = value
		End Property
		
		Public Property Get B2SOn
			B2SOn = m_b2sOn
		End Property

		Public Property Let B2SAlt(ByVal value)
			m_b2sAlt = value
		End Property
		
		Public Property Get B2SAlt
			B2SAlt = m_b2sAlt
		End Property

		Public Sub DOF(DOFevent, State)
			If m_b2sOn Then
				If State = 2 Then
					Controller.B2SSetData DOFevent, 1:Controller.B2SSetData DOFevent, 0
				Else
					Controller.B2SSetData DOFevent, State
				End If
			End If
		End Sub

		Public Sub DOFALT(DOFevent, State)
			If m_b2sAlt Then
				If State = 2 Then
					B2SController.B2SSetData DOFevent, 1:B2SController.B2SSetData DOFevent, 0
				Else
					B2SController.B2SSetData DOFevent, State
				End If
			End If
		End Sub

	End Class


	Dim myDOF
	Set myDOF = new DOFClass
	turnoffrules = 0 ' change to 1 to take off the backglass helper rules text during a game
	turnonultradmd = 0 ' change to 1 to turn on ultradmd
	toppervideo = 0 'set to 1 to turn on the topper
	ballrolleron = 1 ' set to 0 to turn off the ball roller if you use the "c" key in your cabinet

'End Region Player Options

'Region Framework Options

	Const typefont = "Raleway Medium"
	Const numberfont = "Bebas Neue"
	Const zoomfont = "Fundamental  Brigade"
	Const zoombgfont = "Fundamental 3D  Brigade" ' needs to be an outline of the zoomfont
	Const cGameName = "ra3"
	Const myVersion = "1.0.0"
	
'End Region Framework Options

'Region Table Variables
 	
	'Constructions
	Const BallSize = 50
	Const BallMass = 1.5
	Const MaxPlayers = 4
	Const BallSaverTime = 15 
	Const MaxMultiplier = 6 
	Const MaxMultiballs = 5
	Const bpgcurrent = 3

	' Define Global Variables
	Dim toppervideo
	Dim ballrolleron
	Dim turnonultradmd
	Dim turnoffrules
	Dim PlayersPlayingGame
	Dim CurrentPlayer
	Dim Credits
	Dim BonusPoints(4)
	Dim BonusHeldPoints(4)
	Dim BonusMultiplier(4)
	Dim bBonusHeld
	Dim BallsRemaining(4)
	Dim ExtraBallsAwards(4)
	Dim Score(4)
	Dim HighScore(4)
	Dim HighScoreName(4)
	Dim WaffleScore(4)
	Dim WaffleScoreName(4)
	Dim Jackpot
	Dim SuperJackpot
	Dim Tilt
	Dim TiltSensitivity
	Dim Tilted
	Dim TotalGamesPlayed
	Dim mBalls2Eject
	Dim SkillshotValue(4)
	Dim bAutoPlunger
	Dim bInstantInfo
	Dim bromconfig
	Dim bAttractMode
	Dim LastSwitchHit
	Dim BallsOnPlayfield
	Dim BallsInHole
	Dim bFreePlay
	Dim bGameInPlay
	Dim bOnTheFirstBall
	Dim bBallInPlungerLane
	Dim bBallSaverActive
	Dim bBallSaverReady
	Dim bMultiBallMode
	Dim bMusicOn
	Dim bSkillshotReady
	Dim bExtraBallWonThisBall
	Dim bJustStarted
	Dim pupPlayer
	Set pupPlayer = new PinUp
	Dim gameState

	Dim RESET_ARMY_LIGHTS:RESET_ARMY_LIGHTS = "RESET_ARMY_LIGHTS"
	Dim COLLECT_ARMY:COLLECT_ARMY = "COLLECT_ARMY"

	
	Dim c_soviet, c_empire, c_allied, c_black

	c_empire = RGB(61,12,97)
	c_soviet = RGB(133,12,12)
	c_allied = RGB(29,44,144)
	c_black = RGB(0,0,0)


	'LoadCoreFiles
	'Sub LoadCoreFiles
	'	On Error Resume Next
    '    ExecuteGlobal GetTextFile("core.vbs")
	'	If Err Then MsgBox "Can't open core.vbs"
	'	On Error Goto 0
    'End Sub

    Dim WshShell
	Set WshShell = CreateObject("WScript.Shell")
	LoadCoreFiles

	Sub LoadCoreFiles
		On Error Resume Next
		ExecuteGlobal GetTextFile("core.vbs")
		If Err Then MsgBox "Can't open core.vbs"
		ExecuteGlobal GetTextFile("controller.vbs")
		If Err Then MsgBox "Can't open controller.vbs"
		On Error Goto 0

		'============================'  Orbital Scoreboard'============================	
		'if osbactive = 1 or osbactive = 2 Then		
		'	On Error Resume Next		
		'	ExecuteGlobal GetTextFile("osb.vbs")	
		'	On Error Goto 0
		'end if


	End Sub

	Dim EnableBallControl
	EnableBallControl = false 'Change to true to enable manual ball control (or press C in-game) via the arrow keys and B (boost movement) keys

'End Region Variables

'Region Sound Functions	

	'*********************************************************************
	'                 Positional Sound Playback Functions
	'*********************************************************************

	' Play a sound, depending on the X,Y position of the table element (especially cool for surround speaker setups, otherwise stereo panning only)
	' parameters (defaults): loopcount (1), volume (1), randompitch (0), pitch (0), useexisting (0), restart (1))
	' Note that this will not work (currently) for walls/slingshots as these do not feature a simple, single X,Y position
	Sub PlayXYSound(soundname, tableobj, loopcount, volume, randompitch, pitch, useexisting, restart)
		PlaySound soundname, loopcount, volume, AudioPan(tableobj), randompitch, pitch, useexisting, restart, AudioFade(tableobj)
	End Sub

	' Similar subroutines that are less complicated to use (e.g. simply use standard parameters for the PlaySound call)
	Sub PlaySoundAt(soundname, tableobj)
		PlaySound soundname, 1, 1, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
	End Sub

	Sub PlaySoundAtBall(soundname)
		PlaySoundAt soundname, ActiveBall
	End Sub

	'*********************************************************************
	'                     Supporting Ball & Sound Functions
	'*********************************************************************

	Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "table1" is the name of the table
		Dim tmp
		tmp = tableobj.y * 2 / table1.height-1
		If tmp > 0 Then
			AudioFade = Csng(tmp ^10)
		Else
			AudioFade = Csng(-((- tmp) ^10) )
		End If
	End Function

	Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
		Dim tmp
		tmp = tableobj.x * 2 / table1.width-1
		If tmp > 0 Then
			AudioPan = Csng(tmp ^10)
		Else
			AudioPan = Csng(-((- tmp) ^10) )
		End If
	End Function

	Function Vol(ball) ' Calculates the Volume of the sound based on the ball speed
		Vol = Csng(BallVel(ball) ^2 / 2000)
	End Function

	Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
		Pitch = BallVel(ball) * 20
	End Function

	Function BallVel(ball) 'Calculates the ball speed
		BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2) ) )
	End Function

'End Region Sound Functions

'Region Table Init

	Sub Table1_Init()
		''DMD_Init
		LoadEM
		Dim i
		Randomize
		''Loadhs
		' bAttractMode = False
		' bOnTheFirstBall = False
		' bBallInPlungerLane = False
		' bBallSaverActive = False
		' bBallSaverReady = False
		' bMultiBallMode = False
		' bGameInPlay = False
		' bAutoPlunger = False
		' bMusicOn = True
		' BallsOnPlayfield = 0
		' BallsInHole = 0
		' LastSwitchHit = ""
		' Tilt = 0
		' TiltSensitivity = 6
		' Tilted = False
		' bBonusHeld = False
		' bJustStarted = True


		'pupPlayer.InitPup()
		
		''GiOff
		''m_puPlayer.SendMSG "{ ""mt"":301, ""SN"": 2, ""FN"":4, ""FS"":1 }"
		''StartAttractMode
		GiON()
		
		'START GAME
		StartGame()

	End Sub

	Sub StartGame()

		Dim colors,army
		Set gameState = CreateObject("Scripting.Dictionary")
		Set colors=CreateObject("Scripting.Dictionary")

		Set army = InitArmyState

		colors.Add "allied", c_allied
		colors.Add "soviet", c_soviet
		colors.Add "empire", c_empire
		gameState.Add "colors", colors
		gameState.Add "army", army

		Dispatch RESET_ARMY_LIGHTS, Null

		
	End Sub

	Function InitArmyState()
		Dim army,inf,tank,air,armyColors,armyShots,armyTypes,activeArmyShot
		Set army=CreateObject("Scripting.Dictionary")
		Set inf=CreateObject("Scripting.Dictionary")
		Set tank=CreateObject("Scripting.Dictionary")
		Set air=CreateObject("Scripting.Dictionary")
		Set activeArmyShot=CreateObject("Scripting.Dictionary")

		inf.Add "insertsArmyLeftOrbit", insertsArmyLeftOrbitINF
		inf.Add "insertsArmyLeftRamp", insertsArmyLeftRampINF
		inf.Add "insertsArmyRightRamp", insertsArmyRightRampINF
		inf.Add "insertsArmyRightOrbit", insertsArmyRightOrbitINF

		tank.Add "insertsArmyLeftOrbit", insertsArmyLeftOrbitTANK
		tank.Add "insertsArmyLeftRamp", insertsArmyLeftRampTANK
		tank.Add "insertsArmyRightRamp", insertsArmyRightRampTANK
		tank.Add "insertsArmyRightOrbit", insertsArmyRightOrbitTANK

		air.Add "insertsArmyLeftOrbit", insertsArmyLeftOrbitAIR
		air.Add "insertsArmyLeftRamp", insertsArmyLeftRampAIR
		air.Add "insertsArmyRightRamp", insertsArmyRightRampAIR
		air.Add "insertsArmyRightOrbit", insertsArmyRightOrbitAIR

		activeArmyShot.Add "shot", Null
		activeArmyShot.Add "type", Null
		
		armyColors = Array("allied","soviet","empire")
		armyShots = Array("insertsArmyLeftOrbit","insertsArmyLeftRamp","insertsArmyRightRamp", "insertsArmyRightOrbit")
		armyTypes = Array("inf","tank","air")

		army.Add "inf", inf
		army.Add "tank", tank
		army.Add "air", air
		army.Add "armyColors", armyColors
		army.Add "armyShots", armyShots
		army.Add "armyTypes", armyTypes
		army.Add "activeArmyShot", activeArmyShot
		
		
		Set InitArmyState = army
	End Function




'***********************************************************************************************************************
'*****                                          GAME ACTIONS	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

	Sub Dispatch(action, options)
		
		DebugPost action

		Select Case action

			Case RESET_ARMY_LIGHTS:
				ResetArmyLights options
			Case COLLECT_ARMY:
				If IsNull(gameState("army")("activeArmyShot")("shot")) Then
					StartCollectArmy options
				Else
					CollectArmy options
				End If
				
			Case Else
				MsgBox("Action Unknown")
		End Select

		

	End Sub

	Sub StartCollectArmy(hitArmyShot)
		Dim armyType, armyShot
		For Each armyType in gameState("army")("armyTypes")
			If gameState("army")(armyType)(hitArmyShot).State = 1 Then
				gameState("army")("activeArmyShot")("type") = armyType
				gameState("army")("activeArmyShot")("shot") = hitArmyShot
				'set every other shot to blink for this army type
				For Each armyShot in gameState("army")("armyShots")
					If armyShot <> hitArmyShot Then
						gameState("army")(armyType)(armyShot).State = 2
						gameState("army")(armyType)(armyShot).colorFull = gameState("army")(armyType)(hitArmyShot).colorFull
						gameState("army")(armyType)(armyShot).color = gameState("army")(armyType)(hitArmyShot).color
					End IF
				Next
			Else
				For Each armyShot in gameState("army")("armyShots")
					gameState("army")(armyType)(armyShot).State = 0					
				Next
			End If
		Next
	End Sub

	Sub CollectArmy(hitArmyShot)
		If gameState("army")("activeArmyShot")("shot") <> hitArmyShot Then
			'add score 
			'collect army type
			Dispatch RESET_ARMY_LIGHTS, Null

		End If
	End Sub

	Sub ResetArmyLights(options)
		Dim armyColors, armyShots, armyTypes
		armyColors = gameState("army")("armyColors")
		armyShots =  gameState("army")("armyShots")
		armyTypes =  gameState("army")("armyTypes")

		RandomizeArray armyColors
		RandomizeArray armyShots

		gameState("army")("inf")(armyShots(0)).State = 1
		gameState("army")("inf")(armyShots(0)).colorFull = gameState("colors")(armyColors(0))
		gameState("army")("inf")(armyShots(0)).color = c_black
		gameState("army")("tank")(armyShots(0)).State = 0
		gameState("army")("air")(armyShots(0)).State = 0

		gameState("army")("air")(armyShots(1)).State = 1
		gameState("army")("air")(armyShots(1)).colorFull = gameState("colors")(armyColors(1))
		gameState("army")("air")(armyShots(1)).color = c_black
		gameState("army")("tank")(armyShots(1)).State = 0
		gameState("army")("inf")(armyShots(1)).State = 0

		gameState("army")("tank")(armyShots(2)).State = 1
		gameState("army")("tank")(armyShots(2)).colorFull = gameState("colors")(armyColors(2))
		gameState("army")("tank")(armyShots(2)).color = c_black
		gameState("army")("air")(armyShots(2)).State = 0
		gameState("army")("inf")(armyShots(2)).State = 0

		RandomizeArray armyTypes
		RandomizeArray armyColors
		gameState("army")(armyTypes(0))(armyShots(3)).State = 1
		gameState("army")(armyTypes(0))(armyShots(3)).colorFull = gameState("colors")(armyColors(0))
		gameState("army")(armyTypes(0))(armyShots(3)).color = c_black
		gameState("army")(armyTypes(1))(armyShots(3)).State = 0
		gameState("army")(armyTypes(2))(armyShots(3)).State = 0

		gameState("army")("activeArmyShot")("shot") = Null
		gameState("army")("activeArmyShot")("type") = Null
	End Sub

' End Region


'********************
' MATHS
'********************

Function RndNum(min,max)
 RndNum = Int(Rnd()*(max-min+1))+min     ' Sets a random number between min AND max
End Function

Dim BIP
BIP = 0

'EndRegion Table Init

'Region Keys

Sub Table1_KeyDown(ByVal Keycode)
    
    If keycode = PlungerKey Then
        PlaySoundAt "fx_plungerpull", Plunger
        Plunger.Pullback
    End If
    
	debugKickers(Keycode)
	If keyCode = 66 Then 'F8
		DebugPostState
	End If

    If keycode = LeftTiltKey Then Nudge 90, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, -0.1, 0.25:CheckTilt
    If keycode = RightTiltKey Then Nudge 270, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, 0.1, 0.25:CheckTilt
    If keycode = CenterTiltKey Then Nudge 0, 7:PlaySound SoundFX("fx_nudge",0), 0, 1, 1, 0.25:CheckTilt
    
    If keycode = LeftFlipperKey Then
        LeftFlipper.RotateToEnd
        PlaySound SoundFX("fx_flipperup",DOFFlippers), 0, .67, AudioPan(LeftFlipper), 0.05,0,0,1,AudioFade(LeftFlipper)
        ''ldown = 1
        ''checkdown
        If bSkillshotReady = False Then
            ''RotateLaneLightsLeft
        End If
    End If
    
    If keycode = RightFlipperKey Then 
        RightFlipper.RotateToEnd
        UpRightFlipper.RotateToEnd
        PlaySound SoundFX("fx_flipperup",DOFFlippers), 0, .67, AudioPan(RightFlipper), 0.05,0,0,1,AudioFade(RightFlipper)
        ''rdown = 1
        ''checkdown
        If bSkillshotReady = False Then
            ''RotateLaneLightsRight
        End If
    End If
    
    If keycode = StartGameKey Then
        ballRelease.CreateSizedball BallSize / 2
        ballRelease.Kick 90, 4
    End If
    
    
End Sub


Sub Table1_KeyUp(ByVal keycode)
    
    
    
    If keycode = PlungerKey Then
        PlaySoundAt "fx_plunger", Plunger
        Plunger.Fire
    End If
    
    ' Table specific
    
    
    
    
    If keycode = LeftFlipperKey Then
        ''ldown = 0
        LeftFlipper.RotateToStart
        PlaySound SoundFX("fx_flipperdown",DOFFlippers), 0, 1, AudioPan(LeftFlipper), 0.05,0,0,1,AudioFade(LeftFlipper)
    End If
    If keycode = RightFlipperKey Then
        ''rdown = 0
        RightFlipper.RotateToStart
        UpRightFlipper.RotateToStart
        PlaySound SoundFX("fx_flipperdown",DOFFlippers), 0, 1, AudioPan(RightFlipper), 0.05,0,0,1,AudioFade(RightFlipper)
    End If
    
    
End Sub

'End Region Keys

'Region Slings

Dim LStep, RStep

Sub LeftSlingShot_Slingshot
    PlaySoundAt SoundFX("fx_slingshot", DOFContactors), Lemk
    myDof.DOF 101, DOFPulse
    LeftSling4.Visible = 1
    Lemk.RotX = 26
    LStep = 0
    LeftSlingShot.TimerEnabled = 1
End Sub

Sub LeftSlingShot_Timer
    Select Case LStep
        Case 1:LeftSLing4.Visible = 0:LeftSLing3.Visible = 1:Lemk.RotX = 14
        Case 2:LeftSLing3.Visible = 0:LeftSLing2.Visible = 1:Lemk.RotX = 2
        Case 3:LeftSLing2.Visible = 0:Lemk.RotX = -10:LeftSlingShot.TimerEnabled = 0
    End Select
    LStep = LStep + 1
End Sub

Sub RightSlingShot_Slingshot
    PlaySoundAt SoundFX("fx_slingshot", DOFContactors), Remk
    myDof.DOF 102, DOFPulse
    RightSling4.Visible = 1
    Remk.RotX = 26
    RStep = 0
    RightSlingShot.TimerEnabled = 1
End Sub

Sub RightSlingShot_Timer
    Select Case RStep
        Case 1:RightSLing4.Visible = 0:RightSLing3.Visible = 1:Remk.RotX = 14
        Case 2:RightSLing3.Visible = 0:RightSLing2.Visible = 1:Remk.RotX = 2
        Case 3:RightSLing2.Visible = 0:Remk.RotX = -10:RightSlingShot.TimerEnabled = 0
    End Select
    RStep = RStep + 1
End Sub



'End Region Slings

'Region GI

	'*****************
	'   Gi Effects
	'*****************

	Dim OldGiState
	OldGiState = -1 'start witht he Gi off

	Sub GiON
		Dim x
		For each x in aGiLights
			x.State = 1
		Next
	End Sub

	Sub GiOFF
		For each x in aGiLights
			x.State = 0
		Next
	End Sub

	Sub GiEffect(enabled)
		If enabled Then
			For each x in aGiLights
				x.Duration 2, 1000, 1
			Next
		End If
	End Sub

	Sub GIUpdate
		Dim tmp, obj
		tmp = Getballs
		If UBound(tmp) <> OldGiState Then
			OldGiState = Ubound(tmp)
			If UBound(tmp) = -1 Then
				GiOff
			Else
				GiOn
			End If
			If musicplaying<>true Then
				vpmTimer.addTimer 1000, "MusicStart '"			
			End If
		End If
		If LampState(GameOverLampID)Then
			MusicStop
		End If

		
	End Sub

'End Region GI


'Region Switches

	Sub swLeftOrbit_Hit()
		DebugPost "swLeftOrbit_Hit"
		gateRightOrbit.Open = true
		Dispatch COLLECT_ARMY, "insertsArmyLeftOrbit"
	End Sub

	Sub swRightOrbit_Hit()
		DebugPost "swRightOrbit_Hit"
		If gateRightOrbit.Open = true Then
			gateRightOrbit.Open = false
		Else
			Dispatch COLLECT_ARMY, "insertsArmyRightOrbit"
		End If
	End Sub

	Sub swLeftRamp_Hit()
		DebugPost "swLeftRamp_Hit"
		Dispatch COLLECT_ARMY, "insertsArmyLeftRamp"
	End Sub

	Sub swRightRamp_Hit()
		DebugPost "swRightRamp_Hit"
		Dispatch COLLECT_ARMY, "insertsArmyRightRamp"
	End Sub

	Sub swBehindFlipper_Hit()

		DiverterFlipper.RotateToEnd
		DiverterFlipper001.RotateToEnd
		vpmTimer.addtimer 3000, "closeRightLaneDiverter '"

	End Sub

	Sub sw46_Hit()

		PlaySoundAt "fx_target", ActiveBall

	End Sub

'End Region


'Region Degug Kickers

	Sub debugKickers(ByVal Keycode)

		'MsgBox(Keycode)
		If keyCode = 30 Then 'A
			debugKicker.CreateSizedball BallSize / 2
			debugKicker.Kick 90, 10
		End If
		If keyCode = 31 Then 'S
			debugKicker.CreateSizedball BallSize / 2
			debugKicker.Kick -90, 10
		End If
	End Sub

'End Region

kickerinit4.CreateSizedballWithMass Ballsize/2, BallMass
kickerinit4.kick 0,0
kickerinit5.CreateSizedballWithMass Ballsize/2, BallMass
kickerinit5.kick 0,0

'Region Kickers
    Sub drain_Hit()
        drain.DestroyBall
    End Sub


    Sub exitkicker
        leftKicker.Kick 135, 20
        'PlaySoundAt SoundFXDOF("fx_kicker", 200, DOFPulse, DOFContactors), kicker1   
        'PlaySound "zing"
    End Sub

    Sub exitUpperkicker
        'MsgBox("exit")
        upperKicker.Kick 200, 20
        'PlaySoundAt SoundFXDOF("fx_kicker", 200, DOFPulse, DOFContactors), kicker1   
        'PlaySound "zing"
    End Sub

    Sub exitRefinerykicker
        'MsgBox("exit")
        refineryKicker.Kick 20, 20
        'PlaySoundAt SoundFXDOF("fx_kicker", 200, DOFPulse, DOFContactors), kicker1   
        'PlaySound "zing"
    End Sub

    Sub exitAlliedMCVKickerOut
        alliedMCVKickerOut.CreateSizedball BallSize / 2
        alliedMCVKickerOut.Kick 135,5
    End Sub

    Sub exitKickerTech
		kickerTech.Kick 180,5
    End Sub

    Sub leftKicker_Hit()
        Dim waittime
        waittime = 1500
        vpmTimer.addtimer waittime, "exitkicker '"

    End Sub

    Sub upperKicker_Hit()
        Dim waittime
        waittime = 1500
        vpmTimer.addtimer waittime, "exitUpperkicker '"
    End Sub

    Sub refineryKicker_Hit()
        Dim waittime
        waittime = 1500
        vpmTimer.addtimer waittime, "exitRefinerykicker '"
	End Sub
	
	Sub kickerTech_Hit()
		Dim waittime
		waittime = 1500
		vpmTimer.addtimer waittime, "exitKickerTech '"
	End Sub

    Sub kickerLeftRampDrain_Hit()
        kickerLeftRampDrain.DestroyBall
        kickerLeftRampExit.CreateSizedball BallSize / 2
        kickerLeftRampExit.Kick 180,20
    End Sub

    Sub alliedMCVKickerIn_Hit()
        alliedMCVKickerIn.DestroyBall
        Dim waittime
        waittime = 100
        vpmTimer.addtimer waittime, "exitAlliedMCVKickerOut '"
    End Sub



'End Region



'******************
' Realtime Updates
'******************




	Sub GameTimer_Timer
        'RollingUpdate
        Diverter.RotZ = DiverterFlipper.CurrentAngle
        Diverter001.RotZ = DiverterFlipper.CurrentAngle
	End Sub



	Sub SolGate(Enabled)
		If Enabled Then
			PlaySound"fx_SolenoidOn"
			DiverterFlipper.RotateToEnd
		Else
			PlaySound"fx_SolenoidOff"
			DiverterFlipper.RotateToStart
		End If
		PlaySound "gq_airlock",-0
	End Sub

'End Region


'Region VPMTimer Callbacks

    Sub closeRightLaneDiverter
        DiverterFlipper.RotateToStart
        DiverterFlipper001.RotateToStart
    End Sub



'End Region


'Region PINUP
	Class PinUp

		Private m_hasPup
		Private m_puPlayer
		Private m_pTopper
		Private m_pDMD
		Private m_pBackglass
		Private m_pPlayfield
		Private m_pMusic
		Private m_pAudio
		Private m_pCallouts

		Public Sub InitPup

			m_hasPup = True
			m_pTopper=0
			m_pDMD=1
			m_pBackglass=2
			m_pPlayfield=3
			m_pMusic=4
			m_pAudio=7
			m_pCallouts=8
			
			on error resume next
				Set m_puPlayer = CreateObject("PinUpPlayer.PinDisplay") 
			on error goto 0

			If Not IsObject(m_puPlayer) Then 
				m_hasPup = False
			End If
			
			If m_hasPup Then

				m_puPlayer.Init m_pBackglass,cGameName
				m_puPlayer.Init m_pMusic,cGameName
				m_puPlayer.Init m_pAudio,cGameName
				m_puPlayer.Init m_pCallouts,cGameName


				m_puPlayer.SetScreenex m_pBackglass,0,0,0,0,0
				m_puPlayer.SetScreenex m_pAudio,0,0,0,0,2
				m_puPlayer.hide m_pAudio
				m_puPlayer.SetScreenex m_pMusic,0,0,0,0,2
				m_puPlayer.hide m_pMusic
				m_puPlayer.SetScreenex m_pCallouts,0,0,0,0,2
				m_puPlayer.hide m_pCallouts

				m_puPlayer.playlistadd m_pMusic,"audioattract", 1 , 0
				m_puPlayer.playlistadd m_pAudio,"audioevents", 1 , 0
				m_puPlayer.playlistadd m_pCallouts,"audiocallouts", 1 , 0
				m_puPlayer.playlistadd m_pBackglass,"backglass", 1 , 0
				m_puPlayer.playlistadd m_pBackglass,"PuPOverlays", 1 , 0
				m_puPlayer.playlistadd m_pBackglass,"videoattract", 1 , 0

				'Set Background video on DMD
				m_puPlayer.playlistplayex m_pBackglass,"backglass","backglass.jpg",0,1
				m_puPlayer.playlistplayex m_pBackglass,"PuPOverlays","overlay.png",0,1
				m_puPlayer.SetBackground m_pBackglass,1	

			

				m_puPlayer.LabelInit m_pBackglass

				'Setup Pages.  Note if you use fonts they must be in FONTS folder of the pupVideos\tablename\FONTS
				'syntax - mm_puPlayer.LabelNew <screen# or pDMD>,<Labelname>,<fontName>,<size%>,<colour>,<rotation>,<xAlign>,<yAlign>,<xpos>,<ypos>,<PageNum>,<visible>

				'Page 1 (default score display)
				m_puPlayer.LabelNew m_pBackglass,"Play1",typefont,			3,16777215  ,0,0,1,23,81,1,0
				m_puPlayer.LabelNew m_pBackglass,"Play1score",numberfont,	3,16777215  ,0,0,1,31,81,1,0
				m_puPlayer.LabelNew m_pBackglass,"Play2",typefont,			3,16777215  ,0,0,1,23,85,1,0
				m_puPlayer.LabelNew m_pBackglass,"Play2score",numberfont,	3,16777215  ,0,0,1,31,85,1,0
				m_puPlayer.LabelNew m_pBackglass,"Play3",typefont,			3,16777215  ,0,0,1,23,89,1,0
				m_puPlayer.LabelNew m_pBackglass,"Play3score",numberfont,	3,16777215  ,0,0,1,31,89,1,0
				m_puPlayer.LabelNew m_pBackglass,"Play4",typefont,			3,16777215  ,0,0,1,23,93,1,0
				m_puPlayer.LabelNew m_pBackglass,"Play4score",numberfont,	3,16777215  ,0,0,1,31,93,1,0
				m_puPlayer.LabelNew m_pBackglass,"curscore",numberfont,		7,16777215	,0,1,1,50,87,1,1
				m_puPlayer.LabelNew m_pBackglass,"Ball",typefont,			2,16777215 	,0,1,1,50,81,1,1
				m_puPlayer.LabelNew m_pBackglass,"curplayer",typefont,		3,0		 	,0,1,1,50,93,1,1
				m_puPlayer.LabelNew m_pBackglass,"hstitle",typefont,		3,444665 	,0,1,1,65,89,1,1
				m_puPlayer.LabelNew m_pBackglass,"hs",numberfont,			3,16777215 	,0,1,1,65,93,1,1
				m_puPlayer.LabelNew m_pBackglass,"gptitle",typefont,		3,8421504 	,0,1,1,77,89,1,1
				m_puPlayer.LabelNew m_pBackglass,"gp",numberfont,			3,16777215 	,0,1,1,77,93,1,1
				m_puPlayer.LabelNew m_pBackglass,"notetitle",numberfont,	3,16777215  ,0,1,1,50,12,1,1
				m_puPlayer.LabelNew m_pBackglass,"notecopy",typefont,		2,16777215 	,0,1,1,50,15,1,1
				m_puPlayer.LabelNew m_pBackglass,"titlebg",zoombgfont,		9,0  		,0,1,1,50,50,1,1
				m_puPlayer.LabelNew m_pBackglass,"title",zoomfont,			9,16777215 	,0,1,1,50,50,1,1
				m_puPlayer.LabelNew m_pBackglass,"titlebg2",zoombgfont,		6,0  		,0,1,1,50,50,1,1
				m_puPlayer.LabelNew m_pBackglass,"title2",zoomfont,			6,16777215 	,0,1,1,50,50,1,1
				m_puPlayer.LabelNew m_pBackglass,"lefttitle",numberfont,	3,0			,0,1,1,11,82,1,1
				m_puPlayer.LabelNew m_pBackglass,"lefttimer",numberfont,	8,16777215  ,0,1,1,11,87,1,1
				m_puPlayer.LabelNew m_pBackglass,"leftdetail",typefont,		2,0	  		,0,1,1,11,93,1,1
				m_puPlayer.LabelNew m_pBackglass,"righttitle",numberfont,	3,0			,0,1,1,89,82,1,1
				m_puPlayer.LabelNew m_pBackglass,"righttimer",numberfont,	8,16777215  ,0,1,1,89,87,1,1
				m_puPlayer.LabelNew m_pBackglass,"rightdetail",typefont,	2,0	  		,0,1,1,89,93,1,1
				m_puPlayer.LabelNew m_pBackglass,"high1name",typefont,		5,16777215  ,0,1,1,22,30,1,1
				m_puPlayer.LabelNew m_pBackglass,"high1score",numberfont,	5,16777215  ,0,1,1,36,30,1,1
				m_puPlayer.LabelNew m_pBackglass,"high2name",typefont,		5,16777215  ,0,1,1,22,38,1,1
				m_puPlayer.LabelNew m_pBackglass,"high2score",numberfont,	5,16777215  ,0,1,1,36,38,1,1
				m_puPlayer.LabelNew m_pBackglass,"high3name",typefont,		5,16777215  ,0,1,1,22,46,1,1
				m_puPlayer.LabelNew m_pBackglass,"high3score",numberfont,	5,16777215  ,0,1,1,36,46,1,1
				m_puPlayer.LabelNew m_pBackglass,"high4name",typefont,		5,16777215  ,0,1,1,22,54,1,1
				m_puPlayer.LabelNew m_pBackglass,"high4score",numberfont,	5,16777215  ,0,1,1,36,54,1,1
				m_puPlayer.LabelNew m_pBackglass,"HighScore",typefont,		6,16777215	,0,0,1,20,30,1,1
				m_puPlayer.LabelNew m_pBackglass,"HighScoreL1",numberfont,	8,16777215	,0,0,1,20,40,1,1
				m_puPlayer.LabelNew m_pBackglass,"HighScoreL2",numberfont,	8,16777215	,0,0,1,24,40,1,1
				m_puPlayer.LabelNew m_pBackglass,"HighScoreL3",numberfont,	8,16777215	,0,0,1,28,40,1,1
				m_puPlayer.LabelNew m_pBackglass,"HighScoreL4",numberfont,	4,16777215	,0,0,1,20,50,1,1

			End If

			ResetBackGlass()

		End Sub

		Public Sub TurnDownMusic
			m_puPlayer.SendMSG "{ ""mt"":301, ""SN"": 2, ""FN"":11, ""VL"":10 }"
			m_puPlayer.SendMSG "{ ""mt"":301, ""SN"": 4, ""FN"":11, ""VL"":10 }"
			m_puPlayer.SendMSG "{ ""mt"":301, ""SN"": 7, ""FN"":11, ""VL"":10 }"
			vpmtimer.addtimer 2200, "TurnUpMusic '"
		End Sub

		Public Sub TurnUpMusic
			m_puPlayer.SendMSG "{ ""mt"":301, ""SN"": 2, ""FN"":11, ""VL"":99 }"
			m_puPlayer.SendMSG "{ ""mt"":301, ""SN"": 4, ""FN"":11, ""VL"":99 }"
			m_puPlayer.SendMSG "{ ""mt"":301, ""SN"": 7, ""FN"":11, ""VL"":99 }"
		End Sub

		Public Sub ResetBackGlass
			m_puPlayer.LabelShowPage m_pBackglass,1,0,""
			m_puPlayer.playlistplayex m_pBackglass,"scene","layout.png",0,1
			m_puPlayer.SetBackground m_pBackglass,1
			m_puPlayer.LabelSet m_pBackglass,"hstitle","HIGH SCORE",1,""
			m_puPlayer.LabelSet m_pBackglass,"hs","2332332",1,"" '& FormatNumber(HighScore(0),0),1,""
			m_puPlayer.LabelSet m_pBackglass,"gptitle","GAMES",1,""
			m_puPlayer.LabelSet m_pBackglass,"gp","343434",1,"" '& FormatNumber(TotalGamesPlayed,0),1,""
			m_puPlayer.LabelSet m_pBackglass,"Ball","PRESS\rSTART",1,""

			m_puPlayer.LabelSet m_pBackglass,"lefttitle","DATA ITEM",1,""
			m_puPlayer.LabelSet m_pBackglass,"lefttimer","455",1,""
			m_puPlayer.LabelSet m_pBackglass,"leftdetail","PRESS\rSTART",1,""
			m_puPlayer.LabelSet m_pBackglass,"righttitle","DATA ITEM",1,""
			m_puPlayer.LabelSet m_pBackglass,"righttimer","455",1,""
			m_puPlayer.LabelSet m_pBackglass,"rightdetail","PRESS\rSTART",1,""
		End Sub

	End Class







'End Region


EnableBallSaver(20)


'Version of Ballsaver using led display
Dim dbs1, dbs2, dbsdelta, dbstime, dbstens, dbsones, dbsdecimals
Sub EnableBallSaver(seconds)
	seconds = seconds + 0.3  'padding
    'If debugGeneral Then debug.print "*****SUB:EnableBallSaver, seconds=" & seconds
    ' set our game flag
    'bBallSaverActive = True
    'bBallSaverReady = False
    ' start the timer

	BallSaverTimerExpired.Interval = 1000 * seconds
	BallSaverTimerExpired.Enabled = True

	'Set display to x seconds 
	dbstime = seconds
	dbsdelta = .1
	BallSaverUpdateTimer.Interval = 100

	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	debug.print dbsones
	debug.print dbsdecimals
	if dbstime > 10 then 
		fBStens.ImageA = "digit_" & Eval(dbstens)
		fBSones.ImageA = "digit_" & Eval(dbsones)
	else
		fBStens.ImageA = "digit_" & Eval(dbsones + 10)
		fBSones.ImageA = "digit_" & Eval(dbsdecimals)
	end if
'	if dbstime > 10 then 
'		dBallSave1.SetValue (dbstens + 1)
'		dBallSave2.SetValue (dbsones + 1)
'	else
'		dBallSave1.SetValue (dbsones + 1+10)
'		dBallSave2.SetValue (dbsdecimals + 1)
'	end if

	dbstime = dbstime - dbsdelta
    BallSaverUpdateTimer.Enabled = True
End Sub

Sub StopBallSaver
    BallSaverUpdateTimer.Enabled = False
	BallSaverTimer2Expired.Enabled = False
	If ExtraBallsAwards(CurrentPlayer) = 0 Then
		ResetBallSaveDisplay
	Else
		SetExtraBallDisplay
	End If
	bBallSaverActive = False
End Sub


' The ball saver timer has expired.  Turn it off AND reset the game flag
'
Sub BallSaverTimerExpired_Timer()
    'If debugGeneral Then debug.print "*****SUB:" & "BallSaverTimerExpired_Timer"
    BallSaverTimerExpired.Enabled = False
    BallSaverUpdateTimer.Enabled = False

    ' clear the LED display, give extra 2 second 
	'If ExtraBallsAwards(CurrentPlayer) = 0 Then
		ResetBallSaveDisplay
	'Else
	'	SetExtraBallDisplay
	'End If
	'BallSaverTimer2Expired.Interval = 2000
	'BallSaverTimer2Expired.Enabled = True
End Sub

Sub ResetBallSaveDisplay
'	dBallSave1.SetValue 0
'	dBallSave2.SetValue 0
	fBStens.ImageA = "blank"
	fBSones.ImageA = "blank"
End Sub


'Sub BallSaverTimer2Expired_Timer()
'    If debugGeneral Then debug.print "*****SUB:" & "BallSaverTimer2Expired_Timer"
'    BallSaverTimer2Expired.Enabled = False

    ' clear the flag
'    bBallSaverActive = False
'End Sub

Sub BallSaverUpdateTimer_Timer()
	Dim tmp
    'If debugGeneral Then debug.print "*****SUB:" & "BallSaverUpdateTimer_Timer " & dbstime

	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		fBStens.ImageA = "digit_" & Eval(dbstens)
		fBSones.ImageA = "digit_" & Eval(dbsones)
	else
		fBStens.ImageA = "digit_" & Eval (dbsones + 10)
		fBSones.ImageA = "digit_" & Eval(dbsdecimals)
	end if
'	if dbstime > 10 then 
'		'DEBUG.PRINT dbstime & " : " & dbstens & " : " & dbsones & " : " & dbsdecimals
'		dBallSave1.SetValue (dbstens + 1)
'		dBallSave2.SetValue (dbsones + 1)
'	else
'		'DEBUG.PRINT dbstime & " : " & dbstens & " : " & dbsones & " : " & dbsdecimals
'		dBallSave1.SetValue (dbsones + 1+10)
'		dBallSave2.SetValue (dbsdecimals + 1)
'	end if
	dbstime = dbstime - dbsdelta

End Sub

Sub PrintGameState
	dim json
	json = ObjectToString(gameState)
	debug.print Left(json, Len(json) - 1)
End Sub

' Region Util Functions

	Sub SetLightColor(n, col, stat)
		Select Case col
			Case c_empire
				n.color = RGB(0, 0, 0)
				n.colorfull = c_empire
			Case c_soviet
				n.color = RGB(0, 0, 0)
				n.colorfull = c_soviet
			Case c_allied
				n.color = RGB(0, 0, 0)
				n.colorfull = c_allied
		End Select
		If stat <> -1 Then
			n.State = 0
			n.State = stat
		End If
	End Sub

	Function ObjectToString(o)
		Dim k
		Dim s
		s = "{"
		If(HasKeys(o)) Then
			For Each k in o.Keys()
				If IsObject(o(k)) Then
					s = s & " """ & k & """: " & ObjectToString(o(k))
				Else 
					If IsArray(o(k)) Then
						s = s & " """ & k & """: " & ArrayToString(o(k))
					Else
						s = s & " """ & k & """: """ & o(k) & ""","
					End If
				End If
			Next
			s = Left(s, Len(s) - 1) 
		Else

			Dim tableProps
			tableProps = TableItemProperties(o)
			
			If IsArray(tableProps) Then
				Dim prop
				Dim itemCount
				itemCount = UBound(tableProps)
				s = s & " """ & o.Name & """: {"
				s = s & " ""Type"": """ & TypeName(o) & ""","
				For Each prop in tableProps
					Dim pv
					pv = PropertyValue(o,prop)
					s = s & pv & ","
				Next
				s = Left(s, Len(s) - 1) 
				s = s & "}"
			Else
				s = s & " """ & o.Name & """: """ & TypeName(o) & """"
			End If
		End If
		s = s & " },"
		ObjectToString = s
	End Function

	Function ArrayToString(a)

		Dim s
		Dim item
		s = "[ "

		For Each item in a
			If IsObject(item) Then
				s = s & ObjectToString(item)
			Else
				If IsArray(item) Then
					s = s & ArrayToString(item) & ","
				Else
					s = s & """" & item & """" & ","
				End If
			End If
		Next
		s = Left(s, Len(s) - 1) 
		s = s & " ],"
		

		ArrayToString = s
	End Function

	Function PropertyValue(o,p)

		Dim pv
		Dim s

		Select Case p(1)
			Case "BSTR"
				Execute "pv = " & o.Name & "." & p(0)
				s = " """ & p(0) & """:" & """" & pv & """"
			Case "float"
				Execute "pv = " & o.Name & "." & p(0)
				s = " """ & p(0) & """:" & pv
			Case "long"
				Execute "pv = " & o.Name & "." & p(0)
				s = " """ & p(0) & """:" & pv
			Case "LightState"
				Execute "pv = " & o.Name & "." & p(0)
				s = " """ & p(0) & """:" & pv
			Case "VARIANT_BOOL"
				Execute "pv = " & o.Name & "." & p(0)
				s = " """ & p(0) & """:" & LCase(CStr(pv))
			Case "OLE_COLOR"
				Execute "pv = " & o.Name & "." & p(0)
				s = " """ & p(0) & """:" & """" & TranslateOleColor(pv) & """"
			Case Else
				s = " """ & p(0) & """: " & """" & """"
		End Select


		PropertyValue = s
	End Function

	Function HasKeys(o)
		Dim Success
		Success = False

		On Error Resume Next
			' set for property here
			
			o.Keys()

			Success = (Err.Number = 0)
		On Error Goto 0
		HasKeys = Success
	End Function   

	Function TableItemProperties(o)

		Dim properties
		properties = -1

		Select Case TypeName(o)
			Case "Light"
				properties = Array(Array("Falloff", "float"),Array("FalloffPower", "float"),Array("State", "LightState"),Array("Color", "OLE_COLOR"),Array("ColorFull", "OLE_COLOR"),Array("TimerEnabled", "VARIANT_BOOL"),Array("TimerInterval", "long"),Array("X", "float"),Array("Y", "float"),Array("BlinkPattern", "BSTR"),Array("BlinkInterval", "long"),Array("Intensity", "float"),Array("TransmissionScale", "float"),Array("IntensityScale", "float"),Array("Surface", "BSTR"),Array("Name", "BSTR"),Array("UserValue", "VARIANT*"),Array("Image", "BSTR"),Array("ImageMode", "VARIANT_BOOL"),Array("DepthBias", "float"),Array("FadeSpeedUp", "float"),Array("FadeSpeedDown", "float"),Array("Bulb", "VARIANT_BOOL"),Array("ShowBulbMesh", "VARIANT_BOOL"),Array("StaticBulbMesh", "VARIANT_BOOL"),Array("ShowReflectionOnBall", "VARIANT_BOOL"),Array("ScaleBulbMesh", "float"),Array("BulbModulateVsAdd", "float"),Array("BulbHaloHeight", "float"),Array("Visible", "VARIANT_BOOL"))
		End Select


		TableItemProperties = properties

	End Function

	Function TranslateOleColor(c)

		Dim hexV, r, g, b, colorHex
		hexV = Right("000000" & Hex(c), 6)
		r = Left(hexV, 2)
		g = Mid(hexV, 3,2)
		b = Right(hexV, 2)
		colorHex = "#" & r & g & b

		TranslateOleColor = colorHex
	End Function

	Sub RandomizeArray(items)
		Dim i
		Dim j
		Dim k
		Dim tmp
		Dim itemsCount
		itemsCount = uBound(items)


		' Randomize the array.
		Randomize
		For k = 0 To itemsCount*2
			For i = 0 To itemsCount
				'MsgBox(items(i))
				' Pick a random entry.
				j = Int(((itemsCount)-0+1)*Rnd)
				
				' Swap the numbers.
				tmp = items(i)
				items(i) = items(j)
				items(j) = tmp
			Next
		Next
	End Sub

	' Dim debugStateQueue:Set debugStateQueue = CreateObject("Scripting.Dictionary")
	Dim objXmlHttpMain, Url
	Url = "http://localhost:3000/"
	
	
	Sub DebugPost(action)
		Dim json
		json ="{""action"": """ & action & """, ""data"": {} }"	
		Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP")
		objXmlHttpMain.open "POST",Url, False
		objXmlHttpMain.setRequestHeader "Content-Type", "application/json"
		objXmlHttpMain.send json
	End Sub	
	
	Sub DebugPostState()
		Dim json
 		Dim stateJson:stateJson = ObjectToString(gameState)
 		json ="{""action"": ""STATE_DUMP"", ""data"": " & Left(stateJson, Len(stateJson) - 1) & "}"	
		Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP")
		objXmlHttpMain.open "POST",Url, False
		objXmlHttpMain.setRequestHeader "Content-Type", "application/json"
		objXmlHttpMain.send json
	End Sub	

' End Region