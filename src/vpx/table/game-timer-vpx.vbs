
dim lastimeupdate, period
lastimeupdate = gametime

Sub GameTimer_timer()
	period = gametime - lastimeupdate
	lastimeupdate = gametime
	DoSTAnim						'handle stand up target animations
	RollingUpdate
	cor.update
	Options_UpdateDMD
	TargetMovableHelper
	Dim el
	BM_Disc.RotZ = (BM_Disc.RotZ + (ttSpinner.Speed/4)) Mod 360
	For Each el in BP_Disc
		el.Rotz = BM_Disc.RotZ	
	Next
End Sub


Sub LightTimer_timer()
	lightCtrl.Update
End Sub

Sub FrameTimer_Timer()
	BSUpdate	
	calloutsQ.Tick
	TimerTick
End Sub

Sub TargetMovableHelper
	Exit Sub
	Dim t
	For each t in BP_sw10 : t.transy = BM_sw10.transy : Next

	For each t in BP_sw11 : t.transy = BM_sw11.transy : Next

	For each t in BP_sw12 : t.transy = BM_sw12.transy : Next

	For each t in BP_sw18 : t.transy = BM_sw18.transy : Next

	For each t in BP_sw19 : t.transy = BM_sw19.transy : Next

	For each t in BP_sw20 : t.transy = BM_sw20.transy : Next

	For each t in BP_sw21 : t.transy = BM_sw21.transy : Next

	For each t in BP_sw22 : t.transy = BM_sw22.transy : Next

	For each t in BP_sw23 : t.transy = BM_sw23.transy : Next

	For each t in BP_sw25 : t.transy = BM_sw25.transy : Next

End Sub
