

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
Const POINTS_BET_SPIN = 20000


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
Const SCORE = "Player Score"

'Ball
Const CURRENT_BALL = "Current Ball"
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

Const OUTLANE_SAVE = "Outlane Save"
Const JACKPOTS_MULTIPLIER = "Jackpots Multiplier"

'Bonus
Const BONUS_COMBOS_MADE = "Bonus Combos Make"
Const BONUS_RACES_WON = "Bonus Races Won"
Const BONUS_NODES_COMPLETED = "Bonus Nodes Completed"

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

'***********************************************************************************************************************
