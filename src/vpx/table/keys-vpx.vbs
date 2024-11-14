'***********************************************************************************************************************
'*****  TABLE KEYS                                            	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim bFlippersPressed : bFlippersPressed = False

Sub Table1_KeyDown(ByVal Keycode)

    If keycode = LeftFlipperKey Then
        VRFlipperLeft.X = VRFlipperLeft.X + 10
    End if
    If keycode = RightFlipperKey Then
        VRFlipperRight.X = VRFlipperRight.X - 10
    End if

    If keycode = PlungerKey Then
        PlaySoundAt "Plunger_Pull_1", Plunger
        Plunger.Pullback
    End If
    
    If keycode = LeftTiltKey Then Nudge 90, 2: SoundNudgeLeft : CheckTilt
    If keycode = RightTiltKey Then Nudge 270, 2: SoundNudgeRight : CheckTilt
    If keycode = CenterTiltKey Then Nudge 0, 3: SoundNudgeCenter : CheckTilt
        
    If keycode = MechanicalTilt Then 
        SoundNudgeCenter
        CheckMechTilt
    End If

    Glf_KeyDown(keycode) 
End Sub


Sub Table1_KeyUp(ByVal keycode)
    
    If keycode = LeftFlipperKey Then
        VRFlipperLeft.X = VRFlipperLeft.X - 10
    End if
    If keycode = RightFlipperKey Then
        VRFlipperRight.X = VRFlipperRight.X + 10
    End if

    If keycode = PlungerKey Then
        PlaySoundAt "Plunger_Release_Ball", Plunger
        Plunger.Fire
    End If

    Glf_KeyUp(keycode)
End Sub

'***********************************************************************************************************************
