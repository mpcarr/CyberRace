
'****************************
' Check Race Ready
' Event Listeners:  
    RegisterPinEvent SWITCH_HIT_RACE_KICKER, "CheckRaceReady"
'
'*****************************
Sub CheckRaceReady()
    If GetPlayerState(RACE_MODE_READY) = True And RealBallsInPlay = 1 Then
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
        FlexDMDRaceSelectScene()
        calloutsQ.Add "chooserace", "PlayCallout(""choose-race"")", 1, 0, 0, 1200, 0, False
        SetPlayerState RACE_MODE_READY, False
        SetPlayerState MODE_RACE_SELECT, True
    Else
        If GetPlayerState(GRANDSLAM_WIZARD_READY) = False Or (GetPlayerState(GRANDSLAM_WIZARD_READY) = True And RealBallsInPlay > 1) Then
            raceVuk.TimerEnabled = True
        End If
    End If
End Sub

Sub RaceIdleTimer

    If GetPlayerState(MODE_RACE) = True Then
        Select Case GetPlayerState(RACE_MODE_SELECTION):
            Case 1: 
                If GetPlayerState(RACE_MODE_1_HITS) = 6 Then
                    'Callout Go For Finish.
                    'DMD Go For Finish
                Else
                    'Show Progress
                End If
            Case 2
                
                If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 Then
                    
                End If
                If GetPlayerState(RACE_MODE_2_SPIN2) >= 30 Then
                    
                End If
                If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 AND GetPlayerState(RACE_MODE_2_SPIN2) >= 30 Then
                    
                End If                
            Case 3:
                If GetPlayerState(RACE_MODE_3_HITS) = 6 Then
                    
                Else
                    
                End If
            Case 4:
                
            Case 5:
                
            Case 6:
                If GetPlayerState(RACE_MODE_6_HITS) = 5 Then
                
                Else
                
                End If
        End Select
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
' RaceSelectCycleRight
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
        Dim r1,r2,r3,r4
        r1 = GetPlayerState(RACE_1)
        r2 = GetPlayerState(RACE_2)
        r3 = GetPlayerState(RACE_3)
        r4 = GetPlayerState(RACE_4)
        If (r1+r2+r3+r4)<4 And (selection = 5 Or selection = 6) Then
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
                RaceMode5HitsCheck()
            Case 6:
                If GetPlayerState(RACE_MODE_6_HITS) = 5 Then
                    SetPlayerState RACE_MODE_FINISH, True
                Else
                    lightCtrl.AddShot "RaceMode6", l23, GAME_RACE_COLOR
                    lightCtrl.AddShot "RaceMode6", l46, GAME_RACE_COLOR
                    lightCtrl.AddShot "RaceMode6", l47, GAME_RACE_COLOR
                    lightCtrl.AddShot "RaceMode6", l63, GAME_RACE_COLOR
                    lightCtrl.AddShot "RaceMode6", l64, GAME_RACE_COLOR
                End If
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
                    
            End Select
            lightCtrl.RemoveShot GAME_SHOT_SHORTCUT, l65
            SetPlayerState RACE_MODE_FINISH, True
            calloutsQ.Add "finishrace", "PlayCallout(""finishrace"")", 1, 0, 0, 2200, 0, False
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_1_HITS, GetPlayerState(RACE_MODE_1_HITS) + 1
            Dim qItem : Set qItem = New QueueItem
            With qItem
                .Name = "racemsg"
                .Duration = 4
                .BGImage = "BG004"
                .BGVideo = "novideo"
                .Action = "slideup"
            End With
            qItem.AddLabel "6-GetPlayerState(RACE_MODE_1_HITS) & "" More Shots Left""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
            DmdQ.Enqueue qItem
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
            calloutsQ.Add "shortcut", "PlayCallout(""shortcut"")", 1, 0, 0, 1200, 0, False
        End If
        If GetPlayerState(RACE_MODE_1_HITS) = 6 Then
            lightCtrl.RemoveShot "RaceMode1a", l47
            lightCtrl.RemoveShot "RaceMode1b", l64
            SetPlayerState RACE_MODE_FINISH, True
            calloutsQ.Add "finishrace", "PlayCallout(""finishrace"")", 1, 0, 0, 2200, 0, False
        End If
    End If
End Sub

'****************************
' RaceModeTimerHurry
' Event Listeners:          
RegisterPinEvent GAME_RACE_TIMER_HURRY, "RaceModeTimerHurry"
'
'*****************************
Sub RaceModeTimerHurry()
    If GetPlayerState(MODE_RACE) = True Then
        lightCtrl.AddShot "AddTime", l98, RGB(12,100,250)
    End If
