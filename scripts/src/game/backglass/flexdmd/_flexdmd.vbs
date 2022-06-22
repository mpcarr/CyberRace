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
		.ProjectFolder = "./CyberRaceDMD/"
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
'End Ifs

Dim font : Set font = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)
Dim bigFont : Set bigFont = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)