
'****************************
' Boost 1
' Event Listeners:          
    RegisterPlayerStateEvent BOOST_1, "PS_Boost1"
'
'*****************************
Sub PS_Boost1
    lightCtrl.LightState l59, GetPlayerState(BOOST_1)
    If GetPlayerState(MODE_BOOST) = True AND GetPlayerState(BOOST_1) = 2 Then
        lightCtrl.Blink l109
        lightCtrl.LightColor l109, RGB(124,255,1)
    Else
        lightCtrl.LightOff l109
        lightCtrl.LightOnWithColor l109, RGB(255,255,255)
    End If
End Sub

'****************************
' Boost 2
' Event Listeners:          
RegisterPlayerStateEvent BOOST_2, "PS_Boost2"
'
'*****************************
Sub PS_Boost2
    lightCtrl.LightState l60, GetPlayerState(BOOST_2)
    If GetPlayerState(MODE_BOOST) = True AND GetPlayerState(BOOST_2) = 2 Then
        lightCtrl.Blink l128
        lightCtrl.LightColor l128, RGB(124,255,1)
    Else
        lightCtrl.LightOff l128
        lightCtrl.LightOnWithColor l128, RGB(255,255,255)
    End If
End Sub

'****************************
' Boost 3
' Event Listeners:          
    RegisterPlayerStateEvent BOOST_3, "PS_Boost3"
'
'*****************************
Sub PS_Boost3
    lightCtrl.LightState l61, GetPlayerState(BOOST_3)
    If GetPlayerState(MODE_BOOST) = True AND GetPlayerState(BOOST_3) = 2 Then
        lightCtrl.Blink l132
        lightCtrl.LightColor l132, RGB(124,255,1)
    Else
        lightCtrl.LightOff l132
        lightCtrl.LightOnWithColor l132, RGB(255,255,255)
    End If
End Sub
