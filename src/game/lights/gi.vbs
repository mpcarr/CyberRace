'****************************
' GI State
' Event Listeners:  
    RegisterPlayerStateEvent GI_STATE, "GIState"
    RegisterPlayerStateEvent GI_COLOR, "GIState"
    RegisterPlayerStateEvent MODE_RACE, "GIState"
    RegisterPlayerStateEvent MODE_MULTIBALL, "GIState"
    RegisterPlayerStateEvent MODE_BET, "GIState"
'
'*****************************
Sub GIState()
    Dim light, state, color, colors
    colors = 0
    color = GetPlayerState(GI_COLOR)
    If GetPlayerState(MODE_RACE) = True Then
        color = GAME_RACE_COLOR
    End If
    If GetPlayerState(MODE_MULTIBALL) = True Then
        color = GAME_MULTIBALL_COLOR
    End If
    If GetPlayerState(MODE_BET) = True Then
        color = GAME_HURRYUP_COLOR
    End If
    state = GetPlayerState(GI_STATE)
    
    For Each light in GIControlLights
        lightCtrl.LightState light, state
        lightCtrl.LightColor light, color
        lightCtrl.LightLevel light, 100
    Next
End Sub