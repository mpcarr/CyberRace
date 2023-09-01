Sub StartGame()
    gameStarted = True
    FlexDMD.Stage.GetVideo("vidIntro").Visible = False
    DispatchPinEvent START_GAME
    SetPlayerState ENABLE_BALLSAVER, True
    lightCtrl.RemoveAllTableLightSeqs()
    lightCtrl.RemoveAllLightSeq "Attract"
    'FlexDMD.Stage.GetImage("BGP1").Visible = False
    'FlexDMD.Stage.GetImage("BGP2").Visible = False
    'FlexDMD.Stage.GetImage("BGP3").Visible = False
    'FlexDMD.Stage.GetImage("BGP4").Visible = True
End Sub