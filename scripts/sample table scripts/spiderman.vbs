'Spider-Man Vault Edition
'Stern 2016
'Table Recreation by Alessio for Visual Pinball 10

' Thalamus 2018-07-24
' Added/Updated "Positional Sound Playback Functions" and "Supporting Ball & Sound Functions"
' Includeds fix by DjRobX
' Added InitVpmFFlipsSAM
 
' Thalamus 2018-09-16 : Improved directional sounds

' ”Siggi’s Spiderman Classic Edition: VPW Mod”

'VPW edits
' 00X - benji/iaakki - various versions
' 006 - iaakki - NF script updated one more time, GI resolved, solenoid light control added, insert materials redone and adjusted, insert text flasher should be done
' 009 - iaakki - GI rework and various tweaks. Sidewalls are borked
' 010 - Benji - Added reflective metal texture to walls (only reflect with SSR Enabled) and color graded all the graphics. Added preliminary beveled edges to bottom half of plastics
' 011 - iaakki - RGB GI implemented, various fixes
' 014 - iaakki - pf&text images reworked, inserts made more shallow, GI adjusted different when mode on
' 015 - iaakki - villain spots created, heads material swapped
' 016 - Benji - Adjusted bevels and baked GI onto playfield (experimental) old playfield still in image manager
' 017 - iaakki - redid rgb gi, some cleanup
' 018.6 - Sixtoe - Added VR room and associated switches, replaced most flashers & hooked up flash prims to lighting, added global rgb gi flasher, tweaked spotlights and added character prims to lighting system, aligned ramps, unified timers, added ball shadow, repalced green goblin for comic version, reverted playfield, aligned apron wall and made visible, raised Apron, changed trigger shapes, removed numerous old incorrect walls and lights, raised metal screws and fittings up slightly
' 018.7 - Tomate - replaced wire run prims and textures
' 019 - Sixtoe - Made more holes in playfield for triggers aand targets, added wood drop sides, added new wall for sw43a image, added backglass to gi system, hooked up light refllection flashers on sandman and added some to goblin and lock lights.
' 020 - Benji - Added color grade to  playfield from 019
' 021 - Benji reintroduced more yellows to overall color grade
' 022 - tomate - spiderwebs and diverters redone, new textures for metals, diverters and spiderwebs. Improved wire ramp textures
' 023 - Sixtoe - fixed some depth bias issues, fixed rear back wood, fixed pop bumper flashers, fixed a few flashers
' 024 - tomate - Some tweaks to the textures, shadows in the apron and reduction of the file weight by lowering the resolution of some textures
' 025 - iaakki - Latest NF flips code, cabinetmode, fixed desktop mode, small fix to default pov, readjusted flips and fixed trigger areas
' 026 - iaakki - RGB GI brightness adjusted
' 029 - oqq -  added some missing variables. swapped out 1 at ballwithball colission ( not sure if its the right one ) . Bumper sound ... svapped out Vol(activeball) with 0.2 at RandomSoundBumperTop
' 031 - tomate - add Goblin's bracket and some work on Goblin texture
' RC1 - iaakki - default options set, flipnudge check fixed, sandman standup target bank physics reworked
' RC2 - tomate - new prims and brackets for all villains, Sandman texture fixed so it doesn't collide with the ramp, add some thickness to central plastic, shadows added to apron
' RC3 - tomate - new bumper rings prims and new textures
' RC4 - Sixtoe - redid sandman and ock "holder" prims and textures, fixed goblin lighting, fixed spider sense lighting, unlinked difficulty rubbers from main prim and repositioned correctly, removed floating screw, various depth bias issues corrected, cleaned up unused images
' RC5 - iaakki - Some inserts fixed
' RC6 - iaakki - flupper domes
' RC7 - iaakki - dome flasher adjust, info fields updated, script cleanup
' RC8 - oqq/tomate - add movement to goblin bracket and separate prims
' RC9 - Sixtoe - Added invisible walls to stop ball being lost under top right ramp and hopping over centre targets, updated laser sensor lights, split cover plastics and adjusted position and materials so they're in the right place, added ultra minimal vr room options, colour corrected DMD
' RC10 - Sixtoe - Fixed what I broke because I can't code at 2am, various tweaks
' v1.0.0 - iaakki/sixtoe - Final tune and testing

Option Explicit
Randomize


DebugOutClear()

'**********************************************************************************************************
'    Table options
'**********************************************************************************************************

'///////////////////////-----General Sound Options-----///////////////////////
'// VolumeDial:
'// VolumeDial is the actual global volume multiplier for the mechanical sounds.
'// Values smaller than 1 will decrease mechanical sounds volume.
'// Recommended values should be no greater than 1.
Const VolumeDial = 0.8

'Art Side Panels
Const ArtSides = 0

'Cabinet mode - Will hide the rails and scale the side panels higher
Const CabinetMode = 0

'///////////////////////-----VR Room-----///////////////////////
VRRoom = 0 ' 0 - VR Room off, 1 - Minimal Room, 2 - Ultra Minimal


'***********	Set the Flippers Type	*********************************

'Make flipper solenoid to alter active ball behavior
Const FlipSolNudge = 1

Const slackyflips = 1

'Live catch window size. Higher value will make live catching easier. 8-32
Const LiveCatch = 16

'************************************************************************

'GI Color Mod - Choose your own custom color for GI. 
'Primary Colors
'Red = 255, 0, 0
'Green = 0, 255, 0
'Blue = 0, 0, 255
'Incandescent = 255, 197, 143
'Refer to https://rgbcolorcode.com for customized color codes

'Enter RGB values below for "BULB" color
GIColorRed       =  255
GIColorGreen     =  195
GIColorBlue      =  100
dim GIColorRedOrig : GIColorRedOrig =  GIColorRed
dim GIColorGreenOrig : GIColorGreenOrig = GIColorGreen
dim GIColorBlueOrig : GIColorBlueOrig = GIColorBlue

On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

Dim Ballsize,BallMass
BallSize = 50
BallMass = (Ballsize^3)/125000

Dim DesktopMode:DesktopMode = Table1.ShowDT
Dim UseVPMDMD
If VRRoom <> 0 Then UseVPMDMD = True Else UseVPMDMD = DesktopMode

Const UseVPMModSol = 1

LoadVPM "01560000", "sam.VBS", 3.10

'********************
'Standard definitions
'********************

Const UseSolenoids = 1
Const UseLamps = 0
Const UseSync = 0
Const HandleMech = 0

'Standard Sounds
Const SSolenoidOn = "Solenoid"
Const SSolenoidOff = ""
Const SFlipperOn = "FlipperSu"
Const SFlipperOff = "FlipperGiu"
Const SCoin = "coin"

'************
' Table init.
'************

'Const cGameName = "sman_261" 'ENGLISH Normal VERSION

'Const cGameName = "smanve_101" 'ENGLISH Vault Edition VERSION

Const cGameName = "smanve_101c" 'ENGLISH  Vault Edition VERSION DMD COLORED

'Const cGameName = "sman_210ai" 'ITALIAN Normal VERSION

'Variables
Dim bsTrough, bsSandman, bsDocOck, x
Dim mag1
Dim PlungerIM
Dim PalleInGioco
Dim Attendi
Dim DocMagnet

Sub Table1_Init
    vpmInit Me
    With Controller
        .GameName = cGameName
        If Err Then MsgBox "Can't start Game " & cGameName & vbNewLine & Err.Description:Exit Sub
        .SplashInfoLine = "Spider Man Vault Edition(Stern 2016)"
        .Games(cGameName).Settings.Value("rol") = 0
        .HandleKeyboard = 0
        .ShowTitle = 0
        .ShowDMDOnly = 1
        .ShowFrame = 0
        .HandleMechanics = 0
        .Hidden = DesktopMode
        On Error Resume Next
        .Run GetPlayerHWnd
        If Err Then MsgBox Err.Description
        On Error Goto 0
    End With


    'Trough
	Set bsTrough = New cvpmTrough
	bsTrough.Size = 4
	bsTrough.InitSwitches Array(21, 20, 19, 18)
'	bsTrough.EntrySw = 0
	bsTrough.InitExit BallRelease, 90, 8
	bsTrough.InitExitSounds SoundFX("Solenoid",DOFContactors), SoundFX("ballrelease",DOFContactors)
	bsTrough.Balls = 4

	'Sandman VUK
	Set bsSandman = New cvpmSaucer
	bsSandman.InitKicker sw59, 59, 0, 45, 1.56 'ORIGINALE: 59,0,35,1.56
	bsSandman.InitSounds "kicker_enter", SoundFX("Solenoid",DOFContactors), SoundFX("ExitSandman",DOFContactors)

	'Doc Ock VUK
	Set bsDocOck = New cvpmSaucer
	bsDocOck.InitKicker sw36, 36, 0, 45, 1.56   'ORIGINALE: 36,0,35,1.56

	bsDocOck.InitSounds "kicker_enter", SoundFX("Solenoid",DOFContactors), SoundFX("ExitDoc",DOFContactors)

	'Doc Ock Magmet
	Set DocMagnet = New cvpmMagnet
	DocMagnet.InitMagnet DocOckMagnet, 50
	DocMagnet.Solenoid = 3
	'DocMagnet.GrabCenter = True
	DocMagnet.CreateEvents "DocMagnet"

	'Loop Diverter
	diverter.IsDropped = 1

    'Nudging
	vpmNudge.TiltSwitch=-7
  	vpmNudge.Sensitivity=3
  	vpmNudge.TiltObj=Array(Bumper1,Bumper2,Bumper3,LeftSlingshot,RightSlingshot)

	'Main Timer init
	PinMAMETimer.Interval = PinMAMEInterval
	PinMAMETimer.Enabled = 1

    ' Impulse Plunger
    Const IMPowerSetting = 55
    Const IMTime = 0.6
    Set plungerIM = New cvpmImpulseP
    With plungerIM
		.InitImpulseP swplunger, IMPowerSetting, IMTime
		.Switch 23
		.Random 0.3
		.InitExitSnd SoundFX("solenoid",DOFContactors), ""
        .CreateEvents "plungerIM"
    End With
	Attendi=1
	PausaAnimazione.Enabled=1
	Controller.Switch(50)=1
	Controller.Switch(53)=1
	Controller.Switch(57)=1
	BankAlto=1
	SandmanPronto=0
	PalleInGioco=0
	SandmanAlto=0
	PallaBucoOctopus=0
	PallaBucoSandman=0
	PallaSuMagnete=0
	sw16Premuto=0
	sw17Premuto=0
	'AlzaSandman
	sw36.Enabled=0
	sw59.Enabled=0
	'SetGIColor
	InitVpmFFlipsSAM
 End Sub

'**********
'Timer Code
'**********

	Sub FrameTimer_Timer()
		BallShadowUpdate
		RDampen
		GatesTimer
		RollingSound
		LampTimer
		VR_Primary_plunger.Y = -50 + (5* Plunger.Position) -20
	End Sub



Sub table1_Paused:Controller.Pause = 1:End Sub
Sub table1_unPaused:Controller.Pause = 0:End Sub
Sub table1_exit():Controller.Stop:End Sub

'************************************
' PAUSA ANIMAZIONE DOPO AVVIO TAVOLO
'************************************

Sub PausaAnimazione_Timer()
	Attendi=0
	sw63.IsDropped=1
	Me.Enabled=0
End Sub

Dim bulb

Set GICallback2 = GetRef("SetGI")

Set GICallback = GetRef("GIUpdate")

Sub GIUpdate(no, Enabled)
	If Enabled = 0 Then
		DOF 201, DOFOff
		PinCab_Backglass.image = "BackglassImage"
		LuceWall1.Visible=0
		LuceWall2.Visible=0
		LuceWall3.Visible=0
		LuceWall4.Visible=0
		LuceWall5.Visible=0
		LuceWall6.Visible=0
		LuceWall7.Visible=0
		LuceWall8.Visible=0
		FlasherRGBGI.Visible=0
	Else
		DOF 201, DOFOn
		PinCab_Backglass.image = "BackglassImageOn"
		LuceWall1.Visible=1
		LuceWall2.Visible=1
		LuceWall3.Visible=1
		LuceWall4.Visible=1
		LuceWall5.Visible=1
		LuceWall6.Visible=1
		LuceWall7.Visible=1
		LuceWall8.Visible=1
		FlasherRGBGI.Visible=1
	End if
End Sub

Sub LHP1_UnHit()
	If ActiveBall.velY < 0  Then		'ball is going up
	PlaySoundAtVol "rrenter", ActiveBall, 1
	PlaysoundAtVol "plasticrolling", ActiveBall, 1
	Else
	StopSound "rrenter"
	StopSound "plasticrolling"
	End If
End Sub

Sub LHP2_UnHit()
	If ActiveBall.velY < 0  Then		'ball is going up
	PlaysoundAtVol "plasticrolling", ActiveBall, 1
	PlaySoundAtVol "rrenter", ActiveBall, 1
	Else
	StopSound "plasticrolling"
	StopSound "rrenter"
	End If
End Sub

