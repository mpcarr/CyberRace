'***********************************************************************************************************************
'*****    Ramp Switches                                        	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub swEnterRightRamp_Hit()
	WireRampOn(True)
End Sub

Sub swEnterLeftRamp_Hit()
	WireRampOn(True)
End Sub

Sub swEnterLeftRampVuk_Hit()
	WireRampOn(False)
End Sub

Sub swEnterVukRamp_Hit()
	WireRampOn(False)
End Sub

Sub swExitRightRamp_Hit()
	WireRampOff()	 
	WireRampOn(False)
End Sub

Sub swExitLeftRamp_Hit()
	WireRampOff()	
	WireRampOn(False)
End Sub

Sub swRightRamp_Hit()
	DISPATCH SWITCH_HIT_RIGHT_RAMP, Null
End Sub

Sub swLeftRamp_Hit()
	DISPATCH SWITCH_HIT_LEFT_RAMP, Null
End Sub

Sub RPin_Hit()
	DISPATCH SWITCH_HIT_RAMP_PIN, Null
End Sub

Sub LockPin_Hit()
	'If gameState("switches")("lockPinHit") = False Then
'		DISPATCH SWITCH_HIT_BALL_LOCK, Null
'	End If
End Sub