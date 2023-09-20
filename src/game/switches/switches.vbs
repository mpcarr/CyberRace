
'******************************************
Sub Drain_Hit 
    debug.print("drain hit")
    RandomSoundDrain Drain
    UpdateTrough()
    DispatchPinEvent BALL_DRAIN
End Sub

Sub Drain_UnHit : UpdateTrough : End Sub

Sub raceVuk_Hit()
    DispatchPinEvent SWITCH_HIT_RACE_KICKER
    SoundSaucerLock()
End Sub

Sub raceVuk_Timer()
    raceVuk.TimerEnabled = False
    SoundSaucerKick 1,raceVuk
    raceVuk.Kick 65, RndInt(6,15)
    lightCtrl.pulse l141, 0
End Sub
'******************************************
Sub sw01_Hit()
    If ballSaver = True Then
        DispatchPinEvent BALL_SAVE
        ballSaverIgnoreCount = ballSaverIgnoreCount+1
    Else
        PlaySoundAtLevelStatic "drain", SoundFxLevel, sw01
    End If
    If GetPlayerState(LANE_R) > 0 Then
        lightCtrl.Pulse l42, 0
    End If
    
    HitInLanes(LANE_R)
End Sub
'******************************************
Sub sw02_Hit()
    If GetPlayerState(LANE_A) > 0 Then
        lightCtrl.Pulse l43, 0
    End If
    HitInLanes(LANE_A)
    DispatchPinEvent SWITCH_HIT_LANE_A
End Sub
'******************************************
Sub sw03_Hit()
    If GetPlayerState(LANE_C) > 0 Then
        lightCtrl.Pulse l44, 0
    End If
    HitInLanes(LANE_C)
End Sub
'******************************************
Sub sw04_Hit()
    If ballSaver = True Then
        DispatchPinEvent BALL_SAVE
        ballSaverIgnoreCount = ballSaverIgnoreCount+1
    Else
        PlaySoundAtLevelStatic "drain", SoundFxLevel, sw04
    End If
    If GetPlayerState(LANE_E) > 0 Then
        lightCtrl.Pulse l45, 0
    End If
    
    HitInLanes(LANE_E)
End Sub
'******************************************
Sub sw05_Hit()
    HitBonusLanes LANE_BO
End Sub
'******************************************
Sub sw06_Hit()
    HitBonusLanes LANE_N
End Sub
'******************************************
Sub sw07_Hit()
    HitBonusLanes LANE_US
End Sub
'******************************************
Sub sw_38_Hit()
    sw_38.TimerEnabled = True
    SoundSaucerLock()
    
End Sub
Sub sw_38_Timer() 
    DispatchPinEvent SWITCH_HIT_HYPER
    'lightCtrl.pulse l143, 0
    'sw_38.Kick 0, 60, 1.36
    sw_38.TimerEnabled = False
    'SoundSaucerKick 1, sw_38
End Sub
'******************************************
Sub sw39_Hit()
    set KickerBall39 = activeball
    DispatchPinEvent SWITCH_HIT_SCOOP
    SoundSaucerLock()
    If GetPlayerState(MODE_PERK_SELECT) = False Then
        sw39.TimerEnabled = True
    End If
End Sub
Sub sw39_Timer()
	sw39.TimerEnabled = False
    SoundSaucerKick 1, sw39
    KickBall KickerBall39, 0, 0, 55, 10
End Sub
'******************************************
Sub sw37_Hit()
    set KickerBall37 = activeball
    SoundSaucerLock()
	sw37.TimerEnabled = True
End Sub
Sub sw37_Timer()
	sw37.TimerEnabled = False
    SoundSaucerKick 1, sw37
    KickBall KickerBall37, 0, 0, 40, 10
End Sub
'******************************************
Sub Spinner1_Spin()
    PlaySound("fx_spinner")
    lightCtrl.pulse l143, 0
    DispatchPinEvent SWITCH_HIT_SPINNER1
