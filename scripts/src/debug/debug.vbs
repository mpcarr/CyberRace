'***********************************************************************************************************************
'*****  DEBUG                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub DebugOutClear()

	Dim objFileToWrite:Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile("C:\vpxout\ra3.txt",2,true)
	objFileToWrite.WriteLine("")
	objFileToWrite.Close
	Set objFileToWrite = Nothing

End Sub

Sub DebugOut(data)

	Dim objFileToWrite:Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile("C:\vpxout\ra3.txt",8,true)
	objFileToWrite.WriteLine(data)
	objFileToWrite.Close
	Set objFileToWrite = Nothing

End Sub

Dim c: c = 0
Sub debugKeys(ByVal Keycode)

	'MsgBox(keycode)
	If keyCode = 30 Then 'A
		debugKicker.CreateSizedball BallSize / 2
		debugKicker.LastCapturedBall.UserValue = "debugBall"
		debugKicker.Kick 90, 10
	End If
	If keyCode = 31 Then 'S
		debugKicker.CreateSizedball BallSize / 2
		debugKicker.LastCapturedBall.UserValue = "debugBall"
		debugKicker.Kick -90, 10
	End If
	If keyCode = 33 Then 'F
		vukdebug.CreateSizedball BallSize / 2
		vukdebug.LastCapturedBall.UserValue = "debugBall"
		vukdebug.Kick 0, 10
	End If
	If keyCode = 34 Then 'G
		alliedLockDebug.CreateSizedball BallSize / 2
		alliedLockDebug.LastCapturedBall.UserValue = "debugBall"
		alliedLockDebug.Kick -75, 15

	End If
	If keyCode = 35 Then 'H
		Timer_test1.Enabled=False
		vukEmpireDebug.CreateSizedball BallSize / 2
		vukEmpireDebug.LastCapturedBall.UserValue = "debugBall"
		vukEmpireDebug.Kick 20, 50
	End If
	If keyCode = 36 Then 'J
		debugKickerTopLock.CreateSizedball BallSize / 2
		debugKickerTopLock.LastCapturedBall.UserValue = "debugBall"
		debugKickerTopLock.Kick 0, 1
	End If
	If keyCode = 37 Then 'K
		debugKickerNfozzy.CreateSizedball BallSize / 2
		debugKickerNfozzy.LastCapturedBall.UserValue = "debugBall"
		debugKickerNFozzy.Kick -45, 20
	End If
	If keyCode = 22 Then 'U
		debugKickerBumpers.CreateSizedball BallSize / 2
		debugKickerBumpers.LastCapturedBall.UserValue = "debugBall"
		debugKickerBumpers.Kick 0, 1
	End If
	If keyCode = 197 Then
		pupevent 504
	End If
	
	If keyCode = 20 Then 'T
		'diverter
		If DiverterP002.RotZ=-60 Then
			DiverterDir = 1
			DiverterOff.IsDropped=0
			DiverterOn.IsDropped=1
			diverterWall3Off.IsDropped = 0
			diverterWall3On.IsDropped = 1
			timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
			PlaySoundAt SoundFX("DiverterOn",DOFContactors),DiverterP002
		ElseIf DiverterP002.RotZ=0 Then
			DiverterDir = -1
			DiverterOff.IsDropped=1
			DiverterOn.IsDropped=0
			diverterWall3Off.IsDropped = 1
			diverterWall3On.IsDropped = 0
			timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
			PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002
		End If
	End If
	If keyCode = 21 Then 'Y
		debugKickerLeftOrbit.CreateSizedball BallSize / 2
		debugKickerLeftOrbit.LastCapturedBall.UserValue = "debugBall"
		debugKickerLeftOrbit.Kick -45, 50
	End If
	If keyCode = 23 Then 'I
		debugKickerLeftRamp.CreateSizedball BallSize / 2
		debugKickerLeftRamp.LastCapturedBall.UserValue = "debugBall"
		debugKickerLeftRamp.Kick -20, 50
	End If
	If keyCode = 25 Then 'P
		debugKickerRightOrbit.CreateSizedball BallSize / 2
		debugKickerRightOrbit.LastCapturedBall.UserValue = "debugBall"
		debugKickerRightOrbit.Kick 20, 40
	End If

	If keyCode = 17 Then 'W
		debugKickerAugmentations.CreateSizedball BallSize / 2
		debugKickerAugmentations.LastCapturedBall.UserValue = "debugBall"
		debugKickerAugmentations.Kick 45, 20
	End If
	If keyCode = 18 Then 'E
		debugKickerDrainLeft.CreateSizedball BallSize / 2
		debugKickerDrainLeft.LastCapturedBall.UserValue = "debugBall"
		debugKickerDrainLeft.Kick 0, 5
	End If
	If keyCode = 19 Then 'R
		debugKickerCaptive.CreateSizedball BallSize / 2
		debugKickerCaptive.LastCapturedBall.UserValue = "debugBall"
		debugKickerCaptive.Kick 15, 25
	End If
	If keyCode = 26 Then 'W
		debugKickerShortcut.CreateSizedball BallSize / 2
		debugKickerShortcut.LastCapturedBall.UserValue = "debugBall"
		debugKickerShortcut.Kick 45, 20
	End If

	If keyCode = 11 Then '0
		If ModLampz.state(0)>0 Then
			DISPATCH LIGHTS_GI_OFF, null
		Else
			DISPATCH LIGHTS_GI_ON, null
		End If


		Dim ele
		For Each ele in GetElements
		
			On Error Resume Next
		
			If ele.Surface = "22h" Then
				If Err Then
					Debug.print("Element has no surface prop")
				Else
					Debug.print(ele.Name)
				End If
			End If
		
			On Error GoTo 0
		
		Next

	End If

	If keyCode = 39 Then ';
		Dispatch LIGHTS_GI_EMPIRE, null
	End If
	If keyCode = 40 Then ''
		Dispatch LIGHTS_GI_SOVIET, null
	End If
	If keyCode = 43 Then '#
		Dispatch LIGHTS_GI_ALLIED, null
	End If
	If keyCode = 51 Then '.
		Dispatch LIGHTS_GI_NORMAL, null
	End If

