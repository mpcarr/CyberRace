'****************************
' Bumper 1 Hit
'*****************************
Sub Bumper1_Hit()
    If GameTilted = False Then
        RandomSoundBumperTop(Bumper1)
        DOF 107, DOFPulse
        HitPopBumpers(l77)
    End If
End Sub
Sub Bumper2_Hit()
    If GameTilted = False Then
        RandomSoundBumperMiddle(Bumper2)
        DOF 108, DOFPulse
        HitPopBumpers(l78)
    End If
End Sub
Sub Bumper3_Hit()
    If GameTilted = False Then
        RandomSoundBumperBottom(Bumper3) 
        DOF 109, DOFPulse
        HitPopBumpers(l79)
    End If
End Sub