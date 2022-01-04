Sub SwitchHitRightRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        DebugScore = DebugScore + 1000
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
End Sub