' Qualify Race Mode

Sub CreateQualifyRaceMode()

    With GlfShotProfiles("qualify_race")
        With .States("unlit")
            .Show = glf_ShowOff
        End With
        With .States("on")
            .Show = glf_ShowOnColor
            With .Tokens()
                .Add "color", "ff0000"
            End With
        End With
    End With

    With CreateGlfMode("qualify_race", 510)
        .StartEvents = Array("ball_started")
        .StopEvents = Array("ball_ended")
        .Debug = True
        With .Shots("left_outlane")
            .Switch = "sw01"
            .Profile = "qualify_race"
            With .Tokens()
                .Add "lights", "l42"
            End With
            With .ControlEvents("super_skillshot")
                .Events = Array("award_super_skillshot")
                .State = 1
            End With
        End With
        With .Shots("left_inlane")
            .Switch = "sw02"
            .Profile = "qualify_race"
            With .Tokens()
                .Add "lights", "l43"
            End With
            With .ControlEvents("super_skillshot")
                .Events = Array("award_super_skillshot")
                .State = 1
            End With
        End With
        With .Shots("right_inlane")
            .Switch = "sw03"
            .Profile = "qualify_race"
            With .Tokens()
                .Add "lights", "l44"
            End With
            With .ControlEvents("super_skillshot")
                .Events = Array("award_super_skillshot")
                .State = 1
            End With
        End With
        With .Shots("right_outlane")
            .Switch = "sw04"
            .Profile = "qualify_race"
            With .Tokens()
                .Add "lights", "l45"
            End With
            With .ControlEvents("super_skillshot")
                .Events = Array("award_super_skillshot")
                .State = 1
            End With
        End With
        With .Shots("right_orbit_race_qualify")
            .Profile = "flash_color"
            With .Tokens()
                .Add "lights", "l63"
                .Add "color", "ff0000"
            End With
            With .ControlEvents("race_ready")
                .Events = Array("qualify_race_on_complete")
                .State = 1
            End With
            With .ControlEvents("race_started")
                .Events = Array("mode_race_selection_starting")
                .State = 0
            End With
        End With
        With .ShotGroups("qualify_race")
            .Shots = Array("left_outlane", "left_inlane", "right_inlane", "right_outlane")
            .RotateLeftEvents = Array("s_left_flipper_active")
            .RotateRightEvents = Array("s_right_flipper_active")
            .ResetEvents = Array("mode_race_ended")
        End With
        With .BallHolds("race_ready")
            .EnableEvents = Array("qualify_race_on_complete", "mode_qualify_race_started{current_player.player_shot_right_orbit_race_qualify==1}")
            .DisableEvents = Array("race_started")
            .BallsToHold = 1
            .HoldDevices = Array("racevuk")
            .ReleaseAllEvents = Array("race_selection_confirmed")
        End With
        .ToYaml()
    End With
End Sub