


Sub FlexDMDGarageEngineScene()	

 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nye"
        .Duration = 4
        .Title = ""
        .Message = ""
        .Font = FontCyber32        
        .StartPos = Array(DMDWidth/2,DMDHeight/2)
        .EndPos = Array(DMDWidth/2,DMDHeight/2)
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
        .Font = FontCyber32        
        .StartPos = Array(DMDWidth/2,DMDHeight/2)
        .EndPos = Array(DMDWidth/2,DMDHeight/2)
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
        .Font = FontCyber32        
        .StartPos = Array(DMDWidth/2,DMDHeight/2)
        .EndPos = Array(DMDWidth/2,DMDHeight/2)
        .Action = "noblink"
        .BGImage = "noimage"
        .BGVideo = "BGFuel"
    End With
    DmdQ.Enqueue qItem

End Sub