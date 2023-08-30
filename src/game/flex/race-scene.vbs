

Sub InitDMDRaceReadyScene()
    DMDRaceReadyScene.AddActor DMDRaceReadyVid
End Sub

Sub InitDMDRaceSelectScene()
    Dim lbl1 : Set lbl1 = FlexDMD.NewLabel("lblRaceTitle", font20Outline, "RACE X VS RIDLEY")
    Dim lbl2 : Set lbl2 = FlexDMD.NewLabel("lblRaceDescription", font20Outline, "Hit 6 Ramp Shots")
	lbl1.SetAlignedPosition 128, 24, FlexDMD_Align_Center
    lbl2.SetAlignedPosition 128, 42, FlexDMD_Align_Center
    DMDRaceSelectScene.AddActor lbl1
    DMDRaceSelectScene.AddActor lbl2
End Sub

Sub FlexDMDRaceReadyScene()
   ' SetPlayerState FLEX_MODE, 6
    
    DMDModeUpdate.Enabled = 0
    DMDModeUpdate.Enabled = 1
    DMDModeUpdate.Interval = DMDRaceReadyVid.Length*1000
    
    FlexPlayScene(DMDRaceReadyScene)
End Sub


Sub FlexDMDRaceSelectScene()
   ' SetPlayerState FLEX_MODE, 7

    DMDModeUpdate.Enabled = 0

    FlexPlayScene(DMDRaceSelectScene)
End Sub