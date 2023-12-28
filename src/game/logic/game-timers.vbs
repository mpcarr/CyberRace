'***********************************************************************************************************************
'***** Game Timers                                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim dbs1, dbs2, dbsdelta, dbstime, dbstens, dbsones, dbsdecimals
dbsdelta = .1

Sub ClearTimerDisplay
	lightCtrl.LightOff l150
	lightCtrl.LightOff l151
	lightCtrl.LightOff l152
	lightCtrl.LightOff l153
	lightCtrl.LightOff l154
	lightCtrl.LightOff l155
	lightCtrl.LightOff l156
	lightCtrl.LightOff l157
	lightCtrl.LightOff l158
	lightCtrl.LightOff l159

	lightCtrl.LightOff l160
	lightCtrl.LightOff l161
	lightCtrl.LightOff l162
	lightCtrl.LightOff l163
	lightCtrl.LightOff l164
	lightCtrl.LightOff l165
	lightCtrl.LightOff l166
	lightCtrl.LightOff l167
	lightCtrl.LightOff l168
	lightCtrl.LightOff l169
End Sub

Sub GameTimersUpdate_Timer()
	Dim activeTimer : activeTimer = Array(1000, 0)
    ProcessGameTimer GAME_BALLSAVE_TIMER_IDX, activeTimer
    activeTimer = ProcessGameTimer(GAME_RACE_TIMER_IDX, activeTimer)
    activeTimer = ProcessGameTimer(GAME_BET_TIMER_IDX, activeTimer)
    activeTimer = ProcessGameTimer(GAME_BOOST_TIMER_IDX, activeTimer)
    activeTimer = ProcessGameTimer(GAME_EMP_TIMER_IDX, activeTimer)
    activeTimer = ProcessGameTimer(GAME_SKILLS_TIMER_IDX, activeTimer)
	activeTimer = ProcessGameTimer(GAME_TT_TIMER_IDX, activeTimer)
	ProcessGameTimer GAME_BONUS_TIMER_IDX, activeTimer
	ProcessGameTimer GAME_SELECTION_TIMER_IDX, activeTimer
	ProcessGameTimer GAME_MULTIPLIER_TIMER_IDX, activeTimer
    ClearTimerDisplay
    If activeTimer(0) = 1000 Then
		If GameTimers(GAME_BALLSAVE_TIMER_IDX) > 0 Then
			activeTimer = Array(GameTimers(GAME_BALLSAVE_TIMER_IDX), GameTimerColors(GAME_BALLSAVE_TIMER_IDX))
        End If
    End If
	If activeTimer(0) = 1000 Then
		Exit Sub
	End If
    dbstime = activeTimer(0)
    Dim tmp
    'debug.print(activeTimer(1))
	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)
	if dbstime > 10 then 
		lightCtrl.LightOnWithColor Eval("l"&dbstens+150), activeTimer(1)
		lightCtrl.LightOnWithColor Eval("l"&dbsones+160), activeTimer(1)
	else
		lightCtrl.LightOnWithColor Eval("l"&(dbsones)+150), activeTimer(1)
		lightCtrl.LightOnWithColor Eval("l"&dbsdecimals+160), activeTimer(1)
	end if

End Sub



Function ProcessGameTimer(timer, activeTimer)
    Dim a, b,dbstime
    a = activeTimer(0)
    b = activeTimer(1)
    If GameTimers(timer) > 0 Then
        If GameTimers(timer) < a Then
            a = GameTimers(timer)
            b = GameTimerColors(timer)
        End If
        dbstime = GameTimers(timer) - dbsdelta
		GameTimers(timer) = dbstime
		If dbstime < 10 And GameTimersHurry(timer) = 0 Then
			GameTimersHurry(timer) = 1
			DispatchPinEvent GameTimerHurryEvent(timer)
		End If
		If dbstime <= 0 Then
            GameTimers(timer) = 0
			GameTimersHurry(timer) = 0
			DispatchPinEvent GameTimerEndEvent(timer)
        End If
    End If
    ProcessGameTimer = Array(a,b)
End Function