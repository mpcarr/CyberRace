'Devices




Sub ConfigureGlfDevices()

    Dim ball_device_plunger
    Set ball_device_plunger = (new BallDevice)("plunger")

    With ball_device_plunger
        .BallSwitches = Array("s_plunger")
        .EjectTargets = Array("sw27")
        .EjectStrength = 150
        .MechcanicalEject = True
        .DefaultDevice = True
    End With

    Dim ball_device_race_scoop
    Set ball_device_race_scoop = (new BallDevice)("race_scoop")
    ball_device_race_scoop.Debug = True

    With ball_device_race_scoop
        .BallSwitches = Array("s_race_scoop")
        .EjectCallback = "RaceVuk_EjectCallback"
    End With

    Dim ball_device_center_scoop
    Set ball_device_center_scoop = (new BallDevice)("center_scoop")

    With ball_device_center_scoop
        .BallSwitches = Array("sw39")
        .EjectCallback = "Nodes_EjectCallback"
    End With

    Dim ball_device_hyper
    Set ball_device_hyper = (new BallDevice)("hyper")

    With ball_device_hyper
        .BallSwitches = Array("sw38")
        .EjectCallback = "Hyper_EjectCallback"
    End With

    CreateBaseMode()
    CreateSkillshotMode()
    CreateQualifyRaceMode()
    CreateRaceSelectionMode()
    CreateRace1Mode()
End Sub

Sub RaceVuk_EjectCallback(ball)
    SoundSaucerKick 1,s_race_scoop
    s_race_scoop.Kick 65, RndInt(7,15)
End Sub

Sub Nodes_EjectCallback(ball)
    SoundSaucerKick 1,sw39
    KickBall ball, 0, 0, 55, 10
End Sub

Sub Hyper_EjectCallback(ball)
    SoundSaucerKick 1,sw38
    sw38.Kick 0, 60, 1.36
End Sub