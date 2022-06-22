Sub timerRampDiverter_Timer()
	DiverterP002.RotZ=DiverterP002.RotZ+DiverterDir
	If DiverterP002.RotZ>0 AND DiverterDir=1 Then Me.Enabled=0:DiverterP002.RotZ=0
	If DiverterP002.RotZ<-60 AND DiverterDir=-1 Then Me.Enabled=0:DiverterP002.RotZ=-60
End Sub