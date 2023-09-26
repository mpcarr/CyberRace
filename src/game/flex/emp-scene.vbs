
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
'
Sub InitDMDEMPModeScene()
    Dim lbl1 : Set lbl1 = FlexDMD.NewLabel("lblEmpMode1", font20, "SHOOT LEFT SPINNER")
    Dim lbl2 : Set lbl2 = FlexDMD.NewLabel("lblEmpMode2", font20, "TO RE-ENERGISE")
	lbl1.SetAlignedPosition 128, 24, FlexDMD_Align_Center
    lbl2.SetAlignedPosition 128, 40, FlexDMD_Align_Center
    DMDEMPModeScene.AddActor lbl1
    DMDEMPModeScene.AddActor lbl2
End Sub

Sub FlexDMDEMPModeScene()
    
End Sub