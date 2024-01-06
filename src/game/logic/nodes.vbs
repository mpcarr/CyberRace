'****************************
' Node Row A Hit
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_NODE_A, "NodeARowHit"
'
'*****************************
Sub NodeARowHit()
    Dim row : row = GetPlayerState(NODE_ROW_A)
    Dim success : success = False
    If row(4) = 1 Then
        SetPlayerState NODE_ROW_A, Array(row(0), row(1), row(2), row(3), 2)
        AddScore POINTS_BASE
        success = True
    Else
        If row(3) = 1 Then
            SetPlayerState NODE_ROW_A, Array(row(0), row(1), row(2), 2, row(4))
            AddScore POINTS_BASE
            success = True
        Else
            If row(2) = 1 Then
                SetPlayerState NODE_ROW_A, Array(row(0), row(1), 2, row(3), row(4))
                AddScore POINTS_BASE
                success = True
            Else
                If row(1) = 1 Then
                    SetPlayerState NODE_ROW_A, Array(row(0), 2, row(2), row(3), row(4))
                    AddScore POINTS_BASE
                    success = True
                Else
                    If row(0) = 1 Then
                        SetPlayerState NODE_ROW_A, Array(2, row(1), row(2), row(3), row(4))
                        AddScore POINTS_BASE
                        success = True
                    End If
                End If
            End If
        End If
    End If
    If success = True Then
        PlaySoundAt "fx_node_grid_hit", ActiveBall
        SetPlayerState BONUS_NODES_COMPLETED, GetPlayerState(BONUS_NODES_COMPLETED) + 1
    Else
       'PlaySoundAt "fx_node_grid_fail", ActiveBall
    End If
    CheckNodesComplete()
End Sub

'****************************
' Node Row B Hit
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_NODE_B, "NodeBRowHit"
'
'*****************************
Sub NodeBRowHit()
    Dim row : row = GetPlayerState(NODE_ROW_B)
    Dim success : success = False
    If row(4) = 1 Then
        SetPlayerState NODE_ROW_B, Array(row(0), row(1), row(2), row(3), 2)
        AddScore POINTS_BASE
        success = True
    Else
        If row(3) = 1 Then
            SetPlayerState NODE_ROW_B, Array(row(0), row(1), row(2), 2, row(4))
            AddScore POINTS_BASE
            success = True
        Else
            If row(2) = 1 Then
                SetPlayerState NODE_ROW_B, Array(row(0), row(1), 2, row(3), row(4))
                AddScore POINTS_BASE
                success = True
            Else
                If row(1) = 1 Then
                    SetPlayerState NODE_ROW_B, Array(row(0), 2, row(2), row(3), row(4))
                    AddScore POINTS_BASE
                    success = True
                Else
                    If row(0) = 1 Then
                        SetPlayerState NODE_ROW_B, Array(2, row(1), row(2), row(3), row(4))
                        AddScore POINTS_BASE
                        success = True
                    End If
                End If
            End If
        End If
    End If
    If success = True Then
        PlaySoundAt "fx_node_grid_hit", ActiveBall
        SetPlayerState BONUS_NODES_COMPLETED, GetPlayerState(BONUS_NODES_COMPLETED) + 1
    Else
       'PlaySoundAt "fx_node_grid_fail", ActiveBall
    End If
    CheckNodesComplete()
End Sub

'****************************
' Node Row C Hit
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_NODE_C, "NodeCRowHit"
'
'*****************************
Sub NodeCRowHit()
    Dim row : row = GetPlayerState(NODE_ROW_C)
    Dim success : success = False
    If row(4) = 1 Then
        SetPlayerState NODE_ROW_C, Array(row(0), row(1), row(2), row(3), 2)
        AddScore POINTS_BASE
        success = True
    Else
        If row(3) = 1 Then
            SetPlayerState NODE_ROW_C, Array(row(0), row(1), row(2), 2, row(4))
            AddScore POINTS_BASE
            success = True
        Else
            If row(2) = 1 Then
                SetPlayerState NODE_ROW_C, Array(row(0), row(1), 2, row(3), row(4))
                AddScore POINTS_BASE
                success = True
            Else
                If row(1) = 1 Then
                    SetPlayerState NODE_ROW_C, Array(row(0), 2, row(2), row(3), row(4))
                    AddScore POINTS_BASE
                    success = True
                Else
                    If row(0) = 1 Then
                        SetPlayerState NODE_ROW_C, Array(2, row(1), row(2), row(3), row(4))
                        AddScore POINTS_BASE
                        success = True
                    End If
                End If
            End If
        End If
    End If
    If success = True Then
        PlaySoundAt "fx_node_grid_hit", ActiveBall
        SetPlayerState BONUS_NODES_COMPLETED, GetPlayerState(BONUS_NODES_COMPLETED) + 1
    Else
       'PlaySoundAt "fx_node_grid_fail", ActiveBall
    End If
    CheckNodesComplete()