End Sub

'****************************
' RaceModeAddTime
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_ADDTIME, "RaceModeAddTime"
'
'*****************************
Sub RaceModeAddTime()
    If GetPlayerState(MODE_RACE) = True And lightCtrl.IsShotLit("AddTime", l98) = True Then
        GameTimers(GAME_RACE_TIMER_IDX) = GameTimers(GAME_RACE_TIMER_IDX) + 12
        lightCtrl.RemoveShot "AddTime", l98
        Dim qItem : Set qItem = New QueueItem
        With qItem
            .Name = "racemsg"
            .Duration = 3
            .BGImage = "BG004"
            .BGVideo = "novideo"
            .Action = "slideup"
        End With
        qItem.AddLabel "+12 Seconds Added", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
        DmdQ.Enqueue qItem
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
                lightCtrl.RemoveShot "RaceMode5", l47
                lightCtrl.RemoveShot "RaceMode5", l64
                lightCtrl.RemoveLightSeq "RaceMode", lSeqRaceMode4Nodes
            Case 6:
                lightCtrl.RemoveShot "RaceMode6", l48
                lightCtrl.RemoveShot "RaceMode6", l23
                lightCtrl.RemoveShot "RaceMode6", l46
                lightCtrl.RemoveShot "RaceMode6", l63

        End Select
        lightCtrl.RemoveShot GAME_SHOT_SHORTCUT, l65
        lightCtrl.RemoveShot "AddTime", l98
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
        If GetPlayerState(RACE_MODE_SELECTION) = 2  AND GetPlayerState(RACE_MODE_2_SPIN1) < 30  Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_2_SPIN1, GetPlayerState(RACE_MODE_2_SPIN1) + 1
            Dim qItem : Set qItem = New QueueItem
            With qItem
                .Name = "racemsg"
                .Duration = 2
                .BGImage = "BG004"
                .BGVideo = "novideo"
                .Action = "slideup"
            End With
            qItem.AddLabel "30-GetPlayerState(RACE_MODE_2_SPIN1) & "" Spins to Complete""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
            DmdQ.Enqueue qItem
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
        If GetPlayerState(RACE_MODE_SELECTION) = 2 AND GetPlayerState(RACE_MODE_2_SPIN2) < 30 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_2_SPIN2, GetPlayerState(RACE_MODE_2_SPIN2) + 1
            Dim qItem : Set qItem = New QueueItem
            With qItem
                .Name = "racemsg"
                .Duration = 2
                .BGImage = "BG004"
                .BGVideo = "novideo"
                .Action = "slideup"
            End With
            qItem.AddLabel "30-GetPlayerState(RACE_MODE_2_SPIN2) & "" Spins to Complete""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
            DmdQ.Enqueue qItem
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
        If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 And lightCtrl.IsShotLit(GAME_SHOT_SHORTCUT, l65)=False Then
            lightCtrl.RemoveShot "RaceMode2a", l48    
            lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
            calloutsQ.Add "shortcut", "PlayCallout(""shortcut"")", 1, 0, 0, 1200, 0, False
        End If
        If GetPlayerState(RACE_MODE_2_SPIN2) >= 30  And lightCtrl.IsShotLit(GAME_SHOT_SHORTCUT, l65)=False Then
            lightCtrl.RemoveShot "RaceMode2b", l23    
            lightCtrl.AddShot GAME_SHOT_SHORTCUT, l65, GAME_NORMAL_COLOR
            calloutsQ.Add "shortcut", "PlayCallout(""shortcut"")", 1, 0, 0, 1200, 0, False
        End If
        If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 AND GetPlayerState(RACE_MODE_2_SPIN2) >= 30 AND GetPlayerState(RACE_MODE_FINISH) = False Then
            lightCtrl.RemoveShot "RaceMode2a", l48
            lightCtrl.RemoveShot "RaceMode2b", l23
            lightCtrl.RemoveShot GAME_SHOT_SHORTCUT, l65
            SetPlayerState RACE_MODE_FINISH, True
            calloutsQ.Add "finishrace", "PlayCallout(""finishrace"")", 1, 0, 0, 2200, 0, False
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


Sub RaceMode3DmdMsg()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "racemsg"
        .Duration = 4
        .BGImage = "BG004"
        .BGVideo = "novideo"
        .Action = "slideup"
    End With
    qItem.AddLabel "6 - GetPlayerState(RACE_MODE_3_HITS) & "" More Shots Left""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
    DmdQ.Enqueue qItem
End Sub

