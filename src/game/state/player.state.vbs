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
Const MODE_CHOOSE_SKILLSHOT = "Mode_Choose_Skillshot"
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

Const TT_ORBIT = "TT ORBIT"
Const TT_TARGET = "TT TARGET"
Const TT_RAMP = "TT RAMP"
Const TT_CAPTIVE = "TT CAPTIVE"
Const TT_SHORTCUT = "TT SHORTCUT"
Const TT_COLLECTED = "TT COLLECTED"

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
Const LOCK_ACTIVATIONS = "Lock Activations"
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
Const RACE_1 = "Race 1 Complete"
Const RACE_2 = "Race 2 Complete"
Const RACE_3 = "Race 3 Complete"
Const RACE_4 = "Race 4 Complete"
Const RACE_5 = "Race 5 Complete"
Const RACE_6 = "Race 6 Complete"

Const OUTLANE_SAVE = "Outlane Save"
Const JACKPOTS_MULTIPLIER = "Jackpots Multiplier"

'Bonus
Const BONUS_COMBOS_MADE = "Bonus Combos Make"
Const BONUS_RACES_WON = "Bonus Races Won"
Const BONUS_NODES_COMPLETED = "Bonus Nodes Completed"

'HI Score
Const INITIAL_1 = "Initial 1"
Const INITIAL_2 = "Initial 2"
Const INITIAL_3 = "Initial 3"
Const INITIAL_POSITION = "Initial Position"
Const LETTER_POSITION = "Letter Position"


Const RACE_MODE_FINISH = "Race Mode Finish"


Const MODE_NORMAL = "Game_Mode_Normal"
Const MODE_AUGMENTATION_RESEARCH = "Game_Mode_Augmentation_Research"
Const MODE_MULTIBALL = "Game_Mode_Multiball"
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

'***********************************************************************************************************************
