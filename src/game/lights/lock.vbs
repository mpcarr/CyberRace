
'****************************
' NEON L
' Event Listeners:          
    RegisterPlayerStateEvent NEON_L, "PS_Neon_L"
'
'*****************************
Sub PS_Neon_L()
    lightCtrl.LightState l72, GetPlayerState(NEON_L)
End Sub
'****************************
' NEON O
' Event Listeners:          
    RegisterPlayerStateEvent NEON_O, "PS_Neon_O"
'
'*****************************
Sub PS_Neon_O()
    lightCtrl.LightState l71, GetPlayerState(NEON_O)
End Sub
'****************************
' NEON C
' Event Listeners:          
    RegisterPlayerStateEvent NEON_C, "PS_Neon_C"
'
'*****************************
Sub PS_Neon_C()
    lightCtrl.LightState l70, GetPlayerState(NEON_C)
End Sub
'****************************
' NEON K
' Event Listeners:          
    RegisterPlayerStateEvent NEON_K, "PS_Neon_K"
'
'*****************************
Sub PS_Neon_K()
    lightCtrl.LightState l69, GetPlayerState(NEON_K)
End Sub