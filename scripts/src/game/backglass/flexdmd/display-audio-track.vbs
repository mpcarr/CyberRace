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