Sub RHP1_UnHit()
	If ActiveBall.velY < 0  Then		'ball is going up
	PlaysoundAtVol "plasticrolling", ActiveBall, 1
	PlaySoundAtVol "rrenter", ActiveBall, 1
	Else
	StopSound "plasticrolling"
	StopSound "rrenter"
	End If
End Sub

'********************************************
'  Depotenzia magnete dopo presa della palla
'********************************************

Dim PallaSuMagnete

Sub PresenzaSuMagnete_Hit() 'CON PALLA SUL MAGNETE RIDUCE LA POTENZA DELLA CALAMITA
	If DocMagnet.MagnetON= True Then DepotenziaMagnete.Enabled=True: PlaysoundAtVol "Magnete", ActiveBall, 1
	PallaSuMagnete=1
End Sub


Sub PresenzaSuMagnete_UnHit() 'IN USCITA DAL MAGNETE VIENE RIPRISTINATA LA POTENZA DELLA CALAMITA
	If DocMagnet.MagnetON= False Then DocMagnet.InitMagnet DocOckMagnet, 50
	PallaSuMagnete=0
End Sub


Sub DepotenziaMagnete_timer() 'TIMER PER RIDURRE LA POTENZA DEL MAGNETE
	DocMagnet.MagnetON= False
	DocMagnet.InitMagnet DocOckMagnet, 2
	DocMagnet.MagnetON= True
	Me.Enabled = 0
End Sub


'************************************
'  Lancio palla dopo sgancio magnete
'************************************

Dim Pausa

Sub solDocMagnet(enabled)
    MagnetOffTimer.Enabled = Not enabled
    If enabled Then DocMagnet.MagnetOn = True
End Sub

