'****************************
' GI State
' Event Listeners:  
    RegisterPlayerStateEvent GI_STATE, "GIState"
    RegisterPlayerStateEvent GI_COLOR, "GIState"
    RegisterPlayerStateEvent MODE_RACE, "GIState"
    RegisterPlayerStateEvent MODE_MULTIBALL, "GIState"
    RegisterPlayerStateEvent MODE_TT_MULTIBALL, "GIState"
    RegisterPlayerStateEvent MODE_BET, "GIState"
'
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
    If GetPlayerState(GRANDSLAM_WIZARD_READY) = True Then
        state = 0
    End If
    
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