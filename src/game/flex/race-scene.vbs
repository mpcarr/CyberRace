
Sub FlexDMDRaceSelectScene()
    DmdQ.RemoveAll()
    Dim r1,r2,r3,r4,racesComplete
    r1 = GetPlayerState(RACE_1)
    r2 = GetPlayerState(RACE_2)
    r3 = GetPlayerState(RACE_3)
    r4 = GetPlayerState(RACE_4)
    racesComplete = (r1+r2+r3+r4)
    Dim selection : selection = GetPlayerState(RACE_MODE_SELECTION)
    debug.print(racesComplete)
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
            If racesComplete < 4 Then bgVideo = "BGRaceLocked" Else bgVideo = "BGRace5" End If
        Case 6: 
            If racesComplete < 4 Then bgVideo = "BGRaceLocked" Else bgVideo = "BGRace6" End If
    End Select  
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "raceselect"
        .Duration = 15
        .BGImage = "BG001"    
        .BGVideo = "novideo"
        .Callback = "GameTimers(GAME_SELECTION_TIMER_IDX) = 15"
    End With
    Dim gameModeTitle
    gameModeTitle = GAME_RACE_MODE_DESC(selection-1)
    If racesComplete < 4 And (selection = 5 Or selection = 6) Then
        gameModeTitle = "LOCKED"
    End If
    qItem.AddLabel GAME_RACE_MODE_TITLES(selection-1), 		    FlexDMD.NewFont(DMDFontMain, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.35, DMDWidth/2, DMDHeight*.35, ""
    qItem.AddLabel "<", 		                                FlexDMD.NewFont(DMDFontSmall, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth*.1, DMDHeight*.3, DMDWidth*.1, DMDHeight*.3, "blink"
    qItem.AddLabel ">", 		                                FlexDMD.NewFont(DMDFontSmall, RGB(255, 0,0), RGB(0, 0, 0), 0), DMDWidth*.9, DMDHeight*.3, DMDWidth*.9, DMDHeight*.3, "blink"
    qItem.AddLabel gameModeTitle, 		                        Font7, DMDWidth/2, DMDHeight*.75, DMDWidth/2, DMDHeight*.75, ""
    qItem.AddLabel "GetPlayerState(EMPTY_STR) & Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10) & """" & Int(GameTimers(GAME_SELECTION_TIMER_IDX)-Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10)*10)", 		Font7, DMDWidth*.9, DMDHeight*.8, DMDWidth*.9, DMDHeight*.8, ""

    DmdQ.Enqueue qItem

End Sub

Sub FlexAddTimeScene()

	Set qItem = New QueueItem
	With qItem
		.Name = "addTime"
		.Duration = 2
		.BGImage = "BGBlack"
		.BGVideo = "novideo"
	End With
	qItem.AddLabel "BALL SAVED", 		font12, DMDWidth/2, DMDHeight/2, DMDWidth/2, DMDHeight/2, "blink"
	DmdQ.Enqueue qItem

End Sub