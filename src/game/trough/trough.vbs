
'****************************
' Release Ball
' Event Listeners:  
    RegisterPinEvent START_GAME,    "ReleaseBall"
    RegisterPinEvent NEXT_PLAYER,   "ReleaseBall"
    RegisterPinEvent RELEASE_BALL,   "ReleaseBall"
'
'*****************************
Sub ReleaseBall()
    swTrough1.kick 90, 10
    RandomSoundBallRelease swTrough1
End Sub