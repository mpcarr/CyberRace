
Sub StartGame()
    If BallsInTrough = 5 Then
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
                Scorbit.StartSession()
                LoadTexture "", TablesDir & "\CRQR\QRclaim.png"
   				ScorbitFlasher.ImageA = "QRclaim"
   				ScorbitFlasher.Visible = True
            End If
        End If
        DOF 105, DOFPulse
    End If
End Sub