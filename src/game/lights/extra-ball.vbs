
'****************************
' Extra Balls
' Event Listeners:          
    RegisterPlayerStateEvent EXTRA_BALLS, "PS_ExtraBalls"
'
'*****************************
Sub PS_ExtraBalls()
    If GetPlayerState(EXTRA_BALLS) > 0 Then
        lightCtrl.LightOn l16
    ElseIf ballSaver = false Then
        lightCtrl.LightOff l16
    End If
End Sub
