
Sub FlexDMDBetBScene()
	dim bet1,bet2,bet3,vid,l
	vid = Null
	l=2
	bet1 = GetPlayerState(BET_1)
	bet2 = GetPlayerState(BET_2)
	bet3 = GetPlayerState(BET_3)

	If bet1 = 1 And bet2 = 1 And bet3=1 Then
		vid = "betBET"
		l=3
	ElseIf bet2 = 1 And bet3 = 2 Then
		vid = "betBE"
	ElseIf bet2 = 2 And bet3 = 2 Then
		vid = "betB"
	ElseIf bet2 = 2 And bet3 = 1 Then
		vid = "betBT"
	End If

	If Not IsNull(vid) Then
		Dim qItem : Set qItem = New QueueItem
		With qItem
			.Name = "bet"
			.Duration = l
			.Title = ""
			.Message = ""
			.Font = FontCyber32
			.StartPos = Array(128,32)
			.EndPos = Array(128,32)
			.Action = "blink"
			.BGImage = "noimage"
			.BGVideo = vid
		End With
		DmdQ.Enqueue qItem
	End If
End Sub

Sub FlexDMDBetEScene()
	dim bet1,bet2,bet3,vid,l
	vid = Null
	l=2
	bet1 = GetPlayerState(BET_1)
	bet2 = GetPlayerState(BET_2)
	bet3 = GetPlayerState(BET_3)

	If bet1 = 1 And bet2 = 1 And bet3=1 Then
		vid = "betBET"
		l=3
	ElseIf bet1 = 1 And bet3 = 2 Then
		vid = "betBE"
	ElseIf bet1 = 2 And bet3 = 2 Then
		vid = "betE"
	ElseIf bet1 = 2 And bet3 = 1 Then
		vid = "betET"
	End If
		
	If Not IsNull(vid) Then
		Dim qItem : Set qItem = New QueueItem
		With qItem
			.Name = "bet"
			.Duration = l
			.Title = ""
			.Message = ""
			.Font = FontCyber32
			.StartPos = Array(128,32)
			.EndPos = Array(128,32)
			.Action = "blink"
			.BGImage = "noimage"
			.BGVideo = vid
		End With
		DmdQ.Enqueue qItem
	End If
End Sub

Sub FlexDMDBetTScene()
	dim bet1,bet2,bet3,vid,l
	vid = Null
	l=2
	bet1 = GetPlayerState(BET_1)
	bet2 = GetPlayerState(BET_2)
	bet3 = GetPlayerState(BET_3)

	If bet1 = 1 And bet2 = 1 And bet3=1 Then
		vid = "betBET"
		l=3
	ElseIf bet1 = 1 And bet2 = 2 Then
		vid = "betBT"
	ElseIf bet1 = 2 And bet2 = 2 Then
		vid = "betT"
	ElseIf bet1 = 2 And bet2 = 1 Then
		vid = "betET"
	End If
		
	If Not IsNull(vid) Then
		Dim qItem : Set qItem = New QueueItem
		With qItem
			.Name = "bet"
			.Duration = l
			.Title = ""
			.Message = ""
			.Font = FontCyber32
			.StartPos = Array(128,32)
			.EndPos = Array(128,32)
			.Action = "blink"
			.BGImage = "noimage"
			.BGVideo = vid
		End With
		DmdQ.Enqueue qItem
	End If
End Sub