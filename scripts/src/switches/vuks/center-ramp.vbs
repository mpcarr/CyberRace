Sub vukCenterRamp_Hit()
    Dim waittime
    waittime = 400
    DISPATCH SWITCH_HIT_CENTER_RAMP, null
    vpmTimer.addtimer waittime, "exitCenterRampVuk '"
End Sub

Sub exitCenterRampVuk
    vukCenterRamp.Kick 0, 150, 1.36
End Sub