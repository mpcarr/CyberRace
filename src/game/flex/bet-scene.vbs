
Sub FlexDMDBetScene(bb,eb,tb)
    
	dim b,e,t
	If GetPlayerState(BET_1) = 1 Then 
        Set b = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set b = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If
	
    If GetPlayerState(BET_2) = 1 Then 
        Set e = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set e = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If

    If GetPlayerState(BET_3) = 1 Then 
        Set t = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set t = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If

 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "bet"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGCyber"
		.Action = "slidedown"
    End With
    qItem.AddLabel "B", 		b, DMDWidth*.25, DMDHeight/2, DMDWidth*.25, DMDHeight/2, bb
    qItem.AddLabel "E", 		e, DMDWidth*.5, DMDHeight/2, DMDWidth*.5, DMDHeight/2, eb
    qItem.AddLabel "T", 		t, DMDWidth*.75, DMDHeight/2, DMDWidth*.75, DMDHeight/2, tb
    DmdQ.Enqueue qItem
End Sub

Sub FlexDMDBetModeScene()
 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "bet-mode"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBetMode"
		.Action = "slidedown"
    End With
    DmdQ.Enqueue qItem
End Sub

Sub FlexDMDBetModeCollectedScene()
	dim bValue : bValue = FormatScore(GetPlayerState(BET_VALUE))
 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "bet-collected"
        .Duration = 2
        .BGImage = "BG001"
        .BGVideo = "novideo"
		.Action = "slidedown"
    End With
	qItem.AddLabel "BET COLLECTED", 		                        Font5, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, "blink"
    qItem.AddLabel bValue, 		Font12, DMDWidth/2, DMDHeight*.7, DMDWidth/2, DMDHeight*.7, "blink"
    DmdQ.Enqueue qItem
End Sub
