
'****************************
' HitMystery
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_MYSTERY, "HitMystery"
'
'*****************************
Sub HitMystery()
    If lightCtrl.IsShotLit("mystery", l49) = False Then
        AddScore POINTS_BASE
        SetPlayerState MYSTERY_HITS, GetPlayerState(MYSTERY_HITS) + 1
        lightCtrl.Pulse l49, 0
        If GetPlayerState(MYSTERY_HITS) MOD 6 = 0 Then
            lightCtrl.AddShot "mystery", l49, RGB(0, 255, 0)
        End If
    Else
        'Collect Mystery
        lightCtrl.RemoveShot "mystery", l49
        Dim randomNumber
        AddScore POINTS_BASE
        randomNumber = Int((totalMysteryWeight * Rnd) + 1)
        Dim cumulativeWeight, selectedAward
        cumulativeWeight = 0
        For i = 0 To UBound(MysteryAwards)
            cumulativeWeight = cumulativeWeight + MysteryAwards(i, 1)
            If randomNumber <= cumulativeWeight Then
                selectedAward = i
                Exit For
            End If
        Next

        Select Case i
            Case 0
                AddScore 50000
            Case 1
                If GetPlayerState(BONUS_X) < 4 Then
                    SetPlayerState BONUS_X, GetPlayerState(BONUS_X) + 1
                End If
            Case 2
                DispatchPinEvent ADD_BALL
            Case 3
                If GetPlayerState(GRANDSLAM_RACES) = False And GetPlayerState(RACE_MODE_READY) = False And GetPlayerState(MODE_RACE) = False Then
                    SetPlayerState LANE_R, 1
                    SetPlayerState LANE_A, 1
                    SetPlayerState LANE_C, 1
                    SetPlayerState LANE_E, 1
                    SetPlayerState RACE_MODE_READY, True
                    lSeqRGBCircle.Color = GAME_RACE_COLOR
                    lightCtrl.AddTableLightSeq "RaceReady", lSeqRGBCircle
                    calloutsQ.Add "raceready", "PlayCallout(""raceready"")", 1, 0, 0, 2500, 0, False
                End If
            Case 4
                AddScore 100000
        End Select

        Dim qItem : Set qItem = New QueueItem
        With qItem
            .Name = "mysteryAward"
            .Duration = 5
            .BGImage = "BG004"
            .BGVideo = "Mystery" & CStr(i)
            .Action = "slideup"
        End With
        DmdQ.Enqueue qItem
    End If
End Sub