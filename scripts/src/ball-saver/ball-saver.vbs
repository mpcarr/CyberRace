Dim dbs1, dbs2, dbsdelta, dbstime, dbstens, dbsones, dbsdecimals
Sub EnableBallSaver(seconds)
	seconds = seconds + 0.3  'padding
	BallSaverTimerExpired.Interval = 1000 * seconds
	BallSaverTimerExpired.Enabled = True

	'p_watchdisplay_full.Visible = True
	p_watchdisplay_left.Visible = True
	p_watchdisplay_right.Visible = True

	LightBlink(lsBallSave)
	'Set display to x seconds 
	dbstime = seconds
	dbsdelta = .1
	BallSaverUpdateTimer.Interval = 100

	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
    BallSaverUpdateTimer.Enabled = True
End Sub

Sub StopBallSaver
	BallSaverTimerExpired.Enabled = False
	BallSaverUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
End Sub

Sub BallSaverTimerExpired_Timer()
    BallSaverTimerExpired.Enabled = False
    BallSaverUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
	DISPATCH GAME_BALL_SAVE_ENDED, null
End Sub

Sub ResetBallSaveDisplay
	p_watchdisplay_left.Visible = False
	p_watchdisplay_right.Visible = False
	p_watchdisplay_full.blenddisablelighting = 0
	p_watchdisplay_left.blenddisablelighting = 0
	p_watchdisplay_right.blenddisablelighting = 0
End Sub

Sub BallSaverUpdateTimer_Timer()
	Dim tmp
	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
End Sub