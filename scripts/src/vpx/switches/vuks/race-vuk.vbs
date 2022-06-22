Sub raceVuk_Hit()
    Dim waittime
    waittime = 500
    vpmTimer.addtimer waittime, "exitRaceVuk '"
End Sub

Sub exitraceVuk
    raceVuk.Kick 58, 10
End Sub