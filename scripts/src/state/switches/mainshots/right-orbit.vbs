Sub SwitchHitPreRightOrbit()
    If gameState("switches")("rightOrbit") = 1 Then
        gameState("switches")("preRightOrbit") = 0
        gameState("switches")("rightOrbit") = 0
    Else
        gameState("switches")("preRightOrbit") = 1
    End If
End Sub

Sub SwitchHitRightOrbit()
    If gameState("switches")("preRightOrbit") = 1 Then
        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            PlaySound "left_orbit"
            'LightSeqGIUpperLeft.StopPlay
            'LightSeqGIUpperLeft.UpdateInterval = 2
            'LightSeqGIUpperLeft.Play SeqArcTopRightUpOn, 2, 0
            'LightSeqGIUpperLeft.Play SeqArcTopRightUpOff, 2, 0
            GameAddScore GAME_POINTS_BASE
            If gameState("game")("perkShot") = GAME_SHOT_RIGHT_ORBIT Then
                DISPATCH GAME_AWARD_PERKSHOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
            If gameState("game")("augmentationActive") = 7 Then
                DISPATCH GAME_AWARD_SKILLSHOT, Null
            End If
        End If
    
        If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_ORBIT) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_ORBIT) Then
                RemoveGameTargetShot(GAME_SHOT_RIGHT_ORBIT)
                LightOn(lsCyber5)
                lSeqMultiballR.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        DISPATCH GAME_COMBO, lsCombo5
    Else
        gameState("switches")("rightOrbit") = 1
    End If
    gameState("switches")("preRightOrbit") = 0
    gameState("switches")("preLeftOrbit") = 0
End Sub