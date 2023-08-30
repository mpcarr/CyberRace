
dim lastimeupdate, period
lastimeupdate = gametime

Sub GameTimer_timer()
	period = gametime - lastimeupdate
	If period > 500 Then
		debug.Print(period)
	End If
	lastimeupdate = gametime
	DoSTAnim						'handle stand up target animations
	RollingUpdate
	cor.update
	Options_UpdateDMD
	TargetMovableHelper
End Sub

Sub FrameTimer_Timer()
	Dim el, a 
	Disc_BM_World.RotZ = (Disc_BM_World.RotZ + (ttSpinner.Speed/4)) Mod 360
	a = Disc_BM_World.RotZ
	For Each el in Disc_LM
		el.Rotz = a		
	Next
	FlipperVisualUpdate()

	For Each el in sw18_LM
		el.Rotz = a		
	Next

	lightCtrl.Update
	calloutsQ.Tick
	

End Sub

Sub TargetMovableHelper
	Dim t
	For each t in sw10_LM : t.transy = sw10_BM_World.transy : Next

	For each t in sw11_LM : t.transy = sw11_BM_World.transy : Next

	For each t in sw12_LM : t.transy = sw12_BM_World.transy : Next

	For each t in sw18_LM : t.transy = sw18_BM_World.transy : Next

	For each t in sw19_LM : t.transy = sw19_BM_World.transy : Next

	For each t in sw20_LM : t.transy = sw20_BM_World.transy : Next

	For each t in sw21_LM : t.transy = sw21_BM_World.transy : Next

	For each t in sw22_LM : t.transy = sw22_BM_World.transy : Next

	For each t in sw23_LM : t.transy = sw23_BM_World.transy : Next

	For each t in sw25_LM : t.transy = sw25_BM_World.transy : Next

End Sub
