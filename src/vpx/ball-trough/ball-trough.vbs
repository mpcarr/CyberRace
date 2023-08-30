'*******************************************
'  ZDRA : Drain, Trough, and Ball Release, ballsave
'*******************************************

'TROUGH 
Sub swTrough1_Hit   : UpdateTrough : End Sub
Sub swTrough1_UnHit : UpdateTrough : End Sub
Sub swTrough2_Hit   : UpdateTrough : End Sub
Sub swTrough2_UnHit : UpdateTrough : End Sub
Sub swTrough3_Hit   : UpdateTrough : End Sub
Sub swTrough3_UnHit : UpdateTrough : End Sub
Sub swTrough4_Hit   : UpdateTrough : End Sub
Sub swTrough4_UnHit : UpdateTrough : End Sub
Sub swTrough5_Hit   : UpdateTrough : End Sub
Sub swTrough5_UnHit : UpdateTrough : End Sub


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
