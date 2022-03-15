Sub raceVuk_Hit()
    Dim waittime
    waittime = 500
    vpmTimer.addtimer waittime, "exitRaceVuk '"
End Sub

Sub exitraceVuk
    raceVuk.Kick 5, 15
End Sub