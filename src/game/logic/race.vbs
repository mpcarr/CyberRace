
'****************************
' Check Race Ready
' Event Listeners:  
    RegisterPinEvent SWITCH_HIT_RACE_KICKER, "CheckRaceReady"
'
'*****************************
Sub CheckRaceReady()
    If GetPlayerState(RACE_MODE_READY) = True And GetPlayerState(MODE_MULTIBALL) = False Then
        FlexDMDRaceSelectScene()
        Dim x,i
        x = 0
        i = 0
        Do While x=0
            If i = 6 Then
                i = 0
            End If
            x = i+1
            If GetPlayerState(Eval("RACE_" & x)) = 1 Then
                i = i + 1
                x = 0
            End If
        Loop
        SetPlayerState RACE_MODE_SELECTION, x
        SetPlayerState RACE_MODE_READY, False
        SetPlayerState MODE_RACE_SELECT, True
    Else
        raceVuk.TimerEnabled = True
    End If
End Sub


'****************************
' Race Selection Timer Ended
' Event Listeners:      
    RegisterPinEvent GAME_SELECTION_TIMER_ENDED, "RaceSelectionTimerEnded"
'
'*****************************
Sub RaceSelectionTimerEnded()
    If GetPlayerState(MODE_RACE_SELECT) = True Then
        RaceSelectConfirm()
    End If
End Sub


'****************************
' RaceSelectCycleLeft
' Event Listeners:  
    RegisterPinEvent SWITCH_LEFT_FLIPPER_DOWN, "RaceSelectCycleLeft"
'
'*****************************
Sub RaceSelectCycleLeft()
    If GetPlayerState(MODE_RACE_SELECT) = True Then
        Dim x,i
        x=0
        i = GetPlayerState(RACE_MODE_SELECTION)
        Do While x=0
            If i = 1 Then
                i = 7
            End If
            x = i-1
            If GetPlayerState(Eval("RACE_" & x)) = 1 Then
                i = i - 1
                x = 0
            End If
        Loop
        SetPlayerState RACE_MODE_SELECTION, x
        FlexDMDRaceSelectScene()
    End iF
End Sub

'****************************
' NodePerkSelectRightPerk
' Event Listeners:  
    RegisterPinEvent SWITCH_RIGHT_FLIPPER_DOWN, "RaceSelectCycleRight"
'
'*****************************
Sub RaceSelectCycleRight()
    If GetPlayerState(MODE_RACE_SELECT) = True Then

        Dim x,i
        x=0
        i = GetPlayerState(RACE_MODE_SELECTION)
        Do While x=0
            If i = 6 Then
                i = 0
            End If
            x = i+1
            If GetPlayerState(Eval("RACE_" & x)) = 1 Then
                i = i + 1
                x = 0
            End If
        Loop
        SetPlayerState RACE_MODE_SELECTION, x
        FlexDMDRaceSelectScene()
    End If
End Sub

'****************************
' RaceSelectConfirm
' Event Listeners:  
    RegisterPinEvent SWITCH_SELECT_EVENT_KEY, "RaceSelectConfirm"
