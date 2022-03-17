'***********************************************************************************************************************
'*****       Kickers                                          	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub consoleKicker_Hit()
    Dispatch SWITCH_HIT_CONSOLE, Null 
End Sub

Sub drain_Hit()
    drain.DestroyBall

    If gameStarted = false Then
        Exit Sub
    End If
    dim bip: bip = UBound(GetBalls) - gameState("game")("ballsLocked") - 1 'actual balls in play (minus captive)
    'Debug.print UBound(GetBalls)
    If gameState("game")("ballSave") = True Then
        'Kick out balls until ballsInPlay is equaled
        If Not bip = gameState("game")("ballsInPlay") Then
            'kick out balls
            Dim newBalls
            For newBalls=1 to gameState("game")("ballsInPlay")-bip
                ballRelease.CreateSizedball BallSize / 2
                ballRelease.Kick 90, 4
                vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
            Next
        End If

        'If Not gameState("game")("outlaneDrain") Then
        '    ballRelease.CreateSizedball BallSize / 2
        '    ballRelease.Kick 90, 4
        '    vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
        'Else
        '    gameState("game")("outlaneDrain") = False
        'End If
    Else
        If bip = 0 Then
            DISPATCH GAME_END_OF_BALL, Null
        ElseIf bip = 1 And gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            'END MULTIBALL
            gameState("game")("modes")(GAME_MODE_MULTIBALL) = False
            
            DISPATCH GAME_MODE_NORMAL, Null
            gameState("game")("ballsInPlay") = 1
            lSeqMultiballC.RemoveAll()
	        lSeqMultiballY.RemoveAll()
	        lSeqMultiballB.RemoveAll()
	        lSeqMultiballE.RemoveAll()
	        lSeqMultiballR.RemoveAll()
            LightOff(lsCyber1)
            LightOff(lsCyber2)
            LightOff(lsCyber3)
            LightOff(lsCyber4)
            LightOff(lsCyber5)
            lSeqMultiballCShot.Image = "pal_green"
            lSeqMultiballYShot.Image = "pal_green"
            lSeqMultiballBShot.Image = "pal_green"
            lSeqMultiballEShot.Image = "pal_green"
            lSeqMultiballRShot.Image = "pal_green"
            gameState("switches")("lightlock") = 1
            CheckResearchLights
            DISPATCH LIGHTS_GI_NORMAL, Null
            DISPATCH GAME_CLEAR_SHOTS, Null
            PlayBGAudioNext()
        End If
    End If
End Sub

Sub vpmTimerDelayedAutoPlunge()
    PlungerIM.AutoFire
End Sub