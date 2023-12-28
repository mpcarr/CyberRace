Sub BIPL_Hit()
    ballInPlungerLane = True
    If autoPlunge = True Then
        AutoPlungerDelay.Interval = 300
	    AutoPlungerDelay.Enabled = True
    End If
End Sub

Sub BIPL_Top_Hit()
    ballInPlungerLane = False
    autoPlunge = False
    If GameTilted = True Then
        Exit Sub
    End If
    If GetPlayerState(ENABLE_BALLSAVER) = True Then
        EnableBallSaver(20)
        SetPlayerState ENABLE_BALLSAVER, False
    End If

    SetTimer "skillshot", "CancelSkillshot", 4000

End Sub

'****************************
' Release Ball
' Event Listeners:  
    RegisterPinEvent BALL_SAVE,     "AutoPlungeBall"
    RegisterPinEvent ADD_BALL,      "AutoPlungeBall"
'
'*****************************
Sub AutoPlungeBall()
    Debug.print("AutoPlungeBall")
    If ballInPlungerLane = False And swTrough1.BallCntOver = 1 Then
        ReleaseBall()
        autoPlunge = True
    Else
        Debug.print("adding ball to q")
        ballsInQ = ballsInQ + 1
        BallReleaseTimer.Enabled = True
    End If
End Sub

Dim ballsInQ : ballsInQ = 0
Sub BallReleaseTimer_Timer()
    If ballInPlungerLane = False And ballsInQ > 0 AND swTrough1.BallCntOver = 1 Then
        ReleaseBall()
        autoPlunge = True
        ballsInQ = ballsInQ - 1
        If ballsInQ = 0 Then
            BallReleaseTimer.Enabled = False
        End If
    End If
End Sub