End Sub

Sub CheckNodesComplete
    Dim nodesA, nodesB, nodesC
    nodesA = GetPlayerState(NODE_ROW_A)
    nodesB = GetPlayerState(NODE_ROW_B)
    nodesC = GetPlayerState(NODE_ROW_C)
    Dim node
    For Each node in nodesA
        If node = 1 Then
            Exit Sub
        End If
    Next
    For Each node in nodesB
        If node = 1 Then
            Exit Sub
        End If
    Next
    For Each node in nodesC
        If node = 1 Then
            Exit Sub
        End If
    Next
    
    If GetPlayerState(NODE_COMPLETED) = False And GetPlayerState(NODE_LEVEL_UP_READY) = False Then
        lightCtrl.AddTableLightSeq "Nodes", lSeqNodesComplete
        SetPlayerState NODE_LEVEL_UP_READY, True
        FlexDMDNodesCompleteScene()
        calloutsQ.Add "node-complete", "PlayCallout(""node-complete"")", 1, 0, 0, 3113, 0, False
    End If
End Sub

'****************************
' Node Level Up Ready
' Event Listeners:      
    RegisterPinEvent SWITCH_HIT_SCOOP, "NodeCollectPerk"
'
'*****************************
Sub NodeCollectPerk()
    If GetPlayerState(NODE_LEVEL_UP_READY) = True And RealBallsInPlay = 1 Then
        SetPlayerState NODE_LEVEL_UP_READY, False
        SetPlayerState NODE_LEVEL, GetPlayerState(NODE_LEVEL) + 1
        If GetPlayerState(NODE_LEVEL) = 6 Then
            'COMPLETE
            Debounce "nodesCompleteed", "sw39.TimerEnabled = True", 4000
            SetPlayerState GRANDSLAM_NODES, True
            calloutsQ.Add "nodesGS", "PlayCallout(""nodes-grandslam"")", 1, 0, 0, 5500, 0, False
            PlayGrandSlamSeq()
        Else
            lSeqCollectPerk.Repeat = True
            DOF 301, DOFOn
            calloutsQ.Add "nodes-choose-perk", "PlayCallout(""nodes-choose-perk"")", 1, 0, 0, 1660, 0, False
            lightCtrl.AddTableLightSeq "Nodes", lSeqCollectPerk
            SetPlayerState MODE_PERK_SELECT, True
            FlexDMDNodePerkCollectScene()
        End If
    End If
End Sub

'****************************
' Node Perk Selection Timer Ended
' Event Listeners:      
    RegisterPinEvent GAME_SELECTION_TIMER_ENDED, "NodePerkSelectionTimerEnded"
'
'*****************************
Sub NodePerkSelectionTimerEnded()
    If GetPlayerState(MODE_PERK_SELECT) = True Then
        NodePerkSelectLeftPerk()
    End If
End Sub