End Sub

Sub debugFlasher_Timer()
	'
	'objHexBase(1).Material = "FlasherHexMaterial1"
	'objHexBase(1).Image = "hexbasered"
	'objHexLit(1).Image = "hexbasered"
	'HexObjlevel(1) = 1 : FlasherHexFlash1_Timer
	'objHexBase(2).Image = "hexbasered"
	'objHexLit(2).Image = "hexbasered"
	'HexObjlevel(2) = 1 : FlasherHexFlash2_Timer
	'objHexBase(3).Image = "hexbasered"
	'objHexLit(3).Image = "hexbasered"
	'HexObjlevel(3) = 1 : FlasherHexFlash3_Timer
	'objHexBase(4).Image = "hexbasered"
	'objHexLit(4).Image = "hexbasered"
	'HexObjlevel(4) = 1 : FlasherHexFlash4_Timer
	'objHexBase(5).Image = "hexbasered"
	'objHexLit(5).Image = "hexbasered"
	'HexObjlevel(5) = 1 : FlasherHexFlash5_Timer
	'objHexBase(6).Image = "hexbasered"
	'objHexLit(6).Image = "hexbasered"
	'HexObjlevel(6) = 1 : FlasherHexFlash6_Timer
	'objHexBase(7).Image = "hexbasered"
	'objHexLit(7).Image = "hexbasered"
	'HexObjlevel(7) = 1 : FlasherHexFlash7_Timer
	'objHexBase(8).Image = "hexbasered"
	'objHexLit(8).Image = "hexbasered"
	'HexObjlevel(8) = 1 : FlasherHexFlash8_Timer
	'objHexBase(9).Image = "hexbasered"
	'objHexLit(9).Image = "hexbasered"
	'HexObjlevel(9) = 1 : FlasherHexFlash9_Timer
	'objHexBase(10).Image = "hexbasered"
	'objHexLit(10).Image = "hexbasered"
	'HexObjlevel(10) = 1 : FlasherHexFlash10_Timer
	'objHexBase(11).Image = "hexbasered"
	'objHexLit(11).Image = "hexbasered"
	'HexObjlevel(11) = 1 : FlasherHexFlash11_Timer
	'objHexBase(12).Image = "hexbasered"
	'objHexLit(12).Image = "hexbasered"
	'HexObjlevel(12) = 1 : FlasherHexFlash12_Timer
	'objHexBase(13).Image = "hexbasered"
	'objHexLit(13).Image = "hexbasered"
	'HexObjlevel(13) = 1 : FlasherHexFlash13_Timer
	'objHexBase(14).Image = "hexbasered"
	'objHexLit(14).Image = "hexbasered"
	'HexObjlevel(14) = 1 : FlasherHexFlash14_Timer
	'objHexBase(15).Image = "hexbasered"
	'objHexLit(15).Image = "hexbasered"
	'HexObjlevel(15) = 1 : FlasherHexFlash15_Timer
	'objHexBase(16).Image = "hexbasered"
	'objHexLit(16).Image = "hexbasered"
	'HexObjlevel(16) = 1 : FlasherHexFlash16_Timer

End Sub
