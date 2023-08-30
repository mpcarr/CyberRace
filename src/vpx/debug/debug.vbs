Dim debugWorld : debugWorld = False

Sub ShowDebugRoom()
	debugWorld = True
	'Dim tblElement
	'For Each tblElement in Room_BM
	'	tblElement.Visible = False
	'Next
End Sub

Sub HideDebugRoom()
	Dim tblElement
	'For Each tblElement in Room_BM
	'	tblElement.Visible = True
	'Next
End Sub



'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
'/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
'\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
'/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
'  MANUAL BALLCONTROL
'\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
'/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
'\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\ /\
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
	' 

	Sub StartControl_Hit()
		 Set ControlBall = ActiveBall
		 contballinplay = true
	End Sub

	Dim bcup, bcdown, bcleft, bcright, contball, contballinplay, ControlBall, bcboost
	Dim bcvel, bcyveloffset, bcboostmulti

	bcboost = 1 'Do Not Change - default setting
	bcvel = 4 'Controls the speed of the ball movement
	bcyveloffset = -0.01 'Offsets the force of gravity to keep the ball from drifting vertically on the table, should be negative
	bcboostmulti = 3 'Boost multiplier to ball veloctiy (toggled with the B key)

	Sub BallControl_Timer()
		 If Contball and ContBallInPlay then
			  If bcright = 1 Then
				   ControlBall.velx = bcvel*bcboost
			  ElseIf bcleft = 1 Then
				   ControlBall.velx = - bcvel*bcboost
			  Else
				   ControlBall.velx=0
			  End If

			 If bcup = 1 Then
				  ControlBall.vely = -bcvel*bcboost
			 ElseIf bcdown = 1 Then
				  ControlBall.vely = bcvel*bcboost
			 Else
				  ControlBall.vely= bcyveloffset
			 End If
		 End If
	End Sub




Sub TestBonus()

	lightCtrl.AddTableLightSeq "Bonus", lSeqEndOfBallBonus1
    lightCtrl.AddTableLightSeq "Bonus", lSeqEndOfBallBonus2
    'PlayFlexDMD End Of Ball Bonus
    FlexDMDBonusScene()
End Sub

Sub TestMB()
	SetPlayerState MODE_MULTIBALL, True
	ballsInQ = ballsInQ + 2
	BallReleaseTimer.Enabled = True
	Dim light
	lightCtrl.AddShot "MBSpinner", l48, RGB(0,255,0)
	lightCtrl.AddShot "MBLeftOrbit", l46, RGB(0,255,0)
	lightCtrl.AddShot "MBLeftRamp", l47, RGB(0,255,0)
	lightCtrl.AddShot "MBRightRamp", l64, RGB(0,255,0)
	lightCtrl.AddShot "MBRightOrbit", l63, RGB(0,255,0)
End Sub

Sub TestLights
	lightCtrl.AddLightSeq "RaceMode", lSeqRgbRandomRed
	lightCtrl.AddLightSeq "RaceMode", lSeqRaceMode4Nodes
End Sub 