Sub MagnetOffTimer_Timer
    Dim ball
    For Each ball In DocMagnet.Balls
        With ball
		'RilanciaPallaMagnete.Enabled=1
			.VelX = 15: .VelY = -8: Pausa= 1  'ERA VelX = 15: .VelY = -7
          'If PalleIngioco=1 Then .VelX = 15: .VelY = -15: Pausa= 1 'REGOLARE VELY PER AUMENTARE IL LANCIO DELLA PALLA (NEGATIVO PER ANDARE VERSO L'ALTO)
		  'If PalleIngioco>1 Then .VelX = 15: .VelY = -15: Pausa= 1 'REGOLARE VELY PER AUMENTARE IL LANCIO DELLA PALLA (NEGATIVO PER ANDARE VERSO L'ALTO)
        End With
    Next
    Me.Enabled = False:DocMagnet.MagnetOn = False
End Sub

Sub DocOckMagnet_UnHit()
	If Pausa=1 Then
	DocMagnet.MagnetON= False
	DocMagnet.InitMagnet DocOckMagnet, 0
	DocOckMagnet.Enabled=0
	MagneteDisabilitato.Enabled=1
	End If
End Sub

Sub MagneteDisabilitato_Timer()
	DocMagnet.InitMagnet DocOckMagnet, 50
	Pausa= 0
	DocOckMagnet.Enabled=1
	Me.Enabled=0
End Sub

'**********
' Keys
'**********

Sub Table1_KeyDown(ByVal Keycode)

	If keycode = PlungerKey Then
		Plunger.PullBack:SoundPlungerPull()
	End If

 	If Keycode = RightFlipperKey then
		Controller.Switch(86)=1  ' UR Flipper
 	End If

	If keycode = LeftTiltKey Then PlaySound SoundFX("fx_nudge",0)
	If keycode = RightTiltKey Then PlaySound SoundFX("fx_nudge",0)
	If keycode = CenterTiltKey Then PlaySound SoundFX("fx_nudge",0)


'nFozzy physics'
	If keycode = LeftFlipperKey Then LFPress = 1
	If keycode = RightFlipperKey Then rfpress = 1


	If vpmKeyDown(Keycode) Then Exit Sub
 End Sub

Sub Table1_KeyUp(ByVal Keycode)
	If keycode = PlungerKey Then
		Plunger.Fire
		'If BIPL = 1 Then
			SoundPlungerReleaseBall()			'Plunger release sound when there is a ball in shooter lane
		'Else
		'	SoundPlungerReleaseNoBall()			'Plunger release sound when there is no ball in shooter lane
		'End If
	End If

'nfozzy physics'
	If keycode = LeftFlipperKey Then 
		lfpress = 0
		leftflipper.eostorqueangle = EOSA
		leftflipper.eostorque = EOST
	End If
	If keycode = RightFlipperKey Then 
		rfpress = 0
		rightflipper.eostorqueangle = EOSA
		rightflipper.eostorque = EOST
	End If

	If vpmKeyUp(Keycode) Then Exit Sub

 	If Keycode = RightFlipperKey then
		Controller.Switch(86)=0 ' UR flipper
 	End If
 End Sub

'Realtime updates

Sub GatesTimer()
	GateSWsx.RotZ= -Gate2.currentangle
	GateSWdx.RotZ= -Gate3.currentangle
	GateP0.RotX = -Gate4.currentangle + 90
	GateP1.RotX = -Gate5.currentangle + 90
	GateP2.RotX = -LeftRampEnd.currentangle + 90    'gate V shape
	GateP3.RotX = -LeftRampStart.currentangle + 90
	GateP4.RotX = -RightRampEnd.currentangle +90    'gate V shape
	GateP5.RotX = -RightRampStart.currentangle +90
	UpdateFlipperLogos
End Sub

Sub UpdateFlipperLogos
    LFLogo.RotY = LeftFlipper.CurrentAngle
    RFLogo.RotY = RightFlipper.CurrentAngle
	flipperr1.RotY = RightFlipper2.CurrentAngle
End Sub

'Solenoids
SolCallback(1) = "solTrough"
SolCallback(2) = "solAutofire"
SolCallback(3) = "solDocMagnet"
'SolModCallback(3) = "SetModLampmm 0, 200,"

SolCallback(4) = "solDocVUK"
SolCallback(5) = "solDocMotor"
'SolCallback(6) = "ShakerMotor"
SolCallback(7) = "Gate2.open ="
SolCallback(8) = "Gate3.open ="
SolCallback(9) = "solLBump"
SolCallback(10) = "solRBump"
SolCallback(11) = "solBBump"
SolCallback(12) = "solSandVUK"
SolCallback(13) = "solSandMotor"
'SolCallback(14) = "solURFlipper"
SolCallback(15) = "SolLFlipper" '"solLFlipper"
SolCallback(16) = "SolRFlipper" '"solRFlipper"
SolCallback(17) = "solLSling"
SolCallback(18) = "solRSling"
SolCallback(19) = "ShakeGoblin"
SolCallback(20) = "sol3Bank"
SolCallback(22) = "solDivert"
SolCallback(24) = "vpmSolSound SoundFX(""Knocker"",DOFKnocker),"
SolModCallBack(21) = "FlashSol21" '"SetModLamp 21," 'DomeRed RedFlasherMid
SolModCallBack(23) = "SetModLamp 23,"
SolModCallBack(25) = "SetModLamp 25,"
SolModCallBack(26) = "SetModLamp 26,"
SolModCallback(27) = "FlashSol27" '"SetModLamp 27, " 'DomeYellow YellowFlasherTop
SolModCallback(28) = "SetModLamp 28, "
SolModCallBack(29) = "FlashSol29" ' "SetModLamp 29," 'DomerBlue BlueFlasherTop
SolModCallBack(30) = "FlashSol30" '"SetModLamp 30," 'DomerRed RedFlasherTop
SolModCallBack(31) = "SetModLamp 31,"


'Solenoid Functions
Sub solTrough(Enabled)
	If Enabled Then
		bsTrough.ExitSol_On
		vpmTimer.PulseSw 22
	End If
 End Sub

Sub solAutofire(Enabled)
	If Enabled Then
		PlungerIM.AutoFire
	End If
 End Sub


Sub solDocMotor(Enabled)
	If Enabled Then
		If sw63.IsDropped Then
		Controller.Switch(58) = 0
		Controller.Switch(57) = 1
		sw63.IsDropped=0
		AbbassaOctopus
	Else
		Controller.Switch(57) = 0
		Controller.Switch(58) = 1
		If Attendi=0 Then AlzaOctopus
		End If
	End If
 End Sub

Sub solSandMotor(Enabled)
	If Enabled Then
		If sw42.IsDropped Then
		Controller.Switch(54) =0
		Controller.Switch(53) =1
		sw42.IsDropped=0
		AbbassaSandman
	Else
		Controller.Switch(53) =0
		Controller.Switch(54) =1
		AlzaSandman
		End If
	End If
 End Sub

Sub Sol3Bank(Enabled)
	If Enabled Then
		If sw11.IsDropped Then
		Controller.Switch(49)=0
		Controller.Switch(50)=1
		ParetiBankSu
		AlzaBank
	Else
		Controller.Switch(50)=0
		Controller.Switch(49)=1
		AbbassaBank
		End If
	End If
End Sub

Sub solSandVUK(Enabled) 'GESTIONE SOLENOIDE Sandman
	If Enabled Then
		bsSandman.ExitSol_On
		SolenoideSandmanAbilitato
		Playsound "SolenoideFuori" ' TODO
 	End If
 End Sub

Sub SolenoideSandmanAbilitato
	SolenoideSandman.TransZ= -50
	SolenoideUscitaSandman.enabled=1
End Sub

Sub SolenoideUscitaSandman_Timer 'GESTIONE PISTONE LANCIO PALLA Octopus
	SolenoideSandman.TransZ= -60
	Playsound "SolenoideDentro" ' TODO
	Me.Enabled=0
End Sub

Sub solDocVUK(Enabled) 'GESTIONE SOLENOIDE Octopus
	If Enabled Then
		bsDocOck.ExitSol_On
		SolenoideOctopusAbilitato
		Playsound "SolenoideFuori" ' TODO
 	End If
 End Sub

Sub SolenoideOctopusAbilitato
	SolenoideOctopus.TransZ= -50
	SolenoideUscitaOctopus.enabled=1
End Sub

Sub SolenoideUscitaOctopus_Timer 'GESTIONE PISTONE LANCIO PALLA Octopus
	SolenoideOctopus.TransZ= -59
	PlaysoundAtVol "SolenoideDentro", SolenoideOctopus, 1
	Me.Enabled=0
End Sub

Dim LockAttivo

Sub solDivert(Enabled)
	If Enabled Then
		Diverter.IsDropped = 0
		Playsound SoundFX("Diverter",DOFContactors) ' TODO
		LockAttivo = 1
	Else
		Diverter.IsDropped = 1
		Playsound SoundFX("Diverter",DOFContactors) ' TODO
		LockAttivo=0
	End If
 End Sub

'Drains and Kickers
Sub drain_Hit()
	PalleInGioco = PalleInGioco - 1
	bsTrough.AddBall Me
	PlaySoundAtVol "drain", Drain, 1

 End Sub

Sub BallRelease_UnHit()
	PalleInGioco = PalleInGioco + 1
 End Sub

'************************************************
'************Slingshots Animation****************
'************************************************

Dim RStep, Lstep

Sub LeftSlingShot_Slingshot: vpmTimer.PulseSw 26: End Sub
Sub RightSlingShot_Slingshot: vpmTimer.PulseSw 27: End Sub

Sub solLSling(enabled)
	If enabled then
		RandomSoundSlingshotLeft(SLING1)
		LSling.Visible = 0
		LSling1.Visible = 1
		sling1.TransZ = -27
		LStep = 0
		LeftSlingShot.TimerEnabled = 1
	End If
End Sub

Sub solRSling(enabled)
	If enabled then
		RandomSoundSlingshotRight(SLING2)
		RSling.Visible = 0
		RSling1.Visible = 1
		sling2.TransZ = -27
		RStep = 0
		RightSlingShot.TimerEnabled = 1
	End If
End Sub

Sub LeftSlingShot_Timer
    Select Case LStep
        Case 3:LSLing1.Visible = 0:LSLing2.Visible = 1:sling1.TransZ = -15
        Case 4:LSLing2.Visible = 0:LSLing.Visible = 1:sling1.TransZ = 0:LeftSlingShot.TimerEnabled = 0
    End Select
    LStep = LStep + 1
End Sub

Sub RightSlingShot_Timer
    Select Case RStep
        Case 3:RSLing1.Visible = 0:RSLing2.Visible = 1:sling2.TransZ = -15
        Case 4:RSLing2.Visible = 0:RSLing.Visible = 1:sling2.TransZ = 0:RightSlingShot.TimerEnabled = 0
    End Select
    RStep = RStep + 1
End Sub

'************************************************
'**************Bumpers Animation*****************
'************************************************

Dim dirRing1:dirRing1 = -1
Dim dirRing2:dirRing2 = -1
Dim dirRing3:dirRing3 = -1

Sub Bumper1_Hit:vpmTimer.PulseSw 30:End Sub
Sub Bumper2_Hit:vpmTimer.PulseSw 31:End Sub
Sub Bumper3_Hit:vpmTimer.PulseSw 32:End Sub

'
Sub solLBump (enabled): If enabled then Bumper1.TimerEnabled = 1: RandomSoundBumperTop(Bumper1):End If: End Sub
Sub solRBump (enabled): If enabled then Bumper2.TimerEnabled = 1: RandomSoundBumperMiddle(Bumper2) : End If: End Sub
Sub solBBump (enabled): If enabled then Bumper3.TimerEnabled = 1: RandomSoundBumperBottom(Bumper3) : End If: End Sub

Sub Bumper1_timer()
	BumperRing1.Z = BumperRing1.Z + (5 * dirRing1)
	If BumperRing1.Z <= -40 Then dirRing1 = 1
	If BumperRing1.Z >= 0 Then
		dirRing1 = -1
		BumperRing1.Z = 0
		Me.TimerEnabled = 0
	End If
End Sub

Sub Bumper2_timer()
	BumperRing2.Z = BumperRing2.Z + (5 * dirRing2)
	If BumperRing2.Z <= -40 Then dirRing2 = 1
	If BumperRing2.Z >= 0 Then
		dirRing2 = -1
		BumperRing2.Z = 0
		Me.TimerEnabled = 0
	End If
End Sub

Sub Bumper3_timer()
	BumperRing3.Z = BumperRing3.Z + (5 * dirRing3)
	If BumperRing3.Z <= -40 Then dirRing3 = 1
	If BumperRing3.Z >= 0 Then
		dirRing3 = -1
		BumperRing3.Z = 0
		Me.TimerEnabled = 0
	End If
End Sub

'Rollovers
Sub sw23_Hit:Controller.Switch(23) = 1:RandomSoundRollover():End Sub
Sub sw23_UnHit:Controller.Switch(23) = 0:SoundPlungerReleaseBall(): End Sub

'Lower Lanes
Sub sw24_Hit:Controller.Switch(24) = 1 : RandomSoundRollover():End Sub
Sub sw24_UnHit:Controller.Switch(24) = 0:End Sub
Sub sw25_Hit:Controller.Switch(25) = 1:RandomSoundRollover():End Sub
Sub sw25_UnHit:Controller.Switch(25) = 0:End Sub
Sub sw28_Hit:Controller.Switch(28) = 1:RandomSoundRollover():End Sub
Sub sw28_UnHit:Controller.Switch(28) = 0:End Sub
Sub sw29_Hit:Controller.Switch(29) = 1:RandomSoundRollover():End Sub
Sub sw29_UnHit:Controller.Switch(29) = 0:End Sub

'Upper Lanes
Sub sw8_Hit:Controller.Switch(8) = 1:RandomSoundRollover()
End Sub
Sub sw8_UnHit:Controller.Switch(8) = 0:End Sub
Sub sw33_Hit:Controller.Switch(33) = 1:RandomSoundRollover():End Sub
Sub sw33_UnHit:Controller.Switch(33) = 0:End Sub
Sub sw34_Hit:Controller.Switch(34) = 1:RandomSoundRollover():End Sub
Sub sw34_UnHit:Controller.Switch(34) = 0:End Sub
Sub sw35_Hit:Controller.Switch(35) = 1:RandomSoundRollover():End Sub
Sub sw35_UnHit:Controller.Switch(35) = 0:End Sub

'Right
Sub sw37_Hit:Controller.Switch(37) = 1:RandomSoundRollover():End Sub
Sub sw37_UnHit:Controller.Switch(37) = 0:End Sub
Sub sw38_Hit:Controller.Switch(38) = 1:RandomSoundRollover()
End Sub
Sub sw38_UnHit:Controller.Switch(38) = 0:End Sub

'Right Under Flipper
Sub sw46_Hit:Controller.Switch(46) = 1:RandomSoundRollover():End Sub
Sub sw46_UnHit:Controller.Switch(46) = 0:End Sub

'Spinner
Sub sw7_Spin:vpmTimer.PulseSw 7:PlaySoundAtVol "spinner", sw7, SpinnerSoundLevel : End Sub  

'Right Ramp
Sub sw44_Hit:Controller.Switch(44) = 1:SoundHeavyGate():End Sub

Sub sw44_UnHit:Controller.Switch(44) = 0:End Sub

Sub sw45_Hit:Controller.Switch(45) = 1:SoundHeavyGate()
End Sub
Sub sw45_UnHit:Controller.Switch(45) = 0:End Sub

'Left Ramp
Sub sw47_Hit:Controller.Switch(47) = 1:SoundHeavyGate():End Sub
Sub sw47_UnHit:Controller.Switch(47) = 0:End Sub

Sub sw48_Hit:Controller.Switch(48) = 1:SoundHeavyGate()
End Sub

Sub sw48_UnHit:Controller.Switch(48) = 0:End Sub

Sub sw49_Hit
	PlaysoundAtVol "gate", sw49, VolGates
End Sub

'Venom da rampa venom
Sub sw43_Hit
	vpmTimer.PulseSw 43
End Sub

Sub sw43a_Hit
End Sub


'Doc Ock
Sub S63_Hit:Controller.Switch(63)=1:End Sub

Sub S63_unHit:Controller.Switch(63)=0:End Sub

'Sandman
Sub s42_Hit:Controller.Switch(42)=1:End Sub
Sub s42_unHit:Controller.Switch(42)=0:End Sub
'Lock Opto
Sub sw6_Hit:vpmTimer.PulseSw 6
	sw6p.TransX = -5:sw6.TimerEnabled = 1:End Sub

Sub sw6_Timer:sw6p.TransX = 0: Me.TimerEnabled = 0: End Sub

Dim SandmanPronto

Sub SandmanOK_Hit
	SandmanPronto=1
	If ActiveBall.velY > 2  Then		'ball is going up
	sw59.enabled=1
	Else
	sw59.enabled=0
	End If
End Sub

Sub OctopusOK_Hit
	If ActiveBall.velY > 2  Then		'ball is going up
	sw36.enabled=1
	Else
	sw36.enabled=0
	End If
End Sub

Sub RHP1_Hit()
If ActiveBall.velY < 0  Then		'ball is going up
PlaySoundAtVol "rrenter", ActiveBall, 1
Else
StopSound "rrenter"
End If
End Sub

'Sandman Optos
Dim zMultiplier

Sub sw9_Hit
	Select Case Int(Rnd * 4) + 1
        Case 1: zMultiplier = 2.55
        Case 2: zMultiplier = 2.2
        Case 3: zMultiplier = 1.9
        Case 4: zMultiplier = 1.7
    End Select
    activeball.velz = activeball.velz*zMultiplier
	If SandmanPronto=0 Then vpmTimer.PulseSw 9
	Bank.TransX = 5
	BankColpito.Enabled = 1
End Sub

Sub sw10_Hit
	Select Case Int(Rnd * 4) + 1
        Case 1: zMultiplier = 2.55
        Case 2: zMultiplier = 2.2
        Case 3: zMultiplier = 1.9
        Case 4: zMultiplier = 1.7
    End Select
    activeball.velz = activeball.velz*zMultiplier
	If SandmanPronto=0 Then vpmTimer.PulseSw 10
	Bank.TransX = 5
	BankColpito.Enabled = 1
End Sub

Sub sw11_Hit
	Select Case Int(Rnd * 4) + 1
        Case 1: zMultiplier = 2.55
        Case 2: zMultiplier = 2.2
        Case 3: zMultiplier = 1.9
        Case 4: zMultiplier = 1.7
    End Select
    activeball.velz = activeball.velz*zMultiplier
	If SandmanPronto=0 Then vpmTimer.PulseSw 11
	Bank.TransX = 5
	BankColpito.Enabled = 1
End Sub

Sub BankColpito_Timer()
	Bank.TransX = -0
	Me.Enabled = 0
End Sub

Sub sw12_Hit:vpmTimer.PulseSw 12
	sw12p.TransX = -5:sw12.TimerEnabled = 1:End Sub

Sub sw12_Timer:sw12p.TransX = 0:Me.TimerEnabled = 0: End Sub

Sub sw13_Hit:vpmTimer.PulseSw 13
	sw13p.TransX = -5:sw13.TimerEnabled = 1:End Sub

Sub sw13_Timer:sw13p.TransX = 0:Me.TimerEnabled = 0:End Sub

'Green Goblin Optos
Sub sw1_Hit:vpmTimer.PulseSw 1
	sw1p.TransX = -5: ModeTimer.Enabled = 1 : sw1.TimerEnabled = 1:End Sub

Sub sw1_Timer:sw1p.TransX = 0:Me.TimerEnabled = 0:End Sub

Sub sw2_Hit:vpmTimer.PulseSw 2
	sw2p.TransX = -5: sw2.TimerEnabled = 1:End Sub

Sub sw2_Timer:sw2p.TransX = 0:Me.TimerEnabled = 0:End Sub

Sub sw3_Hit:vpmTimer.PulseSw 3
	sw3p.TransX = -5: sw3.TimerEnabled = 1:End Sub

Sub sw3_Timer:sw3p.TransX = 0:Me.TimerEnabled = 0:End Sub

Sub sw4_Hit:vpmTimer.PulseSw 4
	sw4p.TransX = -5: sw4.TimerEnabled = 1:End Sub

Sub sw4_Timer:sw4p.TransX = 0:Me.TimerEnabled = 0:End Sub

Sub sw5_Hit:vpmTimer.PulseSw 5
	sw5p.TransX = -5: sw5.TimerEnabled = 1:End Sub

Sub sw5_Timer:sw5p.TransX = 0:Me.TimerEnabled = 0:End Sub

'Right 3Bank Optos
Sub sw39_Hit:vpmTimer.PulseSw 39
	sw39p.TransX = -5: sw39.TimerEnabled = 1:End Sub

Sub sw39_Timer:sw39p.TransX = 0:sw39.TimerEnabled = 0:End Sub

Sub sw40_Hit:vpmTimer.PulseSw 40
	sw40p.TransX = -5: sw40.TimerEnabled = 1:End Sub

Sub sw40_Timer:sw40p.TransX = 0:sw40.TimerEnabled = 0:End Sub

Sub sw41_Hit:vpmTimer.PulseSw 41
	sw41p.TransX = -5: sw41.TimerEnabled = 1:End Sub

Sub sw41_Timer:sw41p.TransX = 0:sw41.TimerEnabled = 0:End Sub

'Sub PallaBloccata_Hit: vpmTimer.PulseSw 9:vpmTimer.PulseSw 10:vpmTimer.PulseSw 11:End Sub

'Switch 14
Sub RPostColl21_Hit():vpmTimer.PulseSw 14:End Sub

'Sandman VUK

Sub MuroSandman_Hit()
	Playsound "Parete" 'TODO
End Sub

Sub sw59Abilitato_Hit()
	Playsound "EnterHole" 'TODO
	If PallaBucoSandman=0 Then
	sw59.Enabled=1
	End If
End Sub

Sub sw59Abilitato_UnHit()
	If PallaBucoSandman=0 Then
	sw59.Enabled=1
	End If
End Sub

Sub sw59_UnHit()  'Uscita buco sandman
	SandmanPronto=0
	PallaBucoSandman=0
	Playsound "popper" 'TODO
	sw59.Enabled=0
End Sub

Sub sw59_Hit()  'Entrata buco sandman
	bsSandman.AddBall Me
	PallaBucoSandman=1
	ModeTimer.Enabled = 1
End Sub

'DocOck VUK

Dim PallaBucoOctopus, PallaBucoSandman

Sub MuroOctopus_Hit()
	Playsound "Parete" ' TODO
End Sub

Sub sw36Abilitato_UnHit()
	sw36.Enabled=1
End Sub

Sub sw36Abilitato_Hit()
	Playsound "EnterHole" 'TODO
End Sub

Sub sw36_UnHit()  'Buco doc uscita
	PallaBucoOctopus=0
	sw36.Enabled=0
End Sub

Sub sw36_Hit()  'Buco doc entrata
	bsDocOck.AddBall Me
	PallaBucoOctopus=1
 End Sub

'******************************************************
'				NFOZZY'S FLIPPERS
'******************************************************

Const ReflipAngle = 20

Sub SolLFlipper(Enabled)
    If Enabled Then
		If leftflipper.currentangle < leftflipper.endangle + ReflipAngle Then
           RandomSoundReflipUpLeft LeftFlipper
		Else
			SoundFlipperUpAttackLeft LeftFlipper
			RandomSoundFlipperUpLeft LeftFlipper
		End If
		LF.Fire
    Else
		LeftFlipper.RotateToStart
		If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
			RandomSoundFlipperDownLeft LeftFlipper
		End If
		FlipperLeftHitParm = FlipperUpSoundLevel
    End If
End Sub

Sub SolRFlipper(Enabled)
    If Enabled Then
		If rightflipper.currentangle > rightflipper.endangle - ReflipAngle Then
			RandomSoundReflipUpRight RightFlipper
		Else 
			SoundFlipperUpAttackRight RightFlipper
			RandomSoundFlipperUpRight RightFlipper
		End If
		RightFlipper2.RotateToEnd
		RF.Fire
    Else
		RightFlipper.RotateToStart
		RightFlipper2.RotateToStart
		If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
			RandomSoundFlipperDownRight RightFlipper
		End If	
		FlipperRightHitParm = FlipperUpSoundLevel
    End If
End Sub





'******************************************************
'				FLIPPER AND RUBBER CORRECTION
'******************************************************

dim LF : Set LF = New FlipperPolarity
dim RF : Set RF = New FlipperPolarity

InitPolarity

Sub InitPolarity()
	dim x, a : a = Array(LF, RF)
	for each x in a
		'safety coefficient (diminishes polarity correction only)
		'x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 0	'don't mess with these
		x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1	'disabled
		x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1

		x.enabled = True
		'x.DebugOn = True : stickL.visible = True : tbpl.visible = True : vpmSolFlipsTEMP.DebugOn = True
		x.TimeDelay = 60
	Next

	'rf.report "Velocity"
	addpt "Velocity", 0, 0, 	1
	addpt "Velocity", 1, 0.1, 	1.07
	addpt "Velocity", 2, 0.2, 	1.15
	addpt "Velocity", 3, 0.3, 	1.25
	addpt "Velocity", 4, 0.41, 1.05
	addpt "Velocity", 5, 0.65, 	1.0'0.982
	addpt "Velocity", 6, 0.702, 0.968
	addpt "Velocity", 7, 0.95,  0.968
	addpt "Velocity", 8, 1.03, 	0.945

	AddPt "Polarity", 0, 0, 0
	AddPt "Polarity", 1, 0.05, -5.5
	AddPt "Polarity", 2, 0.4, -5.5
	AddPt "Polarity", 3, 0.8, -5.5	
	AddPt "Polarity", 4, 0.85, -5.25
	AddPt "Polarity", 5, 0.9, -4.25
	AddPt "Polarity", 6, 0.95, -3.75
	AddPt "Polarity", 7, 1, -3.25
	AddPt "Polarity", 8, 1.05, -2.25
	AddPt "Polarity", 9, 1.1, -1.5
	AddPt "Polarity", 10, 1.15, -1
	AddPt "Polarity", 11, 1.2, -0.5
	AddPt "Polarity", 12, 1.25, 0
	AddPt "Polarity", 13, 1.3, 0

	LF.Object = LeftFlipper	
	LF.EndPoint = EndPointLp	'you can use just a coordinate, or an object with a .x property. Using a couple of simple primitive objects
	RF.Object = RightFlipper
	RF.EndPoint = EndPointRp
End Sub

Sub AddPt(aStr, idx, aX, aY)	'debugger wrapper for adjusting flipper script in-game
	dim a : a = Array(LF, RF)
	dim x : for each x in a
		x.addpoint aStr, idx, aX, aY
	Next
End Sub

'Trigger Hit - .AddBall activeball
'Trigger UnHit - .PolarityCorrect activeball
dim LFFlipBall, RFFlipBall : LFFlipBall = 0 : RFFlipBall = 0


Sub TriggerLF_Hit() : LF.Addball activeball : LFFlipBall = 1 : End Sub
Sub TriggerLF_UnHit() : LF.PolarityCorrect activeball : LFFlipBall = 0 : End Sub
Sub TriggerRF_Hit() : RF.Addball activeball : RFFlipBall = 1 : End Sub
Sub TriggerRF_UnHit() : RF.PolarityCorrect activeball : RFFlipBall = 0 : End Sub

'Methods:
'.TimeDelay - Delay before trigger shuts off automatically. Default = 80 (ms)
'.AddPoint - "Polarity", "Velocity", "Ycoef" coordinate points. Use one of these 3 strings, keep coordinates sequential. x = %position on the flipper, y = output
'.Object - set to flipper reference. Optional.
'.StartPoint - set start point coord. Unnecessary, if .object is used.

'Called with flipper - 
'ProcessBalls - catches ball data. 
' - OR - 
'.Fire - fires flipper.rotatetoend automatically + processballs. Requires .Object to be set to the flipper.

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
				'debug.print BallPos & " " & AddX & " " & Ycoef & " "& PartialFlipcoef & " "& VelCoef
				'playsound "fx_knocker"
			End If
		End If
		RemoveBall aBall
	End Sub
End Class


'================================
'Helper Functions


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

Sub ShuffleArrays(aArray1, aArray2, offset)
	ShuffleArray aArray1, offset
	ShuffleArray aArray2, offset
End Sub


Function BallSpeed(ball) 'Calculates the ball speed
    BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

Function PSlope(Input, X1, Y1, X2, Y2)	'Set up line via two points, no clamping. Input X, output Y
	dim x, y, b, m : x = input : m = (Y2 - Y1) / (X2 - X1) : b = Y2 - m*X2
	Y = M*x+b
	PSlope = Y
End Function

Function NullFunctionZ(aEnabled):End Function	'1 argument null function placeholder	 TODO move me or replac eme

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

Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

Function DistancePL(px,py,ax,ay,bx,by) ' Distance between a point and a line where point is px,py
	DistancePL = ABS((by - ay)*px - (bx - ax) * py + bx*ay - by*ax)/Distance(ax,ay,bx,by)
End Function

'******************** Slacky Flips **************************'
Dim FlipY

FlipY = rightflipper.y

'Const FlipY = 1810            'Default flip Y position
Const Dislocation = 2        'Amount of minimum slack, affect to recovery speed too
Const SlackHitLimit = 10    '6-16    Lower value will make slack happen with lower collision force
Const HitForceDivider = 50    '10-100    Lower value will add slack. Set to roughly half of the max hit force(parm) you see when playing
Const MaxSlack = 4
Dim SlackAmount

Sub CheckFlipperSlack(ball, Flipper, Logo, parm)
    If slackyFlips = 1 Then
        SlackAmount = Dislocation + parm / HitForceDivider
        if SlackAmount > MaxSlack then SlackAmount = MaxSlack
        if parm > SlackHitLimit Then
            Flipper.Y = FlipY + SlackAmount
            Logo.Y = FlipY + SlackAmount
            Wall23.timerinterval = 10
            Wall23.timerenabled = 1
            'debug.print parm & " parm and SlackAmount " & SlackAmount
        end If
    end If
end Sub

Sub Wall23_timer()
    'msgbox "location change" & RightFlipper.Y & " and " & LeftFlipper.Y
    if RightFlipper.Y > FlipY + 2 Then
        RightFlipper.Y = RightFlipper.Y - 2
        RFLogo.Y = RFLogo.Y - 2
    else
        RightFlipper.Y = FlipY
        RFLogo.Y = FlipY
    End If
    if LeftFlipper.Y > FlipY + 2 Then
        LeftFlipper.Y = LeftFlipper.Y - 2
        LFLogo.Y = LFLogo.Y - 2
    else
        LeftFlipper.Y = FlipY
        LFLogo.Y = FlipY
    End If

    if LeftFlipper.Y = FlipY and RightFlipper.Y = FlipY Then Me.timerenabled = 0
end Sub

'******************************************************
'			FLIPPER TRICKS
'******************************************************

Const PI = 3.14159

RightFlipper.timerinterval=1
Rightflipper.timerenabled=True

sub RightFlipper_timer()
	FlipperTricks LeftFlipper, LFPress, LFCount, LFEndAngle, LFState
	FlipperTricks RightFlipper, RFPress, RFCount, RFEndAngle, RFState
	If FlipSolNudge = 1 Then
		FlipperNudge RightFlipper, RFEndAngle, RFEOSNudge, LeftFlipper, LFEndAngle
		FlipperNudge LeftFlipper, LFEndAngle, LFEOSNudge,  RightFlipper, RFEndAngle
	End If
end sub

Dim LFEOSNudge, RFEOSNudge

Sub FlipperNudge(Flipper1, Endangle1, EOSNudge1, Flipper2, EndAngle2)
	Dim BOT, b

	If Flipper1.currentangle = Endangle1 and EOSNudge1 <> 1 Then
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
					BOT(b).velx = BOT(b).velx / 1.7
					BOT(b).vely = BOT(b).vely - 1
				end If
			Next
		End If
	Else 
		If Flipper1.currentangle <> EndAngle1 then EOSNudge1 = 0
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
	AnglePP = Atn2((by - ay),(bx - ax)) * 180/PI
End Function

Function Atn2(dy, dx)
	If dx > 0 Then
		Atn2 = Atn(dy / dx)
	ElseIf dx < 0 Then
		Atn2 = Sgn(dy) * (PI - Atn(Abs(dy / dx)))
	ElseIf dy = 0 Then
		Atn2 = 0
	Else
		Atn2 = Sgn(dy) * PI / 2
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
Const EOSTnew = 1 
Const EOSAnew = 0.8
Const EOSRampup = 0
Dim SOSRampup
SOSRampup = 2.5
'Const LiveCatch = 16
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
		if CatchTime <= LiveCatch*0.5 Then						'Perfect catch only when catch time happens in the beginning of the window
			LiveCatchBounce = 0
		else
			LiveCatchBounce = Abs((LiveCatch/2) - CatchTime)	'Partial catch when catch happens a bit late
		end If

		If LiveCatchBounce = 0 and ball.velx * Dir > 0 Then ball.velx = 0
		ball.vely = LiveCatchBounce * (16 / LiveCatch) ' Multiplier for inaccuracy bounce
		ball.angmomx= 0
		ball.angmomy= 0
		ball.angmomz= 0
		debug.print "Live catch! Time: " & CatchTime & " Bounce: " & LiveCatchBounce & " parm: " & parm
	End If

End Sub

'*****************************************************************************************************
'*******************************************************************************************************
'END nFOZZY FLIPPERS'


'*********************************
' GESTIONE MOVIMENTAZIONE GOBLIN
'*********************************

Dim GoblinPos

Sub ShakeGoblin(aValue)
	'debug.print "shakevalue:" & aValue
	GoblinPos = 8
	if aValue = True then 
		GoblinShakeTimer.Enabled = 1
	end If
End Sub

Sub GoblinShakeTimer_Timer
	Playsound "shake" 'TODO
    Goblin.TransZ = GoblinPos
	GoblinBracket.TransZ = GoblinPos
    If GoblinPos = 0 Then GoblinShakeTimer.Enabled = 0:Exit Sub
    If GoblinPos < 0 Then
        GoblinPos = ABS(GoblinPos) - 1
    Else
        GoblinPos = - GoblinPos + 1
    End If
End Sub


Sub ModeGiColor(aNr, aValue)
	if aValue = 1 or aValue = 0 Then
		ModeTimer.Enabled = 1
	end If
end Sub

Sub ModeTimer_Timer()

	dim ar,ag,ab,sum,ii:ar=0:ag=0:ab=0

	ar = Lampz.state(74) + Lampz.state(76)
	ag = Lampz.state(74) + Lampz.state(77)
	ab = Lampz.state(75) + Lampz.state(76)

	sum = ar+ag+ab
	'debug.print "red: " & ar & " green: " & ag & " blue: " & ab
	if sum > 0 and sum < 6 then
		GIColorRed=ar/sum*180+20
		GIColorGreen=ag/sum*180+20
		GIColorBlue=ab/sum*180+20
	else
		GIColorRed       =  GIColorRedOrig
		GIColorGreen     =  GIColorGreenOrig
		GIColorBlue      =  GIColorBlueOrig
	end if
	SetGIColor
	Me.Enabled=0
End Sub


'*********************************
' GESTIONE MOVIMENTAZIONE OCTOPUS
'*********************************

Dim OctopusDir, OctopusPos

Sub sw63_Hit()
	PlaysoundAtVol "bersaglio", BracketOctopus, 1
	Octopus.TransZ = 5
	BracketOctopus.TransZ = 5
	OctopusColpito.Enabled = 1
End Sub

Sub Fotocellula1Disattiva_Hit()
	FotocellulaOctopus.Visible=0
End Sub

Sub Fotocellula1Disattiva_UnHit()
	TimerFotocellula1.enabled=1
End Sub

Sub TimerFotocellula1_Timer()
	FotocellulaOctopus.Visible=1
	Me.Enabled=0
End Sub

Sub Fotocellula2Disattiva_Hit()
	FotocellulaSandmanDx.Visible=0
	FotocellulaSandmanSx.Visible=0
End Sub

Sub Fotocellula2Disattiva_UnHit()
	TimerFotocellula2.enabled=1
End Sub

Sub TimerFotocellula2_Timer()
	FotocellulaSandmanDx.Visible=1
	FotocellulaSandmanSx.Visible=1
	Me.Enabled=0
End Sub

Sub Fotocellula3Disattiva_Hit()
	FotocellulaVenom.Visible=0
End Sub

Sub Fotocellula3Disattiva_UnHit()
	TimerFotocellula3.enabled=1
End Sub

Sub TimerFotocellula3_Timer()
	FotocellulaVenom.Visible=1
	Me.Enabled=0
End Sub

Sub OctopusColpito_Timer()
	Octopus.TransZ = 0
	BracketOctopus.TransZ = 0
	Me.Enabled = 0
End Sub

Sub AlzaOctopus
	OctopusDir = -1 ' removing 1 will make Oct go up
	OctopusTimer.Enabled = 1
End Sub

Sub AbbassaOctopus
	OctopusDir = 1 ' adding 1 will make Oct to go down by one step
	OctopusTimer.Enabled = 1
End Sub


Sub OctopusTimer_Timer
	PlaysoundAtVol "Motor", BracketOctopus, 1
	Octopus.TransY = -OctopusPos
	BracketOctopus.TransY = -OctopusPos
	OctopusPos = OctopusPos + OctopusDir
	If OctopusPos < 0 Then OctopusPos=0: sw63.IsDropped=1: Me.Enabled = 0
	If OctopusPos > 50 Then OctopusPos = 50: Me.Enabled = 0
	ModeTimer.Enabled=1
End Sub


'*********************************
' GESTIONE MOVIMENTAZIONE SANDMAN
'*********************************

Dim SandmanDir, SandmanPos, SandmanAlto

Sub sw42_Hit()
	PlaysoundAtVol "bersaglio", BracketSandman, 1
	Sandman.TransZ = 5
	BracketSandman.TransZ = 5
	SandmanColpito.Enabled = 1
End Sub

Sub SandmanColpito_Timer()	'hit
	Sandman.TransZ = 0
	BracketSandman.TransZ = 0
	Me.Enabled = 0
End Sub

Sub AlzaSandman	'rise sandman
	SandmanDir = 1 ' removing 1 will make Oct go up
	SandmanTimer.Enabled = 1
	SandmanAlto=1
End Sub

Sub AbbassaSandman	'drop sandman
	SandmanDir = -1 ' adding 1 will make Oct to go down by one step
	SandmanTimer.Enabled = 1
	SandmanAlto=0
End Sub


Sub SandmanTimer_Timer
	PlaysoundAtVol "Motor", BracketSandman, 1
	Sandman.TransY = SandmanPos
	BracketSandman.TransY = SandmanPos
	SandmanPos = SandmanPos + SandmanDir
	If SandmanPos < 0 Then SandmanPos=0: Me.Enabled = 0
	If SandmanPos > 50 Then SandmanPos = 50: sw42.IsDropped=1: Me.Enabled = 0
	ModeTimer.Enabled=1
End Sub


'***********************************
' GESTIONE MOVIMENTAZIONE MURO BABK
'***********************************

Dim BankDir, BankPos

Sub AlzaBank
	BankDir = -1
	BankTimer.Enabled = 1
End Sub

Sub AbbassaBank
	BankDir = 1
	BankTimer.Enabled = 1
End Sub

Sub BankTimer_Timer
	Bank.TransY = -BankPos
	BankPos = BankPos + BankDir
	If BankPos < 0 Then BankPos = 0: Me.Enabled = 0
	If BankPos > 52 Then BankPos = 52: ParetiBankGiu: Me.Enabled = 0
	ModeTimer.Enabled=1
End Sub

Dim BankAlto

Sub PallaBloccata_Hit()
	If BankAlto=1 AND Attendi=0 Then
	Controller.Switch(50)=0
	Controller.Switch(49)=1
	AbbassaBank
	ParetiBankGiu
	SbloccaPallaBank.Enabled= True
	End If
End Sub

Sub SbloccaPallaBank_Timer()
	If Attendi=0 Then
	Controller.Switch(49)=0
	Controller.Switch(50)=1
	AlzaBank
	ParetiBankSu
	Me.Enabled=0
	End If
End Sub

Sub ParetiBankSu
	sw9.IsDropped=0
	sw10.IsDropped=0
	sw11.IsDropped=0
	sandblock.IsDropped=0
	BankAlto=1
End Sub

Sub ParetiBankGiu
	sw9.IsDropped=1
	sw10.IsDropped=1
	sw11.IsDropped=1
	sandblock.IsDropped=1
	BankAlto=0
End Sub



' *********************************************************************
'                JP's Supporting Ball & Sound Functions
' *********************************************************************

Sub ShooterEnd_UnHit():If activeball.z > 30  Then vpmTimer.AddTimer 150, "BallHitSound":End If:End Sub

Sub BallHitSound(dummy):PlaySound "ballhit":End Sub

Sub Rhelp1_Hit()
	 'AccendiVenom
	 ActiveBall.VelZ = -2
     ActiveBall.VelY = 0
     ActiveBall.VelX = 0
	 StopSound "metalrolling"
	 StopSound "metalrolling"
	 sw16Premuto=0
	 'Playsound "ballrampdrop" 'TODO
	  Playsound "WireRampHit" ' TODO
	  ModeTimer.Enabled=1
 End Sub

Sub Rhelp2_Hit()
	 ActiveBall.VelZ = -2
     ActiveBall.VelY = 0
     ActiveBall.VelX = 0
	 StopSound "metalrolling"
	 StopSound "metalrolling"
	 sw17Premuto=0
	 'Playsound "ballrampdrop" 'TODO
	  Playsound "WireRampHit" 'TODO
	  ModeTimer.Enabled=1
 End Sub


Dim sw16Premuto

Sub sw16_Hit 'Venom da rampa sinistra
	PlaysoundAtVol "WireRampHit", sw16, 1
	PlaysoundAtVol "metalrolling", sw16, 1
	StopSound "plasticrolling"
	sw16Premuto= 1
End Sub

Dim sw17Premuto

Sub sw17_Hit
	PlaysoundAtVol "WireRampHit", sw17, 1
	PlaysoundAtVol "metalrolling", sw17, 1
	StopSound "plasticrolling"
	sw17Premuto=1
End Sub

Sub DocVUKexit_Hit
	If sw17Premuto= 0 Then Playsound "WireRampHit": Playsound "metalrolling" ' TODO
End Sub

Sub VenomOK_Hit
	If sw16Premuto= 0 Then Playsound "WireRampHit": Playsound "metalrolling": StopSound "plasticrolling" ' TODO
End Sub


Sub sw100_Hit()
	PlaysoundAtVol "muro", GateP0, 1
End Sub

Sub sw101_Hit()
	PlaysoundAtVol "muro", BracketOctopus, 1
End Sub

Sub sw102_Hit()
	PlaysoundAtVol "muro", Bank, 1
End Sub

Sub sw103_Hit()
	PlaysoundAtVol "muro", Bank, 1
End Sub

Sub sw104_Hit()
	PlaysoundAtVol "muro", RampLeft, 1
End Sub


Sub LeftFlipper_Collide(parm)
	FlipperLeftHitParm = parm/10
	If FlipperLeftHitParm > 1 Then
		FlipperLeftHitParm = 1
	End If
	FlipperLeftHitParm = FlipperUpSoundLevel * FlipperLeftHitParm
	CheckLiveCatch Activeball, LeftFlipper, LFCount, parm
	CheckFlipperSlack Activeball, LeftFlipper, LFLogo, parm
	RandomSoundRubberFlipper(parm)
End Sub

Sub RightFlipper_Collide(parm)
	FlipperRightHitParm = parm/10
	If FlipperRightHitParm > 1 Then
		FlipperRightHitParm = 1
	End If
	FlipperRightHitParm = FlipperUpSoundLevel * FlipperRightHitParm
	CheckLiveCatch Activeball, RightFlipper, RFCount, parm
	CheckFlipperSlack Activeball, RightFlipper, RFLogo, parm
 	RandomSoundRubberFlipper(parm)
End Sub

Sub RightFlipper2_Collide(parm)
 	RandomSoundRubberFlipper(parm)
End Sub


'////////////////////////////  MECHANICAL SOUNDS  ///////////////////////////
'//  This part in the script is an entire block that is dedicated to the physics sound system.
'//  Various scripts and sounds that may be pretty generic and could suit other WPC systems, but the most are tailored specifically for this table.

'///////////////////////////////  SOUNDS PARAMETERS  //////////////////////////////
Dim GlobalSoundLevel, CoinSoundLevel, PlungerReleaseSoundLevel, PlungerPullSoundLevel, NudgeLeftSoundLevel
Dim NudgeRightSoundLevel, NudgeCenterSoundLevel, StartButtonSoundLevel, RollingSoundFactor

CoinSoundLevel = 1														'volume level; range [0, 1]
NudgeLeftSoundLevel = 1													'volume level; range [0, 1]
NudgeRightSoundLevel = 1												'volume level; range [0, 1]
NudgeCenterSoundLevel = 1												'volume level; range [0, 1]
StartButtonSoundLevel = 0.1												'volume level; range [0, 1]
PlungerReleaseSoundLevel = 0.8 '1 wjr											'volume level; range [0, 1]
PlungerPullSoundLevel = 1												'volume level; range [0, 1]
RollingSoundFactor = 1.1/5		

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
DelayedBallDropOnPlayfieldSoundLevel = 0.8									'volume level; range [0, 1]
WallImpactSoundFactor = 0.075											'volume multiplier; must not be zero
MetalImpactSoundFactor = 0.075/3
SaucerLockSoundLevel = 0.8
SaucerKickSoundLevel = 0.8

'///////////////////////-----Gates, Spinners, Rollovers and Targets-----///////////////////////

Dim GateSoundLevel, TargetSoundFactor, SpinnerSoundLevel, RolloverSoundLevel, DTSoundLevel

GateSoundLevel = 0.5/5													'volume level; range [0, 1]
TargetSoundFactor = 0.0025 * 10											'volume multiplier; must not be zero
DTSoundLevel = 0.25														'volume multiplier; must not be zero
RolloverSoundLevel = 0.25                              					'volume level; range [0, 1]
SpinnerSoundLevel= 0.50 


'///////////////////////-----Ball Release, Guides and Drain-----///////////////////////
Dim DrainSoundLevel, BallReleaseSoundLevel, BottomArchBallGuideSoundFactor, FlipperBallGuideSoundFactor 

DrainSoundLevel = 0.8														'volume level; range [0, 1]
BallReleaseSoundLevel = 1												'volume level; range [0, 1]
BottomArchBallGuideSoundFactor = 0.2									'volume multiplier; must not be zero
FlipperBallGuideSoundFactor = 0.015										'volume multiplier; must not be zero

'///////////////////////-----Loops and Lanes-----///////////////////////
Dim ArchSoundFactor
ArchSoundFactor = 0.025/5													'volume multiplier; must not be zero


'/////////////////////////////  SOUND PLAYBACK FUNCTIONS  ////////////////////////////
'/////////////////////////////  POSITIONAL SOUND PLAYBACK METHODS  ////////////////////////////
' Positional sound playback methods will play a sound, depending on the X,Y position of the table element or depending on ActiveBall object position
' These are similar subroutines that are less complicated to use (e.g. simply use standard parameters for the PlaySound call)
' For surround setup - positional sound playback functions will fade between front and rear surround channels and pan between left and right channels
' For stereo setup - positional sound playback functions will only pan between left and right channels
' For mono setup - positional sound playback functions will not pan between left and right channels and will not fade between front and rear channels

' PlaySound full syntax - PlaySound(string, int loopcount, float volume, float pan, float randompitch, int pitch, bool useexisting, bool restart, float front_rear_fade)
' Note - These functions will not work (currently) for walls/slingshots as these do not feature a simple, single X,Y position
Sub PlaySoundAtLevelStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelExistingStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 1, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticLoop(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticRandomPitch(playsoundparams, aVol, randomPitch, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLevelExistingActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 1, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLeveTimerActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 0, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelTimerExistingActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 1, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelRoll(playsoundparams, aVol, pitch)
    PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

' Previous Positional Sound Subs

Sub PlaySoundAt(soundname, tableobj)
    PlaySound soundname, 1, 1 * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtVol(soundname, tableobj, aVol)
    PlaySound soundname, 1, aVol * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtBall(soundname)
    PlaySoundAt soundname, ActiveBall
End Sub

Sub PlaySoundAtBallVol (Soundname, aVol)
	Playsound soundname, 1,aVol * VolumeDial, AudioPan(ActiveBall), 0,0,0, 1, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtBallVolM (Soundname, aVol)
	Playsound soundname, 1,aVol * VolumeDial, AudioPan(ActiveBall), 0,0,0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtVolLoops(sound, tableobj, Vol, Loops)
	PlaySound sound, Loops, Vol * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub


' *********************************************************************
'                     Fleep  Supporting Ball & Sound Functions
' *********************************************************************

Dim tablewidth, tableheight : tablewidth = Table1.width : tableheight = Table1.height

Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "table1" is the name of the table
	Dim tmp
    tmp = tableobj.y * 2 / tableheight-1
    If tmp > 0 Then
		AudioFade = Csng(tmp ^10)
    Else
        AudioFade = Csng(-((- tmp) ^10) )
    End If
End Function

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
    Dim tmp
    tmp = tableobj.x * 2 / tablewidth-1
    If tmp > 0 Then
        AudioPan = Csng(tmp ^10)
    Else
        AudioPan = Csng(-((- tmp) ^10) )
    End If
End Function

Function Vol(ball) ' Calculates the volume of the sound based on the ball speed
	Vol = Csng(BallVel(ball) ^2)
End Function

Function Volz(ball) ' Calculates the volume of the sound based on the ball speed
	Volz = Csng((ball.velz) ^2)
End Function

Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
    Pitch = BallVel(ball) * 20
End Function

Function BallVel(ball) 'Calculates the ball speed
    BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2) ) )
End Function

Function VolPlayfieldRoll(ball) ' Calculates the roll volume of the sound based on the ball speed
	VolPlayfieldRoll = RollingSoundFactor * 0.0005 * Csng(BallVel(ball) ^3)
End Function

Function PitchPlayfieldRoll(ball) ' Calculates the roll pitch of the sound based on the ball speed
    PitchPlayfieldRoll = BallVel(ball) ^2 * 15
End Function

Function RndInt(min, max)
    RndInt = Int(Rnd() * (max-min + 1) + min)' Sets a random number integer between min and max
End Function

Function RndNum(min, max)
    RndNum = Rnd() * (max-min) + min' Sets a random number between min and max
End Function

'/////////////////////////////  GENERAL SOUND SUBROUTINES  ////////////////////////////
Sub SoundStartButton()
	PlaySound ("Start_Button"), 0, StartButtonSoundLevel, 0, 0.25
End Sub

Sub SoundNudgeLeft()
	PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeLeftSoundLevel * VolumeDial, -0.1, 0.25
End Sub

Sub SoundNudgeRight()
	PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeRightSoundLevel * VolumeDial, 0.1, 0.25
End Sub

Sub SoundNudgeCenter()
	PlaySound ("Nudge_" & Int(Rnd*2)+1), 0, NudgeCenterSoundLevel * VolumeDial, 0, 0.25
End Sub


Sub SoundPlungerPull()
	PlaySoundAtLevelStatic ("plungerpull"), PlungerPullSoundLevel, Plunger
End Sub

Sub SoundPlungerReleaseBall()
	PlaySoundAtLevelStatic ("Plunger_Release_Ball"), PlungerReleaseSoundLevel, Plunger	
End Sub

Sub SoundPlungerReleaseNoBall()
	PlaySoundAtLevelStatic ("Plunger_Release_No_Ball"), PlungerReleaseSoundLevel, Plunger
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

'/////////////////////////////  FLIPPER BATS BALL COLLIDE SOUND  ////////////////////////////


Sub RandomSoundRubberFlipper(parm)
	PlaySoundAtLevelActiveBall ("Flipper_Rubber_" & Int(Rnd*7)+1), parm  * RubberFlipperSoundFactor
End Sub



'/////////////////////////////  RUBBERS AND POSTS - STRONG IMPACTS  ////////////////////////////
Sub RandomSoundRubberStrong(voladj)
	Select Case Int(Rnd*10)+1
		Case 1 : PlaySoundAtLevelActiveBall ("Rubber_Strong_1"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 2 : PlaySoundAtLevelActiveBall ("Rubber_Strong_2"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 3 : PlaySoundAtLevelActiveBall ("Rubber_Strong_3"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 4 : PlaySoundAtLevelActiveBall ("Rubber_Strong_4"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 5 : PlaySoundAtLevelActiveBall ("Rubber_Strong_5"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 6 : PlaySoundAtLevelActiveBall ("Rubber_Strong_6"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 7 : PlaySoundAtLevelActiveBall ("Rubber_Strong_7"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 8 : PlaySoundAtLevelActiveBall ("Rubber_Strong_8"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 9 : PlaySoundAtLevelActiveBall ("Rubber_Strong_9"), Vol(ActiveBall) * RubberStrongSoundFactor*voladj
		Case 10 : PlaySoundAtLevelActiveBall ("Rubber_1_Hard"), Vol(ActiveBall) * RubberStrongSoundFactor * 0.6*voladj
	End Select
End Sub

'/////////////////////////////  RUBBERS AND POSTS - WEAK IMPACTS  ////////////////////////////
Sub RandomSoundRubberWeak()
	PlaySoundAtLevelActiveBall ("Rubber_" & Int(Rnd*9)+1), Vol(ActiveBall) * RubberWeakSoundFactor
End Sub

'/////////////////////////////  WALL IMPACTS  ////////////////////////////
Sub Walls_Hit(idx)
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 5 then
 		RandomSoundRubberStrong 1 
	End if
	If finalspeed <= 5 then
 		RandomSoundRubberWeak()
 	End If	
End Sub

Sub RandomSoundWall()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 16 then 
		Select Case Int(Rnd*5)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_1"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_2"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_5"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 4 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_7"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 5 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_9"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
		Select Case Int(Rnd*4)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_3"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 4 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
 	End If
	If finalspeed < 6 Then
		Select Case Int(Rnd*3)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
	End if
End Sub

'/////////////////////////////  METAL TOUCH SOUNDS  ////////////////////////////
Sub RandomSoundMetal()
	PlaySoundAtLevelActiveBall ("Metal_Touch_" & Int(Rnd*13)+1), Vol(ActiveBall) * MetalImpactSoundFactor
End Sub

'/////////////////////////////  METAL - EVENTS  ////////////////////////////

Sub Metals_Hit (idx)
	RandomSoundMetal
End Sub

Sub ShooterDiverter_collide(idx)
	RandomSoundMetal
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE  ////////////////////////////
'/////////////////////////////  BOTTOM ARCH BALL GUIDE - SOFT BOUNCES  ////////////////////////////
Sub RandomSoundBottomArchBallGuide()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 16 then 
		PlaySoundAtLevelActiveBall ("Apron_Bounce_"& Int(Rnd*2)+1), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
 		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("Apron_Bounce_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
		End Select
 	End If
	If finalspeed < 6 Then
 		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("Apron_Medium_3"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
		End Select
	End if
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE - HARD HITS  ////////////////////////////
Sub RandomSoundBottomArchBallGuideHardHit()
	PlaySoundAtLevelActiveBall ("Apron_Hard_Hit_" & Int(Rnd*3)+1), BottomArchBallGuideSoundFactor * 0.25
End Sub

Sub Apron_Hit (idx)
	If Abs(cor.ballvelx(activeball.id) < 4) and cor.ballvely(activeball.id) > 7 then
		RandomSoundBottomArchBallGuideHardHit()
	Else
		RandomSoundBottomArchBallGuide
	End If
End Sub

'/////////////////////////////  FLIPPER BALL GUIDE  ////////////////////////////
Sub RandomSoundFlipperBallGuide()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 16 then 
 		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("Apron_Hard_1"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("Apron_Hard_2"),  Vol(ActiveBall) * 0.8 * FlipperBallGuideSoundFactor
		End Select
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
		PlaySoundAtLevelActiveBall ("Apron_Medium_" & Int(Rnd*3)+1),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
 	End If
	If finalspeed < 6 Then
		PlaySoundAtLevelActiveBall ("Apron_Soft_" & Int(Rnd*7)+1),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
	End If
End Sub

'/////////////////////////////  ROLLOVER SOUNDS  ////////////////////////////
Sub RandomSoundRollover()
	PlaySoundAtLevelActiveBall ("Rollover_" & Int(Rnd*4)+1), RolloverSoundLevel
End Sub

Sub Rollovers_Hit(idx)
	RandomSoundRollover
End Sub

'/////////////////////////////  TARGET HIT SOUNDS  ////////////////////////////
Sub RandomSoundTargetHitStrong()
	PlaySoundAtLevelActiveBall SoundFX("Target_Hit_" & Int(Rnd*4)+5,DOFTargets), Vol(ActiveBall) * 0.45 * TargetSoundFactor
End Sub

Sub RandomSoundTargetHitWeak()		
	PlaySoundAtLevelActiveBall SoundFX("Target_Hit_" & Int(Rnd*4)+1,DOFTargets), Vol(ActiveBall) * TargetSoundFactor
End Sub

Sub PlayTargetSound()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
 		RandomSoundTargetHitStrong()
		RandomSoundBallBouncePlayfieldSoft Activeball
	Else 
 		RandomSoundTargetHitWeak()
 	End If	
End Sub

Sub Targets_Hit (idx)
	PlayTargetSound	
End Sub

'/////////////////////////////  BALL BOUNCE SOUNDS  ////////////////////////////
Sub RandomSoundBallBouncePlayfieldSoft(aBall)
	Select Case Int(Rnd*9)+1
		Case 1 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_1"), volz(aBall) * BallBouncePlayfieldSoftFactor, aBall
		Case 2 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_2"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.5, aBall
		Case 3 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_3"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.8, aBall
		Case 4 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_4"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.5, aBall
		Case 5 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Soft_5"), volz(aBall) * BallBouncePlayfieldSoftFactor, aBall
		Case 6 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_1"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
		Case 7 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_2"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
		Case 8 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_5"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.2, aBall
		Case 9 : PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_7"), volz(aBall) * BallBouncePlayfieldSoftFactor * 0.3, aBall
	End Select
End Sub

Sub RandomSoundBallBouncePlayfieldHard(aBall)
	PlaySoundAtLevelStatic ("Ball_Bounce_Playfield_Hard_" & Int(Rnd*7)+1), volz(aBall) * BallBouncePlayfieldHardFactor, aBall
End Sub

'/////////////////////////////  DELAYED DROP - TO PLAYFIELD - SOUND  ////////////////////////////
Sub RandomSoundDelayedBallDropOnPlayfield(aBall)
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_1_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 2 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_2_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 3 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_3_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 4 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_4_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
		Case 5 : PlaySoundAtLevelStatic ("Ball_Drop_Playfield_5_Delayed"), DelayedBallDropOnPlayfieldSoundLevel, aBall
	End Select
End Sub

'/////////////////////////////  BUMPER SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundBumperTop(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Top_" & Int(Rnd*5)+1,DOFContactors), 0.22 * BumperSoundFactor, Bump
End Sub

Sub RandomSoundBumperMiddle(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Middle_" & Int(Rnd*5)+1,DOFContactors), 0.22 * BumperSoundFactor, Bump
End Sub

Sub RandomSoundBumperBottom(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Bottom_" & Int(Rnd*5)+1,DOFContactors), 0.22 * BumperSoundFactor, Bump
End Sub

'/////////////////////////////  BALL GATES AND BRACKET GATES SOUNDS  ////////////////////////////

Sub SoundPlayfieldGate()			
	PlaySoundAtLevelStatic ("Gate_FastTrigger_" & Int(Rnd*2)+1), GateSoundLevel, Activeball
End Sub

Sub SoundHeavyGate()
	PlaySoundAtLevelStatic ("Gate_2"), GateSoundLevel, Activeball
End Sub

Sub Gates_hit(idx)
	SoundHeavyGate
End Sub

Sub GatesWire_hit(idx)	
	SoundPlayfieldGate	
End Sub	

'/////////////////////////////  SLINGSHOT SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundSlingshotLeft(sling)
	PlaySoundAtLevelStatic SoundFX("Sling_L" & Int(Rnd*10)+1,DOFContactors), SlingshotSoundLevel, Sling
End Sub

Sub RandomSoundSlingshotRight(sling)
	PlaySoundAtLevelStatic SoundFX("Sling_R" & Int(Rnd*8)+1,DOFContactors), SlingshotSoundLevel, Sling
End Sub

'******************************************************
'		BALL ROLLING AND DROP SOUNDS
'******************************************************

Const tnob = 4 ' total number of balls
ReDim rolling(tnob)
InitRolling

Dim DropCount
ReDim DropCount(tnob)

Sub InitRolling
	Dim i
	For i = 0 to tnob
		rolling(i) = False
	Next
End Sub

Sub RollingSound()
	Dim BOT, b
	BOT = GetBalls

	' stop the sound of deleted balls
	For b = UBound(BOT) + 1 to tnob
		rolling(b) = False
		StopSound("BallRoll_" & b)
	Next

	' exit the sub if no balls on the table
	If UBound(BOT) = -1 Then Exit Sub

	' play the rolling sound for each ball

	For b = 0 to UBound(BOT)
		If BallVel(BOT(b)) > 1 AND BOT(b).z < 30 Then
			rolling(b) = True
			PlaySound ("BallRoll_" & b), -1, VolPlayfieldRoll(BOT(b)) * 1.1 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))

		Else
			If rolling(b) = True Then
				StopSound("BallRoll_" & b)
				rolling(b) = False
			End If
		End If

		'***Ball Drop Sounds***
		If BOT(b).VelZ < -1 and BOT(b).z < 55 and BOT(b).z > 27 Then 'height adjust for ball drop sounds
			If DropCount(b) >= 5 Then
				DropCount(b) = 0
				If BOT(b).velz > -7 Then
					RandomSoundBallBouncePlayfieldSoft BOT(b)
				Else
					RandomSoundBallBouncePlayfieldHard BOT(b)
				End If				
			End If
		End If
		If DropCount(b) < 5 Then
			DropCount(b) = DropCount(b) + 1
		End If
	Next
End Sub




'**********************
' Ball Collision Sound
'**********************

Sub OnBallBallCollision(ball1, ball2, velocity)
' 	PlaySound("fx_collide"), 0, Csng(velocity) ^2 / (VolDiv/VolCol), Pan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)   
 	PlaySound("fx_collide"), 0, Csng(velocity) ^2 / BallWithBallCollisionSoundFactor, AudioPan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
End Sub


'******************************************************
'			RUBBER CORRECTION
'******************************************************


'****************************************************************************
'nFozzy PHYSICS DAMPENERS

'These are data mined bounce curves, 
'dialed in with the in-game elasticity as much as possible to prevent angle / spin issues.
'Requires tracking ballspeed to calculate COR

Sub dPosts_Hit(idx) 
	RubbersD.dampen Activeball
End Sub

Sub dSleeves_Hit(idx) 
	SleevesD.Dampen Activeball
End Sub

dim RubbersD : Set RubbersD = new Dampener	'frubber
RubbersD.name = "Rubbers"
RubbersD.debugOn = False	'shows info in textbox "TBPout"
RubbersD.Print = False	'debug, reports in debugger (in vel, out cor)
'cor bounce curve (linear)
'for best results, try to match in-game velocity as closely as possible to the desired curve
'RubbersD.addpoint 0, 0, 0.935	'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 0, 0, 0.935 '0.96	'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 1, 3.77, 0.935 '0.96
RubbersD.addpoint 2, 5.76, 0.942 '0.967	'dont take this as gospel. if you can data mine rubber elasticitiy, please help!
RubbersD.addpoint 3, 15.84, 0.874
RubbersD.addpoint 4, 56, 0.64	'there's clamping so interpolate up to 56 at least

dim SleevesD : Set SleevesD = new Dampener	'this is just rubber but cut down to 85%...
SleevesD.name = "Sleeves"
SleevesD.debugOn = False	'shows info in textbox "TBPout"
SleevesD.Print = False	'debug, reports in debugger (in vel, out cor)
SleevesD.CopyCoef RubbersD, 0.85

Class Dampener
	Public Print, debugOn 'tbpOut.text
	public name, Threshold 	'Minimum threshold. Useful for Flippers, which don't have a hit threshold.
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
		RealCOR = BallSpeed(aBall) / cor.ballvel(aBall.id)
		coef = desiredcor / realcor 
		if debugOn then str = name & " in vel:" & round(cor.ballvel(aBall.id),2 ) & vbnewline & "desired cor: " & round(desiredcor,4) & vbnewline & _
		"actual cor: " & round(realCOR,4) & vbnewline & "ballspeed coef: " & round(coef, 3) & vbnewline 
		if Print then debug.print Round(cor.ballvel(aBall.id),2) & ", " & round(desiredcor,3)
		
		aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		'playsound "fx_knocker"
		if debugOn then TBPout.text = str
	End Sub

	Public Sub CopyCoef(aObj, aCoef) 'alternative addpoints, copy with coef
		dim x : for x = 0 to uBound(aObj.ModIn)
			addpoint x, aObj.ModIn(x), aObj.ModOut(x)*aCoef
		Next
	End Sub


	Public Sub Report() 	'debug, reports all coords in tbPL.text
		if not debugOn then exit sub
		dim a1, a2 : a1 = ModIn : a2 = ModOut
		dim str, x : for x = 0 to uBound(a1) : str = str & x & ": " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		TBPout.text = str
	End Sub
	

End Class

'******************************************************
'		TRACK ALL BALL VELOCITIES
' 		FOR RUBBER DAMPENER AND DROP TARGETS
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

Sub RDampen()
	Cor.Update
End Sub

Function LinearEnvelope(xInput, xKeyFrame, yLvl)
	dim y 'Y output
	dim L 'Line
	dim ii : for ii = 1 to uBound(xKeyFrame)	'find active line
		if xInput <= xKeyFrame(ii) then L = ii : exit for : end if
	Next
	if xInput > xKeyFrame(uBound(xKeyFrame) ) then L = uBound(xKeyFrame)	'catch line overrun
	Y = pSlope(xInput, xKeyFrame(L-1), yLvl(L-1), xKeyFrame(L), yLvl(L) )

	'Clamp if on the boundry lines
	'if L=1 and Y < yLvl(LBound(yLvl) ) then Y = yLvl(lBound(yLvl) )
	'if L=uBound(xKeyFrame) and Y > yLvl(uBound(yLvl) ) then Y = yLvl(uBound(yLvl) )
	'clamp 2.0
	if xInput <= xKeyFrame(lBound(xKeyFrame) ) then Y = yLvl(lBound(xKeyFrame) ) 	'Clamp lower
	if xInput >= xKeyFrame(uBound(xKeyFrame) ) then Y = yLvl(uBound(xKeyFrame) )	'Clamp upper

	LinearEnvelope = Y
End Function

'*******************************************************
'	End nFozzy Dampening'
'******************************************************

' #####################################
' ###### Flupper Flasher Domes    #####
' #####################################

Dim TestFlashers, TableRef, FlasherLightIntensity, FlasherFlareIntensity, FlasherBloomIntensity, FlasherOffBrightness

								' *********************************************************************
TestFlashers = 0				' *** set this to 1 to check position of flasher object 			***
Set TableRef = Table1   		' *** change this, if your table has another name       			***
FlasherLightIntensity = 0.1		' *** lower this, if the VPX lights are too bright (i.e. 0.1)		***
FlasherFlareIntensity = 0.5		' *** lower this, if the flares are too bright (i.e. 0.1)			***
FlasherBloomIntensity = 0.5
FlasherOffBrightness = 0.5		' *** brightness of the flasher dome when switched off (range 0-2)	***
								' *********************************************************************

Dim ObjLevel(20), objbase(20), objlit(20), objflasher(20), objbloom(20), objlight(20)
'Dim tablewidth, tableheight : tablewidth = TableRef.width : tableheight = TableRef.height
''initialise the flasher color, you can only choose from "green", "red", "purple", "blue", "white" and "yellow"
InitFlasher 1, "blue" : InitFlasher 2, "red" : InitFlasher 3, "yellow" : InitFlasher 4, "green" ': InitFlasher 5, "blue"
''' rotate the flasher with the command below (first argument = flasher nr, second argument = angle in degrees)
rotateflasher 1,90
rotateflasher 2,90
rotateflasher 3,12
rotateflasher 4,-45
'
'Flasherflash4.height = 255
'Flasherflash3.height = 235
'Flasherflash2.height = 276
'Flasherflash1.height = 276


Sub InitFlasher(nr, col)
	' store all objects in an array for use in FlashFlasher subroutine
	Set objbase(nr) = Eval("Flasherbase" & nr) : Set objlit(nr) = Eval("Flasherlit" & nr)
	Set objflasher(nr) = Eval("Flasherflash" & nr) : Set objlight(nr) = Eval("Flasherlight" & nr)
	Set objbloom(nr) = Eval("Flasherbloom" & nr)
	' If the flasher is parallel to the playfield, rotate the VPX flasher object for POV and place it at the correct height
	If objbase(nr).RotY = 0 Then
		objbase(nr).ObjRotZ =  atn( (tablewidth/2 - objbase(nr).x) / (objbase(nr).y - tableheight*1.1)) * 180 / 3.14159
		objflasher(nr).RotZ = objbase(nr).ObjRotZ : objflasher(nr).height = objbase(nr).z + 40
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
		Case "blue" :   objlight(nr).color = RGB(4,120,255) : objflasher(nr).color = RGB(20,155,255) ': objlight(nr).intensity = 5000
		Case "green" :  objlight(nr).color = RGB(12,255,4) : objflasher(nr).color = RGB(12,255,4)
		Case "red" :    objlight(nr).color = RGB(255,32,4) : objflasher(nr).color = RGB(255,32,4)
		Case "purple" : objlight(nr).color = RGB(230,49,255) : objflasher(nr).color = RGB(255,64,255) 
		Case "yellow" : objlight(nr).color = RGB(200,173,25) : objflasher(nr).color = RGB(255,200,50)
		Case "white" :  objlight(nr).color = RGB(255,240,150) : objflasher(nr).color = RGB(100,86,59)
	end select
	objlight(nr).colorfull = objlight(nr).color
	If TableRef.ShowDT and ObjFlasher(nr).RotX = -45 Then 
		objflasher(nr).height = objflasher(nr).height - 20 * ObjFlasher(nr).y / tableheight
		ObjFlasher(nr).y = ObjFlasher(nr).y + 10
	End If
	'FlasherFlash4.height = 226
	'FlasherFlash3.height = 200
End Sub

Sub RotateFlasher(nr, angle) : angle = ((angle + 360 - objbase(nr).ObjRotZ) mod 180)/30 : objbase(nr).showframe(angle) : objlit(nr).showframe(angle) : End Sub

Sub FlashFlasher(nr)
	If not objflasher(nr).TimerEnabled Then objflasher(nr).TimerEnabled = True : objflasher(nr).visible = 1 : objbloom(nr).visible = 1 : objlit(nr).visible = 1 : End If
	objflasher(nr).opacity = 1000 *  FlasherFlareIntensity * ObjLevel(nr)^2.5
	objbloom(nr).opacity = 100 *  FlasherBloomIntensity * ObjLevel(nr)^2.5
	objlight(nr).IntensityScale = 0.5 * FlasherLightIntensity * ObjLevel(nr)^3
	objbase(nr).BlendDisableLighting =  FlasherOffBrightness + 10 * ObjLevel(nr)^3	
	objlit(nr).BlendDisableLighting = 10 * ObjLevel(nr)^2
	UpdateMaterial "Flashermaterial" & nr,0,0,0,0,0,0,ObjLevel(nr),RGB(255,255,255),0,0,False,True,0,0,0,0 
	ObjLevel(nr) = ObjLevel(nr) * 0.9 - 0.01
	If ObjLevel(nr) < 0 Then objflasher(nr).TimerEnabled = False : objflasher(nr).visible = 0 : objbloom(nr).visible = 0 : objlit(nr).visible = 0 : End If
End Sub

Sub FlasherFlash1_Timer() : FlashFlasher(1) : End Sub 
Sub FlasherFlash2_Timer() : FlashFlasher(2) : End Sub 
Sub FlasherFlash3_Timer() : FlashFlasher(3) : End Sub 
Sub FlasherFlash4_Timer() : FlashFlasher(4) : End Sub


' ###############################################
' ###### Spidey flasher dome settings #####
' ###############################################

Sub FlashSol29(flstate) ' blue
	If Flstate Then
		Objlevel(1) = 1 : FlasherFlash1_Timer
	End If
End Sub

Sub FlashSol30(flstate) ' top red
	If Flstate Then
		Objlevel(2) = 1 : FlasherFlash2_Timer
	End If
End Sub

Sub FlashSol27(flstate) ' top red
	If Flstate Then
		Objlevel(3) = 1 : FlasherFlash3_Timer
	End If
End Sub

Sub FlashSol21(flstate) ' top red
	If Flstate Then
		Objlevel(4) = 1 : FlasherFlash4_Timer
	End If
End Sub

'***************************************
'***Begin nFozzy lamp handling***
'***************************************

Dim NullFader : set NullFader = new NullFadingObject
Dim Lampz : Set Lampz = New LampFader
Dim ModLampz : Set ModLampz = New DynamicLamps
InitLampsNF              ' Setup lamp assignments


Sub LampTimer()
	dim x, chglamp
	chglamp = Controller.ChangedLamps
	If Not IsEmpty(chglamp) Then
		For x = 0 To UBound(chglamp) 			'nmbr = chglamp(x, 0), state = chglamp(x, 1)
			'DebugOut("ChangedLamps: Idx: "+Cstr(chglamp(x,0))+". State: "+Cstr(chglamp(x,1)))
			Lampz.state(chglamp(x, 0)) = chglamp(x, 1)		
		next
	End If
	Lampz.Update1
'	ModLampz.Update1
	Lampz.Update2
	ModLampz.Update2
'	If F19.IntensityScale > 0 then
'		fmfl27.visible = False
'		l27.visible = False
'	Else
'		fmfl27.visible = True
'		l27.visible = True
'	end if
End Sub


dim FrameTime, InitFrameTime : InitFrameTime = 0
Wall9.TimerInterval = -1
Wall9.TimerEnabled = True
Sub Wall9_Timer()	'Stealing this random wall's timer for -1 updates
	FrameTime = gametime - InitFrameTime : InitFrameTime = gametime	'Count frametime. Unused atm?
	'DebugOut(Cstr(FrameTime))
	Lampz.Update 'updates on frametime (Object updates only)
	ModLampz.Update
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


Sub InitLampsNF()

	'Filtering (comment out to disable)
	Lampz.Filter = "LampFilter"	'Puts all lamp intensity scale output (no callbacks) through this function before updating
	ModLampz.Filter = "LampFilter"
	'Adjust fading speeds (1 / full MS fading time)
	dim x : for x = 0 to 140 : Lampz.FadeSpeedUp(x) = 1/80 : Lampz.FadeSpeedDown(x) = 1/100 : next
	Lampz.FadeSpeedUp(110) = 1/64 'GI

'*********************************************************************************************************************************************************
'End nfozzy lamp handling
'*********************************************************************************************************************************************************
	Lampz.MassAssign(3) = l3
	Lampz.Callback(3) = "DisableLighting p3on, 75,"


	Lampz.MassAssign(4) = l4
	Lampz.Callback(4) = "DisableLighting p4on, 275,"


	Lampz.MassAssign(5) = l5
	Lampz.Callback(5) = "DisableLighting p5on, 275,"


	Lampz.MassAssign(6) = l6
	Lampz.Callback(6) = "DisableLighting p6on, 275,"


	Lampz.MassAssign(7) = l7
	Lampz.Callback(7) = "DisableLighting p7on, 275,"


	Lampz.MassAssign(8) = l8
	Lampz.Callback(8) = "DisableLighting p8on, 275,"


	Lampz.MassAssign(9) = l9
	Lampz.Callback(9) = "DisableLighting p9on, 275,"


	Lampz.MassAssign(10) = l10
	Lampz.Callback(10) = "DisableLighting p10on, 275,"


	Lampz.MassAssign(11) = l11
	Lampz.Callback(11) = "DisableLighting p11on, 275,"


	Lampz.MassAssign(12) = l12
	Lampz.Callback(12) = "DisableLighting p12on, 975,"


	Lampz.MassAssign(13) = l13
	Lampz.Callback(13) = "DisableLighting p13on, 275,"


	Lampz.MassAssign(14) = l14
	Lampz.Callback(14) = "DisableLighting p14on, 975,"


	Lampz.MassAssign(15) = l15
	Lampz.Callback(15) = "DisableLighting p15on, 75,"


	Lampz.MassAssign(16) = l16
	Lampz.Callback(16) = "DisableLighting p16on, 75,"


	Lampz.MassAssign(17) = l17
	Lampz.Callback(17) = "DisableLighting p17on, 75,"
	Lampz.MassAssign(17) = l17r

	Lampz.MassAssign(18) = l18
	Lampz.Callback(18) = "DisableLighting p18on, 75,"
	Lampz.MassAssign(18) = l18r

	Lampz.MassAssign(19) = l19
	Lampz.Callback(19) = "DisableLighting p19on, 75,"
	Lampz.MassAssign(19) = l19r

	Lampz.MassAssign(20) = l20
	Lampz.Callback(20) = "DisableLighting p20on, 75,"
	Lampz.MassAssign(20) = l20r

	Lampz.MassAssign(21) = l21
	Lampz.Callback(21) = "DisableLighting p21on, 75,"
	Lampz.MassAssign(21) = l21r

	Lampz.MassAssign(22) = l22
	Lampz.Callback(22) = "DisableLighting p22on, 75,"


	Lampz.MassAssign(23) = l23
	Lampz.Callback(23) = "DisableLighting p23on, 75,"

	Lampz.MassAssign(24) = l24
	Lampz.Callback(24) = "DisableLighting p24on, 75,"


	Lampz.MassAssign(25) = l25
	Lampz.Callback(25) = "DisableLighting p25on, 75,"


	Lampz.MassAssign(26) = l26
	Lampz.Callback(26) = "DisableLighting p26on, 75,"


	Lampz.MassAssign(27) = l27
	Lampz.Callback(27) = "DisableLighting p27on, 75,"


	Lampz.MassAssign(28) = l28
	Lampz.Callback(28) = "DisableLighting p28on, 75,"
	Lampz.MassAssign(28) = l28r

	Lampz.MassAssign(29) = l29
	Lampz.Callback(29) = "DisableLighting p29on, 75,"


	Lampz.MassAssign(30) = l30
	Lampz.Callback(30) = "DisableLighting p30on, 75,"


	Lampz.MassAssign(31) = l31
	Lampz.Callback(31) = "DisableLighting p31on, 75,"


	Lampz.MassAssign(32) = l32
	Lampz.Callback(32) = "DisableLighting p32on, 75,"


	Lampz.MassAssign(33) = l33
	Lampz.Callback(33) = "DisableLighting p33on, 75,"


	Lampz.MassAssign(34) = l34
	Lampz.Callback(34) = "DisableLighting p34on, 75,"


	Lampz.MassAssign(35) = l35
	Lampz.Callback(35) = "DisableLighting p35on, 75,"

	Lampz.MassAssign(36) = l36
	Lampz.Callback(36) = "DisableLighting p36on, 75,"

	Lampz.MassAssign(37) = l37
	Lampz.Callback(37) = "DisableLighting p37on, 75,"


	Lampz.MassAssign(38) = l38
	Lampz.Callback(38) = "DisableLighting p38on, 75,"


	Lampz.MassAssign(39) = l39
	Lampz.Callback(39) = "DisableLighting p39on, 75,"


	Lampz.MassAssign(40) = l40
	Lampz.Callback(40) = "DisableLighting p40on, 75,"


	Lampz.MassAssign(41) = l41
	Lampz.Callback(41) = "DisableLighting p41on, 75,"
	Lampz.MassAssign(41) = l41r

	Lampz.MassAssign(42) = l42
	Lampz.Callback(42) = "DisableLighting p42on, 75,"


	Lampz.MassAssign(43) = l43
	Lampz.Callback(43) = "DisableLighting p43on, 75,"


	Lampz.MassAssign(44) = l44
	Lampz.Callback(44) = "DisableLighting p44on, 75,"
	Lampz.MassAssign(44) = l44r

	Lampz.MassAssign(45) = l45
	Lampz.Callback(45) = "DisableLighting p45on, 75,"


	Lampz.MassAssign(46) = l46
	Lampz.Callback(46) = "DisableLighting p46on, 75,"


	Lampz.MassAssign(47) = l47
	Lampz.Callback(47) = "DisableLighting p47on, 75,"


	Lampz.MassAssign(48) = l48
	Lampz.Callback(48) = "DisableLighting p48on, 75,"


	Lampz.MassAssign(49) = l49
	Lampz.Callback(49) = "DisableLighting p49on, 75,"


	Lampz.MassAssign(50) = l50
	Lampz.Callback(50) = "DisableLighting p50on, 75,"


	Lampz.MassAssign(51) = l51
	Lampz.Callback(51) = "DisableLighting p51on, 75,"


	Lampz.MassAssign(52) = l52
	Lampz.Callback(52) = "DisableLighting p52on, 75,"
	Lampz.MassAssign(52) = l52r

	Lampz.MassAssign(53) = l53
	Lampz.Callback(53) = "DisableLighting p53on, 75,"
	Lampz.MassAssign(53) = l53r


	Lampz.MassAssign(54) = l54
	Lampz.Callback(54) = "DisableLighting p54on, 75, "
	Lampz.MassAssign(54) = l54r

	Lampz.MassAssign(57) = l57
	Lampz.Callback(57) = "DisableLighting p57on, 75,"


	Lampz.MassAssign(58) = l58
	Lampz.Callback(58) = "DisableLighting p58on, 75,"


	Lampz.MassAssign(59) = l59
	Lampz.Callback(59) = "DisableLighting p59on, 75,"


	Lampz.MassAssign(63) = l63
	Lampz.Callback(63) = "DisableLighting p63on, 75,"
	Lampz.MassAssign(63) = l63r

	Lampz.MassAssign(64) = l64
	Lampz.Callback(64) = "DisableLighting p64on, 75,"

	Lampz.MassAssign(65) = l65
	Lampz.Callback(65) = "DisableLighting p65on, 75,"

	Lampz.MassAssign(66) = MissioneVenom3
	Lampz.MassAssign(67) = MissioneVenom2
	Lampz.MassAssign(68) = MissioneVenom1
	Lampz.MassAssign(69) = MissioneSandman3
	Lampz.MassAssign(70) = MissioneSandman2
	Lampz.MassAssign(71) = MissioneSandman1

	Lampz.MassAssign(72) = l72
	Lampz.Callback(72) = "DisableLighting p72on, 75,"
	Lampz.MassAssign(72) = l72r

	Lampz.MassAssign(74) = spotSandman
	Lampz.Callback(74) = "ModeGiColor 74,"
	Lampz.Callback(74) = "DisableLighting Sandman, 0.5,"

	Lampz.MassAssign(75) = spotVenom
	Lampz.Callback(75) = "ModeGiColor 75,"
	Lampz.Callback(75) = "DisableLighting Venom, 0.5,"

	Lampz.MassAssign(76) = spotGoblin
	Lampz.Callback(76) = "ModeGiColor 76,"
	Lampz.Callback(76) = "DisableLighting Goblin, 0.5,"

	Lampz.MassAssign(77) = spotOcto
	Lampz.Callback(77) = "ModeGiColor 77,"
	Lampz.Callback(77) = "DisableLighting Octopus, 1,"

	Lampz.MassAssign(78) = l78
	Lampz.Callback(78) = "DisableLighting p78on, 75,"

	ModLampz.MassAssign(23)=f23
	ModLampz.MassAssign(23)=F23a

	ModLampz.MassAssign(25)=f25
	ModLampz.MassAssign(25)=F25a
	
	ModLampz.MassAssign(26)=f26

	ModLampz.MassAssign(28)=FlasherGoblin

	ModLampz.MassAssign(31)=FlasherBumpers

''*****************
''GI Assignments
''*****************
'	Lampz.Callback(110) = "GIupdates"
'	Lampz.obj(110) = ColtoArray(GI)	
'	Lampz.state(110) = 1		'Turn on GI to Start

	ModLampz.Callback(0) = "GIUpdates"
	ModLampz.MassAssign(0)= ColToArray(GI) 

	dim ii
	For each ii in GI:ii.IntensityScale = 0.3:Next
	For each ii in GI_PF:ii.IntensityScale = 1:Next
	'For each ii in GI_PF:ii.Falloff = 400:Next
	

'	'Turn off all lamps on startup
'	lampz.TurnOnStates	'Set any lamps state to 1. (Object handles fading!)
'	lampz.update
		'Turn off all lamps on startup
	lampz.Init	'This just turns state of any lamps to 1
	ModLampz.Init

	'Immediate update to turn on GI, turn off lamps
	lampz.update
	ModLampz.Update


End Sub






'*********************************************************************************************************************************************************
'Begin lamp helper functions
'*********************************************************************************************************************************************************

'***************************************
'GI On/Off
'***************************************
Sub GIOn  : SetGI False: End Sub 'These are just debug commands now
Sub GIOff : SetGI True : End Sub

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

'***GI Color Mod***
Dim GIxx, ColorModRed, ColorModRedFull, ColorModGreen, ColorModGreenFull, ColorModBlue, ColorModBlueFull
Dim GIColorRed, GIColorGreen, GIColorBlue, GIColorFullRed, GIColorFullGreen, GIColorFullBlue, GIColor
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
	FlasherRGBGI.Color = GIColor
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

Class NullFadingObject : Public Property Let IntensityScale(input) : : End Property : End Class

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
			Loaded(idx) = False
		End If
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
		TurnOnStates
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





'Helper function
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

dim GameOnFF
GameOnFF = 0


Dim BallShadow
BallShadow = Array (BallShadow1,BallShadow2,BallShadow3,BallShadow4,BallShadow5)

Sub BallShadowUpdate()
    Dim BOT, b
    BOT = GetBalls
   ' hide shadow of deleted balls
    If UBound(BOT)<(tnob-1) Then
        For b = (UBound(BOT) + 1) to (tnob-1)
            BallShadow(b).visible = 0
        Next
    End If
    ' exit the Sub if no balls on the table
    If UBound(BOT) = -1 Then Exit Sub
    ' render the shadow for each ball
    For b = 0 to UBound(BOT)
        If BOT(b).X < Table1.Width/2 Then
            BallShadow(b).X = ((BOT(b).X) - (Ballsize/6) + ((BOT(b).X - (Table1.Width/2))/7)) + 5
        Else
            BallShadow(b).X = ((BOT(b).X) + (Ballsize/6) + ((BOT(b).X - (Table1.Width/2))/7)) - 5
        End If
        ballShadow(b).Y = BOT(b).Y + 10
        If BOT(b).Z > 10 Then
            BallShadow(b).visible = 1
        Else
            BallShadow(b).visible = 0
        End If
    Next
End Sub

'////////////////////// Options //////////////////////

If CabinetMode = 1 Then
		PinCab_Rails.visible = 0
		PinCab_Blades.Size_y = 2
	Else
		PinCab_Rails.visible = 1
		PinCab_Blades.Size_y = 1
End If

If Artsides = 1 then
		PinCab_Blades.image = "PinCab_Blades_Art"
		PinCab_Blades.blenddisablelighting = 0
	Else
		PinCab_Blades.image = "PinCab_Blades_Wood"
		PinCab_Blades.blenddisablelighting = 1
End if

DIM VRRoom, VRThings
If VRRoom > 0 Then
	ScoreText.visible = 0
	If VRRoom = 1 Then
		for each VRThings in VRCab:VRThings.visible = 1:Next
		for each VRThings in VRStuff:VRThings.visible = 1:Next
	End If
	If VRRoom = 2 Then
		for each VRThings in VRCab:VRThings.visible = 0:Next
		for each VRThings in VRStuff:VRThings.visible = 0:Next
		PinCab_Backglass.visible = 1
		PinCab_Backbox.visible = 1
		PinCab_Backbox.image = "Pincab_Backbox_Min"
		DMD.visible = 1
	End If
Else
		for each VRThings in VRCab:VRThings.visible = 0:Next
		for each VRThings in VRStuff:VRThings.visible = 0:Next
		If DesktopMode then ScoreText.visible = 1 else ScoreText.visible = 0 End If
End if





Sub DebugOutClear()

	Dim objFileToWrite:Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile("C:\vpxout\file.txt",2,true)
	objFileToWrite.WriteLine("")
	objFileToWrite.Close
	Set objFileToWrite = Nothing

End Sub

Sub DebugOut(data)

	Dim objFileToWrite:Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile("C:\vpxout\file.txt",8,true)
	objFileToWrite.WriteLine(data)
	objFileToWrite.Close
	Set objFileToWrite = Nothing

End Sub