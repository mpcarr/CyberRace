'***********************************************************************************************************************
'*****  Lane Lights Dispatch                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub RotateLaneLightsClockwise()
    Dim temp : temp = gameState("laneLights")("leftOuter")
    gameState("laneLights")("leftOuter") = gameState("laneLights")("rightOuter")
    gameState("laneLights")("rightOuter") = gameState("laneLights")("rightInner")
    gameState("laneLights")("rightInner") = gameState("laneLights")("leftInner")
    gameState("laneLights")("leftInner") = temp
    CheckLaneLights()
End Sub

Sub RotateLaneLightsAntiClockwise()
    Dim temp : temp = gameState("laneLights")("leftOuter")
    gameState("laneLights")("leftOuter") = gameState("laneLights")("leftInner")
    gameState("laneLights")("leftInner") = gameState("laneLights")("rightInner")
    gameState("laneLights")("rightInner") = gameState("laneLights")("rightOuter")
    gameState("laneLights")("rightOuter") = temp
    CheckLaneLights()
End Sub

Sub ResetLaneLights()
    gameState("laneLights")("leftOuter") = 0
    gameState("laneLights")("leftInner") = 0
    gameState("laneLights")("rightInner") = 0
    gameState("laneLights")("rightOuter") = 0
    CheckLaneLights()
End Sub


'***********************************************************************************************************************

