

'Dim BetFrameB: Set BetFrameB = FlexDMD.NewImage("BetFrame_B", "VPX.flexBET&region=0,0,512,128")
'BetFrameB.SetBounds 0, 6, 128, 26
'Dim BetFrameE: Set BetFrameE = FlexDMD.NewImage("BetFrame_E", "VPX.flexBET&region=0,128,512,128")
'BetFrameE.SetBounds 0, 6, 128, 26
'Dim BetFrameT: Set BetFrameT = FlexDMD.NewImage("BetFrame_T", "VPX.flexBET&region=0,256,512,128")
'BetFrameT.SetBounds 0, 6, 128, 26
'Dim BetScene : Set BetScene = FlexDMD.NewGroup("BetCharacters")
'BetScene.AddActor FlexDMD.NewLabel("BetHurryUp", font, "")
'BetScene.AddActor BetFrameB
'BetScene.AddActor BetFrameE
'BetScene.AddActor BetFrameT

Sub DisplayFlexBetHitScreen(frame)
	Exit Sub
	BetFrameB.Visible = False
	BetFrameE.Visible = False
	BetFrameT.Visible = False
	Dim label: Set label = BetScene.GetLabel("BetHurryUp")
	label.SetAlignedPosition 64, 5, FlexDMD_Align_Center
	label.Text = gameState("game")("betHits") & " More Hits"
	Execute frame&".Visible = True"
	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor BetScene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub

Sub vpmTimerFlexUpdateMain
	FlexDMDGameModeNormal()
End Sub