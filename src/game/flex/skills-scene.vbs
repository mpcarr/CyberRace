


Sub InitDMDSkillsScene()
End Sub

Sub FlexDMDSkillsScene()	
	FlexPlayScene(DMDSkillsVid)
	DMDModeUpdate.Enabled = 0
    DMDModeUpdate.Enabled = 1
    DMDModeUpdate.Interval = DMDSkillsVid.Length*1000
End Sub