'
'*****************************
Sub RaceSelectConfirm()
    If GetPlayerState(MODE_RACE_SELECT) = True Then
        Dim selection : selection = GetPlayerState(RACE_MODE_SELECTION)
        If selection = 5 Or selection = 6 Then
            'TODO: Code race 5 and 6
            Exit Sub
        End If
        lightCtrl.RemoveAllTableLightSeqs()
        GameTimers(GAME_SELECTION_TIMER_IDX) = 0
        DmdQ.RemoveAll()
        raceVuk.TimerEnabled = True
        SetPlayerState MODE_RACE_SELECT, False
        SetPlayerState RACE_MODE_READY, False
        GameTimers(GAME_RACE_TIMER_IDX) = GetPlayerState(RACE_TIMERS)
        SetPlayerState MODE_RACE, True
        PlayMusic "cyberrace\" & MUSIC_RACE & ".mp3", MusicVol
        Select Case GetPlayerState(RACE_MODE_SELECTION):
            Case 1: 
                If GetPlayerState(RACE_MODE_1_HITS) = 6 Then
                    SetPlayerState RACE_MODE_FINISH, True
                Else
                    lightCtrl.AddShot "RaceMode1a", l47, GAME_RACE_COLOR
                    lightCtrl.AddShot "RaceMode1b", l64, GAME_RACE_COLOR
                    If GetPlayerState(RACE_MODE_1_HITS) > 2 Then
                        lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
                    End If
                End If
            Case 2
                lightCtrl.AddShot "RaceMode2a", l48, GAME_RACE_COLOR
                lightCtrl.AddShot "RaceMode2b", l23, GAME_RACE_COLOR
                If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 Then
                    lightCtrl.RemoveShot "RaceMode2a", l48    
                    lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
                End If
                If GetPlayerState(RACE_MODE_2_SPIN2) >= 30 Then
                    lightCtrl.RemoveShot "RaceMode2b", l23    
                    lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
                End If
                If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 AND GetPlayerState(RACE_MODE_2_SPIN2) >= 30 Then
                    lightCtrl.RemoveShot "RaceMode2a", l48
                    lightCtrl.RemoveShot "RaceMode2b", l23
                    lightCtrl.RemoveShot GAME_SHOT_SHORTCUT, l65
                    SetPlayerState RACE_MODE_FINISH, True
                End If                
            Case 3:
                If GetPlayerState(RACE_MODE_3_HITS) = 6 Then
                    SetPlayerState RACE_MODE_FINISH, True
                Else
                    RaceModeTimer.Enabled = False
                    RaceModeTimer.Enabled = True
                    SetPlayerState RACE_MODE_3_SHOT, RndInt(0,5)
                    RaceModeTimer_Timer()
                    If GetPlayerState(RACE_MODE_3_HITS) > 2 Then
                        lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
                    End If
                End If
                
            Case 4:
                lightCtrl.AddShot "RaceMode4a", l46, GAME_RACE_COLOR
                lightCtrl.AddShot "RaceMode4b", l63, GAME_RACE_COLOR
                If GetPlayerState(RACE_MODE_4_HITS) >= 3 Then
                    lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
                End If
                RaceMode4HitsCheck()
            Case 5:
                
            Case 6:
                
        End Select
    End iF
End Sub


'****************************
' RaceModeShortcutHit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_SHORTCUT, "RaceModeShortcutHit"
'
'*****************************
Sub RaceModeShortcutHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If lightCtrl.IsShotLit(GAME_SHOT_SHORTCUT, l65) = True Then
            'TODO Add Lightshow for shortcut
            AddScore POINTS_MODE_SHOT
            Select Case GetPlayerState(RACE_MODE_SELECTION):
                Case 1: 
                    SetPlayerState RACE_MODE_1_HITS, 6
                Case 2
                    SetPlayerState RACE_MODE_2_SPIN1, 30
                    SetPlayerState RACE_MODE_2_SPIN2, 30
                Case 3:
                    SetPlayerState RACE_MODE_3_HITS, 6
                Case 4:
                    SetPlayerState RACE_MODE_4_HITS, 6
                Case 5:

                Case 6:
                    
            End Select
            lightCtrl.RemoveShot GAME_SHOT_SHORTCUT, l65
            SetPlayerState RACE_MODE_FINISH, True
        End If
    End If
End Sub

'****************************
' RaceMode1RampHit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "RaceMode1RampHit"
    RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "RaceMode1RampHit"
'
'*****************************
Sub RaceMode1RampHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 1 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_1_HITS, GetPlayerState(RACE_MODE_1_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode1
' Event Listeners:          
    RegisterPlayerStateEvent RACE_MODE_1_HITS, "RaceMode1"
'
'*****************************
Sub RaceMode1()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_SELECTION) = 1 Then
        If GetPlayerState(RACE_MODE_1_HITS) = 3 Then
            lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
        End If
        If GetPlayerState(RACE_MODE_1_HITS) = 6 Then
            lightCtrl.RemoveShot "RaceMode1a", l47
            lightCtrl.RemoveShot "RaceMode1b", l64
            SetPlayerState RACE_MODE_FINISH, True
        End If
    End If
