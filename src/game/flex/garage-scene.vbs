


Sub FlexDMDGarageEngineScene()	

 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nye"
        .Duration = 4
        .Title = ""
        .Message = ""
        .Font = FlexDMD.NewFont("FONTS/sendha52.fnt", RGB(255, 255, 255), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noblink"
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
        .Title = ""
        .Message = ""
        .Font = FlexDMD.NewFont("FONTS/sendha52.fnt", RGB(255, 255, 255), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noblink"
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
        .Title = ""
        .Message = ""
        .Font = FlexDMD.NewFont("FONTS/sendha52.fnt", RGB(255, 255, 255), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noblink"
        .BGImage = "noimage"
        .BGVideo = "BGFuel"
    End With
    DmdQ.Enqueue qItem

End Sub