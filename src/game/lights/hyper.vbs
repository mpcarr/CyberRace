
'****************************
' HYPER
' Event Listeners:          
    AddPlayerStateEventListener HYPER, HYPER &   "PS_Hyper",   "PS_Hyper",  1000, Null
'*****************************
Sub PS_Hyper()
    lightCtrl.LightOff l37
    lightCtrl.LightOff l38
    lightCtrl.LightOff l39
    lightCtrl.LightOff l40
    lightCtrl.LightOff l41
    'debug.print(GetPlayerState(HYPER))
    Select Case GetPlayerState(HYPER)
        Case 1:
            'debug.print("Running 1")
            lightCtrl.FlickerOn l37
        Case 2:
            'debug.print("Running 2")
            lightCtrl.FlickerOn l37
            lightCtrl.FlickerOn l38
        Case 3:
            'debug.print("Running 3")
            lightCtrl.FlickerOn l37
            lightCtrl.FlickerOn l38
            lightCtrl.FlickerOn l39
        Case 4:
            'debug.print("Running 4")
            lightCtrl.FlickerOn l37
            lightCtrl.FlickerOn l38
            lightCtrl.FlickerOn l39
            lightCtrl.FlickerOn l40
        Case 5:
            'debug.print("Running 5")    
            lightCtrl.FlickerOn l37
            lightCtrl.FlickerOn l38
            lightCtrl.FlickerOn l39
            lightCtrl.FlickerOn l40
            lightCtrl.FlickerOn l41
    End Select
End Sub
