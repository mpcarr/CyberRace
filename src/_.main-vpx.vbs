'  _______     ______  ______ _____  _____            _____ ______ 
'  / ____\ \   / /  _ \|  ____|  __ \|  __ \     /\   / ____|  ____|
'  | |     \ \_/ /| |_) | |__  | |__) | |__) |   /  \ | |    | |__   
'  | |      \   / |  _ <|  __| |  _  /|  _  /   / /\ \| |    |  __|  
'  | |____   | |  | |_) | |____| | \ \| | \ \  / ____ \ |____| |____ 
'  \_____|  |_|  |____/|______|_|  \_\_|  \_\/_/    \_\_____|______|
																 

'🚀🕹️ CyberRace Pinball is Here! 🌃🔥

'I’m thrilled to announce the launch of my visual pinball creation: CyberRace! 🎉 Get ready to dive into a neon-drenched, 
'adrenaline-fueled cyberpunk world like you've never seen before.

'👾 What’s Inside?

'Futuristic Aesthetics: Immerse yourself in a stunning cyberpunk cityscape, complete with neon lights and retro-futuristic vibes.
'High-Octane Gameplay: Experience intense pinball action that keeps you at the edge of your seat with every flipper hit.

'🎮 Download and Play!
'Ready to race through cyberspace? Download CyberRace now and start your adventure in the virtual pinball world of tomorrow!

'Credits
'-------------------------
'Design
'Layout
'Coding
'Lighting
'Blender Toolkit
'VR Room

'By Flux
'-------------------------
'-------------------------

'Music: Karl Casey @ White Bat Audio

'----------------------------------

'Direct Contributions:
'Sixtoe: 		VPX Walls and Prims Around Scoop
'Primetime5k: 	Staged Flippers
'jsm:			Standalone Patches
'mcarter78:		Ramp/Fleep Sound Fixes
'apophis:		Physics material tweaks, ambient ball shadows
'Tomate:		Ramps Rebuild
'AstroNasty:	Playfield bottom third redesign, physics tweaks, cyberrace flyer

'In-Direct Contributions:
'Niwak: 		VPX Lightmapper AKA Blender Toolkit (https://github.com/vbousquet/vpx_lightmapper)
'Apophis: 		Guidance and Advice
'Sixtoe: 		More Guidance and Advice
'eMBee:			DMD Gif help
'arelyel:		Queue Script
'fleep:			Fleep Sounds
'nfozzy:		nFozzy Physics
'Wylte:			Shadow Code / Inlane Slowdown Code

'Testing:
'PinStratsDan, Studlygoorite, passion4pins, mcarter78, bietekwiet , somatik, jsm and the rest of VPW.

'REQUIRED:

'Visual Pinball 10.8.0 beta 7, 64-bit (or later)
'FlexDMD 1.9 +

'PLEASE NOTE:

'You need 64 bits. Welcome to future. 
 
Const cGameName = "cyberrace"
Const myVersion = "1.3.0"

