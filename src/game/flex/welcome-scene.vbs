Sub InitDMDWelcomeScene()
	Dim vid : Set vid = FlexDMD.NewVideo("vidIntro", "videos/attract-c.gif")
	DMDWelcomeScene.AddActor vid
End Sub

Sub FlexDMDCWelcomeScene()
	
	'Dim vid : Set vid = DMDWelcomeScene.GetVideo("vidIntro") 
	'vid.Seek(0)
	'FlexDMD.LockRenderThread
	'FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	'FlexDMD.Stage.RemoveAll
	'FlexDMD.Stage.AddActor DMDWelcomeScene
	'FlexDMD.Show = True
	'FlexDMD.UnlockRenderThread
End Sub