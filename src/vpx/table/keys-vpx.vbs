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

    If bInOptions Then
		Options_KeyDown keycode
		Exit Sub
	End If
	If keycode = LeftMagnaSave Then
		If bOptionsMagna Then Options_Open() Else bOptionsMagna = True
    ElseIf keycode = RightMagnaSave Then
		If bOptionsMagna Then Options_Open() Else bOptionsMagna = True
	End If


    'If keycode = 46 then ' C Key
    '    If contball = 1 Then
    '        contball = 0
    '    Else
    '        contball = 1
    '    End If
    'End If
    'if keycode = 203 then bcleft = 1 ' Left Arrow
    'if keycode = 200 then bcup = 1 ' Up Arrow
    'if keycode = 208 then bcdown = 1 ' Down Arrow
    'if keycode = 205 then bcright = 1 ' Right Arrow
   

    If gameStarted = False Then
        If keycode = StartGameKey And gameBooted = True Then
            playerState.RemoveAll()
            AddPlayer()
            StartGame()
        End If
    Else
        If GAME_DRAIN_BALLS_AND_RESET = True Or GameTilted = True Then
            Exit Sub
        End If

        If GameTimers(GAME_BONUS_TIMER_IDX) > 0 Then 
            
            If keycode = LeftFlipperKey Then
                LFlipperDown = True   
                If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
            End If
            
            If keycode = RightFlipperKey Then 
                RFlipperDown = True
                If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
            End If    
            
            Exit Sub 
        End If
        
        
        If keycode = StartGameKey Then
            AddPlayer()
        End If
        If keycode = StartGameKey Then
            DispatchPinEvent SWITCH_START_GAME_KEY
        End If
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

        If(keycode = PlungerKey OR keycode = Lockbarkey) Then
            DispatchPinEvent(SWITCH_SELECT_EVENT_KEY)
        End If

        If keycode = LeftFlipperKey Then
            LFlipperDown = True
            DOF 101,DOFOn
            If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
            FlipperActivate LeftFlipper,LFPress
            LF.Fire    
            If LeftFlipper.currentangle < LeftFlipper.endangle + ReflipAngle Then 
                RandomSoundReflipUpLeft LeftFlipper
            Else 
                SoundFlipperUpAttackLeft LeftFlipper
                RandomSoundFlipperUpLeft LeftFlipper
            End If
            DispatchPinEvent(SWITCH_LEFT_FLIPPER_DOWN)
        End If
        
        If keycode = RightFlipperKey Then 
            'UpRightFlipper.RotateToEnd
            FlipperActivate RightFlipper, RFPress
            RF.Fire
            RFlipperDown = True
            DOF 102,DOFOn
            If LFlipperDown And RFlipperDown Then DispatchPinEvent(SWITCH_BOTH_FLIPPERS_PRESSED) End If
			If StagedFlipperMod <> 1 Then
				UpRightFlipper.RotateToEnd
			End If
            If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then
                RandomSoundReflipUpRight RightFlipper
            Else 
                SoundFlipperUpAttackRight RightFlipper
                RandomSoundFlipperUpRight RightFlipper
            End If
            DispatchPinEvent(SWITCH_RIGHT_FLIPPER_DOWN)
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
End Sub


Sub Table1_KeyUp(ByVal keycode)
    
    If keycode = LeftFlipperKey Then
        VRFlipperLeft.X = VRFlipperLeft.X - 10
    End if
    If keycode = RightFlipperKey Then
        VRFlipperRight.X = VRFlipperRight.X + 10
    End if

    If keycode = LeftMagnaSave And Not bInOptions Then bOptionsMagna = False
    If keycode = RightMagnaSave And Not bInOptions Then bOptionsMagna = False


    if keycode = 203 then bcleft = 0 ' Left Arrow
    if keycode = 200 then bcup = 0 ' Up Arrow
    if keycode = 208 then bcdown = 0 ' Down Arrow
    if keycode = 205 then bcright = 0 ' Right Arrow

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
            DispatchPinEvent(SWITCH_LEFT_FLIPPER_UP)
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
            DispatchPinEvent(SWITCH_RIGHT_FLIPPER_UP)
        End If
	If StagedFlipperMod = 1 Then
        If keycode = 40 Then
            UpRightFlipper.RotateToStart
            If UpRightFlipper.currentangle > UpRightFlipper.startAngle + 5 Then
                RandomSoundFlipperDownRight UpRightFlipper
            End If	
        End If
    End If
End Sub

'***********************************************************************************************************************
