
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

Sub CancelBallSaver()
	GameTimers(GAME_BALLSAVE_TIMER_IDX) = 0
	ballSaver = False
	ballSaverInGrace = False
	BallSaverTimerExpired.Enabled = False
End Sub

Sub BallSaverTimerExpired_Timer()
    If ballSaverInGrace = False Then
        BallSaverTimerExpired.Interval = 3000
		If GetPlayerState(EXTRA_BALLS) > 0 Then
			lightCtrl.LightOn l16
		Else
			lightCtrl.LightOff l16
		End If
		ballSaverInGrace = True
    Else
        BallSaverTimerExpired.Enabled = False
        ballSaver = False
		ballSaverInGrace = False
    End If
End Sub

