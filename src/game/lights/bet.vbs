
'****************************
' Bet 1
' Event Listeners:          
    AddPlayerStateEventListener BET_1, BET_1 &   "PS_Bet1",   "PS_Bet1",  1000, Null
'*****************************
Sub PS_Bet1()
    lightCtrl.LightState l17, GetPlayerState(BET_1)
End Sub

'****************************
' Bet 2
' Event Listeners:          
    AddPlayerStateEventListener BET_2, BET_2 &   "PS_Bet2",   "PS_Bet2",  1000, Null
'*****************************
Sub PS_Bet2()
    lightCtrl.LightState l18, GetPlayerState(BET_2)
End Sub

'****************************
' Bet 3
' Event Listeners:          
    AddPlayerStateEventListener BET_3, BET_3 &   "PS_Bet3",   "PS_Bet3",  1000, Null
'*****************************
Sub PS_Bet3()
    lightCtrl.LightState l19, GetPlayerState(BET_3)
End Sub