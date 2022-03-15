'***********************************************************************************************************************
'*****  RED ALERT PINBALL                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Option Explicit
Randomize

DebugOutClear()



'TABLE OPTIONS

Dim usePUP:usePUP = True 'Use Pup Pack or FlexDMD. false = FlexDMD, true = Pup Pack

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

Const typefont = "Raleway Medium"
Const numberfont = "Bebas Neue"
Const zoomfont = "Fundamental  Brigade"
Const zoombgfont = "Fundamental 3D  Brigade" ' needs to be an outline of the zoomfont
Const cGameName = "cyberrace"
Const myVersion = "1.0.0"
Const BallSize = 50
Const BallMass = 1.5
Const MaxPlayers = 4
Const BallSaverTime = 15 
Const MaxMultiplier = 6 
Const MaxMultiballs = 5
Const bpgcurrent = 3
Dim pBackglass:pBackglass=2
Const RollingSoundFactor = 1 		'Change volume of rolling sounds

Const VR_ON = False

'----- Shadow Options -----
Dim DynamicBallShadowsOn: DynamicBallShadowsOn = 1		'0 = no dynamic ball shadow, 1 = enable dynamic ball shadow

If VR_ON = True Then
	DynamicBallShadowsOn = 0
End If

'///////////////////////-----Rubberizer-----////////////////////
const RubberizerEnabled = 1 '0 = normal flip rubber, 1 = more lively rubber for flips
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
	Dim gameState, gameStarted
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

Function RndNum(min,max)
 RndNum = Int(Rnd()*(max-min+1))+min     ' Sets a random number between min AND max
End Function

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







