'****************************
' Lane Lights R
' Event Listeners:  
    RegisterPlayerStateEvent LANE_R, "LaneLightsR"
'
'*****************************
Sub LaneLightsR()
    lightCtrl.LightState l42, GetPlayerState(LANE_R)
End Sub
'****************************
' Lane Lights A
' Event Listeners:  
    RegisterPlayerStateEvent LANE_A, "LaneLightsA"
'
'*****************************
Sub LaneLightsA()
    lightCtrl.LightState l43, GetPlayerState(LANE_A)
End Sub
'****************************
' Lane Lights C
' Event Listeners:  
    RegisterPlayerStateEvent LANE_C, "LaneLightsC"
'
'*****************************
Sub LaneLightsC()
    lightCtrl.LightState l44, GetPlayerState(LANE_C)
End Sub
'****************************
' Lane Lights E
' Event Listeners:  
    RegisterPlayerStateEvent LANE_E, "LaneLightsE"
'
'*****************************
Sub LaneLightsE()
    lightCtrl.LightState l45, GetPlayerState(LANE_E)
End Sub
'****************************
' Lane Lights BO
' Event Listeners:  
    RegisterPlayerStateEvent LANE_BO, "LaneLightsBO"
'
'*****************************
Sub LaneLightsBO()
    lightCtrl.LightState l66, GetPlayerState(LANE_BO)
End Sub
'****************************
' Lane Lights N
' Event Listeners:  
RegisterPlayerStateEvent LANE_N, "LaneLightsN"
'
'*****************************
Sub LaneLightsN()
    lightCtrl.LightState l67, GetPlayerState(LANE_N)
End Sub
'****************************
' Lane Lights US
' Event Listeners:  
RegisterPlayerStateEvent LANE_US, "LaneLightsUS"
'
'*****************************
Sub LaneLightsUS()
    lightCtrl.LightState l68, GetPlayerState(LANE_US)
End Sub