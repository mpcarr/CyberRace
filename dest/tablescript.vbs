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
Dim DMDDisplay(20,20)
Dim NumberOfPlayers : NumberOfPlayers=0
Dim gameDebugger : Set gameDebugger = new AdvGameDebugger

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
	
	SetRoomBrightness RoomBrightness/100

	
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
End Sub


Const START_GAME = "Start Game"
Const NEXT_PLAYER = "Next Player"
Const RELEASE_BALL = "Release Ball"
Const BALL_DRAIN = "Ball Drain"
Const BALL_SAVE = "Ball Save"
Const GAME_OVER = "Game Over"
Const ADD_BALL = "Add Ball"
Const TILT_MACHINE = "Tilt Machine"
Const SWITCH_HIT_NODE_A = "Switch Hit Node A"
Const SWITCH_HIT_NODE_B = "Switch Hit Node B"
Const SWITCH_HIT_NODE_C = "Switch Hit Node C"
Const SWITCH_HIT_SCOOP = "Switch Hit SCOOP"
Const SWITCH_HIT_LEFT_ORBIT = "Switches Hit Left Orbit"
Const SWITCH_HIT_LEFT_ORBIT_WIZARD = "Switches Hit Left Orbit Wizard"
Const SWITCH_LEFT_FLIPPER_DOWN = "Switches Hit Left Flipper Down"
Const SWITCH_RIGHT_FLIPPER_DOWN = "Switches Right Flipper Down"
Const SWITCH_LEFT_FLIPPER_UP = "Switches Left Flipper Up"
Const SWITCH_RIGHT_FLIPPER_UP = "Switches Right Flipper Up"
Const SWITCH_BOTH_FLIPPERS_PRESSED = "Switches Both Flippers Pressed"
Const SWITCH_HIT_SPINNER1 = "Switches Hit Spinner 1"
Const SWITCH_HIT_SPINNER1_WIZARD = "Switches Hit Spinner 1 Wizard"
Const SWITCH_HIT_SPINNER2 = "Switches Hit Spinner 2"
Const SWITCH_HIT_SPINNER2_WIZARD = "Switches Hit Spinner 2 Wizard"
Const SWITCH_HIT_BUMPER = "Switches Hit Bumper"
Const SWITCH_HIT_RIGHT_RAMP_ENTER = "Switches Hit Right Ramp Enter"
Const SWITCH_HIT_RIGHT_RAMP = "Switches Hit Right Ramp"
Const SWITCH_HIT_RIGHT_RAMP_WIZARD = "Switches Hit Right Ramp Wizard"
Const SWITCH_HIT_LANE_A = "Switches Hit Lane A"
Const SWITCH_HIT_LEFT_RAMP = "Switches Hit Left Ramp"
Const SWITCH_HIT_LEFT_RAMP_WIZARD = "Switches Hit Left Ramp Wizard"
Const SWITCH_HIT_RIGHT_ORBIT = "Switches Hit Right Orbit"
Const SWITCH_HIT_RIGHT_ORBIT_WIZARD = "Switches Hit Right Orbit Wizard"
Const SWITCH_HIT_RAMP_LOCK = "Switch Hit Ramp Lock"
Const SWITCH_HIT_HYPER = "Switch Hit Hyper"
Const SWITCH_HIT_MYSTERY = "Switch Hit Mystery"
Const SWITCH_HIT_ADDTIME = "Switch Hit AddTime"
Const SWITCH_HIT_BOOST1 = "Switches Hit Boost1"
Const SWITCH_HIT_BOOST2 = "Switches Hit Boost2"
Const SWITCH_HIT_BOOST3 = "Switches Hit Boost3"

Const SWITCH_HIT_BET1 = "Switches Hit Bet 1"
Const SWITCH_HIT_BET2 = "Switches Hit Bet 2"
Const SWITCH_HIT_BET3 = "Switches Hit Bet 3"

Const SWITCH_HIT_AUGMENTATION = "Switches Hit Augmentation"
Const SWITCH_HIT_CAPTIVE = "Switches Hit Captive"
Const SWITCH_HIT_RESEARCH_1 = "Switches Hit Research 1"
Const SWITCH_HIT_RESEARCH_2 = "Switches Hit Research 2"
Const SWITCH_HIT_RESEARCH_3 = "Switches Hit Research 3"
Const SWITCH_HIT_PRE_LEFT_ORBIT = "Switches Hit Pre Left Orbit"
Const SWITCH_HIT_PRE_RIGHT_ORBIT = "Switches Hit Pre Right Orbit"


Const SWITCH_HIT_CONSOLE = "Switches Hit Console"
Const SWITCH_HIT_HYPERJUMP = "Switches Hit Hyper Jump"

Const SWITCH_HIT_LEFT_RETURN = "Switches Hit Center Ramp"
Const SWITCH_HIT_SHORTCUT = "Switches Hit Shortcut"
Const SWITCH_HIT_SHORTCUT_WIZARD = "Switches Hit Shortcut Wizard"
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
Const SWITCH_HIT_RACE_KICKER = "Switches Hit Race Kicker"

Const SWITCHES_LAST_FLIPPER_DOWN_TIME = "Switches Last Flipper Down Time"

Const SWITCH_START_GAME_KEY = "Switches Start Game Key"
Const SWITCH_PLUNGER_KEY = "Switches Plunger Key"
Const SWITCH_SELECT_EVENT_KEY = "Switches Select Event Key"


'***********************************************************************************************************************
'*****  Game State                                           	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

'Shots
Const GAME_SHOT_HYPER_JUMP = "Game Shot Hyper Jump"
Const GAME_SHOT_LEFT_ORBIT = "Game Shot Left Orbit"
Const GAME_SHOT_LEFT_RAMP = "Game Shot Left Ramp"
Const GAME_SHOT_SPINNER = "Game Shot Spinner"
Const GAME_SHOT_LEFT_RETURN = "Game Shot Left Return"
Const GAME_SHOT_BUMPERS = "Game Shot Bumpers"
Const GAME_SHOT_RIGHT_RAMP = "Game Shot Right Ramp"
Const GAME_SHOT_RIGHT_RAMP_COLLECT = "Game Shot Right Ramp Collect"
Const GAME_SHOT_RIGHT_ORBIT = "Game Shot Right Oribt"
Const GAME_SHOT_SHORTCUT = "Game Shot Shortcut"
Const GAME_SHOT_FINISH = "Game Shot Finish"

Dim GameTilted : GameTilted = False
Dim GAME_DRAIN_BALLS_AND_RESET : GAME_DRAIN_BALLS_AND_RESET = False

Dim GameHiScoreLetters : GameHiScoreLetters = Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"," ")
Dim GameShots: GameShots = Array(GAME_SHOT_HYPER_JUMP, GAME_SHOT_LEFT_ORBIT,GAME_SHOT_LEFT_RAMP,GAME_SHOT_SPINNER,GAME_SHOT_BUMPERS,GAME_SHOT_LEFT_RETURN,GAME_SHOT_RIGHT_RAMP,GAME_SHOT_RIGHT_ORBIT,GAME_SHOT_SHORTCUT)
Dim GameCombos: Set GameCombos = CreateObject("Scripting.Dictionary")

GameCombos.Add "116118", "Left Ramp -> Right Ramp"
GameCombos.Add "118116", "Right Ramp -> Left Ramp"

Dim GAME_BALLSAVE_TIMER_IDX : GAME_BALLSAVE_TIMER_IDX = 0
Dim GAME_RACE_TIMER_IDX : GAME_RACE_TIMER_IDX = 1
Dim GAME_BET_TIMER_IDX : GAME_BET_TIMER_IDX = 2
Dim GAME_BOOST_TIMER_IDX : GAME_BOOST_TIMER_IDX = 3
Dim GAME_EMP_TIMER_IDX : GAME_EMP_TIMER_IDX = 4
Dim GAME_SKILLS_TIMER_IDX : GAME_SKILLS_TIMER_IDX = 5
Dim GAME_BONUS_TIMER_IDX : GAME_BONUS_TIMER_IDX = 6
Dim GAME_SELECTION_TIMER_IDX : GAME_SELECTION_TIMER_IDX = 7
Dim GAME_MULTIPLIER_TIMER_IDX : GAME_MULTIPLIER_TIMER_IDX = 8
Dim GAME_TT_TIMER_IDX : GAME_TT_TIMER_IDX = 9

Const GAME_BALLSAVE_TIMER_ENDED = "Game Ball Save Timer Ended"
Const GAME_RACE_TIMER_ENDED = "Game Race Timer Ended"
Const GAME_BET_TIMER_ENDED = "Game Bet Timer Ended"
Const GAME_BOOST_TIMER_ENDED = "Game Boost Timer Ended"
Const GAME_EMP_TIMER_ENDED = "Game EMP Timer Ended"
Const GAME_SKILLS_TIMER_ENDED = "Game Skills Timer Ended"
Const GAME_BONUS_TIMER_ENDED = "Game Bonus Timer Ended"
Const GAME_SELECTION_TIMER_ENDED = "Game Selection Timer Ended"
Const GAME_MULTIPLIER_TIMER_ENDED = "Game Multiplier Timer Ended"
Const GAME_TT_TIMER_ENDED = "Game TT Timer Ended"

Const GAME_BALLSAVE_TIMER_HURRY = "Game Ball Save Timer Hurry"
Const GAME_RACE_TIMER_HURRY = "Game Race Timer Hurry"
Const GAME_BET_TIMER_HURRY = "Game Bet Timer Hurry"
Const GAME_BOOST_TIMER_HURRY = "Game Boost Timer Hurry"
Const GAME_EMP_TIMER_HURRY = "Game EMP Timer Hurry"
Const GAME_SKILLS_TIMER_HURRY = "Game Skills Timer Hurry"
Const GAME_BONUS_TIMER_HURRY = "Game Bonus Timer Hurry"
Const GAME_SELECTION_TIMER_HURRY = "Game Selection Timer Hurry"
Const GAME_MULTIPLIER_TIMER_HURRY = "Game Multiplier Timer Hurry"
Const GAME_TT_TIMER_HURRY = "Game TT Timer Hurry"

'Modes
Const GAME_MODE_NORMAL = "Game_Mode_Normal"
Const GAME_MODE_CHOOSE_SKILLSHOT = "Game_Mode_Choose_Skillshot"
Const GAME_MODE_SKILLSHOT_ACTIVE = "Game_Mode_Skillshot_Active"
Const GAME_MODE_AUGMENTATION_RESEARCH = "Game_Mode_Augmentation_Research"
Const GAME_MODE_MULTIBALL = "Game_Mode_Multiball"
Const GAME_MODE_HURRYUP = "Game_Mode_Hurry Up"
Const GAME_MODE_RACE_SELECT = "Game Mode Race Select"
Const GAME_MODE_RACE = "Game Mode Race"
'Colors
Dim GAME_NORMAL_COLOR : GAME_NORMAL_COLOR = RGB(255,255,255)
Dim GAME_RESEARCH_COLOR : GAME_RESEARCH_COLOR = RGB(15, 79, 255)
Dim GAME_HURRYUP_COLOR : GAME_HURRYUP_COLOR = RGB(255, 240, 33)
Dim GAME_MULTIBALL_COLOR : GAME_MULTIBALL_COLOR = RGB(13, 109, 18)
Dim GAME_RACE_COLOR : GAME_RACE_COLOR = RGB(255, 0, 0)
Dim GAME_SKILLS_COLOR : GAME_SKILLS_COLOR = RGB(255, 191, 0)
Dim GAME_TT_COLOR : GAME_TT_COLOR = RGB(127, 0, 127)

Const GAME_BET_MAX_HITS = 20

Dim GAME_RACE_MODE_TITLES : GAME_RACE_MODE_TITLES = Array("RYKAR", "MINERVA", "ALLESA", "NYE", "LUKA", "EZRI")
Dim GAME_RACE_MODE_DESC : GAME_RACE_MODE_DESC = Array("Ramp Shots", "Spinners", "Roving Shot", "Orbits/Nodes", "Ramps/Nodes", "Spinners/Orbits")

Dim GAME_NODE_PERK_TITLES : GAME_RACE_MODE_TITLES = Array("RYKAR", "MINERVA", "ALLESA", "NYE", "LUKA", "EZRI")
Dim GAME_NODE_PERK_DESC : GAME_RACE_MODE_DESC = Array("Ramp Shots", "Spinners", "Roving Shot", "Orbits/Nodes", "Ramps/Nodes", "Spinners/Orbits")

' Balls Per Game
Const BALLS_PER_GAME = 3


'Base Points
Const POINTS_BASE = 7500
Const POINTS_MODE_SHOT = 50000
Const POINTS_JACKPOT = 250000
Const POINTS_BUMPERS = 1675
Const POINTS_SPINNER = 2000
Const POINTS_COMBO = 75000
Const POINTS_RESEARCH_NODE = 10000
Const POINTS_HURRYUP = 1000000
Const POINTS_BONUS_X = 75000
Const POINTS_BET_SPIN = 40000


'Base Hits
Const EMP_BASE_HITS = 10
Const SKILLS_BASE_SPINS = 20

Dim GameTimers : GameTimers = Array(0,0,0,0,0,0,0,0,0,0)
Dim GameTimersHurry : GameTimersHurry = Array(0,0,0,0,0,0,0,0,0,0)
Dim GameTimerColors : GameTimerColors = Array(GAME_NORMAL_COLOR,GAME_RACE_COLOR,GAME_HURRYUP_COLOR,GAME_MULTIBALL_COLOR,GAME_NORMAL_COLOR,GAME_SKILLS_COLOR, Null, Null, Null, GAME_TT_COLOR)
Dim GameTimerEndEvent : GameTimerEndEvent = Array(GAME_BALLSAVE_TIMER_ENDED,GAME_RACE_TIMER_ENDED,GAME_BET_TIMER_ENDED,GAME_BOOST_TIMER_ENDED,GAME_EMP_TIMER_ENDED,GAME_SKILLS_TIMER_ENDED, GAME_BONUS_TIMER_ENDED, GAME_SELECTION_TIMER_ENDED, GAME_MULTIPLIER_TIMER_ENDED, GAME_TT_TIMER_ENDED)
Dim GameTimerHurryEvent : GameTimerHurryEvent = Array(GAME_BALLSAVE_TIMER_HURRY,GAME_RACE_TIMER_HURRY,GAME_BET_TIMER_HURRY,GAME_BOOST_TIMER_HURRY,GAME_EMP_TIMER_HURRY,GAME_SKILLS_TIMER_HURRY, GAME_BONUS_TIMER_HURRY, GAME_SELECTION_TIMER_HURRY, GAME_MULTIPLIER_TIMER_HURRY, GAME_TT_TIMER_HURRY)

' Define the MysteryAwards array globally
Dim MysteryAwards(4, 1)
MysteryAwards(0, 0) = "Add 50K"
MysteryAwards(0, 1) = 60
MysteryAwards(1, 0) = "AdvBonusX"
MysteryAwards(1, 1) = 60
MysteryAwards(2, 0) = "Add A Ball"
MysteryAwards(2, 1) = 40
MysteryAwards(3, 0) = "Light Race"
MysteryAwards(3, 1) = 30
MysteryAwards(4, 0) = "Add 100K"
MysteryAwards(4, 1) = 50
' Calculate the total weight
Dim totalMysteryWeight, i
totalMysteryWeight = 0
For i = 0 To UBound(MysteryAwards)
    totalMysteryWeight = totalMysteryWeight + MysteryAwards(i, 1)
Next

'***********************************************************************************************************************
'***********************************************************************************************************************
'*****  Player State                                           	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Const EMPTY_STR=""

'GI
Const GI_STATE = "GI State"
Const GI_COLOR = "GI Color"

'Flex
Const FLEX_MODE = "Flex Mode"
Const PLAYER_NAME = "Player Name"
'Score 
Const SCORE = "score"

'Ball
Const CURRENT_BALL = "ball"
Const ENABLE_BALLSAVER = "Enable Ball Saver"
Const EXTRA_BALLS = "Extra Balls"
'Lanes
Const LANE_R = "Lane R"
Const LANE_A = "Lane A"
Const LANE_C = "Lane C"
Const LANE_E = "Lane E"

'Skillshot
Const MODE_SKILLSHOT_ACTIVE = "Mode_Skillshot_Active"

'Ball Save
Const BALL_SAVE_ACTIVE = "Ball Save Active"

'Top Lanes
Const LANE_BO =     "Lane BO"
Const LANE_N =      "Lane N"
Const LANE_US =     "Lane US"

'Bonus
Const BONUS_X  = "Bonus X"

'PF Nultiplier
Const PF_MULTIPLIER = "PF Multiplier"

'Pop Bumpers
Const EMP_CHARGE = "EMP Charge"
Const EMP_ACTIVATIONS = "EMP Activations"
Const EMP_SHOT = "EMP Shot"

'Nodes (Perks)
Const NODE_LEVEL = "Node Level"
Const NODE_LEVEL_UP_READY = "Node Level Up Ready"
Const NODE_COMPLETED = "Node Completed"
Const NODE_ROW_A = "Node Row A"
Const NODE_ROW_B = "Node Row B"
Const NODE_ROW_C = "Node Row C"

