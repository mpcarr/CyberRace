
'****************************
' End Of Ball
' Event Listeners:      
    RegisterPinEvent BALL_DRAIN, "EndOfBall"
'
'*****************************
Sub EndOfBall()
    Debug.print("Balls In Play: "& ballsInPlay)

    Debug.print(ballsInPlay - BallsOnBridge())
    If ballSaver = True Then
        DispatchPinEvent BALL_SAVE
    ElseIf ballsInPlay - BallsOnBridge() = 0 Then

        PlayCallout("drain")
        DmdQ.RemoveAll()
        lightCtrl.AddTableLightSeq "GI", lSeqGIOff
        MusicOff
        SetPlayerState MODE_CHOOSE_SKILLSHOT, False
        SetPlayerState MODE_SKILLSHOT_ACTIVE, False
        
        SetPlayerState MODE_EMP, False
        SetPlayerState EMP_SHOT, 0

        SetPlayerState MODE_SKILLS_TRIAL, False
        SetPlayerState SKILLS_TRIAL_SHOT, 0

        ComboTimer.Enabled = False
        SetPlayerState COMBO_COUNT, 0
        SetPlayerState COMBO_SHOT_SPINNER, 0
        SetPlayerState COMBO_SHOT_LEFT_ORBIT, 0
        SetPlayerState COMBO_SHOT_LEFT_RAMP, 0
        SetPlayerState COMBO_SHOT_RIGHT_RAMP, 0
        SetPlayerState COMBO_SHOT_RIGHT_OrBIT, 0

        BoostTimer.Enabled = False
        SetPlayerState MODE_BOOST, False
        SetPlayerState BOOST_SHOT, 0
        SetPlayerState BOOST_1, 2
        SetPlayerState BOOST_2, 2
        SetPlayerState BOOST_3, 2

        SetPlayerState MODE_CYBER, False
        SetPlayerState CYBER_C, 0
        SetPlayerState CYBER_Y, 0
        SetPlayerState CYBER_B, 0
        SetPlayerState CYBER_E, 0
        SetPlayerState CYBER_R, 0

        SetPlayerState BET_1, 2
        SetPlayerState BET_2, 2
        SetPlayerState BET_3, 2
        SetPlayerState BET_VALUE, 0
        SetPlayerState MODE_BET, False

        SetPlayerState MODE_MULTIBALL, False

        If GetPlayerState(MODE_RACE) = True Then
            SetPlayerState LANE_R, 0
            SetPlayerState LANE_A, 0
            SetPlayerState LANE_C, 0
            SetPlayerState LANE_E, 0
        End If
        SetPlayerState MODE_RACE, False
        SetPlayerState RACE_MODE_SELECTION, 1
        SetPlayerState RACE_MODE_FINISH, False

        SetPlayerState CURRENT_BALL, GetPlayerState(CURRENT_BALL) + 1

        GameTimers = Array(0,0,0,0,0,0,0,0)

        lightCtrl.RemoveAllShots()
        lightCtrl.RemoveAllLightSeq "GI"
        lightCtrl.RemoveAllLightSeq "BoostUp"
        lightCtrl.RemoveAllLightSeq "RaceMode"
        lightCtrl.RemoveAllLightSeq "NodesGrid"
        lightCtrl.RemoveAllLightSeq "BetMode"

        GameTimers(GAME_BONUS_TIMER_IDX) = 10
        'PlayFlexDMD End Of Ball Bonus
        FlexDMDBonusScene()
        
    End If
End Sub


'****************************
' End Of Bonus
' Event Listeners:      
    RegisterPinEvent GAME_BONUS_TIMER_ENDED, "EndOfBonus"
'
'*****************************
Sub EndOfBonus()
    SetPlayerState BONUS_COMBOS_MADE, 0
    SetPlayerState BONUS_RACES_WON, 0
    SetPlayerState BONUS_NODES_COMPLETED, 0
    SetPlayerState BONUS_X, 0
    SetPlayerState GI_COLOR, GAME_NORMAL_COLOR
    lightCtrl.RemoveTableLightSeq "GI", lSeqGIOff
    Select Case currentPlayer
        Case "PLAYER 1":
            If UBound(playerState.Keys()) > 0 Then
                currentPlayer = "PLAYER 2"
            End If
        Case "PLAYER 2":
            If UBound(playerState.Keys()) > 1 Then
                currentPlayer = "PLAYER 3"
            Else
                currentPlayer = "PLAYER 1"
            End If
        Case "PLAYER 3":
            If UBound(playerState.Keys()) > 2 Then
                currentPlayer = "PLAYER 4"
            Else
                currentPlayer = "PLAYER 1"
            End If
        Case "PLAYER 4":
            currentPlayer = "PLAYER 1"
    End Select

    If GetPlayerState(CURRENT_BALL) > BALLS_PER_GAME Then
        DispatchPinEvent GAME_OVER
        gameStarted = False
        FlexDMDCWelcomeScene()
        currentPlayer = Null
        playerState.RemoveAll()
    Else
        If GetPlayerState(CURRENT_BALL) > 1 Then
            'FlexDMD.Stage.GetImage("BGP1").Visible = False
            'FlexDMD.Stage.GetImage("BGP2").Visible = False
            'FlexDMD.Stage.GetImage("BGP3").Visible = False
            'FlexDMD.Stage.GetImage("BGP4").Visible = False
            Select Case UBound(playerState.Keys())
                Case 0:
                    'FlexDMD.Stage.GetImage("BGP1").Visible = True
                    FlexDMD.Stage.GetLabel("Player1").Visible = True
                Case 1:     
                    'FlexDMD.Stage.GetImage("BGP2").Visible = True
                    FlexDMD.Stage.GetLabel("Player2").Visible = True
                Case 2:
                    'FlexDMD.Stage.GetImage("BGP3").Visible = True
                    FlexDMD.Stage.GetLabel("Player3").Visible = True
                Case 3:   
                    'FlexDMD.Stage.GetImage("BGP4").Visible = True
                    FlexDMD.Stage.GetLabel("Player4").Visible = True  
            End Select
        End If
        SetPlayerState ENABLE_BALLSAVER, True
        SetPlayerState FLEX_MODE, 0
        DispatchPinEvent NEXT_PLAYER
    End If
End Sub