Sub AddScore(v)
    If GameTilted = False Then
        SetPlayerState SCORE, GetPlayerState(SCORE) + (v*GetPlayerState(PF_MULTIPLIER))
    End If
End Sub

Sub AwardJackpot()
    SetPlayerState SCORE, GetPlayerState(SCORE) + ((GetPlayerState(JACKPOT_VALUE)*GetPlayerState(JACKPOTS_MULTIPLIER)) * GetPlayerState(PF_MULTIPLIER))
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


Sub AwardSuperJackpot()
SetPlayerState SCORE, GetPlayerState(SCORE) + (((GetPlayerState(JACKPOT_VALUE)*2) * GetPlayerState(JACKPOTS_MULTIPLIER)) * GetPlayerState(PF_MULTIPLIER))
    Dim qItem : Set qItem = New QueueItem
	With qItem
		.Name = "superjackpot"
		.Duration = 3
		.BGImage = "noimage"
		.BGVideo = "BGSuperJackpot"
        .Action = "slidedown"
	End With
	DmdQ.Enqueue qItem
    calloutsQ.Add "jackpot", "PlayCallout(""super-jackpot"")", 1, 0, 0, 1000, 0, False
    lightCtrl.AddTableLightSeq "RGB", lSeqJackpotRGB
    lightCtrl.AddTableLightSeq "NonRGB", lSeqJackpotNonRGB
    DOF 250, DOFPulse
End Sub

Sub AwardWizardJackpot(callout)
    SetPlayerState SCORE, GetPlayerState(SCORE) + ((GetPlayerState(JACKPOT_VALUE)*GetPlayerState(JACKPOTS_MULTIPLIER)) * GetPlayerState(PF_MULTIPLIER)) + wizardPointsAddOn
    Dim qItem : Set qItem = New QueueItem
	With qItem
		.Name = "wizjackpot"
		.Duration = 3
		.BGImage = "noimage"
		.BGVideo = "BGWizJackpot"
        .Action = "slidedown"
	End With
	DmdQ.Enqueue qItem
    If callout = True Then
        Debounce "wizjack", "TimerWizJackpot", 500
    End If
    lightCtrl.AddTableLightSeq "RGB", lSeqJackpotRGB
    lightCtrl.AddTableLightSeq "NonRGB", lSeqJackpotNonRGB
    DOF 250, DOFPulse
End Sub

Sub TimerWizJackpot
    calloutsQ.Add "jackpot", "PlayCallout(""""jackpot"""")", 1, 0, 0, 1000, 0, False
End Sub