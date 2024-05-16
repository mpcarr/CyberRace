
'****************************
' End Of Ball
' Event Listeners:      
    AddPinEventListener BALL_DRAIN, BALL_DRAIN &   "EndOfBall",   "EndOfBall",  1000, Null
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
            timerQueue.RemoveAll()
            If GetPlayerState(MODE_WIZARD) = True Then
                If GetPlayerState(MODE_WIZARD_STAGE) = 1 Then
                    SetPlayerState MODE_WIZARD_STAGE, 2
                    lightCtrl.RemoveAllTableLightSeqs()
                    calloutsQ.Add "wizards2", "PlayCallout(""wizard-stage2"")", 1, 0, 0, 5000, 0, False
                    lightCtrl.AddTableLightSeq "WIZARDL47", wizardFadeL47Seq
                    lightCtrl.AddTableLightSeq "WIZARDGI", lSeqGIWiz
                    SetTimer "wizstage2Release", "TimerWizStage2Release", 5400
                ElseIf GetPlayerState(MODE_WIZARD_STAGE) = 3 Then
                    'COMPLETE
                    If GameTilted = True Then
                        GameTilted = False
                        lightCtrl.ResumeMainLights()
                    End If
        
                    'lightCtrl.AddTableLightSeq "GI", lSeqGIOff
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
                    SetPlayerState HYPER, 0
                    SetPlayerState PF_MULTIPLIER, 1
            
                    SetPlayerState MODE_MULTIBALL, False
                    SetPlayerState MODE_TT_MULTIBALL, False
            
                    If GetPlayerState(MODE_RACE) = True Then
                        SetPlayerState LANE_R, 0
                        SetPlayerState LANE_A, 0
                        SetPlayerState LANE_C, 0
                        SetPlayerState LANE_E, 0
                    End If
                    SetPlayerState MODE_RACE, False
                    SetPlayerState RACE_GRACE, False
                    SetPlayerState RACE_MODE_SELECTION, 1
                    SetPlayerState RACE_MODE_FINISH, False
       
                    GameTimers = Array(0,0,0,0,0,0,0,0,0,0)
            
                    lightCtrl.RemoveAllShots()
                    
                    lightCtrl.RemoveAllLightSeq "GI"
                    lightCtrl.RemoveAllLightSeq "BoostUp"
                    lightCtrl.RemoveAllLightSeq "RaceMode"
                    lightCtrl.RemoveAllLightSeq "NodesGrid"
                    lightCtrl.RemoveAllLightSeq "BetMode"
                    
                    SetTimer "EndOfGame", "TimerEndOfGame", 10000
                    
                End If
            Else
                GAME_DRAIN_BALLS_AND_RESET = False
                lightCtrl.ResumeMainLights()
                Debounce "reset", "TimerAddaBall", 400
            End If
        End IF
    ElseIf ballSaver = True Then
        DispatchPinEvent BALL_SAVE
    ElseIf RealBallsInPlay = 0 Then

        If GetPlayerState(MODE_WIZARD) = True And GetPlayerState(MODE_WIZARD_STAGE) = 3 Then
            If LockPin2.IsDropped = 0 Then
                LockPin2.IsDropped = 1
                EnableBallSaver 15
                Exit Sub
            Else
                If LockPin3.IsDropped = 0 Then
                    LockPin3.IsDropped = 1
                    EnableBallSaver 15
                    Exit Sub
                End If
            End If
        End If
        If GetPlayerState(MODE_WIZARD) = True And GetPlayerState(MODE_WIZARD_STAGE) = 2 And GetPlayerState(BALLS_LOCKED) > 0 Then
            'move to stage 3
            SetPlayerState LOCK_LIT, False
            If GetPlayerState(BALLS_LOCKED) = 1 Then
                calloutsQ.Add "wizStage3", "PlayCallout(""wizard-stage31ball"")", 1, 0, 0, 6000, 0, False
            ElseIf GetPlayerState(BALLS_LOCKED) = 2 Then
                calloutsQ.Add "wizStage3", "PlayCallout(""wizard-stage32ball"")", 1, 0, 0, 6000, 0, False
            End If
            bStartMB = True
            lightCtrl.RemoveAllTableLightSeqs()
            Debounce "setwizstage2", "TimerSetWizStage2", 9500
            lightCtrl.AddTableLightSeq "WIZARDL48", wizardFadeL48Seq
            lightCtrl.AddTableLightSeq "WIZARDL46", wizardFadeL46Seq
            lightCtrl.AddTableLightSeq "WIZARDL47", wizardFadeL47Seq
            lightCtrl.AddTableLightSeq "WIZARDL23", wizardFadeL23Seq
            lightCtrl.AddTableLightSeq "WIZARDL64", wizardFadeL64Seq
            lightCtrl.AddTableLightSeq "WIZARDL63", wizardFadeL63Seq
            lightCtrl.AddTableLightSeq "WIZARDGI", lSeqGIWiz
            wiz3Spinner1Hit = False
            wiz3Spinner2Hit = False
            wiz3LeftOrbitHit = False
            wiz3LeftRampHit = False
            wiz3RightRampHit = False
            wiz3RightOrbitHit = False
            EnableBallSaver 15
            Exit Sub
        End If

        timerQueue.RemoveAll()
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
        SetPlayerState HYPER, 0
        SetPlayerState PF_MULTIPLIER, 1

        SetPlayerState MODE_MULTIBALL, False
        SetPlayerState MODE_TT_MULTIBALL, False

        If GetPlayerState(MODE_RACE) = True Then
            SetPlayerState LANE_R, 0
            SetPlayerState LANE_A, 0
            SetPlayerState LANE_C, 0
            SetPlayerState LANE_E, 0
        End If
        SetPlayerState MODE_RACE, False
        SetPlayerState RACE_GRACE, False
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

Sub TimerSetWizStage2
    SetPlayerState MODE_WIZARD_STAGE, 3
    LockPin1.IsDropped = 1
End Sub

'****************************
' End Of Bonus
' Event Listeners:      
    AddPinEventListener GAME_BONUS_TIMER_ENDED, GAME_BONUS_TIMER_ENDED &   "EndOfBonus",   "EndOfBonus",  1000, Null
'
'*****************************
Dim bonusScore : bonusScore = 0
Sub EndOfBonus()

    DmdQ.RemoveAll()
    bonusScore = 0
    bonusScore = bonusScore + GetPlayerState(BONUS_COMBOS_MADE) * 50000
    bonusScore = bonusScore + GetPlayerState(BONUS_RACES_WON) * 100000
    bonusScore = bonusScore + GetPlayerState(BONUS_NODES_COMPLETED) * 75000
    bonusScore = bonusScore + GetPlayerState(BONUS_SKILLS_COMPLETED) * 90000
    bonusScore = bonusScore + GetPlayerState(BONUS_TT_COMPLETED) * 75000

    Select Case GetPlayerState(BONUS_X):
        Case 1:
            bonusScore = bonusScore*2
        Case 2:
            bonusScore = bonusScore*3
        Case 3:
            bonusScore = bonusScore*5
    End Select
    AddScore bonusScore
    Set qItem = New QueueItem
    With qItem
        .Name = "bonustotal"
        .Duration = 3
        .BGImage = "BGBlack"
        .BGVideo = "novideo"
        .Replacements = Array("GetDMDLabelBonusTotal")
    End With
    qItem.AddLabel "BONUS TOTAL", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    qItem.AddLabel "$1", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
    DmdQ.Enqueue qItem
    

    SetPlayerState BONUS_COMBOS_MADE, 0
    SetPlayerState BONUS_RACES_WON, 0
    SetPlayerState BONUS_NODES_COMPLETED, 0
    SetPlayerState BONUS_X, 0
    SetPlayerState GI_COLOR, GAME_NORMAL_COLOR
    lightCtrl.RemoveTableLightSeq "GI", lSeqGIOff
    
    If GetPlayerState(MODE_WIZARD) = True Then
        BlockAllPinEvents = False
        AllowPinEventsList.RemoveAll
        SetPlayerState EXTRA_BALLS, 0
        SetPlayerState CURRENT_BALL, BALLS_PER_GAME
    End If
    SetPlayerState MODE_WIZARD, False
    SetPlayerState MODE_WIZARD_STAGE, 0
    If GetPlayerState(EXTRA_BALLS) > 0 Then
        SetPlayerState EXTRA_BALLS, GetPlayerState(EXTRA_BALLS) - 1
        DispatchPinEvent RELEASE_BALL
        Set qItem = New QueueItem
        With qItem
            .Name = "shootagain"
            .Duration = 5
            .BGImage = "noimage"
            .BGVideo = "ShootAgain"
        End With
        DmdQ.Enqueue qItem
        PlayShootAgainSeq()
        calloutsQ.Add "shootagain", "PlayCallout(""shoot-again"")", 1, 0, 0, 1600, 0, False
        SetPlayerState ENABLE_BALLSAVER, True
        MusicOn
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
        ScorbitFlasher.Visible = False
        FlexDMD.Stage.GetFrame("VSeparator1").Visible = False
        FlexDMD.Stage.GetFrame("VSeparator2").Visible = False
        FlexDMD.Stage.GetFrame("VSeparator3").Visible = False
        FlexDMD.Stage.GetFrame("VSeparator4").Visible = False
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

Sub TimerEndOfGame()
    lightCtrl.RemoveAllTableLightSeqs()
    GameTimers(GAME_BONUS_TIMER_IDX) = 10
    FlexDMDBonusScene()
    lSeqJackpotRGB.Repeat = False
    lSeqJackpotNonRGB.Repeat = False
End Sub

Sub TimerWizStage2Release
    GAME_DRAIN_BALLS_AND_RESET = False
    lightCtrl.ResumeMainLights()
    DispatchPinEvent ADD_BALL
    EnableBallSaver 15
End Sub

Function GetDMDLabelBonusTotal()
    GetDMDLabelBonusTotal = FormatScore(bonusScore)
End Function
