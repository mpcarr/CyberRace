'****************************
' GI State
' Event Listeners:  
    AddPlayerStateEventListener GI_STATE, GI_STATE &   "GIState",   "GIState",  1000, Null
    AddPlayerStateEventListener GI_COLOR, GI_COLOR &   "GIState",   "GIState",  1000, Null
    AddPlayerStateEventListener MODE_RACE, MODE_RACE &   "GIState",   "GIState",  1000, Null
    AddPlayerStateEventListener MODE_MULTIBALL, MODE_MULTIBALL &   "GIState",   "GIState",  1000, Null
    AddPlayerStateEventListener MODE_TT_MULTIBALL, MODE_TT_MULTIBALL &   "GIState",   "GIState",  1000, Null
    AddPlayerStateEventListener MODE_BET, MODE_BET &   "GIState",   "GIState",  1000, Null
'*****************************
Sub GIState()
    Dim light, state, color, colors, dofEvent
    colors = 0
    color = GetPlayerState(GI_COLOR)
    dofEvent = 302
    If GetPlayerState(MODE_RACE) = True Then
        color = GAME_RACE_COLOR
        dofEvent = 303
    End If
    If GetPlayerState(MODE_MULTIBALL) = True Then
        color = GAME_MULTIBALL_COLOR
        dofEvent = 304
    End If
    If GetPlayerState(MODE_TT_MULTIBALL) = True Then
        color = GAME_TT_COLOR
        dofEvent = 305
    End If
    If GetPlayerState(MODE_BET) = True Then
        color = GAME_HURRYUP_COLOR
        dofEvent = 306
    End If
    state = GetPlayerState(GI_STATE)
    DOF dofEvent, DOFOn
    
    For Each light in GIControlLights
        lightCtrl.LightState light, state
        lightCtrl.LightColor light, color
        lightCtrl.LightLevel light, 100
    Next
End Sub

Sub GIOn
    GIState()
End Sub

Sub GIOff
    For Each light in GIControlLights
        lightCtrl.LightOff light
    Next
End Sub