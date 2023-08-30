'****************************
' Bumper 1 Hit
'*****************************
Sub Bumper1_Hit()
    'PlaySoundAt SoundFXDOF("LeftBumper", 107, DOFPulse, DOFContactors), ActiveBall
    RandomSoundBumperTop(Bumper1)
    HitPopBumpers(l77)
End Sub
Sub Bumper2_Hit()
    'PlaySoundAt SoundFXDOF("RightBumper", 107, DOFPulse, DOFContactors), ActiveBall  
    RandomSoundBumperMiddle(Bumper2)
    HitPopBumpers(l78)
End Sub
Sub Bumper3_Hit()
    'PlaySoundAt SoundFXDOF("BottomBumper", 107, DOFPulse, DOFContactors), ActiveBall 
    RandomSoundBumperBottom(Bumper3) 
    HitPopBumpers(l79)
End Sub