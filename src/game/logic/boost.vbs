
'****************************
' Boost 1
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_BOOST1, "SwitchBOOST1Hit"
'
'*****************************
Sub SwitchBOOST1Hit()
    If GetPlayerState(BOOST_1) = 2 Then
        Debounce "startMotor", "TimerStartTurnTable", 600
        PlaySoundAtLevelStatic "fx_boost", SoundFxLevel, sw18
        If GetPlayerState(MODE_BOOST) = True Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState JACKPOT_VALUE, GetPlayerState(JACKPOT_VALUE) + 100000
            SetPlayerState BOOST_SHOT, GetPlayerState(BOOST_SHOT) + 1
            FlexDMDBoostModeScene()
        Else
            AddScore POINT_BASE
            SetPlayerState BOOST_1, 1
            SetPlayerState BOOST_HITS, GetPlayerState(BOOST_HITS) + 1
            FlexDMDBoostScene()
        End If
    End If
End Sub


'****************************
' Boost 2
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_BOOST2, "SwitchBOOST2Hit"
'
'*****************************
Sub SwitchBOOST2Hit
    If GetPlayerState(BOOST_2) = 2 Then
        Debounce "startMotor", "TimerStartTurnTable", 600
        PlaySoundAtLevelStatic "fx_boost", SoundFxLevel, sw19
        If GetPlayerState(MODE_BOOST) = True Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState JACKPOT_VALUE, GetPlayerState(JACKPOT_VALUE) + 100000
            SetPlayerState BOOST_SHOT, GetPlayerState(BOOST_SHOT) + 1
            FlexDMDBoostModeScene()
        Else
            AddScore POINT_BASE
            SetPlayerState BOOST_2, 1
            SetPlayerState BOOST_HITS, GetPlayerState(BOOST_HITS) + 1
            FlexDMDBoostScene()
        End If
    End If
End Sub

'****************************
' Boost 3
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_BOOST3, "SwitchBOOST3Hit"
'
'*****************************
Sub SwitchBOOST3Hit
    If GetPlayerState(BOOST_3) = 2 Then
        Debounce "startMotor", "TimerStartTurnTable", 600
        PlaySoundAtLevelStatic "fx_boost", SoundFxLevel, sw20
        If GetPlayerState(MODE_BOOST) = True Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState JACKPOT_VALUE, GetPlayerState(JACKPOT_VALUE) + 100000
            SetPlayerState BOOST_SHOT, GetPlayerState(BOOST_SHOT) + 1
            FlexDMDBoostModeScene()
        Else
            AddScore POINT_BASE
            SetPlayerState BOOST_3, 1
            SetPlayerState BOOST_HITS, GetPlayerState(BOOST_HITS) + 1
            FlexDMDBoostScene()
        End If
    End If
End Sub


'****************************
' Check Boost Mode Complete 
' Event Listeners:              
    RegisterPlayerStateEvent BOOST_HITS, "CheckBoostHits"
'
'*****************************
Sub CheckBoostHits
    If GetPlayerState(BOOST_1) = 1 AND GetPlayerState(BOOST_2) = 1 AND GetPlayerState(BOOST_3) = 1 Then
        SetPlayerState BOOST_1, 2
        SetPlayerState BOOST_2, 2
        SetPlayerState BOOST_3, 2
    End If
End Sub

'****************************
' Check Boost Mode Complete 
' Event Listeners:              
    RegisterPlayerStateEvent BOOST_SHOT, "CheckBoostModeComplete"
'
'*****************************
Sub CheckBoostModeComplete
        If GetPlayerState(MODE_BOOST) = True Then
            If GetPlayerState(BOOST_SHOT) = 5 Then
                'TODO: Light Show
                AddScore POINTS_MODE_SHOT
                SetPlayerState MODE_BOOST, False
                SetPlayerState BOOST_SHOT, 0
                SetPlayerState BOOST_1, 2
                SetPlayerState BOOST_2, 2
                SetPlayerState BOOST_3, 2
                BoostTimer.Enabled = False
            Else
                SetPlayerState BOOST_1, 0
                SetPlayerState BOOST_2, 0
                SetPlayerState BOOST_3, 0
                BoostTimer.Enabled = False
                BoostTimer.Enabled = True
            End If
        End If
End Sub

'****************************
' Check Boost Mode Start 
' Event Listeners:              
    RegisterPlayerStateEvent BOOST_HITS, "CheckBoostModeStart"
'
'*****************************
Sub CheckBoostModeStart
        If GetPlayerState(MODE_BOOST) = False AND GetPlayerState(BOOST_HITS) = (3 * GetPlayerState(BOOST_ACTIVATIONS)) Then

            SetPlayerState BOOST_SHOT, 0
            SetPlayerState MODE_BOOST, True
            calloutsQ.Add "boostmodeactivated", "PlayCallout(""boost-mode-activated"")", 1, 0, 0, 4284, 0, False
            SetPlayerState BOOST_HITS, 0
            SetPlayerState BOOST_1, 2
            SetPlayerState BOOST_2, 0
            SetPlayerState BOOST_3, 0
            SetPlayerState BOOST_ACTIVATIONS, GetPlayerState(BOOST_ACTIVATIONS) + 1
            BoostTimer.Enabled = True    
        End If
End Sub


Sub BoostTimer_Timer()
    If GetPlayerState(MODE_BOOST) = True Then
        If GetPlayerState(BOOST_1) = 2 Then
            SetPlayerState BOOST_1, 0
            SetPlayerState BOOST_2, 2
            SetPlayerState BOOST_3, 0
        ElseIf GetPlayerState(BOOST_2) = 2 Then
            SetPlayerState BOOST_1, 0
            SetPlayerState BOOST_2, 0
            SetPlayerState BOOST_3, 2
        ElseIf GetPlayerState(BOOST_3) = 2 Then
            SetPlayerState BOOST_1, 2
            SetPlayerState BOOST_2, 0
            SetPlayerState BOOST_3, 0
        Else
            SetPlayerState BOOST_1, 2
            SetPlayerState BOOST_2, 0
            SetPlayerState BOOST_3, 0
        End If
    End If
End Sub