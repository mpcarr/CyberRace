
'****************************
' Attract
' Event Listeners:          
    RegisterPinEvent GAME_OVER, "StartAttract"
'
'*****************************
Sub StartAttract()
    lightCtrl.ResetLights()
	lSeqSweepAll.Repeat  = True
	lSeqFadeCorners.Repeat  = True
	lSeqGIOff.Repeat  = True
	lSeqNonRGBUp.Repeat  = True
	lSeqGIRandom.Repeat  = True
	lightCtrl.AddLightSeq "Attract", lSeqSweepAll
	lightCtrl.AddLightSeq "Attract", lSeqFadeCorners
	lightCtrl.AddLightSeq "Attract", lSeqGIOff
	lightCtrl.AddLightSeq "Attract", lSeqNonRGBUp
	lightCtrl.AddLightSeq "Attract", lSeqGIRandom
End Sub