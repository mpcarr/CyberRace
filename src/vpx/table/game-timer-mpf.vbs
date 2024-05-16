
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


	Dim ii
	Dim ChgLED : ChgLED = MPFController.ChangedBrightnessLEDs
	if not isempty(ChgLED) Then	
		for ii=0 to UBound(ChgLED)
			'if ChgLED(ii,0) = "0-0-91" Then
				'debug.print ChgLED(ii,0) &":"& ChgLED(ii,1) 
			'end if
			MPFUpdateLamps ChgLED(ii,0), ChgLED(ii,1) 
		Next
	end If
	lightCtrl.SyncLightMapColors
	
	Dim ChgSeg : ChgSeg = MPFController.ChangedSegmentDisplayText
	if not isempty(ChgSeg) Then	
		for ii=0 to UBound(ChgSeg)
			If ChgSeg(ii,0) = "1" Then
				Dim firstChar : firstChar = Mid(ChgSeg(ii,1), 1, 1)
				Dim secondChar : secondChar = Mid(ChgSeg(ii,1), 2, 1)
				lightCtrl.LightColor l150, RGB(0,0,0)
				lightCtrl.LightColor l151, RGB(0,0,0)
				lightCtrl.LightColor l152, RGB(0,0,0)
				lightCtrl.LightColor l153, RGB(0,0,0)
				lightCtrl.LightColor l154, RGB(0,0,0)
				lightCtrl.LightColor l155, RGB(0,0,0)
				lightCtrl.LightColor l156, RGB(0,0,0)
				lightCtrl.LightColor l157, RGB(0,0,0)
				lightCtrl.LightColor l158, RGB(0,0,0)
				lightCtrl.LightColor l159, RGB(0,0,0)
				Select Case firstChar
					Case "0"
						lightCtrl.LightColor l150, RGB(255,255,255)
					Case "1"
						lightCtrl.LightColor l151, RGB(255,255,255)
					Case "2"
						lightCtrl.LightColor l152, RGB(255,255,255)
					Case "3"
						lightCtrl.LightColor l153, RGB(255,255,255)
					Case "4"
						lightCtrl.LightColor l154, RGB(255,255,255)
					Case "5"
						lightCtrl.LightColor l155, RGB(255,255,255)
					Case "6"
						lightCtrl.LightColor l156, RGB(255,255,255)
					Case "7"
						lightCtrl.LightColor l157, RGB(255,255,255)
					Case "8"
						lightCtrl.LightColor l158, RGB(255,255,255)
					Case "9"
						lightCtrl.LightColor l159, RGB(255,255,255)
				End Select
				lightCtrl.LightColor l160, RGB(0,0,0)
				lightCtrl.LightColor l161, RGB(0,0,0)
				lightCtrl.LightColor l162, RGB(0,0,0)
				lightCtrl.LightColor l163, RGB(0,0,0)
				lightCtrl.LightColor l164, RGB(0,0,0)
				lightCtrl.LightColor l165, RGB(0,0,0)
				lightCtrl.LightColor l166, RGB(0,0,0)
				lightCtrl.LightColor l167, RGB(0,0,0)
				lightCtrl.LightColor l168, RGB(0,0,0)
				lightCtrl.LightColor l169, RGB(0,0,0)
				Select Case secondChar
					Case "0"
						lightCtrl.LightColor l160, RGB(255,255,255)
					Case "1"
						lightCtrl.LightColor l161, RGB(255,255,255)
					Case "2"
						lightCtrl.LightColor l162, RGB(255,255,255)
					Case "3"
						lightCtrl.LightColor l163, RGB(255,255,255)
					Case "4"
						lightCtrl.LightColor l164, RGB(255,255,255)
					Case "5"
						lightCtrl.LightColor l165, RGB(255,255,255)
					Case "6"
						lightCtrl.LightColor l166, RGB(255,255,255)
					Case "7"
						lightCtrl.LightColor l167, RGB(255,255,255)
					Case "8"
						lightCtrl.LightColor l168, RGB(255,255,255)
					Case "9"
						lightCtrl.LightColor l169, RGB(255,255,255)
				End Select
			End If
			'MPFUpdateLamps ChgLED(ii,0), ChgLED(ii,1) 
		Next
	end If


	Dim ChgSol : ChgSol = MPFController.ChangedSolenoids
	if not isempty(ChgSol) Then	
		for ii=0 to UBound(ChgSol)
			debug.print "coil: " &  ChgSol(ii,0) & ". State: " & ChgSol(ii,1)
			If ChgSol(ii,0) = "0-0-6" and ChgSol(ii,1) Then
				AutoPlungerDelay.Interval = 300
	    		AutoPlungerDelay.Enabled = True
			End If
			If ChgSol(ii,0) = "0-0-5" and ChgSol(ii,1) Then
				ReleaseBall
			End If
			If ChgSol(ii,0) = "0-0-7" and ChgSol(ii,1) Then
				raceVuk.Kick 65, RndInt(7,15)
				SoundSaucerKick 1, raceVuk
			End If
			If ChgSol(ii,0) = "0-0-8" and ChgSol(ii,1) Then
				sw_38.Kick 0, 60, 1.36
    			SoundSaucerKick 1, sw_38
			End If
			If ChgSol(ii,0) = "0-0-9" and ChgSol(ii,1) Then
				SoundSaucerKick 1, sw39
    			KickBall KickerBall39, 0, 0, 55, 10
			End If
		Next
	end If
End Sub


Sub LightTimer_timer()
	'lightCtrl.Update
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
