'***********************************************************************
'* TABLE OPTIONS *******************************************************
'***********************************************************************

Dim RoomBrightness : RoomBrightness = 60			'Level of room lighting (0 to 100), where 0 is dark and 100 is brightest
Dim ColorLUT : ColorLUT = 3
Dim ScorbitActive : ScorbitActive = 0
Dim OutPostMod : OutPostMod = 1				'Difficulty : 0 = Easy, 1 = Medium, 2 = Hard
Dim SlingsMod : SlingsMod = 0 				'0 - Blue Slings, 1 = Orange Slings
Dim VolumeDial : VolumeDial = 0.8			'Overall Mechanical sound effect volume. Recommended values should be no greater than 1.
Dim BallRollVolume : BallRollVolume = 0.5 	'Level of ball rolling volume. Value between 0 and 1
Dim RampRollVolume : RampRollVolume = 0.5 	'Level of ramp rolling volume. Value between 0 and 1
Dim StagedFlipperMod
Dim OptionsCabinetMode : OptionsCabinetMode = 0
Dim OptionsBonusSound : OptionsBonusSound = "fx-bonus"

'Dim Cabinetmode	: Cabinetmode = 0			'0 - Siderails On, 1 - Siderails Off

Dim VRRoomChoice : VRRoomChoice = 1				'0 - Minimal Room, 1 = Default Room

' Base options
Const Opt_Light = 0
Const Opt_LUT = 1
Const Opt_Scorbit = 2

Const Opt_CabinetMode = 3
Const Opt_BonusSound = 4

Const Opt_Volume = 5
Const Opt_Volume_Ramp = 6
Const Opt_Volume_Ball = 7
' Table mods & toys
'Const Opt_Cabinet = 8
Const Opt_Staged_Flipper = 8
' Shadow options
' Informations
Const Opt_Info_1 = 9
Const Opt_Info_2 = 10

Const NOptions = 11

Dim OptionDMD: Set OptionDMD = Nothing
Dim bOptionsMagna, bInOptions : bOptionsMagna = False
Dim OptPos, OptSelected, OptN, OptTop, OptBot, OptSel
Dim OptFontHi, OptFontLo

Sub Options_Open
	bOptionsMagna = False
	Set OptionDMD = CreateObject("FlexDMD.FlexDMD")
	If OptionDMD is Nothing Then
		Debug.Print "FlexDMD is not installed"
		Debug.Print "Option UI can not be opened"
		Exit Sub
	End If
	Debug.Print "Option UI opened"
	If ShowDT Then OptionDMDFlasher.RotX = -(Table1.Inclination + Table1.Layback)
	bInOptions = True
	OptPos = 0
	OptSelected = False
	OptionDMD.Show = False
	OptionDMD.RenderMode = FlexDMD_RenderMode_DMD_GRAY_4
	OptionDMD.Width = 128
	OptionDMD.Height = 32
	OptionDMD.Clear = True
	OptionDMD.Run = True
	Dim a, scene, font
	Set scene = OptionDMD.NewGroup("Scene")
	Set OptFontHi = OptionDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", vbWhite, vbWhite, 0)
	Set OptFontLo = OptionDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(100, 100, 100), RGB(100, 100, 100), 0)
	Set OptSel = OptionDMD.NewGroup("Sel")
	Set a = OptionDMD.NewLabel(">", OptFontLo, ">>>")
	a.SetAlignedPosition 1, 16, FlexDMD_Align_Left
	OptSel.AddActor a
	Set a = OptionDMD.NewLabel(">", OptFontLo, "<<<")
	a.SetAlignedPosition 127, 16, FlexDMD_Align_Right
	OptSel.AddActor a
	scene.AddActor OptSel
	OptSel.SetBounds 0, 0, 128, 32
	OptSel.Visible = False
	
	Set a = OptionDMD.NewLabel("Info1", OptFontLo, "MAGNA EXIT/ENTER")
	a.SetAlignedPosition 1, 32, FlexDMD_Align_BottomLeft
	scene.AddActor a
	Set a = OptionDMD.NewLabel("Info2", OptFontLo, "FLIPPER SELECT")
	a.SetAlignedPosition 127, 32, FlexDMD_Align_BottomRight
	scene.AddActor a
	Set OptN = OptionDMD.NewLabel("Pos", OptFontLo, "LINE 1")
	Set OptTop = OptionDMD.NewLabel("Top", OptFontLo, "LINE 1")
	Set OptBot = OptionDMD.NewLabel("Bottom", OptFontLo, "LINE 2")
	scene.AddActor OptN
	scene.AddActor OptTop
	scene.AddActor OptBot
	Options_OnOptChg
	OptionDMD.LockRenderThread
	OptionDMD.Stage.AddActor scene
	OptionDMD.UnlockRenderThread
	OptionDMDFlasher.Visible = True
	DisableStaticPrerendering = True