End Sub

'****************************
' RaceModeTimerEnded
' Event Listeners:          
    RegisterPinEvent GAME_RACE_TIMER_ENDED, "RaceModeTimerEnded"
'
'*****************************
Sub RaceModeTimerEnded()
    If GetPlayerState(MODE_RACE) = True Then
         Select Case GetPlayerState(RACE_MODE_SELECTION):
            Case 1: 
                lightCtrl.RemoveShot "RaceMode1a", l47
                lightCtrl.RemoveShot "RaceMode1b", l64
            Case 2
                lightCtrl.RemoveShot "RaceMode2a", l48
                lightCtrl.RemoveShot "RaceMode2b", l23
            Case 3:
                lightCtrl.RemoveShot "RaceMode3", l48
                lightCtrl.RemoveShot "RaceMode3", l46
                lightCtrl.RemoveShot "RaceMode3", l47
                lightCtrl.RemoveShot "RaceMode3", l23
                lightCtrl.RemoveShot "RaceMode3", l64
                lightCtrl.RemoveShot "RaceMode3", l63
                RaceModeTimer.Enabled = False
            Case 4:
                lightCtrl.RemoveShot "RaceMode4a", l46
                lightCtrl.RemoveShot "RaceMode4b", l63
                lightCtrl.RemoveLightSeq "RaceMode", lSeqRaceMode4Nodes
            Case 5:
                
            Case 6:
                
        End Select
        lightCtrl.RemoveShot GAME_SHOT_SHORTCUT, l65
        SetPlayerState LANE_R, 0
        SetPlayerState LANE_A, 0
        SetPlayerState LANE_C, 0
        SetPlayerState LANE_E, 0
        SetPlayerState RACE_MODE_FINISH, False
        SetPlayerState MODE_RACE, False
        SetPlayerState RACE_MODE_SELECTION, 1
        lightCtrl.RemoveLightSeq "RaceMode", lSeqModeFinish
        GameTimers(GAME_RACE_TIMER_IDX) = 0
    End If
End Sub


'****************************
' RaceMode2Spinner1Hit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_SPINNER1, "RaceMode1SpinnerHit"
'
'*****************************
Sub RaceMode1SpinnerHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 2 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_2_SPIN1, GetPlayerState(RACE_MODE_2_SPIN1) + 1
        End If
    End If
End Sub

'****************************
' RaceMode2Spinner2Hit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_SPINNER2, "RaceMode2SpinnerHit"
'
'*****************************
Sub RaceMode2SpinnerHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 2 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_2_SPIN2, GetPlayerState(RACE_MODE_2_SPIN2) + 1
        End If
    End If
End Sub

'****************************
' RaceMode2
' Event Listeners:          
    RegisterPlayerStateEvent RACE_MODE_2_SPIN1, "RaceMode2"
    RegisterPlayerStateEvent RACE_MODE_2_SPIN2, "RaceMode2"
'
'*****************************
Sub RaceMode2()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_SELECTION) = 2 Then
        If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 Then
            lightCtrl.RemoveShot "RaceMode2a", l48    
            lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
        End If
        If GetPlayerState(RACE_MODE_2_SPIN2) >= 30 Then
            lightCtrl.RemoveShot "RaceMode2b", l23    
            lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
        End If
        If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 AND GetPlayerState(RACE_MODE_2_SPIN2) >= 30 Then
            lightCtrl.RemoveShot "RaceMode2a", l48
            lightCtrl.RemoveShot "RaceMode2b", l23
            lightCtrl.RemoveShot GAME_SHOT_SHORTCUT, l65
            SetPlayerState RACE_MODE_FINISH, True
        End If
    End If
End Sub

