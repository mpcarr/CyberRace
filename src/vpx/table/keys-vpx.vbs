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



    If glf_gameStarted = True Then
       
    
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

        If keycode = LeftFlipperKey Then
            LFlipperDown = True
            DOF 101,DOFOn
            FlipperActivate LeftFlipper,LFPress
            LF.Fire    
            If LeftFlipper.currentangle < LeftFlipper.endangle + ReflipAngle Then 
                RandomSoundReflipUpLeft LeftFlipper
            Else 
                SoundFlipperUpAttackLeft LeftFlipper
                RandomSoundFlipperUpLeft LeftFlipper
            End If
        End If
        
        If keycode = RightFlipperKey Then 
            FlipperActivate RightFlipper, RFPress
            RF.Fire
            RFlipperDown = True
            DOF 102,DOFOn
			If StagedFlipperMod <> 1 Then
				UpRightFlipper.RotateToEnd
			End If
            If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then
                RandomSoundReflipUpRight RightFlipper
            Else 
                SoundFlipperUpAttackRight RightFlipper
                RandomSoundFlipperUpRight RightFlipper
            End If
        End If

	    If StagedFlipperMod = 1 Then
            If keycode = 40 Then 
                UpRightFlipper.RotateToEnd
                If UpRightFlipper.currentangle > UpRightFlipper.endangle - ReflipAngle Then
                    RandomSoundReflipUpRight UpRightFlipper
                Else 
                    SoundFlipperUpAttackRight UpRightFlipper
                    RandomSoundFlipperUpRight UpRightFlipper
                End If
            End If
        End If
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

    'If gameStarted = True Then
    If keycode = PlungerKey Then
        PlaySoundAt "Plunger_Release_Ball", Plunger
        Plunger.Fire
    End If
    
    If keycode = LeftFlipperKey Then
        DOF 101,DOFOff
        LFlipperDown = False
        FlipperDeActivate LeftFlipper, LFPress
        LeftFlipper.RotateToStart
        If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
            RandomSoundFlipperDownLeft LeftFlipper
        End If
        FlipperLeftHitParm = FlipperUpSoundLevel
    End If
    If keycode = RightFlipperKey Then
        DOF 102,DOFOff
        RFlipperDown = False
        FlipperDeActivate RightFlipper, RFPress
        RightFlipper.RotateToStart
        If StagedFlipperMod <> 1 Then
            UpRightFlipper.RotateToStart
            End If
        End If	
        If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
            RandomSoundFlipperDownRight RightFlipper
        FlipperRightHitParm = FlipperUpSoundLevel
    End If
	If StagedFlipperMod = 1 Then
        If keycode = 40 Then
            UpRightFlipper.RotateToStart
            If UpRightFlipper.currentangle > UpRightFlipper.startAngle + 5 Then
                RandomSoundFlipperDownRight UpRightFlipper
            End If	
        End If
    End If

    Glf_KeyUp(keycode)
End Sub

'***********************************************************************************************************************
