'Devices

Sub ConfigureGlfDevices()

    With CreateGlfFlipper("left")
        .Switch = Array("s_left_flipper")
    End With
    AddPinEventListener "flipper_left_activate",   "on_left_flipper_activate",   "OnLeftFlipperActivate", 1000, Null
    AddPinEventListener "flipper_left_deactivate",   "on_left_flipper_deactivate",   "OnLeftFlipperDeactivate", 1000, Null
    
    With CreateGlfFlipper("right")
        .Switch = Array("s_right_flipper")
    End With
    AddPinEventListener "flipper_right_activate",   "on_right_flipper_activate",   "OnRightFlipperActivate", 1000, Null
    AddPinEventListener "flipper_right_deactivate",   "on_right_flipper_deactivate",   "OnRightFlipperDeactivate", 1000, Null

    If StagedFlipperMod = 1 Then
        With CreateGlfFlipper("upper_right")
            .Switch = Array("s_right_staged_flipper")
        End With
        AddPinEventListener "flipper_upper_right_activate",   "on_right_upper_flipper_activate",   "OnRightUpperFlipperActivate", 1000, Null
        AddPinEventListener "flipper_upper_right_deactivate",   "on_right_upper_flipper_deactivate",   "OnRightUpperFlipperDeactivate", 1000, Null
    Else
        With CreateGlfFlipper("upper_right")
            .Switch = Array("s_right_flipper")
        End With
    End If

    With CreateGlfBallDevice("plunger")
        .BallSwitches = Array("s_plunger")
        .EjectTargets = Array("sw27")
        .EjectStrength = 150
        .MechanicalEject = True
        .DefaultDevice = True
    End With

    With CreateGlfBallDevice("race_scoop")
        .BallSwitches = Array("s_race_scoop")
        .EjectCallback = "RaceVuk_EjectCallback"
    End With

    With CreateGlfBallDevice("center_scoop")
        .BallSwitches = Array("sw39")
        .EjectCallback = "Nodes_EjectCallback"
    End With

    With CreateGlfBallDevice("hyper")
        .BallSwitches = Array("sw38")
        .EjectCallback = "Hyper_EjectCallback"
    End With

    Dim segment_display_clock
    Set segment_display_clock = (New GlfLightSegmentDisplay)("clock")

    segment_display_clock.SegmentType = "14Segment"
    segment_display_clock.SegmentSize = 2
    segment_display_clock.LightGroup = "NeoSegClock"

    CreateAttractMode()
    CreateBaseMode()
    CreateSkillshotMode()
    CreateQualifyRaceMode()
    CreateRaceSelectionMode()
    CreateRace1Mode()

    AddPinEventListener "trough_eject",   "on_trough_eject",   "OnTroughEject", 1000, Null

End Sub

Sub OnTroughEject(args)
    'msgbox "here"
End Sub

Sub RaceVuk_EjectCallback(ball)
    SoundSaucerKick 1,s_race_scoop
    s_race_scoop.Kick 65, RndInt(7,15)
End Sub

Sub Nodes_EjectCallback(ball)
    SoundSaucerKick 1,sw39
    KickBall ball, 0, 0, 55, 10
End Sub

Sub Hyper_EjectCallback(ball)
    SoundSaucerKick 1,sw38
    sw38.Kick 0, 60, 1.36
End Sub

Function OnLeftFlipperActivate(args)
    LFlipperDown = True
    DOF 101, DOFOn
    FlipperActivate LeftFlipper, LFPress
    LF.Fire    
    If LeftFlipper.currentangle < LeftFlipper.endangle + ReflipAngle Then 
        RandomSoundReflipUpLeft LeftFlipper
    Else 
        SoundFlipperUpAttackLeft LeftFlipper
        RandomSoundFlipperUpLeft LeftFlipper
    End If
End Function

Function OnLeftFlipperDeactivate(args)
    DOF 101,DOFOff
    LFlipperDown = False
    FlipperDeActivate LeftFlipper, LFPress
    LeftFlipper.RotateToStart
    If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
        RandomSoundFlipperDownLeft LeftFlipper
    End If
    FlipperLeftHitParm = FlipperUpSoundLevel
End Function

Function OnRightFlipperActivate(args)
    FlipperActivate RightFlipper, RFPress
    RF.Fire
    RFlipperDown = True
    DOF 102,DOFOn
    If StagedFlipperMod <> 1 Then
        OnRightUpperFlipperActivate Null
    End If
    If RightFlipper.currentangle > RightFlipper.endangle - ReflipAngle Then
        RandomSoundReflipUpRight RightFlipper
    Else 
        SoundFlipperUpAttackRight RightFlipper
        RandomSoundFlipperUpRight RightFlipper
    End If
End Function

Function OnRightFlipperDeactivate(args)
    DOF 102,DOFOff
    RFlipperDown = False
    FlipperDeActivate RightFlipper, RFPress
    RightFlipper.RotateToStart
    If StagedFlipperMod <> 1 Then
        OnRightUpperFlipperDeactivate Null
    End If
    If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
        RandomSoundFlipperDownRight RightFlipper
        FlipperRightHitParm = FlipperUpSoundLevel
    End If
End Function

Function OnRightUpperFlipperActivate(args)
    UpRightFlipper.RotateToEnd
    If UpRightFlipper.currentangle > UpRightFlipper.endangle - ReflipAngle Then
        RandomSoundReflipUpRight UpRightFlipper
    Else 
        SoundFlipperUpAttackRight UpRightFlipper
        RandomSoundFlipperUpRight UpRightFlipper
    End If
End Function

Function OnRightUpperFlipperDeactivate(args)
    UpRightFlipper.RotateToStart
    If UpRightFlipper.currentangle > UpRightFlipper.startAngle + 5 Then
        RandomSoundFlipperDownRight UpRightFlipper
    End If
End Function