End Sub
'******************************************
Sub Spinner2_Spin()
    PlaySound("fx_spinner")
    lightCtrl.pulse l141, 0
    DispatchPinEvent SWITCH_HIT_SPINNER2
End Sub
'******************************************
Sub sw08_Hit()
    If Not IsNull(lOrbitBall) AND lOrbitBall = ActiveBall.ID Then
        DispatchPinEvent SWITCH_HIT_LEFT_ORBIT
    End If
End Sub
'******************************************
Sub sw09_Hit()
    DispatchPinEvent SWITCH_HIT_RIGHT_RAMP
    For Each light in GIControlLights
        lightCtrl.PulseWithProfile light,Array(80,60,40,0,40,60,80,100),2
    Next
End Sub
'******************************************
Sub sw10_Hit()
    STHit 10
    DispatchPinEvent SWITCH_HIT_NODE_A
End Sub
'******************************************
Sub sw11_Hit()
    STHit 11
    DispatchPinEvent SWITCH_HIT_NODE_B
End Sub
'******************************************
Sub sw12_Hit()
    STHit 12
    DispatchPinEvent SWITCH_HIT_NODE_C
End Sub
'******************************************
Sub sw13_Hit()
    DispatchPinEvent SWITCH_HIT_LEFT_RAMP
    lightCtrl.PulseWithProfile l94,Array(80,60,40,0,40,60,80,100,0),2 'speeder
    For Each light in GIControlLights
        lightCtrl.PulseWithProfile light,Array(80,60,40,0,40,60,80,100),2
    Next
End Sub
'******************************************
Sub sw14_Hit()
    If Not IsNull(rOrbitBall) AND rOrbitBall = ActiveBall.ID Then
        DispatchPinEvent SWITCH_HIT_RIGHT_ORBIT
    End If
End Sub
'******************************************
Sub sw18_Hit()
    STHit 18
    DispatchPinEvent SWITCH_HIT_BOOST1
End Sub
'******************************************
Sub sw19_Hit()
    STHit 19
    DispatchPinEvent SWITCH_HIT_BOOST2
End Sub
'******************************************
Sub sw20_Hit()
    STHit 20
    DispatchPinEvent SWITCH_HIT_BOOST3
End Sub
'******************************************
Dim lOrbitBall : lOrbitBall = Null
Sub sw15_Hit() 'Left Orbit Opto
    lOrbitBall = ActiveBall.ID
    rOrbitBall = Null
End Sub
'******************************************
Dim rOrbitBall : rOrbitBall = Null
Sub sw16_Hit() 'Right Orbit Opto
    rOrbitBall = ActiveBall.ID
    lOrbitBall = Null
End Sub
'******************************************
Sub sw21_Hit()
    STHit 21
    DispatchPinEvent SWITCH_HIT_BET1
End Sub
'******************************************
Sub sw22_Hit()
    STHit 22
    DispatchPinEvent SWITCH_HIT_BET2
End Sub
'******************************************
Sub sw23_Hit()
    STHit 23
    DispatchPinEvent SWITCH_HIT_BET3
End Sub
'******************************************
Sub sw24_Hit()
    DispatchPinEvent SWITCH_HIT_CAPTIVE
End Sub
'******************************************
Sub sw25_Hit()
    STHit 25
End Sub
'******************************************
Sub sw26_Hit()
    DispatchPinEvent SWITCH_HIT_RAMP_LOCK
    DispatchPinEvent SWITCH_HIT_RIGHT_RAMP
End Sub
'******************************************
Sub sw31_Hit()
    DispatchPinEvent SWITCH_HIT_SHORTCUT
End Sub
'******************************************
Sub RPin_Hit()
	DispatchPinEvent SWITCH_HIT_RAMP_PIN
End Sub
'******************************************
Sub ScoopBackWall_Hit()
	debug.print "velz: " & activeball.velz
    debug.print "velx: " & activeball.velx
    debug.print "vely: " & activeball.vely
    activeball.vely = 1
    activeball.velx = 1
End Sub

