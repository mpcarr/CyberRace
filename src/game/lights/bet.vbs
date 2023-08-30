
'****************************
' Bet 1
' Event Listeners:          
    RegisterPlayerStateEvent BET_1, "PS_Bet1"
'
'*****************************
Sub PS_Bet1()
    lightCtrl.LightState l17, GetPlayerState(BET_1)
End Sub

'****************************
' Bet 2
' Event Listeners:          
    RegisterPlayerStateEvent BET_2, "PS_Bet2"
'
'*****************************
Sub PS_Bet2()
    lightCtrl.LightState l18, GetPlayerState(BET_2)
End Sub

'****************************
' Bet 3
' Event Listeners:          
    RegisterPlayerStateEvent BET_3, "PS_Bet3"
'
'*****************************
Sub PS_Bet3()
    lightCtrl.LightState l19, GetPlayerState(BET_3)
End Sub