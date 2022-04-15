Sub SwitchHitSpinner2()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        PlaySoundAt "fx-spinner2", Spinner2
        GameAddScore GAME_POINTS_SPINNER
        If gameState("game")("perkShot") = GAME_SHOT_SPINNER Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 3 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        PlaySoundAt "fx-spinner2", Spinner2
        If gameState("game")("targetShots").Exists(GAME_SHOT_SPINNER) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If gameState("game")("targetShots").Exists(GAME_SHOT_SPINNER) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
End Sub
