
'****************************
' Nodes Row A
' Event Listeners:      
    AddPlayerStateEventListener NODE_ROW_A, NODE_ROW_A &   "NodesRowA",   "NodesRowA",  1000, Null
'*****************************
Sub NodesRowA()
    Dim row : row = GetPlayerState(NODE_ROW_A)
    If IsNull(NodeColor(row(0))) Then
        lightCtrl.LightOff l06
    Else
        lightCtrl.LightOnWithColor l06, NodeColor(row(0))
    End If
    
    If IsNull(NodeColor(row(1))) Then
        lightCtrl.LightOff l04
    Else
        lightCtrl.LightOnWithColor l04, NodeColor(row(1))
    End If

    If IsNull(NodeColor(row(2))) Then
        lightCtrl.LightOff l03
    Else
        lightCtrl.LightOnWithColor l03, NodeColor(row(2))
    End If

    If IsNull(NodeColor(row(3))) Then
        lightCtrl.LightOff l02
    Else
        lightCtrl.LightOnWithColor l02, NodeColor(row(3))
    End If

    If IsNull(NodeColor(row(4))) Then
        lightCtrl.LightOff l01
    Else
        lightCtrl.LightOnWithColor l01, NodeColor(row(4))
    End If
End Sub


'****************************
' Nodes Row B
' Event Listeners:      
    AddPlayerStateEventListener NODE_ROW_B, NODE_ROW_B &   "NodesRowB",   "NodesRowB",  1000, Null
'*****************************
Sub NodesRowB()
    Dim row : row = GetPlayerState(NODE_ROW_B)
    If IsNull(NodeColor(row(0))) Then
        lightCtrl.LightOff l10
    Else
        lightCtrl.LightOnWithColor l10, NodeColor(row(0))
    End If
    
    If IsNull(NodeColor(row(1))) Then
        lightCtrl.LightOff l09
    Else
        lightCtrl.LightOnWithColor l09, NodeColor(row(1))
    End If

    If IsNull(NodeColor(row(2))) Then
        lightCtrl.LightOff l08
    Else
        lightCtrl.LightOnWithColor l08, NodeColor(row(2))
    End If

    If IsNull(NodeColor(row(3))) Then
        lightCtrl.LightOff l07
    Else
        lightCtrl.LightOnWithColor l07, NodeColor(row(3))
    End If

    If IsNull(NodeColor(row(4))) Then
        lightCtrl.LightOff l05
    Else
        lightCtrl.LightOnWithColor l05, NodeColor(row(4))
    End If
End Sub

'****************************
' Nodes Row C
' Event Listeners:      
    AddPlayerStateEventListener NODE_ROW_C, NODE_ROW_C &   "NodesRowC",   "NodesRowC",  1000, Null
'*****************************
Sub NodesRowC()
    Dim row : row = GetPlayerState(NODE_ROW_C)
    If IsNull(NodeColor(row(0))) Then
        lightCtrl.LightOff l15
    Else
        lightCtrl.LightOnWithColor l15, NodeColor(row(0))
    End If
    
    If IsNull(NodeColor(row(1))) Then
        lightCtrl.LightOff l14
    Else
        lightCtrl.LightOnWithColor l14, NodeColor(row(1))
    End If

    If IsNull(NodeColor(row(2))) Then
        lightCtrl.LightOff l13
    Else
        lightCtrl.LightOnWithColor l13, NodeColor(row(2))
    End If

    If IsNull(NodeColor(row(3))) Then
        lightCtrl.LightOff l12
    Else
        lightCtrl.LightOnWithColor l12, NodeColor(row(3))
    End If

    If IsNull(NodeColor(row(4))) Then
        lightCtrl.LightOff l11
    Else
        lightCtrl.LightOnWithColor l11, NodeColor(row(4))
    End If
End Sub

'****************************
' Nodes Level Up Ready
' Event Listeners:      
    AddPlayerStateEventListener NODE_LEVEL_UP_READY, NODE_LEVEL_UP_READY &   "NodeLevelUpReady",   "NodeLevelUpReady",  1000, Null
'*****************************
Sub NodeLevelUpReady()
    If GetPlayerState(NODE_LEVEL_UP_READY) = True Then
        lightCtrl.Blink l62
    Else
        lightCtrl.LightOff l62
    End If
End Sub



Function NodeColor(state)
    
    Select Case state:
        Case 0:
            NodeColor = Null
        Case 1:
            NodeColor = RGB(254,0,0)
        Case 2:
            NodeColor = RGB(124,255,1) 
    End Select
End Function