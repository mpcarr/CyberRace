


Sub FlexDMDGarageEngineScene()	

 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nye"
        .Duration = 4
        .BGImage = "noimage"
        .BGVideo = "BGEngine"
    End With
    DmdQ.Enqueue qItem

End Sub

Sub FlexDMDGarageCoolingScene()	
 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nye"
        .Duration = 4
        .BGImage = "noimage"
        .BGVideo = "BGCooling"
    End With
    DmdQ.Enqueue qItem
End Sub

Sub FlexDMDGarageFuelScene()	
	 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nye"
        .Duration = 4
        .BGImage = "noimage"
        .BGVideo = "BGFuel"
    End With
    DmdQ.Enqueue qItem

End Sub