'Skills Trial
Const SKILLS_TRIAL_SHOT = "Skills Trial Shot"
Const SKILLS_TRIAL_SPINS = "SKills Trial Spins"
Const SKILLS_TRIAL_READY = "Skills Trial Ready"
Const SKILLS_TRIAL_ACTIVATIONS = "SKills Trial Activiations"

'5-way Combo
Const COMBO_COUNT = "Combo Count"
Const COMBO_SHOT_SPINNER = "Combo Shot Spinner"
Const COMBO_SHOT_LEFT_ORBIT = "Combo Shot Left Orbit"
Const COMBO_SHOT_LEFT_RAMP = "Combo Shot Left Ramp"
Const COMBO_SHOT_RIGHT_RAMP = "Combo Shot Right Ramp"
Const COMBO_SHOT_RIGHT_ORBIT = "Combo Shot Right Orbit"

'Boost Targets
Const BOOST_1 = "Boost 1"
Const BOOST_2 = "Boost 2"
Const BOOST_3 = "Boost 3"
Const BOOST_SHOT = "Boost Shot"
Const BOOST_HITS = "Boost Hits"
Const BOOST_ACTIVATIONS = "Boost Activations"

'CYBER
Const CYBER_C = "Cyber C"
Const CYBER_Y = "Cyber Y"
Const CYBER_B = "Cyber B"
Const CYBER_E = "Cyber E"
Const CYBER_R = "Cyber R"

'HYPER
Const HYPER = "Hyper"
Const HYPER_LEVEL = "Hyper Level"
Const HYPER_PLAYED = "Hyper Played"

Const TT_ORBIT = "TT ORBIT"
Const TT_TARGET = "TT TARGET"
Const TT_RAMP = "TT RAMP"
Const TT_CAPTIVE = "TT CAPTIVE"
Const TT_SHORTCUT = "TT SHORTCUT"
Const TT_COLLECTED = "TT COLLECTED"
Const TT_JACKPOTS = "TT JACKPOTS"
Const TT_ACTIVATIONS = "TT Activations"

'Secret Garagew
Const GARAGE_ENGINE = "Garage Engine"
Const GARAGE_COOLING = "Garage Cooling"
Const GARAGE_HULL = "Garage Hull"

'Bet Targets
Const BET_1 = "Bet 1"
Const BET_2 = "Bet 2"
Const BET_3 = "Bet 3"
Const BET_ACTIVATIONS = "BET Activations"
Const BET_VALUE = "Bet Value"
Const BET_MULTIPLIER = "Bet Multiplier"
Const BET_HITS = "Bet Hits"

'Shot Multipliers
Const SHOT_SPINNER1_MULTIPLIER = "Shot Spinner1 Mulitplier"
Const SHOT_LEFT_ORBIT_MULTIPLIER = "Shot Left Orbit Mulitplier"
Const SHOT_LEFT_RAMP_MULTIPLIER = "Shot Left Ramp Mulitplier"
Const SHOT_RIGHT_RAMP_MULTIPLIER = "Shot Right Ramp Mulitplier"
Const SHOT_RIGHT_ORBIT_MULTIPLIER = "Shot Right Orbit Mulitplier"

'Lock
Const NEON_L = "Neon L"
Const NEON_O = "Neon O"
Const NEON_C = "Neon C"
Const NEON_K = "Neon K"
Const LOCK_HITS = "Lock Hits"
Const LOCK_LIT = "Lock Lit"
Const BALLS_LOCKED = "Balls Locked"

'Turn Table
Const TURN_TABLE_MOTOR = "Turn Table Motor"

'Points
Const JACKPOT_VALUE = "Jackpot Value"

'Race Modes
Const RACE_TIMERS = "Race Timers"
Const RACE_MODE_READY = "Race Mode Ready"
Const RACE_MODE_SELECTION = "Race Mode Selection"
Const RACE_MODE_1_HITS = "Race Mode 1 Hits"
Const RACE_MODE_2_SPIN1 = "Race Mode 2 Spin 1 Hits"
Const RACE_MODE_2_SPIN2 = "Race Mode 2 Spin 2 Hits"
Const RACE_MODE_3_HITS = "Race Mode 3 Hits"
Const RACE_MODE_4_HITS = "Race Mode 4 Hits"
Const RACE_MODE_3_SHOT = "Race Mode 3 Shot"
Const RACE_MODE_5_HITS = "Race Mode 5 Hits"
Const RACE_MODE_6_HITS = "Race Mode 6 Hits"
Const RACE_MODE_6_SPIN1 = "Race Mode 6 Spin 1 Hits"
Const RACE_MODE_6_SPIN2 = "Race Mode 6 Spin 2 Hits"
Const RACE_1 = "Race 1 Complete"
Const RACE_2 = "Race 2 Complete"
Const RACE_3 = "Race 3 Complete"
Const RACE_4 = "Race 4 Complete"
Const RACE_5 = "Race 5 Complete"
Const RACE_6 = "Race 6 Complete"
Const RACE_EXTRABALL = "Race Extra Ball"
Const RACE_GRACE = "Race Grace"

Const OUTLANE_SAVE = "Outlane Save"
Const JACKPOTS_MULTIPLIER = "Jackpots Multiplier"

'Bonus
Const BONUS_COMBOS_MADE = "Bonus Combos Make"
Const BONUS_RACES_WON = "Bonus Races Won"
Const BONUS_NODES_COMPLETED = "Bonus Nodes Completed"
Const BONUS_SKILLS_COMPLETED = "Bonus Skills Completed"
Const BONUS_TT_COMPLETED = "Bonus TT Completed"

'Grand Slam

Const GRANDSLAM_TT = "Grand Slam TT"
Const GRANDSLAM_RACES = "Grand Slam Races"
Const GRANDSLAM_COMBO = "Grand Slam Combo"
Const GRANDSLAM_NODES = "Grand Slam Nodes"
Const GRANDSLAM_SKILLS = "Grand Slam Skills"
Const GRANDSLAM_WIZARD_READY = "Grand Slam Wizard Ready"

'HI Score
Const INITIAL_1 = "Initial 1"
Const INITIAL_2 = "Initial 2"
Const INITIAL_3 = "Initial 3"
Const INITIAL_POSITION = "Initial Position"
Const LETTER_POSITION = "Letter Position"


Const RACE_MODE_FINISH = "Race Mode Finish"

'Mystery
Const MYSTERY_HITS = "Mystery Hits"

Const MODE_NORMAL = "Game_Mode_Normal"
Const MODE_AUGMENTATION_RESEARCH = "Game_Mode_Augmentation_Research"
Const MODE_MULTIBALL = "Game_Mode_Multiball"
Const MODE_TT_MULTIBALL = "Game Mode TT Multiball"
Const MODE_HURRYUP = "Game_Mode_Hurry Up"
Const MODE_RACE_SELECT = "Game Mode Race Select"
Const MODE_PERK_SELECT = "Game Mode Perk Select"
Const MODE_HISCORE = "Game Mode Hi Score"


Const MODE_RACE = "Game Mode Race"
Const MODE_EMP = "Game Mode EMP"
Const MODE_SKILLS_TRIAL = "Game Mode Skills Trial"
Const MODE_BOOST = "Game Mode Boost"
Const MODE_CYBER = "Game Mode Cyber"
Const MODE_BET = "Game Mode Bet"
Const MODE_WIZARD = "Game Mode Wizard"
Const MODE_WIZARD_STAGE = "Game Mode Wizard Stage"
Const MODE_WIZARD_HITS = "Game Mode Wizard Hits"

'***********************************************************************************************************************


Sub Spinner1_Animate()
    Dim el
	For Each el in BP_Spinner1
		el.RotX = Spinner1.currentangle
	Next

End Sub

Sub Spinner2_Animate()
    Dim el
	For Each el in BP_Spinner2
		el.RotX = Spinner2.currentangle
	Next
End Sub

Sub sw01_Animate
	Dim z : z = sw01.CurrentAnimOffset
	Dim el : For Each el in BP_sw01 : el.transz = z: Next
End Sub

Sub sw02_Animate
	Dim z : z = sw02.CurrentAnimOffset
	Dim el : For Each el in BP_sw02 : el.transz = z: Next
End Sub

Sub sw03_Animate
	Dim z : z = sw03.CurrentAnimOffset
	Dim el : For Each el in BP_sw03 : el.transz = z: Next
End Sub

Sub sw04_Animate
	Dim z : z = sw04.CurrentAnimOffset
	Dim el : For Each el in BP_sw04 : el.transz = z: Next
End Sub

Sub sw05_Animate
	Dim z : z = sw05.CurrentAnimOffset
	Dim el : For Each el in BP_sw05 : el.transz = z: Next
End Sub

Sub sw06_Animate
	Dim z : z = sw06.CurrentAnimOffset
	Dim el : For Each el in BP_sw06 : el.transz = z: Next
End Sub

Sub sw07_Animate
	Dim z : z = sw07.CurrentAnimOffset
	Dim el : For Each el in BP_sw07 : el.transz = z: Next
End Sub

Sub sw31_Animate
	Dim z : z = sw31.CurrentAnimOffset
	Dim el : For Each el in BP_sw31 : el.transz = z: Next
End Sub

Sub sw14_Animate
	Dim z : z = sw14.CurrentAnimOffset
	Dim el : For Each el in BP_sw14 : el.transz = z: Next
End Sub

Sub sw08_Animate
	Dim z : z = sw08.CurrentAnimOffset
	Dim el : For Each el in BP_sw08 : el.transz = z: Next
End Sub

Sub BIPL_Animate
	Dim z : z = BIPL.CurrentAnimOffset
	Dim el : For Each el in BP_BIPL : el.transz = z: Next
End Sub

Sub Bumper1_Animate: Dim a, x: a = Bumper1.CurrentRingOffset: For Each x in BP_BR1: x.Z = a: Next: End Sub
Sub Bumper2_Animate: Dim a, x: a = Bumper2.CurrentRingOffset: For Each x in BP_BR2: x.Z = a: Next: End Sub
Sub Bumper3_Animate: Dim a, x: a = Bumper3.CurrentRingOffset: For Each x in BP_BR3: x.Z = a: Next: End Sub

Sub Gate002_Animate()
    Dim el
	For Each el in BP_Gate002_Wire
		el.RotX = Gate002.currentangle
	Next
End Sub

Sub sw26_Animate()
    Dim el
	For Each el in BP_sw26_Wire
		el.RotX = sw26.currentangle
	Next
End Sub

Sub LeftFlipper_Animate
	Dim a : a = LeftFlipper.CurrentAngle
    'FlipperLSh.RotZ = a

	' Darken light from lane bulbs when bats are up
	Dim v, w, u, LM
	v = 255.0 * (120.0 -  LeftFlipper.CurrentAngle) / (120.0 -  69.0)
	w = Gray2RGB(255.0 - v)
	u = Gray2RGB(v)

	For Each el in BP_FlipperL
		el.Rotz = a
		el.color = w
		el.visible = v < 128.0
	Next

	For Each el in BP_FlipperLU
		el.Rotz = a
		el.color = u
		el.visible = v > 128.0
	Next

End Sub

Sub RightFlipper_Animate
	Dim a : a = RightFlipper.CurrentAngle
    'FlipperLSh.RotZ = a

	' Darken light from lane bulbs when bats are up
	Dim v, w, u, LM
	v = 255.0 * (120.0 -  RightFlipper.CurrentAngle) / (120.0 -  69.0)
	w = Gray2RGB(255.0 - v)
	u = Gray2RGB(v)

	For Each el in BP_FlipperR
		el.Rotz = a
		el.color = w
		el.visible = v < 128.0
	Next

	For Each el in BP_FlipperRU
		el.Rotz = a
		el.color = u
		el.visible = v > 128.0
	Next

End Sub


Sub UpRightFlipper_Animate
	Dim a : a = UpRightFlipper.CurrentAngle
    'FlipperLSh.RotZ = a

	' Darken light from lane bulbs when bats are up
	Dim v, w, u, LM
	v = 255.0 * (120.0 -  UpRightFlipper.CurrentAngle) / (120.0 -  69.0)
	w = Gray2RGB(255.0 - v)
	u = Gray2RGB(v)

	For Each el in BP_FlipperU
		el.Rotz = a
		el.color = w
		el.visible = v < 128.0

	Next

	For Each el in BP_FlipperUU
		el.Rotz = a
		el.color = u
		el.visible = v > 128.0
	Next

End Sub

Sub AnimateLockPin()
	Dim el
	For Each el in BP_LockPin4
		If LockPin4.IsDropped = True Then el.Visible=True Else el.Visible = False End If
	Next
	For Each el in BP_LockPin4UP
		If LockPin4.IsDropped = True Then el.Visible=False Else el.Visible = True End If
	Next
	If LockPin4.IsDropped = True Then
		PlaySoundAtLevelStatic "Flipper_Left_Down_4", SoundFxLevel, sw02
	Else
		PlaySoundAtLevelStatic "lipper_L04", SoundFxLevel, sw02
	End If
End Sub

'VR Plunger Animation
Sub TimerPlunger_Timer
  If VR_CabShooter_BM.Y < 150 then
      VR_CabShooter_BM.Y = VR_CabShooter_BM.Y + 5
  End If
End Sub

Sub TimerPlunger2_Timer
	VR_CabShooter_BM.Y = 15 + (5* Plunger.Position) -20
End Sub


'***************************************************************
'	Ambient ball shadows
'***************************************************************

'Ambient (Room light source)
Const AmbientBSFactor = 0.9    '0 To 1, higher is darker
Const AmbientMovement = 1	   '1+ higher means more movement as the ball moves left and right
Const offsetX = 0			   'Offset x position under ball (These are if you want to change where the "room" light is for calculating the shadow position,)
Const offsetY = 0			   'Offset y position under ball (^^for example 5,5 if the light is in the back left corner)

' *** Trim or extend these to match the number of balls/primitives/flashers on the table!  (will throw errors if there aren't enough objects)
Dim objBallShadow(8)

'Initialization
BSInit

Sub BSInit()
	Dim iii
	'Prepare the shadow objects before play begins
	For iii = 0 To tnob - 1
		Set objBallShadow(iii) = Eval("BallShadow" & iii)
		objBallShadow(iii).material = "BallShadow" & iii
		UpdateMaterial objBallShadow(iii).material,1,0,0,0,0,0,AmbientBSFactor,RGB(0,0,0),0,0,False,True,0,0,0,0
		objBallShadow(iii).Z = 3 + iii / 1000
		objBallShadow(iii).visible = 0
	Next
End Sub


Sub BSUpdate
	Dim s: For s = lob To UBound(gBOT)
		' *** Normal "ambient light" ball shadow
		
		'Primitive shadow on playfield, flasher shadow in ramps
		'** If on main and upper pf
		If gBOT(s).Z > 20 Then
			objBallShadow(s).visible = 1
			objBallShadow(s).X = gBOT(s).X + (gBOT(s).X - (tablewidth / 2)) / (Ballsize / AmbientMovement) + offsetX
			objBallShadow(s).Y = gBOT(s).Y + offsetY
			'objBallShadow(s).Z = gBOT(s).Z + s/1000 + 1.04 - 25	

		'** Under pf, no shadow
		Else
			objBallShadow(s).visible = 0
		End If
	Next
End Sub


'*****************************************************************************************************************************************
'  Vpx Bcp Controller
'*****************************************************************************************************************************************

