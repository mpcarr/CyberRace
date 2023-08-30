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
        FlexDMDNodeScene()
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
        FlexDMDNodeScene()
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
        FlexDMDNodeScene()
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
    If GetPlayerState(NODE_LEVEL_UP_READY) = True And GetPlayerState(MODE_MULTIBALL) = False Then
        SetPlayerState NODE_LEVEL_UP_READY, False
        SetPlayerState NODE_LEVEL, GetPlayerState(NODE_LEVEL) + 1
        'TODO: Award Perk
        'TODO: Light Show
        lSeqCollectPerk.Repeat = True
        calloutsQ.Add "nodes-choose-perk", "PlayCallout(""nodes-choose-perk"")", 1, 0, 0, 1660, 0, False
        lightCtrl.AddTableLightSeq "Nodes", lSeqCollectPerk
        SetPlayerState MODE_PERK_SELECT, True
        FlexDMDNodePerkCollectScene()
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
        Select Case GetPlayerState(NODE_LEVEL):
            Case 2: 'Level 1.  Increase Jackpot 250K OR 5 Million
                SetPlayerState JACKPOT_VALUE, GetPlayerState(JACKPOT_VALUE) + 250000
            Case 3:'Level 2.  Race Timers + 20 Seconds OR Instant MB
                SetPlayerState RACE_TIMERS, 80
            Case 4:'Level 3. Outlane BallSave OR Award Ball Lock
                'TODO Code outlane ball saves.
            Case 5:'Level 4. Extra Ball
                SetPlayerState EXTRA_BALLS, GetPlayerState(EXTRA_BALLS) + 1
            Case 6:'Level 5. 5x Playfield (30 secs) OR Add a Ball
                SetPlayerState PF_MULTIPLIER, 5
            Case 7:'Level 6. Node Grid Wizard Mode
                'TODO - Node Grid Wizard Mode
                SetPlayerState NODE_COMPLETED, True
        End Select
        SetPlayerState MODE_PERK_SELECT, False
        NodePerkNextLevel()
        lightCtrl.RemoveTableLightSeq "Nodes", lSeqCollectPerk
        sw39.TimerEnabled = True
        DMDModeUpdate.Enabled = 0
        DMDModeUpdate.Enabled = 1
        DMDModeUpdate.Interval = 100
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
                AddScore((GetPlayerState(BONUS_COMBOS_MADE) * 50000) *5)
	            AddScore((GetPlayerState(BONUS_RACES_WON) * 100000) * 5)
	            AddScore((GetPlayerState(BONUS_NODES_COMPLETED) * 75000) * 5)
            Case 4:'Level 3. Collect 5x Bonus OR Instant MB
                SetPlayerState MODE_MULTIBALL, True
                ballsInQ = ballsInQ + 2
        		BallReleaseTimer.Enabled = True
                lightCtrl.AddShot "MBSpinner", l48, RGB(0,255,0)
                lightCtrl.AddShot "MBLeftOrbit", l46, RGB(0,255,0)
                lightCtrl.AddShot "MBLeftRamp", l47, RGB(0,255,0)
                lightCtrl.AddShot "MBRightRamp", l64, RGB(0,255,0)
                lightCtrl.AddShot "MBRightOrbit", l63, RGB(0,255,0)
                EnableBallSaver 15
            Case 5:'Level 4. Extra Ball
                AddScore((GetPlayerState(BONUS_COMBOS_MADE) * 50000) * 10)
	            AddScore((GetPlayerState(BONUS_RACES_WON) * 100000) * 10)
	            AddScore((GetPlayerState(BONUS_NODES_COMPLETED) * 75000) * 10)
            Case 6:'Level 5. 5x Playfield (30 secs) OR 10x Bonus
                ' TODO Code Spot Grand Slam
            Case 7:'Level 6. Node Grid Wizard Mode
                'TODO - Node Grid Wizard Mode
                SetPlayerState NODE_COMPLETED, True
        End Select
        SetPlayerState MODE_PERK_SELECT, False
        NodePerkNextLevel()
        sw39.TimerEnabled = True
        DMDModeUpdate.Enabled = 0
        DMDModeUpdate.Enabled = 1
        DMDModeUpdate.Interval = 100
        lightCtrl.RemoveTableLightSeq "Nodes", lSeqCollectPerk
    End If
End Sub

Sub NodePerkNextLevel

    Select Case GetPlayerState(NODE_LEVEL):
        Case 2: 'Level 1.  Increase Jackpot 250K OR 5 Million
            SetPlayerState NODE_ROW_A, Array(0,1,0,1,0)
            SetPlayerState NODE_ROW_B, Array(0,1,1,0,1)
            SetPlayerState NODE_ROW_C, Array(0,0,1,0,0)
        Case 3:'Level 2.  Race Timers + 20 Seconds OR Instant MB
            SetPlayerState NODE_ROW_A, Array(0,1,0,1,1)
            SetPlayerState NODE_ROW_B, Array(1,1,1,0,0)
            SetPlayerState NODE_ROW_C, Array(0,0,1,0,1)
        Case 4:'Level 3. Collect 5x Bonus OR Award Ball Lock
            SetPlayerState NODE_ROW_A, Array(1,1,0,1,1)
            SetPlayerState NODE_ROW_B, Array(1,1,1,0,1)
            SetPlayerState NODE_ROW_C, Array(0,1,1,0,1)
        Case 5:'Level 4. Extra Ball
            SetPlayerState NODE_ROW_A, Array(1,1,1,1,1)
            SetPlayerState NODE_ROW_B, Array(1,1,1,1,1)
            SetPlayerState NODE_ROW_C, Array(0,1,1,0,1)
        Case 6:'Level 5. 5x Playfield (30 secs) OR Add a Ball
            SetPlayerState NODE_ROW_A, Array(1,1,1,1,1)
            SetPlayerState NODE_ROW_B, Array(1,1,1,1,1)
            SetPlayerState NODE_ROW_C, Array(1,1,1,1,1)
        Case 7:'Level 6. Node Grid Wizard Mode
            SetPlayerState NODE_ROW_A, Array(2,2,2,2,2)
            SetPlayerState NODE_ROW_B, Array(2,2,2,2,2)
            SetPlayerState NODE_ROW_C, Array(2,2,2,2,2)
            SetPlayerState NODE_COMPLETED, True
    End Select

End Sub
