
'****************************
' Hyper Hit
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_HYPER, "SwitchHyper"
'
'*****************************
Sub SwitchHyper()
    If GetPlayerState(HYPER_PLAYED) = False Then
        AddScore POINTS_BASE
        If GetPlayerState(HYPER)+1 = 5 Then
            SetPlayerState HYPER, 0
           	Dim qItem : Set qItem = New QueueItem
            With qItem
                .Name = "hypermsg"
                .Duration = 2
                .BGImage = "BG001"
                .BGVideo = "novideo"
                .Action = "slidedown"
            End With
            
            lightCtrl.AddTableLightSeq "RGB", lSeqHyper
            SetPlayerState HYPER_LEVEL, GetPlayerState(HYPER_LEVEL)+1
            SetPlayerState HYPER_PLAYED, True
            If GetPlayerState(HYPER_LEVEL) = 1 Then
                SetPlayerState PF_MULTIPLIER, 2
                qItem.AddLabel "PLAYFIELD 2X SCORING", FlexDMD.NewFont(DMDFontSmall, RGB(255,127,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight/2, DMDWidth/2, DMDHeight/2, "blink"
                calloutsQ.Add "hyper", "PlayCallout(""playfield-2x"")", 1, 0, 0, 2000, 0, False
            ElseIf GetPlayerState(HYPER_LEVEL) = 2 Then
                SetPlayerState PF_MULTIPLIER, 3
                qItem.AddLabel "PLAYFIELD 3X SCORING", FlexDMD.NewFont(DMDFontSmall, RGB(255,127,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight/2, DMDWidth/2, DMDHeight/2, "blink"
                calloutsQ.Add "hyper", "PlayCallout(""playfield-3x"")", 1, 0, 0, 2000, 0, False
            ElseIf GetPlayerState(HYPER_LEVEL) = 3 Then
                SetPlayerState PF_MULTIPLIER, 5
                qItem.AddLabel "PLAYFIELD 5X SCORING", FlexDMD.NewFont(DMDFontSmall, RGB(255,127,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight/2, DMDWidth/2, DMDHeight/2, "blink"
                calloutsQ.Add "hyper", "PlayCallout(""playfield-5x"")", 1, 0, 0, 2000, 0, False
            End If
            DmdQ.Enqueue qItem
            
            calloutsQ.Add "hyperRelease", "GameTimers(GAME_MULTIPLIER_TIMER_IDX) = 30 : KickSwitch38()", 1, 0, 0, 1000, 0, False
        Else
            SetPlayerState HYPER, GetPlayerState(HYPER) + 1
            KickSwitch38()
        End If
    Else
        KickSwitch38()
    End If

End Sub

Sub KickSwitch38()
    lightCtrl.pulse l143, 0
    sw_38.Kick 0, 60, 1.36
    SoundSaucerKick 1, sw_38
End Sub

'****************************
' HyperModeTimerHurry
' Event Listeners:          
RegisterPinEvent GAME_MULTIPLIER_TIMER_HURRY, "HyperModeTimerHurry"
'
'*****************************
Sub HyperModeTimerHurry()
	Dim qItem : Set qItem = New QueueItem
	With qItem
		.Name = "hypermsg"
		.Duration = 2
		.BGImage = "BG003"
		.BGVideo = "novideo"
        .Action = "slideup"
	End With
	qItem.AddLabel "Multiplier Ends In 10 Secs", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
	DmdQ.Enqueue qItem
End Sub

'****************************
' HyperModeTimerEnded
' Event Listeners:          
    RegisterPinEvent GAME_MULTIPLIER_TIMER_ENDED, "HyperModeTimerEnded"
'
'*****************************
Sub HyperModeTimerEnded()
    SetPlayerState PF_MULTIPLIER, 0
    DmdQ.Dequeue "hypermsg"
End Sub