

Sub FlexExtraBallScene()

	Set qItem = New QueueItem
	With qItem
		.Name = "extraball"
		.Duration = 5
		.BGImage = "noimage"
		.BGVideo = "ExtraBall"
	End With
	DmdQ.Enqueue qItem

End Sub