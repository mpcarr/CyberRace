'***********************************************************************************************************************
'*****  TABLE KEYS                                            	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Table1_KeyDown(ByVal Keycode)

    If bInOptions Then
		Options_KeyDown keycode
		Exit Sub
	End If
	If keycode = LeftMagnaSave Then
		If bOptionsMagna Then Options_Open() Else bOptionsMagna = True
    ElseIf keycode = RightMagnaSave Then
		If bOptionsMagna Then Options_Open() Else bOptionsMagna = True
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
   

    If gameStarted = False Then
        If keycode = StartGameKey Then
            AddPlayer()
            StartGame()
        End If
    Else

        If GameTimers(GAME_BONUS_TIMER_IDX) > 0 Then Exit Sub 
        
        If keycode = StartGameKey And canAddPlayers = True Then
            AddPlayer()
        End If
        If keycode = StartGameKey Then
            DispatchPinEvent SWITCH_START_GAME_KEY
        End If
        If keycode = PlungerKey Then
            PlaySoundAt "Plunger_Pull_1", Plunger
            Plunger.Pullback
        End If
    
        If keycode = LeftTiltKey Then Nudge 90, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, -0.1, 0.25
        If keycode = RightTiltKey Then Nudge 270, 6:PlaySound SoundFX("fx_nudge",0), 0, 1, 0.1, 0.25
        If keycode = CenterTiltKey Then Nudge 0, 7:PlaySound SoundFX("fx_nudge",0), 0, 1, 1, 0.25
        
        If(keycode = PlungerKey OR keycode = Lockbarkey) Then
            DispatchPinEvent(SWITCH_SELECT_EVENT_KEY)
        End If

        If keycode = LeftFlipperKey Then
            LFlipperDown = True   
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
            UpRightFlipper.RotateToEnd
            FlipperActivate RightFlipper, RFPress
            RF.Fire
            RFlipperDown = True
            If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then
                RandomSoundReflipUpRight RightFlipper
            Else 
                SoundFlipperUpAttackRight RightFlipper
                RandomSoundFlipperUpRight RightFlipper
            End If
            DispatchPinEvent(SWITCH_RIGHT_FLIPPER_DOWN)
        End If
    End If    
End Sub


Sub Table1_KeyUp(ByVal keycode)

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
            RFlipperDown = False
            FlipperDeActivate RightFlipper, RFPress
            UpRightFlipper.RotateToStart
            RightFlipper.RotateToStart
            If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
                RandomSoundFlipperDownRight RightFlipper
            End If	
            FlipperRightHitParm = FlipperUpSoundLevel
            DispatchPinEvent(SWITCH_RIGHT_FLIPPER_UP)
        End If
    'End If
End Sub

'***********************************************************************************************************************
