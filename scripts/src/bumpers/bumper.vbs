'***********************************************************************************************************************
'***** Bumpers                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Bumper1_Hit()
    PlaySoundAt SoundFXDOF("fx_bumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper1HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper1HitFlash)

    DISPATCH SWITCH_HIT_BUMPER, null
End Sub

Sub Bumper2_Hit()
    PlaySoundAt SoundFXDOF("fx_bumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper2HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper2HitFlash)

    DISPATCH SWITCH_HIT_BUMPER, null
End Sub

Sub Bumper3_Hit()
    PlaySoundAt SoundFXDOF("fx_bumper", 107, DOFPulse, DOFContactors), ActiveBall  

    Dim colorIndex:colorIndex = RndNum(0,1)
    lSeqBumper3HitFlash.LampColor = gameColors(colorIndex)
    lSeqBumpersFlash.AddItem(lSeqBumper3HitFlash)

    DISPATCH SWITCH_HIT_BUMPER, null
End Sub