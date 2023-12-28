
Function CalculateBonus
    CalculateBonus = 10
End Function

'****************************
' BonusSkip
' Event Listeners:          
RegisterPinEvent SWITCH_BOTH_FLIPPERS_PRESSED, "BonusSkip"
'
'*****************************
Sub BonusSkip()
    If GameTimers(GAME_BONUS_TIMER_IDX) > 0 Then
        GameTimers(GAME_BONUS_TIMER_IDX) = 0.1
    End If
End Sub