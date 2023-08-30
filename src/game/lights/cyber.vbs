
'****************************
' CYBER_C
' Event Listeners:          
    RegisterPlayerStateEvent CYBER_C, "PS_CyberC"
'
'*****************************
Sub PS_CyberC
    lightCtrl.LightState l29, GetPlayerState(CYBER_C)
End Sub

'****************************
' CYBER_Y
' Event Listeners:          
RegisterPlayerStateEvent CYBER_Y, "PS_CyberY"
'
'*****************************
Sub PS_CyberY
    lightCtrl.LightState l30, GetPlayerState(CYBER_Y)
End Sub

'****************************
' CYBER_B
' Event Listeners:          
RegisterPlayerStateEvent CYBER_B, "PS_CyberB"
'
'*****************************
Sub PS_CyberB
    lightCtrl.LightState l31, GetPlayerState(CYBER_B)
End Sub

'****************************
' CYBER_E
' Event Listeners:          
RegisterPlayerStateEvent CYBER_E, "PS_CyberE"
'
'*****************************
Sub PS_CyberE
    lightCtrl.LightState l32, GetPlayerState(CYBER_E)
End Sub

'****************************
' CYBER_R
' Event Listeners:          
RegisterPlayerStateEvent CYBER_R, "PS_CyberR"
'
'*****************************
Sub PS_CyberR
    lightCtrl.LightState l33, GetPlayerState(CYBER_R)
End Sub