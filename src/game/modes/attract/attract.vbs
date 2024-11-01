Sub CreateAttractMode
	With CreateGlfMode("attract", 2000)
		.StartEvents = Array("ball_started")
		.StopEvents = Array("ball_ended") 
		.Debug = True
		With .ShowPlayer()
			With .Events("mode_attract_started")
				.Show = glf_Showrace
				.Loops = -1
				.Speed = 4
				With .Tokens()
					.Add "color", "62FBFF"
				End With
			End With
		End With
		.ToYaml
	End With
End Sub

