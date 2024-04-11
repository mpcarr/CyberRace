
'****************************
' Rotate Lane Lights Clockwise
' Event Listeners:  
    RegisterPinEvent SWITCH_RIGHT_FLIPPER_DOWN, "RotateLaneLightsClockwise"
'
'*****************************
Sub RotateLaneLightsClockwise()
    Dim temp : temp = GetPlayerState(LANE_R)
    SetPlayerState LANE_R, GetPlayerState(LANE_E)
    SetPlayerState LANE_E, GetPlayerState(LANE_C)
    SetPlayerState LANE_C, GetPlayerState(LANE_A)
    SetPlayerState LANE_A, temp

    temp = GetPlayerState(LANE_BO)
    SetPlayerState LANE_BO, GetPlayerState(LANE_US)
    SetPlayerState LANE_US, GetPlayerState(LANE_N)
    SetPlayerState LANE_N, temp

End Sub

'****************************
' Rotate Lane Lights Anti Clockwise
' Event Listeners:      
    RegisterPinEvent SWITCH_LEFT_FLIPPER_DOWN, "RotateLaneLightsAntiClockwise"
'
'*****************************
Sub RotateLaneLightsAntiClockwise()
    Dim temp : temp = GetPlayerState(LANE_R)
    SetPlayerState LANE_R, GetPlayerState(LANE_A)
    SetPlayerState LANE_A, GetPlayerState(LANE_C)
    SetPlayerState LANE_C, GetPlayerState(LANE_E)
    SetPlayerState LANE_E, temp

    temp = GetPlayerState(LANE_BO)
    SetPlayerState LANE_BO, GetPlayerState(LANE_N)
    SetPlayerState LANE_N, GetPlayerState(LANE_US)
    SetPlayerState LANE_US, temp
End Sub

Sub HitBonusLanes(lane)
    AddScore POINTS_BASE
    If GetPlayerState(lane) = 0 Then
        SetPlayerState lane, 1
        PlaySound("fx_rollover")
    Else
        If GetPlayerState(MODE_SKILLSHOT_ACTIVE) = True Then
            AwardSkillshot()
        End If
    End If
    If GetPlayerState(LANE_BO) = 1 AND GetPlayerState(LANE_N) = 1 AND GetPlayerState(LANE_US) = 1 Then
        AddScore POINTS_BONUS_X
        If GetPlayerState(BONUS_X) < 4 Then
            SetPlayerState BONUS_X, GetPlayerState(BONUS_X) + 1
        End If
        lightCtrl.Pulse l66, 0
        lightCtrl.Pulse l67, 0
        lightCtrl.Pulse l68, 0
        LightSeqGI.Play SeqFanLeftUpOn,10,2
        lightCtrl.SyncWithVpxLights lightSeqGI
        lightCtrl.SetVpxSyncLightColor RGB(98,251,255)
        SetPlayerState LANE_BO, 0
        SetPlayerState LANE_N, 0
        SetPlayerState LANE_US, 0
    End If
    
End Sub

Sub HitInLanes(lane)
    AddScore POINTS_BASE
    If GetPlayerState(GRANDSLAM_RACES) = False And GetPlayerState(MODE_MULTIBALL) = False And GetPlayerState(MODE_TT_MULTIBALL) = False Then
        If GetPlayerState(lane) = 0 And GetPlayerState(RACE_MODE_READY) = False And GetPlayerState(MODE_RACE) = False Then
            SetPlayerState lane, 1
            PlaySound("fx_rollover")
        End If
        If GetPlayerState(RACE_MODE_READY) = False And GetPlayerState(MODE_RACE) = False Then
            If GetPlayerState(LANE_R) = 1 AND GetPlayerState(LANE_A) = 1 AND GetPlayerState(LANE_C) = 1 AND GetPlayerState(LANE_E) = 1 Then
                SetPlayerState RACE_MODE_READY, True
                lSeqRGBCircle.Color = GAME_RACE_COLOR
                lightCtrl.AddTableLightSeq "RaceReady", lSeqRGBCircle
                calloutsQ.Add "raceready", "PlayCallout(""raceready"")", 1, 0, 0, 2500, 0, False
                'FlexDMDRaceReadyScene()
                'FlashSeq1()
            End If
        End If
    End If
End Sub