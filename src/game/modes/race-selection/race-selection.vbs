' Race Selection Mode

Sub CreateRaceSelectionMode()

    With CreateGlfMode("race_selection", 520)
        .StartEvents = Array("ball_hold_race_ready_full")
        .StopEvents = Array("race_started")

        With .ShotProfiles("race_selection")
            With .States("unlit")
                .Show = glf_ShowOff
            End With
            With .States("flashing")
                .Show = glf_ShowFlashColor
                With .Tokens()
                    .Add "color", "ff0000"
                End With
            End With
            With .States("complete")
                .Show = glf_ShowOnColor
                With .Tokens()
                    .Add "color", "ff0000"
                End With
            End With
            .StateNamesNotToRotate = Array("complete")
        End With
        With .Shots("rs1_tri")
            .Profile = "race_selection"
            With .Tokens()
                .Add "lights", "race1_selection"
            End With
            With .ControlEvents("light_selection")
                .Events = Array("light_race1_selection")
                .State = 1
            End With
            With .ControlEvents("light_complete")
                .Events = Array("light_race1_complete")
                .State = 2
            End With
        End With
        With .Shots("rs2_tri")
            .Profile = "race_selection"
            With .Tokens()
                .Add "lights", "l54"
            End With
            With .ControlEvents("light_selection")
                .Events = Array("light_race2_selection")
                .State = 1
            End With
            With .ControlEvents("light_complete")
                .Events = Array("light_race2_complete")
                .State = 2
            End With
        End With
        With .Shots("rs3_tri")
            .Profile = "race_selection"
            With .Tokens()
                .Add "lights", "l55"
            End With
            With .ControlEvents("light_selection")
                .Events = Array("light_race3_selection")
                .State = 1
            End With
            With .ControlEvents("light_complete")
                .Events = Array("light_race3_complete")
                .State = 2
            End With
        End With
        With .Shots("rs4_tri")
            .Profile = "race_selection"
            With .Tokens()
                .Add "lights", "l56"
            End With
            With .ControlEvents("light_selection")
                .Events = Array("light_race4_selection")
                .State = 1
            End With
            With .ControlEvents("light_complete")
                .Events = Array("light_race4_complete")
                .State = 2
            End With
        End With
        With .Shots("rs5_tri")
            .Profile = "race_selection"
            With .Tokens()
                .Add "lights", "l57"
            End With
            With .ControlEvents("light_selection")
                .Events = Array("light_race5_selection")
                .State = 1
            End With
            With .ControlEvents("light_complete")
                .Events = Array("light_race5_complete")
                .State = 2
            End With
        End With
        With .Shots("rs6_tri")
            .Profile = "race_selection"
            With .Tokens()
                .Add "lights", "l58"
            End With
            With .ControlEvents("light_selection")
                .Events = Array("light_race6_selection")
                .State = 1
            End With
            With .ControlEvents("light_complete")
                .Events = Array("light_race6_complete")
                .State = 2
            End With
        End With

        With .EventPlayer()
            .Add "mode_race_selection_started{current_player.player_shot_rs1_tri < 2}", Array("light_race1_selection")
            .Add "mode_race_selection_started{current_player.player_shot_rs2_tri < 2 && current_player.player_shot_rs1_tri==2}", Array("light_race2_selection")
            .Add "mode_race_selection_started{current_player.player_shot_rs3_tri < 2 && current_player.player_shot_rs1_tri==2 && current_player.player_shot_rs2_tri==2}", Array("light_race3_selection")
            .Add "mode_race_selection_started{current_player.player_shot_rs3_tri < 2 && current_player.player_shot_rs1_tri==2 && current_player.player_shot_rs2_tri==2 && current_player.player_shot_rs3_tri==2}", Array("light_race4_selection")
            .Add "mode_race_selection_started{current_player.player_shot_rs3_tri < 2 && current_player.player_shot_rs1_tri==2 && current_player.player_shot_rs2_tri==2 && current_player.player_shot_rs3_tri==2 && current_player.player_shot_rs4_tri==2}", Array("light_race5_selection")
            .Add "mode_race_selection_started{current_player.player_shot_rs3_tri < 2 && current_player.player_shot_rs1_tri==2 && current_player.player_shot_rs2_tri==2 && current_player.player_shot_rs3_tri==2 && current_player.player_shot_rs4_tri==2 && current_player.player_shot_rs5_tri==2}", Array("light_race6_selection")
            .Add "s_plunger_key_active", Array("race_selection_confirmed")
            .Add "s_lockbar_key_active", Array("race_selection_confirmed")
        End With

        With .ShotGroups("race_selection")
            .Shots = Array("rs1_tri", "rs2_tri", "rs3_tri", "rs4_tri", "rs5_tri", "rs6_tri")
            .RotateLeftEvents = Array("s_left_flipper_active")
            .RotateRightEvents = Array("s_right_flipper_active")
        End With
        .ToYaml()
    End With

End Sub 