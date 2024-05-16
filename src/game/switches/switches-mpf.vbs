
'******************************************
Sub Drain_Hit 
    RandomSoundDrain Drain
    UpdateTrough()
    'DispatchPinEvent BALL_DRAIN
End Sub

Sub Drain_UnHit : UpdateTrough : End Sub

Sub raceVuk_Hit()
    MPFController.Switch("0-0-32")=1
End Sub
Sub raceVuk_UnHit()
    MPFController.Switch("0-0-32")=0
End Sub

Sub sw_38_Hit()
    MPFController.Switch("0-0-33")=1
End Sub
Sub sw_38_UnHit()
    MPFController.Switch("0-0-33")=0
End Sub

Sub sw39_Hit()
    MPFController.Switch("0-0-34")=1
    Set KickerBall39 = ActiveBall
End Sub
Sub sw39_UnHit()
    MPFController.Switch("0-0-34")=0
    KickerBall39 = Null
End Sub