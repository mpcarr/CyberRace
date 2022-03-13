Sub SwitchHitRightRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_RIGHT_RAMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 6 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP_COLLECT) Then
            DISPATCH GAME_MODE_FINISH_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_RIGHT_RAMP) Then
            RemoveGameTargetShot(GAME_SHOT_RIGHT_RAMP)
            LightOn(lsCyber4)
            lSeqMultiballE.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If
End Sub