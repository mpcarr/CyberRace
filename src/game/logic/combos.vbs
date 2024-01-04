'****************************
' Combos
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_SPINNER1, "ComboShotSpinner1"
'
'*****************************
Sub ComboShotSpinner1
    If GetPlayerState(COMBO_COUNT) = 0 Then
        SetPlayerState COMBO_COUNT, 1
        SetPlayerState COMBO_SHOT_LEFT_ORBIT, 1
        SetPlayerState COMBO_SHOT_LEFT_RAMP, 1
        SetPlayerState COMBO_SHOT_RIGHT_RAMP, 1
        SetPlayerState COMBO_SHOT_RIGHT_ORBIT, 1
    ElseIf GetPlayerState(COMBO_SHOT_SPINNER) = 1 Then
        SetPlayerState BONUS_COMBOS_MADE, GetPlayerState(BONUS_COMBOS_MADE) + 1
        SetPlayerState COMBO_SHOT_SPINNER, 0
        SetPlayerState COMBO_COUNT, GetPlayerState(COMBO_COUNT) + 1
        AddScore (POINTS_MODE_SHOT * GetPlayerState(COMBO_COUNT))
    End If
End Sub

'****************************
' Combos
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_LEFT_ORBIT, "ComboShotLeftOrbit"
'
'*****************************
Sub ComboShotLeftOrbit
    If GetPlayerState(COMBO_COUNT) = 0 Then
        SetPlayerState COMBO_COUNT, 1
        SetPlayerState COMBO_SHOT_SPINNER, 1
        SetPlayerState COMBO_SHOT_LEFT_RAMP, 1
        SetPlayerState COMBO_SHOT_RIGHT_RAMP, 1
        SetPlayerState COMBO_SHOT_RIGHT_ORBIT, 1
    ElseIf GetPlayerState(COMBO_SHOT_LEFT_ORBIT) = 1 Then
        SetPlayerState BONUS_COMBOS_MADE, GetPlayerState(BONUS_COMBOS_MADE) + 1
        SetPlayerState COMBO_SHOT_LEFT_ORBIT, 0
        SetPlayerState COMBO_COUNT, GetPlayerState(COMBO_COUNT) + 1
        AddScore (POINTS_MODE_SHOT * GetPlayerState(COMBO_COUNT))
    End If
End Sub

'****************************
' Combos
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "ComboShotLeftRamp"
'
'*****************************
Sub ComboShotLeftRamp
    If GetPlayerState(COMBO_COUNT) = 0 Then
        SetPlayerState COMBO_COUNT, 1
        SetPlayerState COMBO_SHOT_SPINNER, 1
        SetPlayerState COMBO_SHOT_LEFT_ORBIT, 1
        SetPlayerState COMBO_SHOT_RIGHT_RAMP, 1
        SetPlayerState COMBO_SHOT_RIGHT_ORBIT, 1
    ElseIf GetPlayerState(COMBO_SHOT_LEFT_RAMP) = 1 Then
        SetPlayerState BONUS_COMBOS_MADE, GetPlayerState(BONUS_COMBOS_MADE) + 1
        SetPlayerState COMBO_SHOT_LEFT_RAMP, 0
        SetPlayerState COMBO_COUNT, GetPlayerState(COMBO_COUNT) + 1
        AddScore (POINTS_MODE_SHOT * GetPlayerState(COMBO_COUNT))
    End If
End Sub

'****************************
' Combos
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "ComboShotRightRamp"
'
'*****************************
Sub ComboShotRightRamp
    If GetPlayerState(COMBO_COUNT) = 0 Then
        SetPlayerState COMBO_COUNT, 1
        SetPlayerState COMBO_SHOT_SPINNER, 1
        SetPlayerState COMBO_SHOT_LEFT_ORBIT, 1
        SetPlayerState COMBO_SHOT_LEFT_RAMP, 1
        SetPlayerState COMBO_SHOT_RIGHT_ORBIT, 1
    ElseIf GetPlayerState(COMBO_SHOT_RIGHT_RAMP) = 1 Then
        SetPlayerState BONUS_COMBOS_MADE, GetPlayerState(BONUS_COMBOS_MADE) + 1
        SetPlayerState COMBO_SHOT_RIGHT_RAMP, 0
        SetPlayerState COMBO_COUNT, GetPlayerState(COMBO_COUNT) + 1
        AddScore (POINTS_MODE_SHOT * GetPlayerState(COMBO_COUNT))
    End If
End Sub

'****************************
' Combos
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_RIGHT_ORBIT, "ComboShotRightOrbit"
'
'*****************************
Sub ComboShotRightOrbit
    If GetPlayerState(COMBO_COUNT) = 0 Then
        SetPlayerState COMBO_COUNT, 1
        SetPlayerState COMBO_SHOT_SPINNER, 1
        SetPlayerState COMBO_SHOT_LEFT_ORBIT, 1
        SetPlayerState COMBO_SHOT_LEFT_RAMP, 1
        SetPlayerState COMBO_SHOT_RIGHT_RAMP, 1
    ElseIf GetPlayerState(COMBO_SHOT_RIGHT_ORBIT) = 1 Then
        SetPlayerState BONUS_COMBOS_MADE, GetPlayerState(BONUS_COMBOS_MADE) + 1
        SetPlayerState COMBO_SHOT_RIGHT_ORBIT, 0
        SetPlayerState COMBO_COUNT, GetPlayerState(COMBO_COUNT) + 1
        AddScore (POINTS_MODE_SHOT * GetPlayerState(COMBO_COUNT))
    End If
End Sub

'****************************
' Combos
' Event Listeners:      
    RegisterPlayerStateEvent COMBO_COUNT, "CheckComboCount"
'
'*****************************
Sub CheckComboCount
    
    If GetPlayerState(COMBO_COUNT) = 5 Then
        SetPlayerState COMBO_COUNT, 0
        SetPlayerState COMBO_SHOT_SPINNER, 0
        SetPlayerState COMBO_SHOT_LEFT_ORBIT, 0
        SetPlayerState COMBO_SHOT_LEFT_RAMP, 0
        SetPlayerState COMBO_SHOT_RIGHT_RAMP, 0
        SetPlayerState COMBO_SHOT_RIGHT_OrBIT, 0
        ComboTimer.Enabled = 0
        SetPlayerState GRANDSLAM_COMBO, True
        PlayGrandSlamSeq()
    ElseIf GetPlayerState(COMBO_COUNT) > 0 Then
        If GetPlayerState(COMBO_COUNT) > 1 Then
            FlexSceneCombo(GetPlayerState(COMBO_COUNT))
        End If
        ComboTimer.Enabled = 0
        ComboTimer.Enabled = 1
    End If
End Sub

Sub ComboTimer_Timer()
    SetPlayerState COMBO_COUNT, 0
    SetPlayerState COMBO_SHOT_SPINNER, 0
    SetPlayerState COMBO_SHOT_LEFT_ORBIT, 0
    SetPlayerState COMBO_SHOT_LEFT_RAMP, 0
    SetPlayerState COMBO_SHOT_RIGHT_RAMP, 0
    SetPlayerState COMBO_SHOT_RIGHT_OrBIT, 0
    ComboTimer.Enabled = False
End Sub