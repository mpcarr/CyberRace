
Sub FlexDMDBoostModeScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "boost"
        .Duration = 2
        .Title = "JACKPOTS GROW"
        .Message = "FormatScore(GetPlayerState(JACKPOT_VALUE))"
        .Font = FontCyber32        
        .MessageFont = FontCyber32        
        .StartPos = Array(DMDWidth/2,DMDHeight/2)
        .EndPos = Array(DMDWidth/2,DMDHeight/2)
        .Action = "blink"
        .BGImage = "noimage"
        .BGVideo = "BGBoost"
    End With
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
        .Title = "POINTS BOOST"
        .Message = "(3 * GetPlayerState(BOOST_ACTIVATIONS)) - GetPlayerState(BOOST_HITS) & "" FOR BOOST MODE"""
        .Font = FontCyber32        
        .MessageFont = FontCyber32        
        .StartPos = Array(DMDWidth/2,DMDHeight*.6)
        .EndPos = Array(DMDwidth/2,DMDHeight*.6)
        .Action = ""
        .BGImage = "noimage"
        .BGVideo = "BGBoost"
    End With
    DmdQ.Enqueue qItem
   
    lightCtrl.AddLightSeq "BoostUp", lSeqBoostUp
    lightCtrl.pulse l140, 0
    lightCtrl.pulse l141, 0
    lightCtrl.pulse l142, 0
    lightCtrl.pulse l143, 0

End Sub