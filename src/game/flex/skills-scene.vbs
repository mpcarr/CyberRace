


Sub InitDMDSkillsScene()
End Sub

Sub FlexDMDSkillsScene()	
    Dim qItem : Set qItem = New QueueItem
    Dim font
    Set font = FlexDMD.NewFont(DMDFontMain, RGB(206, 0, 255), RGB(0, 0, 0), 0)
    With qItem
        .Name = "skills"
        .Duration = 2
        .BGImage = "BG002"
        .BGVideo = "novideo"
    End With
    qItem.AddLabel "GetPlayerState(SKILLS_TRIAL_SPINS)", 		font12, DMDWidth*.2, DMDHeight/2, DMDWidth*.2, DMDHeight/2, "blink"
    qItem.AddLabel "SKILLS", 		font12, DMDWidth*.7, DMDHeight*.3, DMDWidth*.7, DMDHeight*.3, ""
    qItem.AddLabel "(SKILLS_BASE_SPINS * GetPlayerState(SKILLS_TRIAL_ACTIVATIONS)) & "" Spins""", 		font7, DMDWidth*.7, DMDHeight*.8, DMDWidth*.7, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
End Sub