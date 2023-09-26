

Sub FlexDMDNodesCompleteScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nodes-complete"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGNodes"
    End With
    qItem.AddLabel "NODES", 		Font12, DMDWidth*.75, DMDHeight*.25, DMDWidth*.75, DMDHeight*.25, "blink"
    qItem.AddLabel "COMPLETE", 		Font12, DMDWidth*.75, DMDHeight*.75, DMDWidth*.75, DMDHeight*.75, "blink"
    DmdQ.Enqueue qItem
End Sub

Sub FlexDMDNodePerkCollectScene()
    DmdQ.RemoveAll()
    Dim perkLeftTitle,perkLeftDesc,perkRightTitle,perkRightDesc
    Select Case GetPlayerState(NODE_LEVEL):
        Case 2: 
            perkLeftTitle = "JACKPOTS"
            perkLeftDesc = "+250K"
            perkRightTitle = "COLLECT"
            perkRightDesc = "5 MIL"
        Case 3: 
            perkLeftTitle = "RACE"
            perkLeftDesc = "+20 SECS"
            perkRightTitle = "2X BET"
            perkRightDesc = "HURRY UP"
        Case 4: 
            perkLeftTitle = "OUTLANE"
            perkLeftDesc = "SAVES"
            perkRightTitle = "INSTANT"
            perkRightDesc = "MULTIBALL"
        Case 5: 
            perkLeftTitle = "EXTRA"
            perkLeftDesc = "BALL"
            perkRightTitle = "JACKPOTS"
            perkRightDesc = "5X"
        Case 6: 
            perkLeftTitle = "SPOT"
            perkLeftDesc = "G/SLAM"
            perkRightTitle = "MINI"
            perkRightDesc = "WIZARD"
    End Select  
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nodes"
        .Duration = 15
        .BGImage = "BGBlack"
        .BGVideo = "BGNode"
        .Callback = "GameTimers(GAME_SELECTION_TIMER_IDX) = 15"
    End With
    qItem.AddLabel perkLeftTitle, 		    font7, DMDWidth*.2, DMDHeight*.35, DMDWidth*.2, DMDHeight*.35, ""
    qItem.AddLabel perkLeftDesc, 		    font7, DMDWidth*.2, DMDHeight*.65, DMDWidth*.2, DMDHeight*.65, ""

    qItem.AddLabel perkRightTitle, 		    font7, DMDWidth*.8, DMDHeight*.35, DMDWidth*.8, DMDHeight*.35, ""
    qItem.AddLabel perkRightDesc, 		    font7, DMDWidth*.8, DMDHeight*.65, DMDWidth*.8, DMDHeight*.65, ""

    qItem.AddLabel "<", font7, DMDWidth*.4, DMDHeight*.9, DMDWidth*.4, DMDHeight*.9, "blink"
    qItem.AddLabel ">", font7, DMDWidth*.6, DMDHeight*.9, DMDWidth*.6, DMDHeight*.9, "blink"
    qItem.AddLabel "GetPlayerState(EMPTY_STR) & Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10) & """" & Int(GameTimers(GAME_SELECTION_TIMER_IDX)-Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10)*10)", 		Font7, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
   
End Sub