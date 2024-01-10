
Dim FlexDMD
Dim DmdWidth : DmdWidth = 128
Dim DmdHeight : DmdHeight = 32
' FlexDMD constants
Const 	FlexDMD_RenderMode_DMD_GRAY = 0, _
		FlexDMD_RenderMode_DMD_GRAY_4 = 1, _
		FlexDMD_RenderMode_DMD_RGB = 2, _
		FlexDMD_RenderMode_SEG_2x16Alpha = 3, _
		FlexDMD_RenderMode_SEG_2x20Alpha = 4, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num = 5, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num_4x1Num = 6, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num = 7, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_10x1Num = 8, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num_gen7 = 9, _
		FlexDMD_RenderMode_SEG_2x7Num10_2x7Num10_4x1Num = 10, _
		FlexDMD_RenderMode_SEG_2x6Num_2x6Num_4x1Num = 11, _
		FlexDMD_RenderMode_SEG_2x6Num10_2x6Num10_4x1Num = 12, _
		FlexDMD_RenderMode_SEG_4x7Num10 = 13, _
		FlexDMD_RenderMode_SEG_6x4Num_4x1Num = 14, _
		FlexDMD_RenderMode_SEG_2x7Num_4x1Num_1x16Alpha = 15, _
		FlexDMD_RenderMode_SEG_1x16Alpha_1x16Num_1x7Num = 16

Const 	FlexDMD_Align_TopLeft = 0, _
		FlexDMD_Align_Top = 1, _
		FlexDMD_Align_TopRight = 2, _
		FlexDMD_Align_Left = 3, _
		FlexDMD_Align_Center = 4, _
		FlexDMD_Align_Right = 5, _
		FlexDMD_Align_BottomLeft = 6, _
		FlexDMD_Align_Bottom = 7, _
		FlexDMD_Align_BottomRight = 8

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
		.Color = RGB(255, 255, 255)
		.RenderMode = FlexDMD_RenderMode_DMD_RGB
		.Width = DmdWidth
		.Height = DmdHeight
		.Clear = True
		.ProjectFolder = "./CyberRaceDMD/"
		.Run = True
	End With
	Set DmdQ = New Queue
	Set DmdQ.FlexDMDItem = FlexDMD
	DmdQ.FlexDMDOverlayAssets = Array("BGBlack|image","BG001|image","BG006|image","BG002|image","BG003|image","BG004|image","BGSuperJackpot|video","BGRaceWon|video","BG005|image","BGBoost|video","BGBetMode|video","BGCyber|video","BGEmp|video","BGNodes|video","BGSkills|video","BGEngine|video","BGCooling|video","BGFuel|video","BGNode|video","BGNodeComplete|video","BGRace1|video","BGRace2|video","BGRace3|video","BGRace4|video","BGRace5|video","BGRace6|video""BGRaceLocked|video","BGBonus1|video","BGBonus2|video","BGBonus3|video","BGBonus4|video","BGBonus5|video","BGJackpot|video","TextSmalLine1|text","TextSmalLine2|text","TextSmalLine3|text","TextSmalLine4|text","TextSmalLine5|text","TextSmalLine6|text","TextSmalLine7|text", "Mystery0|video", "Mystery1|video", "Mystery2|video", "Mystery3|video", "Mystery4|video", "TiltWarning|video", "Tilt|video", "ExtraBall|video", "ShootAgain|video", "BGWizardMode|video", "BGHyper|video")
	CreateGameDMD()
End Sub

Sub DMD_Timer()
	Dim DMDp
	DMDp = FlexDMD.DmdColoredPixels
	If Not IsEmpty(DMDp) Then
		DMD.DMDWidth = FlexDMD.Width
		DMD.DMDHeight = FlexDMD.Height
		DMD.DMDColoredPixels = DMDp
	End If
End Sub

InitFlexDMD()