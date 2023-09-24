Const cGameName = "cyberrace"
Const myVersion = "0.0.17"

'v7 - flux: end of ball bonus, end of game bug fixes. Added lightshows for race mode, various bug fixes. 
'v8 - flux: fix duplicate sub name, update VR cab
'v9 - flux: Finished Race modes 1-4, added secret garage multiball, fixed missing fleep sounds for metals, tweaked vr cab.
'v10: sixtoe: modified prim so it fed the ramp a bit better and adjusted the walls around there a little and set the kickball to something like 0,0,55,0
'v11: flux: added randomness to top kick. added callouts for locked balls. fixed issue with bridge lock, fixed options menu
'v12: flux: Added BET mode callouts and GI Light colours. Add Skills Trial Mode.
'v13: flux: Lots of DMD work. fixed some mode issues
'v14: flux: fix skills trial crash, force dmd label alignments
'v15: flux: 128x32 dmd changes, enabled vr room (needs work)
'v16: flux: more dmd updates, added hyper mode, added multiball callouts and lights
'v17: Primetime5k: Added staged flipper support; staged flipper menu option
'v18: flux: initial scorbit integration
'v19: flux: debugging fps issues
'v20: flux: made ball sit lowerr in scoop, hopefully fixed scoop rejection from left flipper


Const MusicVol = 0.25			'Separate setting that only affects music volume. Range from 0 to 1. 
Const SoundFxLevel = 1
Const CalloutVol = 1				'Separate setting that only affects verbal callout volume. Range from 0 to 1

'----- Shadow Options -----
Const DynamicBallShadowsOn = 0		'0 = no dynamic ball shadow ("triangles" near slings and such), 1 = enable dynamic ball shadow
Const AmbientBallShadowOn = 1		'0 = Static shadow under ball ("flasher" image, like JP's)

Dim tablewidth: tablewidth = Table1.width
Dim tableheight: tableheight = Table1.height

Dim Ball1, Ball2, Ball3, Ball4, Ball5, gBOT

Dim Controller
Dim B2SOn

'Constants
Const BallSize = 50					'Ball size must be 50
Const BallMass = 1					'Ball mass must be 1
Const tnob = 6						'Total number of balls
Const lob = 2						'Locked balls
Const IMPowerSetting = 50 			'Plunger Power
Const IMTime = 1.1        			'Time in seconds for Full Plunge

Dim GrabMag
Dim plungerIM
Dim gameBooted : gameBooted = False
Dim gameStarted : gameStarted = False
Dim gameEnding : gameEnding = False
Dim LFlipperDown: LFlipperDown = False
Dim RFlipperDown: RFlipperDown = False
Dim currentPlayer : currentPlayer = Null
Dim autoPlunge : autoPlunge = False
Dim ballInPlungeerLane : ballInPlungerLane = False
Dim ballSaver : ballSaver = False
Dim ballSaverIgnoreCount : ballSaverIgnoreCount = 0
Dim ttSpinner
Dim pinEvents : Set pinEvents = CreateObject("Scripting.Dictionary")
Dim gameEvents : Set gameEvents = CreateObject("Scripting.Dictionary")
Dim playerEvents : Set playerEvents = CreateObject("Scripting.Dictionary")
Dim gameState : Set gameState = CreateObject("Scripting.Dictionary")
Dim playerState : Set playerState = CreateObject("Scripting.Dictionary")
Dim DMDDisplay(20,20)
Dim NumberOfPlayers : NumberOfPlayers=0

Dim lightCtrl : Set lightCtrl = new LStateController

Dim debugLog : Set debugLog = new DebugLogFile
Dim debugLogOn : debugLogOn = False

Dim calloutsQ : Set calloutsQ = New vpwQueueManager

Dim DmdQ : Set DmdQ = New Queue

Dim VRRoom, VRElement
If RenderingMode = 2 Then VRRoom = VRRoomChoice Else VRRoom = 0
 
If RenderingMode = 2 then 
	For Each VRElement in VRStuff
		VRElement.Visible = True
	Next
	DMD.TimerEnabled = True
End If

'/////////////////////-----Scorbit Options-----////////////////////
dim TablesDir : TablesDir = GetTablesFolder

Const     ScorbitAlternateUUID  = 0 	' Force Alternate UUID from Windows Machine and saves it in VPX Users directory (C:\Visual Pinball\User\ScorbitUUID.dat)	

If debugLogOn = True Then
	debugLog.WriteToLog "Game Started", "", 2
End If

