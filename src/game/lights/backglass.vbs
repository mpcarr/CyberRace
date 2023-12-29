
'****************************
' BGStartGame
' Event Listeners:  
RegisterPinEvent START_GAME,    "BGStartGame"
'
'*****************************
Sub BGStartGame()
    DOF 1, 1 'C
    DOF 2, 1 'Y
    DOF 3, 1 'B
    DOF 4, 1 'E
    DOF 5, 1 'R
    DOF 6, 1 'R
    DOF 7, 1 'A
    DOF 8, 1 'C
    DOF 9, 1 'E

    If timerQueue.Exists("BGAttract") Then
        timerQueue.Remove("BGAttract")
    End If
End Sub

'****************************
' BGStartAttract
' Event Listeners:          
RegisterPinEvent GAME_OVER, "BGStartAttract"
'
'*****************************
Dim BGAttractIndex : BGAttractIndex = 1
Sub BGStartAttract()
    DOF 1, 0 'C
    DOF 2, 0 'Y
    DOF 3, 0 'B
    DOF 4, 0 'E
    DOF 5, 0 'R
    DOF 6, 0 'R
    DOF 7, 0 'A
    DOF 8, 0 'C
    DOF 9, 0 'E

    BGAttractIndex = 1
    DOF BGAttractIndex, 1
    SetTimer "BGAttract", "BGAttractNext", 200
End Sub

Sub BGAttractNext()
    If gameStarted = False Then
        DOF BGAttractIndex, 0
        BGAttractIndex = BGAttractIndex + 1
        If BGAttractIndex = 10 Then
            BGAttractIndex = 1
        End If
        DOF BGAttractIndex, 1
        SetTimer "BGAttract", "BGAttractNext", 200
    End If
End Sub