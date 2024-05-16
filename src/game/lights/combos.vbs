'****************************
' Combo Shot Spinner
' Event Listeners:      
    AddPlayerStateEventListener COMBO_SHOT_SPINNER, COMBO_SHOT_SPINNER &   "PS_ComboShotSpinner",   "PS_ComboShotSpinner",  1000, Null
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
    AddPlayerStateEventListener COMBO_SHOT_LEFT_ORBIT, COMBO_SHOT_LEFT_ORBIT &   "PS_ComboShotLeftOrbit",   "PS_ComboShotLeftOrbit",  1000, Null
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
    AddPlayerStateEventListener COMBO_SHOT_LEFT_RAMP, COMBO_SHOT_LEFT_RAMP &   "PS_ComboShotLeftRamp",   "PS_ComboShotLeftRamp",  1000, Null
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
    AddPlayerStateEventListener COMBO_SHOT_RIGHT_RAMP, COMBO_SHOT_RIGHT_RAMP &   "PS_ComboShotRightRamp",   "PS_ComboShotRightRamp",  1000, Null
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
    AddPlayerStateEventListener COMBO_SHOT_RIGHT_ORBIT, COMBO_SHOT_RIGHT_ORBIT &   "PS_ComboShotRightOrbit",   "PS_ComboShotRightOrbit",  1000, Null
'*****************************
Sub PS_ComboShotRightOrbit()
    If GetPlayerState(COMBO_SHOT_RIGHT_ORBIT) = 1 Then
        lightCtrl.Blink l28
    Else
        lightCtrl.LightOff l28
    End If
End Sub 