
Sub FlexDMDHyperScene()
    
	dim h,y,p,e,r,hb,yb,pb,eb,rb
	If GetPlayerState(HYPER) = 1 Then 
        Set h = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        hb="blink"
    Else
        Set h = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
        hb=""
    End If
	
    If GetPlayerState(HYPER) = 2 Then 
        Set h = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set y = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        yb="blink"
    Else
        Set y = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
        yb=""
    End If

    If GetPlayerState(HYPER) = 3 Then 
        Set h = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set y = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set p = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        pb="blink"
    Else
        Set p = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
        pb=""
    End If

    If GetPlayerState(HYPER) = 4 Then 
        Set h = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set y = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set p = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set e = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        eb="blink"
    Else
        Set e = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
        eb=""
    End If

    If GetPlayerState(HYPER) = 5 Then 
        Set h = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set y = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set p = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set e = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        Set r = FlexDMD.NewFont(DMDFontBig, RGB(255,127,0), RGB(0, 0, 0), 0)
        rb="blink"
    Else
        Set r = FlexDMD.NewFont(DMDFontBig, RGB(255, 255, 255), RGB(0, 0, 0), 0)
        rb=""
    End If


 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "hyper"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGHyper"
        .Action = "slidedown"
    End With
    qItem.AddLabel "H", 		h, DMDWidth*.166, DMDHeight*.4, DMDWidth*.166, DMDHeight*.4, hb
    qItem.AddLabel "Y", 		y, DMDWidth*.333, DMDHeight*.4, DMDWidth*.333, DMDHeight*.4, yb
    qItem.AddLabel "P", 		p, DMDWidth*.499, DMDHeight*.4, DMDWidth*.499, DMDHeight*.4, pb
    qItem.AddLabel "E", 		e, DMDWidth*.665, DMDHeight*.4, DMDWidth*.665, DMDHeight*.4, eb
    qItem.AddLabel "R", 		r, DMDWidth*.831, DMDHeight*.4, DMDWidth*.831, DMDHeight*.4, rb
    qItem.AddLabel "PLAYFIELD MULTIPLIER", FontWhite3, DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, ""
    DmdQ.Enqueue qItem

    lightCtrl.pulse l37, 0
    lightCtrl.pulse l38, 0
    lightCtrl.pulse l39, 0
    lightCtrl.pulse l40, 0
	lightCtrl.pulse l41, 0
End Sub

