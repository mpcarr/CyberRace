Sub FlexDMDSkillsScene()	
    Dim qItem : Set qItem = New QueueItem
    Dim font
    Set font = FlexDMD.NewFont(DMDFontMain, RGB(206, 0, 255), RGB(0, 0, 0), 0)
    With qItem
        .Name = "skills"
        .Duration = 2
        .BGImage = "BG002"
        .BGVideo = "novideo"
        .Replacements = Array("GetDMDLabelSkillsTrialSpins","GetDMDLabelSkillsTrialBaseSpins")
    End With
    qItem.AddLabel "$1", 		font12, DMDWidth*.2, DMDHeight/2, DMDWidth*.2, DMDHeight/2, "blink"
    qItem.AddLabel "SKILLS", 		font12, DMDWidth*.7, DMDHeight*.3, DMDWidth*.7, DMDHeight*.3, ""
    qItem.AddLabel "$2 Spins", 		font7, DMDWidth*.7, DMDHeight*.8, DMDWidth*.7, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
End Sub

Function GetDMDLabelSkillsTrialSpins()
    GetDMDLabelSkillsTrialSpins = GetPlayerState(SKILLS_TRIAL_SPINS)
End Function

Function GetDMDLabelSkillsTrialBaseSpins()
    GetDMDLabelSkillsTrialBaseSpins = (SKILLS_BASE_SPINS * GetPlayerState(SKILLS_TRIAL_ACTIVATIONS))
End Function