Sub AutoPlungerDelay_Timer
	plungerIM.Strength = 45
	plungerIM.AutoFire
	SoundSaucerKick 1,swPlunger
	AutoPlungerDelay.Enabled = False
End Sub
