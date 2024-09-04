' Race 1 Selection Mode

' Left and Right Orbits Increase Race Position
' Roving Blue Shot Decreases Position (Rival)
' When in position 3, shortcut becomes ready.
' Hitting shortcut sets position to 1
' when in position 1, race finish can be hit.
' Race is on a timer. Ends when timer ends or race finish is hit.

Sub CreateRace1Mode()

    With CreateGlfMode("race_1", 500)
        .StartEvents = Array("race_selection_confirmed{current_player.player_shot_rs1_tri==1}")
        .Debug = True
        With .ShotProfiles("race_profile")
            With .States("flashing")
                .Show = glf_ShowFlashColor
                With .Tokens()
                    .Add "color", "ff0000"
                End With
            End With
        End With
        With .EventPlayer()
            .Add "mode_race_1_started", Array("race_started")
            .Add "ball_ending", Array("mode_race_ended")
        End With
        With .Shots("race1_leftorbit")
            .Switch = "sw08"
            .Profile = "race_profile"
            With .Tokens()
                .Add "lights", "l46"
            End With
        End With
        With .Shots("race1_rightorbit")
            .Switch = "sw14"
            .Profile = "race_profile"
            With .Tokens()
                .Add "lights", "l63"
            End With
        End With
        .ToYaml()
    End With
End Sub