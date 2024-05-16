
'****************************
' FlexBallSaveScene
' Event Listeners:          
AddPinEventListener BALL_SAVE, BALL_SAVE &   "FlexBallSaveScene",   "FlexBallSaveScene",  1000, Null
'
'*****************************
Sub FlexBallSaveScene()

	Set qItem = New QueueItem
	With qItem
		.Name = "ballsave"
		.Duration = 2
		.BGImage = "BGBlack"
		.BGVideo = "novideo"
	End With
	qItem.AddLabel "BALL SAVED", 		font12, DMDWidth/2, DMDHeight/2, DMDWidth/2, DMDHeight/2, "blink"
	DmdQ.Enqueue qItem

End Sub