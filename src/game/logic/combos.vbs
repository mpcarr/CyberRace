'****************************
' Combos
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_SPINNER1, SWITCH_HIT_SPINNER1 &   "ComboShotSpinner1",   "ComboShotSpinner1",  1000, Null
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
    AddPinEventListener SWITCH_HIT_LEFT_ORBIT, SWITCH_HIT_LEFT_ORBIT &   "ComboShotLeftOrbit",   "ComboShotLeftOrbit",  1000, Null
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
    AddPinEventListener SWITCH_HIT_LEFT_RAMP, SWITCH_HIT_LEFT_RAMP &   "ComboShotLeftRamp",   "ComboShotLeftRamp",  1000, Null
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
    AddPinEventListener SWITCH_HIT_RIGHT_RAMP, SWITCH_HIT_RIGHT_RAMP &   "ComboShotRightRamp",   "ComboShotRightRamp",  1000, Null
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
    AddPinEventListener SWITCH_HIT_RIGHT_ORBIT, SWITCH_HIT_RIGHT_ORBIT &   "ComboShotRightOrbit",   "ComboShotRightOrbit",  1000, Null
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
    AddPlayerStateEventListener COMBO_COUNT, COMBO_COUNT &   "CheckComboCount",   "CheckComboCount",  1000, Null
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
        If GetPlayerState(GRANDSLAM_COMBO) = False Then
            SetPlayerState GRANDSLAM_COMBO, True
            calloutsQ.Add "comboGS", "PlayCallout(""combo-grandslam"")", 1, 0, 0, 5500, 0, False
            PlayGrandSlamSeq()
        End If
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