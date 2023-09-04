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