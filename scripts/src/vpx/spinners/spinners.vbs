'******************
' Section; Spinner
'******************
Sub Spinner1_Spin()
	PlaySound "fx-spinner2"
	GameAddScore GAME_POINTS_SPINNER
End Sub
Sub Spinner2_Spin()
	DISPATCH SWITCH_HIT_SPINNER2, null
End Sub