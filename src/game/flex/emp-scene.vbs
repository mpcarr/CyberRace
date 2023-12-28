
Sub FlexDMDEMPScene()
    Dim qItem : Set qItem = New QueueItem
    Dim font
    Set font = FlexDMD.NewFont(DMDFontMain, RGB(206, 0, 255), RGB(0, 0, 0), 0)
    With qItem
        .Name = "emp"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGEmp"
    End With
    qItem.AddLabel "EMP", 		font, DMDWidth*.25, DMDHeight*.3, DMDWidth*.25, DMDHeight*.3, ""
    qItem.AddLabel "(EMP_BASE_HITS * GetPlayerState(EMP_ACTIVATIONS)) - GetPlayerState(EMP_CHARGE) & "" HITS""", 		font, DMDWidth*.25, DMDHeight*.8, DMDWidth*.25, DMDHeight*.8, "blink"
    DmdQ.Enqueue qItem
End Sub