'***********************************************************************************************************************
'*****    Ramp Switches                                        	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub swEnterRightRamp_Hit()
	WireRampOn(True)
	DispatchPinEvent SWITCH_HIT_RIGHT_RAMP_ENTER
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

Sub swWireRampEndLeft_UnHit()
    RandomSoundRampStop swWireRampEndLeft
    RandomSoundDelayedBallDropOnPlayfield ActiveBall
End Sub

Sub swWireRampEndRight_UnHit()
    RandomSoundRampStop swWireRampEndRight
    RandomSoundDelayedBallDropOnPlayfield ActiveBall
End Sub