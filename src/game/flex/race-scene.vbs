
Sub FlexDMDRaceSelectScene()
    DmdQ.RemoveAll()
    Dim r1,r2,r3,r4,racesComplete, progressComplete
    r1 = GetPlayerState(RACE_1)
    r2 = GetPlayerState(RACE_2)
    r3 = GetPlayerState(RACE_3)
    r4 = GetPlayerState(RACE_4)
    racesComplete = (r1+r2+r3+r4)
    
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "raceselect"
        .Duration = 15
        .BGImage = "BG001"    
        .BGVideo = "novideo"
        .Callback = "CallbackGameTimersSelection15Secs"
        .Replacements = Array("GetRaceLabelForFlexScene", "GetGameSelectionTimerValue")
    End With
    Dim gameModeTitle
    Dim selection : selection = GetPlayerState(RACE_MODE_SELECTION)
    gameModeTitle = GAME_RACE_MODE_DESC(selection-1)
    If racesComplete < 4 And (selection = 5 Or selection = 6) Then
        gameModeTitle = "LOCKED"
    End If
    qItem.AddLabel GAME_RACE_MODE_TITLES(selection-1), 		    FlexDMD.NewFont(DMDFontMain, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.35, DMDWidth/2, DMDHeight*.35, ""
    qItem.AddLabel "<", 		                                FlexDMD.NewFont(DMDFontSmall, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth*.1, DMDHeight*.3, DMDWidth*.1, DMDHeight*.3, "blink"
    qItem.AddLabel ">", 		                                FlexDMD.NewFont(DMDFontSmall, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth*.9, DMDHeight*.3, DMDWidth*.9, DMDHeight*.3, "blink"
    If gameModeTitle = "LOCKED" Then
        qItem.AddLabel "LOCKED", 		                        Font7, DMDWidth/2, DMDHeight*.75, DMDWidth/2, DMDHeight*.75, ""
    Else
        qItem.AddLabel "$1", 		                        Font7, DMDWidth/2, DMDHeight*.75, DMDWidth/2, DMDHeight*.75, ""
    End If
    qItem.AddLabel "$2", 		Font7, DMDWidth*.9, DMDHeight*.8, DMDWidth*.9, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
    
End Sub

Function GetGameSelectionTimerValue()
    GetGameSelectionTimerValue = Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10) & "" & Int(GameTimers(GAME_SELECTION_TIMER_IDX)-Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10)*10)
End Function

Sub CallbackGameTimersSelection15Secs
    GameTimers(GAME_SELECTION_TIMER_IDX) = 15
End Sub

Function GetRaceLabelForFlexScene()
    If gameTime MOD 2000 < 1000 Then 
        Select Case GetPlayerState(RACE_MODE_SELECTION):
            Case 1: 
                If GetPlayerState(RACE_MODE_1_HITS) >= 6 Then
                    progressComplete = "FINAL SHOT"
                Else
                    progressComplete = GetPlayerState(RACE_MODE_1_HITS) & "/6 COMPLETE"
                End If
            Case 2: 
                Dim spinComplete : spinComplete = 0
                If GetPlayerState(RACE_MODE_2_SPIN1) >= 30 Then
                    spinComplete = spinComplete + 1
                End If
                If GetPlayerState(RACE_MODE_2_SPIN2) >= 30 Then
                    spinComplete = spinComplete + 1
                End If
                If spinComplete = 2 Then
                    progressComplete = "FINAL SHOT"
                Else
                    progressComplete = CStr(spinComplete) & "/2 COMPLETE"
                End If
            Case 3: 
                If GetPlayerState(RACE_MODE_3_HITS) >= 6 Then
                    progressComplete = "FINAL SHOT"
                Else
                    progressComplete = GetPlayerState(RACE_MODE_3_HITS) & "/6 COMPLETE"
                End If
            Case 4: 
                If GetPlayerState(RACE_MODE_4_HITS) >= 6 Then
                    progressComplete = "FINAL SHOT"
                Else
                    progressComplete = GetPlayerState(RACE_MODE_4_HITS) & "/6 COMPLETE"
                End If
            Case 5: 
                If GetPlayerState(RACE_MODE_5_HITS) >= 6 Then
                    progressComplete = "FINAL SHOT"
                Else
                    progressComplete = GetPlayerState(RACE_MODE_5_HITS) & "/6 COMPLETE"
                End If
            Case 6: 
                If GetPlayerState(RACE_MODE_6_HITS) >= 6 Then
                    progressComplete = "FINAL SHOT"
                Else
                    progressComplete = GetPlayerState(RACE_MODE_6_HITS) & "/6 COMPLETE"
                End If
        End Select 
        GetRaceLabelForFlexScene = progressComplete
    Else
        GetRaceLabelForFlexScene = GAME_RACE_MODE_DESC(GetPlayerState(RACE_MODE_SELECTION)-1)
    End If
End Function