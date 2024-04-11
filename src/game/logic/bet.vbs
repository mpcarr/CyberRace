
'****************************
' Bet 1
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_BET1, "SwitchBet1Hit"
'
'*****************************
Sub SwitchBet1Hit()
    If GetPlayerState(MODE_BET) = False And GetPlayerState(MODE_RACE) = False And GetPlayerState(BET_1) = 2 Then
        SetPlayerState BET_1, 1
        AddScore POINTS_BASE
        PlaySoundAtLevelStatic "fx_bet", SoundFxLevel, sw21
        lightCtrl.AddLightSeq "BoostUp", lSeqBetHit
        FlexDMDBetScene "blink", "", ""
        SetPlayerState BET_HITS, GetPlayerState(BET_HITS) + 1
    End If
End Sub

'****************************
' Bet 2
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_BET2, "SwitchBet2Hit"
'
'*****************************
Sub SwitchBet2Hit()
    If GetPlayerState(MODE_BET) = False And GetPlayerState(MODE_RACE) = False And GetPlayerState(BET_2) = 2 Then
        SetPlayerState BET_2, 1
        AddScore POINTS_BASE
        PlaySoundAtLevelStatic "fx_bet", SoundFxLevel, sw22
        lightCtrl.AddLightSeq "BoostUp", lSeqBetHit
        FlexDMDBetScene "", "blink", ""
        SetPlayerState BET_HITS, GetPlayerState(BET_HITS) + 1
    End If
End Sub

'****************************
' Bet 3
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_BET3, "SwitchBet3Hit"
'
'*****************************
Sub SwitchBet3Hit()
    If GetPlayerState(MODE_BET) = False And GetPlayerState(MODE_RACE) = False And GetPlayerState(BET_3) = 2 Then
        SetPlayerState BET_3, 1
        AddScore POINTS_BASE
        PlaySoundAtLevelStatic "fx_bet", SoundFxLevel, sw23
        lightCtrl.AddLightSeq "BoostUp", lSeqBetHit
        FlexDMDBetScene "", "", "blink"
        SetPlayerState BET_HITS, GetPlayerState(BET_HITS) + 1
    End If
End Sub

'****************************
' Check Bet Hits
' Event Listeners:          
    RegisterPlayerStateEvent BET_HITS, "CheckBetHits"
'
'*****************************

Sub CheckBetHits()
    If GetPlayerState(MODE_BET) = False Then
        If GetPlayerState(BET_HITS) = (3 * GetPlayerState(BET_ACTIVATIONS)) Then
            SetPlayerState MODE_BET, True
            GameTimers(GAME_BET_TIMER_IDX) = 30
            FlexDMDBetModeScene()
            calloutsQ.Add "bet-hurry", "PlayCallout(""bet-hurry-mode"")", 1, 0, 0, 4000, 0, False
            lightCtrl.AddLightSeq "BetMode", lSeqBetMode
            SetPlayerState BET_HITS, 0
            SetPlayerState BET_ACTIVATIONS, GetPlayerState(BET_ACTIVATIONS) + 1
            SetPlayerState BET_VALUE, 100000
            SetPlayerState BET_1, 0
            SetPlayerState BET_2, 0
            SetPlayerState BET_3, 0
            DmdQ.Dequeue "betmsg"
            lightCtrl.AddShot "BetSpinner1",    l48, RGB(255,242,5)
            lightCtrl.AddShot "BetSpinner2",    l23, RGB(255,242,5)
            lightCtrl.AddShot "BetCollect",     l64, RGB(255,242,5)
        ElseIf GetPlayerState(BET_1) = 1 AND  GetPlayerState(BET_2) = 1 AND  GetPlayerState(BET_3) = 1 Then
            SetPlayerState BET_1, 2
            SetPlayerState BET_2, 2
            SetPlayerState BET_3, 2
           	Dim qItem : Set qItem = New QueueItem
            With qItem
                .Name = "betmsg"
                .Duration = 4
                .BGImage = "BG003"
                .BGVideo = "novideo"
                .Action = "slideup"
                .Replacements = Array("GetDMDLabelBetActivations")
            End With
            qItem.AddLabel "$1 MORE HITS FOR MODE", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub


