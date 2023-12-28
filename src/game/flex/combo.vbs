
Sub FlexSceneCombo(comboCount)

    Set qItem = New QueueItem
    With qItem
        .Name = "combo"
        .Duration = 2
        .BGImage = "BGBlack"
        .BGVideo = "novideo"
    End With
    qItem.AddLabel comboCount & " WAY COMBO", 		font12, DMDWidth/2, DMDHeight/2, DMDWidth/2, DMDHeight/2, "blink"
    DmdQ.Enqueue qItem


End Sub