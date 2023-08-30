
'****************************
' Turn Table Off
' Event Listeners:          
    RegisterPlayerStateEvent MODE_MULTIBALL, "TurnTableState"
'
'*****************************

Sub TurnTableState()
    ttSpinner.MotorOn = GetPlayerState(MODE_MULTIBALL)
End Sub

Sub StartTurnTable(interval)
    ttSpinner.MotorOn = True
    DiscMotor.Enabled = True
    DiscMotor.Interval = interval
End Sub

Sub DiscMotor_Timer()
    DiscMotor.Enabled = False
    ttSpinner.MotorOn = False
End Sub