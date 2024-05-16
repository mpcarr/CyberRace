'****************************
' Lane Lights R
' Event Listeners:  
    AddPlayerStateEventListener LANE_R, LANE_R &   "LaneLightsR",   "LaneLightsR",  1000, Null
'*****************************
Sub LaneLightsR()
    lightCtrl.LightState l42, GetPlayerState(LANE_R)
End Sub
'****************************
' Lane Lights A
' Event Listeners:  
    AddPlayerStateEventListener LANE_A, LANE_A &   "LaneLightsA",   "LaneLightsA",  1000, Null
'*****************************
Sub LaneLightsA()
    lightCtrl.LightState l43, GetPlayerState(LANE_A)
End Sub
'****************************
' Lane Lights C
' Event Listeners:  
    AddPlayerStateEventListener LANE_C, LANE_C &   "LaneLightsC",   "LaneLightsC",  1000, Null
'*****************************
Sub LaneLightsC()
    lightCtrl.LightState l44, GetPlayerState(LANE_C)
End Sub
'****************************
' Lane Lights E
' Event Listeners:  
    AddPlayerStateEventListener LANE_E, LANE_E &   "LaneLightsE",   "LaneLightsE",  1000, Null
'*****************************
Sub LaneLightsE()
    lightCtrl.LightState l45, GetPlayerState(LANE_E)
End Sub
'****************************
' Lane Lights BO
' Event Listeners:  
    AddPlayerStateEventListener LANE_BO, LANE_BO &   "LaneLightsBO",   "LaneLightsBO",  1000, Null
'*****************************
Sub LaneLightsBO()
    lightCtrl.LightState l66, GetPlayerState(LANE_BO)
End Sub
'****************************
' Lane Lights N
' Event Listeners:  
    AddPlayerStateEventListener LANE_N, LANE_N &   "LaneLightsN",   "LaneLightsN",  1000, Null
'*****************************
Sub LaneLightsN()
    lightCtrl.LightState l67, GetPlayerState(LANE_N)
End Sub
'****************************
' Lane Lights US
' Event Listeners:  
    AddPlayerStateEventListener LANE_US, LANE_US &   "LaneLightsUS",   "LaneLightsUS",  1000, Null
'*****************************
Sub LaneLightsUS()
    lightCtrl.LightState l68, GetPlayerState(LANE_US)
End Sub