'2021-2022: who knows.
'Rebuild
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
'v21: flux: scorbit testing
'v22: jsm/flux: lots of standalone fixes
'v23-26: flux - many updates, new batch bake
'v27: flux - fix clock on sling, added skip to bonus, fixed race 5 & 6 selection
'v28: flux - bug fixes, pf friction 0.25 -> 0.2, added Time Trial Multiball Code
'v29: flux - altered dmd yellow to orange, moved callouts to backglass, added skillshot
'v30: flux - VR Room Update
'v31: flux - Add New DMD Animations, Fix Tilt. Fix MB SuperJackpot, Moved ExtraBall to end of bonus.
'v32: flux - Add BackGlass Calls 
'v33: mcarter78 - Add plunger material, fix collision sounds for ramp ends, sleeves, rollovers, gates, upper flipper
'v34: flux: fix spinner labels, balance: balance: revert race kick out so there is a chance of bouncing into secret garage, add: inlane speed limit, fix: repeated callouts on spinners, update: skillshot change lane
'v35: apophis: Fixed a few physics material assignments. Changed ball image and set to spherical map. Added ambient ball shadows. Enabled playfield reflections. Fleep volume fix. Added DisableStaticPrerendering functionality to options menu. Changed desktop POV. 
'v36: apophis: Added some mechanical hit sounds. 
'v37: flux : fixed sling animations, missing plastic textures and screws. Synced VR Room Lights With GI
'v38: flux : disable problematic texture
'v39: flux : fix music after extra ball, add check to bridge release to make sure all pins are released
'v40: flux : RC1, DOF Config
'v42: DGrimmReaper: add missing VR Cab buttons, animate VR Plunger
'v1.1.0: flux:
'- Fixed: Tilt Debounce (bug with mech tilt only)
'- Fixed: If the last race shoot was the ramp, the shoot also registered the final shot. Fixed so that the finish shot must be made.
'- Fixed: On the final shot the shortcut is now disabled.
'- Fixed: Issue where Playfield Multipliers were not applied
'- Fixed: DOF Config for 8 bumper pack
'- Fixed: Stuck balls in nodes scoop
'- Fixed: Bonus sound moved to backglass instead of SSF
'- Added: cabinet mode to options
'- Added: race progress to mode selection
'- Added: callout and light seq when race won
'- Added: callout for race time expired
'- Added: callout and light seq for shoot again
'- Added: race modes, active shots / race progress is displayed every 6 seconds during race.
'- Added: VR Cabinet Buttons and Animate VR Plunger (DGrimmReaper)
'- Balance: Changed AddTime activation from last 10 seconds to 20 seconds and increased addtime value from 12 seconds to 20 seconds.
'- Quality Of Life: Prioritised Race Timer on the display: If a race is running it will always show the race timer
'v1.2.0: flux
'- Fixed: Missing Const definition (thanks somatik)
'- Updated: Table Info
'- Fixed: CYBER score Multiplier
'- Adjusted Base Points Value from 750 to 7500
'- Combos now score the base value * the combo count
'- Added: more base points scoring to secret garage and bet targets
'- Added: Race Grace period. Race shots will count upto 2 seconds after timer expired.
'- Balance: Prevent Skills and Bet Modes from starting during race
'- Added: Countdown callouts on race timer 5,4,3,2,1
'- Fixed: Issue with Time Trial MB draining and lights locking up.
'- Fixed: Bonus Screen Scoring.
'v1.3.0: flux
'- Fixed: Spelling mistake on DMD Bonus screen
'- Performance: Change Race Mode Hit Seq to be less intense
'- Performance: Added debounce to spinner disc, it will start 600ms after hitting boost target
'- Performance: Moved animations of standup targets into standup code so it isn't ran on gametimer
'- Performance: Moved Disc animation onto gametimer from frametimer
'- Added: An Alt bonus sound to the options menu (thanks lminimart)
'- Fixed: Bug in race modes where more than the required shots were being registered
'- Added: 50% Chance of ball save if the ball drains to the left outlane after hitting the spinner shot
'- Balance: Adjusted walls on exit on top spinner to try and prevent stright down the middle issues.
'v1.3.1: flux
'- Fixed: Issue with shortcut light during spinner modes
'- Added: Super Jackpot callout and DMD Animation
'- Added: Race Won DMD Animation
'- Balance: Tried to reduce repeatable ski jump
'v1.3.2: flux
'- Fixed: Issue where you could start a new game when balls were releasing from bridge
'- Added: Clearer DMD Text for Spelling CYBER
'- Added: DMD shows EMP Hurry Up Value
'- Added: DMD Text and Animation for HYPER
'- Added: Ball Save for Extra Ball
'- Added: Display Bonus Score on DMD
'- Balance: Reworked Node Grid so if row hit is complete it will count for the next row
'- Added: Minimal VR Room
'- Added: Option to play wizard mode
'v1.3.3: flux
'- Fixed: Bug with Race 6 where finish would not light until next race activation
'- Balance: Wizard mode scoring now based on total score when mode starts
'- Balance: Wizard mode now moves to stage 3 when at least one ball has been locked on the bridge.
'- Added: Show Multiball Total scored after Multiball ended.
'-v1.3.4: flux
'- Fixed: Race label but which shows 7/6 shots remaining
'- Added: extra check onto ball search for instance when ball drains and doesn't register
'v1.3.5: flux
'- Fixed: Race Ready light disabled when more than 1 ball on the table
'v1.3.6: flux
'- Updaed: All references to ExecuteCallback re worked (known stutter issues)
'v1.3.7: flux
'- Updaed: All references to ExecuteCallback re worked (known stutter issues)


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
Dim pinEventsOrder : Set pinEventsOrder = CreateObject("Scripting.Dictionary")
Dim playerEvents : Set playerEvents = CreateObject("Scripting.Dictionary")
Dim playerEventsOrder : Set playerEventsOrder = CreateObject("Scripting.Dictionary")
Dim playerState : Set playerState = CreateObject("Scripting.Dictionary")
Dim DMDDisplay(20,20)
Dim NumberOfPlayers : NumberOfPlayers=0
Dim lightCtrl : Set lightCtrl = new LStateController
Dim gameDebugger : Set gameDebugger = new AdvGameDebugger
Dim debugLog : Set debugLog = new DebugLogFile
Dim debugLogOn : debugLogOn = False

