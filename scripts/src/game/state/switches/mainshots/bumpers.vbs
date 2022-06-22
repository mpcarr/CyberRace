
Sub SwitchHitBumper()
    
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BUMPERS
        If gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 4 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_BUMPERS, GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_BUMPERS, GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
End Sub