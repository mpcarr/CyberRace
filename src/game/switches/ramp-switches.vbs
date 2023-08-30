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