'***********************************************************************************************************************
'*****  TABLE KEYS                                            	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Table1_KeyDown(ByVal Keycode)

    If gameStarted = False Then

        If keyCode = 30 Then 'A
            'LightSeqAllLights.StopPlay
            'LightSeqAllLights.UpdateInterval = 2000
            'LightSeqAllLights.Play SeqMiddleOutHorizOn , 12, 0
	    End If
		
        If keycode = StartGameKey Then
            StartGame()
        End If

        If keycode = LeftMagnaSave then
            lutpos = lutpos - 1 : If lutpos < 0 Then lutpos = 0 : end if
            Table1.ColorGradeImage = luts(lutpos)
        End if
    
        If keycode = RightMagnaSave then
            lutpos = lutpos + 1 : If lutpos > 5 Then lutpos = 5: end if
            Table1.ColorGradeImage = luts(lutpos)
        End if

    Else
    
        If keycode = PlungerKey Then
            PlaySoundAt "fx_plungerpull", Plunger
            Plunger.Pullback
        End If
        
        debugKeys(Keycode)
        If keyCode = 66 Then 'F8
            DebugPostState
        End If

        If keycode = 46 then ' C Key
            If contball = 1 Then
                contball = 0
            Else
                contball = 1
            End If
        End If
        if keycode = 203 then bcleft = 1 ' Left Arrow
        if keycode = 200 then bcup = 1 ' Up Arrow
        if keycode = 208 then bcdown = 1 ' Down Arrow
        if keycode = 205 then bcright = 1 ' Right Arrow

        If keycode = LeftTiltKey Then Nudge 90, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, -0.1, 0.25
        If keycode = RightTiltKey Then Nudge 270, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, 0.1, 0.25
        If keycode = CenterTiltKey Then Nudge 0, 7:PlaySound SoundFX("fx_nudge",0), 0, 1, 1, 0.25
        'TODO ADD CHECK TILT
        
        If keycode = LeftFlipperKey Then
            'LeftFlipper.RotateToEnd
            'PlaySound SoundFX("fx_flipperup",DOFFlippers), 0, .67, AudioPan(LeftFlipper), 0.05,0,0,1,AudioFade(LeftFlipper)
            
            FlipperActivate LeftFlipper,LFPress
            LF.Fire
        
            If LeftFlipper.currentangle < LeftFlipper.endangle + ReflipAngle Then 
                RandomSoundReflipUpLeft LeftFlipper
            Else 
                SoundFlipperUpAttackLeft LeftFlipper
                RandomSoundFlipperUpLeft LeftFlipper
            End If
            
            
            
            Dispatch SWITCH_LEFT_FLIPPER_DOWN, Null
        End If
        
        If keycode = RightFlipperKey Then 
            'RightFlipper.RotateToEnd
            UpRightFlipper.RotateToEnd
            'UpRightFlipper001.RotateToEnd
            'PlaySound SoundFX("fx_flipperup",DOFFlippers), 0, .67, AudioPan(RightFlipper), 0.05,0,0,1,AudioFade(RightFlipper)
            FlipperActivate RightFlipper, RFPress
            RF.Fire

            If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then
                RandomSoundReflipUpRight RightFlipper
            Else 
                SoundFlipperUpAttackRight RightFlipper
                RandomSoundFlipperUpRight RightFlipper
            End If
            
            Dispatch SWITCH_RIGHT_FLIPPER_DOWN, Null
        End If
    End If
End Sub


Sub Table1_KeyUp(ByVal keycode)
    
    	
    'Manual Ball Control

	if keycode = 203 then bcleft = 0 ' Left Arrow
	if keycode = 200 then bcup = 0 ' Up Arrow
	if keycode = 208 then bcdown = 0 ' Down Arrow
	if keycode = 205 then bcright = 0 ' Right Arrow
    
    If keycode = PlungerKey Then
        PlaySoundAt "fx_plunger", Plunger
        Plunger.Fire
    End If
    
    ' Table specific
    If keycode = LeftFlipperKey Then
       ''ldown = 0
        'LeftFlipper.RotateToStart
        'PlaySound SoundFX("fx_flipperdown",DOFFlippers), 0, 1, AudioPan(LeftFlipper), 0.05,0,0,1,AudioFade(LeftFlipper)
        FlipperDeActivate LeftFlipper, LFPress
		LeftFlipper.RotateToStart
		If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
			RandomSoundFlipperDownLeft LeftFlipper
		End If
		FlipperLeftHitParm = FlipperUpSoundLevel
    End If
    If keycode = RightFlipperKey Then
       ''rdown = 0
        'RightFlipper.RotateToStart
        FlipperDeActivate RightFlipper, RFPress
        UpRightFlipper.RotateToStart
        'UpRightFlipper001.RotateToStart
        'PlaySound SoundFX("fx_flipperdown",DOFFlippers), 0, 1, AudioPan(RightFlipper), 0.05,0,0,1,AudioFade(RightFlipper)
        RightFlipper.RotateToStart
		If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
			RandomSoundFlipperDownRight RightFlipper
		End If	
		FlipperRightHitParm = FlipperUpSoundLevel
    End If

    
End Sub

'***********************************************************************************************************************
