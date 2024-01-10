
Sub FlexDMDCyberScene(cb,yb,bb,eb,rb)
    
	dim c,y,b,e,r
	If GetPlayerState(CYBER_C) = 1 Then 
        Set c = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set c = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If
	
    If GetPlayerState(CYBER_Y) = 1 Then 
        Set y = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set y = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If

    If GetPlayerState(CYBER_B) = 1 Then 
        Set b = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set b = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If

    If GetPlayerState(CYBER_E) = 1 Then 
        Set e = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set e = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If

    If GetPlayerState(CYBER_R) = 1 Then 
        Set r = FlexDMD.NewFont(DMDFontBig, RGB(1, 244, 255), RGB(0, 0, 0), 0)
    Else
        Set r = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
    End If


 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "cyber"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGCyber"
        .Action = "slidedown"
    End With
    qItem.AddLabel "C", 		c, DMDWidth*.166, DMDHeight*.4, DMDWidth*.166, DMDHeight*.4, cb
    qItem.AddLabel "Y", 		y, DMDWidth*.333, DMDHeight*.4, DMDWidth*.333, DMDHeight*.4, yb
    qItem.AddLabel "B", 		b, DMDWidth*.499, DMDHeight*.4, DMDWidth*.499, DMDHeight*.4, bb
    qItem.AddLabel "E", 		e, DMDWidth*.665, DMDHeight*.4, DMDWidth*.665, DMDHeight*.4, eb
    qItem.AddLabel "R", 		r, DMDWidth*.831, DMDHeight*.4, DMDWidth*.831, DMDHeight*.4, rb
    qItem.AddLabel "INCREASES SHOT VALUE", FontWhite3, DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, ""
    DmdQ.Enqueue qItem

    lightCtrl.pulse l29, 0
    lightCtrl.pulse l30, 0
    lightCtrl.pulse l31, 0
    lightCtrl.pulse l32, 0
	lightCtrl.pulse l33, 0
	PlaySoundAt "fx_cyber-whoosh", ActiveBall
End Sub

