
'****************************
' PS_TTOrbit
' Event Listeners:  
    RegisterPlayerStateEvent TT_ORBIT, "PS_TTOrbit"
'
'*****************************
Sub PS_TTOrbit()
    lightCtrl.LightState l95, GetPlayerState(TT_ORBIT)
End Sub

'****************************
' PS_TTTarget
' Event Listeners:  
RegisterPlayerStateEvent TT_TARGET, "PS_TTTarget"
'
'*****************************
Sub PS_TTTarget()
    lightCtrl.LightState l91, GetPlayerState(TT_TARGET)
End Sub

'****************************
' PS_TTRamp
' Event Listeners:  
RegisterPlayerStateEvent TT_RAMP, "PS_TTRamp"
'
'*****************************
Sub PS_TTRamp()
    lightCtrl.LightState l90, GetPlayerState(TT_RAMP)
End Sub

'****************************
' PS_TTCaptive
' Event Listeners:  
RegisterPlayerStateEvent TT_CAPTIVE, "PS_TTCaptive"
'
'*****************************
Sub PS_TTCaptive()
    lightCtrl.LightState l92, GetPlayerState(TT_CAPTIVE)
End Sub

'****************************
' PS_TTShortcut
' Event Listeners:  
RegisterPlayerStateEvent TT_SHORTCUT, "TTShortcut"
'
'*****************************
Sub TTShortcut()
    lightCtrl.LightState l93, GetPlayerState(TT_SHORTCUT)
End Sub