Function GetDMDLabelBetActivations()
    GetDMDLabelBetActivations = (3*GetPlayerState(BET_ACTIVATIONS)) - GetPlayerState(BET_HITS)
End Function

'****************************
' Bet Mode Spinner Hit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_SPINNER1, "BetModeSpinnerHit"
    RegisterPinEvent SWITCH_HIT_SPINNER2, "BetModeSpinnerHit"
'
'*****************************
Sub BetModeSpinnerHit()
    If GetPlayerState(MODE_BET) = True Then
        AddScore POINTS_SPINNER 
        SetPlayerState BET_VALUE, GetPlayerState(BET_VALUE) + (POINTS_BET_SPIN * GetPlayerState(BET_MULTIPLIER))
        Dim qItem : Set qItem = New QueueItem
        With qItem
            .Name = "bet-mode"
            .Duration = 2
            .BGImage = "BG001"
            .BGVideo = "novideo"
            .Replacements = Array("GetDMDLabelBetValue")
        End With
        qItem.AddLabel "BET INCREASED", 		                        Font5, DMDWidth/2, DMDHeight*.3, DMDWidth/2, DMDHeight*.3, ""
        qItem.AddLabel "$1", 		Font12, DMDWidth/2, DMDHeight*.7, DMDWidth/2, DMDHeight*.7, "blink"
   
        DmdQ.Enqueue qItem
    End If
End Sub

Function GetDMDLabelBetValue()
    GetDMDLabelBetValue = FormatScore(GetPlayerState(BET_VALUE))
End Function

'****************************
' Bet Mode Collect Hit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "BetModeCollect"
'
'*****************************
Sub BetModeCollect()
    If GetPlayerState(MODE_BET) = True Then
        AddScore GetPlayerState(BET_VALUE)
        FlexDMDBetModeCollectedScene()
        SetPlayerState BET_VALUE, 0
        GameTimers(GAME_BET_TIMER_IDX) = 0        
        DmdQ.Dequeue "betmsg"
        SetPlayerState BET_1, 2
        SetPlayerState BET_2, 2
        SetPlayerState BET_3, 2
        SetPlayerState MODE_BET, False
        lightCtrl.RemoveShot "BetSpinner1", l48
        lightCtrl.RemoveShot "BetSpinner2", l23
        lightCtrl.RemoveShot "BetCollect", l64
        lightCtrl.AddTableLightSeq "RGB", lSeqBetUp
    End If
End Sub


'****************************
' BetModeTimerHurry
' Event Listeners:          
    RegisterPinEvent GAME_BET_TIMER_HURRY, "BetModeTimerHurry"
'
'*****************************
Sub BetModeTimerHurry()
	Dim qItem : Set qItem = New QueueItem
	With qItem
		.Name = "betmsg"
		.Duration = 10
		.BGImage = "BG003"
		.BGVideo = "novideo"
        .Action = "slideup"
	End With
	qItem.AddLabel "HURRY UP", FlexDMD.NewFont(DMDFontSmallBold, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
	DmdQ.Enqueue qItem
End Sub

'****************************
' BetModeTimerEnded
' Event Listeners:          
    RegisterPinEvent GAME_BET_TIMER_ENDED, "BetModeTimerEnded"
'
'*****************************
Sub BetModeTimerEnded()
    SetPlayerState BET_VALUE, 0
    SetPlayerState BET_1, 2
    SetPlayerState BET_2, 2
    SetPlayerState BET_3, 2
    SetPlayerState MODE_BET, False
    lightCtrl.RemoveShot "BetSpinner1", l48
    lightCtrl.RemoveShot "BetSpinner2", l23
    lightCtrl.RemoveShot "BetCollect", l64
    DmdQ.Dequeue "betmsg"
End Sub