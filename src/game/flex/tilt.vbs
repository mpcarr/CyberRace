
Sub FlexTiltScene()

	Set qItem = New QueueItem
	With qItem
		.Name = "tilt"
		.Duration = 30
		.BGImage = "noimage"
		.BGVideo = "Tilt"
	End With
	DmdQ.Enqueue qItem

End Sub

Sub FlexTiltWarningScene()

	Set qItem = New QueueItem
	With qItem
		.Name = "tiltwarning"
		.Duration = 5
		.BGImage = "noimage"
		.BGVideo = "TiltWarning"
	End With
	DmdQ.Enqueue qItem

End Sub