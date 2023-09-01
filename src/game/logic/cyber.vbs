
'****************************
' Cyber C 
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_SPINNER1, "SwitchCyberCHit"
'
'*****************************
Sub SwitchCyberCHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_C) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_C, 1
            FlexDMDCyberScene()
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_C) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_SPINNER1_MULTIPLIER, GetPlayerState(SHOT_SPINNER1_MULTIPLIER) + 1 
        End If
    End If
End Sub

'****************************
' Cyber Y 
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_LEFT_ORBIT, "SwitchCyberYHit"
'
'*****************************
Sub SwitchCyberYHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_Y) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_Y, 1
            FlexDMDCyberScene()
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_Y) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_LEFT_ORBIT_MULTIPLIER, GetPlayerState(SHOT_LEFT_ORBIT_MULTIPLIER) + 1
        End If
    End If
End Sub

'****************************
' Cyber B
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "SwitchCyberBHit"
'
'*****************************
Sub SwitchCyberBHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_B) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_B, 1
            FlexDMDCyberScene()
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_B) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_LEFT_RAMP_MULTIPLIER, GetPlayerState(SHOT_LEFT_RAMP_MULTIPLIER) + 1
        End If
    End If
End Sub

'****************************
' Cyber E
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "SwitchCyberEHit"
'
'*****************************
Sub SwitchCyberEHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_E) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_E, 1
            FlexDMDCyberScene()
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_E) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_RIGHT_RAMP_MULTIPLIER, GetPlayerState(SHOT_RIGHT_RAMP_MULTIPLIER) + 1
        End If
    End If
End Sub

'****************************
' Cyber E
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_RIGHT_ORBIT, "SwitchCyberRHit"
'
'*****************************
Sub SwitchCyberRHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_R) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_R, 1
            FlexDMDCyberScene()
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_R) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_RIGHT_ORBIT_MULTIPLIER, GetPlayerState(SHOT_RIGHT_ORBIT_MULTIPLIER) + 1
        End If
    End If
End Sub

Sub CheckCyberModeActive()
    If GetPlayerState(CYBER_C) = 1 AND GetPlayerState(CYBER_Y) = 1 AND GetPlayerState(CYBER_B) = 1 AND GetPlayerState(CYBER_E) = 1 AND GetPlayerState(CYBER_R) = 1 Then
        SetPlayerState MODE_CYBER, True
    End If
End Sub

'****************************
' Cyber Mode Change
' Event Listeners:              
    RegisterPlayerStateEvent MODE_CYBER, "CyberModeChange"
'
'*****************************
Sub CyberModeChange()
    If GetPlayerState(MODE_CYBER) = True Then
        SetPlayerState CYBER_C, 2
        SetPlayerState CYBER_Y, 2
        SetPlayerState CYBER_B, 2
        SetPlayerState CYBER_E, 2
        SetPlayerState CYBER_R, 2
    Else
        SetPlayerState CYBER_C, 0
        SetPlayerState CYBER_Y, 0
        SetPlayerState CYBER_B, 0
        SetPlayerState CYBER_E, 0
        SetPlayerState CYBER_R, 0
    End If
End Sub