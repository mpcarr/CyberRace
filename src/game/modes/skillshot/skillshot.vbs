' Skillshot Mode
' 
' A the start of the ball, the left top lanes lights yellow.
' Hitting the lit shot awards 150K
'
' Skillshot 2
'
' Left Ramp is lit yellow, a soft plunge and hit to this
' awards race ready.
'

Sub CreateSkillshotMode()

    With GlfShotProfiles("skillshot")
        With .States("unlit")
            .Show = glf_ShowOff
        End With
        With .States("flashing")
            .Show = glf_ShowFlashColor
            With .Tokens()
                .Add "color", "ffff00"
            End With
            .SyncMs = 400
        End With
        With .States("flashing_super")
            .Show = glf_ShowFlashColor
            .Speed = 1.5
            With .Tokens()
                .Add "color", "ffff00"
            End With
            .SyncMs = 400
        End With
    End With


    With CreateGlfMode("skillshot", 500)
        .StartEvents = Array("ball_started")
        .StopEvents = Array("end_skillshot", "skill_shot_unlit_hit", "timer_skillshot_complete")
        .Debug = True
        With .Shots("lane1")
            .Switch = "sw05"
            .Profile = "skillshot"
            .Persist = False
            .AdvanceEvents = Array("mode_skillshot_started")
            With .Tokens()
                .Add "lights", "l66"
            End With
        End With
        With .Shots("lane2")
            .Switch = "sw06"
            .Profile = "skillshot"
            .Persist = False
            With .Tokens()
                .Add "lights", "l67"
            End With
        End With
        With .Shots("lane3")
            .Switch = "sw07"
            .Profile = "skillshot"
            .Persist = False
            With .Tokens()
                .Add "lights", "l68"
            End With
        End With
        With .Shots("leftramp")
            .Switch = "sw13"
            .Profile = "skillshot"
            .Persist = False
            With .ControlEvents("start")
                .Events = Array("mode_skillshot_started")
                .State = 2
            End With
            With .Tokens()
                .Add "lights", "l47"
            End With
        End With
        With .ShotGroups("skill_shot")
            .Shots = Array("lane1", "lane2", "lane3")
            .RotateLeftEvents = Array("s_left_flipper_active")
            .RotateRightEvents = Array("s_right_flipper_active")
        End With
        With .EventPlayer()
            .Add "shot_leftramp_skillshot_flashing_super_hit", Array("award_super_skillshot", "end_skillshot")
            .Add "skill_shot_flashing_hit", Array("award_skillshot", "end_skillshot")
        End With
        With .VariablePlayer()
            With .Events("award_skillshot")
                With .Variable("score")
                    .Int = 150000
                End With
            End With
            With .Events("award_super_skillshot")
                With .Variable("score")
                    .Int = 250000
                End With
            End With
        End With
        With .Timers("skillshot")
            .StartValue = 10
            .EndValue = 0
            .Direction = "down"
            With .ControlEvents("start")
                .EventName = "balldevice_plunger_ball_eject_success"
                .Action = "start"
            End With
        End With
    End With
End Sub