

Sub InitDMDRaceReadyScene()
    DMDRaceReadyScene.AddActor DMDRaceReadyVid
End Sub

Sub InitDMDRaceSelectScene()
    Dim lbl1 : Set lbl1 = FlexDMD.NewLabel("lblRaceTitle", font20Outline, "RACE X VS RIDLEY")
    Dim lbl2 : Set lbl2 = FlexDMD.NewLabel("lblRaceDescription", font20Outline, "Hit 6 Ramp Shots")
	lbl1.SetAlignedPosition 128, 24, FlexDMD_Align_Center
    lbl2.SetAlignedPosition 128, 42, FlexDMD_Align_Center
    DMDRaceSelectScene.AddActor lbl1
    DMDRaceSelectScene.AddActor lbl2
End Sub

Sub FlexDMDRaceReadyScene()
   
End Sub


Sub FlexDMDRaceSelectScene()
    DmdQ.RemoveAll()
    Dim selection : selection = GetPlayerState(RACE_MODE_SELECTION)
    Select Case selection:
        Case 1: 
            bgVideo = "BGRace1"
        Case 2: 
            bgVideo = "BGRace2"
        Case 3: 
            bgVideo = "BGRace3"
        Case 4: 
            bgVideo = "BGRace4"
        Case 5: 
            bgVideo = "BGRaceLocked"
        Case 6: 
            bgVideo = "BGRaceLocked"                        
    End Select  
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "raceselect"
        .Duration = 15
        .Title = "Rykar - 6 Ramps Shots"
        .Message = "GetPlayerState(EMPTY_STR) & Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10) & """" & Int(GameTimers(GAME_SELECTION_TIMER_IDX)-Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10)*10)"
        .Font = FontCyber32        
        .MessageFont = FontCyber5
        .StartPos = Array(DMDWidth*1.5,DMDHeight/2)
        .EndPos = Array(0-DMDWidth,DMDHeight/2)
        .Action = "noslide2blink"
        .BGImage = "BG001"    
        .BGVideo = "novideo"
        .Callback = "GameTimers(GAME_SELECTION_TIMER_IDX) = 15"
    End With
    DmdQ.Enqueue qItem

End Sub