Sub vukBallLock_Hit()
    'DISPATCH SWITCH_HIT_BALL_LOCK, Null
    'LockPin.IsDropped = False
    vukBallLock.Kick 0, 60, 1.5
End Sub

Sub swRightRampBallLock_Hit()
    DISPATCH SWITCH_HIT_BALL_LOCK, Null
End Sub