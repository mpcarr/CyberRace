
Sub FlexDMDBoostModeScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "boost"
        .Duration = 2
        .Title = "JACKPOTS GROW"
        .Message = "FormatScore(GetPlayerState(JACKPOT_VALUE))"
        .Font = FlexDMD.NewFont("FONTS/sendha20.fnt", RGB(255, 255, 255), RGB(0, 0, 0), 0)
        .MessageFont = FlexDMD.NewFont("FONTS/sendha22.fnt", RGB(255, 255, 255), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
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
        .Font = FlexDMD.NewFont("FONTS/sendha24.fnt", RGB(255, 255, 255), RGB(0, 0, 0), 0)
        .MessageFont = FlexDMD.NewFont("FONTS/sendha16.fnt", RGB(255, 255, 255), RGB(0, 0, 0), 0)
        .StartPos = Array(128,38)
        .EndPos = Array(128,38)
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