




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
        .BGImage = "BG001"    
        .BGVideo = "novideo"
        .Callback = "GameTimers(GAME_SELECTION_TIMER_IDX) = 15"
    End With
    qItem.AddLabel GAME_RACE_MODE_TITLES(selection-1), 		    FlexDMD.NewFont(DMDFontMain, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.35, DMDWidth/2, DMDHeight*.35, ""
    qItem.AddLabel "<", 		                                FlexDMD.NewFont(DMDFontSmall, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth*.1, DMDHeight*.3, DMDWidth*.1, DMDHeight*.3, "blink"
    qItem.AddLabel ">", 		                                FlexDMD.NewFont(DMDFontSmall, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth*.9, DMDHeight*.3, DMDWidth*.9, DMDHeight*.3, "blink"
    qItem.AddLabel GAME_RACE_MODE_DESC(selection-1), 		                        Font7, DMDWidth/2, DMDHeight*.75, DMDWidth/2, DMDHeight*.75, ""
    qItem.AddLabel "GetPlayerState(EMPTY_STR) & Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10) & """" & Int(GameTimers(GAME_SELECTION_TIMER_IDX)-Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10)*10)", 		Font7, DMDWidth*.9, DMDHeight*.8, DMDWidth*.9, DMDHeight*.8, ""

    DmdQ.Enqueue qItem

End Sub