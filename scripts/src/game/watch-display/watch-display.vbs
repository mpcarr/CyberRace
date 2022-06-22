Sub EnableWatchTimer(seconds)
	seconds = seconds + 0.3  'padding
	WatchDisplayTimerExpired.Interval = 1000 * seconds
	WatchDisplayTimerExpired.Enabled = True

	'p_watchdisplay_full.Visible = True
	p_watchdisplay_left.Visible = True
	p_watchdisplay_right.Visible = True

	'Set display to x seconds 
	dbstime = seconds
	dbsdelta = .1
	WatchDisplayUpdateTimer.Interval = 100

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
    WatchDisplayUpdateTimer.Enabled = True
End Sub

Sub StopWatchDisplay
	WatchDisplayTimerExpired.Enabled = False
	WatchDisplayUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
End Sub

Sub WatchDisplayTimerExpired_Timer()
    WatchDisplayTimerExpired.Enabled = False
    WatchDisplayUpdateTimer.Enabled = False
	ResetBallSaveDisplay
End Sub

Sub ResetWatchDisplay
	p_watchdisplay_left.Visible = False
	p_watchdisplay_right.Visible = False
	p_watchdisplay_full.blenddisablelighting = 0
	p_watchdisplay_left.blenddisablelighting = 0
	p_watchdisplay_right.blenddisablelighting = 0
End Sub

Sub WatchDisplayUpdateTimer_Timer()
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