dim testRunner : set testRunner = new VBSUnit
	
StartGame()

testRunner.assert_equal gameState("game")("playerName"), "Player 2", "Should be Player 1"
DISPATCH GAME_AWARD_SKILLSHOT, Null
testRunner.assert_false gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE), "Skillshot should not be active"

wscript.echo testRunner.results()
wscript.echo testRunner.errors_results()