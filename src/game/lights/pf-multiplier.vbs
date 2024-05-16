'****************************
' PF Multiplier Lights
' Event Listeners:  
    AddPlayerStateEventListener PF_MULTIPLIER, PF_MULTIPLIER &   "PFMultiplierLights",   "PFMultiplierLights",  1000, Null
'*****************************
Sub PFMultiplierLights()
    Select Case GetPlayerState(PF_MULTIPLIER):
        Case 1:
            lightCtrl.LightOff l50
            lightCtrl.LightOff l51
            lightCtrl.LightOff l52
        Case 2:
            lightCtrl.FlickerOn l50
        Case 3:
            lightCtrl.FlickerOn l51
        Case 5:
            lightCtrl.FlickerOn l52
    End Select
End Sub
