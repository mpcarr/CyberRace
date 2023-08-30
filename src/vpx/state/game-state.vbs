Function GetGameState(key)
    If gameState.Exists(key)  Then
        GetGameState = gameState(key)
    Else
        GetGameState = Null
    End If
End Function

Function SetGameState(key, value)
    If gameState.Exists(key)  Then
        gameState(key) = value
    Else
        gameState.Add key, value
    End If

    WriteToLog "Setting Game State", key &": "&value

    If gameEvents.Exists(key) Then
        Dim x
        For Each x in gameEvents(key).Keys()
            If gameEvents(key)(x) = True Then
                WriteToLog "Firing Pin Event", key &": "&x
                ExecuteGlobal x
            End If
        Next
    End If
    SetGameState = Null
End Function

Sub RegisterGameStateEvent(e, v)
    If Not gameEvents.Exists(e) Then
        gameEvents.Add e, CreateObject("Scripting.Dictionary")
    End If
    gameEvents(e).Add v, True
End Sub