Sub RaceMode4DmdMsg()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "racemsg"
        .Duration = 4
        .BGImage = "BG004"
        .BGVideo = "novideo"
        .Action = "slideup"
    End With
    qItem.AddLabel "6-GetPlayerState(RACE_MODE_4_HITS) & "" More Shots Left""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
    DmdQ.Enqueue qItem
End Sub

Sub RaceMode6DmdMsg()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "racemsg"
        .Duration = 4
        .BGImage = "BG004"
        .BGVideo = "novideo"
        .Action = "slideup"
    End With
    qItem.AddLabel "6- GetPlayerState(RACE_MODE_6_HITS) & "" More Shots Left""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
    DmdQ.Enqueue qItem
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
            RaceMode3DmdMsg()
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
            RaceMode3DmdMsg()
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
            RaceMode3DmdMsg()
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
            RaceMode3DmdMsg()
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
            RaceMode3DmdMsg()
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_3_HITS, GetPlayerState(RACE_MODE_3_HITS) + 1
            RaceMode3DmdMsg()
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
            calloutsQ.Add "shortcut", "PlayCallout(""shortcut"")", 1, 0, 0, 1200, 0, False
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
            calloutsQ.Add "finishrace", "PlayCallout(""finishrace"")", 1, 0, 0, 2200, 0, False
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_4_HITS, GetPlayerState(RACE_MODE_4_HITS) + 1
            RaceMode4DmdMsg()
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_4_HITS, GetPlayerState(RACE_MODE_4_HITS) + 1
            RaceMode4DmdMsg()
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
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_4_HITS, GetPlayerState(RACE_MODE_4_HITS) + 1
            RaceMode4DmdMsg()
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
            calloutsQ.Add "shortcut", "PlayCallout(""shortcut"")", 1, 0, 0, 1200, 0, False
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
            calloutsQ.Add "finishrace", "PlayCallout(""finishrace"")", 1, 0, 0, 2200, 0, False
        End If
    End If
End Sub





'****************************
' RaceMode6LeftOrbitHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_LEFT_ORBIT, "RaceMode6LeftOrbitHit"
'
'*****************************
Sub RaceMode6LeftOrbitHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 6 AND lightCtrl.IsShotLit("RaceMode6", l46) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_6_HITS, GetPlayerState(RACE_MODE_6_HITS) + 1
            lightCtrl.RemoveShot "RaceMode6", l46
            RaceMode6DmdMsg()
        End If
    End If
End Sub

'****************************
' RaceMode6LeftRampHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "RaceMode6LeftRampHit"
'
'*****************************
Sub RaceMode6LeftRampHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 6 AND lightCtrl.IsShotLit("RaceMode6", l47) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_6_HITS, GetPlayerState(RACE_MODE_6_HITS) + 1
            lightCtrl.RemoveShot "RaceMode6", l47
            RaceMode6DmdMsg()
        End If
    End If
End Sub

'****************************
' RaceMode6RightOrbitHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_RIGHT_ORBIT, "RaceMode6RightOrbitHit"
'
'*****************************
Sub RaceMode6RightOrbitHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 6 AND lightCtrl.IsShotLit("RaceMode6", l63) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_6_HITS, GetPlayerState(RACE_MODE_6_HITS) + 1
            lightCtrl.RemoveShot "RaceMode6", l63
            RaceMode6DmdMsg()
        End If
    End If
End Sub

'****************************
' RaceMode6RightRampHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "RaceMode6RightRampHit"
'
'*****************************
Sub RaceMode6RightRampHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 6 AND lightCtrl.IsShotLit("RaceMode6", l64) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_6_HITS, GetPlayerState(RACE_MODE_6_HITS) + 1
            lightCtrl.RemoveShot "RaceMode6", l64
            RaceMode6DmdMsg()
        End If
    End If
End Sub

'****************************
' RaceMode6SpinnerHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_SPINNER2, "RaceMode6SpinnerHit"
'
'*****************************
Sub RaceMode6SpinnerHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 6 AND GetPlayerState(RACE_MODE_6_SPIN2) < 30 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_6_SPIN2, GetPlayerState(RACE_MODE_6_SPIN2) + 1

            If GetPlayerState(RACE_MODE_6_SPIN2) = 30 Then
                lightCtrl.RemoveShot "RaceMode6", l23
                SetPlayerState RACE_MODE_6_HITS, GetPlayerState(RACE_MODE_6_HITS) + 1
            Else
                Dim qItem : Set qItem = New QueueItem
                With qItem
                    .Name = "racemsg"
                    .Duration = 2
                    .BGImage = "BG004"
                    .BGVideo = "novideo"
                    .Action = "slideup"
                End With
                qItem.AddLabel "30-GetPlayerState(RACE_MODE_6_SPIN2) & "" Spins to Complete""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
                DmdQ.Enqueue qItem
            End If
        End If
    End If
