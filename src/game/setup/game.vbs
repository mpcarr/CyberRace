Sub StartGame()
    gameStarted = True
    FlexDMD.Stage.GetVideo("vidIntro").Visible = False
    DispatchPinEvent START_GAME
    SetPlayerState ENABLE_BALLSAVER, True
    lightCtrl.RemoveAllTableLightSeqs()
    lightCtrl.RemoveAllLightSeq "Attract"
    FlexDMD.Stage.GetFrame("VSeparator1").Visible = True
    FlexDMD.Stage.GetFrame("VSeparator2").Visible = True
    FlexDMD.Stage.GetFrame("VSeparator3").Visible = True
    FlexDMD.Stage.GetFrame("VSeparator4").Visible = True
    If Not IsNull(Scorbit) Then
        If ScorbitActive = 1 And Scorbit.bNeedsPairing = False Then
            InitFlexScorbitClaimDMD()
            Scorbit.StartSession()
        End If
    End If
End Sub