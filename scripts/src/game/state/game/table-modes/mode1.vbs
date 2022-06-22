' Mode 1 - Left Return Shot.
' X Shots Starts a 3 Way Combo
' Post Pops up on left inlane
' Shot 1 - Right Ramp
' Shot 2 - Left Orbit
' Shot 3 - Left Ramp.
' Awards at Left Inlane.
Sub GameAdvanceMode1()

    gameState("game")("mode1Hits") = gameState("game")("mode1Hits") + 1
    If gameState("game")("mode1Hits") > Min(5 * (gameState("game")("mode1TimesRan")+1),15) Then
        'start mode
        MsgBox("Start Mode 1")
        gameState("game")("mode1Hits") = 0
        gameState("game")("mode1TimesRan") = gameState("game")("mode1TimesRan")+1
    End If
    

End Sub