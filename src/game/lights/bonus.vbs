'****************************
' Bonus Lights
' Event Listeners:  
    RegisterPlayerStateEvent BONUS_X, "BonusLights"
'
'*****************************
Sub BonusLights()
    Select Case GetPlayerState(BONUS_X):
        Case 0:
            lightCtrl.LightOff l20
            lightCtrl.LightOff l21
            lightCtrl.LightOff l22
        Case 1:
            lightCtrl.FlickerOn l20
        Case 2:
            lightCtrl.FlickerOn l22
        Case 3:
            lightCtrl.FlickerOn l21
    End Select
End Sub
