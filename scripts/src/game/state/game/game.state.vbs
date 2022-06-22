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
