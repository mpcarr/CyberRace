
'****************************
' Release Ball
' Event Listeners:  
    AddPinEventListener START_GAME, START_GAME &      "ReleaseBall",      "ReleaseBall",  1000, Null
    AddPinEventListener NEXT_PLAYER, NEXT_PLAYER &     "ReleaseBall",     "ReleaseBall",  1000, Null
    AddPinEventListener RELEASE_BALL, RELEASE_BALL &     "ReleaseBall",     "ReleaseBall",  1000, Null
'
'*****************************
Sub ReleaseBall()
    swTrough1.kick 90, 10
    UpdateTrough()
    RandomSoundBallRelease swTrough1
End Sub