Class VpxBcpController

    Private m_bcpController, m_connected

    Private Sub Class_Initialize()
        On Error Resume Next
        Set m_bcpController = CreateObject("vpx_bcp_server.VpxBcpController")
        m_bcpController.Connect 5050, "cyberrace-mc.exe"
        m_connected = True
        bcpUpdate.Enabled = True
        If Err Then Debug.print("Can't start Vpx Bcp Controller") : m_connected = False
    End Sub

	Public Sub Send(commandMessage)
		If m_connected Then
            m_bcpController.Send commandMessage
        End If
	End Sub

    Public Function GetMessages
		If m_connected Then
            GetMessages = m_bcpController.GetMessages
        End If
	End Function

    Public Sub Reset()
		If m_connected Then
            m_bcpController.Send "reset"
        End If
	End Sub
    
    Public Sub PlaySlide(slide, context, priorty)
		If m_connected Then
            m_bcpController.Send "trigger?json={""name"": ""slides_play"", ""settings"": {""" & slide & """: {""action"": ""play"", ""expire"": 0}}, ""context"": """ & context & """, ""priority"": " & priorty & "}"
        End If
	End Sub

    Public Sub SendPlayerVariable(name, value, prevValue)
		If m_connected Then
            m_bcpController.Send "player_variable?name=" & name & "&value=" & EncodeVariable(value) & "&prev_value=" & EncodeVariable(prevValue) & "&change=" & EncodeVariable(VariableVariance(value, prevValue)) & "&player_num=int:" & GetCurrentPlayerNumber
            '06:34:34.644 : VERBOSE : BCP : Received BCP command: ball_start?player_num=int:1&ball=int:1
        End If
	End Sub

    Private Function EncodeVariable(value)
        Dim retValue
        Select Case VarType(value)
            Case vbInteger, vbLong
                retValue = "int:" & value
            Case vbSingle, vbDouble
                retValue = "float:" & value
            Case vbString
                retValue = "string:" & value
            Case vbBoolean
                retValue = "bool:" & CStr(value)
            Case Else
                retValue = "NoneType:"
        End Select
        EncodeVariable = retValue
    End Function
    
    Private Function VariableVariance(v1, v2)
        Dim retValue
        Select Case VarType(v1)
            Case vbInteger, vbLong, vbSingle, vbDouble
                retValue = Abs(v1 - v2)
            Case Else
                retValue = True 
        End Select
        VariableVariance = retValue
    End Function

    Public Sub Disconnect()
        If m_connected Then
            m_bcpController.Disconnect()
            m_connected = False
            bcpUpdate.Enabled = False
        End If
    End Sub
End Class

Sub BcpSendPlayerVar(args)
    Dim ownProps, kwargs : ownProps = args(0) : kwargs = args(1) 
    Dim player_var : player_var = kwargs(0)
    Dim value : value = kwargs(1)
    Dim prevValue : prevValue = kwargs(2)
    bcpController.SendPlayerVariable player_var, value, prevValue
End Sub

Sub BcpAddPlayer(playerNum)
    If useBcp Then
        bcpController.Send("player_added?player_num=int:"&playerNum)
    End If
End Sub

Sub bcpUpdate_Timer()
    Dim messages : messages = bcpController.GetMessages()
    If IsArray(messages) and UBound(messages)>-1 Then
        Dim message, parameters, parameter
        For Each message in messages
            Select Case message.Command
                case "hello"
                    bcpController.Reset
                case "monitor_start"
                    Dim category : category = message.GetValue("category")
                    If category = "player_vars" Then
                        AddPlayerStateEventListener SCORE, SCORE &   "BcpSendPlayerVar",   "BcpSendPlayerVar",  1000, True
                        AddPlayerStateEventListener CURRENT_BALL, CURRENT_BALL &   "BcpSendPlayerVar",   "BcpSendPlayerVar",  1000, True
                End If
                case "register_trigger"
                    Dim eventName : eventName = message.GetValue("event")
            End Select
        Next
    End If
End Sub

'*****************************************************************************************************************************************
'  END Vpx Bcp Controller
'*****************************************************************************************************************************************

Dim debugWorld : debugWorld = False

Sub ShowDebugRoom()
	debugWorld = True
	'Dim tblElement
	'For Each tblElement in Room_BM
	'	tblElement.Visible = False
	'Next
End Sub

Sub HideDebugRoom()
	Dim tblElement
	'For Each tblElement in Room_BM
	'	tblElement.Visible = True
	'Next
End Sub



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






'*****************************************************************************************************************************************
'  Advance Game Debugger by flux
'*****************************************************************************************************************************************
Class AdvGameDebugger

    Private m_advDebugger, m_connected

    Private Sub Class_Initialize()
        On Error Resume Next
        Set m_advDebugger = CreateObject("vpx_adv_debugger.VPXAdvDebugger")
        m_advDebugger.Connect()
        m_connected = True
        If Err Then Debug.Print("Can't start advanced debugger") : m_connected = False
    End Sub

	Public Sub SendPlayerState(key, value)
		If m_connected Then
            m_advDebugger.SendPlayerState key, value
        End If
	End Sub

    Public Sub SendPinEvent(evt)
		If m_connected Then
            m_advDebugger.SendPinEvent evt
        End If
	End Sub

    Public Sub Disconnect()
        If m_connected Then
            m_advDebugger.Disconnect()
        End If
    End Sub
End Class

'*****************************************************************************************************************************************
'  Advance Game Debugger by flux
'*****************************************************************************************************************************************

'***********************************************************************************************************************
'*****  DOF    	                                                                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Public Sub DOF(DOFevent, State)
    If B2SOn = True Then
        If State = 2 Then
            Controller.B2SSetData DOFevent, 1:Controller.B2SSetData DOFevent, 0
        Else
            Controller.B2SSetData DOFevent, State
        End If
    End If
End Sub

'***********************************************************************************************************************

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

dim FlippersD : Set FlippersD = new Dampener
FlippersD.name = "Flippers"
FlippersD.debugOn = False
FlippersD.Print = False	
FlippersD.addpoint 0, 0, 1.1	
FlippersD.addpoint 1, 3.77, 0.99
FlippersD.addpoint 2, 6, 0.99

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
		RealCOR = BallSpeed(aBall) / (cor.ballvel(aBall.id)+0.0001)
		coef = desiredcor / realcor 
		if debugOn then str = name & " in vel:" & round(cor.ballvel(aBall.id),2 ) & vbnewline & "desired cor: " & round(desiredcor,4) & vbnewline & _
		"actual cor: " & round(realCOR,4) & vbnewline & "ballspeed coef: " & round(coef, 3) & vbnewline 
		if Print then debug.print Round(cor.ballvel(aBall.id),2) & ", " & round(desiredcor,3)

		aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		if debugOn then TBPout.text = str
	End Sub

	public sub Dampenf(aBall, parm) 'Rubberizer is handle here
		dim RealCOR, DesiredCOR, str, coef
		DesiredCor = LinearEnvelope(cor.ballvel(aBall.id), ModIn, ModOut )
		RealCOR = BallSpeed(aBall) / (cor.ballvel(aBall.id)+0.0001)
		coef = desiredcor / realcor 
		If abs(aball.velx) < 2 and aball.vely < 0 and aball.vely > -3.75 then 
			aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		End If
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




Sub leftInlaneSpeedLimit
	'Wylte's implementation
    'debug.print "Spin in: "& activeball.AngMomZ
    'debug.print "Speed in: "& activeball.vely
	If activeball.vely < 0 Then Exit Sub 							'don't affect upwards movement
    activeball.AngMomZ = -abs(activeball.AngMomZ) * RndNum(3,6)
    If abs(activeball.AngMomZ) > 60 Then activeball.AngMomZ = 0.8 * activeball.AngMomZ
    If abs(activeball.AngMomZ) > 80 Then activeball.AngMomZ = 0.8 * activeball.AngMomZ
    If activeball.AngMomZ > 100 Then activeball.AngMomZ = RndNum(80,100)
    If activeball.AngMomZ < -100 Then activeball.AngMomZ = RndNum(-80,-100)

    If abs(activeball.vely) > 5 Then activeball.vely = 0.8 * activeball.vely
    If abs(activeball.vely) > 10 Then activeball.vely = 0.8 * activeball.vely
    If abs(activeball.vely) > 15 Then activeball.vely = 0.8 * activeball.vely
    If activeball.vely > 16 Then activeball.vely = RndNum(14,16)
    If activeball.vely < -16 Then activeball.vely = RndNum(-14,-16)
    'debug.print "Spin out: "& activeball.AngMomZ
    'debug.print "Speed out: "& activeball.vely
End Sub


Sub rightInlaneSpeedLimit
	'Wylte's implementation
    'debug.print "Spin in: "& activeball.AngMomZ
    'debug.print "Speed in: "& activeball.vely
	If activeball.vely < 0 Then Exit Sub 							'don't affect upwards movement

    activeball.AngMomZ = abs(activeball.AngMomZ) * RndNum(2,4)
    If abs(activeball.AngMomZ) > 60 Then activeball.AngMomZ = 0.8 * activeball.AngMomZ
    If abs(activeball.AngMomZ) > 80 Then activeball.AngMomZ = 0.8 * activeball.AngMomZ
    If activeball.AngMomZ > 100 Then activeball.AngMomZ = RndNum(80,100)
    If activeball.AngMomZ < -100 Then activeball.AngMomZ = RndNum(-80,-100)

	If abs(activeball.vely) > 5 Then activeball.vely = 0.8 * activeball.vely
    If abs(activeball.vely) > 10 Then activeball.vely = 0.8 * activeball.vely
    If abs(activeball.vely) > 15 Then activeball.vely = 0.8 * activeball.vely
    If activeball.vely > 16 Then activeball.vely = RndNum(14,16)
    If activeball.vely < -16 Then activeball.vely = RndNum(-14,-16)
    'debug.print "Spin out: "& activeball.AngMomZ
    'debug.print "Speed out: "& activeball.vely
End Sub



Dim RStep, Lstep
LStep = 4
RStep = 4
Sub RightSlingShot_Slingshot
	If GameTilted = False Then
		RS.VelocityCorrect(ActiveBall)
		RStep = 0
		RandomSoundSlingshotRight ActiveBall
		DOF 104,DOFPulse
		DOF 202,DOFPulse
		RightSlingShot.TimerInterval = 17
    	RightSlingShot.TimerEnabled = 1
	End If
End Sub

Sub RightSlingShot_Timer
	Dim x1, x2, y: x1 = True:x2 = False:y = -20
	Select Case RStep
		Case 3:x1 = False:x2 = True:y = -10 :
		Case 4:x1 = False:x2 = False:y = 0:RightSlingShot.TimerEnabled = 0 
	End Select
	Dim x	
	For Each BL in BP_RSling1 : BL.Visible = x1: Next
	For Each BL in BP_RSling2 : BL.Visible = x2: Next
	For Each BL in BP_REMK : BL.transx = -y: Next	
	RStep = RStep + 1
End Sub

Sub LeftSlingShot_Slingshot
	If GameTilted = False Then
		LS.VelocityCorrect(ActiveBall)
		RandomSoundSlingshotLeft ActiveBall
		DOF 103,DOFPulse
		DOF 201,DOFPulse
		LStep = 0
		LeftSlingShot.TimerInterval = 17
    	LeftSlingShot.TimerEnabled = 1
	End If
End Sub


Sub LeftSlingShot_Timer
	Dim x1, x2, y: x1 = True:x2 = False:y = -20
	Select Case LStep
		Case 3:x1 = False:x2 = True:y = -10 : 
		Case 4:x1 = False:x2 = False:y = 0:LeftSlingShot.TimerEnabled = 0
	End Select

	Dim x	
	For Each BL in BP_LSling1 : BL.Visible = x1: Next
	For Each BL in BP_LSling2 : BL.Visible = x2: Next
	For Each BL in BP_LEMK : BL.transx = -y: Next		
	LStep = LStep + 1
End Sub

'******************************************************
'  SLINGSHOT CORRECTION FUNCTIONS
'******************************************************
' To add these slingshot corrections:
'	 - On the table, add the endpoint primitives that define the two ends of the Slingshot
'	 - Initialize the SlingshotCorrection objects in InitSlingCorrection
'	 - Call the .VelocityCorrect methods from the respective _Slingshot event sub

Dim LS
Set LS = New SlingshotCorrection
Dim RS
Set RS = New SlingshotCorrection

InitSlingCorrection

Sub InitSlingCorrection
	LS.Object = LeftSlingshot
	LS.EndPoint1 = EndPoint1LS
	LS.EndPoint2 = EndPoint2LS
	
	RS.Object = RightSlingshot
	RS.EndPoint1 = EndPoint1RS
	RS.EndPoint2 = EndPoint2RS
	
	'Slingshot angle corrections (pt, BallPos in %, Angle in deg)
	' These values are best guesses. Retune them if needed based on specific table research.
	AddSlingsPt 0, 0.00, - 4
	AddSlingsPt 1, 0.45, - 7
	AddSlingsPt 2, 0.48,	0
	AddSlingsPt 3, 0.52,	0
	AddSlingsPt 4, 0.55,	7
	AddSlingsPt 5, 1.00,	4
End Sub

Sub AddSlingsPt(idx, aX, aY)		'debugger wrapper for adjusting flipper script in-game
	Dim a
	a = Array(LS, RS)
	Dim x
	For Each x In a
		x.addpoint idx, aX, aY
	Next
End Sub

'' The following sub are needed, however they may exist somewhere else in the script. Uncomment below if needed
'Dim PI: PI = 4*Atn(1)

Function RotPoint(x,y,angle)
	dim rx, ry
	rx = x*dCos(angle) - y*dSin(angle)
	ry = x*dSin(angle) + y*dCos(angle)
	RotPoint = Array(rx,ry)
End Function

Class SlingshotCorrection
	Public DebugOn, Enabled
	Private Slingshot, SlingX1, SlingX2, SlingY1, SlingY2
	
	Public ModIn, ModOut
	
	Private Sub Class_Initialize
		ReDim ModIn(0)
		ReDim Modout(0)
		Enabled = True
	End Sub
	
	Public Property Let Object(aInput)
		Set Slingshot = aInput
	End Property
	
	Public Property Let EndPoint1(aInput)
		SlingX1 = aInput.x
		SlingY1 = aInput.y
	End Property
	
	Public Property Let EndPoint2(aInput)
		SlingX2 = aInput.x
		SlingY2 = aInput.y
	End Property
	
	Public Sub AddPoint(aIdx, aX, aY)
		ShuffleArrays ModIn, ModOut, 1
		ModIn(aIDX) = aX
		ModOut(aIDX) = aY
		ShuffleArrays ModIn, ModOut, 0
		If gametime > 100 Then Report
	End Sub
	
	Public Sub Report() 'debug, reports all coords in tbPL.text
		If Not debugOn Then Exit Sub
		Dim a1, a2
		a1 = ModIn
		a2 = ModOut
		Dim str, x
		For x = 0 To UBound(a1)
			str = str & x & ": " & Round(a1(x),4) & ", " & Round(a2(x),4) & vbNewLine
		Next
		TBPout.text = str
	End Sub
	
	
	Public Sub VelocityCorrect(aBall)
		Dim BallPos, XL, XR, YL, YR
		
		'Assign right and left end points
		If SlingX1 < SlingX2 Then
			XL = SlingX1
			YL = SlingY1
			XR = SlingX2
			YR = SlingY2
		Else
			XL = SlingX2
			YL = SlingY2
			XR = SlingX1
			YR = SlingY1
		End If
		
		'Find BallPos = % on Slingshot
		If Not IsEmpty(aBall.id) Then
			If Abs(XR - XL) > Abs(YR - YL) Then
				BallPos = PSlope(aBall.x, XL, 0, XR, 1)
			Else
				BallPos = PSlope(aBall.y, YL, 0, YR, 1)
			End If
			If BallPos < 0 Then BallPos = 0
			If BallPos > 1 Then BallPos = 1
		End If
		
		'Velocity angle correction
		If Not IsEmpty(ModIn(0) ) Then
			Dim Angle, RotVxVy
			Angle = LinearEnvelope(BallPos, ModIn, ModOut)
			'   debug.print " BallPos=" & BallPos &" Angle=" & Angle 
			'   debug.print " BEFORE: aBall.Velx=" & aBall.Velx &" aBall.Vely" & aBall.Vely 
			RotVxVy = RotPoint(aBall.Velx,aBall.Vely,Angle)
			If Enabled Then aBall.Velx = RotVxVy(0)
			If Enabled Then aBall.Vely = RotVxVy(1)
			'   debug.print " AFTER: aBall.Velx=" & aBall.Velx &" aBall.Vely" & aBall.Vely 
			'   debug.print " " 
		End If
	End Sub
End Class
'******************************************************
' VPW TargetBouncer for targets and posts by Iaakki, Wrd1972, Apophis
'******************************************************

Const TargetBouncerEnabled = 1	  '0 = normal standup targets, 1 = bouncy targets
Const TargetBouncerFactor = 0.7	 'Level of bounces. Recommmended value of 0.7


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


Sub PlayCallout(value)
    '           Sound,  LoopCount,  Volume,     pan,    randompitch,    pitch, usesame, restart,    front_rear_fade
    PlaySound value,0,CalloutVol,0,0,1,1,1,0
End Sub


'******************************************************
'****  FLEEP MECHANICAL SOUNDS
'******************************************************

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
BallBouncePlayfieldSoftFactor = 0.125									'volume multiplier; must not be zero
BallBouncePlayfieldHardFactor = 0.125									'volume multiplier; must not be zero
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
SpinnerSoundLevel = 0.5                              					'volume level; range [0, 1]

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
	PlaySound playsoundparams, 0, Min(1, aVol) * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelExistingStatic(playsoundparams, aVol, tableobj)
	PlaySound playsoundparams, 0, Min(1, aVol) * VolumeDial, AudioPan(tableobj), 0, 0, 1, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticLoop(playsoundparams, aVol, tableobj)
	PlaySound playsoundparams, -1, Min(1, aVol) * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticRandomPitch(playsoundparams, aVol, randomPitch, tableobj)
	PlaySound playsoundparams, 0, Min(1, aVol) * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, Min(1, aVol) * VolumeDial, AudioPan(ActiveBall), 0, 0, 0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLevelExistingActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, Min(1, aVol) * VolumeDial, AudioPan(ActiveBall), 0, 0, 1, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLeveTimerActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, Min(1, aVol) * VolumeDial, AudioPan(ballvariable), 0, 0, 0, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelTimerExistingActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, Min(1, aVol) * VolumeDial, AudioPan(ballvariable), 0, 0, 1, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelRoll(playsoundparams, aVol, pitch)
	PlaySound playsoundparams, -1, Min(1, aVol) * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

' Previous Positional Sound Subs

Sub PlaySoundAt(soundname, tableobj)
	PlaySound soundname, 1, 1 * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtVol(soundname, tableobj, aVol)
	PlaySound soundname, 1, Min(1,aVol) * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtBall(soundname)
	PlaySoundAt soundname, ActiveBall
End Sub

Sub PlaySoundAtBallVol (Soundname, aVol)
	Playsound soundname, 1,Min(1,aVol) * VolumeDial, AudioPan(ActiveBall), 0,0,0, 1, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtBallVolM (Soundname, aVol)
	Playsound soundname, 1,Min(1,aVol) * VolumeDial, AudioPan(ActiveBall), 0,0,0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtVolLoops(sound, tableobj, Vol, Loops)
	PlaySound sound, Loops, Vol * VolumeDial, AudioPan(tableobj), 0,0,0, 1, AudioFade(tableobj)
End Sub


'******************************************************
'  Fleep  Supporting Ball & Sound Functions
'******************************************************

Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "table1" is the name of the table
  Dim tmp
    tmp = tableobj.y * 2 / tableheight-1

	if tmp > 7000 Then
		tmp = 7000
	elseif tmp < -7000 Then
		tmp = -7000
	end if

    If tmp > 0 Then
		AudioFade = Csng(tmp ^10)
    Else
        AudioFade = Csng(-((- tmp) ^10) )
    End If
End Function

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
    Dim tmp
    tmp = tableobj.x * 2 / tablewidth-1

	if tmp > 7000 Then
		tmp = 7000
	elseif tmp < -7000 Then
		tmp = -7000
	end if

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
	PlaySoundAtLevelStatic ("Plunger_Pull_1"), PlungerPullSoundLevel, Plunger
End Sub

Sub SoundPlungerReleaseBall()
	PlaySoundAtLevelStatic ("Plunger_Release_Ball"), PlungerReleaseSoundLevel, Plunger	
End Sub

Sub SoundPlungerReleaseNoBall()
	PlaySoundAtLevelStatic ("Plunger_Release_No_Ball"), PlungerReleaseSoundLevel, Plunger
End Sub


'/////////////////////////////  KNOCKER SOLENOID  ////////////////////////////
Sub KnockerSolenoid()
	PlaySoundAtLevelStatic SoundFX("Knocker_1",DOFKnocker), KnockerSoundLevel, KnockerPosition
End Sub

'/////////////////////////////  DRAIN SOUNDS  ////////////////////////////
Sub RandomSoundDrain(drainswitch)
	PlaySoundAtLevelStatic ("Drain_" & Int(Rnd*11)+1), DrainSoundLevel, drainswitch
End Sub

'/////////////////////////////  TROUGH BALL RELEASE SOLENOID SOUNDS  ////////////////////////////

Sub RandomSoundBallRelease(drainswitch)
	PlaySoundAtLevelStatic SoundFX("BallRelease" & Int(Rnd*7)+1,DOFContactors), BallReleaseSoundLevel, drainswitch
End Sub

'/////////////////////////////  SLINGSHOT SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundSlingshotLeft(sling)
	PlaySoundAtLevelStatic SoundFX("Sling_L" & Int(Rnd*10)+1,DOFContactors), SlingshotSoundLevel, Sling
End Sub

Sub RandomSoundSlingshotRight(sling)
	PlaySoundAtLevelStatic SoundFX("Sling_R" & Int(Rnd*8)+1,DOFContactors), SlingshotSoundLevel, Sling
End Sub

'/////////////////////////////  BUMPER SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundBumperTop(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Top_" & Int(Rnd*5)+1,DOFContactors), 1 * BumperSoundFactor, Bump
End Sub

Sub RandomSoundBumperMiddle(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Middle_" & Int(Rnd*5)+1,DOFContactors), 1 * BumperSoundFactor, Bump
End Sub

Sub RandomSoundBumperBottom(Bump)
	PlaySoundAtLevelStatic SoundFX("Bumpers_Bottom_" & Int(Rnd*5)+1,DOFContactors), 1 * BumperSoundFactor, Bump
End Sub

'/////////////////////////////  SPINNER SOUNDS  ////////////////////////////
Sub SoundSpinner(spinnerswitch)
	PlaySoundAtLevelStatic ("Spinner"), SpinnerSoundLevel, spinnerswitch
End Sub


'/////////////////////////////  FLIPPER BATS SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  FLIPPER BATS SOLENOID ATTACK SOUND  ////////////////////////////
Sub SoundFlipperUpAttackLeft(flipper)
	FlipperUpAttackLeftSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
	PlaySoundAtLevelStatic SoundFX("Flipper_Attack-L01",DOFFlippers), FlipperUpAttackLeftSoundLevel, flipper
End Sub

Sub SoundFlipperUpAttackRight(flipper)
	FlipperUpAttackRightSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
	PlaySoundAtLevelStatic SoundFX("Flipper_Attack-R01",DOFFlippers), FlipperUpAttackLeftSoundLevel, flipper
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

'/////////////////////////////  ROLLOVER SOUNDS  ////////////////////////////
Sub RandomSoundRollover()
	PlaySoundAtLevelActiveBall ("Rollover_" & Int(Rnd*4)+1), RolloverSoundLevel
End Sub

Sub Rollovers_Hit(idx)
	RandomSoundRollover
End Sub

'/////////////////////////////  VARIOUS PLAYFIELD SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  RUBBERS AND POSTS  ////////////////////////////
'/////////////////////////////  RUBBERS - EVENTS  ////////////////////////////
Sub Rubbers_Hit(idx)
	dim finalspeed
	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
	If finalspeed > 5 then		
		RandomSoundRubberStrong 1
	End if
	If finalspeed <= 5 then
		RandomSoundRubberWeak()
	End If	
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
	RandomSoundWall()      
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

'/////////////////////////////  LEFT LANE ENTRANCE - SOUNDS  ////////////////////////////

Sub RandomSoundLeftArch()
	PlaySoundAtLevelActiveBall ("Arch_L" & Int(Rnd*4)+1), Vol(ActiveBall) * ArchSoundFactor
End Sub

Sub RandomSoundRightArch()
	PlaySoundAtLevelActiveBall ("Arch_R" & Int(Rnd*4)+1), Vol(ActiveBall) * ArchSoundFactor
End Sub


Sub Arch1_hit()
	If Activeball.velx > 1 Then SoundPlayfieldGate
	StopSound "Arch_L1"
	StopSound "Arch_L2"
	StopSound "Arch_L3"
	StopSound "Arch_L4"
End Sub

Sub Arch1_unhit()
	If activeball.velx < -8 Then
		RandomSoundRightArch
	End If
End Sub

Sub Arch2_hit()
	If Activeball.velx < 1 Then SoundPlayfieldGate
	StopSound "Arch_R1"
	StopSound "Arch_R2"
	StopSound "Arch_R3"
	StopSound "Arch_R4"
End Sub

Sub Arch2_unhit()
	If activeball.velx > 10 Then
		RandomSoundLeftArch
	End If
End Sub

'/////////////////////////////  SAUCERS (KICKER HOLES)  ////////////////////////////

Sub SoundSaucerLock()
	PlaySoundAtLevelStatic ("Saucer_Enter_" & Int(Rnd*2)+1), SaucerLockSoundLevel, Activeball
End Sub

Sub SoundSaucerKick(scenario, saucer)
	Select Case scenario
		Case 0: PlaySoundAtLevelStatic SoundFX("Saucer_Empty", DOFContactors), SaucerKickSoundLevel, saucer
		Case 1: PlaySoundAtLevelStatic SoundFX("Saucer_Kick", DOFContactors), SaucerKickSoundLevel, saucer
	End Select
End Sub

'/////////////////////////////  BALL COLLISION SOUND  ////////////////////////////
Sub OnBallBallCollision(ball1, ball2, velocity)
	Dim snd
	Select Case Int(Rnd*7)+1
		Case 1 : snd = "Ball_Collide_1"
		Case 2 : snd = "Ball_Collide_2"
		Case 3 : snd = "Ball_Collide_3"
		Case 4 : snd = "Ball_Collide_4"
		Case 5 : snd = "Ball_Collide_5"
		Case 6 : snd = "Ball_Collide_6"
		Case 7 : snd = "Ball_Collide_7"
	End Select

	PlaySound (snd), 0, Csng(velocity) ^2 / 200 * BallWithBallCollisionSoundFactor * VolumeDial, AudioPan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
End Sub


'///////////////////////////  DROP TARGET HIT SOUNDS  ///////////////////////////

Sub RandomSoundDropTargetReset(obj)
	PlaySoundAtLevelStatic SoundFX("Drop_Target_Reset_" & Int(Rnd*6)+1,DOFContactors), 1, obj
End Sub

Sub SoundDropTargetDrop(obj)
	PlaySoundAtLevelStatic ("Drop_Target_Down_" & Int(Rnd*6)+1), 200, obj
End Sub

'/////////////////////////////  GI AND FLASHER RELAYS  ////////////////////////////

Const RelayFlashSoundLevel = 0.315									'volume level; range [0, 1];
Const RelayGISoundLevel = 1.05									'volume level; range [0, 1];

Sub Sound_GI_Relay(toggle, obj)
	Select Case toggle
		Case 1
			PlaySoundAtLevelStatic ("Relay_GI_On"), 0.025*RelayGISoundLevel, obj
		Case 0
			PlaySoundAtLevelStatic ("Relay_GI_Off"), 0.025*RelayGISoundLevel, obj
	End Select
End Sub

Sub Sound_Flash_Relay(toggle, obj)
	Select Case toggle
		Case 1
			PlaySoundAtLevelStatic ("Relay_Flash_On"), 0.025*RelayFlashSoundLevel, obj			
		Case 0
			PlaySoundAtLevelStatic ("Relay_Flash_Off"), 0.025*RelayFlashSoundLevel, obj		
	End Select
End Sub

'/////////////////////////////////////////////////////////////////
'					End Mechanical Sounds
'/////////////////////////////////////////////////////////////////


'******************************************************
'**** RAMP ROLLING SFX
'******************************************************

'Ball tracking ramp SFX 1.0
'   Reqirements:
'          * Import A Sound File for each ball on the table for plastic ramps.  Call It RampLoop<Ball_Number> ex: RampLoop1, RampLoop2, ...
'          * Import a Sound File for each ball on the table for wire ramps. Call it WireLoop<Ball_Number> ex: WireLoop1, WireLoop2, ...
'          * Create a Timer called RampRoll, that is enabled, with a interval of 100
'          * Set RampBAlls and RampType variable to Total Number of Balls
'	Usage:
'          * Setup hit events and call WireRampOn True or WireRampOn False (True = Plastic ramp, False = Wire Ramp)
'          * To stop tracking ball
'                 * call WireRampOff
'                 * Otherwise, the ball will auto remove if it's below 30 vp units
'

dim RampMinLoops : RampMinLoops = 4

' RampBalls
'      Setup:        Set the array length of x in RampBalls(x,2) Total Number of Balls on table + 1:  if tnob = 5, then RammBalls(6,2)
'      Description:  
dim RampBalls(6,2)
'x,0 = ball x,1 = ID,	2 = Protection against ending early (minimum amount of updates)
'0,0 is boolean on/off, 0,1 unused for now
RampBalls(0,0) = False

' RampType
'     Setup: Set this array to the number Total number of balls that can be tracked at one time + 1.  5 ball multiball then set value to 6
'     Description: Array type indexed on BallId and a values used to deterimine what type of ramp the ball is on: False = Wire Ramp, True = Plastic Ramp
dim RampType(6)	

Sub WireRampOn(input)  : Waddball ActiveBall, input : RampRollUpdate: End Sub
Sub WireRampOff() : WRemoveBall ActiveBall.ID	: End Sub


' WaddBall (Active Ball, Boolean)
'     Description: This subroutine is called from WireRampOn to Add Balls to the RampBalls Array
Sub Waddball(input, RampInput)	'Add ball
	' This will loop through the RampBalls array checking each element of the array x, position 1
	' To see if the the ball was already added to the array.
	' If the ball is found then exit the subroutine
	dim x : for x = 1 to uBound(RampBalls)	'Check, don't add balls twice
		if RampBalls(x, 1) = input.id then 
			if Not IsEmpty(RampBalls(x,1) ) then Exit Sub	'Frustating issue with BallId 0. Empty variable = 0
		End If
	Next

	' This will itterate through the RampBalls Array.
	' The first time it comes to a element in the array where the Ball Id (Slot 1) is empty.  It will add the current ball to the array
	' The RampBalls assigns the ActiveBall to element x,0 and ball id of ActiveBall to 0,1
	' The RampType(BallId) is set to RampInput
	' RampBalls in 0,0 is set to True, this will enable the timer and the timer is also turned on
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

' WRemoveBall (BallId)
'    Description: This subroutine is called from the RampRollUpdate subroutine 
'                 and is used to remove and stop the ball rolling sounds
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

Sub RampRoll_Timer():RampRollUpdate:End Sub

Sub RampRollUpdate()		'Timer update
	dim x : for x = 1 to uBound(RampBalls)
		if Not IsEmpty(RampBalls(x,1) ) then 
			if BallVel(RampBalls(x,0) ) > 1 then ' if ball is moving, play rolling sound
				If RampType(x) then 
					PlaySound("RampLoop" & x), -1, VolPlayfieldRoll(RampBalls(x,0)) * RampRollVolume * VolumeDial, AudioPan(RampBalls(x,0)), 0, BallPitchV(RampBalls(x,0)), 1, 0, AudioFade(RampBalls(x,0))				
					StopSound("wireloop" & x)
				Else
					StopSound("RampLoop" & x)
					PlaySound("wireloop" & x), -1, VolPlayfieldRoll(RampBalls(x,0)) * RampRollVolume * VolumeDial, AudioPan(RampBalls(x,0)), 0, BallPitch(RampBalls(x,0)), 1, 0, AudioFade(RampBalls(x,0))
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

' This can be used to debug the Ramp Roll time.  You need to enable the tbWR timer on the TextBox
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


' Ramp triggers

Sub trigRamp1_hit
	If activeball.vely>0 Then
		WireRampOff
	Else
		WireRampOn true
	End If
End Sub

Sub trigRamp2_hit
	If activeball.vely>0 Then
		WireRampOff
	Else
		WireRampOn true
	End If
End Sub


Sub trigRamp3_hit
	If activeball.vely>0 Then
		WireRampOff
	Else
		WireRampOn true
	End If
End Sub

Sub trigRamp4_hit
	WireRampOff
End Sub

Sub trigRamp5_hit
	WireRampOff
End Sub

Sub trigRamp6_hit
	WireRampOff
End Sub

Sub RandomSoundRampStop(obj)
	Select Case Int(rnd*3)
		Case 0: PlaySoundAtVol "wireramp_stop1", obj, 0.2*VolumeDial:PlaySoundAtLevelActiveBall ("Rubber_Strong_1"), Vol(ActiveBall) * RubberStrongSoundFactor * 0.6
		Case 1: PlaySoundAtVol "wireramp_stop2", obj, 0.2*VolumeDial:PlaySoundAtLevelActiveBall ("Rubber_Strong_2"), Vol(ActiveBall) * RubberStrongSoundFactor * 0.6
		Case 2: PlaySoundAtVol "wireramp_stop3", obj, 0.2*VolumeDial:PlaySoundAtLevelActiveBall ("Rubber_1_Hard"), Vol(ActiveBall) * RubberStrongSoundFactor * 0.6
	End Select
End Sub

'******************************************************
'**** END RAMP ROLLING SFX
'******************************************************



'******************************************************
'****  BALL ROLLING AND DROP SOUNDS
'******************************************************
'
' Be sure to call RollingUpdate in a timer with a 10ms interval see the GameTimer_Timer() sub

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

Sub RollingUpdate()
	Dim b', BOT
'	BOT = GetBalls

	' stop the sound of deleted balls
	For b = UBound(gBOT) + 1 to tnob - 1
		' Comment the next line if you are not implementing Dyanmic Ball Shadows
		rolling(b) = False
		StopSound("BallRoll_" & b)
	Next

	' exit the sub if no balls on the table
	If UBound(gBOT) = -1 Then Exit Sub

	' play the rolling sound for each ball

	For b = 0 to UBound(gBOT)
		If BallVel(gBOT(b)) > 1 AND gBOT(b).z < 30 Then
			rolling(b) = True
			PlaySound ("BallRoll_" & b), -1, VolPlayfieldRoll(gBOT(b)) * BallRollVolume * VolumeDial, AudioPan(gBOT(b)), 0, PitchPlayfieldRoll(gBOT(b)), 1, 0, AudioFade(gBOT(b))

		Else
			If rolling(b) = True Then
				StopSound("BallRoll_" & b)
				rolling(b) = False
			End If
		End If

		' Ball Drop Sounds
		If gBOT(b).VelZ < -1 and gBOT(b).z < 55 and gBOT(b).z > 27 Then 'height adjust for ball drop sounds
			If DropCount(b) >= 5 Then
				DropCount(b) = 0
				If gBOT(b).velz > -7 Then
					RandomSoundBallBouncePlayfieldSoft gBOT(b)
				Else
					RandomSoundBallBouncePlayfieldHard gBOT(b)
				End If				
			End If
		End If
		If DropCount(b) < 5 Then
			DropCount(b) = DropCount(b) + 1
		End If

	Next
End Sub


'******************************************************
'****  END BALL ROLLING AND DROP SOUNDS
'******************************************************


'******************************************************
'		STAND-UP TARGET INITIALIZATION
'******************************************************

Class StandupTarget
  Private m_primary, m_prim, m_sw, m_animate, m_bmArray

  Public Property Get Primary(): Set Primary = m_primary: End Property
  Public Property Let Primary(input): Set m_primary = input: End Property

  Public Property Get Prim(): Set Prim = m_prim: End Property
  Public Property Let Prim(input): Set m_prim = input: End Property

  Public Property Get Sw(): Sw = m_sw: End Property
  Public Property Let Sw(input): m_sw = input: End Property

  Public Property Get BMArray(): BMArray = m_bmArray: End Property
  Public Property Let BMArray(input): m_bmArray = input: End Property	

  Public Property Get Animate(): Animate = m_animate: End Property
  Public Property Let Animate(input): m_animate = input: End Property

  Public default Function init(primary, prim, sw, animate, bmArray)
    Set m_primary = primary
    Set m_prim = prim
	m_bmArray = bmArray
    m_sw = sw
    m_animate = animate

    Set Init = Me
  End Function
End Class

'Define a variable for each stand-up target
Dim ST10, ST11, ST12, ST18, ST19, ST20, ST21, ST22, ST23, ST25

'Set array with stand-up target objects
'
'StandupTargetvar = Array(primary, prim, swtich)
' 	primary: 			vp target to determine target hit
'	prim:				primitive target used for visuals and animation
'							IMPORTANT!!! 
'							transy must be used to offset the target animation
'	switch:				ROM switch number
'	animate:			Arrary slot for handling the animation instrucitons, set to 0
' 
'You will also need to add a secondary hit object for each stand up (name sw11o, sw12o, and sw13o on the example Table1)
'these are inclined primitives to simulate hitting a bent target and should provide so z velocity on high speed impacts

Set ST10 = (new StandupTarget)(sw10, BM_sw10, 10, 0, BP_sw10)
Set ST11 = (new StandupTarget)(sw11, BM_sw11, 11, 0, BP_sw11)
Set ST12 = (new StandupTarget)(sw12, BM_sw12, 12, 0, BP_sw12)
Set ST18 = (new StandupTarget)(sw18, BM_sw18, 18, 0, BP_sw18)
Set ST19 = (new StandupTarget)(sw19, BM_sw19, 19, 0, BP_sw19)
Set ST20 = (new StandupTarget)(sw20, BM_sw20, 20, 0, BP_sw20)
Set ST21 = (new StandupTarget)(sw21, BM_sw21, 21, 0, BP_sw21)
Set ST22 = (new StandupTarget)(sw22, BM_sw22, 22, 0, BP_sw22)
Set ST23 = (new StandupTarget)(sw23, BM_sw23, 23, 0, BP_sw23)
Set ST25 = (new StandupTarget)(sw25, BM_sw25, 25, 0, BP_sw25)

'Add all the Stand-up Target Arrays to Stand-up Target Animation Array
' STAnimationArray = Array(ST1, ST2, ....)
Dim STArray
STArray = Array(ST10, ST11, ST12, ST18, ST19, ST20, ST21, ST22, ST23)

'Configure the behavior of Stand-up Targets
Const STAnimStep =  1.5 				'vpunits per animation step (control return to Start)
Const STMaxOffset = 9 			'max vp units target moves when hit

Const STMass = 0.2				'Mass of the Stand-up Target (between 0 and 1), higher values provide more resistance

'******************************************************
'				STAND-UP TARGETS FUNCTIONS
'******************************************************

Sub STHit(switch)
	Dim i
	i = STArrayID(switch)

	PlayTargetSound
	STArray(i).animate =  STCheckHit(Activeball,STArray(i).primary)

	If STArray(i).animate <> 0 Then
		DTBallPhysics Activeball, STArray(i).primary.orientation, STMass
	End If
	DoSTAnim
End Sub

Function STArrayID(switch)
	Dim i
	For i = 0 to uBound(STArray) 
		If STArray(i).sw = switch Then STArrayID = i:Exit Function 
	Next
End Function

'Check if target is hit on it's face
Function STCheckHit(aBall, target) 
	dim bangle, bangleafter, rangle, rangle2, perpvel, perpvelafter, paravel, paravelafter
	rangle = (target.orientation - 90) * 3.1416 / 180	
	bangle = atn2(cor.ballvely(aball.id),cor.ballvelx(aball.id))
	bangleafter = Atn2(aBall.vely,aball.velx)

	perpvel = cor.BallVel(aball.id) * cos(bangle-rangle)
	paravel = cor.BallVel(aball.id) * sin(bangle-rangle)

	perpvelafter = BallSpeed(aBall) * cos(bangleafter - rangle) 
	paravelafter = BallSpeed(aBall) * sin(bangleafter - rangle)

	If perpvel > 0 and  perpvelafter <= 0 Then
		STCheckHit = 1
	ElseIf perpvel > 0 and ((paravel > 0 and paravelafter > 0) or (paravel < 0 and paravelafter < 0)) Then
		STCheckHit = 1
	Else 
		STCheckHit = 0
	End If
End Function

Sub DoSTAnim()
	Dim i
	For i=0 to Ubound(STArray)
		STArray(i).animate = STAnimate(STArray(i).primary,STArray(i).prim,STArray(i).sw,STArray(i).animate, STArray(i).BMArray)
	Next
End Sub

Function STAnimate(primary, prim, switch, animate, bmArray)
	Dim animtime

	STAnimate = animate

	if animate = 0  Then
		primary.uservalue = 0
		STAnimate = 0
		Exit Function
	Elseif primary.uservalue = 0 then 
		primary.uservalue = gametime
	end if

	animtime = gametime - primary.uservalue
	Dim el
	If animate = 1 Then
		primary.collidable = 0
		prim.transy = -STMaxOffset
		For Each el in bmArray : el.transy = prim.transy: Next
		'vpmTimer.PulseSw switch
		STAnimate = 2
		Exit Function
	elseif animate = 2 Then
		prim.transy = prim.transy + STAnimStep
		If prim.transy >= 0 Then
			prim.transy = 0
			For Each el in bmArray : el.transy =0 : Next
			primary.collidable = 1
			STAnimate = 0
			Exit Function
		Else 
			For Each el in bmArray : el.transy = prim.transy : Next
			STAnimate = 2
		End If
	End If	
End Function

Sub DTBallPhysics(aBall, angle, mass)
	dim rangle,bangle,calc1, calc2, calc3
	rangle = (angle - 90) * 3.1416 / 180
	bangle = atn2(cor.ballvely(aball.id),cor.ballvelx(aball.id))

	calc1 = cor.BallVel(aball.id) * cos(bangle - rangle) * (aball.mass - mass) / (aball.mass + mass)
	calc2 = cor.BallVel(aball.id) * sin(bangle - rangle) * cos(rangle + 4*Atn(1)/2)
	calc3 = cor.BallVel(aball.id) * sin(bangle - rangle) * sin(rangle + 4*Atn(1)/2)

	aBall.velx = calc1 * cos(rangle) + calc2
	aBall.vely = calc1 * sin(rangle) + calc3
End Sub

'******************************************************
'		END STAND-UP TARGETS
'******************************************************



dim lastimeupdate, period
lastimeupdate = gametime

Sub GameTimer_timer()
	period = gametime - lastimeupdate
	lastimeupdate = gametime
	DoSTAnim						'handle stand up target animations
	'RollingUpdate
	'cor.update
	Options_UpdateDMD
	TargetMovableHelper
	Dim el
	BM_Disc.RotZ = (BM_Disc.RotZ + (ttSpinner.Speed/4)) Mod 360
	For Each el in BP_Disc
		el.Rotz = BM_Disc.RotZ	
	Next
End Sub

Sub FrameTimer_Timer()
	'BSUpdate
End Sub

Sub TargetMovableHelper
	Exit Sub
	Dim t
	For each t in BP_sw10 : t.transy = BM_sw10.transy : Next

	For each t in BP_sw11 : t.transy = BM_sw11.transy : Next

	For each t in BP_sw12 : t.transy = BM_sw12.transy : Next

	For each t in BP_sw18 : t.transy = BM_sw18.transy : Next

	For each t in BP_sw19 : t.transy = BM_sw19.transy : Next

	For each t in BP_sw20 : t.transy = BM_sw20.transy : Next

	For each t in BP_sw21 : t.transy = BM_sw21.transy : Next

	For each t in BP_sw22 : t.transy = BM_sw22.transy : Next

	For each t in BP_sw23 : t.transy = BM_sw23.transy : Next

	For each t in BP_sw25 : t.transy = BM_sw25.transy : Next

End Sub

'***********************************************************************************************************************
'*****  TABLE KEYS                                            	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim bFlippersPressed : bFlippersPressed = False

Sub Table1_KeyDown(ByVal Keycode)

    If keycode = LeftFlipperKey Then
        VRFlipperLeft.X = VRFlipperLeft.X + 10
    End if
    If keycode = RightFlipperKey Then
        VRFlipperRight.X = VRFlipperRight.X - 10
    End if

    If bInOptions Then
		Options_KeyDown keycode
		Exit Sub
	End If
	If keycode = LeftMagnaSave Then
		If bOptionsMagna Then Options_Open() Else bOptionsMagna = True
    ElseIf keycode = RightMagnaSave Then
		If bOptionsMagna Then Options_Open() Else bOptionsMagna = True
	End If


    'If keycode = 46 then ' C Key
    '    If contball = 1 Then
    '        contball = 0
    '    Else
    '        contball = 1
    '    End If
    'End If
    'if keycode = 203 then bcleft = 1 ' Left Arrow
    'if keycode = 200 then bcup = 1 ' Up Arrow
    'if keycode = 208 then bcdown = 1 ' Down Arrow
    'if keycode = 205 then bcright = 1 ' Right Arrow
   

    If gameStarted = False Then
        If keycode = StartGameKey And gameBooted = True Then
            playerState.RemoveAll()
            AddPlayer()
            StartGame()
        End If
    Else
        If GAME_DRAIN_BALLS_AND_RESET = True Or GameTilted = True Then
            Exit Sub
        End If

        If GameTimers(GAME_BONUS_TIMER_IDX) > 0 Then 
            
            If keycode = LeftFlipperKey Then
                LFlipperDown = True   
                If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
            End If
            
            If keycode = RightFlipperKey Then 
                RFlipperDown = True
                If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
            End If    
            
            Exit Sub 
        End If
        
        
        If keycode = StartGameKey Then
            AddPlayer()
        End If
        If keycode = StartGameKey Then
            DispatchPinEvent SWITCH_START_GAME_KEY
        End If
        If keycode = PlungerKey Then
            PlaySoundAt "Plunger_Pull_1", Plunger
            Plunger.Pullback
        End If
    
        If keycode = LeftTiltKey Then Nudge 90, 2: SoundNudgeLeft : CheckTilt
        If keycode = RightTiltKey Then Nudge 270, 2: SoundNudgeRight : CheckTilt
        If keycode = CenterTiltKey Then Nudge 0, 3: SoundNudgeCenter : CheckTilt
        
        If keycode = MechanicalTilt Then 
            SoundNudgeCenter
            CheckMechTilt
        End If

        If(keycode = PlungerKey OR keycode = Lockbarkey) Then
            DispatchPinEvent(SWITCH_SELECT_EVENT_KEY)
        End If

        If keycode = LeftFlipperKey Then
            LFlipperDown = True
            DOF 101,DOFOn
            If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
            FlipperActivate LeftFlipper,LFPress
            LF.Fire    
            If LeftFlipper.currentangle < LeftFlipper.endangle + ReflipAngle Then 
                RandomSoundReflipUpLeft LeftFlipper
            Else 
                SoundFlipperUpAttackLeft LeftFlipper
                RandomSoundFlipperUpLeft LeftFlipper
            End If
            DispatchPinEvent(SWITCH_LEFT_FLIPPER_DOWN)
        End If
        
        If keycode = RightFlipperKey Then 
            'UpRightFlipper.RotateToEnd
            FlipperActivate RightFlipper, RFPress
            RF.Fire
            RFlipperDown = True
            DOF 102,DOFOn
            If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
			If StagedFlipperMod <> 1 Then
				UpRightFlipper.RotateToEnd
			End If
            If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then
                RandomSoundReflipUpRight RightFlipper
            Else 
                SoundFlipperUpAttackRight RightFlipper
                RandomSoundFlipperUpRight RightFlipper
            End If
            DispatchPinEvent(SWITCH_RIGHT_FLIPPER_DOWN)
        End If

	    If StagedFlipperMod = 1 Then
            If keycode = 40 Then 
                UpRightFlipper.RotateToEnd
                If UpRightFlipper.currentangle > UpRightFlipper.endangle - ReflipAngle Then
                    RandomSoundReflipUpRight UpRightFlipper
                Else 
                    SoundFlipperUpAttackRight UpRightFlipper
                    RandomSoundFlipperUpRight UpRightFlipper
                End If
            End If
        End If
    End If    
End Sub


Sub Table1_KeyUp(ByVal keycode)
    
    If keycode = LeftFlipperKey Then
        VRFlipperLeft.X = VRFlipperLeft.X - 10
    End if
    If keycode = RightFlipperKey Then
        VRFlipperRight.X = VRFlipperRight.X + 10
    End if

    If keycode = LeftMagnaSave And Not bInOptions Then bOptionsMagna = False
    If keycode = RightMagnaSave And Not bInOptions Then bOptionsMagna = False


    if keycode = 203 then bcleft = 0 ' Left Arrow
    if keycode = 200 then bcup = 0 ' Up Arrow
    if keycode = 208 then bcdown = 0 ' Down Arrow
    if keycode = 205 then bcright = 0 ' Right Arrow

    'If gameStarted = True Then
        If keycode = PlungerKey Then
            PlaySoundAt "Plunger_Release_Ball", Plunger
            Plunger.Fire
        End If
        
        If keycode = LeftFlipperKey Then
            DOF 101,DOFOff
            LFlipperDown = False
            FlipperDeActivate LeftFlipper, LFPress
            LeftFlipper.RotateToStart
            If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
                RandomSoundFlipperDownLeft LeftFlipper
            End If
            FlipperLeftHitParm = FlipperUpSoundLevel
            DispatchPinEvent(SWITCH_LEFT_FLIPPER_UP)
        End If
        If keycode = RightFlipperKey Then
            DOF 102,DOFOff
            RFlipperDown = False
            FlipperDeActivate RightFlipper, RFPress
            RightFlipper.RotateToStart
			If StagedFlipperMod <> 1 Then
				UpRightFlipper.RotateToStart
				End If
            End If	
            If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
                RandomSoundFlipperDownRight RightFlipper
            FlipperRightHitParm = FlipperUpSoundLevel
            DispatchPinEvent(SWITCH_RIGHT_FLIPPER_UP)
        End If
	If StagedFlipperMod = 1 Then
        If keycode = 40 Then
            UpRightFlipper.RotateToStart
            If UpRightFlipper.currentangle > UpRightFlipper.startAngle + 5 Then
                RandomSoundFlipperDownRight UpRightFlipper
            End If	
        End If
    End If
End Sub

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  NFOZZY                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


'******************************************************
'****  GNEREAL ADVICE ON PHYSICS
'******************************************************
'
' It's advised that flipper corrections, dampeners, and general physics settings should all be updated per these 
' examples as all of these improvements work together to provide a realistic physics simulation.
'
' Tutorial videos provided by Bord
' Flippers: 	https://www.youtube.com/watch?v=FWvM9_CdVHw
' Dampeners: 	https://www.youtube.com/watch?v=tqsxx48C6Pg
' Physics: 		https://www.youtube.com/watch?v=UcRMG-2svvE
'
'
' Note: BallMass must be set to 1. BallSize should be set to 50 (in other words the ball radius is 25) 
'
' Recommended Table Physics Settings
' | Gravity Constant             | 0.97      |
' | Playfield Friction           | 0.15-0.25 |
' | Playfield Elasticity         | 0.25      |
' | Playfield Elasticity Falloff | 0         |
' | Playfield Scatter            | 0         |
' | Default Element Scatter      | 2         |
'
' Bumpers
' | Force         | 9.5-10.5 |
' | Hit Threshold | 1.6-2    |
' | Scatter Angle | 2        |
' 
' Slingshots
' | Hit Threshold      | 2    |
' | Slingshot Force    | 4-5  |
' | Slingshot Theshold | 2-3  |
' | Elasticity         | 0.85 |
' | Friction           | 0.8  |
' | Scatter Angle      | 1    |



'******************************************************
'****  FLIPPER CORRECTIONS by nFozzy
'******************************************************
'
' There are several steps for taking advantage of nFozzy's flipper solution.  At a high level well need the following:
'	1. flippers with specific physics settings
'	2. custom triggers for each flipper (TriggerLF, TriggerRF)
'	3. an object or point to tell the script where the tip of the flipper is at rest (EndPointLp, EndPointRp)
'	4. and, special scripting
'
' A common mistake is incorrect flipper length.  A 3-inch flipper with rubbers will be about 3.125 inches long.  
' This translates to about 147 vp units.  Therefore, the flipper start radius + the flipper length + the flipper end 
' radius should  equal approximately 147 vp units. Another common mistake is is that sometimes the right flipper
' angle was set with a large postive value (like 238 or something). It should be using negative value (like -122).
'
' The following settings are a solid starting point for various eras of pinballs.
' |                    | EM's           | late 70's to mid 80's | mid 80's to early 90's | mid 90's and later |
' | ------------------ | -------------- | --------------------- | ---------------------- | ------------------ |
' | Mass               | 1              | 1                     | 1                      | 1                  |
' | Strength           | 500-1000 (750) | 1400-1600 (1500)      | 2000-2600              | 3200-3300 (3250)   |
' | Elasticity         | 0.88           | 0.88                  | 0.88                   | 0.88               |
' | Elasticity Falloff | 0.15           | 0.15                  | 0.15                   | 0.15               |
' | Fricition          | 0.8-0.9        | 0.9                   | 0.9                    | 0.9                |
' | Return Strength    | 0.11           | 0.09                  | 0.07                   | 0.055              |
' | Coil Ramp Up       | 2.5            | 2.5                   | 2.5                    | 2.5                |
' | Scatter Angle      | 0              | 0                     | 0                      | 0                  |
' | EOS Torque         | 0.3            | 0.3                   | 0.275                  | 0.275              |
' | EOS Torque Angle   | 4              | 4                     | 6                      | 6                  |
'


'******************************************************
' Flippers Polarity (Select appropriate sub based on era) 
'******************************************************

dim LF : Set LF = New FlipperPolarity
dim RF : Set RF = New FlipperPolarity

InitPolarity

'
''*******************************************
'' Late 70's to early 80's
'
'Sub InitPolarity()
'        dim x, a : a = Array(LF, RF)
'        for each x in a
'                x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
'                x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
'                x.enabled = True
'                x.TimeDelay = 80
'        Next
'
'        AddPt "Polarity", 0, 0, 0
'        AddPt "Polarity", 1, 0.05, -2.7        
'        AddPt "Polarity", 2, 0.33, -2.7
'        AddPt "Polarity", 3, 0.37, -2.7        
'        AddPt "Polarity", 4, 0.41, -2.7
'        AddPt "Polarity", 5, 0.45, -2.7
'        AddPt "Polarity", 6, 0.576,-2.7
'        AddPt "Polarity", 7, 0.66, -1.8
'        AddPt "Polarity", 8, 0.743, -0.5
'        AddPt "Polarity", 9, 0.81, -0.5
'        AddPt "Polarity", 10, 0.88, 0
'
'        addpt "Velocity", 0, 0,         1
'        addpt "Velocity", 1, 0.16, 1.06
'        addpt "Velocity", 2, 0.41,         1.05
'        addpt "Velocity", 3, 0.53,         1'0.982
'        addpt "Velocity", 4, 0.702, 0.968
'        addpt "Velocity", 5, 0.95,  0.968
'        addpt "Velocity", 6, 1.03,         0.945
'
'        LF.Object = LeftFlipper        
'        LF.EndPoint = EndPointLp
'        RF.Object = RightFlipper
'        RF.EndPoint = EndPointRp
'End Sub
'
'
'
''*******************************************
'' Mid 80's
'
'Sub InitPolarity()
'        dim x, a : a = Array(LF, RF)
'        for each x in a
'                x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
'                x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
'                x.enabled = True
'                x.TimeDelay = 80
'        Next
'
'        AddPt "Polarity", 0, 0, 0
'        AddPt "Polarity", 1, 0.05, -3.7        
'        AddPt "Polarity", 2, 0.33, -3.7
'        AddPt "Polarity", 3, 0.37, -3.7
'        AddPt "Polarity", 4, 0.41, -3.7
'        AddPt "Polarity", 5, 0.45, -3.7 
'        AddPt "Polarity", 6, 0.576,-3.7
'        AddPt "Polarity", 7, 0.66, -2.3
'        AddPt "Polarity", 8, 0.743, -1.5
'        AddPt "Polarity", 9, 0.81, -1
'        AddPt "Polarity", 10, 0.88, 0
'
'        addpt "Velocity", 0, 0,         1
'        addpt "Velocity", 1, 0.16, 1.06
'        addpt "Velocity", 2, 0.41,         1.05
'        addpt "Velocity", 3, 0.53,         1'0.982
'        addpt "Velocity", 4, 0.702, 0.968
'        addpt "Velocity", 5, 0.95,  0.968
'        addpt "Velocity", 6, 1.03,         0.945
'
'        LF.Object = LeftFlipper        
'        LF.EndPoint = EndPointLp
'        RF.Object = RightFlipper
'        RF.EndPoint = EndPointRp
'End Sub
'
'


'*******************************************
'  Late 80's early 90's

'Sub InitPolarity()
'	dim x, a : a = Array(LF, RF)
'	for each x in a
'		x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
'		x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1
'		x.enabled = True
'		x.TimeDelay = 60
'	Next
'
'	AddPt "Polarity", 0, 0, 0
'	AddPt "Polarity", 1, 0.05, -5
'	AddPt "Polarity", 2, 0.4, -5
'	AddPt "Polarity", 3, 0.6, -4.5
'	AddPt "Polarity", 4, 0.65, -4.0
'	AddPt "Polarity", 5, 0.7, -3.5
'	AddPt "Polarity", 6, 0.75, -3.0
'	AddPt "Polarity", 7, 0.8, -2.5
'	AddPt "Polarity", 8, 0.85, -2.0
'	AddPt "Polarity", 9, 0.9,-1.5
'	AddPt "Polarity", 10, 0.95, -1.0
'	AddPt "Polarity", 11, 1, -0.5
'	AddPt "Polarity", 12, 1.1, 0
'	AddPt "Polarity", 13, 1.3, 0
'
'	addpt "Velocity", 0, 0,         1
'	addpt "Velocity", 1, 0.16, 1.06
'	addpt "Velocity", 2, 0.41,         1.05
'	addpt "Velocity", 3, 0.53,         1'0.982
'	addpt "Velocity", 4, 0.702, 0.968
'	addpt "Velocity", 5, 0.95,  0.968
'	addpt "Velocity", 6, 1.03,         0.945
'
'	LF.Object = LeftFlipper        
'	LF.EndPoint = EndPointLp
'	RF.Object = RightFlipper
'	RF.EndPoint = EndPointRp
'End Sub



'
''*******************************************
'' Early 90's and after
'
Sub InitPolarity()
        dim x, a : a = Array(LF, RF)
        for each x in a
                x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1        'disabled
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

        addpt "Velocity", 0, 0,         1
        addpt "Velocity", 1, 0.16, 1.06
        addpt "Velocity", 2, 0.41,         1.05
        addpt "Velocity", 3, 0.53,         1'0.982
        addpt "Velocity", 4, 0.702, 0.968
        addpt "Velocity", 5, 0.95,  0.968
        addpt "Velocity", 6, 1.03,         0.945

		LF.Object = LeftFlipper        
        LF.EndPoint = EndPointLp
        RF.Object = RightFlipper
        RF.EndPoint = EndPointRp
End Sub


' Flipper trigger hit subs
Sub TriggerLF_Hit() : LF.Addball activeball : End Sub
Sub TriggerLF_UnHit() : LF.PolarityCorrect activeball : End Sub
Sub TriggerRF_Hit() : RF.Addball activeball : End Sub
Sub TriggerRF_UnHit() : RF.PolarityCorrect activeball : End Sub




'******************************************************
'  FLIPPER CORRECTION FUNCTIONS
'******************************************************

Sub AddPt(aStr, idx, aX, aY)        'debugger wrapper for adjusting flipper script in-game
	dim a : a = Array(LF, RF)
	dim x : for each x in a
		x.addpoint aStr, idx, aX, aY
	Next
End Sub

Class FlipperPolarity
	Public DebugOn, Enabled
	Private FlipAt        'Timer variable (IE 'flip at 723,530ms...)
	Public TimeDelay        'delay before trigger turns off and polarity is disabled TODO set time!
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

	Public Sub Report(aChooseArray)         'debug, reports all coords in tbPL.text
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
	Private Function FlipperOn() : if gameTime < FlipAt+TimeDelay then FlipperOn = True : End If : End Function        'Timer shutoff for polaritycorrect

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
					if ballpos > 0.65 then  Ycoef = LinearEnvelope(BallData(x).Y, YcoefIn, YcoefOut)                                'find safety coefficient 'ycoef' data
				end if
			Next

			If BallPos = 0 Then 'no ball data meaning the ball is entering and exiting pretty close to the same position, use current values.
				BallPos = PSlope(aBall.x, FlipperStart, 0, FlipperEnd, 1)
				if ballpos > 0.65 then  Ycoef = LinearEnvelope(aBall.Y, YcoefIn, YcoefOut)                                                'find safety coefficient 'ycoef' data
			End If

			'Velocity correction
			if not IsEmpty(VelocityIn(0) ) then
				Dim VelCoef
				VelCoef = LinearEnvelope(BallPos, VelocityIn, VelocityOut)

				if partialflipcoef < 1 then VelCoef = PSlope(partialflipcoef, 0, 1, 1, VelCoef)

				if Enabled then aBall.Velx = aBall.Velx*VelCoef
				if Enabled then aBall.Vely = aBall.Vely*VelCoef
			End If

			'Polarity Correction (optional now)
			if not IsEmpty(PolarityIn(0) ) then
				If StartPoint > EndPoint then LR = -1        'Reverse polarity if left flipper
				dim AddX : AddX = LinearEnvelope(BallPos, PolarityIn, PolarityOut) * LR

				if Enabled then aBall.VelX = aBall.VelX + 1 * (AddX*ycoef*PartialFlipcoef)
			End If
		End If
		RemoveBall aBall
	End Sub
End Class

'******************************************************
'  FLIPPER POLARITY AND RUBBER DAMPENER SUPPORTING FUNCTIONS 
'******************************************************

' Used for flipper correction and rubber dampeners
Sub ShuffleArray(ByRef aArray, byVal offset) 'shuffle 1d array
	dim x, aCount : aCount = 0
	redim a(uBound(aArray) )
	for x = 0 to uBound(aArray)        'Shuffle objects in a temp array
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
	redim aArray(aCount-1+offset)        'Resize original array
	for x = 0 to aCount-1                'set objects back into original array
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
Function PSlope(Input, X1, Y1, X2, Y2)        'Set up line via two points, no clamping. Input X, output Y
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
	dim ii : for ii = 1 to uBound(xKeyFrame)        'find active line
		if xInput <= xKeyFrame(ii) then L = ii : exit for : end if
	Next
	if xInput > xKeyFrame(uBound(xKeyFrame) ) then L = uBound(xKeyFrame)        'catch line overrun
	Y = pSlope(xInput, xKeyFrame(L-1), yLvl(L-1), xKeyFrame(L), yLvl(L) )

	if xInput <= xKeyFrame(lBound(xKeyFrame) ) then Y = yLvl(lBound(xKeyFrame) )         'Clamp lower
	if xInput >= xKeyFrame(uBound(xKeyFrame) ) then Y = yLvl(uBound(xKeyFrame) )        'Clamp upper

	LinearEnvelope = Y
End Function


'******************************************************
'  FLIPPER TRICKS 
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
	Dim b, BOT
	BOT = GetBalls

	If Flipper1.currentangle = Endangle1 and EOSNudge1 <> 1 Then
		EOSNudge1 = 1
		'debug.print Flipper1.currentangle &" = "& Endangle1 &"--"& Flipper2.currentangle &" = "& EndAngle2
		If Flipper2.currentangle = EndAngle2 Then 
			For b = 0 to Ubound(BOT)
				If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper1) Then
					'Debug.Print "ball in flip1. exit"
					exit Sub
				end If
			Next
			For b = 0 to Ubound(BOT)
				If FlipperTrigger(BOT(b).x, BOT(b).y, Flipper2) Then
					BOT(b).velx = BOT(b).velx / 1.3
					BOT(b).vely = BOT(b).vely - 0.5
				end If
			Next
		End If
	Else 
		If Abs(Flipper1.currentangle) > Abs(EndAngle1) + 30 then EOSNudge1 = 0
	End If
End Sub

'*****************
' Maths
'*****************
Dim PI : PI = 4*Atn(1)

Function dSin(degrees)
	dsin = sin(degrees * Pi/180)
End Function

Function dCos(degrees)
	dcos = cos(degrees * Pi/180)
End Function

Function Atn2(dy, dx)
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

'*************************************************
'  Check ball distance from Flipper for Rem
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
'  End - Check ball distance from Flipper for Rem
'*************************************************

dim LFPress, RFPress, LFCount, RFCount
dim LFState, RFState
dim EOST, EOSA,Frampup, FElasticity,FReturn
dim RFEndAngle, LFEndAngle

Const FlipperCoilRampupMode = 0 '0 = fast, 1 = medium, 2 = slow (tap passes should work)

LFState = 1
RFState = 1
EOST = leftflipper.eostorque
EOSA = leftflipper.eostorqueangle
Frampup = LeftFlipper.rampup
FElasticity = LeftFlipper.elasticity
FReturn = LeftFlipper.return
'Const EOSTnew = 1 'EM's to late 80's
Const EOSTnew = 0.8 '90's and later
Const EOSAnew = 1
Const EOSRampup = 0
Dim SOSRampup
Select Case FlipperCoilRampupMode 
	Case 0:
		SOSRampup = 2.5
	Case 1:
		SOSRampup = 6
	Case 2:
		SOSRampup = 8.5
End Select

Const LiveCatch = 16
Const LiveElasticity = 0.45
Const SOSEM = 0.815
'Const EOSReturn = 0.055  'EM's
'Const EOSReturn = 0.045  'late 70's to mid 80's
Const EOSReturn = 0.035  'mid 80's to early 90's
'Const EOSReturn = 0.025  'mid 90's and later

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
		Dim b, BOT
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
	Dir = Flipper.startangle/Abs(Flipper.startangle)        '-1 for Right Flipper

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
	Dim LiveCatchBounce                                                                                                                        'If live catch is not perfect, it won't freeze ball totally
	Dim CatchTime : CatchTime = GameTime - FCount

	if CatchTime <= LiveCatch and parm > 6 and ABS(Flipper.x - ball.x) > LiveDistanceMin and ABS(Flipper.x - ball.x) < LiveDistanceMax Then
		if CatchTime <= LiveCatch*0.5 Then                                                'Perfect catch only when catch time happens in the beginning of the window
			LiveCatchBounce = 0
		else
			LiveCatchBounce = Abs((LiveCatch/2) - CatchTime)        'Partial catch when catch happens a bit late
		end If

		If LiveCatchBounce = 0 and ball.velx * Dir > 0 Then ball.velx = 0
		ball.vely = LiveCatchBounce * (32 / LiveCatch) ' Multiplier for inaccuracy bounce
		ball.angmomx= 0
		ball.angmomy= 0
		ball.angmomz= 0
    Else
        If Abs(Flipper.currentangle) <= Abs(Flipper.endangle) + 1 Then FlippersD.Dampenf Activeball, parm
	End If
End Sub


'******************************************************
'****  END FLIPPER CORRECTIONS
'******************************************************

Const ReflipAngle = 20

' Flipper collide subs
Sub LeftFlipper_Collide(parm)
	CheckLiveCatch Activeball, LeftFlipper, LFCount, parm
	LeftFlipperCollide parm
End Sub

Sub RightFlipper_Collide(parm)
	CheckLiveCatch Activeball, RightFlipper, RFCount, parm
	RightFlipperCollide parm
End Sub

Sub FlipperVisualUpdate
	Dim el
	For Each el in BP_FlipperR
		el.Rotz = RightFlipper.currentangle
	Next
	For Each el in BP_FlipperL
		el.Rotz = LeftFlipper.currentangle
	Next
	For Each el in BP_FlipperU
		el.Rotz = UpRightFlipper.currentangle
	Next
End Sub

Function Gray2RGB(gray)
	if gray < 0 then gray = 0
	if gray > 255 Then gray = 255
	Gray2RGB = RGB(gray, gray, gray)
End Function





'######################### Add new FlippersD Profile
'#########################    Adjust these values to increase or lessen the elasticity




'*****************************************************************************************************
'*******************************************************************************************************
'END nFOZZY FLIPPERS'

'********************************************
' ZTLT : Tilt
'********************************************

'NOTE: The TiltDecreaseTimer Subtracts .01 from the "Tilt" variable every round
Sub CheckTilt                                    	'Called when table is nudged
	If Not gameStarted Then Exit Sub
	Tilt = Tilt + TiltSensitivity                	'Add to tilt count
	TiltDecreaseTimer.Enabled = True
	If(Tilt > TiltSensitivity) AND (Tilt <= 15) Then ShowTiltWarning 'show a warning
	If Tilt > 15 Then TiltMachine  					'If more than 15 then TILT the table
End Sub

Sub CheckMechTilt                                	'Called when mechanical tilt bob switch closed
	If Not gameStarted Then Exit Sub
	If Not bMechTiltJustHit Then
		MechTilt = MechTilt + 1               		'Add to tilt count
		If(MechTilt > 0) AND (MechTilt <= 2) Then ShowTiltWarning 'show a warning
		If MechTilt > 2 Then TiltMachine  			'If more than 2 then TILT the table
		bMechTiltJustHit = True
        Debounce "mechTilt", "TimerMechTilt", 3000
	End If
End Sub

Sub TimerMechTilt
	bMechTiltJustHit = False
End Sub

Sub ShowTiltWarning
    FlexTiltWarningScene()
End Sub

Sub TiltMachine
    DmdQ.RemoveAll()
    lightCtrl.PauseMainLights()
    GameTilted = True
    MusicOff
    CancelBallSaver()
    FlexTiltScene()
End Sub

Sub TiltDecreaseTimer_Timer
	' DecreaseTilt
	If Tilt> 0 Then
		Tilt = Tilt - 0.1
	Else
		TiltDecreaseTimer.Enabled = False
	End If
End Sub

'***********************************************************************************************************************
'*****   Utility Functions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function Min(value, minVal)
	if value < minVal then
		Min=Value
	Else 
		Min=minVal
	End If 
End Function

Function FormatScore2(ByVal Num) 'it returns a string with commas
    dim i
    dim NumString

    NumString = CStr(abs(Num))

	If NumString = "0" Then
		NumString = "00"
	Else
		For i = Len(NumString)-3 to 1 step -3
			if IsNumeric(mid(NumString, i, 1))then
				NumString = left(NumString, i) & "," & right(NumString, Len(NumString)-i)
			end if
		Next
	End If
    FormatScore2 = NumString
End function

Function BallsOnBridge()
	Dim lockPinsUp : lockPinsUp = 0
    If LockPin1.IsDropped = 0 Then
        lockPinsUp=lockPinsUp+1
    End If
    If LockPin2.IsDropped = 0 Then
        lockPinsUp=lockPinsUp+1
    End If
    If LockPin3.IsDropped = 0 Then
        lockPinsUp=lockPinsUp+1
    End If
	BallsOnBridge = lockPinsUp
End Function

Function RealBallsInPlay()
	RealBallsInPlay = (5-BallsInTrough) - BallsOnBridge()
    'Debug.print((5-BallsInTrough) - BallsOnBridge())
End Function

Function FlattenArrays(arrays)
    Dim resultArray()
    Dim i, j, totalSize
    totalSize = 0

    ' Calculate total size for the resultant array
    For i = 0 To UBound(arrays)
        totalSize = totalSize + UBound(arrays(i)) - LBound(arrays(i)) + 1
    Next

    ' Resize the resultant array
    ReDim resultArray(totalSize - 1)

    Dim currentIndex
    currentIndex = 0

    ' Iterate over each array and copy its elements to the resultArray
    For i = 0 To UBound(arrays)
        For j = LBound(arrays(i)) To UBound(arrays(i))
            resultArray(currentIndex) = arrays(i)(j)
            currentIndex = currentIndex + 1
        Next
    Next

    FlattenArrays = resultArray
End Function
Class QueueItem
    Public Name
    Public Duration
    public Action
    public BGImage
    public BGVideo
    public Callback
    public Label1
    public Label2
    public Label3
    public Label4
    public Label5
    public Label6
    public Label7
    public Replacements
    private LabelIdx

    Private Sub Class_Initialize()
        Callback = Null
        Label1 = Null
        Label2 = Null
        Label3 = Null
        Label4 = Null
        Label5 = Null
        Label6 = Null
        Label7 = Null
        Replacements = Null
        LabelIdx = 1
        Action = ""
    End Sub

    Public Sub AddLabel(msg, font, sposX, sposY, eposX, eposY, action)
        If LabelIdx = 8 Then Exit Sub
        Dim params : params = Array(msg, font, sposX, sposY, eposX, eposY, action)
        Select Case LabelIdx
			Case 1:
                Label1 = params
            Case 2:
                Label2 = params
            Case 3:
                Label3 = params
            Case 4:
                Label4 = params
            Case 5:
                Label5 = params
            Case 6:
                Label6 = params
            Case 7:
                Label7 = params
        End Select
        LabelIdx = LabelIdx + 1
    End Sub

   Public Function GetLabel(LabelIdx)
       GetLabel = Null
       Select Case LabelIdx
          Case 1:
             If Not IsNull(Label1) Then
                GetLabel = Label1
             End If
          Case 2:
             If Not IsNull(Label2) Then
                GetLabel = Label2
             End If
          Case 3:
             If Not IsNull(Label3) Then
                GetLabel = Label3
             End If
          Case 4:
             If Not IsNull(Label4) Then
                GetLabel = Label4
             End If
          Case 5:
             If Not IsNull(Label5) Then
                GetLabel = Label5
             End If
          Case 6:
             If Not IsNull(Label6) Then
                GetLabel = Label6
             End If
          Case 7:
             If Not IsNull(Label7) Then
                GetLabel = Label7
             End If
        End Select
    End Function
End Class

Class Queue
    Private Items
    Private CurrentItem
    Private PreviousItemExecutedTime
    private Frame
    private CurrentMSGdone
    private DMD_slide
    public FlexDMDItem
    public FlexDMDOverlayAssets

    Private Sub Class_Initialize()
        Set Items = CreateObject("Scripting.Dictionary")
        Frame = 0
    End Sub

    Public Sub Enqueue(queueItem)
        'queueItem.Action = ""
        'queueItem.BGVideo = "novideo"
        If Items.Exists(queueItem.Name) Then
            Dim item : Set item = Items(queueItem.Name)
            item.Duration = queueItem.Duration
            item.Action = queueItem.Action
            item.callback = queueItem.Callback
            item.Replacements = queueItem.Replacements
            item.Label1 = queueItem.Label1
            item.Label2 = queueItem.Label2
            item.Label3 = queueItem.Label3
            item.Label4 = queueItem.Label4
            item.Label5 = queueItem.Label5
            item.Label6 = queueItem.Label6
            item.Label7 = queueItem.Label7
            If IsObject(CurrentItem) Then
				If item.Name = CurrentItem.Name Then
					If CurrentItem.BGImage <> "noimage"  Then FlexDMDItem.Stage.GetImage(CurrentItem.BGImage).Visible = False
					If CurrentItem.BGVideo <> "novideo" Then FlexDMDItem.Stage.GetVideo(CurrentItem.BGVideo).Visible = False
					item.BGImage = queueItem.BGImage
					item.BGVideo = queueItem.BGVideo
					If CurrentItem.BGImage  <> "noimage" Then FlexDMDItem.Stage.GetImage(CurrentItem.BGImage).Visible=True : FlexDMDItem.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
					If CurrentItem.BGVideo <> "novideo" Then FlexDMDItem.Stage.GetVideo(CurrentItem.BGVideo).Visible=True : FlexDMDItem.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide
				End If
            Else
                item.BGImage = queueItem.BGImage
                item.BGVideo = queueItem.BGVideo
            End If
        Else
            Items.Add queueItem.Name, queueItem
        End If
    End Sub

    Public Function GetCurrentItem()
        GetCurrentItem = CurrentItem
    End Function

    Public Sub RemoveAll()
        DMDResetAll()
        Items.RemoveAll()
        CurrentItem = Null
    End Sub

    Public Sub Dequeue(name)
        If Items.Exists(name) Then
            If IsObject(CurrentItem) Then
                If CurrentItem.Name = name Then
                    Items.Remove CurrentItem.Name
                    DMDResetAll()
                    CurrentItem = Null
                Else
                    Items.Remove name
                End If
            Else
                Items.Remove name
            End If
        End If
    End Sub

    Public Sub Update()

        frame=frame+1
        If IsObject(CurrentItem) Then
            If gameTime >= (PreviousItemExecutedTime+(CurrentItem.Duration*1000)) Then
                DMDSlideOff
            Else
                DMDUpdate
            End If
        End If

        If Not IsObject(CurrentItem) And Items.Count > 0 Then
            Dim mItems : mItems = Items.Items()
            Set CurrentItem = mItems(0)
            PreviousItemExecutedTime = gameTime
            If Not IsNull(CurrentItem.Callback) Then
                GetRef(CurrentItem.Callback)()
            End If
            DMDResetAll
            DMDNewOverlay
        End If
            
    End Sub

    Public Sub DMDUpdate

        dim tmp, flabel
        if CurrentItem.Action = "slidedown" Then
            If DMD_Slide > 0 Then DMD_slide = DMD_slide - 2
        End If
        if CurrentItem.Action = "slideup" Then
            If DMD_Slide < 0 Then DMD_slide = DMD_slide + 2
        End If

        If CurrentItem.BGImage <> "noimage"  Then FlexDMDItem.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
        If CurrentItem.BGVideo <> "novideo" Then FlexDMDItem.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide

        Dim i
         For i = 1 to 7
             
             dim label : label = CurrentItem.GetLabel(i)
            If Not IsNull(label) Then

                Set flabel = FlexDMDItem.Stage.GetLabel("TextSmalLine" & CStr(i))
                flabel.Font = label(1)
                flabel.visible = True
                flabel.Text = label(0)
                If InStr(1, label(0), "$") > 0 Then
                    Dim x
                    debug.print(CurrentItem.Name)
                    For x=0 To UBound(CurrentItem.Replacements)
                        If InStr(1, label(0), "$"&x+1) > 0 Then
                            flabel.Text = Replace(flabel.Text, "$"&x+1, GetRef(CurrentItem.Replacements(x))())
                        End If
                    Next
                End If

                If label(6) = "blink" Then ' blinking
                    If frame mod 30 > 15 Then
                        flabel.visible = False
                    Else
                        flabel.visible = True
                    End If
                End If

                If label(2) < label(4) Then label(2) = label(2) + 1
                If label(2) > label(4) Then label(2) = label(2) - 1
                If label(3) < label(5) Then label(3) = label(3) + 1
                If label(3) > label(5) Then label(3) = label(3) - 1
                

                Select Case i
                    Case 1:
                        CurrentItem.Label1(2) = label(2)
                        CurrentItem.Label1(3) = label(3)
                    Case 2:
                        CurrentItem.Label2(2) = label(2)
                        CurrentItem.Label2(3) = label(3)
                    Case 3:
                        CurrentItem.Label3(2) = label(2)
                        CurrentItem.Label3(3) = label(3)
                    Case 4:
                        CurrentItem.Label4(2) = label(2)
                        CurrentItem.Label4(3) = label(3)
                    Case 5:
                        CurrentItem.Label5(2) = label(2)
                        CurrentItem.Label5(3) = label(3)
                    Case 6:
                        CurrentItem.Label6(2) = label(2)
                        CurrentItem.Label6(3) = label(3)
                    Case 7:
                        CurrentItem.Label7(2) = label(2)
                        CurrentItem.Label7(3) = label(3)                        
                End Select

                flabel.SetAlignedPosition label(2),label(3) - DMD_slide ,FlexDMD_Align_Center
                '

            End If
       Next

    End Sub

    Sub DMDNewOverlay
        CurrentMSGdone = 1 ' to get it off screen
        Dim flabel
        DMD_slide = 0

        if CurrentItem.Action = "slidedown" Then DMD_slide = DMDHeight
        if CurrentItem.Action = "slideup" Then DMD_slide = -DMDHeight

        If CurrentItem.BGImage  <> "noimage" Then FlexDMDItem.Stage.GetImage(CurrentItem.BGImage).Visible=True : FlexDMDItem.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
        If CurrentItem.BGVideo <> "novideo" Then FlexDMDItem.Stage.GetVideo(CurrentItem.BGVideo).Visible=True : FlexDMDItem.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide * 1.5 : FlexDMDItem.Stage.GetVideo(CurrentItem.BGVideo).Seek(0)
        
        Dim i
        For i = 1 to 7
            
            dim label : label = CurrentItem.GetLabel(i)
            If Not IsNull(label) Then

                Set flabel = FlexDMDItem.Stage.GetLabel("TextSmalLine" & CStr(i))
                flabel.Font = label(1)
                flabel.Text = label(0)
                If InStr(1, label(0), "$") > 0 Then
                    Dim x
                    debug.print(CurrentItem.Name)
                    For x=0 To UBound(CurrentItem.Replacements)
                        
                        If InStr(1, label(0), "$"&x+1) > 0 Then
                            flabel.Text = Replace(flabel.Text, "$"&x+1, GetRef(CurrentItem.Replacements(x))())
                        End If
                    Next
                End If

                flabel.SetAlignedPosition label(2),label(3) - DMD_slide ,FlexDMD_Align_Center
                flabel.visible = True

            End If
        Next
     
    End Sub

    Sub DMDSlideOff
        If CurrentItem.Action = "" Then CurrentMSGdone = 0
        If CurrentMSGdone > 0 Then
            DMD_Slide = DMD_Slide - 3 
            If DMD_Slide < -DMDHeight Then CurrentMSGdone = 0
            DMDUpdate()
        Else
            Items.Remove CurrentItem.Name
            DMDResetAll()
            CurrentItem = Null
        End If
    End Sub

    Public Sub DMDResetAll
        Exit Sub
        Dim child
        For Each child in FlexDMDOverlayAssets
            dim asset
            asset = Split(child, "|")
            Select Case asset(1)
                Case "image"
                    FlexDMDItem.Stage.GetImage(asset(0)).Visible=False 
                Case "video"
                    FlexDMDItem.Stage.GetVideo(asset(0)).Visible=False 
                Case "text"
                    FlexDMDItem.Stage.GetLabel(asset(0)).Visible=False 
            End Select
        Next
    End Sub
End Class

'***********************************************************************
'* TABLE OPTIONS *******************************************************
'***********************************************************************

Dim RoomBrightness : RoomBrightness = 60			'Level of room lighting (0 to 100), where 0 is dark and 100 is brightest
Dim ColorLUT : ColorLUT = 3
Dim ScorbitActive : ScorbitActive = 0
Dim OutPostMod : OutPostMod = 1				'Difficulty : 0 = Easy, 1 = Medium, 2 = Hard
Dim SlingsMod : SlingsMod = 0 				'0 - Blue Slings, 1 = Orange Slings
Dim VolumeDial : VolumeDial = 0.8			'Overall Mechanical sound effect volume. Recommended values should be no greater than 1.
Dim BallRollVolume : BallRollVolume = 0.5 	'Level of ball rolling volume. Value between 0 and 1
Dim RampRollVolume : RampRollVolume = 0.5 	'Level of ramp rolling volume. Value between 0 and 1
Dim StagedFlipperMod
Dim OptionsCabinetMode : OptionsCabinetMode = 0
Dim OptionsWizardMode : OptionsWizardMode = 0
Dim OptionsBonusSound : OptionsBonusSound = "fx-bonus"

'Dim Cabinetmode	: Cabinetmode = 0			'0 - Siderails On, 1 - Siderails Off

Dim VRRoomChoice : VRRoomChoice = 1				'0 - Minimal Room, 1 = Default Room

' Base options
Const Opt_Light = 0
Const Opt_LUT = 1
Const Opt_Scorbit = 2

Const Opt_CabinetMode = 3
Const Opt_WizardMode = 4
Const Opt_BonusSound = 5

Const Opt_Volume = 6
Const Opt_Volume_Ramp = 7
Const Opt_Volume_Ball = 8
' Table mods & toys
'Const Opt_Cabinet = 8
Const Opt_Staged_Flipper = 9
' Shadow options
' Informations
Const Opt_Info_1 = 10
Const Opt_Info_2 = 11

Const NOptions = 12

Dim OptionDMD: Set OptionDMD = Nothing
Dim bOptionsMagna, bInOptions : bOptionsMagna = False
Dim OptPos, OptSelected, OptN, OptTop, OptBot, OptSel
Dim OptFontHi, OptFontLo

Sub Options_Open
	bOptionsMagna = False
	Set OptionDMD = CreateObject("FlexDMD.FlexDMD")
	If OptionDMD is Nothing Then
		Debug.Print "FlexDMD is not installed"
		Debug.Print "Option UI can not be opened"
		Exit Sub
	End If
	Debug.Print "Option UI opened"
	If ShowDT Then OptionDMDFlasher.RotX = -(Table1.Inclination + Table1.Layback)
	bInOptions = True
	OptPos = 0
	OptSelected = False
	OptionDMD.Show = False
	OptionDMD.RenderMode = FlexDMD_RenderMode_DMD_GRAY_4
	OptionDMD.Width = 128
	OptionDMD.Height = 32
	OptionDMD.Clear = True
	OptionDMD.Run = True
	Dim a, scene, font
	Set scene = OptionDMD.NewGroup("Scene")
	Set OptFontHi = OptionDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", vbWhite, vbWhite, 0)
	Set OptFontLo = OptionDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(100, 100, 100), RGB(100, 100, 100), 0)
	Set OptSel = OptionDMD.NewGroup("Sel")
	Set a = OptionDMD.NewLabel(">", OptFontLo, ">>>")
	a.SetAlignedPosition 1, 16, FlexDMD_Align_Left
	OptSel.AddActor a
	Set a = OptionDMD.NewLabel(">", OptFontLo, "<<<")
	a.SetAlignedPosition 127, 16, FlexDMD_Align_Right
	OptSel.AddActor a
	scene.AddActor OptSel
	OptSel.SetBounds 0, 0, 128, 32
	OptSel.Visible = False
	
	Set a = OptionDMD.NewLabel("Info1", OptFontLo, "MAGNA EXIT/ENTER")
	a.SetAlignedPosition 1, 32, FlexDMD_Align_BottomLeft
	scene.AddActor a
	Set a = OptionDMD.NewLabel("Info2", OptFontLo, "FLIPPER SELECT")
	a.SetAlignedPosition 127, 32, FlexDMD_Align_BottomRight
	scene.AddActor a
	Set OptN = OptionDMD.NewLabel("Pos", OptFontLo, "LINE 1")
	Set OptTop = OptionDMD.NewLabel("Top", OptFontLo, "LINE 1")
	Set OptBot = OptionDMD.NewLabel("Bottom", OptFontLo, "LINE 2")
	scene.AddActor OptN
	scene.AddActor OptTop
	scene.AddActor OptBot
	Options_OnOptChg
	OptionDMD.LockRenderThread
	OptionDMD.Stage.AddActor scene
	OptionDMD.UnlockRenderThread
	OptionDMDFlasher.Visible = True
	DisableStaticPrerendering = True
End Sub

Sub Options_UpdateDMD
	If OptionDMD is Nothing Then Exit Sub
	Dim DMDp: DMDp = OptionDMD.DmdPixels
	If Not IsEmpty(DMDp) Then
		OptionDMDFlasher.DMDWidth = OptionDMD.Width
		OptionDMDFlasher.DMDHeight = OptionDMD.Height
		OptionDMDFlasher.DMDPixels = DMDp
	End If
End Sub

Sub Options_Close
	bInOptions = False
	OptionDMDFlasher.Visible = False
	If OptionDMD is Nothing Then Exit Sub
	OptionDMD.Run = False
	Set OptionDMD = Nothing
	DisableStaticPrerendering = False
End Sub

Function Options_OnOffText(opt)
	If opt Then
		Options_OnOffText = "ON"
	Else
		Options_OnOffText = "OFF"
	End If
End Function

Sub Options_OnOptChg
	If OptionDMD is Nothing Then Exit Sub
	OptionDMD.LockRenderThread


	If Not OptPos=2 Then
		
	End If

	If OptSelected Then
		OptTop.Font = OptFontLo
		OptBot.Font = OptFontHi
		OptSel.Visible = True
	Else
		OptTop.Font = OptFontHi
		OptBot.Font = OptFontLo
		OptSel.Visible = False
	End If
	If OptPos = Opt_Light Then
		OptTop.Text = "ROOM LIGHT LEVEL1"
		OptBot.Text = "LEVEL " & RoomBrightness
		SaveValue cGameName, "LIGHT", RoomBrightness
	ElseIf OptPos = Opt_LUT Then
		OptTop.Text = "COLOR SATURATION"
'		OptBot.Text = "LUT " & CInt(ColorLUT)
		if ColorLUT = 1 Then OptBot.text = "DISABLED"
		if ColorLUT = 2 Then OptBot.text = "DESATURATED -10%"
		if ColorLUT = 3 Then OptBot.text = "DESATURATED -20%"
		if ColorLUT = 4 Then OptBot.text = "DESATURATED -30%"
		if ColorLUT = 5 Then OptBot.text = "DESATURATED -40%"
		if ColorLUT = 6 Then OptBot.text = "DESATURATED -50%"
		if ColorLUT = 7 Then OptBot.text = "DESATURATED -60%"
		if ColorLUT = 8 Then OptBot.text = "DESATURATED -70%"
		if ColorLUT = 9 Then OptBot.text = "DESATURATED -80%"
		if ColorLUT = 10 Then OptBot.text = "DESATURATED -90%"
		if ColorLUT = 11 Then OptBot.text = "BLACK'N WHITE"
		SaveValue cGameName, "LUT", ColorLUT
	ElseIf OptPos = Opt_Scorbit Then
		OptTop.Text = "SCORBIT"
		if ScorbitActive = 0 Then OptBot.text = "OFF"
		if ScorbitActive = 1 Then OptBot.text = "ACTIVE"
		SaveValue cGameName, "SCORBIT", ScorbitActive
	ElseIf OptPos = Opt_CabinetMode Then
		OptTop.Text = "CABINET MODE"
		OptBot.Text = Options_OnOffText(OptionsCabinetMode)
		SaveValue cGameName, "CABMODE", OptionsCabinetMode
	ElseIf OptPos = Opt_WizardMode Then
		OptTop.Text = "PLAY WIZARD MODE"
		OptBot.Text = Options_OnOffText(OptionsWizardMode)
		SaveValue cGameName, "WIZMODE", OptionsWizardMode
	ElseIf OptPos = Opt_BonusSound Then
		OptTop.Text = "BONUS SOUND"
		If OptionsBonusSound = "fx-bonus" Then
			OptBot.Text = "Main"
		Else
			OptBot.Text = "Alt"
		End If
		SaveValue cGameName, "BONUS", OptionsBonusSound
	ElseIf OptPos = Opt_Volume Then
		OptTop.Text = "MECH VOLUME"
		OptBot.Text = "LEVEL " & CInt(VolumeDial * 100)
		SaveValue cGameName, "VOLUME", VolumeDial
	ElseIf OptPos = Opt_Volume_Ramp Then
		OptTop.Text = "RAMP VOLUME"
		OptBot.Text = "LEVEL " & CInt(RampRollVolume * 100)
		SaveValue cGameName, "RAMPVOLUME", RampRollVolume
	ElseIf OptPos = Opt_Volume_Ball Then
		OptTop.Text = "BALL VOLUME"
		OptBot.Text = "LEVEL " & CInt(BallRollVolume * 100)
		SaveValue cGameName, "BALLVOLUME", BallRollVolume
	ElseIf OptPos = Opt_Staged_Flipper Then
		OptTop.Text = "STAGED FLIPPER"
		OptBot.Text = Options_OnOffText(StagedFlipperMod)
		SaveValue cGameName, "STAGED", StagedFlipperMod
'	ElseIf OptPos = Opt_Cabinet Then
'		OptTop.Text = "CABINET MODE"
'		OptBot.Text = Options_OnOffText(CabinetMode)
'		SaveValue cGameName, "CABINET", CabinetMode
	ElseIf OptPos = Opt_Info_1 Then
		OptTop.Text = "VPX " & VersionMajor & "." & VersionMinor & "." & VersionRevision
		OptBot.Text = "CYBERRACE " & TableVersion
	ElseIf OptPos = Opt_Info_2 Then
		OptTop.Text = "RENDER MODE"
		If RenderingMode = 0 Then OptBot.Text = "DEFAULT"
		If RenderingMode = 1 Then OptBot.Text = "STEREO 3D"
		If RenderingMode = 2 Then OptBot.Text = "VR"
	End If
	'OptTop.SetAlignedPosition 127, 1, FlexDMD_Align_TopRight 'bug? not aligning right
	OptTop.SetAlignedPosition 100, 1, FlexDMD_Align_TopRight
	OptBot.SetAlignedPosition 64, 16, FlexDMD_Align_Center
	OptionDMD.UnlockRenderThread
	UpdateMods
End Sub

Sub Options_Toggle(amount)
	If OptionDMD is Nothing Then Exit Sub

	If OptPos = Opt_Light Then
		RoomBrightness = RoomBrightness + amount * 10
		If RoomBrightness < 0 Then RoomBrightness = 100
		If RoomBrightness > 100 Then RoomBrightness = 0
	ElseIf OptPos = Opt_LUT Then
		ColorLUT = ColorLUT + amount * 1
		If ColorLUT < 1 Then ColorLUT = 11
		If ColorLUT > 11 Then ColorLUT = 1
	ElseIf OptPos = Opt_Scorbit Then
		If ScorbitActive = 1 Then 
			ScorbitActive = 0
		Else 
			ScorbitActive = 1
		End If
	ElseIf OptPos = Opt_Volume Then
		VolumeDial = VolumeDial + amount * 0.1
		If VolumeDial < 0 Then VolumeDial = 1
		If VolumeDial > 1 Then VolumeDial = 0
	ElseIf OptPos = Opt_Volume_Ramp Then
		RampRollVolume = RampRollVolume + amount * 0.1
		If RampRollVolume < 0 Then RampRollVolume = 1
		If RampRollVolume > 1 Then RampRollVolume = 0
	ElseIf OptPos = Opt_Volume_Ball Then
		BallRollVolume = BallRollVolume + amount * 0.1
		If BallRollVolume < 0 Then BallRollVolume = 1
		If BallRollVolume > 1 Then BallRollVolume = 0
	ElseIf OptPos = Opt_Staged_Flipper Then
		StagedFlipperMod = 1 - StagedFlipperMod
	ElseIf OptPos = Opt_CabinetMode Then
		OptionsCabinetMode = 1 - OptionsCabinetMode
	ElseIf OptPos = Opt_WizardMode Then
		OptionsWizardMode = 1 - OptionsWizardMode
	ElseIf OptPos = Opt_BonusSound Then
		If OptionsBonusSound = "fx-bonus" Then 
			OptionsBonusSound = "fx-bonus-alt"
		Else
			OptionsBonusSound = "fx-bonus"
		End If
		PlaySound(OptionsBonusSound)
	End If
End Sub

Sub Options_KeyDown(ByVal keycode)
	If OptSelected Then
		If keycode = LeftMagnaSave Then ' Exit / Cancel
			OptSelected = False
		ElseIf keycode = RightMagnaSave Then ' Enter / Select
			OptSelected = False
		ElseIf keycode = LeftFlipperKey Then ' Next / +
			Options_Toggle	-1
		ElseIf keycode = RightFlipperKey Then ' Prev / -
			Options_Toggle	1
		End If
	Else
		If keycode = LeftMagnaSave Then ' Exit / Cancel
			Options_Close
		ElseIf keycode = RightMagnaSave Then ' Enter / Select
			If OptPos < Opt_Info_1 Then OptSelected = True
		ElseIf keycode = LeftFlipperKey Then ' Next / +
			OptPos = OptPos - 1
'			If OptPos = Opt_VRTopperOn And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRSideBlades And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRBackglassGI And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRRoomChoice And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
			If OptPos < 0 Then OptPos = NOptions - 1
		ElseIf keycode = RightFlipperKey Then ' Prev / -
			OptPos = OptPos + 1
'			If OptPos = Opt_VRRoomChoice And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRBackglassGI And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRSideBlades And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRTopperOn And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
			If OptPos >= NOPtions Then OptPos = 0
		End If
	End If
	Options_OnOptChg
End Sub

Sub Options_Load
	Dim x
    x = LoadValue(cGameName, "LIGHT") : If x <> "" Then RoomBrightness = CInt(x) Else RoomBrightness = 60
    x = LoadValue(cGameName, "LUT") : If x <> "" Then ColorLUT = CInt(x) Else ColorLUT = 3
	x = LoadValue(cGameName, "SCORBIT") : If x <> "" Then ScorbitActive = CInt(x) Else ScorbitActive = 0
    x = LoadValue(cGameName, "VOLUME") : If x <> "" Then VolumeDial = CNCDbl(x) Else VolumeDial = 0.8
    x = LoadValue(cGameName, "RAMPVOLUME") : If x <> "" Then RampRollVolume = CNCDbl(x) Else RampRollVolume = 0.5
    x = LoadValue(cGameName, "BALLVOLUME") : If x <> "" Then BallRollVolume = CNCDbl(x) Else BallRollVolume = 0.5
    x = LoadValue(cGameName, "STAGED") : If x <> "" Then StagedFlipperMod = CInt(x) Else StagedFlipperMod = 0
	x = LoadValue(cGameName, "CABMODE") : If x <> "" Then OptionsCabinetMode = CInt(x) Else OptionsCabinetMode = 0
	x = LoadValue(cGameName, "WIZMODE") : If x <> "" Then OptionsWizardMode = CInt(x) Else OptionsWizardMode = 0
	x = LoadValue(cGameName, "BONUS") : If x <> "" Then OptionsBonusSound = CStr(x) Else OptionsBonusSound = "fx-bonus"
	UpdateMods
End Sub


Sub UpdateMods
	Dim BL, LM, x, y, c, enabled
	
	'*********************
	'Room light level
	'*********************

	SetRoomBrightness RoomBrightness/100

	'*********************
	'Color LUT
	'*********************

	if ColorLUT = 1 Then Table1.ColorGradeImage = ""
	if ColorLUT = 2 Then Table1.ColorGradeImage = "colorgradelut256x16-10"
	if ColorLUT = 3 Then Table1.ColorGradeImage = "colorgradelut256x16-20"
	if ColorLUT = 4 Then Table1.ColorGradeImage = "colorgradelut256x16-30"
	if ColorLUT = 5 Then Table1.ColorGradeImage = "colorgradelut256x16-40"
	if ColorLUT = 6 Then Table1.ColorGradeImage = "colorgradelut256x16-50"
	if ColorLUT = 7 Then Table1.ColorGradeImage = "colorgradelut256x16-60"
	if ColorLUT = 8 Then Table1.ColorGradeImage = "colorgradelut256x16-70"
	if ColorLUT = 9 Then Table1.ColorGradeImage = "colorgradelut256x16-80"
	if ColorLUT = 10 Then Table1.ColorGradeImage = "colorgradelut256x16-90"
	if ColorLUT = 11 Then Table1.ColorGradeImage = "colorgradelut256x16-100"

	'MsgBox(ScorbitActive)
	If ScorbitActive = 1 Then
		StartScorbit
		If ScorbitActive = 1 And Scorbit.bNeedsPairing = True Then
			ScorbitFlasher.Visible = True
		End If
	Else
		ScorbitFlasher.Visible = False
	End If

	Dim element
	If OptionsCabinetMode = 1 Then
		For Each element in BP_PinCab_Rails
			element.Visible = False
		Next
	Else
		For Each element in BP_PinCab_Rails
			element.Visible = True
		Next
	End If

End Sub


' Culture neutral string to double conversion (handles situation where you don't know how the string was written)
Function CNCDbl(str)
    Dim strt, Sep, i
    If IsNumeric(str) Then
        CNCDbl = CDbl(str)
    Else
        Sep = Mid(CStr(0.5), 2, 1)
        Select Case Sep
        Case "."
            i = InStr(1, str, ",")
        Case ","
            i = InStr(1, str, ".")
        End Select
        If i = 0 Then     
            CNCDbl = Empty
        Else
            strt = Mid(str, 1, i - 1) & Sep & Mid(str, i + 1)
            If IsNumeric(strt) Then
                CNCDbl = CDbl(strt)
            Else
                CNCDbl = Empty
            End If
        End If
    End If
End Function

'******************
'Setup Stuff
'*****************


'****************************
'	Room Brightness
'****************************

' Update these arrays if you want to change more materials with room light level
Dim RoomBrightnessMtlArray: RoomBrightnessMtlArray = Array("VLM.Bake.Active","VLM.Bake.Solid")
Dim SavedMtlColorArray:     SavedMtlColorArray     = Array(0,0)


Sub SetRoomBrightness(lvl)
	If lvl > 1 Then lvl = 1
	If lvl < 0 Then lvl = 0

	' Lighting level
	Dim v: v=(lvl * 225 + 30)/255
	Dim i: For i = 0 to UBound(RoomBrightnessMtlArray)
		ModulateMaterialBaseColor RoomBrightnessMtlArray(i), i, v
	Next


End Sub

SaveMtlColors
Sub SaveMtlColors
	Dim i: For i = 0 to UBound(RoomBrightnessMtlArray)
		SaveMaterialBaseColor RoomBrightnessMtlArray(i), i
	Next
End Sub

Sub SaveMaterialBaseColor(name, idx)
    Dim wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
	GetMaterial name, wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
	SavedMtlColorArray(idx) = round(base,0)
End Sub


Sub ModulateMaterialBaseColor(name, idx, val)
    Dim wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
	Dim red, green, blue, saved_base, new_base
 
	'First get the existing material properties
	GetMaterial name, wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle

	'Get saved color
	saved_base = SavedMtlColorArray(idx)
	
	'Next extract the r,g,b values from the base color
	red = saved_base And &HFF
	green = (saved_base \ &H100) And &HFF
	blue = (saved_base \ &H10000) And &HFF
	'msgbox red & " " & green & " " & blue

	'Create new color scaled down by 'val', and update the material
	new_base = RGB(red*val, green*val, blue*val)
    UpdateMaterial name, wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, new_base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
End Sub