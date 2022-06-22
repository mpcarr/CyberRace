Sub FlexDMDCreateWelcomeScene()


	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor FlexDMD.NewVideo("videoplaying", "videos/attract.gif")
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread


	Exit Sub
	'DotMatrix.color = RGB(255, 88, 32)
	Dim scene : Set scene = FlexDMD.NewGroup("Welcome")
	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "...CYBERRACE...")
	Dim lblPressStart : Set lblPressStart = FlexDMD.NewLabel("lblPressStart", bigFont, "PRESS START")
	scene.AddActor lblTitle
	scene.AddActor lblPressStart
	
	lblTitle.SetBounds 0, 0, 128, 16
	lblPressStart.SetBounds 0, 16, 128, 16
	'lblPressStart.SetAlignedPosition 128, 32, FlexDMD_Align_Bottom

	Dim afPressStart
	Set afPressStart = lblPressStart.ActionFactory
	dim blinkLeft : Set blinkLeft = afPressStart.Sequence()
	blinkLeft.Add afPressStart.Show(False)
	blinkLeft.Add afPressStart.Wait(0.5)
	blinkLeft.Add afPressStart.Show(True)
	blinkLeft.Add afPressStart.Wait(0.5)
	lblPressStart.AddAction afPressStart.Repeat(blinkLeft, -1)


	'Dim afTitle : Set af = lblTitle.ActionFactory
	'Dim list : Set list = afTitle.Sequence()
	'list.Add afTitle.MoveTo(128, 0, 0)
	'list.Add afTitle.Wait(0.5)
	'list.Add afTitle.MoveTo(-128, 0, 3.0)
	'list.Add afTitle.Wait(0.5)
	'lblTitle.AddAction afTitle.Repeat(list, -1)


	'scene.AddActor FlexDMD.NewLabel("Info", font, "Use Left and Right Magna" & vbLf & "to select Demo")
	'scene.GetLabel("Info").SetAlignedPosition 64, 32, FlexDMD_Align_Bottom

	'scene.AddActor FlexDMD.NewLabel("Left", bigFont, "<")
	'scene.AddActor FlexDMD.NewLabel("Right", bigFont, ">")
	'scene.GetLabel("Left").SetAlignedPosition 3, 32, FlexDMD_Align_BottomLeft
	'scene.GetLabel("Right").SetAlignedPosition 125, 32, FlexDMD_Align_BottomRight
	
	'Dim af
	'Set af = scene.GetLabel("Left").ActionFactory
	'dim blinkLeft : Set blinkLeft = af.Sequence()
	'blinkLeft.Add af.Show(False)
	'blinkLeft.Add af.Wait(0.5)
	'blinkLeft.Add af.Show(True)
	'blinkLeft.Add af.Wait(0.5)
	'scene.GetLabel("Left").AddAction af.Repeat(blinkLeft, -1)

	'Set af = scene.GetLabel("Right").ActionFactory
	'dim blinkRight : Set blinkRight = af.Sequence()
	'blinkRight.Add af.Show(True)
	'blinkRight.Add af.Wait(0.5)
	'blinkRight.Add af.Show(False)
	'blinkRight.Add af.Wait(0.5)
	'scene.GetLabel("Right").AddAction af.Repeat(blinkRight, -1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub