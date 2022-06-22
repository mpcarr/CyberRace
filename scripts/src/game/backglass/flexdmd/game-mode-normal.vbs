Sub FlexDMDGameModeNormal()
	'DotMatrix.color = RGB(255, 88, 32)

	DisplayFlexBetHitScreen("BetFrameB")
	Exit Sub

	Dim scene : Set scene = FlexDMD.NewGroup("Welcome")
	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "...CYBERRACE...")
	
	scene.AddActor lblTitle
	
	lblTitle.SetBounds 0, 0, 128, 16

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub