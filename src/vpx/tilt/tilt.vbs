
'********************************************
' ZTLT : Tilt
'********************************************

'NOTE: The TiltDecreaseTimer Subtracts .01 from the "Tilt" variable every round
Sub CheckTilt                                    	'Called when table is nudged
	If Not gameStarted Then Exit Sub
	Tilt = Tilt + TiltSensitivity                	'Add to tilt count
	TiltDecreaseTimer.Enabled = True
	If(Tilt > TiltSensitivity) AND (Tilt <= 15) Then ShowTiltWarning 'show a warning
	If Tilt > 15 Then TiltMachine  					'If more than 15 then TILT the table
End Sub

Sub CheckMechTilt                                	'Called when mechanical tilt bob switch closed
	If Not gameStarted Then Exit Sub
	If Not bMechTiltJustHit Then
		MechTilt = MechTilt + 1               		'Add to tilt count
		If(MechTilt > 0) AND (MechTilt <= 2) Then ShowTiltWarning 'show a warning
		If MechTilt > 2 Then TiltMachine  			'If more than 2 then TILT the table
		bMechTiltJustHit = True
        Debounce "mechTilt", "TimerMechTilt", 3000
	End If
End Sub

Sub TimerMechTilt
	bMechTiltJustHit = False
End Sub

Sub ShowTiltWarning
    FlexTiltWarningScene()
End Sub

Sub TiltMachine
    DmdQ.RemoveAll()
    lightCtrl.PauseMainLights()
    GameTilted = True
    MusicOff
    CancelBallSaver()
    FlexTiltScene()
End Sub

Sub TiltDecreaseTimer_Timer
	' DecreaseTilt
	If Tilt> 0 Then
		Tilt = Tilt - 0.1
	Else
		TiltDecreaseTimer.Enabled = False
	End If
End Sub
