Sub FlexDMDGameModeSkillshot()
	'DotMatrix.color = RGB(255, 88, 32)
	Dim scene : Set scene = FlexDMD.NewGroup("GameModeNormal")

	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "SKILLSHOT")
	Dim lblMusic : Set lblMusic = FlexDMD.NewLabel("lblMusic", font, audioTracks(currentTrack)(1))
	Dim lblLeft : Set lblLeft = FlexDMD.NewLabel("lblLeft", bigFont, "<")
	Dim lblRight : Set lblRight = FlexDMD.NewLabel("lblRight", bigFont, ">")

	scene.AddActor lblTitle
	scene.AddActor lblMusic
	scene.AddActor lblLeft
	scene.AddActor lblRight
	
	lblLeft.SetAlignedPosition 3, 2, FlexDMD_Align_TopLeft
	lblRight.SetAlignedPosition 125, 2, FlexDMD_Align_TopRight
	lblTitle.SetAlignedPosition 64, 8, FlexDMD_Align_Center
	
	lblMusic.SetAlignedPosition -500, 0, FlexDMD_Align_TopLeft

	Dim afLeft : Set afLeft = lblLeft.ActionFactory
	dim blinkLeft : Set blinkLeft = afLeft.Sequence()
	blinkLeft.Add afLeft.Show(False)
	blinkLeft.Add afLeft.Wait(0.5)
	blinkLeft.Add afLeft.Show(True)
	blinkLeft.Add afLeft.Wait(0.5)
	lblLeft.AddAction afLeft.Repeat(blinkLeft, -1)

	Dim afRight : Set afRight = lblRight.ActionFactory
	dim blinkRight : Set blinkRight = afRight.Sequence()
	blinkRight.Add afRight.Show(False)
	blinkRight.Add afRight.Wait(0.5)
	blinkRight.Add afRight.Show(True)
	blinkRight.Add afRight.Wait(0.5)
	lblRight.AddAction afRight.Repeat(blinkRight, -1)


	Dim afMusic : Set afMusic = lblMusic.ActionFactory
	Dim list : Set list = afMusic.Sequence()
	list.Add afMusic.MoveTo(128, 22, 0)
	list.Add afMusic.Wait(0.5)
	list.Add afMusic.MoveTo(-128, 22, 5.0)
	list.Add afMusic.Show(False)
	lblMusic.AddAction afMusic.Repeat(list, 1)


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
