'***********************************************************************************************************************
'*****  CYBERRACE PINBALL by Flux                                  	                                                ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Option Explicit
Randomize

DebugOutClear()



'TABLE OPTIONS

Const typefont = "Raleway Medium"
Const numberfont = "Bebas Neue"
Const zoomfont = "Fundamental  Brigade"
Const zoombgfont = "Fundamental 3D  Brigade" ' needs to be an outline of the zoomfont
Const cGameName = "cyberrace"
Const myVersion = "1.0.0"
Const BallSize = 50
Const BallMass = 1
Const MaxPlayers = 4
Const BallSaverTime = 15 
Const MaxMultiplier = 6 
Const MaxMultiballs = 5
Const bpgcurrent = 3
Dim pBackglass:pBackglass=2
Const RollingSoundFactor = 1 		'Change volume of rolling sounds
Dim usePup: usePUP = True 'Use Pup Pack or FlexDMD. false = FlexDMD, true = Pup Pack
Dim useLightMapper: useLightMapper = true
Const VR_ON = False

'----- Shadow Options -----
Dim DynamicBallShadowsOn: DynamicBallShadowsOn = 0		'0 = no dynamic ball shadow, 1 = enable dynamic ball shadow

If VR_ON = True Then
	DynamicBallShadowsOn = 0
End If

' using table width and height in script slows down the performance
dim tablewidth: tablewidth = Table1.width
dim tableheight: tableheight = Table1.height

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
	dim plungerIM
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
	Dim insertPrims(140)
	Dim DiverterDir

	'Dim pupPlayer
	'Set pupPlayer = new PinUp
	Dim gameStarted
	gameStarted = False

	Dim debugMode:debugMode = False

	LoadCoreFiles

	Sub LoadCoreFiles
		On Error Resume Next
		ExecuteGlobal GetTextFile("core.vbs")
		If Err Then MsgBox "Can't open core.vbs"
		ExecuteGlobal GetTextFile("controller.vbs")
		If Err Then MsgBox "Can't open controller.vbs"
		On Error Goto 0
	End Sub

	Dim EnableBallControl
	EnableBallControl = false 'Change to true to enable manual ball control (or press C in-game) via the arrow keys and B (boost movement) keys

	'Dim objShell
	Dim dEff(9)
	'on error resume next
	'Set objShell = CreateObject("WScript.Shell")
	'DOFeffects(0)=objShell.RegRead(directory & "DOFContactors")
	'DOFeffects(1)=objShell.RegRead(directory & "DOFKnocker")
	'DOFeffects(2)=objShell.RegRead(directory & "DOFChimes")
	'DOFeffects(3)=objShell.RegRead(directory & "DOFBell")
	'DOFeffects(4)=objShell.RegRead(directory & "DOFGear")
	'DOFeffects(5)=objShell.RegRead(directory & "DOFShaker")
	'DOFeffects(6)=objShell.RegRead(directory & "DOFFlippers")
	'DOFeffects(7)=objShell.RegRead(directory & "DOFTargets")
	'DOFeffects(8)=objShell.RegRead(directory & "DOFDropTargets")
	'Set objShell = nothing	

'End Region Variables



'Region Table Init

	Sub Table1_Init()
		LoadEM
		kickerCaptiveBall1.CreateSizedballWithMass Ballsize/2, BallMass
		kickerCaptiveBall1.kick 0,0
		kickerCaptiveBall2.CreateSizedballWithMass Ballsize/2, BallMass
		kickerCaptiveBall2.kick 0,0
		Const IMPowerSetting = 50 ' Plunger Power (45)
		Const IMTime = 1.1        ' Time in seconds for Full Plunge
		Set plungerIM = New cvpmImpulseP
		With plungerIM
			.InitImpulseP swplunger, IMPowerSetting, IMTime
			.Random 1.5
			.InitExitSnd SoundFX("fx_kicker", DOFContactors), SoundFX("fx_solenoid", DOFContactors)
			.CreateEvents "plungerIM"
		End With
		InitLightMapperElements
	End Sub

	Sub Table1_Exit()
		
		'If usePUP=False Then
			If Not FlexDMD is Nothing Then
				FlexDMD.Show = False
				FlexDMD.Run = False
				FlexDMD = NULL
			End If
		'End If
	End Sub

' End Region


'********************
' MATHS
'********************



'EndRegion Table Init

'Region Keys

'End Region Keys

'Region Slings

Dim LStep, RStep

Sub LeftSlingShot_Slingshot
    PlaySoundAt SoundFX("fx_slingshot", DOFContactors), Lemk
    DOF 201, DOFPulse
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
    DOF 202, DOFPulse
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




'Region Kickers



    Sub exitAlliedMCVKickerOut
        alliedMCVKickerOut.CreateSizedball BallSize / 2
        alliedMCVKickerOut.Kick 135,5
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


Sub PrintGameState
	dim json
	json = ObjectToString(gameState)
	debug.print Left(json, Len(json) - 1)
End Sub

' Region Util Functions


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
		If debugMode Then
			On Error Resume Next
			Dim json
			json ="{""action"": """ & action & """, ""data"": {} }"	
			Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP")
			objXmlHttpMain.open "POST",Url, False
			objXmlHttpMain.setRequestHeader "Content-Type", "application/json"
			objXmlHttpMain.send json
		End If
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

'***********************************************************************************************************************


'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
'/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
'\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
'/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
'  MANUAL BALLCONTROL
'\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
'/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
'\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
	' 

	Sub StartControl_Hit()
		 Set ControlBall = ActiveBall
		 contballinplay = true
	End Sub

	Dim bcup, bcdown, bcleft, bcright, contball, contballinplay, ControlBall, bcboost
	Dim bcvel, bcyveloffset, bcboostmulti

	bcboost = 1 'Do Not Change - default setting
	bcvel = 4 'Controls the speed of the ball movement
	bcyveloffset = -0.01 'Offsets the force of gravity to keep the ball from drifting vertically on the table, should be negative
	bcboostmulti = 3 'Boost multiplier to ball veloctiy (toggled with the B key)

	Sub BallControl_Timer()
		 If Contball and ContBallInPlay then
			  If bcright = 1 Then
				   ControlBall.velx = bcvel*bcboost
			  ElseIf bcleft = 1 Then
				   ControlBall.velx = - bcvel*bcboost
			  Else
				   ControlBall.velx=0
			  End If

			 If bcup = 1 Then
				  ControlBall.vely = -bcvel*bcboost
			 ElseIf bcdown = 1 Then
				  ControlBall.vely = bcvel*bcboost
			 Else
				  ControlBall.vely= bcyveloffset
			 End If
		 End If
	End Sub








'***********************************************************************************************************************
'*****  DEBUG                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub DebugOutClear()

	'Dim objFileToWrite:Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile("C:\vpxout\ra3.txt",2,true)
	'objFileToWrite.WriteLine("")
	'objFileToWrite.Close
	'Set objFileToWrite = Nothing

End Sub

Sub DebugOut(data)

	Dim objFileToWrite:Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile("C:\vpxout\ra3.txt",8,true)
	objFileToWrite.WriteLine(data)
	objFileToWrite.Close
	Set objFileToWrite = Nothing

End Sub

Dim c: c = 0
Sub debugKeys(ByVal Keycode)

	'MsgBox(keycode)
	If keyCode = 30 Then 'A
		debugKicker.CreateSizedball BallSize / 2
		debugKicker.LastCapturedBall.UserValue = "debugBall"
		debugKicker.Kick 90, 10

		LightSeqAttract.StopPlay
		LightSeqAttract.UpdateInterval = 8
		LightSeqAttract.Play SeqHatch2HorizOn , 10, 0
	End If
	If keyCode = 31 Then 'S
		debugKicker.CreateSizedball BallSize / 2
		debugKicker.LastCapturedBall.UserValue = "debugBall"
		debugKicker.Kick -90, 10
	End If
	If keyCode = 33 Then 'F
		vukdebug.CreateSizedball BallSize / 2
		vukdebug.LastCapturedBall.UserValue = "debugBall"
		vukdebug.Kick 0, 10
	End If
	If keyCode = 34 Then 'G
		alliedLockDebug.CreateSizedball BallSize / 2
		alliedLockDebug.LastCapturedBall.UserValue = "debugBall"
		alliedLockDebug.Kick -75, 15

	End If
	If keyCode = 35 Then 'H
		Timer_test1.Enabled=False
		vukBallLockDebug.CreateSizedball BallSize / 2
		vukBallLockDebug.LastCapturedBall.UserValue = "debugBall"
		vukBallLockDebug.Kick 20, 50
	End If
	If keyCode = 36 Then 'J
		debugKickerTopLock.CreateSizedball BallSize / 2
		debugKickerTopLock.LastCapturedBall.UserValue = "debugBall"
		debugKickerTopLock.Kick 0, 1
	End If
	If keyCode = 37 Then 'K
		debugKickerNfozzy.CreateSizedball BallSize / 2
		debugKickerNfozzy.LastCapturedBall.UserValue = "debugBall"
		debugKickerNFozzy.Kick -45, 20
	End If
	If keyCode = 22 Then 'U
		debugKickerBumpers.CreateSizedball BallSize / 2
		debugKickerBumpers.LastCapturedBall.UserValue = "debugBall"
		debugKickerBumpers.Kick 0, 1
	End If
	If keyCode = 197 Then
		pupevent 504
	End If
	
	If keyCode = 20 Then 'T
		'diverter
		If DiverterP002.RotZ=-60 Then
			DiverterDir = 1
			DiverterOff.IsDropped=0
			DiverterOn.IsDropped=1
			diverterWall3Off.IsDropped = 0
			diverterWall3On.IsDropped = 1
			timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
			PlaySoundAt SoundFX("DiverterOn",DOFContactors),DiverterP002
		ElseIf DiverterP002.RotZ=0 Then
			DiverterDir = -1
			DiverterOff.IsDropped=1
			DiverterOn.IsDropped=0
			diverterWall3Off.IsDropped = 1
			diverterWall3On.IsDropped = 0
			timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
			PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002
		End If
	End If
	If keyCode = 21 Then 'Y
		debugKickerLeftOrbit.CreateSizedball BallSize / 2
		debugKickerLeftOrbit.LastCapturedBall.UserValue = "debugBall"
		debugKickerLeftOrbit.Kick -45, 50
	End If
	If keyCode = 23 Then 'I
		debugKickerLeftRamp.CreateSizedball BallSize / 2
		debugKickerLeftRamp.LastCapturedBall.UserValue = "debugBall"
		debugKickerLeftRamp.Kick -20, 50
	End If
	If keyCode = 25 Then 'P
		debugKickerRightOrbit.CreateSizedball BallSize / 2
		debugKickerRightOrbit.LastCapturedBall.UserValue = "debugBall"
		debugKickerRightOrbit.Kick 20, 40
	End If

	If keyCode = 17 Then 'W
		debugKickerAugmentations.CreateSizedball BallSize / 2
		debugKickerAugmentations.LastCapturedBall.UserValue = "debugBall"
		debugKickerAugmentations.Kick 45, 20
	End If
	If keyCode = 18 Then 'E
		debugKickerDrainLeft.CreateSizedball BallSize / 2
		debugKickerDrainLeft.LastCapturedBall.UserValue = "debugBall"
		debugKickerDrainLeft.Kick 0, 5
	End If
	If keyCode = 19 Then 'R
		debugKickerCaptive.CreateSizedball BallSize / 2
		debugKickerCaptive.LastCapturedBall.UserValue = "debugBall"
		debugKickerCaptive.Kick 15, 25
	End If
	If keyCode = 26 Then 'W
		debugKickerShortcut.CreateSizedball BallSize / 2
		debugKickerShortcut.LastCapturedBall.UserValue = "debugBall"
		debugKickerShortcut.Kick 45, 20
	End If

	If keyCode = 11 Then '0
		If ModLampz.state(0)>0 Then
			DISPATCH LIGHTS_GI_OFF, null
		Else
			DISPATCH LIGHTS_GI_ON, null
		End If


		Dim ele
		For Each ele in GetElements
		
			On Error Resume Next
		
			If ele.Surface = "22h" Then
				If Err Then
					Debug.print("Element has no surface prop")
				Else
					Debug.print(ele.Name)
				End If
			End If
		
			On Error GoTo 0
		
		Next

	End If

	If keyCode = 39 Then ';
		Dispatch LIGHTS_GI_EMPIRE, null
	End If
	If keyCode = 40 Then ''
		Dispatch LIGHTS_GI_SOVIET, null
	End If
	If keyCode = 43 Then '#
		Dispatch LIGHTS_GI_ALLIED, null
	End If
	If keyCode = 51 Then '.
		Dispatch LIGHTS_GI_NORMAL, null
	End If

End Sub

Sub debugFlasher_Timer()
	'
	'objHexBase(1).Material = "FlasherHexMaterial1"
	'objHexBase(1).Image = "hexbasered"
	'objHexLit(1).Image = "hexbasered"
	'HexObjlevel(1) = 1 : FlasherHexFlash1_Timer
	'objHexBase(2).Image = "hexbasered"
	'objHexLit(2).Image = "hexbasered"
	'HexObjlevel(2) = 1 : FlasherHexFlash2_Timer
	'objHexBase(3).Image = "hexbasered"
	'objHexLit(3).Image = "hexbasered"
	'HexObjlevel(3) = 1 : FlasherHexFlash3_Timer
	'objHexBase(4).Image = "hexbasered"
	'objHexLit(4).Image = "hexbasered"
	'HexObjlevel(4) = 1 : FlasherHexFlash4_Timer
	'objHexBase(5).Image = "hexbasered"
	'objHexLit(5).Image = "hexbasered"
	'HexObjlevel(5) = 1 : FlasherHexFlash5_Timer
	'objHexBase(6).Image = "hexbasered"
	'objHexLit(6).Image = "hexbasered"
	'HexObjlevel(6) = 1 : FlasherHexFlash6_Timer
	'objHexBase(7).Image = "hexbasered"
	'objHexLit(7).Image = "hexbasered"
	'HexObjlevel(7) = 1 : FlasherHexFlash7_Timer
	'objHexBase(8).Image = "hexbasered"
	'objHexLit(8).Image = "hexbasered"
	'HexObjlevel(8) = 1 : FlasherHexFlash8_Timer
	'objHexBase(9).Image = "hexbasered"
	'objHexLit(9).Image = "hexbasered"
	'HexObjlevel(9) = 1 : FlasherHexFlash9_Timer
	'objHexBase(10).Image = "hexbasered"
	'objHexLit(10).Image = "hexbasered"
	'HexObjlevel(10) = 1 : FlasherHexFlash10_Timer
	'objHexBase(11).Image = "hexbasered"
	'objHexLit(11).Image = "hexbasered"
	'HexObjlevel(11) = 1 : FlasherHexFlash11_Timer
	'objHexBase(12).Image = "hexbasered"
	'objHexLit(12).Image = "hexbasered"
	'HexObjlevel(12) = 1 : FlasherHexFlash12_Timer
	'objHexBase(13).Image = "hexbasered"
	'objHexLit(13).Image = "hexbasered"
	'HexObjlevel(13) = 1 : FlasherHexFlash13_Timer
	'objHexBase(14).Image = "hexbasered"
	'objHexLit(14).Image = "hexbasered"
	'HexObjlevel(14) = 1 : FlasherHexFlash14_Timer
	'objHexBase(15).Image = "hexbasered"
	'objHexLit(15).Image = "hexbasered"
	'HexObjlevel(15) = 1 : FlasherHexFlash15_Timer
	'objHexBase(16).Image = "hexbasered"
	'objHexLit(16).Image = "hexbasered"
	'HexObjlevel(16) = 1 : FlasherHexFlash16_Timer

End Sub

'***********************************************************************************************************************
'*****  COLORS                                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim c_augmentationResearch,c_augmentationResearchFull,c_black, c_normal,c_normal_full, c_multiball, c_race, c_perkshot
Dim gameColors(7), gameDomes(7)

gameColors(0) = RGB(99, 13, 95)
gameColors(1) = RGB(17, 247, 255)
gameColors(2) = RGB(173, 112, 20)
gameColors(3) = RGB(4, 120, 255)
gameColors(4) = RGB(255, 0, 0)
gameColors(5) = RGB(64,62,2)
gameColors(6) = RGB(255, 240, 33)
gameColors(7) = RGB(13, 109, 18)

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
c_multiball = RGB(13, 109, 18)
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

Sub InitFlexDMD()
	Set FlexDMD = CreateObject("FlexDMD.FlexDMD")
    If FlexDMD is Nothing Then
        MsgBox "No FlexDMD found. This table will NOT run without it."
        Exit Sub
    End If
	SetLocale(1033)
	With FlexDMD
		.GameName = cGameName
		.TableFile = Table1.Filename & ".vpx"
		.Color = RGB(255, 88, 32)
		.RenderMode = FlexDMD_RenderMode_DMD_RGB
		.Width = 128
		.Height = 32
		.Clear = True
		.ProjectFolder = "./CyberRaceDMD/"
		.Run = True
	End With
	FlexDMDCreateWelcomeScene()
End Sub

Sub FlexDMDTimerTest_Timer
Dim DMDp
If FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB Then
	DMDp = FlexDMD.DmdColoredPixels
	If Not IsEmpty(DMDp) Then
		DMDWidth = FlexDMD.Width
		DMDHeight = FlexDMD.Height
		DMDColoredPixels = DMDp
	End If
Else
	DMDp = FlexDMD.DmdPixels
	If Not IsEmpty(DMDp) Then
		DMDWidth = FlexDMD.Width
		DMDHeight = FlexDMD.Height
		DMDPixels = DMDp
	End If
End If
End Sub

'If usePUP = False Then
	InitFlexDMD()
'End Ifs

Dim font : Set font = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)
Dim bigFont : Set bigFont = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)
Sub DisplayCurrentAudioTrack()

	Dim scene : Set scene = FlexDMD.NewGroup("GameModeNormal")

	Dim lblMusic : Set lblMusic = FlexDMD.NewLabel("lblMusic", font, audioTracks(currentTrack)(1))

	scene.AddActor lblMusic
	
	lblMusic.SetAlignedPosition -500, 0, FlexDMD_Align_Center

	Dim afMusic : Set afMusic = lblMusic.ActionFactory
	Dim list : Set list = afMusic.Sequence()
	list.Add afMusic.MoveTo(128, 22, 0)
	list.Add afMusic.Wait(0.5)
	list.Add afMusic.MoveTo(-128, 22, 5.0)
	list.Add afMusic.Show(False)
	lblMusic.AddAction afMusic.Repeat(list, 1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread

End Sub


'Dim BetFrameB: Set BetFrameB = FlexDMD.NewImage("BetFrame_B", "VPX.flexBET&region=0,0,512,128")
'BetFrameB.SetBounds 0, 6, 128, 26
'Dim BetFrameE: Set BetFrameE = FlexDMD.NewImage("BetFrame_E", "VPX.flexBET&region=0,128,512,128")
'BetFrameE.SetBounds 0, 6, 128, 26
'Dim BetFrameT: Set BetFrameT = FlexDMD.NewImage("BetFrame_T", "VPX.flexBET&region=0,256,512,128")
'BetFrameT.SetBounds 0, 6, 128, 26
'Dim BetScene : Set BetScene = FlexDMD.NewGroup("BetCharacters")
'BetScene.AddActor FlexDMD.NewLabel("BetHurryUp", font, "")
'BetScene.AddActor BetFrameB
'BetScene.AddActor BetFrameE
'BetScene.AddActor BetFrameT

Sub DisplayFlexBetHitScreen(frame)
	Exit Sub
	BetFrameB.Visible = False
	BetFrameE.Visible = False
	BetFrameT.Visible = False
	Dim label: Set label = BetScene.GetLabel("BetHurryUp")
	label.SetAlignedPosition 64, 5, FlexDMD_Align_Center
	label.Text = gameState("game")("betHits") & " More Hits"
	Execute frame&".Visible = True"
	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor BetScene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub

Sub vpmTimerFlexUpdateMain
	FlexDMDGameModeNormal()
End Sub
Sub FlexDMDGameModeNormal()
	'DotMatrix.color = RGB(255, 88, 32)

	DisplayFlexBetHitScreen("BetFrameB")
	Exit Sub

	Dim scene : Set scene = FlexDMD.NewGroup("Welcome")
	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "...CYBERRACE...")
	
	scene.AddActor lblTitle
	
	lblTitle.SetBounds 0, 0, 128, 16

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub
Sub FlexDMDGameModeSkillshot()
	'DotMatrix.color = RGB(255, 88, 32)
	Dim scene : Set scene = FlexDMD.NewGroup("GameModeNormal")

	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "SKILLSHOT")
	Dim lblMusic : Set lblMusic = FlexDMD.NewLabel("lblMusic", font, audioTracks(currentTrack)(1))
	Dim lblLeft : Set lblLeft = FlexDMD.NewLabel("lblLeft", bigFont, "<")
	Dim lblRight : Set lblRight = FlexDMD.NewLabel("lblRight", bigFont, ">")

	scene.AddActor lblTitle
	scene.AddActor lblMusic
	scene.AddActor lblLeft
	scene.AddActor lblRight
	
	lblLeft.SetAlignedPosition 3, 2, FlexDMD_Align_TopLeft
	lblRight.SetAlignedPosition 125, 2, FlexDMD_Align_TopRight
	lblTitle.SetAlignedPosition 64, 8, FlexDMD_Align_Center
	
	lblMusic.SetAlignedPosition -500, 0, FlexDMD_Align_TopLeft

	Dim afLeft : Set afLeft = lblLeft.ActionFactory
	dim blinkLeft : Set blinkLeft = afLeft.Sequence()
	blinkLeft.Add afLeft.Show(False)
	blinkLeft.Add afLeft.Wait(0.5)
	blinkLeft.Add afLeft.Show(True)
	blinkLeft.Add afLeft.Wait(0.5)
	lblLeft.AddAction afLeft.Repeat(blinkLeft, -1)

	Dim afRight : Set afRight = lblRight.ActionFactory
	dim blinkRight : Set blinkRight = afRight.Sequence()
	blinkRight.Add afRight.Show(False)
	blinkRight.Add afRight.Wait(0.5)
	blinkRight.Add afRight.Show(True)
	blinkRight.Add afRight.Wait(0.5)
	lblRight.AddAction afRight.Repeat(blinkRight, -1)


	Dim afMusic : Set afMusic = lblMusic.ActionFactory
	Dim list : Set list = afMusic.Sequence()
	list.Add afMusic.MoveTo(128, 22, 0)
	list.Add afMusic.Wait(0.5)
	list.Add afMusic.MoveTo(-128, 22, 5.0)
	list.Add afMusic.Show(False)
	lblMusic.AddAction afMusic.Repeat(list, 1)


	'scene.AddActor FlexDMD.NewLabel("Info", font, "Use Left and Right Magna" & vbLf & "to select Demo")
	'scene.GetLabel("Info").SetAlignedPosition 64, 32, FlexDMD_Align_Bottom

	'scene.AddActor FlexDMD.NewLabel("Left", bigFont, "<")
	'scene.AddActor FlexDMD.NewLabel("Right", bigFont, ">")
	'scene.GetLabel("Left").SetAlignedPosition 3, 32, FlexDMD_Align_BottomLeft
	'scene.GetLabel("Right").SetAlignedPosition 125, 32, FlexDMD_Align_BottomRight
	
	'Dim af
	'Set af = scene.GetLabel("Left").ActionFactory
	'dim blinkLeft : Set blinkLeft = af.Sequence()
	'blinkLeft.Add af.Show(False)
	'blinkLeft.Add af.Wait(0.5)
	'blinkLeft.Add af.Show(True)
	'blinkLeft.Add af.Wait(0.5)
	'scene.GetLabel("Left").AddAction af.Repeat(blinkLeft, -1)

	'Set af = scene.GetLabel("Right").ActionFactory
	'dim blinkRight : Set blinkRight = af.Sequence()
	'blinkRight.Add af.Show(True)
	'blinkRight.Add af.Wait(0.5)
	'blinkRight.Add af.Show(False)
	'blinkRight.Add af.Wait(0.5)
	'scene.GetLabel("Right").AddAction af.Repeat(blinkRight, -1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub

Sub FlexDMDCreateWelcomeScene()


	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor FlexDMD.NewVideo("videoplaying", "videos/attract.gif")
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread


	Exit Sub
	'DotMatrix.color = RGB(255, 88, 32)
	Dim scene : Set scene = FlexDMD.NewGroup("Welcome")
	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "...CYBERRACE...")
	Dim lblPressStart : Set lblPressStart = FlexDMD.NewLabel("lblPressStart", bigFont, "PRESS START")
	scene.AddActor lblTitle
	scene.AddActor lblPressStart
	
	lblTitle.SetBounds 0, 0, 128, 16
	lblPressStart.SetBounds 0, 16, 128, 16
	'lblPressStart.SetAlignedPosition 128, 32, FlexDMD_Align_Bottom

	Dim afPressStart
	Set afPressStart = lblPressStart.ActionFactory
	dim blinkLeft : Set blinkLeft = afPressStart.Sequence()
	blinkLeft.Add afPressStart.Show(False)
	blinkLeft.Add afPressStart.Wait(0.5)
	blinkLeft.Add afPressStart.Show(True)
	blinkLeft.Add afPressStart.Wait(0.5)
	lblPressStart.AddAction afPressStart.Repeat(blinkLeft, -1)


	'Dim afTitle : Set af = lblTitle.ActionFactory
	'Dim list : Set list = afTitle.Sequence()
	'list.Add afTitle.MoveTo(128, 0, 0)
	'list.Add afTitle.Wait(0.5)
	'list.Add afTitle.MoveTo(-128, 0, 3.0)
	'list.Add afTitle.Wait(0.5)
	'lblTitle.AddAction afTitle.Repeat(list, -1)


	'scene.AddActor FlexDMD.NewLabel("Info", font, "Use Left and Right Magna" & vbLf & "to select Demo")
	'scene.GetLabel("Info").SetAlignedPosition 64, 32, FlexDMD_Align_Bottom

	'scene.AddActor FlexDMD.NewLabel("Left", bigFont, "<")
	'scene.AddActor FlexDMD.NewLabel("Right", bigFont, ">")
	'scene.GetLabel("Left").SetAlignedPosition 3, 32, FlexDMD_Align_BottomLeft
	'scene.GetLabel("Right").SetAlignedPosition 125, 32, FlexDMD_Align_BottomRight
	
	'Dim af
	'Set af = scene.GetLabel("Left").ActionFactory
	'dim blinkLeft : Set blinkLeft = af.Sequence()
	'blinkLeft.Add af.Show(False)
	'blinkLeft.Add af.Wait(0.5)
	'blinkLeft.Add af.Show(True)
	'blinkLeft.Add af.Wait(0.5)
	'scene.GetLabel("Left").AddAction af.Repeat(blinkLeft, -1)

	'Set af = scene.GetLabel("Right").ActionFactory
	'dim blinkRight : Set blinkRight = af.Sequence()
	'blinkRight.Add af.Show(True)
	'blinkRight.Add af.Wait(0.5)
	'blinkRight.Add af.Show(False)
	'blinkRight.Add af.Wait(0.5)
	'scene.GetLabel("Right").AddAction af.Repeat(blinkRight, -1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub

'Dim audioBGTracks: Set gameLogic=CreateObject("Scripting.Dictionary")

Dim audioTracks, currentTrack, trackCount
audioTracks = Array(Array("500", "White Bat Audio - Glitch in Reality", "195600", "601"), Array("501", "Rob Avery - Untitled", "67200", "602"), Array("508", "WBA - Race Against Sunset", "206400", "603"),Array("509", "WBA - Existence", "212400", "604"))
currentTrack = RndNum(0,UBound(audioTracks))
trackCount = 0
'audioBGTracks.Add "E500", "White Bat Audio - Glitch in Reality"
'audioBGTracks.Add "E501", "Rob Avery - Untitled"

Sub PlayBGAudio

    If currentTrack > -1 Then
        Dim pupCode: pupCode = audioTracks(currentTrack)(0)
        pupevent pupCode
        trackCount=trackCount+1
        DisplayCurrentAudioTrack()
        vpmTimer.AddTimer audioTracks(currentTrack)(2), "vpmTimerNextTrack "&pupCode&","&trackCount&" '"
    End If

End Sub

Sub vpmTimerNextTrack(pupCode, count)
    Debug.print ">"&pupCode&"<"
    Debug.print ">"&count&"<"
    Debug.print ">"&trackCount&"<"
    If currentTrack > -1 Then
        If count = trackCount Then
            Debug.print "MAtch"
            PlayBGAudioNext()
        End If
    End If
End Sub

Sub PlayBGAudioNext()

    If currentTrack = -1 Then
        currentTrack = RndNum(0,UBound(audioTracks))
    End If

    'Debug.Print(currentTrack)
    'Debug.Print(UBound(audioTracks))
    currentTrack=currentTrack+1
    If currentTrack > UBound(audioTracks) Then
        currentTrack = 0
    End If

    PlayBGAudio()

End Sub

Sub StopBGAudio
    dim track
    for each track in audioTracks
        pupevent track(3)
    next
    currentTrack = -1
    pupevent 605'hurryup
    pupevent 503'hackers

End sub


Sub InitPupLabels
    if (usePUP=false or PUPStatus=false) then Exit Sub
    
    PuPlayer.LabelInit pBackglass
    Dim sendhaFont:sendhaFont="Sendha"

    'syntax - PuPlayer.LabelNew <screen# or pDMD>,<Labelname>,<fontName>,<size%>,<colour>,<rotation>,<xAlign>,<yAlign>,<xpos>,<ypos>,<PageNum>,<visible>
    'PuPlayer.LabelNew pBackglass,"Play1",sendhaFont,3,16777215,0,0,1,23,81,1,1

    '				    Scrn        LblName                 Fnt         Size	        Color	 		    R   Ax    Ay    X       Y           pagenum     Visible 
    'PuPlayer.LabelNew pBackglass,"Player"  ,sendhaFont,21*1,RGB(3, 57, 252)	,1,0,0, 0,0,	1,	0
    PuPlayer.LabelNew   pBackglass, "CurScore1",            sendhaFont,    8,           RGB(0, 255, 220),  0,  1,    1,    0,      0,          1,          1
    PuPlayer.LabelNew   pBackglass, "lblPlayer",            sendhaFont,    6,           RGB(0, 255, 220),  0,  0,    0,    26,     33,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblBall",              sendhaFont,    6,           RGB(0, 255, 220),  0,  0,    0,    63,     33,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblAug",               sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    PuPlayer.LabelNew   pBackglass, "lblPerk1",             sendhaFont,	4,              RGB(0, 255, 220),  0,  0,    0,    26,     60,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblPerk2",             sendhaFont,	4,              RGB(18, 155, 143),  0,  0,    0,    26,     65,         1,          1

    PuPlayer.LabelNew   pBackglass, "lblResearchNode",      sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     35,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblLocks",             sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     45,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblSpeeder",           sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     55,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblCombos",            sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     65,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblCombosMade",        sendhaFont,	4,              RGB(18, 155, 143),  0,  0,    0,    85,     70,         1,          1

    'PuPlayer.LabelNew   pBackglass, "lblE",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblS",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblE2",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblA",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblR2",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblC",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblH",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1

    PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\augLion.png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"
    PuPlayer.LabelSet   pBackglass, "lblPlayer",     "",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblBall",       "",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblPerk1",      "",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblPerk2",      "",                        1,  "{}"

    PuPlayer.LabelSet   pBackglass, "lblResearchNode",      "Research Nodes",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblLocks",      "Locks",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblSpeeder",      "Speeder Parts",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblCombos",      "Combos",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblCombosMade",      "0",                        1,  "{}"
    
End Sub
'***********************************************************************************************************************
'*****  PIN UP UPDATE SCORES                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Dim ScoreSize(4)

Sub pupDMDupdate_Timer()
	If gameStarted Then
		pUpdateScores
	End If
End Sub

'************************ called during gameplay to update Scores ***************************
Sub pUpdateScores  'call this ONLY on timer 300ms is good enough
    
	if (usePUP=false or PUPStatus=false) then Exit Sub

	Dim StatusStr
    Dim Size(4)
    Dim ScoreTag(4)
	

	StatusStr = ""
	'DebugScore = DebugScore + 1000000000

	Dim lenScore:lenScore = Len(DebugScore & "")
	Dim scoreScale:scoreScale=0.6
	If lenScore>10 Then
		scoreScale=scoreScale - ((lenScore-10)/20)
	End If
	ScoreSize(0) = 12*scoreScale

	'if PlayersPlayingGame>1 then ScoreSize(CurrentPlayer)=ScoreSize(CurrentPlayer)-(PlayersPlayingGame+.5)
	ScoreTag(0)="{'mt':2,'size':"& ScoreSize(0) &"}"
	'ScoreTag(1)="{'mt':2,'size':"& ScoreSize(1) &"}"
	'ScoreTag(2)="{'mt':2,'size':"& ScoreSize(2) &"}"
	'ScoreTag(3)="{'mt':2,'size':"& ScoreSize(3) &"}"


    'ScoreTag(CurrentPlayer)=""

	'puPlayer.LabelSet pBackglass,"Player",	"Player " & CurrentPlayer+1	,1,""
	'puPlayer.LabelSet pBackglass,"Ball",	"BALL " & Balls	 & "    "	,1,""
	'Select case PlayersPlayingGame
		'case 1:
		'	if Score(CurrentPlayer)=0 then 
		'		puPlayer.LabelSet pBackglass,"CurScore1", "00"								,1,ScoreTag(0)
		'	else
			'Debug.print("Updating Scores")
			If gameState("game")("hideScore") = False Then
				puPlayer.LabelSet pBackglass,"CurScore1", FormatScore(DebugScore)	 ,1,ScoreTag(0)
				PuPlayer.LabelSet pBackglass, "lblCombosMade",  gameState("game")("combosMade").Count & " / " & GameCombos.Count,                        1,  "{}"
			End If
		'	End if
		'case 2:
		'	PuPlayer.LabelSet pBackglass,"Play1score",FormatScore(Score(0)),1,ScoreTag(0)
		'	PuPlayer.LabelSet pBackglass,"Play2score",FormatScore(Score(1)),1,ScoreTag(1)
		'case 3:
		'	PuPlayer.LabelSet pBackglass,"Play1score",FormatScore(Score(0)),1,ScoreTag(0)
		'	PuPlayer.LabelSet pBackglass,"Play2score",FormatScore(Score(1)),1,ScoreTag(1)
		'	PuPlayer.LabelSet pBackglass,"Play3score",FormatScore(Score(2)),1,ScoreTag(2)
		'case 4:
		'	PuPlayer.LabelSet pBackglass,"Play1score",FormatScore(Score(0)),1,ScoreTag(0)
		'	PuPlayer.LabelSet pBackglass,"Play2score",FormatScore(Score(1)),1,ScoreTag(1)
		'	PuPlayer.LabelSet pBackglass,"Play3score",FormatScore(Score(2)),1,ScoreTag(2)
		'	PuPlayer.LabelSet pBackglass,"Play4score",FormatScore(Score(3)),1,ScoreTag(3)
	'End Select 

	'puPlayer.LabelSet pDMD,"Player",	"Player " & CurrentPlayer+1				,1,""
	'puPlayer.LabelSet pDMD,"Ball",		"Ball " & Balls							,1,""
	'puPlayer.LabelSet pDMD,"CurScore",	FormatScore(Score(CurrentPlayer))		,1,""
	'puPlayer.LabelSet pDMD,"Status",	StatusStr								,1,"1"
	'puPlayer.LabelSet pDMD,"Credits", 	"C  " & Credits							,1,""

end Sub

Function FormatScore(ByVal Num) 'it returns a string with commas
    dim i
    dim NumString
	
    NumString = CStr(abs(Num))

    For i = Len(NumString)-3 to 1 step -3
        if IsNumeric(mid(NumString, i, 1))then
            NumString = left(NumString, i) & "," & right(NumString, Len(NumString)-i)
        end if
    Next
    FormatScore = NumString
End function
'***********************************************************************************************************************
'*****  PIN UP                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


' COPY EVERYTHING BELOW TO THE TOP OF YOUR TABLE SCRIPT UNDER OPTION EXPLICIT

'****** PuP Variables ******

Dim cPuPPack: Dim PuPlayer: Dim PUPStatus: PUPStatus=false ' dont edit this line!!!

'*************************** PuP Settings for this table ********************************

cPuPPack = "cyberrace"    ' name of the PuP-Pack / PuPVideos folder for this table

'//////////////////// PINUP PLAYER: STARTUP & CONTROL SECTION //////////////////////////

' This is used for the startup and control of Pinup Player

Sub PuPStart(cPuPPack)
    If PUPStatus=true then Exit Sub
    If usePUP=true then
        Set PuPlayer = CreateObject("PinUpPlayer.PinDisplay")
        If PuPlayer is Nothing Then
            usePUP=false
            PUPStatus=false
        Else
            PuPlayer.B2SInit "",cPuPPack 'start the Pup-Pack
            PUPStatus=true
            InitPupLabels
        End If
    End If
End Sub

Sub pupevent(EventNum)
    if (usePUP=false or PUPStatus=false) then Exit Sub
    PuPlayer.B2SData "E"&EventNum,1  'send event to Pup-Pack
End Sub

' ******* How to use PUPEvent to trigger / control a PuP-Pack *******

' Usage: pupevent(EventNum)

' EventNum = PuP Exxx trigger from the PuP-Pack

' Example: pupevent 102

' This will trigger E102 from the table's PuP-Pack

' DO NOT use any Exxx triggers already used for DOF (if used) to avoid any possible confusion

'************ PuP-Pack Startup **************

PuPStart(cPuPPack) 'Check for PuP - If found, then start Pinup Player / PuP-Pack

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Backglass PUP / FlexDMD                             	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const TIMINGS_START_AUG_RESEARCH = "Timings Start Aug Research"
Const TIMINGS_COLLECT_AUGMENTATION = "Timings Collect Augmentation"
Const TIMINGS_BALL_LOCKED = "Timings Ball Locked"
Const TIMINGS_START_MULTIBALL = "Timings Smart Multiball"

Dim pupTimings: Set pupTimings=CreateObject("Scripting.Dictionary")
Dim dmdTimings: Set dmdTimings=CreateObject("Scripting.Dictionary")

pupTimings.Add TIMINGS_START_AUG_RESEARCH, 7000
dmdTimings.Add TIMINGS_START_AUG_RESEARCH, 1000

pupTimings.Add TIMINGS_COLLECT_AUGMENTATION, 10500
dmdTimings.Add TIMINGS_COLLECT_AUGMENTATION, 1000

pupTimings.Add TIMINGS_BALL_LOCKED, 3000
pupTimings.Add TIMINGS_START_MULTIBALL, 5000


Function Timings(tcode)
    If usePup = True Then
        Timings = pupTimings(tcode)
    Else
        Timings = dmdTimings(tcode)
    End If
End Function
Dim dbs1, dbs2, dbsdelta, dbstime, dbstens, dbsones, dbsdecimals
Sub EnableBallSaver(seconds)
	seconds = seconds + 0.3  'padding
	BallSaverTimerExpired.Interval = 1000 * seconds
	BallSaverTimerExpired.Enabled = True

	'p_watchdisplay_full.Visible = True
	p_watchdisplay_left.Visible = True
	p_watchdisplay_right.Visible = True

	LightBlink(lsBallSave)
	'Set display to x seconds 
	dbstime = seconds
	dbsdelta = .1
	BallSaverUpdateTimer.Interval = 100

	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
    BallSaverUpdateTimer.Enabled = True
End Sub

Sub StopBallSaver
	BallSaverTimerExpired.Enabled = False
	BallSaverUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
End Sub

Sub BallSaverTimerExpired_Timer()
    BallSaverTimerExpired.Enabled = False
    BallSaverUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
	DISPATCH GAME_BALL_SAVE_ENDED, null
End Sub

Sub ResetBallSaveDisplay
	p_watchdisplay_left.Visible = False
	p_watchdisplay_right.Visible = False
	p_watchdisplay_full.blenddisablelighting = 0
	p_watchdisplay_left.blenddisablelighting = 0
	p_watchdisplay_right.blenddisablelighting = 0
End Sub

Sub BallSaverUpdateTimer_Timer()
	Dim tmp
	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
End Sub
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
'*****  Light Change Item Class                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightChangeItem
	
	Private m_Frames, m_Idx, m_State, m_initialFrames,m_lampColor,m_image,m_baseImage

        Public Property Get Idx()
                Idx=m_Idx
        End Property

        Public Property Get BaseImage()
                BaseImage=m_baseImage
        End Property

        Public Property Get Image()
                Image=m_image
        End Property
        
	Public Property Let Image(input)
		m_image = input
	End Property

        Public Property Get State()
                State=m_State
        End Property

        Public Property Let State(input)
		m_State = input
	End Property

        Public Sub Blink()
                If m_State = 1 Then
                        m_State = 0
                Else
                        m_State = 1
                End If
                m_Frames = m_initialFrames
	End Sub

        Public Sub Init(idx, state, frames, baseImage)
                m_Idx = idx
                m_State = state
                m_Frames = frames
                m_initialFrames = frames
                m_lampColor = Null
                m_image = baseImage
                m_baseImage = baseImage                
	End Sub

	Public Property Let lampColor(input)
		m_lampColor = input
	End Property

        Public Property Get lampColor()
		lampColor = m_lampColor
	End Property

	Public Property Get Update(framesPassed)
                m_Frames = m_Frames - framesPassed
                
                If m_Idx = 21 Then
                        'Debug.print(m_Idx & ":" & m_Frames)
                        'Debug.print("Frames Passed: "& framesPassed)
                End If
                Update = m_Frames
        End Property

        Public Sub ResetFrames()
                m_Frames = m_initialFrames
        End Sub

End Class

'***********************************************************************************************************************
'*****  Light Seq Item Class                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightSeqItem
	
	Private m_currentIdx, m_sequence, m_name, m_image, m_lampColor,m_updateInterval, m_Frames

        Public Property Get CurrentIdx()
                CurrentIdx=m_currentIdx
        End Property

        Public Property Let CurrentIdx(input)
		m_currentIdx = input
	End Property

        Public Property Get Sequence()
                Sequence=m_sequence
        End Property
        
	Public Property Let Sequence(input)
		m_sequence = input
	End Property

        Public Property Get LampColor()
                LampColor=m_lampColor
        End Property
        
	Public Property Let LampColor(input)
		m_lampColor = input
	End Property

        Public Property Get Image()
                Image=m_image
        End Property
        
	Public Property Let Image(input)
		m_image = input
	End Property

        Public Property Get Name()
                Name=m_name
        End Property
        
	Public Property Let Name(input)
		m_name = input
	End Property        

        Public Property Get UpdateInterval()
                UpdateInterval=m_updateInterval
        End Property

        Public Property Let UpdateInterval(input)
		m_updateInterval = input
	End Property

        Private Sub Class_Initialize()
                m_currentIdx = 0
                m_image = Null
                m_lampColor = Null
                m_updateInterval = 100
        End Sub

        Public Property Get Update(framesPassed)
                m_Frames = m_Frames - framesPassed
                Update = m_Frames
        End Property

        Public Sub ResetFrames()
                m_Frames = m_updateInterval
        End Sub

End Class

'***********************************************************************************************************************
'*****  Light Seq Class                               	                                                            ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightSeq
	
	Private m_repeat, m_name, m_items,m_currentItemIdx,m_resetSequence

        Public Property Get Repeat()
                Repeat=m_repeat
        End Property

        Public Property Let Repeat(input)
		m_repeat = input
	End Property

        Public Property Get Name()
                Name=m_name
        End Property

        Public Property Get Items()
                Items=m_items.Items
        End Property
        
	Public Property Let Name(input)
		m_name = input
	End Property

        Public Property Get ResetSequence()
                ResetSequence=m_resetSequence
        End Property
        
	Public Property Let ResetSequence(input)
		Set m_resetSequence = input
	End Property

        Public Property Get CurrentItem()
                Dim items: items = m_items.Items()
                If UBound(items) = -1 Then       
                        CurrentItem  = Null
                Else
                        Set CurrentItem = items(m_currentItemIdx)                
                End If
	End Property

        Private Sub Class_Initialize()
                m_repeat = 0
                Set m_items = CreateObject("Scripting.Dictionary")
                m_currentItemIdx = 0
                m_resetSequence = Null
        End Sub

        Public Sub AddItem(item)
                If Not IsNull(item) Then
                        If Not m_items.Exists(item.Name) Then
                                m_items.Add item.Name, item
                        End If
                End If
        End Sub

        Public Sub RemoveAll()
                Dim x
                For Each x in items
                        RemoveItem(x)
                Next
        End Sub

        Public Sub RemoveItem(item)
                If Not IsNull(item) Then
                        If m_items.Exists(item.Name) Then
                                m_items.Remove item.Name
                                'DebugOut(item.Name)
                                Dim x
                                For Each x in item.Sequence
                                        If IsArray(x) Then
                                                Dim xx
                                                For Each xx in x
                                                        'DebugOut("Resetting IDX: " & xx.Idx)
                                                        Lampz.state(xx.Idx) = 0
                                                        Lampz.image(xx.Idx) = xx.BaseImage
                                                        xx.Image = xx.BaseImage
                                                Next
                                        Else
                                                'DebugOut("Resetting IDX: " & x.Idx)
                                                Lampz.state(x.Idx) = 0
                                                Lampz.image(x.Idx) = x.BaseImage
                                                x.Image = x.BaseImage
                                        End If
                                Next
                        End If
                End If
        End Sub

        Public Sub NextItem()
                m_currentItemIdx = m_currentItemIdx + 1
                Dim items: items = m_items.Items
                If m_currentItemIdx > UBound(items) Then
                        If Not IsNull(m_resetSequence) Then
                              AddItem(m_resetSequence)  
                              m_resetSequence = Null
                        Else
                                m_currentItemIdx = 0
                                
                                If m_repeat = 0 Then
                                        Dim x
                                        For Each x in items
                                                RemoveItem(x)
                                        Next
                                        m_items.RemoveAll
                                End If
                        End If
                End If
        End Sub

End Class
'***********************************************************************************************************************
'*****     In Game Light Sequences                            	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim lciResearchLit: Set lciResearchLit = New LightChangeItem
lciResearchLit.Init 25,1,180,"pal_purple"

Dim lsResearchReady: Set lsResearchReady = New LightChangeItem
lsResearchReady.Init 25,1,180,"pal_purple"
Dim lsResearchReadyOff: Set lsResearchReadyOff = New LightChangeItem
lsResearchReadyOff.Init 25,0,180,"pal_purple"

Dim lciHoldAug: Set lciHoldAug = New LightChangeItem
lciHoldAug.Init 30,1,180,"pal_purple"

Dim lsHoldAug: Set lsHoldAug = New LightChangeItem
lsHoldAug.Init 30,1,180,"pal_purple"
Dim lsHoldAugOff: Set lsHoldAugOff = New LightChangeItem
lsHoldAugOff.Init 30,0,180,"pal_purple"

Dim lsResearch1: Set lsResearch1 = New LightChangeItem
lsResearch1.Init 21,1,2000,"pal_blue"
Dim lsResearch1Off: Set lsResearch1Off = New LightChangeItem
lsResearch1Off.Init 21,0,180,"pal_blue"

Dim lsResearch2: Set lsResearch2 = New LightChangeItem
lsResearch2.Init 22,1,180,"pal_blue"
Dim lsResearch2Off: Set lsResearch2Off = New LightChangeItem
lsResearch2Off.Init 22,0,180,"pal_blue"

Dim lsResearch3: Set lsResearch3 = New LightChangeItem
lsResearch3.Init 23,0,180,"pal_blue"
Dim lsResearch3Off: Set lsResearch3Off = New LightChangeItem
lsResearch3Off.Init 23,0,180,"pal_blue"


Dim lciFinish: Set lciFinish = New LightChangeItem
lciFinish.Init 49,1,180,"pal_purple"
Dim lciFinishOff: Set lciFinishOff = New LightChangeItem
lciFinishOff.Init 49,0,180,"pal_purple"

Dim lsHyperJump: Set lsHyperJump = New LightChangeItem
lsHyperJump.Init 38,1,180,"pal_purple"





Dim lsShortcut: Set lsShortcut = New LightChangeItem
lsShortcut.Init 37,1,180,"pal_purple"
Dim lsShortcutOff: Set lsShortcutOff = New LightChangeItem
lsShortcutOff.Init 37,0,180,"pal_purple"







Dim lsAug1: Set lsAug1 = New LightChangeItem
lsAug1.Init 0,1,180,"pal_blue"
Dim lsAug1Off: Set lsAug1Off = New LightChangeItem
lsAug1Off.Init 0,0,180,"pal_blue"

Dim lsAug2: Set lsAug2 = New LightChangeItem
lsAug2.Init 3,1,180,"pal_blue"
Dim lsAug2Off: Set lsAug2Off = New LightChangeItem
lsAug2Off.Init 3,0,180,"pal_blue"

Dim lsAug3: Set lsAug3 = New LightChangeItem
lsAug3.Init 6,1,180,"pal_blue"
Dim lsAug3Off: Set lsAug3Off = New LightChangeItem
lsAug3Off.Init 6,0,180,"pal_blue"

Dim lsAug4: Set lsAug4 = New LightChangeItem
lsAug4.Init 1,4,180,"pal_blue"
Dim lsAug4Off: Set lsAug4Off = New LightChangeItem
lsAug4Off.Init 1,0,180,"pal_blue"

Dim lsAug5: Set lsAug5 = New LightChangeItem
lsAug5.Init 4,1,180,"pal_blue"
Dim lsAug5Off: Set lsAug5Off = New LightChangeItem
lsAug5Off.Init 4,0,180,"pal_blue"

Dim lsAug6: Set lsAug6 = New LightChangeItem
lsAug6.Init 7,1,180,"pal_blue"
Dim lsAug6Off: Set lsAug6Off = New LightChangeItem
lsAug6Off.Init 7,0,180,"pal_blue"

Dim lsAug7: Set lsAug7 = New LightChangeItem
lsAug7.Init 2,4,180,"pal_blue"
Dim lsAug7Off: Set lsAug7Off = New LightChangeItem
lsAug7Off.Init 2,0,180,"pal_blue"

Dim lsAug8: Set lsAug8 = New LightChangeItem
lsAug8.Init 5,1,180,"pal_blue"
Dim lsAug8Off: Set lsAug8Off = New LightChangeItem
lsAug8Off.Init 5,0,180,"pal_blue"

Dim lsAug9: Set lsAug9 = New LightChangeItem
lsAug9.Init 8,1,180,"pal_blue"
Dim lsAug9Off: Set lsAug9Off = New LightChangeItem
lsAug9Off.Init 8,0,180,"pal_blue"

Dim lSeqAugmentationFlicker: Set lSeqAugmentationFlicker = new LightSeqItem
lSeqAugmentationFlicker.Name = "lSeqAugmentationFlicker"
lSeqAugmentationFlicker.Image = "pal_blue"
lSeqAugmentationFlicker.Sequence = Array(Array(lsAug1Off,lsAug2Off,lsAug3Off,lsAug4Off,lsAug5Off,lsAug6Off,lsAug7Off,lsAug8Off,lsAug9Off),lsAug1,lsAug2,lsAug3, Array(lsAug1Off,lsAug4),Array(lsAug2Off,lsAug5),Array(lsAug3Off,lsAug6),Array(lsAug4Off,lsAug7),Array(lsAug5Off,lsAug8),Array(lsAug6Off,lsAug9),lsAug7Off,lsAug8Off,lsAug9Off)
lSeqAugmentationFlicker.UpdateInterval = 20

Dim lSeqAugmentation: Set lSeqAugmentation = new LightSeq
lSeqAugmentation.Name = "lSeqAugmentation"

Dim lsBallSaverClock1: Set lsBallSaverClock1 = New LightChangeItem
lsBallSaverClock1.Init 130,1,120,"pal_purple"
Dim lsBallSaverClock1Off: Set lsBallSaverClock1Off = New LightChangeItem
lsBallSaverClock1Off.Init 130,0,120,"pal_purple"

Dim lsBallSaverClock2: Set lsBallSaverClock2 = New LightChangeItem
lsBallSaverClock2.Init 131,1,120,"pal_purple"
Dim lsBallSaverClock2Off: Set lsBallSaverClock2Off = New LightChangeItem
lsBallSaverClock2Off.Init 131,0,120,"pal_purple"

Dim lsBallSaverClock3: Set lsBallSaverClock3 = New LightChangeItem
lsBallSaverClock3.Init 132,1,120,"pal_purple"
Dim lsBallSaverClock3Off: Set lsBallSaverClock3Off = New LightChangeItem
lsBallSaverClock3Off.Init 132,0,120,"pal_purple"

Dim lsBallSave: Set lsBallSave = New LightChangeItem
lsBallSave.Init 123,1,120,"pal_purple"
Dim lsBallSaveOff: Set lsBallSaveOff = New LightChangeItem
lsBallSaveOff.Init 123,0,120,"pal_purple"
Dim lsBet1: Set lsBet1 = New LightChangeItem
lsBet1.Init 9,1,140,"pal_yellow"
Dim lsBet1Off: Set lsBet1Off = New LightChangeItem
lsBet1Off.Init 9,0,140,"pal_yellow"

Dim lsBet2: Set lsBet2 = New LightChangeItem
lsBet2.Init 10,1,140,"pal_yellow"
Dim lsBet2Off: Set lsBet2Off = New LightChangeItem
lsBet2Off.Init 10,0,140,"pal_yellow"

Dim lsBet3: Set lsBet3 = New LightChangeItem
lsBet3.Init 11,1,140,"pal_yellow"
Dim lsBet3Off: Set lsBet3Off = New LightChangeItem
lsBet3Off.Init 11,0,140,"pal_yellow"

Dim lsBonus1: Set lsBonus1 = New LightChangeItem
lsBonus1.Init 107,1,20,"pal_purple"
Dim lsBonus1Off: Set lsBonus1Off = New LightChangeItem
lsBonus1Off.Init 107,0,20,"pal_purple"

Dim lsBonus2: Set lsBonus2 = New LightChangeItem
lsBonus2.Init 108,1,20,"pal_purple"
Dim lsBonus2Off: Set lsBonus2Off = New LightChangeItem
lsBonus2Off.Init 108,0,20,"pal_purple"

Dim lsBonus3: Set lsBonus3 = New LightChangeItem
lsBonus3.Init 109,1,20,"pal_purple"
Dim lsBonus3Off: Set lsBonus3Off = New LightChangeItem
lsBonus3Off.Init 109,0,20,"pal_purple"



Dim lsBump1flash: Set lsBump1flash = New LightChangeItem
lsBump1flash.Init 40,1,80,"pal_purple"

Dim lsBump1flashOff: Set lsBump1flashOff = New LightChangeItem
lsBump1flashOff.Init 40,0,80,"pal_purple"

Dim lsBump2flash: Set lsBump2flash = New LightChangeItem
lsBump2flash.Init 41,1,80,"pal_purple"

Dim lsBump2flashOff: Set lsBump2flashOff = New LightChangeItem
lsBump2flashOff.Init 41,0,80,"pal_purple"

Dim lsBump3flash: Set lsBump3flash = New LightChangeItem
lsBump3flash.Init 42,1,80,"pal_purple"

Dim lsBump3flashOff: Set lsBump3flashOff = New LightChangeItem
lsBump3flashOff.Init 42,0,80,"pal_purple"

Dim lSeqBumpersActiveShot: Set lSeqBumpersActiveShot = new LightSeqItem
lSeqBumpersActiveShot.Name = "lSeqBumpersActiveShot"
lSeqBumpersActiveShot.LampColor = gameColors(0)
lSeqBumpersActiveShot.Sequence = Array(Array(lsBump1flash,lsBump2flash,lsBump3flash), Array(lsBump1flashOff,lsBump2flashOff,lsBump3flashOff))
lSeqBumpersActiveShot.UpdateInterval = 80


Dim lSeqBumper1HitFlash: Set lSeqBumper1HitFlash = new LightSeqItem
lSeqBumper1HitFlash.Name = "lSeqBumper1HitFlash"
lSeqBumper1HitFlash.Sequence = Array(lsBump1flash, lsBump1flashOff)
lSeqBumper1HitFlash.UpdateInterval = 40

Dim lSeqBumper2HitFlash: Set lSeqBumper2HitFlash = new LightSeqItem
lSeqBumper2HitFlash.Name = "lSeqBumper2HitFlash"
lSeqBumper2HitFlash.Sequence = Array(lsBump2flash, lsBump2flashOff)
lSeqBumper2HitFlash.UpdateInterval = 40

Dim lSeqBumper3HitFlash: Set lSeqBumper3HitFlash = new LightSeqItem
lSeqBumper3HitFlash.Name = "lSeqBumper3HitFlash"
lSeqBumper3HitFlash.Sequence = Array(lsBump3flash, lsBump3flashOff)
lSeqBumper3HitFlash.UpdateInterval = 40


Dim lSeqBumpers: Set lSeqBumpers = new LightSeq
lSeqBumpers.Name = "lSeqBumpers"
lSeqBumpers.Repeat = 1

Dim lSeqBumpersFlash: Set lSeqBumpersFlash = new LightSeq
lSeqBumpersFlash.Name = "lSeqBumpersFlash"
Dim lsCaptive1: Set lsCaptive1 = New LightChangeItem
lsCaptive1.Init 26,1,20,"pal_purple"
Dim lsCaptive1Off: Set lsCaptive1Off = New LightChangeItem
lsCaptive1Off.Init 26,0,20,"pal_purple"

Dim lsCaptive2: Set lsCaptive2 = New LightChangeItem
lsCaptive2.Init 27,1,20,"pal_purple"
Dim lsCaptive2Off: Set lsCaptive2Off = New LightChangeItem
lsCaptive2Off.Init 27,0,20,"pal_purple"

Dim lsCaptive3: Set lsCaptive3 = New LightChangeItem
lsCaptive3.Init 28,1,20,"pal_purple"
Dim lsCaptive3Off: Set lsCaptive3Off = New LightChangeItem
lsCaptive3Off.Init 28,0,20,"pal_purple"

Dim lsCaptive4: Set lsCaptive4 = New LightChangeItem
lsCaptive4.Init 29,1,20,"pal_purple"
Dim lsCaptive4Off: Set lsCaptive4Off = New LightChangeItem
lsCaptive4Off.Init 29,0,20,"pal_purple"

Dim lsAugSign1: Set lsAugSign1 = New LightChangeItem
lsAugSign1.Init 15,1,100,"pal_red_darker"
Dim lsAugSign1Off: Set lsAugSign1Off = New LightChangeItem
lsAugSign1Off.Init 15,0,100,"pal_red_darker"

Dim lsAugSign2: Set lsAugSign2 = New LightChangeItem
lsAugSign2.Init 16,1,100,"pal_red_darker"
Dim lsAugSign2Off: Set lsAugSign2Off = New LightChangeItem
lsAugSign2Off.Init 16,0,100,"pal_red_darker"

Dim lsAugSign3: Set lsAugSign3 = New LightChangeItem
lsAugSign3.Init 17,1,100,"pal_red_darker"
Dim lsAugSign3Off: Set lsAugSign3Off = New LightChangeItem
lsAugSign3Off.Init 17,0,100,"pal_red_darker"

Dim lsAugSign4: Set lsAugSign4 = New LightChangeItem
lsAugSign4.Init 18,1,100,"pal_red_darker"
Dim lsAugSign4Off: Set lsAugSign4Off = New LightChangeItem
lsAugSign4Off.Init 18,0,100,"pal_red_darker"

Dim lsAugSign5: Set lsAugSign5 = New LightChangeItem
lsAugSign5.Init 19,1,100,"pal_red_darker"
Dim lsAugSign5Off: Set lsAugSign5Off = New LightChangeItem
lsAugSign5Off.Init 19,0,100,"pal_red_darker"


Dim lSeqCaptiveAugHold: Set lSeqCaptiveAugHold = new LightSeqItem
lSeqCaptiveAugHold.Name = "lSeqCaptiveAugHold"
lSeqCaptiveAugHold.Image = "pal_purple"
lSeqCaptiveAugHold.Sequence = Array(lsCaptive4,lsCaptive3,Array(lsCaptive4Off,lsCaptive2),Array(lsCaptive3Off,lsCaptive1),lsCaptive2Off, lsCaptive1Off)
lSeqCaptiveAugHold.UpdateInterval = 60

Dim lSeqCaptive: Set lSeqCaptive = new LightSeq
lSeqCaptive.Name = "lSeqCaptive"
lSeqCaptive.Repeat = 1


Dim lsCenterRamp: Set lsCenterRamp = New LightChangeItem
lsCenterRamp.Init 34,1,180,"pal_purple"
Dim lsCenterRampOff: Set lsCenterRampOff = New LightChangeItem
lsCenterRampOff.Init 34,0,180,"pal_purple"

Dim lSeqCenterRampActiveShot: Set lSeqCenterRampActiveShot = new LightSeqItem
lSeqCenterRampActiveShot.Name = "lSeqCenterRampActiveShot"
lSeqCenterRampActiveShot.Image = "pal_purple"
lSeqCenterRampActiveShot.Sequence = Array(lsCenterRamp,lsCenterRampOff)

Dim lSeqCenterRamp: Set lSeqCenterRamp = new LightSeq
lSeqCenterRamp.Name = "lSeqCenterRamp"
lSeqCenterRamp.Repeat = 1
Dim lsCombo1: Set lsCombo1 = New LightChangeItem
lsCombo1.Init 115,1,100,"pal_purple"
Dim lsCombo1Off: Set lsCombo1Off = New LightChangeItem
lsCombo1Off.Init 115,0,100,"pal_purple"

Dim lsCombo2: Set lsCombo2 = New LightChangeItem
lsCombo2.Init 116,1,100,"pal_purple"
Dim lsCombo2Off: Set lsCombo2Off = New LightChangeItem
lsCombo2Off.Init 116,0,100,"pal_purple"

Dim lsCombo3: Set lsCombo3 = New LightChangeItem
lsCombo3.Init 117,1,100,"pal_purple"
Dim lsCombo3Off: Set lsCombo3Off = New LightChangeItem
lsCombo3Off.Init 117,0,100,"pal_purple"

Dim lsCombo4: Set lsCombo4 = New LightChangeItem
lsCombo4.Init 118,1,100,"pal_purple"
Dim lsCombo4Off: Set lsCombo4Off = New LightChangeItem
lsCombo4Off.Init 118,0,100,"pal_purple"

Dim lsCombo5: Set lsCombo5 = New LightChangeItem
lsCombo5.Init 119,1,100,"pal_purple"
Dim lsCombo5Off: Set lsCombo5Off = New LightChangeItem
lsCombo5Off.Init 119,0,100,"pal_purple"

Dim lsCyber1: Set lsCyber1 = New LightChangeItem
lsCyber1.Init 110,1,20,"pal_green"
Dim lsCyber1Off: Set lsCyber1Off = New LightChangeItem
lsCyber1Off.Init 110,0,20,"pal_green"

Dim lsCyber2: Set lsCyber2 = New LightChangeItem
lsCyber2.Init 111,1,20,"pal_green"
Dim lsCyber2Off: Set lsCyber2Off = New LightChangeItem
lsCyber2Off.Init 111,0,20,"pal_green"

Dim lsCyber3: Set lsCyber3 = New LightChangeItem
lsCyber3.Init 112,1,20,"pal_green"
Dim lsCyber3Off: Set lsCyber3Off = New LightChangeItem
lsCyber3Off.Init 112,0,20,"pal_green"

Dim lsCyber4: Set lsCyber4 = New LightChangeItem
lsCyber4.Init 113,1,20,"pal_green"
Dim lsCyber4Off: Set lsCyber4Off = New LightChangeItem
lsCyber4Off.Init 113,0,20,"pal_green"

Dim lsCyber5: Set lsCyber5 = New LightChangeItem
lsCyber5.Init 114,1,20,"pal_green"
Dim lsCyber5Off: Set lsCyber5Off = New LightChangeItem
lsCyber5Off.Init 114,0,20,"pal_green"

Dim olr1a: Set olr1a = New LightChangeItem
olr1a.Init 50,1,20,"pal_purple"
Dim olr1b: Set olr1b = new LightChangeItem
olr1b.Init 51,1,20,"pal_purple"

Dim olr1aOff: Set olr1aOff = New LightChangeItem
olr1aOff.Init 50,0,20,"pal_purple"
Dim olr1bOff: Set olr1bOff = new LightChangeItem
olr1bOff.Init 51,0,20,"pal_purple"

Dim olr2a: Set olr2a = New LightChangeItem
olr2a.Init 52,1,20,"pal_purple"
Dim olr2b: Set olr2b = new LightChangeItem
olr2b.Init 53,1,20,"pal_purple"

Dim olr2aOff: Set olr2aOff = New LightChangeItem
olr2aOff.Init 52,0,20,"pal_purple"
Dim olr2bOff: Set olr2bOff = new LightChangeItem
olr2bOff.Init 53,0,20,"pal_purple"

Dim olr3a: Set olr3a = New LightChangeItem
olr3a.Init 54,1,20,"pal_purple"
Dim olr3b: Set olr3b = new LightChangeItem
olr3b.Init 55,1,20,"pal_purple"

Dim olr3aOff: Set olr3aOff = New LightChangeItem
olr3aOff.Init 54,0,20,"pal_purple"
Dim olr3bOff: Set olr3bOff = new LightChangeItem
olr3bOff.Init 55,0,20,"pal_purple"

Dim olr4a: Set olr4a = New LightChangeItem
olr4a.Init 56,1,20,"pal_purple"
Dim olr4b: Set olr4b = new LightChangeItem
olr4b.Init 57,1,20,"pal_purple"

Dim olr4aOff: Set olr4aOff = New LightChangeItem
olr4aOff.Init 56,0,20,"pal_purple"
Dim olr4bOff: Set olr4bOff = new LightChangeItem
olr4bOff.Init 57,0,20,"pal_purple"

Dim olr5a: Set olr5a = New LightChangeItem
olr5a.Init 58,1,20,"pal_purple"
Dim olr5b: Set olr5b = new LightChangeItem
olr5b.Init 59,1,20,"pal_purple"

Dim olr5aOff: Set olr5aOff = New LightChangeItem
olr5aOff.Init 58,0,20,"pal_purple"
Dim olr5bOff: Set olr5bOff = new LightChangeItem
olr5bOff.Init 59,0,20,"pal_purple"

Dim olr6a: Set olr6a = New LightChangeItem
olr6a.Init 60,1,20,"pal_purple"
Dim olr6b: Set olr6b = new LightChangeItem
olr6b.Init 61,1,20,"pal_purple"

Dim olr6aOff: Set olr6aOff = New LightChangeItem
olr6aOff.Init 60,0,20,"pal_purple"
Dim olr6bOff: Set olr6bOff = new LightChangeItem
olr6bOff.Init 61,0,20,"pal_purple"

Dim olr7a: Set olr7a = New LightChangeItem
olr7a.Init 62,1,20,"pal_purple"
Dim olr7b: Set olr7b = new LightChangeItem
olr7b.Init 63,1,20,"pal_purple"

Dim olr7aOff: Set olr7aOff = New LightChangeItem
olr7aOff.Init 62,0,20,"pal_purple"
Dim olr7bOff: Set olr7bOff = new LightChangeItem
olr7bOff.Init 63,0,20,"pal_purple"

Dim olr8a: Set olr8a = New LightChangeItem
olr8a.Init 64,1,20,"pal_purple"
Dim olr8b: Set olr8b = new LightChangeItem
olr8b.Init 65,1,20,"pal_purple"

Dim olr8aOff: Set olr8aOff = New LightChangeItem
olr8aOff.Init 64,0,20,"pal_purple"
Dim olr8bOff: Set olr8bOff = new LightChangeItem
olr8bOff.Init 65,0,20,"pal_purple"

Dim olr9a: Set olr9a = New LightChangeItem
olr9a.Init 66,1,20,"pal_purple"
Dim olr9b: Set olr9b = new LightChangeItem
olr9b.Init 67,1,20,"pal_purple"

Dim olr9aOff: Set olr9aOff = New LightChangeItem
olr9aOff.Init 66,0,20,"pal_purple"
Dim olr9bOff: Set olr9bOff = new LightChangeItem
olr9bOff.Init 67,0,20,"pal_purple"

Dim oll1a: Set oll1a = New LightChangeItem
oll1a.Init 70,1,20,"pal_purple"
Dim oll1b: Set oll1b = new LightChangeItem
oll1b.Init 71,1,20,"pal_purple"

Dim oll1aOff: Set oll1aOff = New LightChangeItem
oll1aOff.Init 70,0,20,"pal_purple"
Dim oll1bOff: Set oll1bOff = new LightChangeItem
oll1bOff.Init 71,0,20,"pal_purple"

Dim oll2a: Set oll2a = New LightChangeItem
oll2a.Init 72,1,20,"pal_purple"
Dim oll2b: Set oll2b = new LightChangeItem
oll2b.Init 73,1,20,"pal_purple"

Dim oll2aOff: Set oll2aOff = New LightChangeItem
oll2aOff.Init 72,0,20,"pal_purple"
Dim oll2bOff: Set oll2bOff = new LightChangeItem
oll2bOff.Init 73,0,20,"pal_purple"

Dim oll3a: Set oll3a = New LightChangeItem
oll3a.Init 74,1,20,"pal_purple"
Dim oll3b: Set oll3b = new LightChangeItem
oll3b.Init 75,1,20,"pal_purple"

Dim oll3aOff: Set oll3aOff = New LightChangeItem
oll3aOff.Init 74,0,20,"pal_purple"
Dim oll3bOff: Set oll3bOff = new LightChangeItem
oll3bOff.Init 75,0,20,"pal_purple"

Dim oll4a: Set oll4a = New LightChangeItem
oll4a.Init 76,1,20,"pal_purple"
Dim oll4b: Set oll4b = new LightChangeItem
oll4b.Init 77,1,20,"pal_purple"

Dim oll4aOff: Set oll4aOff = New LightChangeItem
oll4aOff.Init 76,0,20,"pal_purple"
Dim oll4bOff: Set oll4bOff = new LightChangeItem
oll4bOff.Init 77,0,20,"pal_purple"

Dim oll5a: Set oll5a = New LightChangeItem
oll5a.Init 78,1,20,"pal_purple"
Dim oll5b: Set oll5b = new LightChangeItem
oll5b.Init 79,1,20,"pal_purple"

Dim oll5aOff: Set oll5aOff = New LightChangeItem
oll5aOff.Init 78,0,20,"pal_purple"
Dim oll5bOff: Set oll5bOff = new LightChangeItem
oll5bOff.Init 79,0,20,"pal_purple"

Dim oll6a: Set oll6a = New LightChangeItem
oll6a.Init 80,1,20,"pal_purple"
Dim oll6b: Set oll6b = new LightChangeItem
oll6b.Init 81,1,20,"pal_purple"

Dim oll6aOff: Set oll6aOff = New LightChangeItem
oll6aOff.Init 80,0,20,"pal_purple"
Dim oll6bOff: Set oll6bOff = new LightChangeItem
oll6bOff.Init 81,0,20,"pal_purple"

Dim oll7a: Set oll7a = New LightChangeItem
oll7a.Init 82,1,20,"pal_purple"
Dim oll7b: Set oll7b = new LightChangeItem
oll7b.Init 83,1,20,"pal_purple"

Dim oll7aOff: Set oll7aOff = New LightChangeItem
oll7aOff.Init 82,0,20,"pal_purple"
Dim oll7bOff: Set oll7bOff = new LightChangeItem
oll7bOff.Init 83,0,20,"pal_purple"

Dim oll8a: Set oll8a = New LightChangeItem
oll8a.Init 84,1,20,"pal_purple"
Dim oll8b: Set oll8b = new LightChangeItem
oll8b.Init 85,1,20,"pal_purple"

Dim oll8aOff: Set oll8aOff = New LightChangeItem
oll8aOff.Init 84,0,20,"pal_purple"
Dim oll8bOff: Set oll8bOff = new LightChangeItem
oll8bOff.Init 85,0,20,"pal_purple"

Dim oll9a: Set oll9a = New LightChangeItem
oll9a.Init 86,1,20,"pal_purple"
Dim oll9b: Set oll9b = new LightChangeItem
oll9b.Init 87,1,20,"pal_purple"

Dim oll9aOff: Set oll9aOff = New LightChangeItem
oll9aOff.Init 86,0,20,"pal_purple"
Dim oll9bOff: Set oll9bOff = new LightChangeItem
oll9bOff.Init 87,0,20,"pal_purple"


Dim lSeqLeftDrainBlink: Set lSeqLeftDrainBlink = new LightSeqItem
lSeqLeftDrainBlink.Name = "lSeqLeftDrainBlink"
lSeqLeftDrainBlink.Image = "pal_red_darker"
lSeqLeftDrainBlink.Sequence = Array(Array(oll1a,oll1b),Array(oll2a,oll2b),Array(oll1aOff,oll1bOff,oll3a,oll3b),Array(oll2aOff,oll2bOff,oll4a,oll4b),Array(oll3aOff,oll3bOff,oll5a,oll5b), Array(oll4aOff,oll4bOff,oll6a,oll6b),Array(oll5aOff,oll5bOff,oll7a,oll7b),Array(oll6aOff,oll6bOff,oll8a,oll8b),Array(oll7aOff,oll7bOff,oll9a,oll9b),Array(oll8aOff,oll8bOff),Array(oll9aOff,oll9bOff))
lSeqLeftDrainBlink.UpdateInterval = 20

Dim lSeqRightDrainBlink: Set lSeqRightDrainBlink = new LightSeqItem
lSeqRightDrainBlink.Name = "lSeqRightDrainBlink"
lSeqRightDrainBlink.Image = "pal_red_darker"
lSeqRightDrainBlink.Sequence = Array(Array(olr1a,olr1b),Array(olr2a,olr2b),Array(olr1aOff,olr1bOff,olr3a,olr3b),Array(olr2aOff,olr2bOff,olr4a,olr4b),Array(olr3aOff,olr3bOff,olr5a,olr5b), Array(olr4aOff,olr4bOff,olr6a,olr6b),Array(olr5aOff,olr5bOff,olr7a,olr7b),Array(olr6aOff,olr6bOff,olr8a,olr8b),Array(olr7aOff,olr7bOff,olr9a,olr9b),Array(olr8aOff,olr8bOff),Array(olr9aOff,olr9bOff))
lSeqRightDrainBlink.UpdateInterval = 20

Dim lSeqLeftDrain: Set lSeqLeftDrain = new LightSeq
lSeqLeftDrain.Name = "lSeqLeftDrain"

Dim lSeqRightDrain: Set lSeqRightDrain = new LightSeq
lSeqRightDrain.Name = "lSeqRightDrain"
Dim lsExtraBall: Set lsExtraBall = New LightChangeItem
lsExtraBall.Init 97,1,20,"pal_purple"
Dim lsExtraBallOff: Set lsExtraBallOff = New LightChangeItem
lsExtraBallOff.Init 97,0,20,"pal_purple"

Dim lsHyperJump1: Set lsHyperJump1 = New LightChangeItem
lsHyperJump1.Init 38,1,80,"pal_purple"
Dim lsHyperJump1Off: Set lsHyperJump1Off = New LightChangeItem
lsHyperJump1Off.Init 38,0,80,"pal_purple"

Dim lsHyperJump2: Set lsHyperJump2 = New LightChangeItem
lsHyperJump2.Init 45,1,80,"pal_purple"
Dim lsHyperJump2Off: Set lsHyperJump2Off = New LightChangeItem
lsHyperJump2Off.Init 45,0,80,"pal_purple"

Dim lsHyperJump3: Set lsHyperJump3 = New LightChangeItem
lsHyperJump3.Init 43,1,80,"pal_purple"
Dim lsHyperJump3Off: Set lsHyperJump3Off = New LightChangeItem
lsHyperJump3Off.Init 43,0,80,"pal_purple"

Dim lsHyperJump4: Set lsHyperJump4 = New LightChangeItem
lsHyperJump4.Init 44,1,80,"pal_purple"
Dim lsHyperJump4Off: Set lsHyperJump4Off = New LightChangeItem
lsHyperJump4Off.Init 44,0,80,"pal_purple"

Dim lsHyperJump5: Set lsHyperJump5 = New LightChangeItem
lsHyperJump5.Init 68,1,80,"pal_purple"
Dim lsHyperJump5Off: Set lsHyperJump5Off = New LightChangeItem
lsHyperJump5Off.Init 68,0,80,"pal_purple"

Dim lSeqHyperJumpActiveShot: Set lSeqHyperJumpActiveShot = new LightSeqItem
lSeqHyperJumpActiveShot.Name = "lSeqHyperJumpActiveShot"
lSeqHyperJumpActiveShot.Image = "pal_purple"
lSeqHyperJumpActiveShot.Sequence = Array(lsHyperJump5,lsHyperJump4,Array(lsHyperJump5Off,lsHyperJump3),Array(lsHyperJump4Off,lsHyperJump2),Array(lsHyperJump3Off,lsHyperJump1),lsHyperJump2Off, lsHyperJump1Off)
lSeqHyperJumpActiveShot.UpdateInterval = 60

Dim lSeqHyperJump: Set lSeqHyperJump = new LightSeq
lSeqHyperJump.Name = "lSeqHyperJump"
lSeqHyperJump.Repeat = 1
Dim lsLane1: Set lsLane1 = New LightChangeItem
lsLane1.Init 90,1,180,"pal_orange2"
Dim lsLane1Off: Set lsLane1Off = New LightChangeItem
lsLane1Off.Init 90,0,180,"pal_orange2"

Dim lsLane2: Set lsLane2 = New LightChangeItem
lsLane2.Init 91,1,180,"pal_orange2"
Dim lsLane2Off: Set lsLane2Off = New LightChangeItem
lsLane2Off.Init 91,0,180,"pal_orange2"

Dim lsLane3: Set lsLane3 = New LightChangeItem
lsLane3.Init 92,1,180,"pal_orange2"
Dim lsLane3Off: Set lsLane3Off = New LightChangeItem
lsLane3Off.Init 92,0,180,"pal_orange2"

Dim lsLane4: Set lsLane4 = New LightChangeItem
lsLane4.Init 93,1,180,"pal_orange2"
Dim lsLane4Off: Set lsLane4Off = New LightChangeItem
lsLane4Off.Init 93,0,180,"pal_orange2"



Dim lsLeftOrbit: Set lsLeftOrbit = New LightChangeItem
lsLeftOrbit.Init 31,1,180,"pal_purple"
Dim lsLeftOrbitOff: Set lsLeftOrbitOff = New LightChangeItem
lsLeftOrbitOff.Init 31,0,180,"pal_purple"

Dim lSeqLeftOrbitActiveShot: Set lSeqLeftOrbitActiveShot = new LightSeqItem
lSeqLeftOrbitActiveShot.Name = "lSeqLeftOrbitActiveShot"
lSeqLeftOrbitActiveShot.Image = "pal_purple"
lSeqLeftOrbitActiveShot.Sequence = Array(lsLeftOrbit,lsLeftOrbitOff)

Dim lSeqLeftOrbit: Set lSeqLeftOrbit = new LightSeq
lSeqLeftOrbit.Name = "lSeqLeftOrbit"
lSeqLeftOrbit.Repeat = 1


Dim lsLeftRamp: Set lsLeftRamp = New LightChangeItem
lsLeftRamp.Init 32,1,180,"pal_purple"
Dim lsLeftRampOff: Set lsLeftRampOff = New LightChangeItem
lsLeftRampOff.Init 32,0,180,"pal_purple"

Dim lSeqLeftRampActiveShot: Set lSeqLeftRampActiveShot = new LightSeqItem
lSeqLeftRampActiveShot.Name = "lSeqLeftRampActiveShot"
lSeqLeftRampActiveShot.Image = "pal_purple"
lSeqLeftRampActiveShot.Sequence = Array(lsLeftRamp,lsLeftRampOff)

Dim lSeqLeftRamp: Set lSeqLeftRamp = new LightSeq
lSeqLeftRamp.Name = "lSeqLeftRamp"
lSeqLeftRamp.Repeat = 1
Dim lsLightLock: Set lsLightLock = New LightChangeItem
lsLightLock.Init 98,1,180,"pal_green"
Dim lsLightLockOff: Set lsLightLockOff = New LightChangeItem
lsLightLockOff.Init 98,0,180,"pal_green"

Dim lsPlayfield1: Set lsPlayfield1 = New LightChangeItem
lsPlayfield1.Init 94,1,20,"pal_purple"
Dim lsPlayfield1Off: Set lsPlayfield1Off = New LightChangeItem
lsPlayfield1Off.Init 94,0,20,"pal_purple"

Dim lsPlayfield2: Set lsPlayfield2 = New LightChangeItem
lsPlayfield2.Init 95,1,20,"pal_purple"
Dim lsPlayfield2Off: Set lsPlayfield2Off = New LightChangeItem
lsPlayfield2Off.Init 95,0,20,"pal_purple"

Dim lsPlayfield3: Set lsPlayfield3 = New LightChangeItem
lsPlayfield3.Init 96,1,20,"pal_purple"
Dim lsPlayfield3Off: Set lsPlayfield3Off = New LightChangeItem
lsPlayfield3Off.Init 96,0,20,"pal_purple"

Dim lsPlungerLane1: Set lsPlungerLane1 = New LightChangeItem
lsPlungerLane1.Init 133,1,180,"pal_green"
Dim lsPlungerLane1Off: Set lsPlungerLane1Off = New LightChangeItem
lsPlungerLane1Off.Init 133,0,180,"pal_green"

Dim lsPlungerLane2: Set lsPlungerLane2 = New LightChangeItem
lsPlungerLane2.Init 134,1,180,"pal_green"
Dim lsPlungerLane2Off: Set lsPlungerLane2Off = New LightChangeItem
lsPlungerLane2Off.Init 134,0,180,"pal_green"

Dim lsPlungerLane3: Set lsPlungerLane3 = New LightChangeItem
lsPlungerLane3.Init 135,1,180,"pal_green"
Dim lsPlungerLane3Off: Set lsPlungerLane3Off = New LightChangeItem
lsPlungerLane3Off.Init 135,0,180,"pal_green"

Dim lSeqPlungerLaneItem: Set lSeqPlungerLaneItem = new LightSeqItem
lSeqPlungerLaneItem.Name = "lSeqPlungerLaneItem"
lSeqPlungerLaneItem.Image = "pal_green"
lSeqPlungerLaneItem.Sequence = Array(lsPlungerLane1,lsPlungerLane2,Array(lsPlungerLane1Off,lsPlungerLane3),lsPlungerLane2Off,lsPlungerLane3Off)
lSeqPlungerLaneItem.UpdateInterval = 100

Dim lSeqPlungerLane: Set lSeqPlungerLane = new LightSeq
lSeqPlungerLane.Name = "lSeqPlungerLane"
lSeqPlungerLane.Repeat = 1


Dim lsPop1: Set lsPop1 = New LightChangeItem
lsPop1.Init 120,1,20,"pal_purple"
Dim lsPop1Off: Set lsPop1Off = New LightChangeItem
lsPop1Off.Init 120,0,20,"pal_purple"

Dim lsPop2: Set lsPop2 = New LightChangeItem
lsPop2.Init 121,1,20,"pal_purple"
Dim lsPop2Off: Set lsPop2Off = New LightChangeItem
lsPop2Off.Init 122,0,20,"pal_purple"

Dim lsPop3: Set lsPop3 = New LightChangeItem
lsPop3.Init 122,1,20,"pal_purple"
Dim lsPop3Off: Set lsPop3Off = New LightChangeItem
lsPop3Off.Init 122,0,20,"pal_purple"

Dim lsRace1: Set lsRace1 = New LightChangeItem
lsRace1.Init 100,1,20,"pal_purple"
Dim lsRace1Off: Set lsRace1Off = New LightChangeItem
lsRace1Off.Init 100,0,20,"pal_purple"

Dim lsRace2: Set lsRace2 = New LightChangeItem
lsRace2.Init 101,1,20,"pal_purple"
Dim lsRace2Off: Set lsRace2Off = New LightChangeItem
lsRace2Off.Init 101,0,20,"pal_purple"

Dim lsRace3: Set lsRace3 = New LightChangeItem
lsRace3.Init 102,1,20,"pal_purple"
Dim lsRace3Off: Set lsRace3Off = New LightChangeItem
lsRace3Off.Init 102,0,20,"pal_purple"

Dim lsRace4: Set lsRace4 = New LightChangeItem
lsRace4.Init 103,1,20,"pal_purple"
Dim lsRace4Off: Set lsRace4Off = New LightChangeItem
lsRace4Off.Init 103,0,20,"pal_purple"

Dim lsRace5: Set lsRace5 = New LightChangeItem
lsRace5.Init 104,1,20,"pal_purple"
Dim lsRace5Off: Set lsRace5Off = New LightChangeItem
lsRace5Off.Init 104,0,20,"pal_purple"

Dim lsRace6: Set lsRace6 = New LightChangeItem
lsRace6.Init 105,1,20,"pal_purple"
Dim lsRace6Off: Set lsRace6Off = New LightChangeItem
lsRace6Off.Init 105,0,20,"pal_purple"

Dim lsRaceWizard: Set lsRaceWizard = New LightChangeItem
lsRaceWizard.Init 106,1,20,"pal_purple"
Dim lsRaceWizardOff: Set lsRaceWizardOff = New LightChangeItem
lsRaceWizardOff.Init 106,0,20,"pal_purple"



Dim lsRightOrbit: Set lsRightOrbit = New LightChangeItem
lsRightOrbit.Init 36,1,180,"pal_purple"
Dim lsRightOrbitOff: Set lsRightOrbitOff = New LightChangeItem
lsRightOrbitOff.Init 36,0,180,"pal_purple"

Dim lSeqRightOrbitActiveShot: Set lSeqRightOrbitActiveShot = new LightSeqItem
lSeqRightOrbitActiveShot.Name = "lSeqRightOrbitActiveShot"
lSeqRightOrbitActiveShot.Image = "pal_purple"
lSeqRightOrbitActiveShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqRightOrbitHurryUpShot: Set lSeqRightOrbitHurryUpShot = new LightSeqItem
lSeqRightOrbitHurryUpShot.Name = "lSeqRightOrbitHurryUpShot"
lSeqRightOrbitHurryUpShot.Image = "pal_yellow"
lSeqRightOrbitHurryUpShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqRightOrbit: Set lSeqRightOrbit = new LightSeq
lSeqRightOrbit.Name = "lSeqRightOrbit"
lSeqRightOrbit.Repeat = 1


Dim lsRightRamp: Set lsRightRamp = New LightChangeItem
lsRightRamp.Init 35,1,180,"pal_purple"
Dim lsRightRampOff: Set lsRightRampOff = New LightChangeItem
lsRightRampOff.Init 35,0,180,"pal_purple"

Dim lSeqRightRampActiveShot: Set lSeqRightRampActiveShot = new LightSeqItem
lSeqRightRampActiveShot.Name = "lSeqRightRampActiveShot"
lSeqRightRampActiveShot.Image = "pal_purple"
lSeqRightRampActiveShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqRightRampCollectShot: Set lSeqRightRampCollectShot = new LightSeqItem
lSeqRightRampCollectShot.Name = "lSeqRightRampCollectShot"
lSeqRightRampCollectShot.Image = "pal_green"
lSeqRightRampCollectShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqRightRamp: Set lSeqRightRamp = new LightSeq
lSeqRightRamp.Name = "lSeqRightRamp"
lSeqRightRamp.Repeat = 1
Dim lsShortcut1: Set lsShortcut1 = New LightChangeItem
lsShortcut1.Init 46,1,60,"pal_purple"
Dim lsShortcut1Off: Set lsShortcut1Off = New LightChangeItem
lsShortcut1Off.Init 46,0,60,"pal_purple"

Dim lsShortcut2: Set lsShortcut2 = New LightChangeItem
lsShortcut2.Init 47,1,60,"pal_purple"
Dim lsShortcut2Off: Set lsShortcut2Off = New LightChangeItem
lsShortcut2Off.Init 47,0,60,"pal_purple"

Dim lsShortcut3: Set lsShortcut3 = New LightChangeItem
lsShortcut3.Init 48,1,60,"pal_purple"
Dim lsShortcut3Off: Set lsShortcut3Off = New LightChangeItem
lsShortcut3Off.Init 48,0,60,"pal_purple"

Dim lSeqShortcutBlink: Set lSeqShortcutBlink = new LightSeqItem
lSeqShortcutBlink.Name = "lSeqShortcutBlink"
lSeqShortcutBlink.Image = "pal_purple"
lSeqShortcutBlink.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)


Dim lSeqShortcutActiveShot: Set lSeqShortcutActiveShot = new LightSeqItem
lSeqShortcutActiveShot.Name = "lSeqShortcutActiveShot"
lSeqShortcutActiveShot.Image = "pal_purple"
lSeqShortcutActiveShot.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)

Dim lSeqShortcut: Set lSeqShortcut = new LightSeq
lSeqShortcut.Name = "lSeqShortcut"
lSeqShortcut.Repeat = 1
Dim lsSpeeder: Set lsSpeeder = New LightChangeItem
lsSpeeder.Init 136,1,180,"pal_cyan"
Dim lsSpeederOff: Set lsSpeederOff = New LightChangeItem
lsSpeederOff.Init 136,0,180,"pal_cyan"

'Dim lSeqPlungerLaneItem: Set lSeqPlungerLaneItem = new LightSeqItem
'lSeqPlungerLaneItem.Name = "lSeqPlungerLaneItem"
'lSeqPlungerLaneItem.Image = "pal_green"
'lSeqPlungerLaneItem.Sequence = Array(lsPlungerLane1,lsPlungerLane2,Array(lsPlungerLane1Off,lsPlungerLane3),lsPlungerLane2Off,lsPlungerLane3Off)
'lSeqPlungerLaneItem.UpdateInterval = 100

'Dim lSeqPlungerLane: Set lSeqPlungerLane = new LightSeq
'lSeqPlungerLane.Name = "lSeqPlungerLane"
'lSeqPlungerLane.Repeat = 1




Dim lsSpinner1: Set lsSpinner1 = New LightChangeItem
lsSpinner1.Init 33,1,180,"pal_purple"
Dim lsSpinner1Off: Set lsSpinner1Off = New LightChangeItem
lsSpinner1Off.Init 33,0,180,"pal_purple"
Dim lsSpinner2: Set lsSpinner2 = New LightChangeItem
lsSpinner2.Init 39,1,180,"pal_purple"
Dim lsSpinner2Off: Set lsSpinner2Off = New LightChangeItem
lsSpinner2Off.Init 39,0,180,"pal_purple"

Dim lSeqSpinnerActiveShot: Set lSeqSpinnerActiveShot = new LightSeqItem
lSeqSpinnerActiveShot.Name = "lSeqSpinnerActiveShot"
lSeqSpinnerActiveShot.Image = "pal_purple"
lSeqSpinnerActiveShot.Sequence = Array(Array(lsSpinner1,lsSpinner2), Array(lsSpinner1Off,lsSpinner2Off))

Dim lSeqSpinner: Set lSeqSpinner = new LightSeq
lSeqSpinner.Name = "lSeqSpinner"
lSeqSpinner.Repeat = 1
Dim lSeqMultiballCShot: Set lSeqMultiballCShot = new LightSeqItem
lSeqMultiballCShot.Name = "lSeqMultiballCShot"
lSeqMultiballCShot.Image = "pal_green"
lSeqMultiballCShot.Sequence = Array(lsCyber1,Array(lsCombo1,lsCyber1Off),Array(lsLeftOrbit,lsCombo1Off),lsLeftOrbitOff)
lSeqMultiballCShot.UpdateInterval = 80

Dim lSeqMultiballYShot: Set lSeqMultiballYShot = new LightSeqItem
lSeqMultiballYShot.Name = "lSeqMultiballYShot"
lSeqMultiballYShot.Image = "pal_green"
lSeqMultiballYShot.Sequence = Array(lsCyber2,Array(lsCombo2,lsCyber2Off),Array(lsLeftRamp,lsCombo2Off),lsLeftRampOff)
lSeqMultiballYShot.UpdateInterval = 80

Dim lSeqMultiballBShot: Set lSeqMultiballBShot = new LightSeqItem
lSeqMultiballBShot.Name = "lSeqMultiballBShot"
lSeqMultiballBShot.Image = "pal_green"
lSeqMultiballBShot.Sequence = Array(lsCyber3,Array(lsCombo3,lsCyber3Off),Array(lsCenterRamp,lsCombo3Off),lsCenterRampOff)
lSeqMultiballBShot.UpdateInterval = 80

Dim lSeqMultiballEShot: Set lSeqMultiballEShot = new LightSeqItem
lSeqMultiballEShot.Name = "lSeqMultiballEShot"
lSeqMultiballEShot.Image = "pal_green"
lSeqMultiballEShot.Sequence = Array(lsCyber4,Array(lsCombo4,lsCyber4Off),Array(lsRightRamp,lsCombo4Off),lsRightRampOff)
lSeqMultiballEShot.UpdateInterval = 80

Dim lSeqMultiballRShot: Set lSeqMultiballRShot = new LightSeqItem
lSeqMultiballRShot.Name = "lSeqMultiballRShot"
lSeqMultiballRShot.Image = "pal_green"
lSeqMultiballRShot.Sequence = Array(lsCyber5,Array(lsCombo5,lsCyber5Off),Array(lsRightOrbit,lsCombo5Off),lsRightOrbitOff)
lSeqMultiballRShot.UpdateInterval = 80

Dim lSeqMultiballC: Set lSeqMultiballC = new LightSeq
lSeqMultiballC.Name = "lSeqMultiballC"
lSeqMultiballC.Repeat = 1

Dim lSeqMultiballY: Set lSeqMultiballY = new LightSeq
lSeqMultiballY.Name = "lSeqMultiballY"
lSeqMultiballY.Repeat = 1

Dim lSeqMultiballB: Set lSeqMultiballB = new LightSeq
lSeqMultiballB.Name = "lSeqMultiballB"
lSeqMultiballB.Repeat = 1

Dim lSeqMultiballE: Set lSeqMultiballE = new LightSeq
lSeqMultiballE.Name = "lSeqMultiballE"
lSeqMultiballE.Repeat = 1

Dim lSeqMultiballR: Set lSeqMultiballR = new LightSeq
lSeqMultiballR.Name = "lSeqMultiballR"
lSeqMultiballR.Repeat = 1

Dim lSeqMultiballCYBER: Set lSeqMultiballCYBER = new LightSeq
lSeqMultiballCYBER.Name = "lSeqMultiballCYBER"
lSeqMultiballCYBER.Repeat = 1


Dim lSeqLeftOrbitPerkShot: Set lSeqLeftOrbitPerkShot = new LightSeqItem
lSeqLeftOrbitPerkShot.Name = "lSeqLeftOrbitPerkShot"
lSeqLeftOrbitPerkShot.Image = "pal_orange"
lSeqLeftOrbitPerkShot.Sequence = Array(lsLeftOrbit,lsLeftOrbitOff)

Dim lSeqRightOrbitPerkShot: Set lSeqRightOrbitPerkShot = new LightSeqItem
lSeqRightOrbitPerkShot.Name = "lSeqRightOrbitPerkShot"
lSeqRightOrbitPerkShot.Image = "pal_orange"
lSeqRightOrbitPerkShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqHyperJumpPerkShot: Set lSeqHyperJumpPerkShot = new LightSeqItem
lSeqHyperJumpPerkShot.Name = "lSeqHyperJumpPerkShot"
lSeqHyperJumpPerkShot.Image = "pal_orange"
lSeqHyperJumpPerkShot.Sequence = Array(lsHyperJump5,lsHyperJump4,Array(lsHyperJump5Off,lsHyperJump3),Array(lsHyperJump4Off,lsHyperJump2),Array(lsHyperJump3Off,lsHyperJump1),lsHyperJump2Off, lsHyperJump1Off)
lSeqHyperJumpPerkShot.UpdateInterval = 60

Dim lSeqShortcutPerkShot: Set lSeqShortcutPerkShot = new LightSeqItem
lSeqShortcutPerkShot.Name = "lSeqShortcutPerkShot"
lSeqShortcutPerkShot.Image = "pal_orange"
lSeqShortcutPerkShot.UpdateInterval = 60
lSeqShortcutPerkShot.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)

Dim lSeqRightRampPerkShot: Set lSeqRightRampPerkShot = new LightSeqItem
lSeqRightRampPerkShot.Name = "lSeqRightRampPerkShot"
lSeqRightRampPerkShot.Image = "pal_orange"
lSeqRightRampPerkShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqLeftRampPerkShot: Set lSeqLeftRampPerkShot = new LightSeqItem
lSeqLeftRampPerkShot.Name = "lSeqLeftRampPerkShot"
lSeqLeftRampPerkShot.Image = "pal_orange"
lSeqLeftRampPerkShot.Sequence = Array(lsLeftRamp,lsLeftRampOff)

Dim lSeqCenterRampPerkShot: Set lSeqCenterRampPerkShot = new LightSeqItem
lSeqCenterRampPerkShot.Name = "lSeqCenterRampPerkShot"
lSeqCenterRampPerkShot.Image = "pal_orange"
lSeqCenterRampPerkShot.Sequence = Array(lsCenterRamp,lsCenterRampOff)

Dim lSeqSpinnerPerkShot: Set lSeqSpinnerPerkShot = new LightSeqItem
lSeqSpinnerPerkShot.Name = "lSeqSpinnerPerkShot"
lSeqSpinnerPerkShot.Image = "pal_orange"
lSeqSpinnerPerkShot.Sequence = Array(Array(lsSpinner1,lsSpinner2), Array(lsSpinner1Off,lsSpinner2Off))

Dim lSeqBumpersPerkShot: Set lSeqBumpersPerkShot = new LightSeqItem
lSeqBumpersPerkShot.Name = "lSeqBumpersPerkShot"
lSeqBumpersPerkShot.LampColor = gameColors(2)
lSeqBumpersPerkShot.Sequence = Array(Array(lsBump1flash,lsBump2flash,lsBump3flash), Array(lsBump1flashOff,lsBump2flashOff,lsBump3flashOff))

Dim lSeqSkillshot: Set lSeqSkillshot = new LightSeqItem
lSeqSkillshot.Name = "lSeqSkillshot"
lSeqSkillshot.Image = "pal_yellow"
lSeqSkillshot.Sequence = AppendLightSequenceArray(Array(), Array(lsPop1, lsBet1, lsBet2, lsBet3, lsCenterRamp, lsRace6))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo3, lsRace3, lsBonus2, lsCyber3))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsResearch2, lsCyber4, lsRace1, lsBonus1, lsRightRamp, lsCombo4))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsPop1Off, lsBet1Off, lsBet2Off, lsBet3Off, lsCenterRampOff, lsRace6Off, lsAug1, lsRaceWizard))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo3Off, lsRace3Off, lsBonus1Off, lsCyber4Off, lsAug4, lsAug7, lsBonus3, lsRace2, lsRace5, lsSpinner2, lsPop2))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCyber3Off, lsResearch2Off, lsBonus2Off, lsRace1Off, lsRightRampOff, lsCombo4Off, lciFinish, lsShortcut))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsAug1Off, lsRaceWizardOff, lsHyperJump5, lsHyperJump4, lsHoldAug, lsShortcut1, lsAug2, lsSpinner1))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsAug4Off, lsAug7Off, lsBonus3Off, lsRace2Off, lsRace5Off, lsSpinner2Off, lsPop2Off, lsCombo2, lsCyber2, lsRace4, lsPlayfield2, lsCaptive1, lsCaptive4, lsShortcut2, lsAug5))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lciFinishOff, lsShortcutOff, lsHyperJump5Off, lsLeftRamp, lsHyperJump3, lsCaptive2, lsCaptive3, lsAug8))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsHyperJump4Off, lsHoldAugOff, lsShortcut1Off, lsAug2Off, lsSpinner1Off, lsPlayfield3, lsPop3, lsShortcut3))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo2Off, lsCyber2Off, lsRace4Off, lsPlayfield2Off, lsCaptive1Off, lsCaptive4Off, lsShortcut2Off, lsAug5Off, lsHyperJump2, lsAug3, lsAug6))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLeftRampOff, lsHyperJump3Off, lsCaptive2Off, lsCaptive3Off, lsAug8Off, lsHyperJump1, lsLightLock, lsAug9, lsCyber5))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsPlayfield3Off, lsPop3Off, lsShortcut3Off, lsExtraBall, lsPlayfield1, lsCombo5, lsResearch3, lsLane3))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsHyperJump2Off, lsAug3Off, lsAug6Off, lsResearch1, lsRightOrbit))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsHyperJump1Off, lsLightLockOff, lsAug9Off, lsCyber5Off, lsResearchReady, lsCyber1))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsExtraBallOff, lsPlayfield1Off, lsCombo5Off, lsResearch3Off, lsLane3Off, lsCombo1, lsLane4, olr1a, olr2a, olr3a, olr4a, olr5a, olr6a, olr7a, olr8a, olr9a))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsResearch1Off, lsRightOrbitOff, lsLeftOrbit, olr1b, olr2b, olr3b, olr4b, olr5b, olr6b, olr7b, olr8b, olr9b))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsResearchReadyOff, lsCyber1Off))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo1Off, lsLane4Off, olr1aOff, olr2aOff, olr3aOff, olr4aOff, olr5aOff, olr6aOff, olr7aOff, olr8aOff, olr9aOff, lsLane2))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLeftOrbitOff, olr1bOff, olr2bOff, olr3bOff, olr4bOff, olr5bOff, olr6bOff, olr7bOff, olr8bOff, olr9bOff))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLane2Off, oll1b, oll2b, oll3b, oll4b, oll5b, oll6b, oll7b, oll8b, oll9b))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLane1, oll1a, oll2a, oll3a, oll4a, oll5a, oll6a, oll7a, oll8a, oll9a))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(oll1bOff, oll2bOff, oll3bOff, oll4bOff, oll5bOff, oll6bOff, oll7bOff, oll8bOff, oll9bOff))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLane1Off, oll1aOff, oll2aOff, oll3aOff, oll4aOff, oll5aOff, oll6aOff, oll7aOff, oll8aOff, oll9aOff))
lSeqSkillshot.UpdateInterval = 10

Dim lSeqLightsOverride: Set lSeqLightsOverride = new LightSeq
lSeqLightsOverride.Name = "lSeqLightsOverride"

'***********************************************************************************************************************
'*****  COLORS                                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim mat_soviet, mat_empire, mat_allied, mat_rgb

mat_empire = "insertPurpleOn"
mat_soviet = "insertRedOn"
mat_allied = "insertBlueOn"
mat_rgb = "insertOff"

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
        Case GAME_ADVANCE_MODE1
            GameAdvanceMode1
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

'Table Modes
Const GAME_ADVANCE_MODE1 = "Game Advance Mode 1"

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
  DOF 210, DOFOn 'MX Effects, Ball ready to Shoot
  
	ballRelease.CreateSizedball BallSize / 2
  ballRelease.Kick 90, 4
  gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True
  gameState("game")("modes")(GAME_MODE_NORMAL) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  gameState("game")("modes")(GAME_MODE_MULTIBALL) = False
  gameState("game")("modes")(GAME_MODE_HURRYUP) = False
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
  LightOn(lsCyber4)
  
  
End Sub

Sub GameEndOfBall()
  EndMusic
  Dispatch LIGHTS_GI_OFF, Null
  If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
    DISPATCH LIGHTS_RESEARCH_OFF, Null
    StopLightBlink(lciFinish)
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
    LightBlink(lciResearchLit)
    'objFluxTimer(1).UserValue = 1
    'objFluxBase(1).UserValue = 0.4
    'FluxObjlevel(1) = 0.1 : FlasherFluxTimer1_Timer
    'LightFluxFlash 1, FlasherFluxTimer1
    'objFluxTimer(2).UserValue = 1
    'objFluxBase(2).UserValue = 0.4
    'FluxObjlevel(2) = 0.1 : FlasherFluxTimer2_Timer
    'LightFluxFlash 2, FlasherFluxTimer2
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
      aug.Image = "pal_red_darker"
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
  StopLightBlink(lciHoldAug)
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
  LightBlink(lciHoldAug)
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

  gameState("game")("gameShots")(GAME_MODE_AUGMENTATION_RESEARCH).RemoveAll()

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
      LightBlink(lciFinish)
      AddGameTargetShot GAME_SHOT_RIGHT_RAMP_COLLECT, GAME_MODE_AUGMENTATION_RESEARCH
  End Select

End Sub

Sub GameModeFinishAugmentation()
  gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = 0
  lSeqRightRamp.RemoveItem(lSeqRightRampCollectShot)
  StopLightBlink(lciFinish)
  RPin.IsDropped = 0
End Sub

Sub GameModeCollectAugmentation()

  DISPATCH LIGHTS_GI_OFF, Null
  'pupevent 503 'stop music hackers
  EndMusic
  gameState("game")("gameShots")(GAME_MODE_AUGMENTATION_RESEARCH).RemoveAll()
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
      StopLightBlink(lciHoldAug)
      lSeqHyperJump.RemoveAll()
      lSeqLeftOrbit.RemoveAll()
      lSeqShortcut.RemoveAll()
      lSeqRightOrbit.RemoveAll()
      lSeqRightRamp.RemoveAll()
      lSeqCenterRamp.RemoveAll()
      lSeqSpinner.RemoveAll()
      lSeqBumpers.RemoveAll()
      lSeqLeftRamp.RemoveAll()
    Case 0:
      'lSeqHyperJumpActiveShot.Image = palette
      lSeqHyperJump.AddItem(lSeqHyperJumpActiveShot)
      AddGameTargetShot GAME_SHOT_HYPER_JUMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 1:
      'lSeqLeftOrbitActiveShot.Image = palette
      lSeqLeftOrbit.AddItem(lSeqLeftOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH
    Case 2:
      'lSeqLeftRampActiveShot.Image = palette
      lSeqLeftRamp.AddItem(lSeqLeftRampActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 3:
      'lSeqSpinnerActiveShot.Image = palette
      lSeqSpinner.AddItem(lSeqSpinnerActiveShot)
      AddGameTargetShot GAME_SHOT_SPINNER,GAME_MODE_AUGMENTATION_RESEARCH
    Case 4:
      'lSeqBumpersActiveShot.Image = palette
      lSeqBumpers.AddItem(lSeqBumpersActiveShot)
      AddGameTargetShot GAME_SHOT_BUMPERS,GAME_MODE_AUGMENTATION_RESEARCH
    Case 5:
      'lSeqCenterRampActiveShot.Image = palette
      lSeqCenterRamp.AddItem(lSeqCenterRampActiveShot)
      AddGameTargetShot GAME_SHOT_CENTER_RAMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 6:
      'lSeqRightRampActiveShot.Image = palette
      lSeqRightRamp.AddItem(lSeqRightRampActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 7:
      'lSeqRightOrbitActiveShot.Image = palette
      lSeqRightOrbit.AddItem(lSeqRightOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH
    Case 8:
      'lSeqShortcutActiveShot.Image = palette
      lSeqShortcut.AddItem(lSeqShortcutActiveShot)
      AddGameTargetShot GAME_SHOT_SHORTCUT,GAME_MODE_AUGMENTATION_RESEARCH
  End Select
End Sub

Sub AddGameTargetShot(shot, gameMode)

	If Not gameState("game")("gameShots")(gameMode).Exists(shot) Then
		gameState("game")("gameShots")(gameMode).Add shot, True
	End If

End Sub

Function IsActiveGameShot(shot, gameMode)

  If gameState("game")("gameShots")(gameMode).Exists(shot) Then
    IsActiveGameShot = True
  Else
    IsActiveGameShot = False
  End If
  
End Function

Sub RemoveGameTargetShot(shot, gameMode)

	If gameState("game")("gameShots")(gameMode).Exists(shot) Then
		gameState("game")("gameShots")(gameMode).Remove shot
	End If

End Sub

Sub GameAwardSkillshot()
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
  PlayGameCallout("skillshot")
  DOF 251, DOFOn 'MX Effects, Skill Flashing On
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
  DOF 251, DOFOff 'MX Effects, Skill Flashing Off
  DOF 252, DOFOn 'MX Effects, Shot Flashing On
  vpmTimer.AddTimer 400, "vpmTimerAwardSkillshotDof2 '"
End Sub

Sub vpmTimerAwardSkillshotDof2
  DOF 252, DOFOff 'MX Effects, Shot Flashing Off
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
  'timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
  'PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002

End Sub

Sub GameDisableBallLock()

  DiverterDir = 1
  DiverterOff.IsDropped=0
  DiverterOn.IsDropped=1
  'timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
  'PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002

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
  gameState("game")("gameShots")(GAME_MODE_AUGMENTATION_RESEARCH).RemoveAll()
  gameState("game")("gameShots")(GAME_MODE_NORMAL).RemoveAll()
  gameState("game")("gameShots")(GAME_MODE_MULTIBALL).RemoveAll()
  gameState("game")("gameShots")(GAME_MODE_HURRYUP).RemoveAll()
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
    AddGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
  End If
  If gameState("game")("multiballJackpots")=6 Then
    'Super Jackpot
    LightOff(lsCyber1)
    LightOff(lsCyber2)
    LightOff(lsCyber3)
    LightOff(lsCyber4)
    LightOff(lsCyber5)
    AddGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
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
  'gameState("switches")("betB") = 0
  'gameState("switches")("betE") = 0
  'gameState("switches")("betT") = 0
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
  
  lSeqRightOrbit.AddItem(lSeqRightOrbitHurryUpShot)
  AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_HURRYUP

End Sub

Sub vpmTimerEndHurryUp

  If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
    gameState("game")("modes")(GAME_MODE_HURRYUP) = False
    'pupevent music
    StopBGAudio()
    lSeqRightOrbit.RemoveItem(lSeqRightOrbitHurryUpShot)
    gameState("game")("gameShots")(GAME_MODE_HURRYUP).RemoveAll()
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
    gameLogic.Add "mode1Hits", 0
    gameLogic.Add "mode1TimesRan", 0
    gameModes.Add GAME_MODE_NORMAL, False
    gameModes.Add GAME_MODE_CHOOSE_SKILLSHOT, False
    gameModes.Add GAME_MODE_SKILLSHOT_ACTIVE, False
    gameModes.Add GAME_MODE_AUGMENTATION_RESEARCH, False
    gameModes.Add GAME_MODE_MULTIBALL, False
    gameModes.Add GAME_MODE_HURRYUP, False
    gameLogic.Add "modes", gameModes

    Dim gameShots: Set gameShots=CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_NORMAL, CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_AUGMENTATION_RESEARCH, CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_MULTIBALL, CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_HURRYUP, CreateObject("Scripting.Dictionary")
    gameLogic.Add "gameShots", gameShots

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
PaletteToLampLookup.Add "pal_red_darker", gameColors(4)
PaletteToLampLookup.Add "pal_yellow", gameColors(5)
PaletteToLampLookup.Add "pal_green", gameColors(7)
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

Const GAME_MODE_NORMAL = "Game_Mode_Normal"
Const GAME_MODE_CHOOSE_SKILLSHOT = "Game_Mode_Choose_Skillshot"
Const GAME_MODE_SKILLSHOT_ACTIVE = "Game_Mode_Skillshot_Active"
Const GAME_MODE_AUGMENTATION_RESEARCH = "Game_Mode_Augmentation_Research"
Const GAME_MODE_MULTIBALL = "Game_Mode_Multiball"
Const GAME_MODE_HURRYUP = "Game_Mode_Hurry Up"

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

' Mode 1 - Left Return Shot.
' X Shots Starts a 3 Way Combo
' Post Pops up on left inlane
' Shot 1 - Right Ramp
' Shot 2 - Left Orbit
' Shot 3 - Left Ramp.
' Awards at Left Inlane.
Sub GameAdvanceMode1()

    gameState("game")("mode1Hits") = gameState("game")("mode1Hits") + 1
    If gameState("game")("mode1Hits") > Min(5 * (gameState("game")("mode1TimesRan")+1),15) Then
        'start mode
        MsgBox("Start Mode 1")
        gameState("game")("mode1Hits") = 0
        gameState("game")("mode1TimesRan") = gameState("game")("mode1TimesRan")+1
    End If
    

End Sub
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
    'FlasherFluxTimer1.Enabled = False
    'objFluxBase(1).BlendDisableLighting = FluxFlasherOffBrightness
    'FlasherFluxTimer2.Enabled = False
    'objFluxBase(2).BlendDisableLighting = FluxFlasherOffBrightness

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
                Lampz.lampColor(gameState("lights")("changedLamps")(changedLamp).Idx) = PaletteToLampLookup(gameState("lights")("changedLamps")(changedLamp).Image)
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

    'playfield_lm.visible = True
    'p_artblades_back.Image = "artbladesbackgion"
    'p_plastics.Image = "plastics-new"
    gameState("game")("modes")(GAME_MODE_NORMAL) = True
    ModLampz.SetGI 0, 9
    
    SetGI 0,9
    SetGIPerk 0,0
    'Dispatch LIGHTS_GI_NORMAL, Null
    for each GIxx in GI
        GIxx.Color = gameState("lights")("GIColor")
        GIxx.ColorFull = gameState("lights")("GIColor")
        'GIxx.Intensity = 30
        GIxx.visible = False
    next
End Sub

Sub LightsGIOff()
    gameState("lights")("gi") = 0
    'playfield_lm.visible = False
    'p_artblades_back.Image = "artbladesbackgioff"
    'p_plastics.Image = "plastics-off"
    ModLampz.SetGI 0, 0
    LightOff(lsSpeeder)
End Sub

Sub LightsGINormal()
    for each GIxx in GI
        GIxx.Color = c_normal
        GIxx.ColorFull = c_normal_full
        'GIxx.Intensity = 30
    next
    'p_plastics.Image = "plastics-new"
    ModLampz.SetGI 0, 9
    gameState("lights")("GIColor") = c_normal
End Sub

Sub LightsGIDomes(color)
    'for each GIxx in GISLings
    '    GIxx.Color = gameColors(color)
    '    GIxx.ColorFull = gameColors(color)
    '    GIxx.Intensity = 2
    'next
    'p_plastics.Image = gamePlastics(color)
    'SetGIPerk 0,9
End Sub

Sub LightsGiAugmentationResearch()
    for each GIxx in GI
        GIxx.Color = c_augmentationResearch
        GIxx.ColorFull = c_augmentationResearch
       ' GIxx.Intensity = 3
    next
    'p_plastics.Image = "plastics-blue"
    gameState("lights")("GIColor") = c_augmentationResearch
End Sub

Sub LightsGiHurryUp()
    for each GIxx in GI
        GIxx.Color = gameColors(6)
        GIxx.ColorFull = gameColors(6)
       ' GIxx.Intensity = 3
    next
    'p_plastics.Image = "plastics-yellow"
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
    StopLightBlink(lciResearchLit)
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

'***********************************************************************************************************************
'*****    Light Utils                                                  	                                            ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Function AppendLightSequenceArray(ByVal aArray, aInput)	'append one value, object, or Array onto the end of a 1 dimensional array
    dim tmp : tmp = aArray
    Redim Preserve tmp(uBound(aArray) +1)
    tmp(uBound(aArray)+1) = aInput
    AppendLightSequenceArray = tmp
End Function

Sub LightOn(light)
    If gameState("lights")("lightOn").Exists(light.Idx) Then 
        Exit Sub
    End If

    StopLightBlink(light)

    light.State = 1
    'If Not gameState("lights")("lightOn").Exists(light.Idx) Then 
    gameState("lights")("lightOn").Add light.Idx, light
    'End If
End Sub

Sub LightOff(light)
    StopLightBlink(light)
End Sub

Sub LightFluxFlash(nr, light)

    If Not gameState("lights")("lightFlash").Exists(nr) Then 
        gameState("lights")("lightFlash").Add nr, light
    End If

End Sub

Sub LightFluxFlashOff(nr)

    If gameState("lights")("lightFlash").Exists(nr) Then 
        gameState("lights")("lightFlash").Remove nr
    End If

End Sub

Sub LightBlink(light)

    If Not gameState("lights")("lightBlinks").Exists(light.Idx) Then 
        gameState("lights")("lightBlinks").Add light.Idx, light
    End If

    If gameState("lights")("lightOn").Exists(light.Idx) Then
        gameState("lights")("lightOn").Remove light.Idx
    End If

End Sub

Sub StopLightBlink(light)

    Lampz.State(light.Idx) = 0
    light.State = 1
    light.ResetFrames()

    If gameState("lights")("lightBlinks").Exists(light.Idx) Then
        gameState("lights")("lightBlinks").Remove light.Idx
    End If

    If gameState("lights")("lightOn").Exists(light.Idx) Then	
        gameState("lights")("lightOn").Remove light.Idx
    End If

End Sub

Sub StopLightSeq(seq)
    If Not IsNull(seq) Then
        Dim item
        For Each item in seq.Items
            Dim x
            For Each x in item.Sequence

                If IsArray(x) Then
                    Dim xx
                    For Each xx in x
                        Lampz.State(xx.Idx) = 0
                    Next
                Else
                    Lampz.State(x.Idx) = 0
                
                End If
            Next
            item.CurrentIdx = 0
        Next
        If gameState("lights")("lightSeqs").Exists(seq.Name) Then
            gameState("lights")("lightSeqs").Remove seq.Name
        End If
    End If
End Sub

Sub StartLightSeq(seq)
    If Not IsNull(seq) Then
        If Not gameState("lights")("lightSeqs").Exists(seq.Name) Then
            gameState("lights")("lightSeqs").Add seq.Name, seq
        End If
    End If
End Sub

Function IsLightOn(light)
    If gameState("lights")("lightBlinks").Exists(light.Idx) Or gameState("lights")("lightOn").Exists(light.Idx) Then 
        IsLightOn = True
    Else
        IsLightOn = False
    End If
End Function

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
        If IsActiveGameShot(GAME_SHOT_BUMPERS, GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_BUMPERS, GAME_MODE_HURRYUP) Then
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
        If IsActiveGameShot(GAME_SHOT_CENTER_RAMP, GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If IsActiveGameShot(GAME_SHOT_CENTER_RAMP,GAME_MODE_MULTIBALL) Then
            RemoveGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
            LightOn(lsCyber3)
            lSeqMultiballB.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_CENTER_RAMP,GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
        DISPATCH GAME_COMBO, lsCombo3
        DISPATCH GAME_ADVANCE_MODE1, null
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
        If IsActiveGameShot(GAME_SHOT_HYPER_JUMP,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_HYPER_JUMP,GAME_MODE_HURRYUP) Then
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
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_MULTIBALL) Then
                RemoveGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
                LightOn(lsCyber1)
                lSeqMultiballC.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_HURRYUP) Then
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
        If IsActiveGameShot(GAME_SHOT_LEFT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If IsActiveGameShot(GAME_SHOT_LEFT_RAMP,GAME_MODE_MULTIBALL) Then
            RemoveGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
            LightOn(lsCyber2)
            lSeqMultiballY.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_LEFT_RAMP,GAME_MODE_HURRYUP) Then
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
            If IsActiveGameShot(GAME_SHOT_RIGHT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If IsActiveGameShot(GAME_SHOT_RIGHT_ORBIT,GAME_MODE_MULTIBALL) Then
                RemoveGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
                LightOn(lsCyber5)
                lSeqMultiballR.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
            If IsActiveGameShot(GAME_SHOT_RIGHT_ORBIT,GAME_MODE_HURRYUP) Then
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
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP_COLLECT,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_FINISH_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP,GAME_MODE_MULTIBALL) Then
            RemoveGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
            LightOn(lsCyber4)
            lSeqMultiballE.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP,GAME_MODE_HURRYUP) Then
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
        If IsActiveGameShot(GAME_SHOT_SHORTCUT,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_SHORTCUT,GAME_MODE_HURRYUP) Then
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
        If IsActiveGameShot(GAME_SHOT_SPINNER,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_SPINNER,GAME_MODE_HURRYUP) Then
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
    'objFluxTimer(1).UserValue = 0
    'objFluxBase(1).UserValue = 1
    'objFluxBase(1).Material = "Console_HUD_Red"
    DOF 235, DOFPulse
    'FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
    waittime = 400
    vpmTimer.addtimer waittime, "exitConsoleKickerWithFlash '"

End Sub

Sub exitConsoleKickerWithFlash
    'objFluxTimer(1).UserValue = 0
    'objFluxBase(1).UserValue = 1
    'objFluxBase(1).Material = "Console_HUD_Red"
    'FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
    'consoleKicker.Kick 0, 30, 1.36
    vukCenterRamp.Kick 0, 120, .5
End Sub

Sub SwitchHitRampPin()
    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP_COLLECT, GAME_MODE_AUGMENTATION_RESEARCH) Then
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
            'TurnOffFluxFlasher(4)
            'FluxObjlevel(4) = 1.5
            'TurnOnFluxFlasher(4)
        
            'objFluxTimer(5).UserValue = 2
            'objFluxBase(5).UserValue = 1
            'objFluxOffBrightness(5) = 0.5
            'FluxObjlevel(5) = 0.1 : FlasherFluxTimer5_Timer
            'LightFluxFlash 5, FlasherFluxTimer5

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
        AddGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
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

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        Exit Sub
    End If

    gameState("game")("betHits") = gameState("game")("betHits") - 1
    
    DISPATCH GAME_CHECK_BET, Null

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

'***********************************************************************************************************************
'*****   Utilitiy Functions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function Min(value, minVal)
	if value < minVal then
		Min=Value
	Else 
		Min=minVal
	End If 
End Function

Function RndNum(min,max)
	RndNum = Int(Rnd()*(max-min+1))+min     ' Sets a random number between min AND max
End Function
Sub EnableWatchTimer(seconds)
	seconds = seconds + 0.3  'padding
	WatchDisplayTimerExpired.Interval = 1000 * seconds
	WatchDisplayTimerExpired.Enabled = True

	'p_watchdisplay_full.Visible = True
	p_watchdisplay_left.Visible = True
	p_watchdisplay_right.Visible = True

	'Set display to x seconds 
	dbstime = seconds
	dbsdelta = .1
	WatchDisplayUpdateTimer.Interval = 100

	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
    WatchDisplayUpdateTimer.Enabled = True
End Sub

Sub StopWatchDisplay
	WatchDisplayTimerExpired.Enabled = False
	WatchDisplayUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
End Sub

Sub WatchDisplayTimerExpired_Timer()
    WatchDisplayTimerExpired.Enabled = False
    WatchDisplayUpdateTimer.Enabled = False
	ResetBallSaveDisplay
End Sub

Sub ResetWatchDisplay
	p_watchdisplay_left.Visible = False
	p_watchdisplay_right.Visible = False
	p_watchdisplay_full.blenddisablelighting = 0
	p_watchdisplay_left.blenddisablelighting = 0
	p_watchdisplay_right.blenddisablelighting = 0
End Sub

Sub WatchDisplayUpdateTimer_Timer()
	Dim tmp
	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
End Sub
Function ReadIni( myFilePath, mySection, myKey )
    ' This function returns a value read from an INI file
    '
    ' Arguments:
    ' myFilePath  [string]  the (path and) file name of the INI file
    ' mySection   [string]  the section in the INI file to be searched
    ' myKey       [string]  the key whose value is to be returned
    '
    ' Returns:
    ' the [string] value for the specified key in the specified section
    '
    ' CAVEAT:     Will return a space if key exists but value is blank
    '
    ' Written by Keith Lacelle
    ' Modified by Denis St-Pierre and Rob van der Woude

    Const ForReading   = 1
    Const ForWriting   = 2
    Const ForAppending = 8

    Dim intEqualPos
    Dim objFSO, objIniFile
    Dim strFilePath, strKey, strLeftString, strLine, strSection

    Set objFSO = CreateObject( "Scripting.FileSystemObject" )

    ReadIni     = ""
    strFilePath = Trim( myFilePath )
    strSection  = Trim( mySection )
    strKey      = Trim( myKey )

    If objFSO.FileExists( strFilePath ) Then
        Set objIniFile = objFSO.OpenTextFile( strFilePath, ForReading, False )
        Do While objIniFile.AtEndOfStream = False
            strLine = Trim( objIniFile.ReadLine )

            ' Check if section is found in the current line
            If LCase( strLine ) = "[" & LCase( strSection ) & "]" Then
                strLine = Trim( objIniFile.ReadLine )

                ' Parse lines until the next section is reached
                Do While Left( strLine, 1 ) <> "["
                    ' Find position of equal sign in the line
                    intEqualPos = InStr( 1, strLine, "=", 1 )
                    If intEqualPos > 0 Then
                        strLeftString = Trim( Left( strLine, intEqualPos - 1 ) )
                        ' Check if item is found in the current line
                        If LCase( strLeftString ) = LCase( strKey ) Then
                            ReadIni = Trim( Mid( strLine, intEqualPos + 1 ) )
                            ' In case the item exists but value is blank
                            If ReadIni = "" Then
                                ReadIni = " "
                            End If
                            ' Abort loop when item is found
                            Exit Do
                        End If
                    End If

                    ' Abort if the end of the INI file is reached
                    If objIniFile.AtEndOfStream Then Exit Do

                    ' Continue with next line
                    strLine = Trim( objIniFile.ReadLine )
                Loop
            Exit Do
            End If
        Loop
        objIniFile.Close
    Else
        WScript.Echo strFilePath & " doesn't exists. Exiting..."
        Wscript.Quit 1
    End If
End Function
'***********************************************************************************************************************
'*****   Utilitiy Functions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function Min(value, minVal)
	if value < minVal then
		Min=Value
	Else 
		Min=minVal
	End If 
End Function

Function RndNum(min,max)
	RndNum = Int(Rnd()*(max-min+1))+min     ' Sets a random number between min AND max
End Function

'***********************************************************************************************************************
'*****   Ball Shadows                                          	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

'***************************************************************
'****  VPW DYNAMIC BALL SHADOWS by Iakki, Apophis, and Wylte
'***************************************************************

'****** INSTRUCTIONS please read ******

' The "DynamicBSUpdate" sub should be called with an interval of -1 (framerate)
' Place a toggleable variable (DynamicBallShadowsOn) in user options at the top of the script
' Import the "bsrtx7" and "ballshadow" images
' Import the shadow materials file (3 sets included) (you can also export the 3 sets from this table to create the same file)
' Copy in the sets of primitives named BallShadow#, RtxBallShadow#, and RtxBall2Shadow#, with at least as many objects each as there can be balls
'
' Create a collection called DynamicSources that includes all light sources you want to cast ball shadows
'***These must be organized in order, so that lights that intersect on the table are adjacent in the collection***
' This is because the code will only project two shadows if they are coming from lights that are consecutive in the collection
' The easiest way to keep track of this is to start with the group on the left slingshot and move clockwise around the table
'	For example, if you use 6 lights: A & B on the left slingshot and C & D on the right, with E near A&B and F next to C&D, your collection would look like EBACDF
'
'																E
'	A		 C													B
'	 B		D			your collection should look like		A		because E&B, B&A, etc. intersect; but B&D or E&F do not
'  E		  F													C
'																D
'																F
'
'Update shadow options in the code to fit your table and preference

'****** End Instructions ******

' *** Example timer sub

' The frame timer interval is -1, so executes at the display frame rate
'Sub FrameTimer_Timer()
'	If DynamicBallShadowsOn=1 Then DynamicBSUpdate 'update ball shadows
'End Sub

' *** These are usually defined elsewhere (ballrolling), but activate here if necessary

'Const tnob = 10 ' total number of balls
Const lob = 0	'locked balls on start; might need some fiddling depending on how your locked balls are done

' *** Example "Top of Script" User Option
'Const DynamicBallShadowsOn = 1		'0 = no dynamic ball shadow, 1 = enable dynamic ball shadow

' *** Shadow Options ***
Const fovY					= -2	'Offset y position under ball to account for layback or inclination (more pronounced need further back, -2 seems best for alignment at slings)
Const DynamicBSFactor 		= 0.95	'0 to 1, higher is darker, 1 will always be maxed even with 2 sources
Const AmbientBSFactor 		= 0.7	'0 to 1, higher is darker
Const Wideness				= 20	'Sets how wide the shadows can get (20 +5 thinness should be most realistic)
Const Thinness				= 5		'Sets minimum as ball moves away from source
' ***				 ***

Dim sourcenames, currentShadowCount

sourcenames = Array ("","","","","","","","","","","","")
currentShadowCount = Array (0,0,0,0,0,0,0,0,0,0,0,0)


dim objrtx1(20), objrtx2(20)
dim objBallShadow(20)
DynamicBSInit

sub DynamicBSInit()
	Dim iii

	for iii = 0 to tnob									'Prepares the shadow objects before play begins
		Set objrtx1(iii) = Eval("RtxBallShadow" & iii)
		objrtx1(iii).material = "RtxBallShadow" & iii
		objrtx1(iii).z = iii/1000 + 0.01
		objrtx1(iii).visible = 0
		'objrtx1(iii).uservalue=0

		Set objrtx2(iii) = Eval("RtxBall2Shadow" & iii)
		objrtx2(iii).material = "RtxBallShadow2_" & iii
		objrtx2(iii).z = (iii)/1000 + 0.02
		objrtx2(iii).visible = 0
		'objrtx2(iii).uservalue=0
		currentShadowCount(iii) = 0
		Set objBallShadow(iii) = Eval("BallShadow" & iii)
		objBallShadow(iii).material = "BallShadow" & iii
		objBallShadow(iii).Z = iii/1000 + 0.04
	Next
end sub


Sub DynamicBSUpdate
	Dim falloff:	falloff = 150			'Max distance to light sources, can be changed if you have a reason
	Const AmbientShadowOn = 1				'Toggle for just the moving shadow primitive (ninuzzu's)
	Dim ShadowOpacity, ShadowOpacity2 
	Dim s, Source, LSd, b, currentMat, AnotherSource, BOT
	BOT = GetBalls

	'Hide shadow of deleted balls
	For s = UBound(BOT) + 1 to tnob
		objrtx1(s).visible = 0
		objrtx2(s).visible = 0
		objBallShadow(s).visible = 0
	Next

	If UBound(BOT) = lob - 1 Then Exit Sub		'No balls in play, exit

'The Magic happens here
	For s = lob to UBound(BOT)

' *** Normal "ambient light" ball shadow
		If AmbientShadowOn = 1 Then
			If BOT(s).X < tablewidth/2 Then
				objBallShadow(s).X = ((BOT(s).X) - (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/13)) + 5
			Else
				objBallShadow(s).X = ((BOT(s).X) + (Ballsize/10) + ((BOT(s).X - (tablewidth/2))/13)) - 5
			End If
			objBallShadow(s).Y = BOT(s).Y + fovY

			If BOT(s).Z < 30 Then 'or BOT(s).Z > 105 Then		'Defining when (height-wise) you want ambient shadows
				objBallShadow(s).visible = 1
	'			objBallShadow(s).Z = BOT(s).Z - 25 + s/1000 + 0.04		'Uncomment if you want to add shadows to an upper/lower pf
			Else
				objBallShadow(s).visible = 0
			end if
		End If
' *** Dynamic shadows
		For Each Source in DynamicSources
			LSd=DistanceFast((BOT(s).x-Source.x),(BOT(s).y-Source.y))	'Calculating the Linear distance to the Source
			If BOT(s).Z < 30 Then 'Or BOT(s).Z > 105 Then				'Defining when (height-wise) you want dynamic shadows
				If LSd < falloff and Source.state=1 Then	    		'If the ball is within the falloff range of a light and light is on
					currentShadowCount(s) = currentShadowCount(s) + 1	'Within range of 1 or 2
					if currentShadowCount(s) = 1 Then					'1 dynamic shadow source
						sourcenames(s) = source.name
						currentMat = objrtx1(s).material
						objrtx2(s).visible = 0 : objrtx1(s).visible = 1 : objrtx1(s).X = BOT(s).X : objrtx1(s).Y = BOT(s).Y + fovY
'						objrtx1(s).Z = BOT(s).Z - 25 + s/1000 + 0.01							'Uncomment if you want to add shadows to an upper/lower pf
						objrtx1(s).rotz = AnglePP(Source.x, Source.y, BOT(s).X, BOT(s).Y) + 90
						ShadowOpacity = (falloff-LSd)/falloff									'Sets opacity/darkness of shadow by distance to light
						objrtx1(s).size_y = Wideness*ShadowOpacity+Thinness						'Scales shape of shadow with distance/opacity
						UpdateMaterial currentMat,1,0,0,0,0,0,ShadowOpacity*DynamicBSFactor^2,RGB(0,0,0),0,0,False,True,0,0,0,0
						'debug.print "update1" & source.name & " at:" & ShadowOpacity

						currentMat = objBallShadow(s).material
						UpdateMaterial currentMat,1,0,0,0,0,0,AmbientBSFactor*(1-ShadowOpacity),RGB(0,0,0),0,0,False,True,0,0,0,0

					Elseif currentShadowCount(s) = 2 Then
																'Same logic as 1 shadow, but twice
						currentMat = objrtx1(s).material
						set AnotherSource = Eval(sourcenames(s))
						objrtx1(s).visible = 1 : objrtx1(s).X = BOT(s).X : objrtx1(s).Y = BOT(s).Y + fovY
'						objrtx1(s).Z = BOT(s).Z - 25 + s/1000 + 0.01							'Uncomment if you want to add shadows to an upper/lower pf
						objrtx1(s).rotz = AnglePP(AnotherSource.x, AnotherSource.y, BOT(s).X, BOT(s).Y) + 90
						ShadowOpacity = (falloff-(((BOT(s).x-AnotherSource.x)^2+(BOT(s).y-AnotherSource.y)^2)^0.5))/falloff
						objrtx1(s).size_y = Wideness*ShadowOpacity+Thinness
						UpdateMaterial currentMat,1,0,0,0,0,0,ShadowOpacity*DynamicBSFactor^3,RGB(0,0,0),0,0,False,True,0,0,0,0

						currentMat = objrtx2(s).material
						objrtx2(s).visible = 1 : objrtx2(s).X = BOT(s).X : objrtx2(s).Y = BOT(s).Y + fovY
'						objrtx2(s).Z = BOT(s).Z - 25 + s/1000 + 0.02							'Uncomment if you want to add shadows to an upper/lower pf
						objrtx2(s).rotz = AnglePP(Source.x, Source.y, BOT(s).X, BOT(s).Y) + 90
						ShadowOpacity2 = (falloff-LSd)/falloff
						objrtx2(s).size_y = Wideness*ShadowOpacity2+Thinness
						UpdateMaterial currentMat,1,0,0,0,0,0,ShadowOpacity2*DynamicBSFactor^3,RGB(0,0,0),0,0,False,True,0,0,0,0
						'debug.print "update2: " & source.name & " at:" & ShadowOpacity & " and "  & Eval(sourcenames(s)).name & " at:" & ShadowOpacity2

						currentMat = objBallShadow(s).material
						UpdateMaterial currentMat,1,0,0,0,0,0,AmbientBSFactor*(1-max(ShadowOpacity,ShadowOpacity2)),RGB(0,0,0),0,0,False,True,0,0,0,0
					end if
				Else
					currentShadowCount(s) = 0
				End If
			Else									'Hide dynamic shadows everywhere else
				objrtx2(s).visible = 0 : objrtx1(s).visible = 0
			End If
		Next
	Next
End Sub


Function DistanceFast(x, y)
	dim ratio, ax, ay
	'Get absolute value of each vector
	ax = abs(x)
	ay = abs(y)
	'Create a ratio
	ratio = 1 / max(ax, ay)
	ratio = ratio * (1.29289 - (ax + ay) * ratio * 0.29289)
	if ratio > 0 then
		DistanceFast = 1/ratio
	Else
		DistanceFast = 0
	End if
end Function

Function max(a,b)
	if a > b then 
		max = a
	Else
		max = b
	end if
end Function
							'Enable these functions if they are not already present elswhere in your table
'Dim PI: PI = 4*Atn(1)

'Function Atn2(dy, dx)
'	If dx > 0 Then
'		Atn2 = Atn(dy / dx)
'	ElseIf dx < 0 Then
'		If dy = 0 Then 
'			Atn2 = pi
'		Else
'			Atn2 = Sgn(dy) * (pi - Atn(Abs(dy / dx)))
'		end if
'	ElseIf dx = 0 Then
'		if dy = 0 Then
'			Atn2 = 0
'		else
'			Atn2 = Sgn(dy) * pi / 2
'		end if
'	End If
'End Function
'
'Function AnglePP(ax,ay,bx,by)
'	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
'End Function

'****************************************************************
'****  END VPW DYNAMIC BALL SHADOWS by Iakki, Apophis, and Wylte
'****************************************************************
'***********************************************************************************************************************
'***** Bumpers                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Bumper1_Hit()
    PlaySoundAt SoundFXDOF("LeftBumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper1HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper1HitFlash)
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False OR Not gameState("game")("augmentationActive") = 4 OR Not gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
        If colorIndex = 0 Then
            DOF 203, DOFPulse
        Else
            DOF 205, DOFPulse
        End If
    End If
    DISPATCH SWITCH_HIT_BUMPER, null
End Sub

Sub Bumper2_Hit()
    PlaySoundAt SoundFXDOF("RightBumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper2HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper2HitFlash)
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False OR Not gameState("game")("augmentationActive") = 4 OR Not gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
        If colorIndex = 0 Then
            DOF 203, DOFPulse
        Else
            DOF 205, DOFPulse
        End If
    End If
    DISPATCH SWITCH_HIT_BUMPER, null
End Sub

Sub Bumper3_Hit()
    PlaySoundAt SoundFXDOF("BottomBumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper3HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper3HitFlash)
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False OR Not gameState("game")("augmentationActive") = 4 OR Not gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
        If colorIndex = 0 Then
            DOF 203, DOFPulse
        Else
            DOF 205, DOFPulse
        End If
    End If
    DISPATCH SWITCH_HIT_BUMPER, null
End Sub
'***********************************************************************************************************************
'*****  DOF    	                                                                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

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

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Flubber Flashers                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim TestFlashers, TableRef, FlasherLightIntensity, FlasherFlareIntensity, FlasherOffBrightness

								' *********************************************************************
TestFlashers = 0				' *** set this to 1 to check position of flasher object 			***
Set TableRef = Table1   		' *** change this, if your table has another name       			***
FlasherLightIntensity = 0.1		' *** lower this, if the VPX lights are too bright (i.e. 0.1)		***
FlasherFlareIntensity = 1		' *** lower this, if the flares are too bright (i.e. 0.1)			***
FlasherOffBrightness = 0.1		' *** brightness of the flasher dome when switched off (range 0-2)	***
								' *********************************************************************

Dim ObjLevel(20), objbase(20), objlit(20), objflasher(20), objlight(20), objPulse(20)
'Dim tablewidth, tableheight : tablewidth = TableRef.width : tableheight = TableRef.height
'initialise the flasher color, you can only choose from "green", "red", "purple", "blue", "white" and "yellow"
'InitFlasher 1, "white"
'InitFlasher 2, "white"
'InitFlasher 3, "white"
'InitFlasher 4, "white"
'InitFlasher 3, "white"
'InitFlasher 4, "white"
'InitFlasher 5, "white"
'InitFlasher 1, "green" : InitFlasher 2, "red" : 
'InitFlasher 4, "green" : InitFlasher 5, "red" : InitFlasher 6, "white"
'InitFlasher 7, "green" : InitFlasher 8, "red"
'InitFlasher 9, "green" : InitFlasher 10, "red" : InitFlasher 11, "white" 
' rotate the flasher with the command below (first argument = flasher nr, second argument = angle in degrees)
'RotateFlasher 3,90 ': RotateFlasher 5,0 : RotateFlasher 6,90
'RotateFlasher 7,0 : RotateFlasher 8,0 
'RotateFlasher 9,-45 : RotateFlasher 10,90 : RotateFlasher 11,90

Sub InitFlasher(nr, col)
	' store all objects in an array for use in FlashFlasher subroutine
	Set objbase(nr) = Eval("Flasherbase" & nr) : Set objlit(nr) = Eval("Flasherlit" & nr)
	Set objflasher(nr) = Eval("Flasherflash" & nr) : Set objlight(nr) = Eval("Flasherlight" & nr)
	' If the flasher is parallel to the playfield, rotate the VPX flasher object for POV and place it at the correct height
	If objbase(nr).RotY = 0 Then
		objbase(nr).ObjRotZ =  atn( (tablewidth/2 - objbase(nr).x) / (objbase(nr).y - tableheight*1.1)) * 180 / 3.14159
		objflasher(nr).RotZ = objbase(nr).ObjRotZ : objflasher(nr).height = objbase(nr).z + 60
	End If
	' set all effects to invisible and move the lit primitive at the same position and rotation as the base primitive
	objlight(nr).IntensityScale = 0 : objlit(nr).visible = 0 : objlit(nr).material = "Flashermaterial" & nr
	objlit(nr).RotX = objbase(nr).RotX : objlit(nr).RotY = objbase(nr).RotY : objlit(nr).RotZ = objbase(nr).RotZ
	objlit(nr).ObjRotX = objbase(nr).ObjRotX : objlit(nr).ObjRotY = objbase(nr).ObjRotY : objlit(nr).ObjRotZ = objbase(nr).ObjRotZ
	objlit(nr).x = objbase(nr).x : objlit(nr).y = objbase(nr).y : objlit(nr).z = objbase(nr).z
	objbase(nr).BlendDisableLighting = FlasherOffBrightness
	' set the texture and color of all objects
	select case objbase(nr).image
		Case "dome2basewhite" : objbase(nr).image = "dome2base" & col : objlit(nr).image = "dome2lit" & col : 
		Case "ronddomebasewhite" : objbase(nr).image = "ronddomebase" & col : objlit(nr).image = "ronddomelit" & col
		Case "domeearbasewhite" : objbase(nr).image = "domeearbase" & col : objlit(nr).image = "domeearlit" & col
	end select
	If TestFlashers = 0 Then objflasher(nr).imageA = "domeflashwhite" : objflasher(nr).visible = 0 : End If
	select case col
		Case "blue" :   objlight(nr).color = RGB(4,120,255) : objflasher(nr).color = RGB(200,255,255) : objlight(nr).intensity = 5000
		Case "green" :  objlight(nr).color = RGB(12,255,4) : objflasher(nr).color = RGB(12,255,4)
		Case "red" :    objlight(nr).color = RGB(255,32,4) : objflasher(nr).color = RGB(255,32,4)
		Case "purple" : objlight(nr).color = RGB(230,49,255) : objflasher(nr).color = RGB(255,64,255) 
		Case "yellow" : objlight(nr).color = RGB(200,173,25) : objflasher(nr).color = RGB(255,200,50)
		Case "white" :  objlight(nr).color = RGB(255,240,150) : objflasher(nr).color = RGB(100,86,59)
	end select
	objlight(nr).intensity = 5000
	objlight(nr).colorfull = objlight(nr).color
	If TableRef.ShowDT and ObjFlasher(nr).RotX = -45 Then 
		objflasher(nr).height = objflasher(nr).height - 20 * ObjFlasher(nr).y / tableheight
		ObjFlasher(nr).y = ObjFlasher(nr).y + 10
	End If
	objPulse(nr) = 1
End Sub

Sub RotateFlasher(nr, angle) : angle = ((angle + 360 - objbase(nr).ObjRotZ) mod 180)/30 : objbase(nr).showframe(angle) : objlit(nr).showframe(angle) : End Sub

Sub FlashFlasher(nr)
	Exit Sub
	If not objflasher(nr).TimerEnabled Then objflasher(nr).TimerEnabled = True : objflasher(nr).visible = 1 : objlit(nr).visible = 1 : End If
	objflasher(nr).opacity = 1000 *  FlasherFlareIntensity * ObjLevel(nr)^2.5
	objlight(nr).IntensityScale = 0.5 * FlasherLightIntensity * ObjLevel(nr)^3
	objbase(nr).BlendDisableLighting =  FlasherOffBrightness + 10 * ObjLevel(nr)^3	
	objlit(nr).BlendDisableLighting = 10 * ObjLevel(nr)^2
	UpdateMaterial "Flashermaterial" & nr,0,0,0,0,0,0,ObjLevel(nr),RGB(255,255,255),0,0,False,True,0,0,0,0 
	ObjLevel(nr) = ObjLevel(nr) * 0.9 - 0.01
	If ObjLevel(nr) < 0.2 And objPulse(nr) > 0 Then
			FlashDome nr, -1, objPulse(nr)-1
	ElseIf ObjLevel(nr) < 0 Then
			objflasher(nr).TimerEnabled = False : objflasher(nr).visible = 0 : objlit(nr).visible = 0
			objbase(nr).image = "dome2basewhite"
			objlit(nr).image = "dome2litwhite"
	End If
End Sub

Sub FlasherFlash1_Timer() : FlashFlasher(1) : End Sub 
Sub FlasherFlash2_Timer() : FlashFlasher(2) : End Sub 
Sub FlasherFlash3_Timer() : FlashFlasher(3) : End Sub 
Sub FlasherFlash4_Timer() : FlashFlasher(4) : End Sub 
Sub FlasherFlash5_Timer() : FlashFlasher(5) : End Sub 
Sub FlasherFlash6_Timer() : FlashFlasher(6) : End Sub 
Sub FlasherFlash7_Timer() : FlashFlasher(7) : End Sub
Sub FlasherFlash8_Timer() : FlashFlasher(8) : End Sub
Sub FlasherFlash9_Timer() : FlashFlasher(9) : End Sub
Sub FlasherFlash10_Timer() : FlashFlasher(10) : End Sub
Sub FlasherFlash11_Timer() : FlashFlasher(11) : End Sub


Sub FlashDome(Idx, color, pulseCount)
	Exit Sub
	If color > -1 Then
		objlit(Idx).image = gameDomes(color)
		objlight(Idx).color = gameColors(color)
		objlight(Idx).colorfull = objlight(Idx).color
	End If
	objlevel(Idx) = 1
	objPulse(Idx) = pulseCount
	Execute "FlashFlasher "&Idx

End Sub

Sub FlashDomes(color, pulseCount)
	Exit Sub
	Dim flasherDome
	'MsgBox(Ubound(flasherDomes))
	Dim totalTimeout : totalTimeout = 0
	For flasherDome = 0 to Ubound(objflasher)-1
		
		If Not IsEmpty(objflasher(flasherDome)) Then
			'Debug.print "flasherdome > "&flasherDome
			If color > -1 Then
				objlit(flasherDome).image = gameDomes(color)
				objlight(flasherDome).color = gameColors(color)
				objlight(flasherDome).colorfull = objlight(flasherDome).color
			End If
			objlevel(flasherDome) = 1
			objPulse(flasherDome) = pulseCount-1

			Dim rndTimeout : rndTimeout = RndNum(100,300)
			totalTimeout=totalTimeout+rndTimeout
			vpmTimer.addtimer rndTimeout, "vpmTimerFlasherPulseRandom "&flasherDome&" '"
			
		End If
	next
	DISPATCH LIGHTS_GI_OFF, Null
	DISPATCH LIGHTS_GI_DOMES, color
	vpmTimer.addtimer totalTimeout+(200*pulseCount), "vpmTimerFlasherPulseFinished '"
End Sub

Sub vpmTimerFlasherPulseRandom(Idx)
	Execute "FlashFlasher "&Idx
End Sub

Sub vpmTimerFlasherPulseFinished
  DISPATCH LIGHTS_GI_ON, Null
End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Flux Flashers (Flubber alt light hack)           	                                                    	****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim TestFluxFlashers, FluxFlasherFluxLightIntensity, FluxFlasherFlareIntensity, FluxFlasherOffBrightness

								' *********************************************************************
TestFluxFlashers = 0				' *** set this to 1 to check position of flasher object 			***
FluxFlasherFluxLightIntensity = 0.1		' *** lower this, if the VPX lights are too bright (i.e. 0.1)		***
FluxFlasherFlareIntensity = 1		' *** lower this, if the flares are too bright (i.e. 0.1)			***
FluxFlasherOffBrightness = 0.1		' *** brightness of the flasher dome when switched off (range 0-2)	***
								' *********************************************************************

Dim FluxObjLevel(20), objFluxBase(20), objFluxLit(20), objFluxTimer(20), objFluxOffBrightness(20)
'Dim tablewidth, tableheight : tablewidth = TableRef.width : tableheight = TableRef.height
'initialise the flasher color, you can only choose from "green", "red", "purple", "blue", "white" and "yellow"
'InitFluxFlasher 1, 0.4
'InitFluxFlasher 2, 0.4
'InitFluxFlasher 3, 2
'InitFluxFlasher 4, 1.5
'InitFluxFlasher 5, 2
'InitFluxFlasher 6, 2
'InitFluxFlasher 7, 2
'InitFluxFlasher 8, 2
'InitFluxFlasher 9, 2
'InitFluxFlasher 10, 2
'InitFluxFlasher 7, "white"
'InitFluxFlasher 8, "white"
'InitFluxFlasher 9, "white"
'InitFluxFlasher 10, "white"
'InitFluxFlasher 11, "white"
'InitFluxFlasher 12, "white"
'InitFluxFlasher 13, "white"
'InitFluxFlasher 14, "white"
'InitFluxFlasher 15, "white"
'InitFluxFlasher 16, "white"
'InitFluxFlasher 1, "green" : InitFluxFlasher 2, "red" : 
'InitFluxFlasher 4, "green" : InitFluxFlasher 5, "red" : InitFluxFlasher 6, "white"
'InitFluxFlasher 7, "green" : InitFluxFlasher 8, "red"
'InitFluxFlasher 9, "green" : InitFluxFlasher 10, "red" : InitFluxFlasher 11, "white" 
' rotate the flasher with the command below (first argument = flasher nr, second argument = angle in degrees)
'RotateFluxFlasher 3,90 ': RotateFluxFlasher 5,0 : RotateFluxFlasher 6,90
'RotateFluxFlasher 7,0 : RotateFluxFlasher 8,0 
'RotateFluxFlasher 9,-45 : RotateFluxFlasher 10,90 : RotateFluxFlasher 11,90

Sub InitFluxFlasher(nr, col)
	' store all objects in an array for use in FlashFluxFlasher subroutine
	Set objFluxBase(nr) = Eval("FlasherFluxBase" & nr)
	objFluxBase(nr).UserValue = col
	objFluxOffBrightness(nr) = FluxFlasherOffBrightness
	''Set objFluxLit(nr) = Eval("FlasherFluxLit" & nr)
	Set objFluxTimer(nr) = Eval("FlasherFluxTimer" & nr)
	' If the flasher is parallel to the playfield, rotate the VPX flasher object for POV and place it at the correct height
	''objFluxLit(nr).visible = 0 : objFluxLit(nr).material = "Flashermaterial" & nr
	''objFluxLit(nr).RotX = objFluxBase(nr).RotX : objFluxLit(nr).RotY = objFluxBase(nr).RotY : objFluxLit(nr).RotZ = objFluxBase(nr).RotZ
	''objFluxLit(nr).ObjRotX = objFluxBase(nr).ObjRotX : objFluxLit(nr).ObjRotY = objFluxBase(nr).ObjRotY : objFluxLit(nr).ObjRotZ = objFluxBase(nr).ObjRotZ
	''objFluxLit(nr).x = objFluxBase(nr).x : objFluxLit(nr).y = objFluxBase(nr).y : objFluxLit(nr).z = objFluxBase(nr).z
	objFluxBase(nr).BlendDisableLighting = FluxFlasherOffBrightness
End Sub

'FADING ROUTINE
Sub FlashFluxFlasher(nr)
'	If not objFluxFlasher(nr).TimerEnabled Then objFluxFlasher(nr).TimerEnabled = True : objFluxFlasher(nr).visible = 1 : objFluxLit(nr).visible = 1 : End If
'	objFluxFlasher(nr).opacity = 1000 *  FluxFlasherFlareIntensity * FluxObjLevel(nr)^2.5
'	objFluxBase(nr).BlendDisableLighting =  FluxFlasherOffBrightness + 10 * FluxObjLevel(nr)^3	
'	objFluxLit(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2
'	FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
'	If FluxObjLevel(nr) < 0 Then 
'		objFluxFlasher(nr).TimerEnabled = False
'		objFluxFlasher(nr).visible = 0
'		objFluxLit(nr).visible = 0
'	End If
End Sub

'FADING ROUTINE
Sub TurnOnFluxFlasher(nr)
'	If not objFluxFlasher(nr).TimerEnabled Then objFluxFlasher(nr).TimerEnabled = True : objFluxFlasher(nr).visible = 1 : objFluxLit(nr).visible = 1 : End If
'	objFluxFlasher(nr).opacity = 1000 *  FluxFlasherFlareIntensity * FluxObjLevel(nr)^2.5
	objFluxBase(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2 'FluxFlasherOffBrightness + 10 * FluxObjLevel(nr)^3	
'	objFluxLit(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2
	'FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
	'If FluxObjLevel(nr) < 0 Then 
'		objFluxFlasher(nr).TimerEnabled = False
'		objFluxFlasher(nr).visible = 0
'		objFluxLit(nr).visible = 0
'	End If
End Sub

Sub PulseFluxFlasher(nr)
	If not objFluxTimer(nr).Enabled Then objFluxTimer(nr).Enabled = True End If
	objFluxBase(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2	
	If objFluxTimer(nr).UserValue <= 1 Then
		FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
	ElseIf objFluxTimer(nr).UserValue = 2 Then
		FluxObjLevel(nr) = FluxObjLevel(nr) * 1 + 0.01
	End If
	If FluxObjLevel(nr) < objFluxOffBrightness(nr) Then 
		If objFluxTimer(nr).UserValue = 0 Then
			TurnOffFluxFlasher(nr)
		Else
			FluxObjLevel(nr) = objFluxOffBrightness(nr)
			objFluxTimer(nr).UserValue = 2
		End If
	ElseIf FluxObjLevel(nr) > objFluxBase(nr).UserValue Then 
		FluxObjLevel(nr) = objFluxBase(nr).UserValue
		objFluxTimer(nr).UserValue = 1
	End If
End Sub

Sub TurnOffFluxFlasher(nr)
'	If not objFluxFlasher(nr).TimerEnabled Then objFluxFlasher(nr).TimerEnabled = True : objFluxFlasher(nr).visible = 1 : objFluxLit(nr).visible = 1 : End If
'	objFluxFlasher(nr).opacity = 1000 *  FluxFlasherFlareIntensity * FluxObjLevel(nr)^2.5
	'objFluxTimer(nr).Enabled = False
	'objFluxBase(nr).BlendDisableLighting = FluxFlasherOffBrightness
	'objFluxBase(nr).Material = "FlasherFluxMaterial" & nr

	'LightFluxFlashOff(nr)
'	objFluxLit(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2
	'FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
	'If FluxObjLevel(nr) < 0 Then 
'		objFluxFlasher(nr).TimerEnabled = False
'		objFluxFlasher(nr).visible = 0
'		objFluxLit(nr).visible = 0
'	End If
End Sub

Sub FlasherFluxTimer1_Timer() : PulseFluxFlasher(1) : End Sub
Sub FlasherFluxTimer2_Timer() : PulseFluxFlasher(2) : End Sub
Sub FlasherFluxTimer3_Timer() : PulseFluxFlasher(3) : End Sub
Sub FlasherFluxTimer4_Timer() : PulseFluxFlasher(4) : End Sub
Sub FlasherFluxTimer5_Timer() : PulseFluxFlasher(5) : End Sub
Sub FlasherFluxTimer6_Timer() : PulseFluxFlasher(6) : End Sub
Sub FlasherFluxTimer7_Timer() : PulseFluxFlasher(7) : End Sub
Sub FlasherFluxTimer8_Timer() : PulseFluxFlasher(8) : End Sub
Sub FlasherFluxTimer9_Timer() : PulseFluxFlasher(9) : End Sub
Sub FlasherFluxTimer10_Timer() : PulseFluxFlasher(10) : End Sub

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  NFOZZY                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const ReflipAngle = 20

'******************************************************
'		FLIPPER CORRECTION INITIALIZATION
'******************************************************

dim LF : Set LF = New FlipperPolarity
dim RF : Set RF = New FlipperPolarity

InitPolarity

Sub InitPolarity()
	dim x, a : a = Array(LF, RF)
	for each x in a
		x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1	'disabled
		x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
		x.enabled = True
		x.TimeDelay = 60
	Next

	AddPt "Polarity", 0, 0, 0
	AddPt "Polarity", 1, 0.05, -5.5
	AddPt "Polarity", 2, 0.4, -5.5
	AddPt "Polarity", 3, 0.6, -5.0
	AddPt "Polarity", 4, 0.65, -4.5
	AddPt "Polarity", 5, 0.7, -4.0
	AddPt "Polarity", 6, 0.75, -3.5
	AddPt "Polarity", 7, 0.8, -3.0
	AddPt "Polarity", 8, 0.85, -2.5
	AddPt "Polarity", 9, 0.9,-2.0
	AddPt "Polarity", 10, 0.95, -1.5
	AddPt "Polarity", 11, 1, -1.0
	AddPt "Polarity", 12, 1.05, -0.5
	AddPt "Polarity", 13, 1.1, 0
	AddPt "Polarity", 14, 1.3, 0

	addpt "Velocity", 0, 0, 	1
	addpt "Velocity", 1, 0.16, 1.06
	addpt "Velocity", 2, 0.41, 	1.05
	addpt "Velocity", 3, 0.53, 	1'0.982
	addpt "Velocity", 4, 0.702, 0.968
	addpt "Velocity", 5, 0.95,  0.968
	addpt "Velocity", 6, 1.03, 	0.945

	LF.Object = LeftFlipper	
	LF.EndPoint = EndPointLp
	RF.Object = RightFlipper
	RF.EndPoint = EndPointRp
End Sub

Sub TriggerLF_Hit() : LF.Addball activeball :End Sub
Sub TriggerLF_UnHit() : LF.PolarityCorrect activeball : End Sub
Sub TriggerRF_Hit() : RF.Addball activeball : End Sub
Sub TriggerRF_UnHit() : RF.PolarityCorrect activeball : End Sub

'******************************************************
'			FLIPPER CORRECTION FUNCTIONS
'******************************************************

Sub AddPt(aStr, idx, aX, aY)	'debugger wrapper for adjusting flipper script in-game
	dim a : a = Array(LF, RF)
	dim x : for each x in a
		x.addpoint aStr, idx, aX, aY
	Next
End Sub

Class FlipperPolarity
	Public DebugOn, Enabled
	Private FlipAt	'Timer variable (IE 'flip at 723,530ms...)
	Public TimeDelay	'delay before trigger turns off and polarity is disabled TODO set time!
	private Flipper, FlipperStart,FlipperEnd, FlipperEndY, LR, PartialFlipCoef
	Private Balls(20), balldata(20)
	
	dim PolarityIn, PolarityOut
	dim VelocityIn, VelocityOut
	dim YcoefIn, YcoefOut
	Public Sub Class_Initialize 
		redim PolarityIn(0) : redim PolarityOut(0) : redim VelocityIn(0) : redim VelocityOut(0) : redim YcoefIn(0) : redim YcoefOut(0)
		Enabled = True : TimeDelay = 50 : LR = 1:  dim x : for x = 0 to uBound(balls) : balls(x) = Empty : set Balldata(x) = new SpoofBall : next 
	End Sub
	
	Public Property let Object(aInput) : Set Flipper = aInput : StartPoint = Flipper.x : End Property
	Public Property Let StartPoint(aInput) : if IsObject(aInput) then FlipperStart = aInput.x else FlipperStart = aInput : end if : End Property
	Public Property Get StartPoint : StartPoint = FlipperStart : End Property
	Public Property Let EndPoint(aInput) : FlipperEnd = aInput.x: FlipperEndY = aInput.y: End Property
	Public Property Get EndPoint : EndPoint = FlipperEnd : End Property	
	Public Property Get EndPointY: EndPointY = FlipperEndY : End Property
	
	Public Sub AddPoint(aChooseArray, aIDX, aX, aY) 'Index #, X position, (in) y Position (out) 
		Select Case aChooseArray
			case "Polarity" : ShuffleArrays PolarityIn, PolarityOut, 1 : PolarityIn(aIDX) = aX : PolarityOut(aIDX) = aY : ShuffleArrays PolarityIn, PolarityOut, 0
			Case "Velocity" : ShuffleArrays VelocityIn, VelocityOut, 1 :VelocityIn(aIDX) = aX : VelocityOut(aIDX) = aY : ShuffleArrays VelocityIn, VelocityOut, 0
			Case "Ycoef" : ShuffleArrays YcoefIn, YcoefOut, 1 :YcoefIn(aIDX) = aX : YcoefOut(aIDX) = aY : ShuffleArrays YcoefIn, YcoefOut, 0
		End Select
		if gametime > 100 then Report aChooseArray
	End Sub 

	Public Sub Report(aChooseArray) 	'debug, reports all coords in tbPL.text
		if not DebugOn then exit sub
		dim a1, a2 : Select Case aChooseArray
			case "Polarity" : a1 = PolarityIn : a2 = PolarityOut
			Case "Velocity" : a1 = VelocityIn : a2 = VelocityOut
			Case "Ycoef" : a1 = YcoefIn : a2 = YcoefOut 
			case else :tbpl.text = "wrong string" : exit sub
		End Select
		dim str, x : for x = 0 to uBound(a1) : str = str & aChooseArray & " x: " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		tbpl.text = str
	End Sub
	
	Public Sub AddBall(aBall) : dim x : for x = 0 to uBound(balls) : if IsEmpty(balls(x)) then set balls(x) = aBall : exit sub :end if : Next  : End Sub

	Private Sub RemoveBall(aBall)
		dim x : for x = 0 to uBound(balls)
			if TypeName(balls(x) ) = "IBall" then 
				if aBall.ID = Balls(x).ID Then
					balls(x) = Empty
					Balldata(x).Reset
				End If
			End If
		Next
	End Sub
	
	Public Sub Fire() 
		Flipper.RotateToEnd
		processballs
	End Sub

	Public Property Get Pos 'returns % position a ball. For debug stuff.
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				pos = pSlope(Balls(x).x, FlipperStart, 0, FlipperEnd, 1)
			End If
		Next		
	End Property

	Public Sub ProcessBalls() 'save data of balls in flipper range
		FlipAt = GameTime
		
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				balldata(x).Data = balls(x)
			End If
		Next
		PartialFlipCoef = ((Flipper.StartAngle - Flipper.CurrentAngle) / (Flipper.StartAngle - Flipper.EndAngle))
		PartialFlipCoef = abs(PartialFlipCoef-1)
	End Sub
	Private Function FlipperOn() : if gameTime < FlipAt+TimeDelay then FlipperOn = True : End If : End Function	'Timer shutoff for polaritycorrect
	
	Public Sub PolarityCorrect(aBall)
		if FlipperOn() then 
			dim tmp, BallPos, x, IDX, Ycoef : Ycoef = 1

			'y safety Exit
			if aBall.VelY > -8 then 'ball going down
				RemoveBall aBall
				exit Sub
			end if

			'Find balldata. BallPos = % on Flipper
			for x = 0 to uBound(Balls)
				if aBall.id = BallData(x).id AND not isempty(BallData(x).id) then 
					idx = x
					BallPos = PSlope(BallData(x).x, FlipperStart, 0, FlipperEnd, 1)
					if ballpos > 0.65 then  Ycoef = LinearEnvelope(BallData(x).Y, YcoefIn, YcoefOut)				'find safety coefficient 'ycoef' data
				end if
			Next

			If BallPos = 0 Then 'no ball data meaning the ball is entering and exiting pretty close to the same position, use current values.
				BallPos = PSlope(aBall.x, FlipperStart, 0, FlipperEnd, 1)
				if ballpos > 0.65 then  Ycoef = LinearEnvelope(aBall.Y, YcoefIn, YcoefOut)						'find safety coefficient 'ycoef' data
			End If

			'Velocity correction
			if not IsEmpty(VelocityIn(0) ) then
				Dim VelCoef
	 : 			VelCoef = LinearEnvelope(BallPos, VelocityIn, VelocityOut)

				if partialflipcoef < 1 then VelCoef = PSlope(partialflipcoef, 0, 1, 1, VelCoef)

				if Enabled then aBall.Velx = aBall.Velx*VelCoef
				if Enabled then aBall.Vely = aBall.Vely*VelCoef
			End If

			'Polarity Correction (optional now)
			if not IsEmpty(PolarityIn(0) ) then
				If StartPoint > EndPoint then LR = -1	'Reverse polarity if left flipper
				dim AddX : AddX = LinearEnvelope(BallPos, PolarityIn, PolarityOut) * LR
	
				if Enabled then aBall.VelX = aBall.VelX + 1 * (AddX*ycoef*PartialFlipcoef)
				'playsound "fx_knocker"
			End If
		End If
		RemoveBall aBall
	End Sub
End Class

'******************************************************
'		FLIPPER POLARITY AND RUBBER DAMPENER
'			SUPPORTING FUNCTIONS 
'******************************************************

' Used for flipper correction and rubber dampeners
Sub ShuffleArray(ByRef aArray, byVal offset) 'shuffle 1d array
	dim x, aCount : aCount = 0
	redim a(uBound(aArray) )
	for x = 0 to uBound(aArray)	'Shuffle objects in a temp array
		if not IsEmpty(aArray(x) ) Then
			if IsObject(aArray(x)) then 
				Set a(aCount) = aArray(x)
			Else
				a(aCount) = aArray(x)
			End If
			aCount = aCount + 1
		End If
	Next
	if offset < 0 then offset = 0
	redim aArray(aCount-1+offset)	'Resize original array
	for x = 0 to aCount-1		'set objects back into original array
		if IsObject(a(x)) then 
			Set aArray(x) = a(x)
		Else
			aArray(x) = a(x)
		End If
	Next
End Sub

' Used for flipper correction and rubber dampeners
Sub ShuffleArrays(aArray1, aArray2, offset)
	ShuffleArray aArray1, offset
	ShuffleArray aArray2, offset
End Sub

' Used for flipper correction, rubber dampeners, and drop targets
Function BallSpeed(ball) 'Calculates the ball speed
    BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

' Used for flipper correction and rubber dampeners
Function PSlope(Input, X1, Y1, X2, Y2)	'Set up line via two points, no clamping. Input X, output Y
	dim x, y, b, m : x = input : m = (Y2 - Y1) / (X2 - X1) : b = Y2 - m*X2
	Y = M*x+b
	PSlope = Y
End Function

' Used for flipper correction
Class spoofball 
	Public X, Y, Z, VelX, VelY, VelZ, ID, Mass, Radius 
	Public Property Let Data(aBall)
		With aBall
			x = .x : y = .y : z = .z : velx = .velx : vely = .vely : velz = .velz
			id = .ID : mass = .mass : radius = .radius
		end with
	End Property
	Public Sub Reset()
		x = Empty : y = Empty : z = Empty  : velx = Empty : vely = Empty : velz = Empty 
		id = Empty : mass = Empty : radius = Empty
	End Sub
End Class

' Used for flipper correction and rubber dampeners
Function LinearEnvelope(xInput, xKeyFrame, yLvl)
	dim y 'Y output
	dim L 'Line
	dim ii : for ii = 1 to uBound(xKeyFrame)	'find active line
		if xInput <= xKeyFrame(ii) then L = ii : exit for : end if
	Next
	if xInput > xKeyFrame(uBound(xKeyFrame) ) then L = uBound(xKeyFrame)	'catch line overrun
	Y = pSlope(xInput, xKeyFrame(L-1), yLvl(L-1), xKeyFrame(L), yLvl(L) )

	if xInput <= xKeyFrame(lBound(xKeyFrame) ) then Y = yLvl(lBound(xKeyFrame) ) 	'Clamp lower
	if xInput >= xKeyFrame(uBound(xKeyFrame) ) then Y = yLvl(uBound(xKeyFrame) )	'Clamp upper

	LinearEnvelope = Y
End Function

' Used for drop targets and flipper tricks
Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

'******************************************************
'			FLIPPER TRICKS
'******************************************************

RightFlipper.timerinterval=1
Rightflipper.timerenabled=True

sub RightFlipper_timer()
	FlipperTricks LeftFlipper, LFPress, LFCount, LFEndAngle, LFState
	FlipperTricks RightFlipper, RFPress, RFCount, RFEndAngle, RFState
	FlipperNudge RightFlipper, RFEndAngle, RFEOSNudge, LeftFlipper, LFEndAngle
	FlipperNudge LeftFlipper, LFEndAngle, LFEOSNudge,  RightFlipper, RFEndAngle
end sub

Dim LFEOSNudge, RFEOSNudge

Sub FlipperNudge(Flipper1, Endangle1, EOSNudge1, Flipper2, EndAngle2)
	Dim BOT, b

	If abs(Flipper1.currentangle) < abs(Endangle1) + 3 and EOSNudge1 <> 1 Then
		EOSNudge1 = 1
		If Flipper2.currentangle = EndAngle2 Then 
			BOT = GetBalls
			For b = 0 to Ubound(BOT)
				If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper1) Then
					'Debug.Print "ball in flip1. exit"
 					exit Sub
				end If
			Next
			For b = 0 to Ubound(BOT)
				If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper2) Then
					'debug.print "flippernudge!!"
					BOT(b).velx = BOT(b).velx /1.3
					BOT(b).vely = BOT(b).vely - 0.7
				end If
			Next
		End If
	Else 
		If abs(Flipper1.currentangle) > abs(Endangle1) + 30 then EOSNudge1 = 0
	End If
End Sub

'*************************************************
' Check ball distance from Flipper for Rem
'*************************************************

Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

Function DistancePL(px,py,ax,ay,bx,by) ' Distance between a point and a line where point is px,py
	DistancePL = ABS((by - ay)*px - (bx - ax) * py + bx*ay - by*ax)/Distance(ax,ay,bx,by)
End Function

Function Radians(Degrees)
	Radians = Degrees * PI /180
End Function

Function AnglePP(ax,ay,bx,by)
	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
End Function

Function Atn2(dy, dx)
	dim pi
	pi = 4*Atn(1)

	If dx > 0 Then
		Atn2 = Atn(dy / dx)
	ElseIf dx < 0 Then
		If dy = 0 Then 
			Atn2 = pi
		Else
			Atn2 = Sgn(dy) * (pi - Atn(Abs(dy / dx)))
		end if
	ElseIf dx = 0 Then
		if dy = 0 Then
			Atn2 = 0
		else
			Atn2 = Sgn(dy) * pi / 2
		end if
	End If
End Function

Function DistanceFromFlipper(ballx, bally, Flipper)
	DistanceFromFlipper = DistancePL(ballx, bally, Flipper.x, Flipper.y, Cos(Radians(Flipper.currentangle+90))+Flipper.x, Sin(Radians(Flipper.currentangle+90))+Flipper.y)
End Function

Function FlipperTrigger(ballx, bally, Flipper)
	Dim DiffAngle
	DiffAngle  = ABS(Flipper.currentangle - AnglePP(Flipper.x, Flipper.y, ballx, bally) - 90)
	If DiffAngle > 180 Then DiffAngle = DiffAngle - 360

	If DistanceFromFlipper(ballx,bally,Flipper) < 48 and DiffAngle <= 90 and Distance(ballx,bally,Flipper.x,Flipper.y) < Flipper.Length Then
		FlipperTrigger = True
	Else
		FlipperTrigger = False
	End If	
End Function

'*************************************************
' End - Check ball distance from Flipper for Rem
'*************************************************


dim LFPress, RFPress, LFCount, RFCount
dim LFState, RFState
dim EOST, EOSA,Frampup, FElasticity,FReturn
dim RFEndAngle, LFEndAngle

EOST = leftflipper.eostorque
EOSA = leftflipper.eostorqueangle
Frampup = LeftFlipper.rampup
FElasticity = LeftFlipper.elasticity
FReturn = LeftFlipper.return
Const EOSTnew = 0.8 
Const EOSAnew = 1
Const EOSRampup = 0
Dim SOSRampup
SOSRampup = 2.5
Const LiveCatch = 32
Const LiveElasticity = 0.45
Const SOSEM = 0.815
Const EOSReturn = 0.025


LFEndAngle = Leftflipper.endangle
RFEndAngle = RightFlipper.endangle

Sub FlipperActivate(Flipper, FlipperPress)
	FlipperPress = 1
	Flipper.Elasticity = FElasticity

	Flipper.eostorque = EOST 	
	Flipper.eostorqueangle = EOSA 	
End Sub

Sub FlipperDeactivate(Flipper, FlipperPress)
	FlipperPress = 0
	Flipper.eostorqueangle = EOSA
	Flipper.eostorque = EOST*EOSReturn/FReturn

	
	If Abs(Flipper.currentangle) <= Abs(Flipper.endangle) + 0.1 Then
		Dim BOT, b
		BOT = GetBalls
			
		For b = 0 to UBound(BOT)
			If Distance(BOT(b).x, BOT(b).y, Flipper.x, Flipper.y) < 55 Then 'check for cradle
				If BOT(b).vely >= -0.4 Then BOT(b).vely = -0.4
			End If
		Next
	End If
End Sub

Sub FlipperTricks (Flipper, FlipperPress, FCount, FEndAngle, FState) 
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)	'-1 for Right Flipper

	If Abs(Flipper.currentangle) > Abs(Flipper.startangle) - 0.05 Then
		If FState <> 1 Then
			Flipper.rampup = SOSRampup 
			Flipper.endangle = FEndAngle - 3*Dir
			Flipper.Elasticity = FElasticity * SOSEM
			FCount = 0 
			FState = 1
		End If
	ElseIf Abs(Flipper.currentangle) <= Abs(Flipper.endangle) and FlipperPress = 1 then
		if FCount = 0 Then FCount = GameTime

		If FState <> 2 Then
			Flipper.eostorqueangle = EOSAnew
			Flipper.eostorque = EOSTnew
			Flipper.rampup = EOSRampup			
			Flipper.endangle = FEndAngle
			FState = 2
		End If
	Elseif Abs(Flipper.currentangle) > Abs(Flipper.endangle) + 0.01 and FlipperPress = 1 Then 
		If FState <> 3 Then
			Flipper.eostorque = EOST	
			Flipper.eostorqueangle = EOSA
			Flipper.rampup = Frampup
			Flipper.Elasticity = FElasticity
			FState = 3
		End If

	End If
End Sub

Const LiveDistanceMin = 30  'minimum distance in vp units from flipper base live catch dampening will occur
Const LiveDistanceMax = 114  'maximum distance in vp units from flipper base live catch dampening will occur (tip protection)

Sub CheckLiveCatch(ball, Flipper, FCount, parm) 'Experimental new live catch
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)    '-1 for Right Flipper
	Dim LiveCatchBounce															'If live catch is not perfect, it won't freeze ball totally
	Dim CatchTime : CatchTime = GameTime - FCount

	if CatchTime <= LiveCatch and parm > 6 and ABS(Flipper.x - ball.x) > LiveDistanceMin and ABS(Flipper.x - ball.x) < LiveDistanceMax Then
		if CatchTime <= LiveCatch*0.8 Then						'Perfect catch only when catch time happens in the beginning of the window
			LiveCatchBounce = 0
		else
			LiveCatchBounce = Abs((LiveCatch/2) - CatchTime)	'Partial catch when catch happens a bit late
		end If

		If LiveCatchBounce = 0 and ball.velx * Dir > 0 Then ball.velx = 0
		ball.vely = LiveCatchBounce * (16 / LiveCatch) ' Multiplier for inaccuracy bounce
		ball.angmomx= 0
		ball.angmomy= 0
		ball.angmomz= 0
	End If
End Sub

'*****************************************************************************************************
'*******************************************************************************************************
'END nFOZZY FLIPPERS'










'******************************************************
'		FLIPPERS PRIMS & SHADOWS
'******************************************************
sub FlipperTimer()
	'pleftFlipper.rotz=leftFlipper.CurrentAngle
	'UPleftFlipper.rotz=ULeftFlipper.CurrentAngle
	'prightFlipper.rotz=rightFlipper.CurrentAngle
	Dim r: r = LeftFlipper.CurrentAngle
    LFLogo.RotZ = LeftFlipper.CurrentAngle
	'Flipper_3_BM_World.ObjRotz = r
	'Flipper_3_LM_GI.ObjRotz = r

	r = RightFlipper.CurrentAngle
	'ULFLogo.RotZ = ULeftFlipper.CurrentAngle
    RFLogo.RotZ = r 'RightFlipper.CurrentAngle
	'Flipper_3_002_BM_World.Rotz = r
	'Flipper_3_002_LM_GI.Rotz = r
	
end sub

Sub LeftFlipper_Collide(parm)
	LeftFlipperCollide parm
	CheckLiveCatch Activeball, LeftFlipper, LFCount, parm
	if RubberizerEnabled <> 0 then Rubberizer(parm)
End Sub

Sub RightFlipper_Collide(parm)
	RightFlipperCollide parm
	CheckLiveCatch Activeball, RightFlipper, RFCount, parm
	if RubberizerEnabled <> 0 then Rubberizer(parm)
End Sub

sub Rubberizer(parm)
	if parm < 10 And parm > 2 And Abs(activeball.angmomz) < 10 then
		'debug.print "parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * 2
		activeball.vely = activeball.vely * 1.2
		'debug.print ">> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	Elseif parm <= 2 and parm > 0.2 Then
		'debug.print "* parm: " & parm & " momz: " & activeball.angmomz &" vely: "& activeball.vely
		activeball.angmomz = activeball.angmomz * 0.5
		activeball.vely = activeball.vely * 1.4
		'debug.print "**** >> newmomz: " & activeball.angmomz&" newvely: "& activeball.vely
	end if
end sub
'***********************************************************************************************************************
'*****  TABLE KEYS                                            	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Table1_KeyDown(ByVal Keycode)

    If gameStarted = False Then

        If keyCode = 30 Then 'A
            'LightSeqAllLights.StopPlay
            'LightSeqAllLights.UpdateInterval = 2000
            'LightSeqAllLights.Play SeqMiddleOutHorizOn , 12, 0
	    End If
		
        If keycode = StartGameKey Then
            StartGame()
        End If

        If keycode = LeftMagnaSave then
            lutpos = lutpos - 1 : If lutpos < 0 Then lutpos = 0 : end if
            Table1.ColorGradeImage = luts(lutpos)
        End if
    
        If keycode = RightMagnaSave then
            lutpos = lutpos + 1 : If lutpos > 5 Then lutpos = 5: end if
            Table1.ColorGradeImage = luts(lutpos)
        End if

    Else
    
        If keycode = PlungerKey Then
            PlaySoundAt "fx_plungerpull", Plunger
            Plunger.Pullback
        End If
        
        debugKeys(Keycode)
        If keyCode = 66 Then 'F8
            DebugPostState
        End If

        If keycode = 46 then ' C Key
            If contball = 1 Then
                contball = 0
            Else
                contball = 1
            End If
        End If
        if keycode = 203 then bcleft = 1 ' Left Arrow
        if keycode = 200 then bcup = 1 ' Up Arrow
        if keycode = 208 then bcdown = 1 ' Down Arrow
        if keycode = 205 then bcright = 1 ' Right Arrow

        If keycode = LeftTiltKey Then Nudge 90, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, -0.1, 0.25
        If keycode = RightTiltKey Then Nudge 270, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, 0.1, 0.25
        If keycode = CenterTiltKey Then Nudge 0, 7:PlaySound SoundFX("fx_nudge",0), 0, 1, 1, 0.25
        'TODO ADD CHECK TILT
        
        If keycode = LeftFlipperKey Then
            'LeftFlipper.RotateToEnd
            'PlaySound SoundFX("fx_flipperup",DOFFlippers), 0, .67, AudioPan(LeftFlipper), 0.05,0,0,1,AudioFade(LeftFlipper)
            
            FlipperActivate LeftFlipper,LFPress
            LF.Fire
        
            If LeftFlipper.currentangle < LeftFlipper.endangle + ReflipAngle Then 
                RandomSoundReflipUpLeft LeftFlipper
            Else 
                SoundFlipperUpAttackLeft LeftFlipper
                RandomSoundFlipperUpLeft LeftFlipper
            End If
            
            
            
            Dispatch SWITCH_LEFT_FLIPPER_DOWN, Null
        End If
        
        If keycode = RightFlipperKey Then 
            'RightFlipper.RotateToEnd
            UpRightFlipper.RotateToEnd
            'UpRightFlipper001.RotateToEnd
            'PlaySound SoundFX("fx_flipperup",DOFFlippers), 0, .67, AudioPan(RightFlipper), 0.05,0,0,1,AudioFade(RightFlipper)
            FlipperActivate RightFlipper, RFPress
            RF.Fire

            If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then
                RandomSoundReflipUpRight RightFlipper
            Else 
                SoundFlipperUpAttackRight RightFlipper
                RandomSoundFlipperUpRight RightFlipper
            End If
            
            Dispatch SWITCH_RIGHT_FLIPPER_DOWN, Null
        End If
    End If
End Sub


Sub Table1_KeyUp(ByVal keycode)
    
    	
    'Manual Ball Control

	if keycode = 203 then bcleft = 0 ' Left Arrow
	if keycode = 200 then bcup = 0 ' Up Arrow
	if keycode = 208 then bcdown = 0 ' Down Arrow
	if keycode = 205 then bcright = 0 ' Right Arrow
    
    If keycode = PlungerKey Then
        PlaySoundAt "fx_plunger", Plunger
        Plunger.Fire
    End If
    
    ' Table specific
    If keycode = LeftFlipperKey Then
       ''ldown = 0
        'LeftFlipper.RotateToStart
        'PlaySound SoundFX("fx_flipperdown",DOFFlippers), 0, 1, AudioPan(LeftFlipper), 0.05,0,0,1,AudioFade(LeftFlipper)
        FlipperDeActivate LeftFlipper, LFPress
		LeftFlipper.RotateToStart
		If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
			RandomSoundFlipperDownLeft LeftFlipper
		End If
		FlipperLeftHitParm = FlipperUpSoundLevel
    End If
    If keycode = RightFlipperKey Then
       ''rdown = 0
        'RightFlipper.RotateToStart
        FlipperDeActivate RightFlipper, RFPress
        UpRightFlipper.RotateToStart
        'UpRightFlipper001.RotateToStart
        'PlaySound SoundFX("fx_flipperdown",DOFFlippers), 0, 1, AudioPan(RightFlipper), 0.05,0,0,1,AudioFade(RightFlipper)
        RightFlipper.RotateToStart
		If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
			RandomSoundFlipperDownRight RightFlipper
		End If	
		FlipperRightHitParm = FlipperUpSoundLevel
    End If

    
End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  LAMPS                                                	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


'***************************************
'***Begin nFozzy lamp handling***
'***************************************

Dim NullFader : set NullFader = new NullFadingObject
Dim Lampz : Set Lampz = New LampFader
Dim ModLampz : Set ModLampz = New DynamicLamps
'Dim ModLampzPerk : 'Set ModLampzPerk = New DynamicLamps
InitLampsNF              ' Setup lamp assignments

Sub InitLampsNF()

	'Filtering (comment out to disable)
	Lampz.Filter = "LampFilter"	'Puts all lamp intensity scale output (no callbacks) through this function before updating
	ModLampz.Filter = "LampFilter"
'	ModLampzPerk.Filter = "LampFilter"
	'Adjust fading speeds (1 / full MS fading time)
	dim x : for x = 0 to 140 : Lampz.FadeSpeedUp(x) = 1/80 : Lampz.FadeSpeedDown(x) = 1/100 : next
	Lampz.FadeSpeedUp(110) = 1/64 'GI

'*********************************************************************************************************************************************************
'End nfozzy lamp handling
'*********************************************************************************************************************************************************
	Lampz.MassAssign(0) = l_aug1
    Lampz.MassAssign(1) = l_aug4
	Lampz.MassAssign(2) = l_aug7
    Lampz.MassAssign(3) = l_aug2
    Lampz.MassAssign(4) = l_aug5
	Lampz.MassAssign(5) = l_aug8
    Lampz.MassAssign(6) = l_aug3
    Lampz.MassAssign(7) = l_aug6
	Lampz.MassAssign(8) = l_aug9
	Lampz.MassAssign(9) = l_bet1
	Lampz.MassAssign(10) = l_bet2
	Lampz.MassAssign(11) = l_bet3
	Lampz.MassAssign(21) = l_pw2
	Lampz.MassAssign(22) = l_pw3
	Lampz.MassAssign(23) = l_pw4
	Lampz.MassAssign(25) = l_research

	Lampz.MassAssign(15) = l_augsign1
	'Lampz.Callback(15) = "DisableLighting p_augsign_1, 45,"
	Lampz.MassAssign(16) = l_augsign2
	'Lampz.Callback(16) = "DisableLighting p_augsign_2, 45,"
	Lampz.MassAssign(17) = l_augsign3
	'Lampz.Callback(17) = "DisableLighting p_augsign_3, 45,"
	Lampz.MassAssign(18) = l_augsign4
	'Lampz.Callback(18) = "DisableLighting p_augsign_4, 45,"
	Lampz.MassAssign(19) = l_augsign5
	'Lampz.Callback(19) = "DisableLighting p_augsign_5, 45,"

	
	Lampz.MassAssign(26) = l_captive1
	Lampz.MassAssign(27) = l_captive2
	Lampz.MassAssign(28) = l_captive3
	Lampz.MassAssign(29) = l_captive4
	Lampz.MassAssign(30) = l_holdaug

	Lampz.MassAssign(31) = l_leftOrbit
	Lampz.MassAssign(32) = l_leftRamp
	Lampz.MassAssign(33) = l_spinner1
	Lampz.MassAssign(39) = l_spinner2
	Lampz.MassAssign(34) = l_centerRamp
	Lampz.MassAssign(35) = l_rightRamp
	Lampz.MassAssign(36) = l_rightOrbit
	
	Lampz.MassAssign(37) = l_shortcutReady
	Lampz.MassAssign(38) = l_hyperJump1
	Lampz.MassAssign(45) = l_hyperJump2
	Lampz.MassAssign(43) = l_hyperJump3
	Lampz.MassAssign(44) = l_hyperJump4
	Lampz.MassAssign(68) = l_hyperJump5

	Lampz.MassAssign(40) = LBBump1Flash
	Lampz.MassAssign(41) = LBBump2Flash
	Lampz.MassAssign(42) = LBBump3Flash

	Lampz.MassAssign(46) = l_shortcut1
	Lampz.MassAssign(47) = l_shortcut2
	Lampz.MassAssign(48) = l_shortcut3

	Lampz.MassAssign(49) = l_finish

	Lampz.MassAssign(50) = l_olr1a
	Lampz.MassAssign(51) = l_olr1b
	Lampz.MassAssign(52) = l_olr2a
	Lampz.MassAssign(53) = l_olr2b
	Lampz.MassAssign(54) = l_olr3a
	Lampz.MassAssign(55) = l_olr3b
	Lampz.MassAssign(56) = l_olr4a
	Lampz.MassAssign(57) = l_olr4b
	Lampz.MassAssign(58) = l_olr5a
	Lampz.MassAssign(59) = l_olr5b
	Lampz.MassAssign(60) = l_olr6a
	Lampz.MassAssign(61) = l_olr6b
	Lampz.MassAssign(62) = l_olr7a
	Lampz.MassAssign(63) = l_olr7b
	Lampz.MassAssign(64) = l_olr8a
	Lampz.MassAssign(65) = l_olr8b
	Lampz.MassAssign(66) = l_olr9a
	Lampz.MassAssign(67) = l_olr9b

	Lampz.MassAssign(70) = l_oll1a
	Lampz.MassAssign(71) = l_oll1b
	Lampz.MassAssign(72) = l_oll2a
	Lampz.MassAssign(73) = l_oll2b
	Lampz.MassAssign(74) = l_oll3a
	Lampz.MassAssign(75) = l_oll3b
	Lampz.MassAssign(76) = l_oll4a
	Lampz.MassAssign(77) = l_oll4b
	Lampz.MassAssign(78) = l_oll5a
	Lampz.MassAssign(79) = l_oll5b
	Lampz.MassAssign(80) = l_oll6a
	Lampz.MassAssign(81) = l_oll6b
	Lampz.MassAssign(82) = l_oll7a
	Lampz.MassAssign(83) = l_oll7b
	Lampz.MassAssign(84) = l_oll8a
	Lampz.MassAssign(85) = l_oll8b
	Lampz.MassAssign(86) = l_oll9a
	Lampz.MassAssign(87) = l_oll9b

	Lampz.MassAssign(90) = l_lane1
	Lampz.MassAssign(91) = l_lane2
	Lampz.MassAssign(92) = l_lane3
	Lampz.MassAssign(93) = l_lane4
	
	Lampz.MassAssign(94) = l_px2
	Lampz.MassAssign(95) = l_px4
	Lampz.MassAssign(96) = l_px5

	Lampz.MassAssign(97) = l_extraball
	Lampz.MassAssign(98) = l_lock

	Lampz.MassAssign(100) = l_race1
	Lampz.MassAssign(101) = l_race2
	Lampz.MassAssign(102) = l_race3
	Lampz.MassAssign(103) = l_race4
	Lampz.MassAssign(104) = l_race5
	Lampz.MassAssign(105) = l_race6
	Lampz.MassAssign(106) = l_raceWizard

	Lampz.MassAssign(107) = l_bx2
	Lampz.MassAssign(108) = l_bx4
	Lampz.MassAssign(109) = l_bx5

	Lampz.MassAssign(110) = l_cyber1
	Lampz.MassAssign(111) = l_cyber2
	Lampz.MassAssign(112) = l_cyber3
	Lampz.MassAssign(113) = l_cyber4
	Lampz.MassAssign(114) = l_cyber5

	Lampz.MassAssign(115) = l_combo1
	Lampz.MassAssign(116) = l_combo2
	Lampz.MassAssign(117) = l_combo3
	Lampz.MassAssign(118) = l_combo4
	Lampz.MassAssign(119) = l_combo5
	
	Lampz.MassAssign(120) = l_pop1
	Lampz.MassAssign(121) = l_pop2
	Lampz.MassAssign(122) = l_pop3

	Lampz.MassAssign(123) = l_ballsave

	Lampz.MassAssign(130) = l_watch
	'Lampz.Callback(130) = "DisableLighting p_watchdisplay_full, 45,"
	Lampz.MassAssign(131) = l_watch
	'Lampz.Callback(131) = "DisableLighting p_watchdisplay_left, 45,"
	Lampz.MassAssign(132) = l_watch
	'Lampz.Callback(132) = "DisableLighting p_watchdisplay_right, 45,"


	Lampz.MassAssign(133) = l_plungerlane1
	'Lampz.Callback(133) = "DisableLighting p_plungerSign1, 45,"
	Lampz.MassAssign(134) = l_plungerlane2
	'Lampz.Callback(134) = "DisableLighting p_plungerSign2, 45,"
	Lampz.MassAssign(135) = l_plungerlane3
	'Lampz.Callback(135) = "DisableLighting p_plungerSign3, 45,"

	Lampz.MassAssign(136) = l_speederToy
	'Lampz.Callback(136) = "DisableLighting p_speederToy, 45,"
	'Lampz.Callback(136) = "PriSwapImage p_speederToy, l_speederToy.Image,"

	' Sync on l_bet2 ' VLM.Lampz;Inserts-l_bet2
	Lampz.Callback(10) = "UpdateLightMap 10,Playfield_LM_Inserts_l_bet2, 200.00, " ' VLM.Lampz;Inserts-l_bet2
	' Sync on l_bet3 ' VLM.Lampz;Inserts-l_bet3
	Lampz.Callback(11) = "UpdateLightMap 11,Playfield_LM_Inserts_l_bet3, 200.00, " ' VLM.Lampz;Inserts-l_bet3
	' Sync on l_cyber1 ' VLM.Lampz;Inserts-l_cyber1
	Lampz.Callback(110) = "UpdateLightMap 110,Playfield_LM_Inserts_l_cyber1, 200.00, " ' VLM.Lampz;Inserts-l_cyber1
	' Sync on l_cyber2 ' VLM.Lampz;Inserts-l_cyber2
	Lampz.Callback(111) = "UpdateLightMap 111,Playfield_LM_Inserts_l_cyber2, 200.00, " ' VLM.Lampz;Inserts-l_cyber2
	' Sync on l_cyber3 ' VLM.Lampz;Inserts-l_cyber3
	Lampz.Callback(112) = "UpdateLightMap 112,Playfield_LM_Inserts_l_cyber3, 200.00, " ' VLM.Lampz;Inserts-l_cyber3
	' Sync on l_cyber4 ' VLM.Lampz;Inserts-l_cyber4
	Lampz.Callback(113) = "UpdateLightMap 113,Playfield_LM_Inserts_l_cyber4, 200.00, " ' VLM.Lampz;Inserts-l_cyber4
	' Sync on l_cyber5 ' VLM.Lampz;Inserts-l_cyber5
	Lampz.Callback(114) = "UpdateLightMap 114,Playfield_LM_Inserts_l_cyber5, 200.00, " ' VLM.Lampz;Inserts-l_cyber5
	' Sync on l_holdaug ' VLM.Lampz;Inserts-l_holdaug
	Lampz.Callback(30) = "UpdateLightMap 30,Playfield_LM_Inserts_l_holdaug, 200.00, " ' VLM.Lampz;Inserts-l_holdaug
	' Sync on l_leftOrbit ' VLM.Lampz;Inserts-l_leftOrbit
	Lampz.Callback(31) = "UpdateLightMap 31,Layer_2_LM_Inserts_l_leftOrbit, 200.00, " ' VLM.Lampz;Inserts-l_leftOrbit
	Lampz.Callback(31) = "UpdateLightMap 31,Playfield_LM_Inserts_l_leftOrbi, 200.00, " ' VLM.Lampz;Inserts-l_leftOrbit
	' Sync on l_leftRamp ' VLM.Lampz;Inserts-l_leftRamp
	Lampz.Callback(32) = "UpdateLightMap 32,Playfield_LM_Inserts_l_leftRamp, 200.00, " ' VLM.Lampz;Inserts-l_leftRamp
	' Sync on l_centerRamp ' VLM.Lampz;Inserts-l_centerRamp
	Lampz.Callback(34) = "UpdateLightMap 34,Playfield_LM_Inserts_l_centerRa, 200.00, " ' VLM.Lampz;Inserts-l_centerRamp
	' Sync on l_rightRamp ' VLM.Lampz;Inserts-l_rightRamp
	Lampz.Callback(35) = "UpdateLightMap 35,Playfield_LM_Inserts_l_rightRam, 200.00, " ' VLM.Lampz;Inserts-l_rightRamp
	' Sync on l_rightOrbit ' VLM.Lampz;Inserts-l_rightOrbit
	Lampz.Callback(36) = "UpdateLightMap 36,Playfield_LM_Inserts_l_rightOrb, 200.00, " ' VLM.Lampz;Inserts-l_rightOrbit
	' Sync on l_shortcutReady ' VLM.Lampz;Inserts-l_shortcutReady
	Lampz.Callback(37) = "UpdateLightMap 37,Playfield_LM_Inserts_l_shortcut, 200.00, " ' VLM.Lampz;Inserts-l_shortcutReady
	' Sync on l_bet1 ' VLM.Lampz;Inserts-l_bet1
	Lampz.Callback(9) = "UpdateLightMap 9,Playfield_LM_Inserts_l_bet1, 200.00, " ' VLM.Lampz;Inserts-l_bet1
	' Sync on l_extraball ' VLM.Lampz;Inserts-l_extraball
	Lampz.Callback(97) = "UpdateLightMap 97,Playfield_LM_Inserts_l_extrabal, 200.00, " ' VLM.Lampz;Inserts-l_extraball
	' Sync on l_lock ' VLM.Lampz;Inserts-l_lock
	Lampz.Callback(98) = "UpdateLightMap 98,Playfield_LM_Inserts_l_lock, 200.00, " ' VLM.Lampz;Inserts-l_lock


	'p_racer_lights.blenddisablelighting = 15
	'Lampz.State(133) = 1
	'Lampz.MassAssign(100) = L58
	'Lampz.MassAssign(101) = L25
	'Lampz.MassAssign(110) = l_alert_a
	

''*****************
''GI Assignments
''*****************
'	Lampz.Callback(110) = "GIupdates"
'	Lampz.obj(110) = ColtoArray(GI)	
'	Lampz.state(110) = 1		'Turn on GI to Start

	'ModLampz.Callback(0) = "GIUpdates"
	ModLampz.MassAssign(0)= ColToArray(GI) 


	dim ii
	For each ii in GI:ii.IntensityScale = 0.3:Next
	'For each ii in GI_PF:ii.IntensityScale = 1:Next
	'For each ii in GI_PF:ii.Falloff = 400:Next
	

'	'Turn off all lamps on startup
'	lampz.TurnOnStates	'Set any lamps state to 1. (Object handles fading!)
'	lampz.update
		'Turn off all lamps on startup
	lampz.Init	'This just turns state of any lamps to 1
	ModLampz.Init
	'ModLampzPerk.Init

	'Immediate update to turn on GI, turn off lamps
	lampz.update
	ModLampz.Update
	'ModLampzPerk.Update


End Sub

Sub UpdateLightMap(idx, lightmap, intensity, ByVal aLvl)
	If useLightMapper = true And IsObject(lightmap) Then
   		'if ModLampz.UseFunction then aLvl = ModLampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
   		lightmap.Opacity = aLvl * intensity
		Debug.print(idx)
			If Idx > 0 Then
			lightmap.Color = Lampz.lampColor(idx)
		End If
	End If
End Sub

Dim fps: fps = 0
Sub fpsTimer_Timer

	'("FPS: " & fps)
	fps=0

End Sub

dim FrameTime, InitFrameTime : InitFrameTime = 0
Sub LampTimer()
	dim x, chglamp
	
	FrameTime = gametime - InitFrameTime : InitFrameTime = gametime
	Dispatch LIGHTS_UPDATE, FrameTime

	fps=fps+1
	
	'Lampz.Update1 ' what does this do
	Lampz.Update2 ' what does this do
	ModLampz.Update2 ' what does this do
	'ModLampzPerk.Update2 ' what does this do
End Sub

Function FlashLevelToIndex(Input, MaxSize)
	FlashLevelToIndex = cInt(MaxSize * Input)
End Function



'Material swap arrays.
Dim TextureArray1: TextureArray1 = Array("Plastic with an image trans", "Plastic with an image trans","Plastic with an image trans","Plastic with an image")


Dim DLintensity
'***************************************
'***Prim Image Swaps***
'***************************************
Sub ImageSwap(pri, group, DLintensity, ByVal aLvl)	'cp's script  DLintensity = disabled lighting intesity
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
    Select case FlashLevelToIndex(aLvl, 3)
		Case 1:pri.Image = group(0) 'Full
		Case 2:pri.Image = group(1) 'Fading...
		Case 3:pri.Image = group(2) 'Fading...
        Case 4:pri.Image = group(3) 'Off
    End Select
pri.blenddisablelighting = aLvl * DLintensity
End Sub


'***************************************
'***Prim Material Swaps***
'***************************************
Sub MatSwap(pri, group, DLintensity, ByVal aLvl)	'cp's script  DLintensity = disabled lighting intesity
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
    Select case FlashLevelToIndex(aLvl, 3)
		Case 1:pri.Material = group(0) 'Full
		Case 2:pri.Material = group(1) 'Fading...
		Case 3:pri.Material = group(2) 'Fading...
              Case 4:pri.Material = group(3) 'Off
    End Select
pri.blenddisablelighting = aLvl * DLintensity
End Sub


Sub FadeMaterialToys(pri, group, ByVal aLvl)	'cp's script
'	if Lampz.UseFunction then aLvl = LampFilter(aLvl)	'Callbacks don't get this filter automatically
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
    Select case FlashLevelToIndex(aLvl, 3)
		Case 0:pri.Material = group(0) 'Off
		Case 1:pri.Material = group(1) 'Fading...
		Case 2:pri.Material = group(2) 'Fading...
        Case 3:pri.Material = group(3) 'Full
    End Select
	'if tb.text <> pri.image then tb.text = pri.image : debug.print pri.image end If	'debug
pri.blenddisablelighting = aLvl * 1 'Intensity Adjustment
End Sub



Sub DisableLighting(pri, DLintensity, ByVal aLvl)	'cp's script  DLintensity = disabled lighting intesity
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
	pri.blenddisablelighting = aLvl * DLintensity * 0.4
End Sub

Sub PriSwapImage(pri, image, ByVal aLvl)	'cp's script  DLintensity = disabled lighting intesity
	pri.Image = image
End Sub






'***************************************
'GI off insert lamps intensity boost
'***************************************
Dim GIoffMult : GIoffMult = 3 'Multiplies all non-GI inserts lights opacities when the GI is off 
Sub GIupdates(ByVal aLvl)	'GI update odds and ends go here

	'DebugOut("GIupdates;"+Cstr(aLvl))
	if Lampz.UseFunction then aLvl = LampFilter(aLvl)	'Callbacks don't get this filter automatically
	'SetGIColor
	'Fade lamps up when GI is off
'	dim GIscale
'	GiScale = (GIoffMult-1) * (ABS(aLvl-1 )  ) + 1	'invert
'	dim x : for x = 0 to uBound(LightsA) 
'		On Error Resume Next
'		LightsA(x).Opacity = LightsB(x) * GIscale
'		LightsA(x).Intensity = LightsB(x) * GIscale
'		'LightsA(x).FadeSpeedUp = LightsC(x) * GIscale
'		'LightsA(x).FadeSpeedDown = LightsD(x) * GIscale
'		On Error Goto 0
'	Next
End Sub

'***************************************
'GI off finsert light falloff-power boost
'***************************************
Dim GiOffFOP
Sub SetGI(aNr, aValue)
	'DebugOut("SETTING GI MAIN FROM CORE.vbs ; "+ Cstr(aNr) + " ; " + Cstr(aValue))
	ModLampz.SetGI aNr, aValue 'Redundant. Could reassign GI indexes here
'	GestioneGIWall
	SetGIColor
End Sub

Sub SetGIPerk(aNr, aValue)
	'DebugOut("SETTING GI MAIN FROM CORE.vbs ; "+ Cstr(aNr) + " ; " + Cstr(aValue))
	'ModLampzPerk.SetGI aNr, aValue 'Redundant. Could reassign GI indexes here
'	GestioneGIWall
	'SetGIColor
End Sub

'***GI Color Mod***
Dim GIxx, ColorModRed, ColorModRedFull, ColorModGreen, ColorModGreenFull, ColorModBlue, ColorModBlueFull
Dim GIColorRed, GIColorGreen, GIColorBlue, GIColorFullRed, GIColorFullGreen, GIColorFullBlue, GIColor

'GIColorRed       =  61
'GIColorGreen     =  12
'GIColorBlue      =  97

GIColorRed       =  255
GIColorGreen     =  195
GIColorBlue      =  100
dim GIColorRedOrig : GIColorRedOrig =  GIColorRed
dim GIColorGreenOrig : GIColorGreenOrig = GIColorGreen
dim GIColorBlueOrig : GIColorBlueOrig = GIColorBlue

Sub SetGIColor ()

'	for each GIxx in GILighting
'	GIxx.Color = rgb(GIColorRed, GIColorGreen, GIColorBlue)
'	GIxx.ColorFull = rgb(GIColorFullRed, GIColorFullGreen, GIColorFullBlue)
'	next
	const ColorMultiplier = 0.8
	const FullColorMultiplier = 0.95
	'debug.print GIColorRed &" - "& GIColorGreen &" - "& GIColorBlue
	for each GIxx in GI
	GIxx.Color = rgb(GIColorRed*ColorMultiplier, GIColorGreen*ColorMultiplier, GIColorBlue*ColorMultiplier)
	GIxx.ColorFull = rgb(GIColorRed*FullColorMultiplier, GIColorGreen*FullColorMultiplier, GIColorBlue*FullColorMultiplier)
	GIColor = GIxx.ColorFull
	next
	'FlasherRGBGI.Color = GIColor
End Sub

'Lamp Filter
Function LampFilter(aLvl)

	LampFilter = aLvl^1.6	'exponential curve?
End Function

Function ColtoArray(aDict)	'converts a collection to an indexed array. Indexes will come out random probably.
	redim a(999)
	dim count : count = 0
	dim x  : for each x in aDict : set a(Count) = x : count = count + 1 : Next
	redim preserve a(count-1) : ColtoArray = a
End Function

Sub SetLamp(aNr, aOn)
	Lampz.state(aNr) = abs(aOn)
End Sub

Sub SetModLamp(aNr, aInput)


	'If aNr=0 Then
		'DebugOut(Cstr(aNr)+"="+Cstr(abs(aInput)/255))
	'End If
	ModLampz.state(aNr) = abs(aInput)/255
End Sub

'*********************************************************************************************************************************************************
'End lamp helper functions
'*********************************************************************************************************************************************************

'*********************************************************************************************************************************************************
'End lamp helper functions
'*********************************************************************************************************************************************************






'====================
'Class jungle nf
'=============

'No-op object instead of adding more conditionals to the main loop
'It also prevents errors if empty lamp numbers are called, and it's only one object
'should be g2g?

Class NullFadingObject : Public Property Let IntensityScale(input) : End Property End Class

'version 0.11 - Mass Assign, Changed modulate style
'version 0.12 - Update2 (single -1 timer update) update method for core.vbs
'Version 0.12a - Filter can now be accessed via 'FilterOut'
'Version 0.12b - Changed MassAssign from a sub to an indexed property (new syntax: lampfader.MassAssign(15) = Light1 )
'Version 0.13 - No longer requires setlocale. Callback() can be assigned multiple times per index
' Note: if using multiple 'LampFader' objects, set the 'name' variable to avoid conflicts with callbacks

Class LampFader
	Public FadeSpeedDown(140), FadeSpeedUp(140)
	Private Lock(140), Loaded(140), OnOff(140)
	Public UseFunction
	Private cFilter
	Public UseCallback(140), cCallback(140)
	Public Lvl(140), Obj(140)
	Private Mult(140)
	Public FrameTime
	Private InitFrame
	Public Name

	Sub Class_Initialize()
		InitFrame = 0
		dim x : for x = 0 to uBound(OnOff) 	'Set up fade speeds
			FadeSpeedDown(x) = 1/100	'fade speed down
			FadeSpeedUp(x) = 1/80		'Fade speed up
			UseFunction = False
			lvl(x) = 0
			OnOff(x) = False
			Lock(x) = True : Loaded(x) = False
			Mult(x) = 1
		Next
		Name = "LampFaderNF" 'NEEDS TO BE CHANGED IF THERE'S MULTIPLE OF THESE OBJECTS, OTHERWISE CALLBACKS WILL INTERFERE WITH EACH OTHER!!
		for x = 0 to uBound(OnOff) 		'clear out empty obj
			if IsEmpty(obj(x) ) then Set Obj(x) = NullFader' : Loaded(x) = True
		Next
	End Sub

	Public Property Get Locked(idx) : Locked = Lock(idx) : End Property		'debug.print Lampz.Locked(100)	'debug
	Public Property Get state(idx) : state = OnOff(idx) : end Property
	Public Property Get lampColor(idx) : lampColor = obj(idx).colorFull : end Property
	Public Property Get image(idx) : image = obj(idx).Image : end Property
	
	Public Property Let Filter(String) : Set cFilter = GetRef(String) : UseFunction = True : End Property
	Public Function FilterOut(aInput) : if UseFunction Then FilterOut = cFilter(aInput) Else FilterOut = aInput End If : End Function
	'Public Property Let Callback(idx, String) : cCallback(idx) = String : UseCallBack(idx) = True : End Property
	Public Property Let Callback(idx, String)
		UseCallBack(idx) = True
		'cCallback(idx) = String 'old execute method
		'New method: build wrapper subs using ExecuteGlobal, then call them
		cCallback(idx) = cCallback(idx) & "___" & String	'multiple strings dilineated by 3x _

		dim tmp : tmp = Split(cCallback(idx), "___")

		dim str, x : for x = 0 to uBound(tmp)	'build proc contents
			'If Not tmp(x)="" then str = str & "	" & tmp(x) & " aLVL" & "	'" & x & vbnewline	'more verbose
			If Not tmp(x)="" then str = str & tmp(x) & " aLVL:"
		Next

		dim out : out = "Sub " & name & idx & "(aLvl):" & str & "End Sub"
		'if idx = 132 then msgbox out	'debug
		ExecuteGlobal Out

	End Property

	Public Property Let state(ByVal idx, input) 'Major update path
		if Input <> OnOff(idx) then  'discard redundant updates
			OnOff(idx) = input
			Lock(idx) = False
			If input = 1 Then
				Lvl(idx) = 0
			Else
				Lvl(idx) = 1
			End If
			If not typename(obj(idx)) = "NullFadingObject" Then 'if empty, use Set
				obj(idx).State = input
			End If
			Loaded(idx) = False
		End If
	End Property

	Public Property Let lampColor(ByVal idx, input) 'Major update path
		obj(idx).colorFull = input
		obj(idx).color = input
	End Property

	Public Property Let image(ByVal idx, input) 'Major update path
		obj(idx).Image = input
	End Property

	'Mass assign, Builds arrays where necessary
	'Sub MassAssign(aIdx, aInput)
	Public Property Let MassAssign(aIdx, aInput)
		If typename(obj(aIdx)) = "NullFadingObject" Then 'if empty, use Set
			if IsArray(aInput) then
				obj(aIdx) = aInput
			Else
				Set obj(aIdx) = aInput
			end if
		Else
			Obj(aIdx) = AppendArray(obj(aIdx), aInput)
		end if
	end Property

	Sub SetLamp(aIdx, aOn) : state(aIdx) = aOn : End Sub	'Solenoid Handler

	Public Sub TurnOffStates()
		dim idx : for idx = 0 to uBound(OnOff)
			state(idx) = 0
		Next
	End Sub

	Public Sub TurnOnStates()	'If obj contains any light objects, set their states to 1 (Fading is our job!)
		dim debugstr
		dim idx : for idx = 0 to uBound(obj)
			if IsArray(obj(idx)) then
				'debugstr = debugstr & "array found at " & idx & "..."
				dim x, tmp : tmp = obj(idx) 'set tmp to array in order to access it
				for x = 0 to uBound(tmp)
					if typename(tmp(x)) = "Light" then DisableState tmp(x)' : debugstr = debugstr & tmp(x).name & " state'd" & vbnewline
					tmp(x).intensityscale = 0.001 ' this can prevent init stuttering
				Next
			Else
				if typename(obj(idx)) = "Light" then DisableState obj(idx)' : debugstr = debugstr & obj(idx).name & " state'd (not array)" & vbnewline
				obj(idx).intensityscale = 0.001 ' this can prevent init stuttering
			end if
		Next
		'debug.print debugstr
	End Sub
	Private Sub DisableState(ByRef aObj) : aObj.FadeSpeedUp = 0.2 : aObj.State = 1 : End Sub	'turn state to 1

	Public Sub Init()	'Just runs TurnOnStates right now
		'TurnOnStates
	End Sub

	Public Property Let Modulate(aIdx, aCoef) : Mult(aIdx) = aCoef : Lock(aIdx) = False : Loaded(aIdx) = False: End Property
	Public Property Get Modulate(aIdx) : Modulate = Mult(aIdx) : End Property

	Public Sub Update1()	 'Handle all boolean numeric fading. If done fading, Lock(x) = True. Update on a '1' interval Timer!
		dim x : for x = 0 to uBound(OnOff)
			if not Lock(x) then 'and not Loaded(x) then
				if OnOff(x) then 'Fade Up
					Lvl(x) = Lvl(x) + FadeSpeedUp(x)
					if Lvl(x) >= 1 then Lvl(x) = 1 : Lock(x) = True
				elseif Not OnOff(x) then 'fade down
					Lvl(x) = Lvl(x) - FadeSpeedDown(x)
					if Lvl(x) <= 0 then Lvl(x) = 0 : Lock(x) = True
				end if
			end if
		Next
	End Sub

	Public Sub Update2()	 'Both updates on -1 timer (Lowest latency, but less accurate fading at 60fps vsync)
		FrameTime = gametime - InitFrame : InitFrame = GameTime	'Calculate frametime
		dim x : for x = 0 to uBound(OnOff)
			if not Lock(x) then 'and not Loaded(x) then
				if OnOff(x) then 'Fade Up
					Lvl(x) = Lvl(x) + FadeSpeedUp(x) * FrameTime
					if Lvl(x) >= 1 then Lvl(x) = 1 : Lock(x) = True
				elseif Not OnOff(x) then 'fade down
					Lvl(x) = Lvl(x) - FadeSpeedDown(x) * FrameTime
					if Lvl(x) <= 0 then Lvl(x) = 0 : Lock(x) = True
				end if
			end if
		Next
		Update
	End Sub

	Public Sub Update()	'Handle object updates. Update on a -1 Timer! If done fading, loaded(x) = True
		dim x,xx : for x = 0 to uBound(OnOff)
			if not Loaded(x) then
				if IsArray(obj(x) ) Then	'if array
					If UseFunction then
						for each xx in obj(x) : xx.IntensityScale = cFilter(Lvl(x)*Mult(x)) : Next
					Else
						for each xx in obj(x) : xx.IntensityScale = Lvl(x)*Mult(x) : Next
					End If
				else						'if single lamp or flasher
					If UseFunction then
						obj(x).Intensityscale = cFilter(Lvl(x)*Mult(x))
					Else
						obj(x).Intensityscale = Lvl(x)
					End If
				end if
				if TypeName(lvl(x)) <> "Double" and typename(lvl(x)) <> "Integer" then msgbox "uhh " & 2 & " = " & lvl(x)
				'If UseCallBack(x) then execute cCallback(x) & " " & (Lvl(x))	'Callback
				If UseCallBack(x) then Proc name & x,Lvl(x)*mult(x)	'Proc
				If Lock(x) Then
					if Lvl(x) = 1 or Lvl(x) = 0 then Loaded(x) = True	'finished fading
					If not typename(obj(x)) = "NullFadingObject" Then 'if empty, use Set
						If OnOff(x) = 0 Then
							'MsgBox("off")
							'debug.print obj(x).Name
							'finished fading the lamp off.
							obj(x).IntensityScale=1
							obj(x).State = 0
						End if
					End If
				end if
			end if
		Next
	End Sub
End Class




'version 0.11 - Mass Assign, Changed modulate style
'version 0.12 - Update2 (single -1 timer update) update method for core.vbs
'Version 0.12a - Filter can now be publicly accessed via 'FilterOut'
'Version 0.12b - Changed MassAssign from a sub to an indexed property (new syntax: lampfader.MassAssign(15) = Light1 )
'Version 0.13 - No longer requires setlocale. Callback() can be assigned multiple times per index
'Version 0.13a - fixed DynamicLamps hopefully
' Note: if using multiple 'DynamicLamps' objects, change the 'name' variable to avoid conflicts with callbacks

Class DynamicLamps 'Lamps that fade up and down. GI and Flasher handling
	Public Loaded(50), FadeSpeedDown(50), FadeSpeedUp(50)
	Private Lock(50), SolModValue(50)
	Private UseCallback(50), cCallback(50)
	Public Lvl(50)
	Public Obj(50)
	Private UseFunction, cFilter
	private Mult(50)
	Public Name

	Public FrameTime
	Private InitFrame

	Private Sub Class_Initialize()
		InitFrame = 0
		dim x : for x = 0 to uBound(Obj)
			FadeSpeedup(x) = 0.01
			FadeSpeedDown(x) = 0.01
			lvl(x) = 0.0001 : SolModValue(x) = 0
			Lock(x) = True : Loaded(x) = False
			mult(x) = 1
			Name = "DynamicFaderNF" 'NEEDS TO BE CHANGED IF THERE'S MULTIPLE OBJECTS, OTHERWISE CALLBACKS WILL INTERFERE WITH EACH OTHER!!
			if IsEmpty(obj(x) ) then Set Obj(x) = NullFader' : Loaded(x) = True
		next
	End Sub

	Public Property Get Locked(idx) : Locked = Lock(idx) : End Property
	'Public Property Let Callback(idx, String) : cCallback(idx) = String : UseCallBack(idx) = True : End Property
	Public Property Let Filter(String) : Set cFilter = GetRef(String) : UseFunction = True : End Property
	Public Function FilterOut(aInput) : if UseFunction Then FilterOut = cFilter(aInput) Else FilterOut = aInput End If : End Function

	Public Property Let Callback(idx, String)
		UseCallBack(idx) = True
		'cCallback(idx) = String 'old execute method
		'New method: build wrapper subs using ExecuteGlobal, then call them
		cCallback(idx) = cCallback(idx) & "___" & String	'multiple strings dilineated by 3x _

		dim tmp : tmp = Split(cCallback(idx), "___")

		dim str, x : for x = 0 to uBound(tmp)	'build proc contents
			'debugstr = debugstr & x & "=" & tmp(x) & vbnewline
			'If Not tmp(x)="" then str = str & "	" & tmp(x) & " aLVL" & "	'" & x & vbnewline	'more verbose
			If Not tmp(x)="" then str = str & tmp(x) & " aLVL:"
		Next

		dim out : out = "Sub " & name & idx & "(aLvl):" & str & "End Sub"
		'if idx = 132 then msgbox out	'debug
		'Debug.print out
		ExecuteGlobal Out

	End Property


	Public Property Let State(idx,Value)
		'If Value = SolModValue(idx) Then Exit Property ' Discard redundant updates
		If Value <> SolModValue(idx) Then ' Discard redundant updates
			SolModValue(idx) = Value
			Lock(idx) = False : Loaded(idx) = False
		End If
	End Property
	Public Property Get state(idx) : state = SolModValue(idx) : end Property

	'Mass assign, Builds arrays where necessary
	'Sub MassAssign(aIdx, aInput)
	Public Property Let MassAssign(aIdx, aInput)
		If typename(obj(aIdx)) = "NullFadingObject" Then 'if empty, use Set
			if IsArray(aInput) then
				obj(aIdx) = aInput
			Else
				Set obj(aIdx) = aInput
			end if
		Else
			Obj(aIdx) = AppendArray(obj(aIdx), aInput)
		end if
	end Property

	'solcallback (solmodcallback) handler
	Sub SetLamp(aIdx, aInput) : state(aIdx) = aInput : End Sub	'0->1 Input
	Sub SetModLamp(aIdx, aInput) : state(aIdx) = aInput/255 : End Sub	'0->255 Input
	Sub SetGI(aIdx, ByVal aInput) 
		'DebugOut("SETTING GI ON MODLAMPZ ; "+ Cstr(aIdx) + " ; " + CStr(aInput))
		if aInput = 8 then 
			aInput = 7 
		end if 
		state(aIdx) = aInput/7
	End Sub	'0->8 WPC GI input

	Public Sub TurnOnStates()	'If obj contains any light objects, set their states to 1 (Fading is our job!)
		dim debugstr
		dim idx : for idx = 0 to uBound(obj)
			if IsArray(obj(idx)) then
				'debugstr = debugstr & "array found at " & idx & "..."
				dim x, tmp : tmp = obj(idx) 'set tmp to array in order to access it
				for x = 0 to uBound(tmp)
					if typename(tmp(x)) = "Light" then DisableState tmp(x) ': debugstr = debugstr & tmp(x).name & " state'd" & vbnewline

				Next
			Else
				if typename(obj(idx)) = "Light" then DisableState obj(idx) ': debugstr = debugstr & obj(idx).name & " state'd (not array)" & vbnewline

			end if
		Next
		'debug.print debugstr
	End Sub
	Private Sub DisableState(ByRef aObj) : aObj.FadeSpeedUp = 1000 : aObj.State = 1 : End Sub	'turn state to 1

	Public Sub Init()	'just call turnonstates for now
		TurnOnStates
	End Sub

	Public Property Let Modulate(aIdx, aCoef) : Mult(aIdx) = aCoef : Lock(aIdx) = False : Loaded(aIdx) = False: End Property
	Public Property Get Modulate(aIdx) : Modulate = Mult(aIdx) : End Property

	Public Sub Update1()	 'Handle all numeric fading. If done fading, Lock(x) = True
		'dim stringer
		dim x : for x = 0 to uBound(Lvl)
			'stringer = "Locked @ " & SolModValue(x)






			if not Lock(x) then 'and not Loaded(x) then
				If lvl(x) < SolModValue(x) then '+
					'stringer = "Fading Up " & lvl(x) & " + " & FadeSpeedUp(x)
					Lvl(x) = Lvl(x) + FadeSpeedUp(x)
					if Lvl(x) >= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				ElseIf Lvl(x) > SolModValue(x) Then '-
					Lvl(x) = Lvl(x) - FadeSpeedDown(x)
					'stringer = "Fading Down " & lvl(x) & " - " & FadeSpeedDown(x)
					if Lvl(x) <= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				End If
			end if
		Next
		'tbF.text = stringer
	End Sub

	Public Sub Update2()	 'Both updates on -1 timer (Lowest latency, but less accurate fading at 60fps vsync)
		FrameTime = gametime - InitFrame : InitFrame = GameTime	'Calculate frametime
		dim x : for x = 0 to uBound(Lvl)

			if not Lock(x) then 'and not Loaded(x) then
				If lvl(x) < SolModValue(x) then '+
					Lvl(x) = Lvl(x) + FadeSpeedUp(x) * FrameTime
					if Lvl(x) >= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				ElseIf Lvl(x) > SolModValue(x) Then '-
					Lvl(x) = Lvl(x) - FadeSpeedDown(x) * FrameTime
					if Lvl(x) <= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				End If
			end if
		Next
		Update
	End Sub

	Public Sub Update()	'Handle object updates. Update on a -1 Timer! If done fading, loaded(x) = True
		dim x,xx
		for x = 0 to uBound(Lvl)
			if not Loaded(x) then
				if IsArray(obj(x) ) Then	'if array
					If UseFunction then
						for each xx in obj(x) 

							xx.IntensityScale = cFilter(abs(Lvl(x))*mult(x))
							If xx.Name = "LA014" Then
								'DebugOut(xx.Name + ":" + cStr(cFilter(abs(Lvl(x))*mult(x))))
							End If
						Next
					Else
						for each xx in obj(x) : xx.IntensityScale = Lvl(x)*mult(x) : Next
					End If
				else						'if single lamp or flasher
					If UseFunction then
						obj(x).Intensityscale = cFilter(abs(Lvl(x))*mult(x))
					Else
						obj(x).Intensityscale = Lvl(x)*mult(x)
					End If
				end if
				'If UseCallBack(x) then execute cCallback(x) & " " & (Lvl(x)*mult(x))	'Callback
				If UseCallBack(x) then Proc name & x,Lvl(x)*mult(x)	'Proc
				If Lock(x) Then
					Loaded(x) = True
				end if





			end if
		Next
	End Sub
End Class

'Helper functions
Sub Proc(string, Callback)	'proc using a string and one argument
	'On Error Resume Next
	Debug.print(Callback)
	dim p : Set P = GetRef(String)
	P Callback
	If err.number = 13 then  msgbox "Proc error! No such procedure: " & vbnewline & string
	if err.number = 424 then msgbox "Proc error! No such Object"
End Sub

Function AppendArray(ByVal aArray, aInput)	'append one value, object, or Array onto the end of a 1 dimensional array
	if IsArray(aInput) then 'Input is an array...
		dim tmp : tmp = aArray
		If not IsArray(aArray) Then	'if not array, create an array
			tmp = aInput
		Else						'Append existing array with aInput array
			Redim Preserve tmp(uBound(aArray) + uBound(aInput)+1)	'If existing array, increase bounds by uBound of incoming array
			dim x : for x = 0 to uBound(aInput)
				if isObject(aInput(x)) then
					Set tmp(x+uBound(aArray)+1 ) = aInput(x)
				Else
					tmp(x+uBound(aArray)+1 ) = aInput(x)
				End If
			Next
		AppendArray = tmp	 'return new array
		End If
	Else 'Input is NOT an array...
		If not IsArray(aArray) Then	'if not array, create an array
			aArray = Array(aArray, aInput)
		Else
			Redim Preserve aArray(uBound(aArray)+1)	'If array, increase bounds by 1
			if isObject(aInput) then
				Set aArray(uBound(aArray)) = aInput
			Else
				aArray(uBound(aArray)) = aInput
			End If
		End If
		AppendArray = aArray 'return new array
	End If
End Function


'***********************************************************************************************************************

	' Sync on LA055 ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,Layer_2_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,Bumper1_Ring_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,Bumper2_Ring_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,Bumper3_Ring_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,Flipper_3_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,Flipper_3_002_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,sw58_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,swLeftInlane_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,swLeftOutlane_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,swLeftReturn_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,swRightInlane_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,swRightOrbit_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,swRightRamp_Wire_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,swRightRampBallLock_Wire_LM_GI, 100.00, " ' VLM.ModLampz;GI
	ModLampz.Callback(0) = "UpdateLightMap 0,Playfield_LM_GI, 100.00, " ' VLM.ModLampz;GI

Sub InitLightMapperElements
    Dim p
    If useLightMapper = True Then
        PinCab_Blades.Visible = False
        PinCab_Rails.Visible = False
        p_rightramp.Visible = False
        for each p in inserts
            p.Visible = False  
        next
        for each p in GI
            p.Visible = False  
        next
    Else    
        PinCab_Blades.Visible = True
        PinCab_Rails.Visible = True
        p_rightramp.Visible = True
        for each p in inserts
            p.Visible = True
        next
        for each p in GI
            p.Visible = True
        next
    End If
End Sub
Dim lutpos: lutpos = 2
Dim luts: luts = Array("LUT0_0","LUT0_1","LUT1_0","LUT1_1","LUT1_2","LUT4_2","lutTotan1","ColorGrade_7", "LUT0")
Table1.ColorGradeImage = luts(lutpos)
'******************************************************
'  TRACK ALL BALL VELOCITIES
'  FOR RUBBER DAMPENER AND DROP TARGETS
'******************************************************

dim cor : set cor = New CoRTracker

Class CoRTracker
	public ballvel, ballvelx, ballvely

	Private Sub Class_Initialize : redim ballvel(0) : redim ballvelx(0): redim ballvely(0) : End Sub 

	Public Sub Update()	'tracks in-ball-velocity
		dim str, b, AllBalls, highestID : allBalls = getballs

		for each b in allballs
			if b.id >= HighestID then highestID = b.id
		Next

		if uBound(ballvel) < highestID then redim ballvel(highestID)	'set bounds
		if uBound(ballvelx) < highestID then redim ballvelx(highestID)	'set bounds
		if uBound(ballvely) < highestID then redim ballvely(highestID)	'set bounds

		for each b in allballs
			ballvel(b.id) = BallSpeed(b)
			ballvelx(b.id) = b.velx
			ballvely(b.id) = b.vely
		Next
	End Sub
End Class



'******************************************************
'****  PHYSICS DAMPENERS
'******************************************************
'
' These are data mined bounce curves, 
' dialed in with the in-game elasticity as much as possible to prevent angle / spin issues.
' Requires tracking ballspeed to calculate COR



Sub dPosts_Hit(idx) 
	RubbersD.dampen Activeball
	TargetBouncer Activeball, 1
End Sub

Sub dSleeves_Hit(idx) 
	SleevesD.Dampen Activeball
	TargetBouncer Activeball, 0.7
End Sub


dim RubbersD : Set RubbersD = new Dampener        'frubber
RubbersD.name = "Rubbers"
RubbersD.debugOn = False        'shows info in textbox "TBPout"
RubbersD.Print = False        'debug, reports in debugger (in vel, out cor)
'cor bounce curve (linear)
'for best results, try to match in-game velocity as closely as possible to the desired curve
'RubbersD.addpoint 0, 0, 0.935        'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 0, 0, 0.96        'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 1, 3.77, 0.96
RubbersD.addpoint 2, 5.76, 0.967        'dont take this as gospel. if you can data mine rubber elasticitiy, please help!
RubbersD.addpoint 3, 15.84, 0.874
RubbersD.addpoint 4, 56, 0.64        'there's clamping so interpolate up to 56 at least

dim SleevesD : Set SleevesD = new Dampener        'this is just rubber but cut down to 85%...
SleevesD.name = "Sleeves"
SleevesD.debugOn = False        'shows info in textbox "TBPout"
SleevesD.Print = False        'debug, reports in debugger (in vel, out cor)
SleevesD.CopyCoef RubbersD, 0.85

Class Dampener
	Public Print, debugOn 'tbpOut.text
	public name, Threshold         'Minimum threshold. Useful for Flippers, which don't have a hit threshold.
	Public ModIn, ModOut
	Private Sub Class_Initialize : redim ModIn(0) : redim Modout(0): End Sub 

	Public Sub AddPoint(aIdx, aX, aY) 
		ShuffleArrays ModIn, ModOut, 1 : ModIn(aIDX) = aX : ModOut(aIDX) = aY : ShuffleArrays ModIn, ModOut, 0
		if gametime > 100 then Report
	End Sub

	public sub Dampen(aBall)
		if threshold then if BallSpeed(aBall) < threshold then exit sub end if end if
		dim RealCOR, DesiredCOR, str, coef
		DesiredCor = LinearEnvelope(cor.ballvel(aBall.id), ModIn, ModOut )
		RealCOR = BallSpeed(aBall) / (cor.ballvel(aBall.id)+0.0000001)
		coef = desiredcor / realcor 
		if debugOn then str = name & " in vel:" & round(cor.ballvel(aBall.id),2 ) & vbnewline & "desired cor: " & round(desiredcor,4) & vbnewline & _
		"actual cor: " & round(realCOR,4) & vbnewline & "ballspeed coef: " & round(coef, 3) & vbnewline 
		if Print then debug.print Round(cor.ballvel(aBall.id),2) & ", " & round(desiredcor,3)

		aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		if debugOn then TBPout.text = str
	End Sub

	Public Sub CopyCoef(aObj, aCoef) 'alternative addpoints, copy with coef
		dim x : for x = 0 to uBound(aObj.ModIn)
			addpoint x, aObj.ModIn(x), aObj.ModOut(x)*aCoef
		Next
	End Sub


	Public Sub Report()         'debug, reports all coords in tbPL.text
		if not debugOn then exit sub
		dim a1, a2 : a1 = ModIn : a2 = ModOut
		dim str, x : for x = 0 to uBound(a1) : str = str & x & ": " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		TBPout.text = str
	End Sub

End Class


'******************************************************
' VPW TargetBouncer for targets and posts by Iaakki, Wrd1972, Apophis
'******************************************************

sub TargetBouncer(aBall,defvalue)
    dim zMultiplier, vel, vratio
    if TargetBouncerEnabled = 1 and aball.z < 30 then
        'debug.print "velx: " & aball.velx & " vely: " & aball.vely & " velz: " & aball.velz
        vel = BallSpeed(aBall)
        if aBall.velx = 0 then vratio = 1 else vratio = aBall.vely/aBall.velx
        Select Case Int(Rnd * 6) + 1
            Case 1: zMultiplier = 0.2*defvalue
			Case 2: zMultiplier = 0.25*defvalue
            Case 3: zMultiplier = 0.3*defvalue
			Case 4: zMultiplier = 0.4*defvalue
            Case 5: zMultiplier = 0.45*defvalue
            Case 6: zMultiplier = 0.5*defvalue
        End Select
        aBall.velz = abs(vel * zMultiplier * TargetBouncerFactor)
        aBall.velx = sgn(aBall.velx) * sqr(abs((vel^2 - aBall.velz^2)/(1+vratio^2)))
        aBall.vely = aBall.velx * vratio
        'debug.print "---> velx: " & aball.velx & " vely: " & aball.vely & " velz: " & aball.velz
        'debug.print "conservation check: " & BallSpeed(aBall)/vel
    elseif TargetBouncerEnabled = 2 and aball.z < 30 then
		'debug.print "velz: " & activeball.velz
		Select Case Int(Rnd * 4) + 1
			Case 1: zMultiplier = defvalue+1.1
			Case 2: zMultiplier = defvalue+1.05
			Case 3: zMultiplier = defvalue+0.7
			Case 4: zMultiplier = defvalue+0.3
		End Select
		aBall.velz = aBall.velz * zMultiplier * TargetBouncerFactor
		'debug.print "----> velz: " & activeball.velz
		'debug.print "conservation check: " & BallSpeed(aBall)/vel
	end if
end sub

'/////////////////////////////  FLIPPER BATS SOLENOID CORE SOUND  ////////////////////////////
Sub RandomSoundFlipperUpLeft(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_L0" & Int(Rnd*9)+1,DOFFlippers), FlipperLeftHitParm, Flipper
End Sub

Sub RandomSoundFlipperUpRight(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_R0" & Int(Rnd*9)+1,DOFFlippers), FlipperRightHitParm, Flipper
End Sub

Sub RandomSoundReflipUpLeft(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_ReFlip_L0" & Int(Rnd*3)+1,DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, Flipper
End Sub

Sub RandomSoundReflipUpRight(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_ReFlip_R0" & Int(Rnd*3)+1,DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, Flipper
End Sub

Sub RandomSoundFlipperDownLeft(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_Left_Down_" & Int(Rnd*7)+1,DOFFlippers), FlipperDownSoundLevel, Flipper
End Sub

Sub RandomSoundFlipperDownRight(flipper)
	PlaySoundAtLevelStatic SoundFX("Flipper_Right_Down_" & Int(Rnd*8)+1,DOFFlippers), FlipperDownSoundLevel, Flipper
End Sub

'/////////////////////////////  FLIPPER BATS SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  FLIPPER BATS SOLENOID ATTACK SOUND  ////////////////////////////
Sub SoundFlipperUpAttackLeft(flipper)
	FlipperUpAttackLeftSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
	PlaySoundAtLevelStatic ("Flipper_Attack-L01"), FlipperUpAttackLeftSoundLevel, flipper
End Sub

Sub SoundFlipperUpAttackRight(flipper)
	FlipperUpAttackRightSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
		PlaySoundAtLevelStatic ("Flipper_Attack-R01"), FlipperUpAttackLeftSoundLevel, flipper
End Sub

'/////////////////////////////  FLIPPER BATS BALL COLLIDE SOUND  ////////////////////////////

Sub LeftFlipperCollide(parm)
	FlipperLeftHitParm = parm/10
	If FlipperLeftHitParm > 1 Then
		FlipperLeftHitParm = 1
	End If
	FlipperLeftHitParm = FlipperUpSoundLevel * FlipperLeftHitParm
	RandomSoundRubberFlipper(parm)
End Sub

Sub RightFlipperCollide(parm)
	FlipperRightHitParm = parm/10
	If FlipperRightHitParm > 1 Then
		FlipperRightHitParm = 1
	End If
	FlipperRightHitParm = FlipperUpSoundLevel * FlipperRightHitParm
 	RandomSoundRubberFlipper(parm)
End Sub

Sub RandomSoundRubberFlipper(parm)
	PlaySoundAtLevelActiveBall ("Flipper_Rubber_" & Int(Rnd*7)+1), parm  * RubberFlipperSoundFactor
End Sub
'***********************************************************************************************************************
'*****      Ramp Sounds                                        	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

'=====================================
'		Ramp Rolling SFX updates nf
'=====================================
'Ball tracking ramp SFX 1.0
'	Usage:
'- Setup hit events with WireRampOn True or WireRampOn False (True = Plastic ramp, False = Wire Ramp)
'- To stop tracking ball, use WireRampoff
'--	Otherwise, the ball will auto remove if it's below 30 vp units

'Example, from Space Station:
'Sub RampSoundPlunge1_hit() : WireRampOn  False : End Sub						'Enter metal habitrail
'Sub RampSoundPlunge2_hit() : WireRampOff : WireRampOn True : End Sub			'Exit Habitrail, enter onto Mini PF 
'Sub RampEntry_Hit() : If activeball.vely < -10 then WireRampOn True : End Sub 	'Ramp enterance
dim RampMinLoops : RampMinLoops = 4
dim RampBalls(10,2)
'x,0 = ball x,1 = ID,	2 = Protection against ending early (minimum amount of updates)
'0,0 is boolean on/off, 0,1 unused for now
RampBalls(0,0) = False

dim RampType(10)	'Slapped together support for multiple ramp types... False = Wire Ramp, True = Plastic Ramp

Sub WireRampOn(input)  : Waddball ActiveBall, input : RampRollUpdate: End Sub
Sub WireRampOff() : WRemoveBall ActiveBall.ID	: End Sub

Sub Waddball(input, RampInput)	'Add ball
    'Debug.Print "In Waddball() + add ball to loop array"	
	dim x : for x = 1 to uBound(RampBalls)	'Check, don't add balls twice
		if RampBalls(x, 1) = input.id then 
			if Not IsEmpty(RampBalls(x,1) ) then Exit Sub	'Frustating issue with BallId 0. Empty variable = 0
		End If
	Next
	
	For x = 1 to uBound(RampBalls)
		if IsEmpty(RampBalls(x, 1)) then 
			Set RampBalls(x, 0) = input
			RampBalls(x, 1)	= input.ID
			RampType(x) = RampInput
			RampBalls(x, 2)	= 0
			'exit For
			RampBalls(0,0) = True
			RampRoll.Enabled = 1	 'Turn on timer
			'RampRoll.Interval = RampRoll.Interval 'reset timer
			exit Sub
		End If
		if x = uBound(RampBalls) then 	'debug
			Debug.print "WireRampOn error, ball queue is full: " & vbnewline & _
						 RampBalls(0, 0) & vbnewline & _
						 Typename(RampBalls(1, 0)) & " ID:" & RampBalls(1, 1) & "type:" & RampType(1) & vbnewline & _
						 Typename(RampBalls(2, 0)) & " ID:" & RampBalls(2, 1) & "type:" & RampType(2) & vbnewline & _
						 Typename(RampBalls(3, 0)) & " ID:" & RampBalls(3, 1) & "type:" & RampType(3) & vbnewline & _
						 Typename(RampBalls(4, 0)) & " ID:" & RampBalls(4, 1) & "type:" & RampType(4) & vbnewline & _
						 Typename(RampBalls(5, 0)) & " ID:" & RampBalls(5, 1) & "type:" & RampType(5) & vbnewline & _
						 " "
		End If
	next
End Sub

Sub WRemoveBall(ID)		'Remove ball
    'Debug.Print "In WRemoveBall() + Remove ball from loop array"
	dim ballcount : ballcount = 0
	dim x : for x = 1 to Ubound(RampBalls)
		if ID = RampBalls(x, 1) then 'remove ball
			Set RampBalls(x, 0) = Nothing
			RampBalls(x, 1) = Empty
			RampType(x) = Empty
			StopSound("RampLoop" & x)
			StopSound("wireloop" & x)
		end If
		'if RampBalls(x,1) = Not IsEmpty(Rampballs(x,1) then ballcount = ballcount + 1
		if not IsEmpty(Rampballs(x,1)) then ballcount = ballcount + 1
	next
	if BallCount = 0 then RampBalls(0,0) = False	'if no balls in queue, disable timer update
End Sub

Sub RampRoll_Timer():RampRollUpdate:End Sub 'set to FrameTimer

Sub RampRollUpdate()		'Timer update
	dim x : for x = 1 to uBound(RampBalls)
		if Not IsEmpty(RampBalls(x,1) ) then 
			if BallVel(RampBalls(x,0) ) > 1 then ' if ball is moving, play rolling sound
				If RampType(x) then 
					PlaySound("RampLoop" & x), -1, Vol(RampBalls(x,0) )*10, AudioPan(RampBalls(x,0) )*3, 0, BallPitchV(RampBalls(x,0) ), 1, 0,AudioFade(RampBalls(x,0) )'*3
					StopSound("wireloop" & x)
				Else
					StopSound("RampLoop" & x)
					PlaySound("wireloop" & x), -1, Vol(RampBalls(x,0) )*10, AudioPan(RampBalls(x,0) )*3, 0, BallPitch(RampBalls(x,0) ), 1, 0,AudioFade(RampBalls(x,0) )'*3
				End If
				RampBalls(x, 2)	= RampBalls(x, 2) + 1
			Else
				StopSound("RampLoop" & x)
				StopSound("wireloop" & x)
			end if
			if RampBalls(x,0).Z < 30 and RampBalls(x, 2) > RampMinLoops then	'if ball is on the PF, remove  it
				StopSound("RampLoop" & x)
				StopSound("wireloop" & x)
				Wremoveball RampBalls(x,1)
			End If
		Else
			StopSound("RampLoop" & x)
			StopSound("wireloop" & x)
		end if
	next
	if not RampBalls(0,0) then RampRoll.enabled = 0

End Sub


Sub tbWR_Timer()	'debug textbox
	me.text =	"on? " & RampBalls(0, 0) & " timer: " & RampRoll.Enabled & vbnewline & _
				 "1 " & Typename(RampBalls(1, 0)) & " ID:" & RampBalls(1, 1) & " type:" & RampType(1) & " Loops:" & RampBalls(1, 2) & vbnewline & _
				 "2 " & Typename(RampBalls(2, 0)) & " ID:" & RampBalls(2, 1) & " type:" & RampType(2) & " Loops:" & RampBalls(2, 2) & vbnewline & _
				 "3 " & Typename(RampBalls(3, 0)) & " ID:" & RampBalls(3, 1) & " type:" & RampType(3) & " Loops:" & RampBalls(3, 2) & vbnewline & _
				 "4 " & Typename(RampBalls(4, 0)) & " ID:" & RampBalls(4, 1) & " type:" & RampType(4) & " Loops:" & RampBalls(4, 2) & vbnewline & _
				 "5 " & Typename(RampBalls(5, 0)) & " ID:" & RampBalls(5, 1) & " type:" & RampType(5) & " Loops:" & RampBalls(5, 2) & vbnewline & _
				 "6 " & Typename(RampBalls(6, 0)) & " ID:" & RampBalls(6, 1) & " type:" & RampType(6) & " Loops:" & RampBalls(6, 2) & vbnewline & _
				 " "
End Sub


Function BallPitch(ball) ' Calculates the pitch of the sound based on the ball speed
    BallPitch = pSlope(BallVel(ball), 1, -1000, 60, 10000)
End Function

Function BallPitchV(ball) ' Calculates the pitch of the sound based on the ball speed Variation
    BallPitchV = pSlope(BallVel(ball), 1, -4000, 60, 7000)
End Function
Sub PlaySoundAtLevelStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 0, 0, AudioFade(ActiveBall)
End Sub


Sub PlayGameCallout(callout)
    If Not gameState("game")("currentCallOut") = "" Then
        StopSound(gameState("game")("currentCallOut"))
    End If
    PlaySound(callout)
    gameState("game")("currentCallOut") = callout
End Sub
'***********************************************************************************************************************
'*****  SOUNDS                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

'///////////////////////-----Solenoids, Kickers and Flash Relays-----///////////////////////
Dim FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel, FlipperUpAttackLeftSoundLevel, FlipperUpAttackRightSoundLevel
Dim FlipperUpSoundLevel, FlipperDownSoundLevel, FlipperLeftHitParm, FlipperRightHitParm
Dim SlingshotSoundLevel, BumperSoundFactor, KnockerSoundLevel

FlipperUpAttackMinimumSoundLevel = 0.010           						'volume level; range [0, 1]
FlipperUpAttackMaximumSoundLevel = 0.635								'volume level; range [0, 1]
FlipperUpSoundLevel = 1.0                        						'volume level; range [0, 1]
FlipperDownSoundLevel = 0.45                      						'volume level; range [0, 1]
FlipperLeftHitParm = FlipperUpSoundLevel								'sound helper; not configurable
FlipperRightHitParm = FlipperUpSoundLevel								'sound helper; not configurable
SlingshotSoundLevel = 0.95												'volume level; range [0, 1]
BumperSoundFactor = 4.25												'volume multiplier; must not be zero
KnockerSoundLevel = 1 													'volume level; range [0, 1]

'///////////////////////-----Ball Drops, Bumps and Collisions-----///////////////////////
Dim RubberStrongSoundFactor, RubberWeakSoundFactor, RubberFlipperSoundFactor,BallWithBallCollisionSoundFactor
Dim BallBouncePlayfieldSoftFactor, BallBouncePlayfieldHardFactor, PlasticRampDropToPlayfieldSoundLevel, WireRampDropToPlayfieldSoundLevel, DelayedBallDropOnPlayfieldSoundLevel
Dim WallImpactSoundFactor, MetalImpactSoundFactor, SubwaySoundLevel, SubwayEntrySoundLevel, ScoopEntrySoundLevel
Dim SaucerLockSoundLevel, SaucerKickSoundLevel

BallWithBallCollisionSoundFactor = 3.2									'volume multiplier; must not be zero
RubberStrongSoundFactor = 0.055/5											'volume multiplier; must not be zero
RubberWeakSoundFactor = 0.075/5											'volume multiplier; must not be zero
RubberFlipperSoundFactor = 0.075/5										'volume multiplier; must not be zero
BallBouncePlayfieldSoftFactor = 0.025									'volume multiplier; must not be zero
BallBouncePlayfieldHardFactor = 0.025									'volume multiplier; must not be zero
DelayedBallDropOnPlayfieldSoundLevel = 1									'volume level; range [0, 1]
WallImpactSoundFactor = 0.075											'volume multiplier; must not be zero
MetalImpactSoundFactor = 0.075/3
SaucerLockSoundLevel = 0.8
SaucerKickSoundLevel = 0.8

'///////////////////////-----General Sound Options-----///////////////////////
'// VolumeDial:
'// VolumeDial is the actual global volume multiplier for the mechanical sounds.
'// Values smaller than 1 will decrease mechanical sounds volume.
'// Recommended values should be no greater than 1.
Const VolumeDial = 0.8
Const VolumeDialRamps = 0.5




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

	Function SoundFXDOF(Sound, DOFevent, State, Effect)
		If dEff(Effect)=1 Then
			SoundFXDOF = ""
			DOF DOFevent, State
		ElseIf dEff(Effect)=2 Then
			SoundFXDOF = Sound
			DOF DOFevent, State
		Else
			SoundFXDOF = Sound
		End If
	End Function

	Function SoundFX (Sound, Effect)
		If ((Effect = 0 And B2SOn) Or DOFeffects(Effect)=1) Then
			SoundFX = ""
		Else
			SoundFX = Sound
		End If
	End Function
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

'***********************************************************************************************************************

'******************
' Section; Spinner
'******************
Sub Spinner1_Spin()
	PlaySound "fx-spinner2"
	GameAddScore GAME_POINTS_SPINNER
End Sub
Sub Spinner2_Spin()
	DISPATCH SWITCH_HIT_SPINNER2, null
End Sub
'***********************************************************************************************************************
'*****     Augmentation Switches                              	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub sw_augmentation_Hit()
    DISPATCH SWITCH_HIT_AUGMENTATION, Null
End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Back Bumper                                  	                                                            ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub sw_bckBumpers_Hit()
    Dispatch SWITCH_HIT_RESEARCH_3, Null
End Sub
'***********************************************************************************************************************
'*****    Bet Switch                                  	                                                            ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub sw_bet_Hit()
    Dispatch SWITCH_HIT_BET, Null
End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****     Captive Ball Switches                              	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub sw_captive_Hit()
    DISPATCH SWITCH_HIT_CAPTIVE, Null
End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****       Kickers                                          	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub drain_Hit()
    drain.DestroyBall

    If gameStarted = false Then
        Exit Sub
    End If
    dim bip: bip = UBound(GetBalls) - gameState("game")("ballsLocked") - 1 'actual balls in play (minus captive)
    'Debug.print UBound(GetBalls)
    If gameState("game")("ballSave") = True Then
        'Kick out balls until ballsInPlay is equaled
        If Not bip = gameState("game")("ballsInPlay") Then
            'kick out balls
            Dim newBalls
            For newBalls=1 to gameState("game")("ballsInPlay")-bip
                ballRelease.CreateSizedball BallSize / 2
                ballRelease.Kick 90, 4
                vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
            Next
        End If

        'If Not gameState("game")("outlaneDrain") Then
        '    ballRelease.CreateSizedball BallSize / 2
        '    ballRelease.Kick 90, 4
        '    vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
        'Else
        '    gameState("game")("outlaneDrain") = False
        'End If
    Else
        If bip = 0 Then
            DISPATCH GAME_END_OF_BALL, Null
        ElseIf bip = 1 And gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            'END MULTIBALL
            gameState("game")("modes")(GAME_MODE_MULTIBALL) = False
            
            DISPATCH GAME_MODE_NORMAL, Null
            gameState("game")("ballsInPlay") = 1
            lSeqMultiballC.RemoveAll()
	        lSeqMultiballY.RemoveAll()
	        lSeqMultiballB.RemoveAll()
	        lSeqMultiballE.RemoveAll()
	        lSeqMultiballR.RemoveAll()
            LightOff(lsCyber1)
            LightOff(lsCyber2)
            LightOff(lsCyber3)
            LightOff(lsCyber4)
            LightOff(lsCyber5)
            lSeqMultiballCShot.Image = "pal_green"
            lSeqMultiballYShot.Image = "pal_green"
            lSeqMultiballBShot.Image = "pal_green"
            lSeqMultiballEShot.Image = "pal_green"
            lSeqMultiballRShot.Image = "pal_green"
            gameState("switches")("lightlock") = 1
            CheckResearchLights
            DISPATCH LIGHTS_GI_NORMAL, Null
            gameState("game")("gameShots")(GAME_MODE_MULTIBALL).RemoveAll()
            PlayBGAudioNext()
        End If
    End If
End Sub

Sub vpmTimerDelayedAutoPlunge()
    PlungerIM.AutoFire
End Sub
'***********************************************************************************************************************
'*****    Light Lock Switches                                  	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub sw_lightlock_Hit()
    Dispatch SWITCH_HIT_LIGHT_LOCK, Null
End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Power Switches                                  	                                                        ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub sw_pw2_Hit()
    Dispatch SWITCH_HIT_RESEARCH_1, Null
End Sub

Sub sw_pw3_Hit()
    Dispatch SWITCH_HIT_RESEARCH_2, Null
End Sub

Sub sw_pw4_Hit()
    Dispatch SWITCH_HIT_RESEARCH_3, Null
End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Ramp Switches                                        	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub swEnterRightRamp_Hit()
	WireRampOn(True)
End Sub

Sub swEnterLeftRamp_Hit()
	WireRampOn(True)
End Sub

Sub swEnterLeftRampVuk_Hit()
	WireRampOn(False)
End Sub

Sub swEnterVukRamp_Hit()
	WireRampOn(False)
End Sub

Sub swExitRightRamp_Hit()
	WireRampOff()	 
	WireRampOn(False)
End Sub

Sub swExitLeftRamp_Hit()
	WireRampOff()	
	WireRampOn(False)
End Sub

Sub swRightRamp_Hit()
	DISPATCH SWITCH_HIT_RIGHT_RAMP, Null
End Sub

Sub swLeftRamp_Hit()
	DISPATCH SWITCH_HIT_LEFT_RAMP, Null
End Sub

Sub RPin_Hit()
	DISPATCH SWITCH_HIT_RAMP_PIN, Null
End Sub

Sub LockPin_Hit()
	'If gameState("switches")("lockPinHit") = False Then
'		DISPATCH SWITCH_HIT_BALL_LOCK, Null
'	End If
End Sub
'***********************************************************************************************************************
'*****   Rollover Switches                                  	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub swPreLeftOrbit_Hit()
    Dispatch SWITCH_HIT_PRE_LEFT_ORBIT, Null
End Sub
Sub swLeftOrbit_Hit()
    Dispatch SWITCH_HIT_LEFT_ORBIT, Null
End Sub
Sub swPreRightOrbit_Hit()
    Dispatch SWITCH_HIT_PRE_RIGHT_ORBIT, Null
End Sub
Sub swRightOrbit_Hit()
    Dispatch SWITCH_HIT_RIGHT_ORBIT, Null
End Sub
Sub swLeftOutlane_Hit()
    Dispatch SWITCH_HIT_LEFT_OUTLANE, Null
End Sub
Sub swLeftInlane_Hit()
    Dispatch SWITCH_HIT_LEFT_INLANE, Null
End Sub
Sub swRightInlane_Hit()
    Dispatch SWITCH_HIT_RIGHT_INLANE, Null
End Sub
Sub swRightOutlane_Hit()
    If gameState("switches")("shortcut") = 0 Then
        Dispatch SWITCH_HIT_RIGHT_OUTLANE, Null
    End If
End Sub

Sub swShortcut_Hit()
    Dispatch SWITCH_HIT_SHORTCUT, Null
    DiverterFlipper.RotateToEnd
    DiverterFlipper001.RotateToEnd
    vpmTimer.addtimer 3000, "closeRightLaneDiverter '"
End Sub

Sub swLeftReturn_Hit()
    DISPATCH SWITCH_HIT_CENTER_RAMP, null
End Sub

Sub closeRightLaneDiverter
    DiverterFlipper.RotateToStart
    DiverterFlipper001.RotateToStart
    gameState("switches")("shortcut") = 0
End Sub

Sub swPlungerLane_Hit()
    DISPATCH SWITCH_HIT_PLUNGER_LANE, Null
End Sub

Sub swSecretUpgrade_Hit()
    DISPATCH SWITCH_HIT_SECRET_UPGRADE, Null
End Sub

'***********************************************************************************************************************

Sub vukBallLock_Hit()
    'DISPATCH SWITCH_HIT_BALL_LOCK, Null
    'LockPin.IsDropped = False
    vukBallLock.Kick 0, 60, 1.5
End Sub

Sub swRightRampBallLock_Hit()
    DISPATCH SWITCH_HIT_BALL_LOCK, Null
End Sub
Sub vukCenterRamp_Hit()
    Dim waittime
    waittime = 400
    Dispatch SWITCH_HIT_CONSOLE, Null 
End Sub
'***********************************************************************************************************************
'*****  Allied VUK                                             	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Sub sw_hyperJump_Hit()
    Dim waittime
    waittime = 400
    FlashDome 2, 3, 1 'Idx, color, pulseCount
    StopSound("fx-allied-flasher")
    PlaySoundAt "fx-allied-flasher", Flasherbase2
    DISPATCH SWITCH_HIT_HYPERJUMP, null
    vpmTimer.addtimer waittime, "exitsw_hyperJump '"
End Sub

Sub exitsw_hyperJump
    StopSound("fx-allied-flasher")
    PlaySoundAt "fx-allied-flasher", Flasherbase2
    sw_hyperJump.Kick 0, 60, 1.36
End Sub
Sub raceVuk_Hit()
    Dim waittime
    waittime = 500
    vpmTimer.addtimer waittime, "exitRaceVuk '"
End Sub

Sub exitraceVuk
    raceVuk.Kick 58, 10
End Sub
Sub timerRampDiverter_Timer()
	DiverterP002.RotZ=DiverterP002.RotZ+DiverterDir
	If DiverterP002.RotZ>0 AND DiverterDir=1 Then Me.Enabled=0:DiverterP002.RotZ=0
	If DiverterP002.RotZ<-60 AND DiverterDir=-1 Then Me.Enabled=0:DiverterP002.RotZ=-60
End Sub