
'****************************
' HiScore Selection Timer Ended
' Event Listeners:      
AddPinEventListener GAME_SELECTION_TIMER_ENDED, GAME_SELECTION_TIMER_ENDED &   "HiScoreSelectionTimerEnded",   "HiScoreSelectionTimerEnded",  1000, Null
'
'*****************************
Sub HiScoreSelectionTimerEnded()
    If GetPlayerState(MODE_HISCORE) = True Then
        
    End If
End Sub


'****************************
' HiScoreCycleLeft
' Event Listeners:  
    AddPinEventListener SWITCH_LEFT_FLIPPER_DOWN, SWITCH_LEFT_FLIPPER_DOWN &   "HiScoreCycleLeft",   "HiScoreCycleLeft",  1000, Null
'
'*****************************
Sub HiScoreCycleLeft()
    If GetPlayerState(MODE_HISCORE) = True Then
        If GetPlayerState(LETTER_POSITION) = 0 Then
            SetPlayerState LETTER_POSITION, 36
        Else
            SetPlayerState LETTER_POSITION, GetPlayerState(LETTER_POSITION) - 1
        End If
        Select Case GetPlayerState(INITIAL_POSITION):
            Case 0: 
                SetPlayerState INITIAL_1, GameHiScoreLetters(GetPlayerState(LETTER_POSITION))
            Case 1: 
                SetPlayerState INITIAL_2, GameHiScoreLetters(GetPlayerState(LETTER_POSITION))
            Case 2: 
                SetPlayerState INITIAL_3, GameHiScoreLetters(GetPlayerState(LETTER_POSITION))
        End Select  
    End IF
End Sub

'****************************
' HiScoreCycleRight
' Event Listeners:  
AddPinEventListener SWITCH_RIGHT_FLIPPER_DOWN, SWITCH_RIGHT_FLIPPER_DOWN &   "HiScoreCycleRight",   "HiScoreCycleRight",  1000, Null
'
'*****************************
Sub HiScoreCycleRight()
    If GetPlayerState(MODE_HISCORE) = True Then
        If GetPlayerState(LETTER_POSITION) = 36 Then
            SetPlayerState LETTER_POSITION, 0
        Else
            SetPlayerState LETTER_POSITION, GetPlayerState(LETTER_POSITION) + 1
        End If
        Select Case GetPlayerState(INITIAL_POSITION):
            Case 0: 
                SetPlayerState INITIAL_1, GameHiScoreLetters(GetPlayerState(LETTER_POSITION))
            Case 1: 
                SetPlayerState INITIAL_2, GameHiScoreLetters(GetPlayerState(LETTER_POSITION))
            Case 2: 
                SetPlayerState INITIAL_3, GameHiScoreLetters(GetPlayerState(LETTER_POSITION))
        End Select  
    End If
End Sub

'****************************
' HiScoreConfirm
' Event Listeners:  
    AddPinEventListener SWITCH_SELECT_EVENT_KEY, SWITCH_SELECT_EVENT_KEY &   "HiScoreConfirm",   "HiScoreConfirm",  1000, Null
'
'*****************************
Sub HiScoreConfirm()
    SetPlayerState INITIAL_POSITION, GetPlayerState(INITIAL_POSITION)+1
    If GetPlayerState(INITIAL_POSITION) = 3 Then
        DmdQ.RemoveAll()
    End If
End Sub