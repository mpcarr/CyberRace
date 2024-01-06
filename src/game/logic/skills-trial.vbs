
'****************************
' Skills Trial
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_SPINNER1, "SkillsTrial"
'
'*****************************
Sub SkillsTrial()
    AddScore POINT_BASE
    If GetPlayerState(GRANDSLAM_SKILLS) = False And GetPlayerState(MODE_SKILLS_TRIAL) = False And GetPlayerState(SKILLS_TRIAL_READY) = False Then
        SetPlayerState SKILLS_TRIAL_SPINS, GetPlayerState(SKILLS_TRIAL_SPINS) + 1
        FlexDMDSkillsScene()
        If GetPlayerState(SKILLS_TRIAL_SPINS) > (SKILLS_BASE_SPINS * GetPlayerState(SKILLS_TRIAL_ACTIVATIONS)) Then
            'Start Skills Trial
            DmdQ.Dequeue "skills"
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
    If GetPlayerState(GRANDSLAM_SKILLS) = False And GetPlayerState(MODE_RACE) = False And GetPlayerState(SKILLS_TRIAL_READY) = True AND RealBallsInPlay=1 Then
        SetPlayerState MODE_SKILLS_TRIAL, True
        SetPlayerState SKILLS_TRIAL_ACTIVATIONS, GetPlayerState(SKILLS_TRIAL_ACTIVATIONS) + 1
        SetPlayerState SKILLS_TRIAL_READY, False
        SetPlayerState SKILLS_TRIAL_SHOT, 1
        SetPlayerState SKILLS_TRIAL_SPINS, 0
        SetPlayerState BONUS_SKILLS_COMPLETED, GetPlayerState(BONUS_SKILLS_COMPLETED) + 1
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
        SetPlayerState BONUS_SKILLS_COMPLETED, GetPlayerState(BONUS_SKILLS_COMPLETED) + 1
        lightCtrl.AddTableLightSeq "RGB", lSeqBetUp
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
        SetPlayerState BONUS_SKILLS_COMPLETED, GetPlayerState(BONUS_SKILLS_COMPLETED) + 1
        lightCtrl.AddTableLightSeq "RGB", lSeqBetUp
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
        SetPlayerState BONUS_SKILLS_COMPLETED, GetPlayerState(BONUS_SKILLS_COMPLETED) + 1
        SetPlayerState MODE_SKILLS_TRIAL, False
        lightCtrl.AddTableLightSeq "RGB", lSeqBetUp
        SetPlayerState GRANDSLAM_SKILLS, True
        calloutsQ.Add "skillsGS", "PlayCallout(""skills-grandslam"")", 1, 0, 0, 5500, 0, False
        PlayGrandSlamSeq()
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
    AnimateLockPin()
End Sub

Sub LockPin4_Timer()
    LockPin4.TimerEnabled = False
    LockPin4.IsDropped = True
    AnimateLockPin()
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
    lightCtrl.RemoveShot "Skills1", l64
    lightCtrl.RemoveShot "Skills2", l46
    lightCtrl.RemoveShot "Skills3", l47
End Sub