End Sub

Sub Options_UpdateDMD
	If OptionDMD is Nothing Then Exit Sub
	Dim DMDp: DMDp = OptionDMD.DmdPixels
	If Not IsEmpty(DMDp) Then
		OptionDMDFlasher.DMDWidth = OptionDMD.Width
		OptionDMDFlasher.DMDHeight = OptionDMD.Height
		OptionDMDFlasher.DMDPixels = DMDp
	End If
End Sub

Sub Options_Close
	bInOptions = False
	OptionDMDFlasher.Visible = False
	If OptionDMD is Nothing Then Exit Sub
	OptionDMD.Run = False
	Set OptionDMD = Nothing
	DisableStaticPrerendering = False
End Sub

Function Options_OnOffText(opt)
	If opt Then
		Options_OnOffText = "ON"
	Else
		Options_OnOffText = "OFF"
	End If
End Function

Sub Options_OnOptChg
	If OptionDMD is Nothing Then Exit Sub
	OptionDMD.LockRenderThread


	If Not OptPos=2 Then
		
	End If

	If OptSelected Then
		OptTop.Font = OptFontLo
		OptBot.Font = OptFontHi
		OptSel.Visible = True
	Else
		OptTop.Font = OptFontHi
		OptBot.Font = OptFontLo
		OptSel.Visible = False
	End If
	If OptPos = Opt_Light Then
		OptTop.Text = "ROOM LIGHT LEVEL1"
		OptBot.Text = "LEVEL " & RoomBrightness
		SaveValue cGameName, "LIGHT", RoomBrightness
	ElseIf OptPos = Opt_LUT Then
		OptTop.Text = "COLOR SATURATION"
'		OptBot.Text = "LUT " & CInt(ColorLUT)
		if ColorLUT = 1 Then OptBot.text = "DISABLED"
		if ColorLUT = 2 Then OptBot.text = "DESATURATED -10%"
		if ColorLUT = 3 Then OptBot.text = "DESATURATED -20%"
		if ColorLUT = 4 Then OptBot.text = "DESATURATED -30%"
		if ColorLUT = 5 Then OptBot.text = "DESATURATED -40%"
		if ColorLUT = 6 Then OptBot.text = "DESATURATED -50%"
		if ColorLUT = 7 Then OptBot.text = "DESATURATED -60%"
		if ColorLUT = 8 Then OptBot.text = "DESATURATED -70%"
		if ColorLUT = 9 Then OptBot.text = "DESATURATED -80%"
		if ColorLUT = 10 Then OptBot.text = "DESATURATED -90%"
		if ColorLUT = 11 Then OptBot.text = "BLACK'N WHITE"
		SaveValue cGameName, "LUT", ColorLUT
	ElseIf OptPos = Opt_Scorbit Then
		OptTop.Text = "SCORBIT"
		if ScorbitActive = 0 Then OptBot.text = "OFF"
		if ScorbitActive = 1 Then OptBot.text = "ACTIVE"
		SaveValue cGameName, "SCORBIT", ScorbitActive
	ElseIf OptPos = Opt_CabinetMode Then
		OptTop.Text = "CABINET MODE"
		OptBot.Text = Options_OnOffText(OptionsCabinetMode)
		SaveValue cGameName, "CABMODE", OptionsCabinetMode
	ElseIf OptPos = Opt_BonusSound Then
		OptTop.Text = "BONUS SOUND"
		If OptionsBonusSound = "fx-bonus" Then
			OptBot.Text = "Main"
		Else
			OptBot.Text = "Alt"
		End If
		SaveValue cGameName, "BONUS", OptionsBonusSound
	ElseIf OptPos = Opt_Volume Then
		OptTop.Text = "MECH VOLUME"
		OptBot.Text = "LEVEL " & CInt(VolumeDial * 100)
		SaveValue cGameName, "VOLUME", VolumeDial
	ElseIf OptPos = Opt_Volume_Ramp Then
		OptTop.Text = "RAMP VOLUME"
		OptBot.Text = "LEVEL " & CInt(RampRollVolume * 100)
		SaveValue cGameName, "RAMPVOLUME", RampRollVolume
	ElseIf OptPos = Opt_Volume_Ball Then
		OptTop.Text = "BALL VOLUME"
		OptBot.Text = "LEVEL " & CInt(BallRollVolume * 100)
		SaveValue cGameName, "BALLVOLUME", BallRollVolume
	ElseIf OptPos = Opt_Staged_Flipper Then
		OptTop.Text = "STAGED FLIPPER"
		OptBot.Text = Options_OnOffText(StagedFlipperMod)
		SaveValue cGameName, "STAGED", StagedFlipperMod
