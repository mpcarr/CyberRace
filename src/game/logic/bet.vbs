
'****************************
' Bet 1
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_BET1, "SwitchBet1Hit"
'
'*****************************
Sub SwitchBet1Hit()
    If GetPlayerState(MODE_BET) = False And GetPlayerState(BET_1) = 2 Then
        SetPlayerState BET_1, 1
        PlaySoundAtLevelStatic "fx_bet", SoundFxLevel, sw21
        lightCtrl.AddLightSeq "BoostUp", lSeqBetHit
        FlexDMDBetBScene()
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
    If GetPlayerState(MODE_BET) = False And GetPlayerState(BET_2) = 2 Then
        SetPlayerState BET_2, 1
        PlaySoundAtLevelStatic "fx_bet", SoundFxLevel, sw22
        lightCtrl.AddLightSeq "BoostUp", lSeqBetHit
        FlexDMDBetEScene()
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
    If GetPlayerState(MODE_BET) = False And GetPlayerState(BET_3) = 2 Then
        SetPlayerState BET_3, 1
        PlaySoundAtLevelStatic "fx_bet", SoundFxLevel, sw23
        lightCtrl.AddLightSeq "BoostUp", lSeqBetHit
        FlexDMDBetTScene()
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
            calloutsQ.Add "bet-hurry", "PlayCallout(""bet-hurry-mode"")", 1, 0, 0, 4000, 0, False
            lightCtrl.AddLightSeq "BetMode", lSeqBetMode
            SetPlayerState BET_HITS, 0
            SetPlayerState BET_ACTIVATIONS, GetPlayerState(BET_ACTIVATIONS) + 1
            SetPlayerState BET_VALUE, 100000
            SetPlayerState BET_1, 0
            SetPlayerState BET_2, 0
            SetPlayerState BET_3, 0
            lightCtrl.AddShot "BetSpinner1",    l48, RGB(255,242,5)
            lightCtrl.AddShot "BetSpinner2",    l23, RGB(255,242,5)
            lightCtrl.AddShot "BetCollect",     l64, RGB(255,242,5)
        ElseIf GetPlayerState(BET_1) = 1 AND  GetPlayerState(BET_2) = 1 AND  GetPlayerState(BET_3) = 1 Then
            SetPlayerState BET_1, 2
            SetPlayerState BET_2, 2
            SetPlayerState BET_3, 2
        End If
    End If
End Sub

'****************************
' Bet Mode Spinner Hit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_SPINNER1, "BetModeSpinnerHit"
    RegisterPinEvent SWITCH_HIT_SPINNER2, "BetModeSpinnerHit"
'
'*****************************
Sub BetModeSpinnerHit()
    If GetPlayerState(MODE_BET) = True Then        
        SetPlayerState BET_VALUE, GetPlayerState(BET_VALUE) + POINTS_BET_SPIN
        Dim qItem : Set qItem = New QueueItem
        With qItem
            .Name = "betmode"
            .Duration = 2
            .Title = "BET VALUE INCREASED"
            .Message = "GetPlayerState(BET_VALUE)"
            .Font = FontCyber16_HURRYUP_COLOR
            .StartPos = Array(128,32)
            .EndPos = Array(128,32)
            .Action = "blink"
            .BGImage = "BG001"
            .BGVideo = "novideo"
        End With
        DmdQ.Enqueue qItem
    End If
End Sub

'****************************
' Bet Mode Collect Hit
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_RIGHT_RAMP, "BetModeCollect"
'
'*****************************
Sub BetModeCollect()
    If GetPlayerState(MODE_BET) = True Then
        AddScore GetPlayerState(BET_VALUE)
        SetPlayerState BET_VALUE, 0
        SetPlayerState BET_1, 2
        SetPlayerState BET_2, 2
        SetPlayerState BET_3, 2
        SetPlayerState MODE_BET, False
        lightCtrl.RemoveShot "BetSpinner1", l48
        lightCtrl.RemoveShot "BetSpinner2", l23
        lightCtrl.RemoveShot "BetCollect", l64
    End If
End Sub