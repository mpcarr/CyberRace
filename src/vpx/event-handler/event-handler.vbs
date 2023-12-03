Sub DispatchPinEvent(e)
    If Not pinEvents.Exists(e) Then
        Exit Sub
    End If
    Dim x
    For Each x in pinEvents(e).Keys()
        If pinEvents(e)(x) = True Then
            WriteToLog "Dispatching Pin Event", e &": "&x
            ExecuteGlobal x
            AdvDebug.SendPinEvent e &": "&x
        End If
    Next
End Sub

Sub RegisterPinEvent(e, v)
    If Not pinEvents.Exists(e) Then
        pinEvents.Add e, CreateObject("Scripting.Dictionary")
    End If
    pinEvents(e).Add v, True
End Sub