'****************************
' Race Mode Finish
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "CheckRaceModeFinish"
'
'*****************************
Sub CheckRaceModeFinish()
    If GetPlayerState(RACE_MODE_FINISH) = True Then
        SetPlayerState BONUS_RACES_WON, GetPlayerState(BONUS_RACES_WON) + 1
        SetPlayerState RACE_MODE_FINISH, False
        Select Case GetPlayerState(RACE_MODE_SELECTION):
            Case 1: 
                SetPlayerState RACE_1, 1
            Case 2
                SetPlayerState RACE_2, 1
            Case 3:
                SetPlayerState RACE_3, 1
            Case 4:
                SetPlayerState RACE_4, 1
            Case 5:
                SetPlayerState RACE_5, 1
            Case 6:
                SetPlayerState RACE_6, 1
        End Select
        RaceModeTimerEnded
        MusicOn
    End If

End Sub

'****************************
' Race Mode Finish
' Event Listeners:      
    RegisterPlayerStateEvent RACE_MODE_FINISH, "RaceModeFinish"
'
'*****************************
Sub RaceModeFinish()
    If GetPlayerState(RACE_MODE_FINISH) = True Then
        lightCtrl.AddLightSeq "RaceMode", lSeqModeFinish
    End If
End Sub


'****************************
' RaceMode3Spinner1Hit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_SPINNER1, "RaceMode3Spinner1Hit"
'
'*****************************
Sub RaceMode3Spinner1Hit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 3 AND GetPlayerState(RACE_MODE_3_SHOT) = 0 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode3LeftOrbitHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_LEFT_ORBIT, "RaceMode3LeftOrbitHit"
'
'*****************************
Sub RaceMode3LeftOrbitHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 3 AND GetPlayerState(RACE_MODE_3_SHOT) = 1 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode3LeftRampHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "RaceMode3LeftRampHit"
'
'*****************************
Sub RaceMode3LeftRampHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 3 AND GetPlayerState(RACE_MODE_3_SHOT) = 2 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode3Spinner2Hit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_SPINNER2, "RaceMode3Spinner2Hit"
'
'*****************************
Sub RaceMode3Spinner2Hit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 3 AND GetPlayerState(RACE_MODE_3_SHOT) = 3 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode3RightRampHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "RaceMode3RightRampHit"
'
'*****************************
Sub RaceMode3RightRampHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 3 AND GetPlayerState(RACE_MODE_3_SHOT) = 4 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode3RightOrbitHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_RIGHT_ORBIT, "RaceMode3RightOrbitHit"
'
'*****************************
Sub RaceMode3RightOrbitHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 3 AND GetPlayerState(RACE_MODE_3_SHOT) = 5 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode3HitsCheck
' Event Listeners:          
RegisterPlayerStateEvent RACE_MODE_3_HITS, "RaceMode3HitsCheck"
'
'*****************************
Sub RaceMode3HitsCheck()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_SELECTION) = 3 Then
        If GetPlayerState(RACE_MODE_3_HITS) = 3 Then
            lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
        End If
        If GetPlayerState(RACE_MODE_3_HITS) = 6 Then
            lightCtrl.RemoveShot "RaceMode3", l48
            lightCtrl.RemoveShot "RaceMode3", l46
            lightCtrl.RemoveShot "RaceMode3", l47
            lightCtrl.RemoveShot "RaceMode3", l23
            lightCtrl.RemoveShot "RaceMode3", l64
            lightCtrl.RemoveShot "RaceMode3", l63
            RaceModeTimer.Enabled = False
            SetPlayerState RACE_MODE_FINISH, True
        End If
    End If
End Sub