Dim calloutsQ : Set calloutsQ = New vpwQueueManager

Dim Tilt
Dim MechTilt
Dim TiltSensitivity
Dim bMechTiltJustHit
Tilt = 0
TiltSensitivity = 5
MechTilt = 0 
bMechTiltJustHit = False

Dim DmdQ

Dim VRRoom, VRElement
VRRoom = 0 '0 = Standard Room, 1= Minimal Room
 
'If RenderingMode = 2 then 
	For Each VRElement in VRStuff
		VRElement.Visible = True
	Next
	If VRRoom = 0 Then
		For Each VRElement in VRRoomStandard
			VRElement.Visible = True
		Next
	End If
	If VRRoom = 1 Then
		For Each VRElement in VRMinimalRoom
			VRElement.Visible = True
		Next
	End If
	DMD.TimerEnabled = True
'End If

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
	B2SOn = True
	Controller.Run()
	If Err Then 
		B2SOn = False	
	End If
	On Error Goto 0
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

	lightCtrl.CreateSeqRunner("WIZARDL48")
	lightCtrl.CreateSeqRunner("WIZARDL46")
	lightCtrl.CreateSeqRunner("WIZARDL47")
	lightCtrl.CreateSeqRunner("WIZARDL23")
	lightCtrl.CreateSeqRunner("WIZARDL64")
	lightCtrl.CreateSeqRunner("WIZARDL63")

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

	kickerCaptiveBall1.enabled = false
	kickerCaptiveBall2.enabled = false

	DiverterOn.IsDropped = 1
	DiverterOff.IsDropped = 0
	RPin.IsDropped = 1
	LockPin1.IsDropped = 1
	LockPin2.IsDropped = 1
	LockPin3.IsDropped = 1
	WallScoopProtect.IsDropped = 1
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

	LeftSlingShot_Timer
	RightSlingShot_Timer
	
	lightCtrl.AddTableLightSeq "Attract", lSeqAttract3
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
	SetRoomBrightness RoomBrightness/100

	If useBCP = True Then
		ConnectToBCPMediaController
	End If
End Sub

Sub AttractTimer_Timer
	AttractTimer.Enabled = False
	gameBooted = True
	DmdQ.DMDResetAll()
	DispatchPinEvent GAME_OVER
End Sub

Sub Table1_Exit
	If B2SOn = True Then
		Controller.Pause = False
		Controller.Stop
	End If
	If Not FlexDMD is Nothing Then
		FlexDMD.Show = False
		FlexDMD.Run = False
		FlexDMD = NULL
    End If
	If useBcp = True Then
		bcpController.Disconnect
		Set bcpController = Nothing
	End If
End Sub