LoadCoreFiles
Sub LoadCoreFiles
	On Error Resume Next
	ExecuteGlobal GetTextFile("core.vbs")
	If Err Then MsgBox "Can't open core.vbs"
	On Error Goto 0
	ExecuteGlobal GetTextFile("controller.vbs")
	If Err Then MsgBox "Can't open controller.vbs"
	On Error Goto 0

	On Error Resume Next
	Set Controller = CreateObject("B2S.Server")
	Controller.B2SName = cGameName
	Controller.Run()
	'If Err Then MsgBox "Can't load b2s"
	On Error Goto 0
	B2SOn = True
End Sub

Sub Table1_Init()
	
	vpmMapLights aLights2
	lightCtrl.RegisterLights "VPX"
	lightCtrl.CreateSeqRunner("BoostUp")
	lightCtrl.CreateSeqRunner("RaceMode")
	lightCtrl.CreateSeqRunner("NodesGrid")
	lightCtrl.CreateSeqRunner("BetMode")
	lightCtrl.CreateSeqRunner("GI")
	lightCtrl.CreateSeqRunner("NonRGB")
	lightCtrl.CreateSeqRunner("RGB")

	lightCtrl.CreateSeqRunner("Attract")

	'lightCtrl.LoadLightShows
	
	'InitLampsNF 'Init Lampz

	Set Ball1 = swTrough1.CreateSizedballWithMass(Ballsize/2,Ballmass)
	Set Ball2 = swTrough2.CreateSizedballWithMass(Ballsize/2,Ballmass)
	Set Ball3 = swTrough3.CreateSizedballWithMass(Ballsize/2,Ballmass)
	Set Ball4 = swTrough4.CreateSizedballWithMass(Ballsize/2,Ballmass)
	Set Ball5 = swTrough5.CreateSizedballWithMass(Ballsize/2,Ballmass)
	gBOT = Array(Ball1,Ball2,Ball3,Ball4,Ball5)

	kickerCaptiveBall1.CreateSizedballWithMass Ballsize/2, BallMass
	kickerCaptiveBall1.kick 0,0
	kickerCaptiveBall2.CreateSizedballWithMass Ballsize/2, BallMass
	kickerCaptiveBall2.kick 0,0

	DiverterOn.IsDropped = 1
	DiverterOff.IsDropped = 0
	RPin.IsDropped = 0
	LockPin1.IsDropped = 1
	LockPin2.IsDropped = 1
	LockPin3.IsDropped = 1
	LockPin4.IsDropped = True
	AnimateLockPin()

	Set ttSpinner = New cvpmTurntable
	ttSpinner.InitTurntable TurnTable, 100
	ttSpinner.SpinDown = 50
	ttSpinner.SpinUp = 100


	
	' Grab magnet
	Set GrabMag = New cvpmMagnet
	With GrabMag
		.InitMagnet GrabMagnet, 16  
		.GrabCenter = False
		.strength = 12
		.CreateEvents "GrabMag"
	End With

	Set plungerIM = New cvpmImpulseP
	With plungerIM
		.InitImpulseP swplunger, IMPowerSetting, IMTime
		.Random 1.5
		.InitExitSnd SoundFX("Saucer_Kick", DOFContactors), SoundFX("Relay_On", DOFContactors)
		.CreateEvents "plungerIM"
	End With
	Options_Load
	
	'lightCtrl.AddTableLightSeq "Attract", lSeqAttract3
	lightCtrl.AddTableLightSeq "Attract", lSeqAttWarm1
	lightCtrl.AddTableLightSeq "Attract", lSeqAttWarm2
	lightCtrl.AddTableLightSeq "Attract", lSeqAttFlashers
	Dim qItem : Set qItem = New QueueItem
	With qItem
		.Name = "boot"
		.Duration = 3
		.BGImage = "BGBlack"
		.BGVideo = "novideo"
	End With
	qItem.AddLabel "PLEASE WAIT", 	Font12, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, "blink"
	qItem.AddLabel "BOOTING", 		Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
	DmdQ.Enqueue qItem
	'StartScorbit
End Sub

Sub AttractTimer_Timer
	AttractTimer.Enabled = False
	gameBooted = True
	DmdQ.DMDResetAll()
	DispatchPinEvent GAME_OVER
End Sub

Sub Table1_Exit
	If B2SOn Then
		Controller.Pause = False
		Controller.Stop
	End If
	If Not FlexDMD is Nothing Then
		FlexDMD.Show = False
		FlexDMD.Run = False
		FlexDMD = NULL
    End If
	If Not IsNull(FlexDMDScorbit) Then
		FlexDMDScorbit.Show = False
		FlexDMDScorbit.Run = False
		FlexDMDScorbit = NULL
    End If
End Sub