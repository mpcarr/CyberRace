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
            DebugScore = DebugScore + 1500
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
    Else
        gameState("switches")("rightOrbit") = 1
    End If
    gameState("switches")("preRightOrbit") = 0
    gameState("switches")("preLeftOrbit") = 0
End Sub