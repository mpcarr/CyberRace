'****************************
' Combo Shot Spinner
' Event Listeners:      
    RegisterPlayerStateEvent COMBO_SHOT_SPINNER, "PS_ComboShotSpinner"
'
'*****************************
Sub PS_ComboShotSpinner()
    If GetPlayerState(COMBO_SHOT_SPINNER) = 1 Then
        lightCtrl.Blink l24
    Else
        lightCtrl.LightOff l24
    End If
End Sub

'****************************
' Combo Shot Left Orbit
' Event Listeners:      
    RegisterPlayerStateEvent COMBO_SHOT_LEFT_ORBIT, "PS_ComboShotLeftOrbit"
'
'*****************************
Sub PS_ComboShotLeftOrbit()
    If GetPlayerState(COMBO_SHOT_LEFT_ORBIT) = 1 Then
        lightCtrl.Blink l25
    Else
        lightCtrl.LightOff l25
    End If
End Sub 


'****************************
' Combo Shot Left Ramp
' Event Listeners:      
    RegisterPlayerStateEvent COMBO_SHOT_LEFT_RAMP, "PS_ComboShotLeftRamp"
'
'*****************************
Sub PS_ComboShotLeftRamp()
    If GetPlayerState(COMBO_SHOT_LEFT_RAMP) = 1 Then
        lightCtrl.Blink l26
    Else
        lightCtrl.LightOff l26
    End If
End Sub 

'****************************
' Combo Shot Right Ramp
' Event Listeners:      
    RegisterPlayerStateEvent COMBO_SHOT_RIGHT_RAMP, "PS_ComboShotRightRamp"
'
'*****************************
Sub PS_ComboShotRightRamp()
    If GetPlayerState(COMBO_SHOT_RIGHT_RAMP) = 1 Then
        lightCtrl.Blink l27
    Else
        lightCtrl.LightOff l27
    End If
End Sub 

'****************************
' Combo Shot Right Orbit
' Event Listeners:      
    RegisterPlayerStateEvent COMBO_SHOT_RIGHT_ORBIT, "PS_ComboShotRightOrbit"
'
'*****************************
Sub PS_ComboShotRightOrbit()
    If GetPlayerState(COMBO_SHOT_RIGHT_ORBIT) = 1 Then
        lightCtrl.Blink l28
    Else
        lightCtrl.LightOff l28
    End If
End Sub 