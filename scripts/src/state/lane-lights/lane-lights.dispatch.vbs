'***********************************************************************************************************************
'*****  Lane Lights Dispatch                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const LIGHTB = 4

Sub RotateLaneLightsClockwise()

    Dim temp : temp = Lampz.State(90)
    Lampz.State(90) = Lampz.State(93)
    Lampz.State(93) = Lampz.State(92)
    Lampz.State(92) = Lampz.State(91)
    Lampz.State(91) = temp
    

End Sub

Sub RotateLaneLightsAntiClockwise()

    Dim temp : temp = Lampz.State(90)
    Lampz.State(90) = Lampz.State(91)
    Lampz.State(91) = Lampz.State(92)
    Lampz.State(92) = Lampz.State(93)
    Lampz.State(93) = temp
    
End Sub

Sub ResetLaneLights()
    Lampz.State(90) = 0
    Lampz.State(91) = 0
    Lampz.State(92) = 0
    Lampz.State(93) = 0
End Sub


'***********************************************************************************************************************

