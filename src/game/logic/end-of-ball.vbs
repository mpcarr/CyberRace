
'****************************
' End Of Ball
' Event Listeners:      
    RegisterPinEvent BALL_DRAIN, "EndOfBall"
'
'*****************************
Sub EndOfBall()
    
    If gameStarted = False Then
        Exit Sub
    End If

    Dim qItem 
    If ballSaverIgnoreCount > 0 Then
        ballSaverIgnoreCount = ballSaverIgnoreCount-1
        Exit Sub
    End If
    If GAME_DRAIN_BALLS_AND_RESET = True Then
        If RealBallsInPlay = 0 Then
            GAME_DRAIN_BALLS_AND_RESET = False
            lightCtrl.ResumeMainLights()
            Debounce "reset", "DispatchPinEvent ADD_BALL", 400
        End IF
    ElseIf ballSaver = True Then
        DispatchPinEvent BALL_SAVE
    ElseIf RealBallsInPlay = 0 Then

        If GameTilted = True Then
            GameTilted = False
            lightCtrl.ResumeMainLights()
        End If

        PlayCallout("drain")
        DmdQ.RemoveAll()
        lightCtrl.AddTableLightSeq "GI", lSeqGIOff
        MusicOff
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

        SetPlayerState HYPER_PLAYED, False
        SetPlayerState PF_MULTIPLIER, 0

        SetPlayerState MODE_MULTIBALL, False
        SetPlayerState MODE_TT_MULTIBALL, False

        If GetPlayerState(MODE_RACE) = True Then
            SetPlayerState LANE_R, 0
            SetPlayerState LANE_A, 0
            SetPlayerState LANE_C, 0
            SetPlayerState LANE_E, 0
        End If
        SetPlayerState MODE_RACE, False
        SetPlayerState RACE_MODE_SELECTION, 1
        SetPlayerState RACE_MODE_FINISH, False

        
        GameTimers = Array(0,0,0,0,0,0,0,0,0,0)

        lightCtrl.RemoveAllShots()
        lightCtrl.RemoveAllLightSeq "GI"
        lightCtrl.RemoveAllLightSeq "BoostUp"
        lightCtrl.RemoveAllLightSeq "RaceMode"
        lightCtrl.RemoveAllLightSeq "NodesGrid"
        lightCtrl.RemoveAllLightSeq "BetMode"
        lightCtrl.RemoveAllTableLightSeqs()

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
    DmdQ.RemoveAll()
    If GetPlayerState(MODE_WIZARD) = True Then
        BlockAllPinEvents = False
        AllowPinEventsList.RemoveAll
        SetPlayerState EXTRA_BALLS, 0
        SetPlayerState CURRENT_BALL, BALLS_PER_GAME
    End If

    If GetPlayerState(EXTRA_BALLS) > 0 Then
        SetPlayerState EXTRA_BALLS, GetPlayerState(EXTRA_BALLS) - 1
        DispatchPinEvent RELEASE_BALL
        PlayShootAgainSeq()
        Set qItem = New QueueItem
        With qItem
            .Name = "shootagain"
            .Duration = 5
            .BGImage = "noimage"
            .BGVideo = "ShootAgain"
        End With
        DmdQ.Enqueue qItem
        Exit Sub
    End If

    If GetPlayerState(CURRENT_BALL) = BALLS_PER_GAME And (GetCurrentPlayerNumber()=NumberOfPlayers) Then
        'Check HI SCORES
        DispatchPinEvent GAME_OVER
        calloutsQ.Add "bridgeRelease1", "LockPin1.IsDropped = 1", 1, 0, 0, 1000, 0, False
        calloutsQ.Add "bridgeRelease2", "LockPin2.IsDropped = 1", 1, 0, 0, 1000, 0, False
        calloutsQ.Add "bridgeRelease3", "LockPin3.IsDropped = 1", 1, 0, 0, 1000, 0, False
        gameStarted = False
        currentPlayer = null
        If Not IsNull(Scorbit) Then
            Scorbit.StopSession GetPlayerScore(1), GetPlayerScore(2), GetPlayerScore(3), GetPlayerScore(4), NumberOfPlayers
        End If
        NumberOfPlayers=0
        Exit Sub
    End If

    If GetPlayerState(CURRENT_BALL) < BALLS_PER_GAME Then
        SetPlayerState CURRENT_BALL, GetPlayerState(CURRENT_BALL) + 1
    End If
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

    If GetPlayerState(CURRENT_BALL) > 1 Then
        FlexDMD.Stage.GetFrame("VSeparator1").Visible = False
        FlexDMD.Stage.GetFrame("VSeparator2").Visible = False
        FlexDMD.Stage.GetFrame("VSeparator3").Visible = False
        FlexDMD.Stage.GetFrame("VSeparator4").Visible = False
        CloseFlexScorbitClaimDMD()
        Select Case UBound(playerState.Keys())
            Case 0:
                FlexDMD.Stage.GetFrame("VSeparator1").Visible = True
                FlexDMD.Stage.GetLabel("Player1").Visible = True
            Case 1:     
                FlexDMD.Stage.GetFrame("VSeparator1").Visible = True
                FlexDMD.Stage.GetFrame("VSeparator2").Visible = True
                FlexDMD.Stage.GetLabel("Player2").Visible = True
            Case 2:
                FlexDMD.Stage.GetFrame("VSeparator1").Visible = True
                FlexDMD.Stage.GetFrame("VSeparator2").Visible = True
                FlexDMD.Stage.GetFrame("VSeparator3").Visible = True
                FlexDMD.Stage.GetLabel("Player3").Visible = True
            Case 3:   
                FlexDMD.Stage.GetFrame("VSeparator1").Visible = True
                FlexDMD.Stage.GetFrame("VSeparator2").Visible = True
                FlexDMD.Stage.GetFrame("VSeparator3").Visible = True
                FlexDMD.Stage.GetFrame("VSeparator4").Visible = True
                FlexDMD.Stage.GetLabel("Player4").Visible = True  
        End Select
    End If
    SetPlayerState ENABLE_BALLSAVER, True
    SetPlayerState FLEX_MODE, 0
    DispatchPinEvent NEXT_PLAYER

End Sub