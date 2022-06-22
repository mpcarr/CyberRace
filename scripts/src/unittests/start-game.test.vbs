	
StartGame()

tr.assert_equal gameState("game")("playerName"), "Player 1", "Should be Player 1"
tr.assert_equal gameState("game")("playerBall"), 1, "Should be ball 1"
tr.assert_equal LockPin.IsDropped, False, "Should be False"
tr.assert_equal gameState("laneLights")("leftOuter"), 0, "Should be off"
tr.assert_equal gameState("laneLights")("leftInner"), 0, "Should be off"
tr.assert_equal gameState("laneLights")("rightInner"), 0, "Should be off"
tr.assert_equal gameState("laneLights")("rightOuter"), 0, "Should be off"
tr.assert_equal gameState("switches")("lightlock"), 1, "Should be blinking"

