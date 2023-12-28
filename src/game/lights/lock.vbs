
'****************************
' NEON L
' Event Listeners:          
    RegisterPlayerStateEvent LOCK_HITS, "PS_LockHits"
'
'*****************************
Sub PS_LockHits()
    dim lockHits : lockHits = GetPlayerState(LOCK_HITS)
    Select Case lockHits
        Case 1:
            lightCtrl.LightState l72, 1
            lightCtrl.LightState l71, 2
            lightCtrl.LightState l70, 0
            lightCtrl.LightState l69, 0
            lightCtrl.LightState l97, 0
        Case 2:
            lightCtrl.LightState l72, 1
            lightCtrl.LightState l71, 1
            lightCtrl.LightState l70, 2
            lightCtrl.LightState l69, 0
            lightCtrl.LightState l97, 0
        Case 3:
            lightCtrl.LightState l72, 1
            lightCtrl.LightState l71, 1
            lightCtrl.LightState l70, 1
            lightCtrl.LightState l69, 2
            lightCtrl.LightState l97, 0
        Case 4:
            lightCtrl.LightState l72, 1
            lightCtrl.LightState l71, 1
            lightCtrl.LightState l70, 1
            lightCtrl.LightState l69, 1
            lightCtrl.LightState l97, 2
    End Select
End Sub