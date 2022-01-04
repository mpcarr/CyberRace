'***********************************************************************************************************************
'*****       Kickers                                          	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub consoleKicker_Hit()
    Dispatch SWITCH_HIT_CONSOLE, Null 
End Sub

Sub drain_Hit()
    drain.DestroyBall
    If UBound(GetBalls) = 1 Then
        DISPATCH GAME_END_OF_BALL, Null
    End If
End Sub