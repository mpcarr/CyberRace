
Sub FlexDMDBonusScene()
    'SetPlayerState FLEX_MODE, 8
    'Exit Sub
	Dim bonusRaces : Set bonusRaces = New QueueItem
    With bonusRaces
        .Name = "bonus_races"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus1"
		.Callback = "CallbackBonus1"
        .Replacements = Array("DMDLabelBonusRacesWon", "DMDLabelBonusRacesScore")
    End With
    bonusRaces.AddLabel "RACE SHOTS: $1 x 100K", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusRaces.AddLabel "$2", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusRaces

	Dim bonusNodes : Set bonusNodes = New QueueItem
    With bonusNodes
        .Name = "bonus_nodes"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus2"
		.Callback = "CallbackBonus2"
        .Replacements = Array("DMDLabelBonusNodes", "DMDLabelBonusNodesScore")
    End With
    bonusNodes.AddLabel "NODES: $1 x 75K", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusNodes.AddLabel "$2", 		                   Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusNodes

	Dim bonusSkills : Set bonusSkills = New QueueItem
    With bonusSkills
        .Name = "bonus_skills"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus3"
		.Callback = "CallbackBonus3"
        .Replacements = Array("DMDLabelBonusSkills", "DMDLabelBonusSkillsScore")
    End With
    bonusSkills.AddLabel "SKILLS TRIAL: $1 x 90K", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusSkills.AddLabel "$2", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusSkills

	Dim bonusTT : Set bonusTT = New QueueItem
    With bonusTT
        .Name = "bonus_tt"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus4"
		.Callback = "CallbackBonus4"
        .Replacements = Array("DMDLabelBonusTT", "DMDLabelBonusTTScore")
    End With
    bonusTT.AddLabel "TIME TRIAL: $1 x 75K", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusTT.AddLabel "$2", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusTT

	Dim bonusCombos : Set bonusCombos = New QueueItem
    With bonusCombos
        .Name = "bonus_combos"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus5"
		.Callback = "CallbackBonus5"
        .Replacements = Array("DMDLabelBonusCombos", "DMDLabelBonusCombosScore")
    End With
    bonusCombos.AddLabel "COMBOS: $1 x 50K", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusCombos.AddLabel "$2", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusCombos

End Sub

Function DMDLabelBonusRacesWon
    DMDLabelBonusRacesWon = GetPlayerState(BONUS_RACES_WON)
End Function
Function DMDLabelBonusRacesScore
    DMDLabelBonusRacesScore = FormatScore(GetPlayerState(BONUS_RACES_WON) * 100000)
End Function

Function DMDLabelBonusNodes
    DMDLabelBonusNodes = GetPlayerState(BONUS_NODES_COMPLETED)
End Function
Function DMDLabelBonusNodesScore
    DMDLabelBonusNodesScore = FormatScore(GetPlayerState(BONUS_NODES_COMPLETED) * 75000)
End Function

Function DMDLabelBonusSkills
    DMDLabelBonuSkills = GetPlayerState(BONUS_SKILLS_COMPLETED)
End Function
Function DMDLabelBonusSkillsScore
    DMDLabelBonusSkillsScore = FormatScore(GetPlayerState(BONUS_SKILLS_COMPLETED) * 90000)
End Function

Function DMDLabelBonusTT
    DMDLabelBonusTT = GetPlayerState(BONUS_TT_COMPLETED)
End Function
Function DMDLabelBonusTTScore
    DMDLabelBonusTTScore = FormatScore(GetPlayerState(BONUS_TT_COMPLETED) * 75000)
End Function

Function DMDLabelBonusCombos
    DMDLabelBonusCombos = GetPlayerState(BONUS_COMBOS_MADE)
End Function
Function DMDLabelBonusCombosScore
    DMDLabelBonusCombosScore = FormatScore(GetPlayerState(BONUS_COMBOS_MADE) * 50000)
End Function

Sub CallbackBonus1
    PlaySound(OptionsBonusSound)
    lightCtrl.AddTableLightSeq "Bonus", lSeqBonus1
End Sub
Sub CallbackBonus2
    PlaySound(OptionsBonusSound)
    lightCtrl.AddTableLightSeq "Bonus", lSeqBonus2
End Sub
Sub CallbackBonus3
    PlaySound(OptionsBonusSound)
    lightCtrl.AddTableLightSeq "Bonus", lSeqBonus3
End Sub
Sub CallbackBonus4
    PlaySound(OptionsBonusSound)
    lightCtrl.AddTableLightSeq "Bonus", lSeqBonus4
End Sub
Sub CallbackBonus5
    PlaySound(OptionsBonusSound)
    lightCtrl.AddTableLightSeq "Bonus", lSeqBonus5
End Sub