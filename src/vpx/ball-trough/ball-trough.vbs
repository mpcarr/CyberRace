'*******************************************
'  ZDRA : Drain, Trough, and Ball Release, ballsave
'*******************************************

'TROUGH 
Sub swTrough1_Hit
	MPFController.Switch("0-0-3")=1
	UpdateTrough
End Sub
Sub swTrough1_UnHit
	MPFController.Switch("0-0-3")=0
	UpdateTrough
End Sub
Sub swTrough2_Hit
	MPFController.Switch("0-0-8")=1
	UpdateTrough
End Sub
Sub swTrough2_UnHit
	MPFController.Switch("0-0-8")=0
	UpdateTrough
End Sub
Sub swTrough3_Hit
	MPFController.Switch("0-0-9")=1
	UpdateTrough
End Sub
Sub swTrough3_UnHit
	MPFController.Switch("0-0-9")=0
	UpdateTrough
End Sub
Sub swTrough4_Hit
	MPFController.Switch("0-0-10")=1
	UpdateTrough
End Sub
Sub swTrough4_UnHit
	MPFController.Switch("0-0-10")=0
	UpdateTrough
End Sub
Sub swTrough5_Hit
	MPFController.Switch("0-0-11")=1
	UpdateTrough
End Sub
Sub swTrough5_UnHit
	MPFController.Switch("0-0-11")=0
	UpdateTrough
End Sub


Sub UpdateTrough
	UpdateTroughTimer.Interval = 300
	UpdateTroughTimer.Enabled = 1
End Sub

Sub UpdateTroughTimer_Timer
	If swTrough5.BallCntOver = 0 Then
		Drain.kick 57, 20
	End If
	If swTrough1.BallCntOver = 0 Then swTrough2.kick 50, 10
	If swTrough2.BallCntOver = 0 Then swTrough3.kick 50, 10
	If swTrough3.BallCntOver = 0 Then swTrough4.kick 50, 10
	If swTrough4.BallCntOver = 0 Then swTrough5.kick 50, 10
	UpdateTroughTimer.Enabled = 0
End Sub

Function BallsInTrough()
	dim bInTrough : bInTrough = 0
	If Drain.BallCntOver = 1 Then bInTrough = bInTrough + 1
	If swTrough1.BallCntOver = 1 Then bInTrough = bInTrough + 1
	If swTrough2.BallCntOver = 1 Then bInTrough = bInTrough + 1
	If swTrough3.BallCntOver = 1 Then bInTrough = bInTrough + 1
	If swTrough4.BallCntOver = 1 Then bInTrough = bInTrough + 1
	If swTrough5.BallCntOver = 1 Then bInTrough = bInTrough + 1
	BallsInTrough = bInTrough
End Function