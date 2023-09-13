Sub Spinner1_Animate()
    Dim el
	For Each el in BP_Spinner1
		el.RotX = Spinner1.currentangle
	Next

End Sub

Sub Spinner2_Animate()
    Dim el
	For Each el in BP_Spinner2
		el.RotX = Spinner2.currentangle
	Next
End Sub

Sub sw01_Animate
	Dim z : z = sw01.CurrentAnimOffset
	Dim el : For Each el in BP_sw01 : el.transz = z: Next
End Sub

Sub sw02_Animate
	Dim z : z = sw02.CurrentAnimOffset
	Dim el : For Each el in BP_sw02 : el.transz = z: Next
End Sub

Sub sw03_Animate
	Dim z : z = sw03.CurrentAnimOffset
	Dim el : For Each el in BP_sw03 : el.transz = z: Next
End Sub

Sub sw04_Animate
	Dim z : z = sw04.CurrentAnimOffset
	Dim el : For Each el in BP_sw04 : el.transz = z: Next
End Sub

Sub sw05_Animate
	Dim z : z = sw05.CurrentAnimOffset
	Dim el : For Each el in BP_sw05 : el.transz = z: Next
End Sub

Sub sw06_Animate
	Dim z : z = sw06.CurrentAnimOffset
	Dim el : For Each el in BP_sw06 : el.transz = z: Next
End Sub

Sub sw07_Animate
	Dim z : z = sw07.CurrentAnimOffset
	Dim el : For Each el in BP_sw07 : el.transz = z: Next
End Sub

Sub sw31_Animate
	Dim z : z = sw31.CurrentAnimOffset
	Dim el : For Each el in BP_sw31 : el.transz = z: Next
End Sub

Sub sw14_Animate
	Dim z : z = sw14.CurrentAnimOffset
	Dim el : For Each el in BP_sw14 : el.transz = z: Next
End Sub

Sub sw08_Animate
	Dim z : z = sw08.CurrentAnimOffset
	Dim el : For Each el in BP_sw08 : el.transz = z: Next
End Sub


Sub Gate002_Animate()
    Dim el
	For Each el in BP_Gate002_Wire
		el.RotX = Gate002.currentangle
	Next
End Sub

Sub sw26_Animate()
    Dim el
	For Each el in BP_sw26_Wire
		el.RotX = sw26.currentangle
	Next
End Sub

Sub LeftFlipper_Animate
	Dim a : a = LeftFlipper.CurrentAngle
    'FlipperLSh.RotZ = a

	' Darken light from lane bulbs when bats are up
	Dim v, w, u, LM
	v = 255.0 * (120.0 -  LeftFlipper.CurrentAngle) / (120.0 -  69.0)
	w = Gray2RGB(255.0 - v)
	u = Gray2RGB(v)

	For Each el in BP_FlipperL
		el.Rotz = a
		el.color = w
		el.visible = v < 128.0
	Next

	For Each el in BP_FlipperLU
		el.Rotz = a
		el.color = u
		el.visible = v > 128.0
	Next

End Sub

Sub RightFlipper_Animate
	Dim a : a = RightFlipper.CurrentAngle
    'FlipperLSh.RotZ = a

	' Darken light from lane bulbs when bats are up
	Dim v, w, u, LM
	v = 255.0 * (120.0 -  RightFlipper.CurrentAngle) / (120.0 -  69.0)
	w = Gray2RGB(255.0 - v)
	u = Gray2RGB(v)

	For Each el in BP_FlipperR
		el.Rotz = a
		el.color = w
		el.visible = v < 128.0
	Next

	For Each el in BP_FlipperRU
		el.Rotz = a
		el.color = u
		el.visible = v > 128.0
	Next

End Sub


Sub UpRightFlipper_Animate
	Dim a : a = UpRightFlipper.CurrentAngle
    'FlipperLSh.RotZ = a

	' Darken light from lane bulbs when bats are up
	Dim v, w, u, LM
	v = 255.0 * (120.0 -  UpRightFlipper.CurrentAngle) / (120.0 -  69.0)
	w = Gray2RGB(255.0 - v)
	u = Gray2RGB(v)

	For Each el in BP_FlipperU
		el.Rotz = a
		el.color = w
		el.visible = v < 128.0

	Next

	For Each el in BP_FlipperUU
		el.Rotz = a
		el.color = u
		el.visible = v > 128.0
	Next

End Sub