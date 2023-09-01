
Sub FlexDMDCyberScene()
    
	dim letter
	If GetPlayerState(CYBER_C) = 1 Then letter = letter & " C "
	If GetPlayerState(CYBER_Y) = 1 Then letter = letter & " Y "
	If GetPlayerState(CYBER_B) = 1 Then letter = letter & " B "
	If GetPlayerState(CYBER_E) = 1 Then letter = letter & " E "
	If GetPlayerState(CYBER_R) = 1 Then letter = letter & " R "
	
 	Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "cyber"
        .Duration = 2
        .Title = letter
        .Message = ""
        .Font = FontCyber32        
        .StartPos = Array(DMDWidth/2,DMDHeight*.3)
        .EndPos = Array(DMDWidth/2,DMDHeight*.3)
        .Action = "blink"
        .BGImage = "noimage"
        .BGVideo = "BGCyber"
    End With
    DmdQ.Enqueue qItem

    lightCtrl.pulse l29, 0
    lightCtrl.pulse l30, 0
    lightCtrl.pulse l31, 0
    lightCtrl.pulse l32, 0
	lightCtrl.pulse l33, 0
	PlaySoundAt "fx_cyber-whoosh", ActiveBall
End Sub

