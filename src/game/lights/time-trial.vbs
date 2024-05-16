
'****************************
' PS_TTOrbit
' Event Listeners:  
    AddPlayerStateEventListener TT_ORBIT, TT_ORBIT &   "PS_TTOrbit",   "PS_TTOrbit",  1000, Null
'*****************************
Sub PS_TTOrbit()
    lightCtrl.LightState l95, GetPlayerState(TT_ORBIT)
End Sub

'****************************
' PS_TTTarget
' Event Listeners:  
    AddPlayerStateEventListener TT_TARGET, TT_TARGET &   "PS_TTTarget",   "PS_TTTarget",  1000, Null
'*****************************
Sub PS_TTTarget()
    lightCtrl.LightState l91, GetPlayerState(TT_TARGET)
End Sub

'****************************
' PS_TTRamp
' Event Listeners:  
    AddPlayerStateEventListener TT_RAMP, TT_RAMP &   "PS_TTRamp",   "PS_TTRamp",  1000, Null
'*****************************
Sub PS_TTRamp()
    lightCtrl.LightState l90, GetPlayerState(TT_RAMP)
End Sub

'****************************
' PS_TTCaptive
' Event Listeners:  
    AddPlayerStateEventListener TT_CAPTIVE, TT_CAPTIVE &   "PS_TTCaptive",   "PS_TTCaptive",  1000, Null
'*****************************
Sub PS_TTCaptive()
    lightCtrl.LightState l92, GetPlayerState(TT_CAPTIVE)
End Sub

'****************************
' PS_TTShortcut
' Event Listeners:  
    AddPlayerStateEventListener TT_SHORTCUT, TT_SHORTCUT &   "TTShortcut",   "TTShortcut",  1000, Null
'*****************************
Sub TTShortcut()
    lightCtrl.LightState l93, GetPlayerState(TT_SHORTCUT)
End Sub


