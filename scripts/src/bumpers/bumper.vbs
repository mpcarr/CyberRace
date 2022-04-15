'***********************************************************************************************************************
'***** Bumpers                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Bumper1_Hit()
    PlaySoundAt SoundFXDOF("LeftBumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper1HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper1HitFlash)
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False OR Not gameState("game")("augmentationActive") = 4 OR Not gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
        If colorIndex = 0 Then
            DOF 203, DOFPulse
        Else
            DOF 205, DOFPulse
        End If
    End If
    DISPATCH SWITCH_HIT_BUMPER, null
End Sub

Sub Bumper2_Hit()
    PlaySoundAt SoundFXDOF("RightBumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper2HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper2HitFlash)
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False OR Not gameState("game")("augmentationActive") = 4 OR Not gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
        If colorIndex = 0 Then
            DOF 203, DOFPulse
        Else
            DOF 205, DOFPulse
        End If
    End If
    DISPATCH SWITCH_HIT_BUMPER, null
End Sub

Sub Bumper3_Hit()
    PlaySoundAt SoundFXDOF("BottomBumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper3HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper3HitFlash)
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False OR Not gameState("game")("augmentationActive") = 4 OR Not gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
        If colorIndex = 0 Then
            DOF 203, DOFPulse
        Else
            DOF 205, DOFPulse
        End If
    End If
    DISPATCH SWITCH_HIT_BUMPER, null
End Sub