'***********************************************************************************************************************
'*****  Game State                                           	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitGameLogicState()
    Dim gameLogic: Set gameLogic=CreateObject("Scripting.Dictionary")
    gameLogic.Add "augmentationReady", False
    gameLogic.Add "augmentationActive", 0
    gameLogic.Add "augmentationHold", 1
    gameLogic.Add "currentSound", ""
    gameLogic.Add "hideScore", False
    gameLogic.Add "pauseLights", False
    gameLogic.Add "mode", GAME_MODE_NORMAL
    Dim targetShots: Set targetShots=CreateObject("Scripting.Dictionary")
    gameLogic.Add "targetShots", targetShots
    gameLogic.Add "augmentationResearchStage", 0
    gameLogic.Add "augTigerLvl", 0
    gameLogic.Add "augBatLvl", 0
    gameLogic.Add "augBullLvl", 0
    gameLogic.Add "augLionLvl", 0
    gameLogic.Add "augHawkLvl", 0
    gameLogic.Add "augDeerLvl", 0
    gameLogic.Add "augPantherLvl", 0
    gameLogic.Add "augOwlLvl", 0
    gameLogic.Add "augRhinoLvl", 0
    Dim gameModes: Set gameModes=CreateObject("Scripting.Dictionary")
    gameModes.Add GAME_MODE_NORMAL, False
    gameModes.Add GAME_MODE_CHOOSE_SKILLSHOT, False
    gameModes.Add GAME_MODE_SKILLSHOT_ACTIVE, False
    gameModes.Add GAME_MODE_AUGMENTATION_RESEARCH, False
    gameLogic.Add "modes", gameModes
    Set InitGameLogicState = gameLogic
End Function

Dim AugmentationNames: AugmentationNames = Array("Tiger", "Bat", "Bull","Lion","Hawk","Deer","Panther","Owl","Rhino")
Dim AugmentationPerksLvl1: AugmentationPerksLvl1 = Array("2x Hyper Jump", "2x Left Orbit", "2x Left Ramp","2x Spinner","2x Bumpers","2x Center Ramp","2x Right Right","2x Right Oribit","2x Shortcut")
Dim PaletteToLampLookup: Set PaletteToLampLookup = CreateObject("Scripting.Dictionary")
PaletteToLampLookup.Add "pal_purple", gameColors(0)
PaletteToLampLookup.Add "pal_orange", gameColors(2)
PaletteToLampLookup.Add "pal_red", gameColors(4)
PaletteToLampLookup.Add "pal_yellow", gameColors(5)
Dim AugmentationSounds : AugmentationSounds = Array(Array("2x_hyperjump", ""), Array("2x_leftorbit", "1million_orbits"), Array("2x_left_ramp",""), Array("2x_spinners",""), Array("2x_bumpers",""), Array("2x_centerramp", ""), Array("2x_rightramp", ""), Array("2x_rightorbit", ""), Array("2x_shortcut", ""))

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

'Dim GameShots: GameShots = Array(GAME_SHOT_HYPER_JUMP, GAME_SHOT_LEFT_ORBIT,GAME_SHOT_LEFT_RAMP,GAME_SHOT_SPINNER,GAME_SHOT_CENTER_RAMP,GAME_SHOT_RIGHT_RAMP,GAME_SHOT_RIGHT_ORBIT,GAME_SHOT_SHORTCUT)

Const GAME_MODE_NORMAL = "Game Mode Normal"
Const GAME_MODE_CHOOSE_SKILLSHOT = "Game Mode Choose Skillshot"
Const GAME_MODE_SKILLSHOT_ACTIVE = "Game Mode Skillshot Active"
Const GAME_MODE_AUGMENTATION_RESEARCH = "Game Mode Augmentation Research"

'***********************************************************************************************************************
