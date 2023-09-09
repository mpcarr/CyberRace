
'****************************
' Hyper Hit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_HYPER, "SwitchHyper"
'
'*****************************
Sub SwitchHyper()
    SetPlayerState HYPER, GetPlayerState(HYPER) + 1
    AddScore POINTS_BASE
    If GetPlayerState(HYPER) = 5 Then
        'TODO - Start Hyper
        SetPlayerState HYPER, 0
    End If
End Sub
