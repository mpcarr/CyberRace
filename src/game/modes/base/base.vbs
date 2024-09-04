
Sub CreateBaseMode

	With CreateGlfMode("base", 1000)
		.StartEvents = Array("ball_started")
		.StopEvents = Array("ball_ended") 
		.Debug = True
		With .BallSaves("base")
			.EnableEvents = Array("mode_base_started")
			.TimerStartEvents = Array("balldevice_plunger_ball_eject_success")
			.ActiveTime = 15
			.HurryUpTime = 5
			.GracePeriod = 3
			.BallsToSave = -1
			.AutoLaunch = True
		End With

		With .LightPlayer()
			With .Events("mode_base_started")
				With .Lights("T_GI")
					.Color = "ffffff"
				End With
			End With
		End With

		With .ShowPlayer()
			With .Events("ball_save_base_timer_start")
				.Key = "ball_save"
				.Show = glf_ShowFlashColor
				.Loops = -1
				.Speed = 1
				With .Tokens()
					.Add "lights", "l16"
					.Add "color", "62FBFF"
				End With
			End With
			With .Events("ball_save_base_hurry_up")
				.Key = "ball_save"
				.Show = glf_ShowFlashColor
				.Loops = -1
				.Speed = 2
				With .Tokens()
					.Add "lights", "l16"
					.Add "color", "62FBFF"
				End With
			End With
			With .Events("ball_save_base_grace_period")
				.Key = "ball_save"
				.Show = glf_ShowFlashColor
				.Action = "stop"
			End With
		End With

		With .VariablePlayer()
			With .Events("ball_save_base_timer_start")
				With .Variable("score")
					.Int = 1000
				End With
			End With
		End With
		.ToYaml
	End With


End Sub

