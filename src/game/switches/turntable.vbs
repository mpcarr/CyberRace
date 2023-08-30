Sub TurnTable_Hit
    ttSpinner.AddBall ActiveBall
    if ttSpinner.MotorOn=true then ttSpinner.AffectBall ActiveBall
End Sub
 
Sub TurnTable_unHit
	ttSpinner.RemoveBall ActiveBall
End Sub