'	ElseIf OptPos = Opt_Cabinet Then
'		OptTop.Text = "CABINET MODE"
'		OptBot.Text = Options_OnOffText(CabinetMode)
'		SaveValue cGameName, "CABINET", CabinetMode
	ElseIf OptPos = Opt_Info_1 Then
		OptTop.Text = "VPX " & VersionMajor & "." & VersionMinor & "." & VersionRevision
		OptBot.Text = "CYBERRACE " & TableVersion
	ElseIf OptPos = Opt_Info_2 Then
		OptTop.Text = "RENDER MODE"
		If RenderingMode = 0 Then OptBot.Text = "DEFAULT"
		If RenderingMode = 1 Then OptBot.Text = "STEREO 3D"
		If RenderingMode = 2 Then OptBot.Text = "VR"
	End If
	'OptTop.SetAlignedPosition 127, 1, FlexDMD_Align_TopRight 'bug? not aligning right
	OptTop.SetAlignedPosition 100, 1, FlexDMD_Align_TopRight
	OptBot.SetAlignedPosition 64, 16, FlexDMD_Align_Center
	OptionDMD.UnlockRenderThread
	UpdateMods
End Sub

Sub Options_Toggle(amount)
	If OptionDMD is Nothing Then Exit Sub

	If OptPos = Opt_Light Then
		RoomBrightness = RoomBrightness + amount * 10
		If RoomBrightness < 0 Then RoomBrightness = 100
		If RoomBrightness > 100 Then RoomBrightness = 0
	ElseIf OptPos = Opt_LUT Then
		ColorLUT = ColorLUT + amount * 1
		If ColorLUT < 1 Then ColorLUT = 11
		If ColorLUT > 11 Then ColorLUT = 1
	ElseIf OptPos = Opt_Scorbit Then
		If ScorbitActive = 1 Then 
			ScorbitActive = 0
		Else 
			ScorbitActive = 1
		End If
	ElseIf OptPos = Opt_Volume Then
		VolumeDial = VolumeDial + amount * 0.1
		If VolumeDial < 0 Then VolumeDial = 1
		If VolumeDial > 1 Then VolumeDial = 0
	ElseIf OptPos = Opt_Volume_Ramp Then
		RampRollVolume = RampRollVolume + amount * 0.1
		If RampRollVolume < 0 Then RampRollVolume = 1
		If RampRollVolume > 1 Then RampRollVolume = 0
	ElseIf OptPos = Opt_Volume_Ball Then
		BallRollVolume = BallRollVolume + amount * 0.1
		If BallRollVolume < 0 Then BallRollVolume = 1
		If BallRollVolume > 1 Then BallRollVolume = 0
	ElseIf OptPos = Opt_Staged_Flipper Then
		StagedFlipperMod = 1 - StagedFlipperMod
	ElseIf OptPos = Opt_CabinetMode Then
		OptionsCabinetMode = 1 - OptionsCabinetMode
	ElseIf OptPos = Opt_BonusSound Then
		If OptionsBonusSound = "fx-bonus" Then 
			OptionsBonusSound = "fx-bonus-alt"
		Else
			OptionsBonusSound = "fx-bonus"
		End If
		PlaySound(OptionsBonusSound)
	End If
