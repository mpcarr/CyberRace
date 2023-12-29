Sub AddPlayer()
    'FlexDMD.Stage.GetImage("BGP1").Visible = False
    'FlexDMD.Stage.GetImage("BGP2").Visible = False
    'FlexDMD.Stage.GetImage("BGP3").Visible = False
    'FlexDMD.Stage.GetImage("BGP4").Visible = False

    Select Case UBound(playerState.Keys())
        Case -1:
            playerState.Add "PLAYER 1", InitNewPlayer()
            currentPlayer = "PLAYER 1"
            NumberOfPlayers=1
     '       FlexDMD.Stage.GetImage("BGP1").Visible = True
      '      FlexDMD.Stage.GetLabel("Player1").Visible = True
        Case 0:     
            If GetPlayerState(CURRENT_BALL) = 1 Then
                playerState.Add "PLAYER 2", InitNewPlayer()
                NumberOfPlayers=2
       '         FlexDMD.Stage.GetImage("BGP2").Visible = True
        '        FlexDMD.Stage.GetLabel("Player2").Visible = True
            End If
        Case 1:
            If GetPlayerState(CURRENT_BALL) = 1 Then
                playerState.Add "PLAYER 3", InitNewPlayer()
                NumberOfPlayers=3
         '       FlexDMD.Stage.GetImage("BGP3").Visible = True
          '      FlexDMD.Stage.GetLabel("Player3").Visible = True
            End If     
        Case 2:   
            If GetPlayerState(CURRENT_BALL) = 1 Then
                playerState.Add "PLAYER 4", InitNewPlayer()
                NumberOfPlayers=4
           '     FlexDMD.Stage.GetImage("BGP4").Visible = True
            '    FlexDMD.Stage.GetLabel("Player4").Visible = True
            End If  
    End Select
End Sub

