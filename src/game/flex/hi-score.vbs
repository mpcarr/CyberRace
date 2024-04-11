
Sub FlexDMDHiScoreScene()
    Exit Sub
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "hiscore"
        .Duration = 30
        .BGImage = "BGBlack"
        .BGVideo = "novideo"
        .Replacements = Array("GetGameSelectionTimerValue")
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
    qItem.AddLabel "INITIAL_1", 		Font12, DMDWidth*.25, DMDHeight/2, DMDWidth*.25, DMDHeight/2, b1
    qItem.AddLabel "INITIAL_2", 		Font12, DMDWidth*.5, DMDHeight/2, DMDWidth*.5, DMDHeight/2, b2
    qItem.AddLabel "INITIAL_3", 		Font12, DMDWidth*.75, DMDHeight/2, DMDWidth*.75, DMDHeight/2, b3
    qItem.AddLabel "$1", 		Font7, DMDWidth*.9, DMDHeight*.8, DMDWidth*.9, DMDHeight*.8, ""
    DmdQ.Enqueue qItem

End Sub