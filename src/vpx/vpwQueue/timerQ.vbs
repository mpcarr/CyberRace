
' Create a dictionary to store the callbacks with their names and execution times
Dim timerQueue : Set timerQueue = CreateObject("Scripting.Dictionary")

' Function to add a callback to the queue
Sub SetTimer(name, callbackFunc, delayInMs)
    ' Calculate the execution time
    Dim executionTime
    executionTime = gametime + delayInMs
    ' Create a small dictionary to hold both the execution time and the callback function
    Dim cbDict
    Set cbDict = CreateObject("Scripting.Dictionary")
    cbDict.Add "executionTime", executionTime
    cbDict.Add "callbackFunc", callbackFunc
    
    If timerQueue.Exists(name) Then
        timerQueue.Remove(name)
    End If
    ' Add the callback information to the main timer queue dictionary with the name as the key
    timerQueue.Add name, cbDict
End Sub

Function TimerExists(name)
If timerQueue.Exists(name) Then
    TimerExists = True
Else
    TimerExists = False
End If
End Function

Sub Debounce(name, callbackFunc, delayInMs)
    SetTimer name, callbackFunc, delayInMs
End Sub

Sub TimerTick()
    Dim key, callbackInfo, callbacksToExecute, name
    Set callbacksToExecute = CreateObject("Scripting.Dictionary")
    
    ' Check each timer in the queue
    For Each key In timerQueue.Keys()
        Set callbackInfo = timerQueue(key)
        ' If the execution time has come or passed, mark it for execution
        If callbackInfo("executionTime") <= gametime Then
            callbacksToExecute.Add key, callbackInfo("callbackFunc")
        End If
    Next

    ' Execute and remove callbacks that are due
    For Each name In callbacksToExecute
        timerQueue.Remove(name)        
        ExecuteGlobal callbacksToExecute(name)
    Next
End Sub