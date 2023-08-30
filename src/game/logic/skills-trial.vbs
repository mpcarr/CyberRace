
'****************************
' Skills Trial
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_SPINNER1, "SkillsTrial"
'
'*****************************
Sub SkillsTrial()
    AddScore POINT_BASE
    If GetPlayerState(MODE_SKILLS_TRIAL) = False Then
        SetPlayerState SKILLS_TRIAL_SPINS, GetPlayerState(SKILLS_TRIAL_SPINS) + 1
        If GetPlayerState(SKILLS_TRIAL_SPINS) > (SKILLS_BASE_SPINS * GetPlayerState(SKILLS_TRIAL_ACTIVATIONS)) Then
            'Start Skills Trial
            SetPlayerState SKILLS_TRIAL_READY, True
        End If
    End If
End Sub

'****************************
' Skills Trial Ready
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_LANE_A, "CheckSkillsTrialReady"
'
'*****************************
Sub CheckSkillsTrialReady()
    If GetPlayerState(SKILLS_TRIAL_READY) = True AND (ballsInPlay-BallsOnBridge())=1 Then
        SetPlayerState MODE_SKILLS_TRIAL, True
        SetPlayerState SKILLS_TRIAL_ACTIVATIONS, GetPlayerState(SKILLS_TRIAL_ACTIVATION) + 1
        SetPlayerState SKILLS_TRIAL_READY, False
        SetPlayerState SKILLS_TRIAL_SHOT, 1
        'TODO: Light Show.
        FlexDMDSkillsScene()
        lightCtrl.AddShot "Skills1", l64, GAME_SKILLS_COLOR
        calloutsQ.Add "skills-trial", "PlayCallout(""skills-trial"")", 1, 0, 0, 3000, 0, False
        calloutsQ.Add "heartbeat", "PlaySoundAtLevelStatic ""heartbeat"", SoundFxLevel, sw02", 1, 0, 0, 3900, 0, False        
        lSeqHeartBeat.Repeat = True
        lSeqHeartBeat.UpdateInterval = 40
        lSeqSkills1.UpdateInterval = 10
        lSeqSkills2.UpdateInterval = 10
        lSeqSkills3.UpdateInterval = 10
        lightCtrl.AddTableLightSeq "All", lSeqSkills1
        lightCtrl.AddTableLightSeq "All", lSeqSkills2
        lightCtrl.AddTableLightSeq "All", lSeqSkills3
        lightCtrl.AddTableLightSeq "All", lSeqHeartBeat
        GameTimers(GAME_SKILLS_TIMER_IDX) = 22
        LockPin4.TimerEnabled = True
    End If
End Sub

'****************************
' Skills Trial Shot 1
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "SkillsTrialShot1"
'
'*****************************
Sub SkillsTrialShot1()
    If GetPlayerState(MODE_SKILLS_TRIAL) = True AND GetPlayerState(SKILLS_TRIAL_SHOT) = 1 Then
        AddScore POINTS_MODE_SHOT
        SetPlayerState SKILLS_TRIAL_SHOT, 2
        GameTimers(GAME_SKILLS_TIMER_IDX) = 15
        'TODO: Light Show.
        lightCtrl.RemoveShot "Skills1", l64
        lightCtrl.AddShot "Skills2", l46, GAME_SKILLS_COLOR
    End If
End Sub

'****************************
' Skills Trial Shot 2
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_LEFT_ORBIT, "SkillsTrialShot2"
'
'*****************************
Sub SkillsTrialShot2()
    If GetPlayerState(MODE_SKILLS_TRIAL) = True AND GetPlayerState(SKILLS_TRIAL_SHOT) = 2 Then
        AddScore POINTS_MODE_SHOT
        SetPlayerState SKILLS_TRIAL_SHOT, 3
        GameTimers(GAME_SKILLS_TIMER_IDX) = 15
        'TODO: Light Show.
        lightCtrl.RemoveShot "Skills2", l46
        lightCtrl.AddShot "Skills3", l47, GAME_SKILLS_COLOR
    End If
End Sub

'****************************
' Skills Trial Shot 3
' Event Listeners:      
RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "SkillsTrialShot3"
'
'*****************************
Sub SkillsTrialShot3
    If GetPlayerState(MODE_SKILLS_TRIAL) = True AND GetPlayerState(SKILLS_TRIAL_SHOT) = 3 Then
        AddScore POINTS_MODE_SHOT
        SetPlayerState SKILLS_TRIAL_SHOT, 0
        GameTimers(GAME_SKILLS_TIMER_IDX) = 0
        SetPlayerState MODE_SKILLS_TRIAL, False
        'TODO: Light Show.
        lightCtrl.RemoveShot "Skills3", l47
    End If
End Sub

'****************************
' Skills Trial Lock Pin
' Event Listeners:      
    RegisterPlayerStateEvent MODE_SKILLS_TRIAL, "SkillsTrialLockPin"
'
'*****************************
Sub SkillsTrialLockPin
    If GetPlayerState(MODE_SKILLS_TRIAL) = True Then
        LockPin4.IsDropped = False
    Else
        LockPin4.IsDropped = True
    End If
End Sub

Sub LockPin4_Timer()
    LockPin4.TimerEnabled = False
    LockPin4.IsDropped = True
    lightCtrl.RemoveTableLightSeq "All", lSeqHeartBeat
End Sub

'****************************
' GameSkillsTimerEnded
' Event Listeners:      
    RegisterPinEvent GAME_SKILLS_TIMER_ENDED, "GameSkillsTimerEnded"
'
'*****************************

Sub GameSkillsTimerEnded()
	SetPlayerState SKILLS_TRIAL_SHOT, 0
    GameTimers(GAME_SKILLS_TIMER_IDX) = 0
    SetPlayerState MODE_SKILLS_TRIAL, False
    lightCtrl.RemoveShot "Skills1", l47
    lightCtrl.RemoveShot "Skills2", l47
    lightCtrl.RemoveShot "Skills3", l47
End Sub