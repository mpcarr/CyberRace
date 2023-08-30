Sub StartGame()
    gameStarted = True
    FlexDMD.Stage.GetVideo("vidIntro").Visible = False
    DispatchPinEvent START_GAME
    SetPlayerState ENABLE_BALLSAVER, True
    lightCtrl.RemoveAllTableLightSeqs()
    lightCtrl.RemoveAllLightSeq "Attract"
End Sub