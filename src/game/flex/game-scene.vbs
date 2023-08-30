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

		Select Case flexMode
			Case 0: 'SCORE
				Dim flexScoreLabel: Set flexScoreLabel = DMDNormalScene.GetLabel("lblScore")
				If lenScore>6 Then
					flexScoreLabel.Font = font32
				End If
				flexScoreLabel.Text = FormatScore(GetPlayerState(SCORE))
				flexScoreLabel.SetAlignedPosition 128, 32, FlexDMD_Align_Center
			Case 1: 'EMP SCENE
				Dim chargeLabel: Set chargeLabel = DMDEMPScene.GetLabel("lblCharge2")
				chargeLabel.Text =  (EMP_BASE_HITS * GetPlayerState(EMP_ACTIVATIONS)) - GetPlayerState(EMP_CHARGE) & " HITS REMAINING"
				chargeLabel.SetAlignedPosition 128, 42, FlexDMD_Align_Center			
			Case 3: 'BOOST SCENE
				'Set label = DMDBoostScene.GetLabel("lblBoost")
				'label.Text =  ((3 * GetPlayerState(BOOST_ACTIVATIONS)) - GetPlayerState(BOOST_HITS))  & " HITS REMAINING"
				'label.SetAlignedPosition 128, 32, FlexDMD_Align_Center			
			Case 7: 'RACE MODE SELECTION SCENE
				Dim labelTitle : Set labelTitle = DMDRaceSelectScene.GetLabel("lblRaceTitle")
				Dim labelDescription : Set labelDescription = DMDRaceSelectScene.GetLabel("lblRaceDescription")
				Dim selection : selection = GetPlayerState(RACE_MODE_SELECTION)
				labelTitle.Text =  "RACE " & selection & " -VS- " & GAME_RACE_MODE_TITLES(selection-1)
				labelDescription.Text =  GAME_RACE_MODE_DESC(selection-1)
				labelTitle.SetAlignedPosition 128, 24, FlexDMD_Align_Center
				labelDescription.SetAlignedPosition 128, 42, FlexDMD_Align_Center
		End Select
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