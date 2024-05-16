

'****************************
' BonusSkip
' Event Listeners:          
AddPinEventListener SWITCH_BOTH_FLIPPERS_PRESSED, SWITCH_BOTH_FLIPPERS_PRESSED &   "BonusSkip",   "BonusSkip",  1000, Null
'
'*****************************
Sub BonusSkip()
    If GameTimers(GAME_BONUS_TIMER_IDX) > 0 Then
        GameTimers(GAME_BONUS_TIMER_IDX) = 0.1
    End If
End Sub