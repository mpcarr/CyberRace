
Sub InitDMDEMPScene()
    Dim lbl1 : Set lbl1 = FlexDMD.NewLabel("lblCharge", font20Outline, "EMP CHARGING")
    Dim lbl2 : Set lbl2 = FlexDMD.NewLabel("lblCharge2", font20Outline, "HITS REMAINING")
	lbl1.SetAlignedPosition 128, 24, FlexDMD_Align_Center
    lbl2.SetAlignedPosition 128, 42, FlexDMD_Align_Center
    DMDEMPScene.AddActor DMDChargeEMP
    DMDEMPScene.AddActor lbl1
    DMDEMPScene.AddActor lbl2
End Sub

Sub FlexDMDEMPScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "emp"
        .Duration = 2
        .Title = "EMP CHARGING"
        .Message = "(EMP_BASE_HITS * GetPlayerState(EMP_ACTIVATIONS)) - GetPlayerState(EMP_CHARGE) & "" HITS REMAINING"""
        .Font = FontCyber16_HURRYUP_COLOR
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "blink"
        .BGImage = "BG001"
        .BGVideo = "novideo"
    End With
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