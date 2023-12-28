Sub DispatchPinEvent(e)
    If Not pinEvents.Exists(e) Then
        Exit Sub
    End If
    If GameTilted = True And Not e = BALL_DRAIN Then
        Exit Sub
    End If
    Dim x
    If e=SWITCH_LEFT_FLIPPER_DOWN or _
    e=SWITCH_RIGHT_FLIPPER_DOWN or _
    e=SWITCH_LEFT_FLIPPER_UP or _
    e=SWITCH_RIGHT_FLIPPER_UP or _
    e=SWITCH_BOTH_FLIPPERS_PRESSED Then
    Else
        SetTimer "BallSearch", "BallSearch", 6000
    End If
    For Each x in pinEvents(e).Keys()
        If pinEvents(e)(x) = True Then
            WriteToLog "Dispatching Pin Event", e &": "&x
            ExecuteGlobal x
            'AdvDebug.SendPinEvent e &": "&x
        End If
    Next
End Sub

Sub RegisterPinEvent(e, v)
    If Not pinEvents.Exists(e) Then
        pinEvents.Add e, CreateObject("Scripting.Dictionary")
    End If
    pinEvents(e).Add v, True
End Sub