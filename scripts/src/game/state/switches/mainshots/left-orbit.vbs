Sub SwitchHitPreLeftOrbit()
    If gameState("switches")("leftOrbit") = 1 Then
        gameState("switches")("preLeftOrbit") = 0
        gameState("switches")("leftOrbit") = 0
    Else
        gameState("switches")("preLeftOrbit") = 1
    End If
End Sub

Sub SwitchHitLeftOrbit()
    If gameState("switches")("preLeftOrbit") = 1 Then

        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            PlaySound "left_orbit"    
            'LightSeqGIUpperLeft.StopPlay   
            'LightSeqGIUpperLeft.UpdateInterval = 2
            'LightSeqGIUpperLeft.Play SeqArcTopLeftUpOn, 2, 0
            'LightSeqGIUpperLeft.Play SeqArcTopLeftUpOff, 2, 0
            GameAddScore GAME_POINTS_BASE
            If gameState("game")("perkShot") = GAME_SHOT_LEFT_ORBIT Then
                DISPATCH GAME_AWARD_PERKSHOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
            If gameState("game")("augmentationActive") = 1 Then
                DISPATCH GAME_AWARD_SKILLSHOT, Null
            End If
        End If
    
        If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_MULTIBALL) Then
                RemoveGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
                LightOn(lsCyber1)
                lSeqMultiballC.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_HURRYUP) Then
                DISPATCH GAME_AWARD_HURRYUP, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
            DISPATCH GAME_COMBO, lsCombo1
        End If
    Else
        gameState("switches")("leftOrbit") = 1
    End If
    gameState("switches")("preLeftOrbit") = 0
    gameState("switches")("preRightOrbit") = 0
End Sub