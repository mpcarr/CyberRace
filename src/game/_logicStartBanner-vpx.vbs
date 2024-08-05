'Devices




Sub ConfigureGlfDevices()

    Dim light
    For Each light in Lights_GI
        lightCtrl.AddLightTags light, "gi"
    Next

    lightCtrl.AddLightTags l53, "race1_selection"
    lightCtrl.AddLightTags l46, "race1_selection"
    lightCtrl.AddLightTags l63, "race1_selection"
    

    Dim ball_device_plunger
    Set ball_device_plunger = (new BallDevice)("plunger")

    With ball_device_plunger
        .BallSwitches = Array("sw17")
        .EjectTargets = Array("sw27")
        .EjectStrength = 150
        .MechcanicalEject = True
        .DefaultDevice = True
    End With

    Dim ball_device_racevuk
    Set ball_device_racevuk = (new BallDevice)("racevuk")
    ball_device_racevuk.Debug = True

    With ball_device_racevuk
        .BallSwitches = Array("raceVuk")
        .EjectCallback = "RaceVuk_EjectCallback"
    End With

    Dim ball_device_nodes
    Set ball_device_nodes = (new BallDevice)("nodes")

    With ball_device_nodes
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
    SoundSaucerKick 1,raceVuk
    raceVuk.Kick 65, RndInt(7,15)
End Sub

Sub Nodes_EjectCallback(ball)
    SoundSaucerKick 1,sw39
    KickBall ball, 0, 0, 55, 10
End Sub

Sub Hyper_EjectCallback(ball)
    SoundSaucerKick 1,sw38
    sw38.Kick 0, 60, 1.36
End Sub