'******************
' Section; Spinner
'******************
Sub Spinner1_Spin()
	PlaySound "fx-spinner2"
	DebugScore = DebugScore + 1000
End Sub
Sub Spinner2_Spin()
	DISPATCH SWITCH_HIT_SPINNER2, null
End Sub