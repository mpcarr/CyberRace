Sub InitFlexDMD()
	Set FlexDMD = CreateObject("FlexDMD.FlexDMD")
    If FlexDMD is Nothing Then
        MsgBox "No FlexDMD found. This table will NOT run without it."
        Exit Sub
    End If
	SetLocale(1033)
	With FlexDMD
		.GameName = cGameName
		.TableFile = Table1.Filename & ".vpx"
		.Color = RGB(255, 88, 32)
		.RenderMode = FlexDMD_RenderMode_DMD_RGB
		.Width = 128
		.Height = 32
		.Clear = True
		.Run = True
	End With
	FlexDMDCreateWelcomeScene()
End Sub


Sub FlexDMDTimerTest_Timer
Dim DMDp
If FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB Then
	DMDp = FlexDMD.DmdColoredPixels
	If Not IsEmpty(DMDp) Then
		DMDWidth = FlexDMD.Width
		DMDHeight = FlexDMD.Height
		DMDColoredPixels = DMDp
	End If
Else
	DMDp = FlexDMD.DmdPixels
	If Not IsEmpty(DMDp) Then
		DMDWidth = FlexDMD.Width
		DMDHeight = FlexDMD.Height
		DMDPixels = DMDp
	End If
End If
End Sub

'If usePUP = False Then
	InitFlexDMD()
'End If

Dim font : Set font = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)
Dim bigFont : Set bigFont = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)

Sub FlexDMDCreateWelcomeScene()
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

Sub DisplayCurrentAudioTrack()

	Dim scene : Set scene = FlexDMD.NewGroup("GameModeNormal")

	Dim lblMusic : Set lblMusic = FlexDMD.NewLabel("lblMusic", font, audioTracks(currentTrack)(1))

	scene.AddActor lblMusic
	
	lblMusic.SetAlignedPosition -500, 0, FlexDMD_Align_Center

	Dim afMusic : Set afMusic = lblMusic.ActionFactory
	Dim list : Set list = afMusic.Sequence()
	list.Add afMusic.MoveTo(128, 22, 0)
	list.Add afMusic.Wait(0.5)
	list.Add afMusic.MoveTo(-128, 22, 5.0)
	list.Add afMusic.Show(False)
	lblMusic.AddAction afMusic.Repeat(list, 1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread

End Sub

Dim BetFrameB: Set BetFrameB = FlexDMD.NewImage("BetFrame_B", "VPX.flexBET&region=0,0,512,128")
BetFrameB.SetBounds 0, 6, 128, 26
Dim BetFrameE: Set BetFrameE = FlexDMD.NewImage("BetFrame_E", "VPX.flexBET&region=0,128,512,128")
BetFrameE.SetBounds 0, 6, 128, 26
Dim BetFrameT: Set BetFrameT = FlexDMD.NewImage("BetFrame_T", "VPX.flexBET&region=0,256,512,128")
BetFrameT.SetBounds 0, 6, 128, 26
Dim BetScene : Set BetScene = FlexDMD.NewGroup("BetCharacters")
BetScene.AddActor FlexDMD.NewLabel("BetHurryUp", font, "")
BetScene.AddActor BetFrameB
BetScene.AddActor BetFrameE
BetScene.AddActor BetFrameT

Sub DisplayFlexBetHitScreen(frame)
	
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