Sub RaceModeTimer_Timer()

    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_SELECTION) = 3 Then
        lightCtrl.RemoveShot "RaceMode3", l48
        lightCtrl.RemoveShot "RaceMode3", l46
        lightCtrl.RemoveShot "RaceMode3", l47
        lightCtrl.RemoveShot "RaceMode3", l23
        lightCtrl.RemoveShot "RaceMode3", l64
        lightCtrl.RemoveShot "RaceMode3", l63
        Dim shotCount : shotCount = GetPlayerState(RACE_MODE_3_SHOT)
        If shotCount = 5 Then
            SetPlayerState RACE_MODE_3_SHOT, 0
        Else
            SetPlayerState RACE_MODE_3_SHOT, shotCount + 1
        End If

        Select Case GetPlayerState(RACE_MODE_3_SHOT):
            Case 0: 
                lightCtrl.AddShot "RaceMode3", l48, GAME_RACE_COLOR
            Case 1
                lightCtrl.AddShot "RaceMode3", l46, GAME_RACE_COLOR
            Case 2:
                lightCtrl.AddShot "RaceMode3", l47, GAME_RACE_COLOR
            Case 3:
                lightCtrl.AddShot "RaceMode3", l23, GAME_RACE_COLOR
            Case 4:
                lightCtrl.AddShot "RaceMode3", l64, GAME_RACE_COLOR
            Case 5:
                lightCtrl.AddShot "RaceMode3", l63, GAME_RACE_COLOR
        End Select

    End If
End Sub



'****************************
' RaceMode4LeftOrbitHit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_LEFT_ORBIT, "RaceMode4LeftOrbitHit"
'
'*****************************
Sub RaceMode4LeftOrbitHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 4 And lightCtrl.IsShotLit("RaceMode4a", l46) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_4_HITS, GetPlayerState(RACE_MODE_4_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode4RightOrbitHit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_RIGHT_ORBIT, "RaceMode4RightOrbitHit"
'
'*****************************
Sub RaceMode4RightOrbitHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 4 And lightCtrl.IsShotLit("RaceMode4b", l63) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_4_HITS, GetPlayerState(RACE_MODE_4_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode4NodesHit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_NODE_A, "RaceMode4NodesHit"
    RegisterPinEvent SWITCH_HIT_NODE_B, "RaceMode4NodesHit"
    RegisterPinEvent SWITCH_HIT_NODE_C, "RaceMode4NodesHit"
'
'*****************************
Sub RaceMode4NodesHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 4 And (GetPlayerState(RACE_MODE_4_HITS) = 2 Or GetPlayerState(RACE_MODE_4_HITS) = 5) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
            SetPlayerState RACE_MODE_4_HITS, GetPlayerState(RACE_MODE_4_HITS) + 1
        End If
    End If
End Sub

'****************************
' RaceMode4HitsCheck
' Event Listeners:          
RegisterPlayerStateEvent RACE_MODE_4_HITS, "RaceMode4HitsCheck"
'
'*****************************
Sub RaceMode4HitsCheck()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_SELECTION) = 4 Then
        If GetPlayerState(RACE_MODE_4_HITS) = 2 Then
            lightCtrl.RemoveShot "RaceMode4b", l63
            lightCtrl.RemoveShot "RaceMode4a", l46
            lightCtrl.AddLightSeq "RaceMode", lSeqRaceMode4Nodes
        End If
        If GetPlayerState(RACE_MODE_4_HITS) = 3 Then
            lightCtrl.AddShot "RaceMode4a", l46, GAME_RACE_COLOR
            lightCtrl.AddShot "RaceMode4b", l63, GAME_RACE_COLOR
            lightCtrl.RemoveLightSeq "RaceMode", lSeqRaceMode4Nodes
            lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
        End If
        If GetPlayerState(RACE_MODE_4_HITS) = 5 Then
            lightCtrl.RemoveShot "RaceMode4b", l63
            lightCtrl.RemoveShot "RaceMode4a", l46
            lightCtrl.AddLightSeq "RaceMode", lSeqRaceMode4Nodes
        End If
        If GetPlayerState(RACE_MODE_4_HITS) = 6 Then
            lightCtrl.RemoveShot "RaceMode4b", l63
            lightCtrl.RemoveShot "RaceMode4a", l46
            lightCtrl.RemoveLightSeq "RaceMode", lSeqRaceMode4Nodes
            SetPlayerState RACE_MODE_FINISH, True
        End If
    End If
End Sub