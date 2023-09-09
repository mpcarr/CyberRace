
Sub FlexDMDBoostModeScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "boost"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBoost"
    End With
    qItem.AddLabel "JACKPOTS GROW", 		Font12, DMDWidth/2, DMDHeight*.4, DMDWidth/2, DMDHeight*.4, ""
    qItem.AddLabel "FormatScore(GetPlayerState(JACKPOT_VALUE))", 		Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
    DmdQ.Enqueue qItem
    lightCtrl.AddLightSeq "BoostUp", lSeqBoostUp
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
    End With
    qItem.AddLabel "POINTS BOOST", 		Font12, DMDWidth/2, DMDHeight*.4, DMDWidth/2, DMDHeight*.4, ""
    qItem.AddLabel "(3 * GetPlayerState(BOOST_ACTIVATIONS)) - GetPlayerState(BOOST_HITS) & "" FOR BOOST MODE""", 		Font7, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
   
    lightCtrl.AddLightSeq "BoostUp", lSeqBoostUp
    lightCtrl.pulse l140, 0
    lightCtrl.pulse l141, 0
    lightCtrl.pulse l142, 0
    lightCtrl.pulse l143, 0

End Sub