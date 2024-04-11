
Sub FlexDMDBoostModeScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "boost"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBoost"
        .Replacements = Array("DMDLabelJackpotValue")
    End With
    qItem.AddLabel "JACKPOTS GROW", 		Font12, DMDWidth/2, DMDHeight*.4, DMDWidth/2, DMDHeight*.4, ""
    qItem.AddLabel "$1", 		Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
    DmdQ.Enqueue qItem
    LightSeqRGB.Play SeqUpOn,50,2
    lightCtrl.SyncWithVpxLights lightSeqRGB
    lightCtrl.SetVpxSyncLightColor RGB(0,255,0)
    
    lightCtrl.pulse l140, 0
    lightCtrl.pulse l141, 0
    lightCtrl.pulse l142, 0
    lightCtrl.pulse l143, 0
End Sub

Sub FlexDMDBoostScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "boost"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBoost"
        .Replacements = Array("DMDLabelPointsBoost")
    End With
    qItem.AddLabel "POINTS BOOST", 		Font12, DMDWidth/2, DMDHeight*.4, DMDWidth/2, DMDHeight*.4, ""
    qItem.AddLabel "$1 FOR BOOST MODE", 		Font7, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
   
    LightSeqRGB.Play SeqUpOn,50,2
    lightCtrl.SyncWithVpxLights lightSeqRGB
    lightCtrl.SetVpxSyncLightColor RGB(0,255,0)
    
    lightCtrl.pulse l140, 0
    lightCtrl.pulse l141, 0
    lightCtrl.pulse l142, 0
    lightCtrl.pulse l143, 0

End Sub

Function DMDLabelJackpotValue
    DMDLabelJackpotValue = FormatScore(GetPlayerState(JACKPOT_VALUE))
End Function

Function DMDLabelPointsBoost
    DMDLabelPointsBoost = (3 * GetPlayerState(BOOST_ACTIVATIONS)) - GetPlayerState(BOOST_HITS)
End Function