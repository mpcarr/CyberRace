
Sub SwitchHitShortcut()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_SHORTCUT Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
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

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_SHORTCUT) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    gameState("switches")("shortcut") = 1
End Sub