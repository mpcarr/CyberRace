Function GetPlayerState(key)
    If IsNull(currentPlayer) Then
        Exit Function
    End If

    If playerState(currentPlayer).Exists(key)  Then
        GetPlayerState = playerState(currentPlayer)(key)
    Else
        GetPlayerState = Null
    End If
End Function

Function GetPlayerScore(player)
    dim p
    Select Case player
        Case 1:
            p = "PLAYER 1"
        Case 2:
            p = "PLAYER 2"
        Case 3:
            p = "PLAYER 3"
        Case 4:
            p = "PLAYER 4"
    End Select

    If playerState.Exists(p) Then
        GetPlayerScore = playerState(p)(SCORE)
    Else
        GetPlayerScore = 0
    End If
End Function


Function GetCurrentPlayerNumber()
    
    Select Case currentPlayer
        Case "PLAYER 1":
            GetCurrentPlayerNumber = 1
        Case "PLAYER 2":
            GetCurrentPlayerNumber = 2
        Case "PLAYER 3":
            GetCurrentPlayerNumber = 3
        Case "PLAYER 4":
            GetCurrentPlayerNumber = 4
    End Select
End Function



Function SetPlayerState(key, value)
    If IsNull(currentPlayer) Then
        Exit Function
    End If

    If IsArray(value) Then
        If Join(GetPlayerState(key)) = Join(value) Then
            Exit Function
        End If
        WriteToLog "Player State", key&": "&Join(value)
    Else
        If GetPlayerState(key) = value Then
            Exit Function
        End If
        WriteToLog "Player State", key&": "&value
    End If   
    
    If playerState(currentPlayer).Exists(key) Then
       playerState(currentPlayer).Remove key
    End If
    playerState(currentPlayer).Add key, value

    If IsArray(value) Then
        'AdvDebug.SendPlayerState key, Join(value)
    Else
        'AdvDebug.SendPlayerState key, value
    End If
    If playerEvents.Exists(key) Then
        Dim x
        For Each x in playerEvents(key).Keys()
            If playerEvents(key)(x) = True Then
                WriteToLog "Firing Player Event", key &": "&x
                ExecuteGlobal x
            End If
        Next
    End If
    
    SetPlayerState = Null
End Function

Sub RegisterPlayerStateEvent(e, v)
    If Not playerEvents.Exists(e) Then
        playerEvents.Add e, CreateObject("Scripting.Dictionary")
    End If
    playerEvents(e).Add v, True
End Sub

Sub EmitAllPlayerEvents()
    Dim key
    For Each key in playerState(currentPlayer).Keys()
        If playerEvents.Exists(key) Then
            Dim x
            For Each x in playerEvents(key).Keys()
                If playerEvents(key)(x) = True Then
                    ExecuteGlobal x
                End If
            Next
        End If
    Next
End Sub