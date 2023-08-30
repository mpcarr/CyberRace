
Sub FlexDMDBonusScene()
    'SetPlayerState FLEX_MODE, 8
    'Exit Sub
	Dim bonusRaces : Set bonusRaces = New QueueItem
    With bonusRaces
        .Name = "bonus_races"
        .Duration = 2
        .Title = """RACES WON: "" & GetPlayerState(BONUS_RACES_WON) & "" x 100K"""
        .Message = "FormatScore(GetPlayerState(BONUS_RACES_WON) * 100000)"
        .Font = FlexDMD.NewFont("FONTS/sendha20.fnt", RGB(255, 0, 0), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noslide2"
        .BGImage = "BG001"
        .BGVideo = "novideo"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus1"
    End With
    DmdQ.Enqueue bonusRaces

	Dim bonusNodes : Set bonusNodes = New QueueItem
    With bonusNodes
        .Name = "bonus_nodes"
        .Duration = 2
        .Title = """NODES COMPLETED: "" & GetPlayerState(BONUS_NODES_COMPLETED) & "" x 75K"""
        .Message = "FormatScore(GetPlayerState(BONUS_NODES_COMPLETED) * 75000)"
        .Font = FlexDMD.NewFont("FONTS/sendha20.fnt", RGB(124, 255, 1), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noslide2"
        .BGImage = "BG001"
        .BGVideo = "novideo"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus2"
    End With
    DmdQ.Enqueue bonusNodes

	Dim bonusSkills : Set bonusSkills = New QueueItem
    With bonusSkills
        .Name = "bonus_skills"
        .Duration = 2
        .Title = """SKILLS TRAIL: "" & GetPlayerState(BONUS_NODES_COMPLETED) & "" x 75K"""
        .Message = "xxx"
        .Font = FlexDMD.NewFont("FONTS/sendha20.fnt", RGB(255, 243, 137), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noslide2"
        .BGImage = "BG001"
        .BGVideo = "novideo"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus3"
    End With
    DmdQ.Enqueue bonusSkills

	Dim bonusTT : Set bonusTT = New QueueItem
    With bonusTT
        .Name = "bonus_tt"
        .Duration = 2
        .Title = """TIME TRAIL: "" & GetPlayerState(BONUS_NODES_COMPLETED) & "" x 75K"""
        .Message = "xxx"
        .Font = FlexDMD.NewFont("FONTS/sendha20.fnt", RGB(206, 0, 255), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noslide2"
        .BGImage = "BG001"
        .BGVideo = "novideo"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus4"
    End With
    DmdQ.Enqueue bonusTT

	Dim bonusCombos : Set bonusCombos = New QueueItem
    With bonusCombos
        .Name = "bonus_combos"
        .Duration = 2
        .Title = """COMBOS: "" & GetPlayerState(BONUS_COMBOS_MADE) & "" x 50K"""
        .Message = "FormatScore(GetPlayerState(BONUS_COMBOS_MADE) * 50000)"
        .Font = FlexDMD.NewFont("FONTS/sendha20.fnt", RGB(255, 17, 120), RGB(0, 0, 0), 0)
        .StartPos = Array(128,32)
        .EndPos = Array(128,32)
        .Action = "noslide2"
        .BGImage = "BG001"
        .BGVideo = "novideo"
		.Callback = "PlaySound(""fx-bonus"") : lightCtrl.AddTableLightSeq ""Bonus"", lSeqBonus5"
    End With
    DmdQ.Enqueue bonusCombos
	
	AddScore(GetPlayerState(BONUS_COMBOS_MADE) * 50000)
	AddScore(GetPlayerState(BONUS_RACES_WON) * 100000)
	AddScore(GetPlayerState(BONUS_NODES_COMPLETED) * 75000)

End Sub