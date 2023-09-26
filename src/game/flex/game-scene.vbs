Sub InitDMDGameSceneNormal()

	Dim lblScore : Set lblScore = FlexDMD.NewLabel("lblScore", font32, "0")
	lblScore.SetAlignedPosition 128, 32, FlexDMD_Align_Center

	Dim lblBall : Set lblBall = FlexDMD.NewLabel("lblBall", font20, "BALL 1")
	lblBall.SetAlignedPosition 40, 56, FlexDMD_Align_Center

	Dim lblPlayer : Set lblPlayer = FlexDMD.NewLabel("lblPlayer", font20, "PLAYER 1")
	lblPlayer.SetAlignedPosition 200, 56, FlexDMD_Align_Center

	'Dim af
	'Set af = lblScore.ActionFactory
	'dim blinkScore : Set blinkScore = af.Sequence()
	'blinkScore.Add af.Show(False)
	'blinkScore.Add af.Wait(0.2)
	'blinkScore.Add af.Show(True)
	'blinkScore.Add af.Wait(0.2)
	'lblScore.AddAction af.Repeat(blinkScore, -1)

	DMDNormalScene.AddActor lblScore
	DMDNormalScene.AddActor lblBall
	DMDNormalScene.AddActor lblPlayer

End Sub

Sub FlexModeUpdate_Timer()
	
	If gameStarted = True Then
		Dim flexMode, label
		flexMode = GetPlayerState(FLEX_MODE)
	End If
End Sub


'****************************
' Update DMD Player Name
' Event Listeners:          
	RegisterPinEvent NEXT_PLAYER, "UpdateDMDPlayerName"
'
'*****************************
Sub UpdateDMDPlayerName()
	Dim lp: Set lp = DMDNormalScene.GetLabel("lblPlayer")
	Dim lb: Set lb = DMDNormalScene.GetLabel("lblBall")
	lp.Text = currentPlayer
	lb.Text = "BALL " & GetPlayerState(CURRENT_BALL)
End Sub