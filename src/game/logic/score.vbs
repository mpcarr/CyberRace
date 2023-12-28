Sub AddScore(v)
    'TODO Apply Any Multipliers
    SetPlayerState SCORE, GetPlayerState(SCORE) + v
End Sub

Sub AwardJackpot()
    SetPlayerState SCORE, GetPlayerState(SCORE) + GetPlayerState(JACKPOT_VALUE)
    Dim qItem : Set qItem = New QueueItem
	With qItem
		.Name = "jackpot"
		.Duration = 2
		.BGImage = "noimage"
		.BGVideo = "BGJackpot"
        .Action = "slidedown"
	End With
	DmdQ.Enqueue qItem
    calloutsQ.Add "jackpot", "PlayCallout(""jackpot"")", 1, 0, 0, 1000, 0, False
    lightCtrl.AddTableLightSeq "RGB", lSeqJackpotRGB
    lightCtrl.AddTableLightSeq "NonRGB", lSeqJackpotNonRGB
    DOF 250, DOFPulse
End Sub