End Sub

Sub Options_KeyDown(ByVal keycode)
	If OptSelected Then
		If keycode = LeftMagnaSave Then ' Exit / Cancel
			OptSelected = False
		ElseIf keycode = RightMagnaSave Then ' Enter / Select
			OptSelected = False
		ElseIf keycode = LeftFlipperKey Then ' Next / +
			Options_Toggle	-1
		ElseIf keycode = RightFlipperKey Then ' Prev / -
			Options_Toggle	1
		End If
	Else
		If keycode = LeftMagnaSave Then ' Exit / Cancel
			Options_Close
		ElseIf keycode = RightMagnaSave Then ' Enter / Select
			If OptPos < Opt_Info_1 Then OptSelected = True
		ElseIf keycode = LeftFlipperKey Then ' Next / +
			OptPos = OptPos - 1
'			If OptPos = Opt_VRTopperOn And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRSideBlades And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRBackglassGI And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRRoomChoice And RenderingMode <> 2 Then OptPos = OptPos - 1 ' Skip VR option in non VR mode
			If OptPos < 0 Then OptPos = NOptions - 1
		ElseIf keycode = RightFlipperKey Then ' Prev / -
			OptPos = OptPos + 1
'			If OptPos = Opt_VRRoomChoice And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRBackglassGI And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRSideBlades And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
'			If OptPos = Opt_VRTopperOn And RenderingMode <> 2 Then OptPos = OptPos + 1 ' Skip VR option in non VR mode
			If OptPos >= NOPtions Then OptPos = 0
		End If
	End If
	Options_OnOptChg
End Sub

Sub Options_Load
	Dim x
    x = LoadValue(cGameName, "LIGHT") : If x <> "" Then RoomBrightness = CInt(x) Else RoomBrightness = 60
    x = LoadValue(cGameName, "LUT") : If x <> "" Then ColorLUT = CInt(x) Else ColorLUT = 3
	x = LoadValue(cGameName, "SCORBIT") : If x <> "" Then ScorbitActive = CInt(x) Else ScorbitActive = 0
    x = LoadValue(cGameName, "VOLUME") : If x <> "" Then VolumeDial = CNCDbl(x) Else VolumeDial = 0.8
    x = LoadValue(cGameName, "RAMPVOLUME") : If x <> "" Then RampRollVolume = CNCDbl(x) Else RampRollVolume = 0.5
    x = LoadValue(cGameName, "BALLVOLUME") : If x <> "" Then BallRollVolume = CNCDbl(x) Else BallRollVolume = 0.5
    x = LoadValue(cGameName, "STAGED") : If x <> "" Then StagedFlipperMod = CInt(x) Else StagedFlipperMod = 0
	x = LoadValue(cGameName, "CABMODE") : If x <> "" Then OptionsCabinetMode = CInt(x) Else OptionsCabinetMode = 0
	x = LoadValue(cGameName, "BONUS") : If x <> "" Then OptionsBonusSound = CStr(x) Else OptionsBonusSound = "fx-bonus"
	UpdateMods
End Sub


