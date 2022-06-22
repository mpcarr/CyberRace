StartGame()

DISPATCH GAME_AWARD_SKILLSHOT, Null

tr.assert_equal gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE), False, "Should be False"