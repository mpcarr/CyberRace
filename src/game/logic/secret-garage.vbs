
'****************************
' SecretGarageSkip
' Event Listeners:          
    RegisterPinEvent SWITCH_BOTH_FLIPPERS_PRESSED, "SecretGarageSkip"
'
'*****************************
Sub SecretGarageSkip()
    If garageKicker.BallCntOver Then
        releaseGarageLock()
    End If
End Sub

'****************************
' SecretGarageEnter
' Event Listeners:          
    RegisterPinEvent SWITCH_HIT_RAMP_PIN, "SecretGarageEnter"
'
'*****************************
Sub SecretGarageEnter()

    If RealBallsInPlay > 1 Then
        'RPin.TimerEnabled = False
        'RPin.TimerEnabled = True
        'RPin.TimerInterval = 100
        releaseGarageLock()
        Exit Sub
    End If

    If GetPlayerState(GARAGE_ENGINE) = 0 Then
        DOF 256, DOFOn
        lightCtrl.AddTableLightSeq "RGB", lSeqGaragePart2
        FlexDMDGarageEngineScene()
        calloutsQ.Add "engineUpgrade", "PlayCallout(""engine-upgrade"")", 1, 0, 0, 3500, 0, False
        calloutsQ.Add "collectMore", "PlayCallout(""collect2more"")", 1, 0, 0, 1000, 0, False
        SetPlayerState GARAGE_ENGINE, 1
        Debounce "releaseGarage", "releaseGarageLock", 5000
        'RPin.TimerEnabled = False
        'RPin.TimerEnabled = True
        'RPin.TimerInterval = 5000
    ElseIf GetPlayerState(GARAGE_COOLING) = 0 Then
        DOF 256, DOFOn
        lightCtrl.AddTableLightSeq "RGB", lSeqGaragePart2
        FlexDMDGarageCoolingScene()
        calloutsQ.Add "coolingUpgrade", "PlayCallout(""cooling-upgrade"")", 1, 0, 0, 3500, 0, False
        calloutsQ.Add "collectMore", "PlayCallout(""collect1more"")", 1, 0, 0, 1000, 0, False
        SetPlayerState GARAGE_COOLING, 1

        Debounce "releaseGarage", "releaseGarageLock", 5000
        'RPin.TimerEnabled = False
        'RPin.TimerEnabled = True
        'RPin.TimerInterval = 5000
    ElseIF GetPlayerState(GARAGE_HULL) = 0 Then
        DOF 256, DOFOn
        lightCtrl.AddTableLightSeq "RGB", lSeqGaragePart2
        FlexDMDGarageFuelScene()
        calloutsQ.Add "fuelUpgrade", "PlayCallout(""fuel-upgrade"")", 1, 0, 0, 3500, 0, False
        calloutsQ.Add "prepareformb", "PlayCallout(""prepareformb"")", 1, 0, 0, 3500, 0, False
        calloutsQ.Add "startmb", "ballsInQ = ballsInQ + 1 : BallReleaseTimer.Enabled = True", 1, 0, 0, 0, 0, False
        SetPlayerState GARAGE_HULL, 0
        SetPlayerState GARAGE_COOLING, 0
        SetPlayerState GARAGE_ENGINE, 0
        Debounce "releaseGarage", "releaseGarageLock", 4000
        'RPin.TimerEnabled = False
        'RPin.TimerEnabled = True
        'RPin.TimerInterval = 4000
    End If
End Sub

Sub releaseGarageLock()
    DOF 256, DOFOff
    lightCtrl.RemoveTableLightSeq "RGB", lSeqGaragePart2
    lightCtrl.pulse l141, 2
    SoundDropTargetDrop(RPinTarget)        
    garageKicker.Kick -45, 5
End Sub