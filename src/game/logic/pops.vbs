'****************************
' Hit Pop Bumpers
'*****************************
Dim DOFBumperPulse : DOFBumperPulse = False
Sub HitPopBumpers(bumper)
    AddScore POINTS_BASE
    If DOFBumperPulse = False Then
        DOF 203, DOFPulse
        DOFBumperPulse = True
    Else
        DOF 205, DOFPulse
        DOFBumperPulse = False
    End If
    If GetPlayerState(MODE_EMP) = True Then
        lightCtrl.Pulse bumper, 0
        Exit Sub
    End If

    If (GetPlayerState(EMP_CHARGE) + 1) = (EMP_BASE_HITS * GetPlayerState(EMP_ACTIVATIONS)) Then
        'Start EMP MODE
        GrabMag.MagnetOn = 1
        DOF 128, DOFPulse
		GrabMagnetTimer.Enabled = true
        lightCtrl.pulse l140, 2
        lightCtrl.pulse l141, 0
        lightCtrl.pulse l142, 1
        lightCtrl.pulse l143, 2
        lightCtrl.AddLightSeq "BoostUp", lSeqEmp
        SetPlayerState EMP_ACTIVATIONS, GetPlayerState(EMP_ACTIVATIONS) + 1
        PlaySoundAtLevelStatic "emp-drain", SoundFxLevel, bumper
        calloutsQ.Add "grid-unstable", "PlayCallout(""grid-unstable"")", 1, 0, 0, 3100, 0, False
        SetPlayerState EMP_SHOT, 1
        SetPlayerState EMP_CHARGE, 0
        lightCtrl.AddShot "EMP1", l23, RGB(255,255,255)
        SetPlayerState MODE_EMP, True
        GameTimers(GAME_EMP_TIMER_IDX) = 20
    Else
        lightCtrl.Pulse bumper, 0
        SetPlayerState EMP_CHARGE, GetPlayerState(EMP_CHARGE) + 1
        FlexDMDEMPScene()
    End If
End Sub

Sub GrabMagnetTimer_Timer()
	GrabMagnetTimer.Enabled = false
	GrabMag.MagnetOn = 0
    lightCtrl.AddLightSeq "GI", lSeqGIEmpOn
End Sub

'****************************
' GameEmpTimerEnded
' Event Listeners:      
    RegisterPinEvent GAME_EMP_TIMER_ENDED, "GameEmpTimerEnded"
'
'*****************************

Sub GameEmpTimerEnded()
	SetPlayerState EMP_SHOT, 0
    SetPlayerState MODE_EMP, False
    lightCtrl.RemoveLightSeq "GI", lSeqGIEMPon
    lightCtrl.RemoveShot "EMP1", l23
End Sub

'****************************
' EMP MODE Shot 1
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_SPINNER2,       "EMPModeShot1"
'
'*****************************
Sub EMPModeShot1()
    If GetPlayerState(MODE_EMP) = True AND GetPlayerState(EMP_SHOT) = 1 Then
        'MsgBox("Here")
        calloutsQ.Add "emp-energised", "PlayCallout(""emp-energised"")", 1, 0, 0, 2560, 0, False
        lightCtrl.RemoveShot "EMP1", l23
        For Each light in RGBControlLights
            lightCtrl.Pulse light, 3
        Next
        AddScore POINTS_EMP_MODE * 5
        SetPlayerState EMP_SHOT, 0
        SetPlayerState MODE_EMP, False
        lightCtrl.RemoveLightSeq "GI", lSeqGIEmpOn
    End If
End Sub