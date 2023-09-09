
Sub FlexDMDHiScoreScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "hiscore"
        .Duration = 30
        .BGImage = "BGBlack"
        .BGVideo = "novideo"
    End With
    qItem.AddLabel "HI SCORE", 		Font7, DMDWidth/2, DMDHeight*.15, DMDWidth/2, DMDHeight*.15, ""
    Dim b1,b2,b3
    b1 = "" : b2 = "" : b3 = ""
    Select Case GetPlayerState(INITIAL_POSITION):
        Case 0: 
            b1 = "blink"
        Case 1: 
            b2 = "blink"
        Case 2: 
            b3 = "blink"
    End Select  
    qItem.AddLabel "GetPlayerState(INITIAL_1)", 		Font12, DMDWidth*.25, DMDHeight/2, DMDWidth*.25, DMDHeight/2, b1
    qItem.AddLabel "GetPlayerState(INITIAL_2)", 		Font12, DMDWidth*.5, DMDHeight/2, DMDWidth*.5, DMDHeight/2, b2
    qItem.AddLabel "GetPlayerState(INITIAL_3)", 		Font12, DMDWidth*.75, DMDHeight/2, DMDWidth*.75, DMDHeight/2, b3
    qItem.AddLabel "GetPlayerState(EMPTY_STR) & Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10) & """" & Int(GameTimers(GAME_SELECTION_TIMER_IDX)-Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10)*10)", 		Font7, DMDWidth*.9, DMDHeight*.8, DMDWidth*.9, DMDHeight*.8, ""
    DmdQ.Enqueue qItem

End Sub