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
    Dispatch SWITCH_HIT_LEFT_OUTLANE, Null
End Sub
Sub swLeftInlane_Hit()
    Dispatch SWITCH_HIT_LEFT_INLANE, Null
End Sub
Sub swRightInlane_Hit()
    Dispatch SWITCH_HIT_RIGHT_INLANE, Null
End Sub
Sub swRightOutlane_Hit()
    If gameState("switches")("shortcut") = 0 Then
        Dispatch SWITCH_HIT_RIGHT_OUTLANE, Null
    End If
End Sub

Sub swShortcut_Hit()
    Dispatch SWITCH_HIT_SHORTCUT, Null
    DiverterFlipper.RotateToEnd
    DiverterFlipper001.RotateToEnd
    vpmTimer.addtimer 3000, "closeRightLaneDiverter '"
End Sub

Sub swLeftReturn_Hit()
    DISPATCH SWITCH_HIT_CENTER_RAMP, null
End Sub

Sub closeRightLaneDiverter
    DiverterFlipper.RotateToStart
    DiverterFlipper001.RotateToStart
    gameState("switches")("shortcut") = 0
End Sub

Sub swPlungerLane_Hit()
    DISPATCH SWITCH_HIT_PLUNGER_LANE, Null
End Sub

Sub swSecretUpgrade_Hit()
    DISPATCH SWITCH_HIT_SECRET_UPGRADE, Null
End Sub

'***********************************************************************************************************************
