
'****************************
' Release Ball
' Event Listeners:  
    RegisterPinEvent START_GAME,    "ReleaseBall"
    RegisterPinEvent NEXT_PLAYER,   "ReleaseBall"
'
'*****************************
Sub ReleaseBall()
    swTrough1.kick 90, 10
    RandomSoundBallRelease swTrough1
    ballsInPlay = ballsInPlay + 1
End Sub