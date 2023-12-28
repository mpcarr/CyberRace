
Sub BallSearch 
    If gameStarted = True Then
        If GameTilted = True Then
            SoundDropTargetDrop(RPinTarget)     
            garageKicker.Kick -45, 5
            raceVuk.Kick 65, RndInt(10,15)
            SoundSaucerKick 1,raceVuk
            sw_38.Kick 0, 60, 1.36
            SoundSaucerKick 1, sw_38
            If sw39.BallCntOver = 1 Then
                KickBall KickerBall39, 0, 0, 55, 10
            End If
            If ballInPlungerLane = True Then
                autoPlunge = True
                AutoPlungerDelay.Interval = 300
                AutoPlungerDelay.Enabled = False
	            AutoPlungerDelay.Enabled = True
            End If
        Else
            'Where are the balls
            If RealBallsInPlay = 0 Then
                If GameTimers(GAME_BONUS_TIMER_IDX) = 0 Then
                    'bonus not running, release new ball?
                    DispatchPinEvent RELEASE_BALL
                End If
            End If
        End If
    End If
    SetTimer "BallSearch", "BallSearch", 6000
End Sub