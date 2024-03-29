
Sub FlexDMDBonusScene()
    'SetPlayerState FLEX_MODE, 8
    'Exit Sub
	Dim bonusRaces : Set bonusRaces = New QueueItem
    With bonusRaces
        .Name = "bonus_races"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus1"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus1"
    End With
    bonusRaces.AddLabel """RACES WON: "" & GetPlayerState(BONUS_RACES_WON) & "" x 100K""", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusRaces.AddLabel "FormatScore(GetPlayerState(BONUS_RACES_WON) * 100000)", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusRaces

	Dim bonusNodes : Set bonusNodes = New QueueItem
    With bonusNodes
        .Name = "bonus_nodes"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus2"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus2"
    End With
    bonusNodes.AddLabel """NODES: "" & GetPlayerState(BONUS_NODES_COMPLETED) & "" x 75K""", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusNodes.AddLabel "FormatScore(GetPlayerState(BONUS_NODES_COMPLETED) * 75000)", 		                   Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusNodes

	Dim bonusSkills : Set bonusSkills = New QueueItem
    With bonusSkills
        .Name = "bonus_skills"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus3"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus3"
    End With
    bonusSkills.AddLabel """SKILLS TRAIL: "" & GetPlayerState(BONUS_NODES_COMPLETED) & "" x 75K""", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusSkills.AddLabel "xxx", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusSkills

	Dim bonusTT : Set bonusTT = New QueueItem
    With bonusTT
        .Name = "bonus_tt"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus4"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus4"
    End With
    bonusTT.AddLabel """TIME TRAIL: "" & GetPlayerState(BONUS_NODES_COMPLETED) & "" x 75K""", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusTT.AddLabel "xxx", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusTT

	Dim bonusCombos : Set bonusCombos = New QueueItem
    With bonusCombos
        .Name = "bonus_combos"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGBonus5"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus5"
    End With
    bonusCombos.AddLabel """COMBOS: "" & GetPlayerState(BONUS_COMBOS_MADE) & "" x 50K""", 		Font7, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
    bonusCombos.AddLabel "FormatScore(GetPlayerState(BONUS_COMBOS_MADE) * 50000)", 		        Font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue bonusCombos
	
	AddScore(GetPlayerState(BONUS_COMBOS_MADE) * 50000)
	AddScore(GetPlayerState(BONUS_RACES_WON) * 100000)
	AddScore(GetPlayerState(BONUS_NODES_COMPLETED) * 75000)

End Sub