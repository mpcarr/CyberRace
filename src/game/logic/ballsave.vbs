
Dim ballSaverInGrace : ballSaverInGrace = False
Sub EnableBallSaver(seconds)
	lightCtrl.Blink l16
	seconds = seconds + 0.3  'padding
	BallSaverTimerExpired.Interval = 1000 * seconds
	BallSaverTimerExpired.Enabled = True
	GameTimers(GAME_BALLSAVE_TIMER_IDX) = seconds
	ballSaver = True
	ballSaverInGrace = False
End Sub

Sub BallSaverTimerExpired_Timer()
    If ballSaverInGrace = False Then
        BallSaverTimerExpired.Interval = 3000
		lightCtrl.LightOff l16
		ballSaverInGrace = True
    Else
        BallSaverTimerExpired.Enabled = False
        ballSaver = False
		ballSaverInGrace = False
    End If
End Sub
