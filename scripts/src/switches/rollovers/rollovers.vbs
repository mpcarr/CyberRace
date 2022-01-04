'***********************************************************************************************************************
'*****   Rollover Switches                                  	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub swPreLeftOrbit_Hit()
    Dispatch SWITCH_HIT_PRE_LEFT_ORBIT, Null
End Sub
Sub swLeftOrbit_Hit()
    Dispatch SWITCH_HIT_LEFT_ORBIT, Null
End Sub
Sub swPreRightOrbit_Hit()
    Dispatch SWITCH_HIT_PRE_RIGHT_ORBIT, Null
End Sub
Sub swRightOrbit_Hit()
    Dispatch SWITCH_HIT_RIGHT_ORBIT, Null
End Sub
Sub swLeftOutlane_Hit()
    Lampz.State(90) = 1
    lSeqLeftDrain.AddItem(lSeqLeftDrainBlink)
End Sub
Sub swLeftInlane_Hit()
    Lampz.State(91) = 1
End Sub
Sub swRightInlane_Hit()
    Lampz.State(92) = 1
End Sub
Sub swRightOutlane_Hit()
    Lampz.State(93) = 1
    lSeqRightDrain.AddItem(lSeqRightDrainBlink)
End Sub

Sub swShortcut_Hit()
    Dispatch SWITCH_HIT_SHORTCUT, Null
    DiverterFlipper.RotateToEnd
    DiverterFlipper001.RotateToEnd
    vpmTimer.addtimer 3000, "closeRightLaneDiverter '"
End Sub

Sub closeRightLaneDiverter
    DiverterFlipper.RotateToStart
    DiverterFlipper001.RotateToStart
End Sub

Sub swPlungerLane_Hit()
    DISPATCH SWITCH_HIT_PLUNGER_LANE, Null
End Sub



'***********************************************************************************************************************