Sub UpdateMods
	Dim BL, LM, x, y, c, enabled
	
	'*********************
	'Room light level
	'*********************

	SetRoomBrightness RoomBrightness/100

	'*********************
	'Color LUT
	'*********************

	if ColorLUT = 1 Then Table1.ColorGradeImage = ""
	if ColorLUT = 2 Then Table1.ColorGradeImage = "colorgradelut256x16-10"
	if ColorLUT = 3 Then Table1.ColorGradeImage = "colorgradelut256x16-20"
	if ColorLUT = 4 Then Table1.ColorGradeImage = "colorgradelut256x16-30"
	if ColorLUT = 5 Then Table1.ColorGradeImage = "colorgradelut256x16-40"
	if ColorLUT = 6 Then Table1.ColorGradeImage = "colorgradelut256x16-50"
	if ColorLUT = 7 Then Table1.ColorGradeImage = "colorgradelut256x16-60"
	if ColorLUT = 8 Then Table1.ColorGradeImage = "colorgradelut256x16-70"
	if ColorLUT = 9 Then Table1.ColorGradeImage = "colorgradelut256x16-80"
	if ColorLUT = 10 Then Table1.ColorGradeImage = "colorgradelut256x16-90"
	if ColorLUT = 11 Then Table1.ColorGradeImage = "colorgradelut256x16-100"

	'MsgBox(ScorbitActive)
	If ScorbitActive = 1 Then
		StartScorbit
		If ScorbitActive = 1 And Scorbit.bNeedsPairing = True Then
			ScorbitFlasher.Visible = True
		End If
	Else
		ScorbitFlasher.Visible = False
	End If

	Dim element
	If OptionsCabinetMode = 1 Then
		For Each element in BP_PinCab_Rails
			element.Visible = False
		Next
	Else
		For Each element in BP_PinCab_Rails
			element.Visible = True
		Next
	End If

End Sub


' Culture neutral string to double conversion (handles situation where you don't know how the string was written)
Function CNCDbl(str)
    Dim strt, Sep, i
    If IsNumeric(str) Then
        CNCDbl = CDbl(str)
    Else
        Sep = Mid(CStr(0.5), 2, 1)
        Select Case Sep
        Case "."
            i = InStr(1, str, ",")
        Case ","
            i = InStr(1, str, ".")
        End Select
        If i = 0 Then     
            CNCDbl = Empty
        Else
            strt = Mid(str, 1, i - 1) & Sep & Mid(str, i + 1)
            If IsNumeric(strt) Then
                CNCDbl = CDbl(strt)
            Else
                CNCDbl = Empty
            End If
        End If
    End If
End Function

'******************
'Setup Stuff
'*****************


'****************************
'	Room Brightness
'****************************

' Update these arrays if you want to change more materials with room light level
Dim RoomBrightnessMtlArray: RoomBrightnessMtlArray = Array("VLM.Bake.Active","VLM.Bake.Solid")
Dim SavedMtlColorArray:     SavedMtlColorArray     = Array(0,0)


Sub SetRoomBrightness(lvl)
	If lvl > 1 Then lvl = 1
	If lvl < 0 Then lvl = 0

	' Lighting level
	Dim v: v=(lvl * 225 + 30)/255
	Dim i: For i = 0 to UBound(RoomBrightnessMtlArray)
		ModulateMaterialBaseColor RoomBrightnessMtlArray(i), i, v
	Next


End Sub

SaveMtlColors
Sub SaveMtlColors
	Dim i: For i = 0 to UBound(RoomBrightnessMtlArray)
		SaveMaterialBaseColor RoomBrightnessMtlArray(i), i
	Next
End Sub

Sub SaveMaterialBaseColor(name, idx)
    Dim wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
	GetMaterial name, wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
	SavedMtlColorArray(idx) = round(base,0)
End Sub


Sub ModulateMaterialBaseColor(name, idx, val)
    Dim wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
	Dim red, green, blue, saved_base, new_base
 
	'First get the existing material properties
	GetMaterial name, wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle

	'Get saved color
	saved_base = SavedMtlColorArray(idx)
	
	'Next extract the r,g,b values from the base color
	red = saved_base And &HFF
	green = (saved_base \ &H100) And &HFF
	blue = (saved_base \ &H10000) And &HFF
	'msgbox red & " " & green & " " & blue

	'Create new color scaled down by 'val', and update the material
	new_base = RGB(red*val, green*val, blue*val)
    UpdateMaterial name, wrapLighting, roughness, glossyImageLerp, thickness, edge, edgeAlpha, opacity, new_base, glossy, clearcoat, isMetal, opacityActive, elasticity, elasticityFalloff, friction, scatterAngle
End Sub