End Sub

'****************************
' RaceMode6HitsCheck
' Event Listeners:          
RegisterPlayerStateEvent RACE_MODE_6_HITS, "RaceMode6HitsCheck"
'
'*****************************
Sub RaceMode6HitsCheck()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_SELECTION) = 6 Then
        If GetPlayerState(RACE_MODE_6_HITS) = 5 Then
            lightCtrl.RemoveShot "RaceMode6", l46
            lightCtrl.RemoveShot "RaceMode6", l47
            lightCtrl.RemoveShot "RaceMode6", l23
            lightCtrl.RemoveShot "RaceMode6", l64
            lightCtrl.RemoveShot "RaceMode6", l63
            SetPlayerState RACE_MODE_FINISH, True
            calloutsQ.Add "finishrace", "PlayCallout(""finishrace"")", 1, 0, 0, 2200, 0, False
        End If
    End If
End Sub



'****************************
' RaceMode5RampHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "RaceMode5RampHit"
RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "RaceMode5RampHit"
'
'*****************************
Sub RaceMode5RampHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 5 Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_5_HITS, GetPlayerState(RACE_MODE_5_HITS) + 1
            Dim qItem : Set qItem = New QueueItem
            With qItem
                .Name = "racemsg"
                .Duration = 4
                .BGImage = "BG004"
                .BGVideo = "novideo"
                .Action = "slideup"
            End With
            qItem.AddLabel "6-GetPlayerState(RACE_MODE_5_HITS) & "" More Shots Left""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub


'****************************
' RaceMode5NodesHit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_NODE_A, "RaceMode5NodesHit"
RegisterPinEvent SWITCH_HIT_NODE_B, "RaceMode5NodesHit"
RegisterPinEvent SWITCH_HIT_NODE_C, "RaceMode5NodesHit"
'
'*****************************
Sub RaceMode5NodesHit()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_FINISH) = False Then
        If GetPlayerState(RACE_MODE_SELECTION) = 5 And (GetPlayerState(RACE_MODE_5_HITS) = 1 Or GetPlayerState(RACE_MODE_5_HITS) = 3 Or GetPlayerState(RACE_MODE_5_HITS) = 5) Then
            AddScore POINTS_MODE_SHOT
            lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed : DOF 300, DOFPulse
            SetPlayerState RACE_MODE_5_HITS, GetPlayerState(RACE_MODE_5_HITS) + 1
            Dim qItem : Set qItem = New QueueItem
            With qItem
                .Name = "racemsg"
                .Duration = 4
                .BGImage = "BG004"
                .BGVideo = "novideo"
                .Action = "slideup"
            End With
            qItem.AddLabel "6-GetPlayerState(RACE_MODE_5_HITS) & "" More Shots Left""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub


'****************************
' RaceMode5HitsCheck
' Event Listeners:          
RegisterPlayerStateEvent RACE_MODE_5_HITS, "RaceMode5HitsCheck"
'
'*****************************
Sub RaceMode5HitsCheck()
    If GetPlayerState(MODE_RACE) = True And GetPlayerState(RACE_MODE_SELECTION) = 5 Then
        If GetPlayerState(RACE_MODE_5_HITS) = 6 Then
            lightCtrl.RemoveShot "RaceMode5", l47
            lightCtrl.RemoveShot "RaceMode5", l64   
            lightCtrl.RemoveLightSeq "RaceMode", lSeqRaceMode4Nodes
            SetPlayerState RACE_MODE_FINISH, True
            calloutsQ.Add "finishrace", "PlayCallout(""finishrace"")", 1, 0, 0, 2200, 0, False
        Else
            If GetPlayerState(RACE_MODE_5_HITS) Mod 2 = 0 Then
                'Even Shot
                lightCtrl.AddShot "RaceMode5", l47, GAME_RACE_COLOR
                lightCtrl.AddShot "RaceMode5", l64, GAME_RACE_COLOR
                lightCtrl.RemoveLightSeq "RaceMode", lSeqRaceMode4Nodes
            Else
                'Odd Shot
                lightCtrl.AddLightSeq "RaceMode", lSeqRaceMode4Nodes
                lightCtrl.RemoveShot "RaceMode5", l47
                lightCtrl.RemoveShot "RaceMode5", l64
            End If

        End If
    End If
End Sub
