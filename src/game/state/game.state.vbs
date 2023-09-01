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

Const GAME_BALLSAVE_TIMER_ENDED = "Game Ball Save Timer Ended"
Const GAME_RACE_TIMER_ENDED = "Game Race Timer Ended"
Const GAME_BET_TIMER_ENDED = "Game Bet Timer Ended"
Const GAME_BOOST_TIMER_ENDED = "Game Boost Timer Ended"
Const GAME_EMP_TIMER_ENDED = "Game EMP Timer Ended"
Const GAME_SKILLS_TIMER_ENDED = "Game Skills Timer Ended"
Const GAME_BONUS_TIMER_ENDED = "Game Bonus Timer Ended"
Const GAME_SELECTION_TIMER_ENDED = "Game Selection Timer Ended"

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

Const GAME_BET_MAX_HITS = 20


Dim GAME_RACE_MODE_TITLES : GAME_RACE_MODE_TITLES = Array("RYKAR", "MINERVA", "ALLESA", "NYE", "LUKA", "EZRI")
Dim GAME_RACE_MODE_DESC : GAME_RACE_MODE_DESC = Array("Hit 6 Ramp Shots", "Spin Each Spinner 30 Times", "One Roving Shot Lit, Hit 6 To Complete", "Hit boost targets in order plus roving", "Ramps and boost targets. Hit boost targets, then ramps in order then, roving boost target.", "Shots and spinners. Hit roving shots and 50 spins on each spinner.Shots and spinners. Hit roving shots and 50 spins on each spinner.")


' Balls Per Game
Const BALLS_PER_GAME = 3


'Base Points
Const POINTS_BASE = 750
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

Dim GameTimers : GameTimers = Array(0,0,0,0,0,0,0,0)
Dim GameTimerColors : GameTimerColors = Array(GAME_NORMAL_COLOR,GAME_RACE_COLOR,GAME_HURRYUP_COLOR,GAME_MULTIBALL_COLOR,GAME_NORMAL_COLOR,GAME_SKILLS_COLOR, Null, Null)
Dim GameTimerEndEvent : GameTimerEndEvent = Array(GAME_BALLSAVE_TIMER_ENDED,GAME_RACE_TIMER_ENDED,GAME_BET_TIMER_ENDED,GAME_BOOST_TIMER_ENDED,GAME_EMP_TIMER_ENDED,GAME_SKILLS_TIMER_ENDED, GAME_BONUS_TIMER_ENDED, GAME_SELECTION_TIMER_ENDED)

'***********************************************************************************************************************