Function InitNewPlayer()

    Dim state: Set state=CreateObject("Scripting.Dictionary")
    
    state.Add EMPTY_STR, ""

    state.Add GI_STATE, 1
    state.Add GI_COLOR, RGB(255,255,255)

    state.Add JACKPOT_VALUE, POINTS_JACKPOT

    state.Add FLEX_MODE, 0
    state.Add PLAYER_NAME, ""

    state.Add SCORE, 0
    state.Add CURRENT_BALL, 1
    state.Add EXTRA_BALLS, 0

    state.Add ENABLE_BALLSAVER, False

    state.Add LANE_R,   0
    state.Add LANE_A,   0
    state.Add LANE_C,   0
    state.Add LANE_E,   0

    state.Add LANE_BO,  0
    state.Add LANE_N,   0
    state.Add LANE_US,  0

    state.Add BONUS_X,  0

    state.Add PF_MULTIPLIER, 0

    state.Add EMP_CHARGE, 0
    state.Add EMP_ACTIVATIONS, 1
    state.Add EMP_SHOT, 0

    state.Add NODE_LEVEL, 1
    state.Add NODE_LEVEL_UP_READY, False
    state.Add NODE_COMPLETED, False
    state.Add NODE_ROW_A, Array(0,1,0,0,0)
    state.Add NODE_ROW_B, Array(0,2,1,0,0)
    state.Add NODE_ROW_C, Array(0,0,2,0,0)

    state.Add SKILLS_TRIAL_SHOT, 0
    state.Add SKILLS_TRIAL_SPINS, 0
    state.Add SKILLS_TRIAL_ACTIVATIONS, 1
    state.Add SKILLS_TRIAL_READY, False

    state.Add COMBO_COUNT, 0
    state.Add COMBO_SHOT_SPINNER, 0
    state.Add COMBO_SHOT_LEFT_ORBIT, 0
    state.Add COMBO_SHOT_LEFT_RAMP, 0
    state.Add COMBO_SHOT_RIGHT_RAMP, 0
    state.Add COMBO_SHOT_RIGHT_ORBIT, 0

    state.Add BOOST_1, 2
    state.Add BOOST_2, 2
    state.Add BOOST_3, 2
    state.Add BOOST_SHOT, 0
    state.Add BOOST_HITS, 0
    state.Add BOOST_ACTIVATIONS, 1

    state.Add CYBER_C, 0
    state.Add CYBER_Y, 0
    state.Add CYBER_B, 0
    state.Add CYBER_E, 0
    state.Add CYBER_R, 0

    state.Add HYPER, 0
    state.Add HYPER_LEVEL, 0
    state.Add HYPER_PLAYED, False

    state.Add TT_ORBIT, 0
    state.Add TT_TARGET, 0
    state.Add TT_RAMP, 0
    state.Add TT_CAPTIVE, 0
    state.Add TT_SHORTCUT, 0
    state.Add TT_COLLECTED, 0
    state.Add TT_JACKPOTS, 0
    state.Add TT_ACTIVATIONS, 1

    state.Add GARAGE_ENGINE, 0
    state.Add GARAGE_COOLING, 0
    state.Add GARAGE_HULL, 0

    state.Add BET_1, 2
    state.Add BET_2, 2
    state.Add BET_3, 2
    state.Add BET_VALUE, 0
    state.Add BET_ACTIVATIONS, 1
    state.Add BET_HITS, 0
    state.Add BET_MULTIPLIER, 1

    state.Add NEON_L, 1
    state.Add NEON_O, 1
    state.Add NEON_C, 1
    state.Add NEON_K, 2
    state.Add LOCK_HITS, 3
    state.Add LOCK_LIT, False
    state.Add BALLS_LOCKED, 0

    state.Add TURN_TABLE_MOTOR, False

    state.Add OUTLANE_SAVE, False
    state.Add JACKPOTS_MULTIPLIER, 1

    state.Add MODE_SKILLSHOT_ACTIVE, False
    state.Add MODE_EMP, False
    state.Add MODE_SKILLS_TRIAL, False
    state.Add MODE_BOOST, False
    state.Add MODE_CYBER, False
    state.Add MODE_BET, False
    state.Add MODE_MULTIBALL, False
    state.Add MODE_TT_MULTIBALL, False
    state.Add MODE_RACE_SELECT, False
    state.Add MODE_PERK_SELECT, False
    state.Add MODE_RACE, False
    state.Add MODE_HISCORE, False
    state.Add MODE_WIZARD, False

    state.Add RACE_MODE_FINISH, False

    state.Add SHOT_SPINNER1_MULTIPLIER, 1
    state.Add SHOT_LEFT_ORBIT_MULTIPLIER, 1
    state.Add SHOT_LEFT_RAMP_MULTIPLIER, 1
    state.Add SHOT_RIGHT_RAMP_MULTIPLIER, 1
    state.Add SHOT_RIGHT_ORBIT_MULTIPLIER, 1

    state.Add RACE_TIMERS, 60
    state.Add RACE_MODE_READY, False
    state.Add RACE_MODE_SELECTION, 1
    state.Add RACE_MODE_1_HITS, 0
    state.Add RACE_MODE_2_SPIN1, 0
    state.Add RACE_MODE_2_SPIN2, 0
    state.Add RACE_MODE_3_HITS, 0
    state.Add RACE_MODE_4_HITS, 0
    state.Add RACE_MODE_3_SHOT, 0
    state.Add RACE_MODE_5_HITS, 0
    state.Add RACE_MODE_6_HITS, 0
    state.Add RACE_1, 0
    state.Add RACE_2, 0
    state.Add RACE_3, 0
    state.Add RACE_4, 0
    state.Add RACE_5, 0
    state.Add RACE_6, 0
    state.Add RACE_EXTRABALL, 0

    state.Add BONUS_COMBOS_MADE, 0
    state.Add BONUS_RACES_WON, 0
    state.Add BONUS_NODES_COMPLETED, 0

    state.Add MYSTERY_HITS, 0

    state.Add INITIAL_1, ""
    state.Add INITIAL_2, ""
    state.Add INITIAL_3, ""
    state.Add INITIAL_POSITION, 0
    state.Add LETTER_POSITION, 0

    state.Add GRANDSLAM_TT, False
    state.Add GRANDSLAM_RACES, False
    state.Add GRANDSLAM_COMBO, False
    state.Add GRANDSLAM_NODES, False
    state.Add GRANDSLAM_SKILLS, False
    state.Add GRANDSLAM_WIZARD_READY, False

    Set InitNewPlayer = state

End Function


'****************************
' Setup Player
' Event Listeners:  
    RegisterPinEvent START_GAME,    "SetupPlayer"
    RegisterPinEvent NEXT_PLAYER,   "SetupPlayer"
'
'*****************************
Sub SetupPlayer()
    EmitAllPlayerEvents()
End Sub