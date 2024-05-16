
'****************************
' Turn Table Off
' Event Listeners:          
    AddPlayerStateEventListener MODE_MULTIBALL, MODE_MULTIBALL &   "TurnTableState",   "TurnTableState",  1000, Null
'*****************************

Sub TurnTableState()
    ttSpinner.MotorOn = GetPlayerState(MODE_MULTIBALL)
End Sub

Sub TimerStartTurnTable
    StartTurnTable 5000
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