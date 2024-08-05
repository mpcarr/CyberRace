' Race 1 Selection Mode

Sub CreateRace1Mode()

    With CreateGlfMode("race_1", 500)
        .StartEvents = Array("race_selection_confirmed{current_player.player_shot_rs1_tri==1}")
        .Debug = True
        With .EventPlayer()
            .Add "mode_race_1_started", Array("race_started")
            .Add "ball_ending", Array("mode_race_ended")
        End With
    End With
End Sub