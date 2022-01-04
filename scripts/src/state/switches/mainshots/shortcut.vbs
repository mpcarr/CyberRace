
Sub SwitchHitShortcut()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        DebugScore = DebugScore + 1000
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 8 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_SHORTCUT) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If
End Sub