
Sub CreateBaseMode


	Dim mode_base
	Set mode_base = (new Mode)("base", 1000)

	With mode_base
		.StartEvents = Array("ball_started")
		.StopEvents = Array("ball_ended") 
	End With

	With mode_base.BallSaves("base")
		.EnableEvents = Array("mode_base_started")
		.TimerStartEvents = Array("balldevice_plunger_ball_eject_success")
		.ActiveTime = 15
		.HurryUpTime = 5
		.GracePeriod = 3
		.BallsToSave = -1
		.AutoLaunch = True
	End With

	With mode_base.LightPlayer()
		.Add "mode_base_started", Array("gi|ffffff")
	End With

	With mode_base.ShowPlayer()
		With .Events("ball_saves_base_timer_start")
			.Key = "ball_save"
			.Show = glf_ShowFlashColor
			.Loops = -1
			.Speed = 1
			With .Tokens()
				.Add "lights", "l16"
				.Add "color", "62FBFF"
			End With
		End With
		With .Events("ball_saves_base_hurry_up_time")
			.Key = "ball_save"
			.Show = glf_ShowFlashColor
			.Loops = -1
			.Speed = 2
			With .Tokens()
				.Add "lights", "l17"
				.Add "color", "62FBFF"
			End With
		End With
		With .Events("ball_saves_base_grace_period")
			.Key = "ball_save"
			.Action = "stop"
		End With
	End With

	With mode_base.VariablePlayer()
		With .Events("ball_saves_base_timer_start")
			With .Variable("score")
				.Int = 1000
			End With
		End With
	End With


End Sub