'****************************
' NodePerkSelectLeftPerk
' Event Listeners:  
RegisterPinEvent SWITCH_LEFT_FLIPPER_DOWN, "NodePerkSelectLeftPerk"
'
'*****************************
Sub NodePerkSelectLeftPerk()

    If GetPlayerState(MODE_PERK_SELECT) = True Then
        Dim qItem
        Select Case GetPlayerState(NODE_LEVEL):
            Case 2: 'Level 2.  Increase Jackpot 250K OR 5 Million
                SetPlayerState JACKPOT_VALUE, GetPlayerState(JACKPOT_VALUE) + 250000
                Set qItem = New QueueItem
                With qItem
                    .Name = "nodemsg"
                    .Duration = 3
                    .BGImage = "BG005"
                    .BGVideo = "novideo"
                    .Action = "slideup"
                End With
                qItem.AddLabel """JACKPOTS: "" & FormatScore(GetPlayerState(JACKPOT_VALUE))", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
                DmdQ.Enqueue qItem
            Case 3:'Level 3.  Race Timers + 20 Seconds OR 2x Bet Hurry
                SetPlayerState RACE_TIMERS, 80
                Set qItem = New QueueItem
                With qItem
                    .Name = "nodemsg"
                    .Duration = 3
                    .BGImage = "BG005"
                    .BGVideo = "novideo"
                    .Action = "slideup"
                End With
                qItem.AddLabel """RACE TIMERS: "" & GetPlayerState(RACE_TIMERS) & "" Secs""", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
                DmdQ.Enqueue qItem
            Case 4:'Level 4. Outlane BallSave OR Instant MB
                SetPlayerState OUTLANE_SAVE, True
            Case 5:'Level 5. Extra Ball
                SetPlayerState EXTRA_BALLS, GetPlayerState(EXTRA_BALLS) + 1
                FlexExtraBallScene()
                PlayExtraBallSeq()
                calloutsQ.Add "extraball", "PlayCallout(""extraball"")", 1, 0, 0, 1000, 0, False
        End Select
        SetPlayerState MODE_PERK_SELECT, False
        NodePerkNextLevel()
        GameTimers(GAME_SELECTION_TIMER_IDX) = 0
        DmdQ.Dequeue "nodes"
        lightCtrl.RemoveTableLightSeq "Nodes", lSeqCollectPerk
        DOF 301, DOFOff
        sw39.TimerEnabled = True
    End iF

End Sub

'****************************
' NodePerkSelectRightPerk
' Event Listeners:  
RegisterPinEvent SWITCH_RIGHT_FLIPPER_DOWN, "NodePerkSelectRightPerk"
'
'*****************************
Sub NodePerkSelectRightPerk()
    If GetPlayerState(MODE_PERK_SELECT) = True Then
        Select Case GetPlayerState(NODE_LEVEL):
            Case 2: 'Level 1.  Increase Jackpot 250K OR 5 Million
                AddScore 5000000
            Case 3:'Level 2.  Race Timers + 20 Seconds OR 5x Bonus
                 SetPlayerState BET_MULTIPLIER, 2
            Case 4:'Level 3. outlane save OR Instant MB
                SetPlayerState MODE_MULTIBALL, True
                ballsInQ = ballsInQ + 2
        		BallReleaseTimer.Enabled = True
                lightCtrl.AddShot "MBSpinner", l48, RGB(0,255,0)
                lightCtrl.AddShot "MBLeftOrbit", l46, RGB(0,255,0)
                lightCtrl.AddShot "MBLeftRamp", l47, RGB(0,255,0)
                lightCtrl.AddShot "MBRightRamp", l64, RGB(0,255,0)
                lightCtrl.AddShot "MBRightOrbit", l63, RGB(0,255,0)
                EnableBallSaver 15
            Case 5:'Level 5. 5X Jackpots
                SetPlayerState JACKPOTS_MULTIPLIER, 5
        End Select
        SetPlayerState MODE_PERK_SELECT, False
        NodePerkNextLevel()
        GameTimers(GAME_SELECTION_TIMER_IDX) = 0
        DmdQ.Dequeue "nodes"
        sw39.TimerEnabled = True
        DOF 301, DOFOff
        lightCtrl.RemoveTableLightSeq "Nodes", lSeqCollectPerk
    End If
End Sub

Sub NodePerkNextLevel

    Select Case GetPlayerState(NODE_LEVEL):
        Case 2: 
            SetPlayerState NODE_ROW_A, Array(0,1,0,1,0)
            SetPlayerState NODE_ROW_B, Array(0,1,1,0,1)
            SetPlayerState NODE_ROW_C, Array(0,0,1,0,0)
        Case 3:
            SetPlayerState NODE_ROW_A, Array(0,1,0,1,1)
            SetPlayerState NODE_ROW_B, Array(1,1,1,0,0)
            SetPlayerState NODE_ROW_C, Array(0,0,1,0,1)
        Case 4:
            SetPlayerState NODE_ROW_A, Array(1,1,0,1,1)
            SetPlayerState NODE_ROW_B, Array(1,1,1,0,1)
            SetPlayerState NODE_ROW_C, Array(0,1,1,0,1)
        Case 5:
            SetPlayerState NODE_ROW_A, Array(1,1,1,1,1)
            SetPlayerState NODE_ROW_B, Array(1,1,1,1,1)
            SetPlayerState NODE_ROW_C, Array(0,1,1,0,1)
        Case 6:
            SetPlayerState NODE_ROW_A, Array(2,2,2,2,2)
            SetPlayerState NODE_ROW_B, Array(2,2,2,2,2)
            SetPlayerState NODE_ROW_C, Array(2,2,2,2,2)
            SetPlayerState NODE_COMPLETED, True
    End Select

End Sub
