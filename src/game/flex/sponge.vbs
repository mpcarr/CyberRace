
Dim FontScoreActive
Dim FontCyber5
Dim FontCyber7
Dim FontCyber32
Dim FontCyber16_HURRYUP_COLOR


sub CreateGameDMD

	Dim title, af,list

	Set FontScoreActive = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", vbWhite, RGB(0, 0, 0), 0)

	Set FontWhite3 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", vbWhite, RGB(0,0,0), 0)
	Set FontPurple3 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(255,0,255), RGB(0,0,0), 0)

	Set FontCyber16_HURRYUP_COLOR = FlexDMD.NewFont("FlexDMD.Resources.udmd-f6by12.fnt", RGB(255, 240, 33), RGB(0, 0, 0), 0)
	Set FontCyber32  = FlexDMD.NewFont("FlexDMD.Resources.udmd-f6by12.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontCyber5  = FlexDMD.NewFont("FlexDMD.Resources.udmd-f4by5.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontCyber7  = FlexDMD.NewFont("FlexDMD.Resources.udmd-f5by7.fnt", vbWhite, RGB(0, 0, 0), 0)
	

	Dim scene 
	Set scene = FlexDMD.NewGroup("Score")
	Set title = FlexDMD.NewImage("BGP1",		"BGP1.png")			: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene.AddActor title
	Set title = FlexDMD.NewImage("BGP2",		"BGP2.png")			: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene.AddActor title
	Set title = FlexDMD.NewImage("BGP3",		"BGP3.png")			: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene.AddActor title
	Set title = FlexDMD.NewImage("BGP4",		"BGP4.png")			: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene.AddActor title
	

	scene.SetBounds 0, 0, DmdWidth, DmdHeight
	scene.AddActor FlexDMD.NewLabel("Ball", FontPurple3, " ")
	scene.AddActor FlexDMD.NewLabel("Player1", FontWhite3, " ")
	scene.AddActor FlexDMD.NewLabel("Player2", FontWhite3, " ")
	scene.AddActor FlexDMD.NewLabel("Player3", FontWhite3, " ")
	scene.AddActor FlexDMD.NewLabel("Player4", FontWhite3, " ")

	' scene.AddActor FlexDMD.NewFrame("VSeparator5")
	' scene.GetFrame("VSeparator5").Thickness = 1
	' scene.GetFrame("VSeparator5").FillColor = RGB(255,0,255)
	' scene.GetFrame("VSeparator5").Fill = True
	' scene.GetFrame("VSeparator5").SetBounds 0, 0, DMDWidth, DMDHeight
	
	scene.AddActor FlexDMD.NewFrame("VSeparator1")
	scene.GetFrame("VSeparator1").Thickness = 1
	scene.GetFrame("VSeparator1").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator1").SetBounds 2, 7, (DMDWidth/2)-12, 1

	scene.AddActor FlexDMD.NewFrame("VSeparator2")
	scene.GetFrame("VSeparator2").Thickness = 1
	scene.GetFrame("VSeparator2").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator2").SetBounds (DMDWidth/2)+10, 7, (DMDWidth/2)-12, 1

	scene.AddActor FlexDMD.NewFrame("VSeparator3")
	scene.GetFrame("VSeparator3").Thickness = 1
	scene.GetFrame("VSeparator3").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator3").SetBounds 2, 24, (DMDWidth/2)-12, 1

	scene.AddActor FlexDMD.NewFrame("VSeparator4")
	scene.GetFrame("VSeparator4").Thickness = 1
	scene.GetFrame("VSeparator4").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator4").SetBounds (DMDWidth/2)+10, 24, (DMDWidth/2)-12, 1

    Set title = FlexDMD.NewLabel("Content_1", FontScoreActive, " ")
	Set af = title.ActionFactory
	Set list = af.Sequence()
	title.AddAction af.Repeat(list, 1)
	scene.AddActor title

	Dim scene2 
	Set scene2 = FlexDMD.NewGroup("Overlay")

	Set title = FlexDMD.NewImage("BG001",		"BG001.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BGEMP",		"cyberEMP.png")		: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BGRaceReady",	"cyberRaceReady.png")		: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("vidIntro",	"videos/attract-c.gif")		: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("betB", "videos/bet-b.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betE", "videos/bet-e.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betT", "videos/bet-t.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betBET", "videos/bet-hurry.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betBE", "videos/bet-be.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betBT", "videos/bet-bt.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betET", "videos/bet-et.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGBoost", "videos/boost-bg.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGCyber", "videos/cyber-bg.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	
	Set title = FlexDMD.NewVideo("BGEngine", "videos/garage-engine.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGCooling", "videos/garage-cooling.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGFuel", "videos/garage-fuel.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGNode1", "videos/node1.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGNode2", "videos/node2.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGNode3", "videos/node3.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGNode4", "videos/node4.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGNode5", "videos/node5.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGNodeComplete", "videos/node-complete.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGRace1", "videos/race1.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace2", "videos/race2.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace3", "videos/race3.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace4", "videos/race4.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRaceLocked", "videos/RaceLocked.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title

    scene2.AddActor FlexDMD.NewLabel("TextSmalLine4", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine1", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine2", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine3", FontCyber16_HURRYUP_COLOR, " ")

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Stage.AddActor scene2
	FlexDMD.Show = True
    'If VRRoom = 0 Then FlexDMD.Show = True Else FlexDMD.Show = False
	FlexDMD.Run = True
	FlexDMD.UnlockRenderThread

End Sub


Sub DMDTimer_Timer
	
	
	FlexDMD.LockRenderThread
	If gameBooted = False Then
		'Dim label : Set label = FlexDMD.Stage.GetLabel("TextSmalLine1")
		'label.Font = FontCyber32
		'label.Text = "PLEASE WAIT"
		'label.SetAlignedPosition 128,32,FlexDMD_Align_Center
		'label.visible = True

		'Set label = FlexDMD.Stage.GetLabel("TextSmalLine2")
		'label.Font = FontCyber32
		'label.Text = "BOOTING"
		'label.SetAlignedPosition CurrentItem.StartPos(0),CurrentItem.StartPos(1)+16 - DMD_slide ,FlexDMD_Align_Center
		'label.visible = True
		DmdQ.Update()
		FlexDMD.UnLockRenderThread
		Exit Sub	
	End If

	If gameStarted = False Then
		FlexDMD.Stage.GetVideo("vidIntro").Visible = True
		FlexDMD.UnLockRenderThread
		Exit Sub
	End If

	If bInOptions = True Then
		Options_UpdateDMD
		FlexDMD.UnLockRenderThread
		Exit Sub
	End If
	
	
	Dim flexMode : flexMode = GetPlayerState(FLEX_MODE)
	If flexMode > 0 Then
		Select Case flexMode
			Case 7: 'RACE MODE SELECTION SCENE
				'Dim labelTitle : Set labelTitle = DMDRaceSelectScene.GetLabel("lblRaceTitle")
				'Dim labelDescription : Set labelDescription = DMDRaceSelectScene.GetLabel("lblRaceDescription")
				'Dim selection : selection = GetPlayerState(RACE_MODE_SELECTION)
				'labelTitle.Text =  "RACE " & selection & " -VS- " & GAME_RACE_MODE_TITLES(selection-1)
				'labelDescription.Text =  GAME_RACE_MODE_DESC(selection-1)
				'labelTitle.SetAlignedPosition 128, 24, FlexDMD_Align_Center
				'labelDescription.SetAlignedPosition 128, 42, FlexDMD_Align_Center
		End Select
	Else
		Dim currentBall : currentBall = GetPlayerState(CURRENT_BALL)

		FlexDMD.Stage.GetLabel("Ball").Text = "BALL " & currentBall 'BallInPlay
		If playerState.Exists("PLAYER 1") Then
			If currentPlayer = "PLAYER 1" Then
				FlexDMD.Stage.GetLabel("Player1").Text = "Player 1"
				FlexDMD.Stage.GetLabel("Player1").SetAlignedPosition 28, 5, FlexDMD_Align_Center
			Else
				FlexDMD.Stage.GetLabel("Player1").Text = FormatScore(PlayerState("PLAYER 1")(SCORE))
				FlexDMD.Stage.GetLabel("Player1").SetAlignedPosition 28, 4, FlexDMD_Align_Center
			End If
		End If
		If playerState.Exists("PLAYER 2") Then
			If currentPlayer = "PLAYER 2" Then
				FlexDMD.Stage.GetLabel("Player2").Text = "Player 2"
				FlexDMD.Stage.GetLabel("Player2").SetAlignedPosition 100, 5, FlexDMD_Align_Center
			Else
				FlexDMD.Stage.GetLabel("Player2").Text = FormatScore(PlayerState("PLAYER 2")(SCORE))
				FlexDMD.Stage.GetLabel("Player2").SetAlignedPosition 100, 4, FlexDMD_Align_Center
			End If
		Else
			If currentBall = 1 Then FlexDMD.Stage.GetLabel("Player2").Text = "P/START" : FlexDMD.Stage.GetLabel("Player2").SetAlignedPosition 100, 4, FlexDMD_Align_Center Else FlexDMD.Stage.GetLabel("Player2").Text = ""
		End If
		If playerState.Exists("PLAYER 3") Then
			If currentPlayer = "PLAYER 3" Then
				FlexDMD.Stage.GetLabel("Player3").Text = "Player 3"
				FlexDMD.Stage.GetLabel("Player3").SetAlignedPosition 28, 30, FlexDMD_Align_Center
			Else
				FlexDMD.Stage.GetLabel("Player3").Text = FormatScore(PlayerState("PLAYER 3")(SCORE))
				FlexDMD.Stage.GetLabel("Player3").SetAlignedPosition 28, 29, FlexDMD_Align_Center
			End If
		Else
			If currentBall = 1 Then FlexDMD.Stage.GetLabel("Player3").Text = "P/START" : FlexDMD.Stage.GetLabel("Player3").SetAlignedPosition 28, 29, FlexDMD_Align_Center Else FlexDMD.Stage.GetLabel("Player3").Text = ""
		End If
		If playerState.Exists("PLAYER 4") Then
			If currentPlayer = "PLAYER 4" Then
				FlexDMD.Stage.GetLabel("Player4").Text = "Player 4"
				FlexDMD.Stage.GetLabel("Player4").SetAlignedPosition 100, 30, FlexDMD_Align_Center
			Else
				FlexDMD.Stage.GetLabel("Player4").Text = FormatScore(PlayerState("PLAYER 4")(SCORE))
				FlexDMD.Stage.GetLabel("Player4").SetAlignedPosition 100, 29, FlexDMD_Align_Center
			End If
		Else
			If currentBall = 1 Then FlexDMD.Stage.GetLabel("Player4").Text = "P/START" : FlexDMD.Stage.GetLabel("Player4").SetAlignedPosition 100, 29, FlexDMD_Align_Center Else FlexDMD.Stage.GetLabel("Player4").Text = ""
		End If

		FlexDMD.Stage.GetLabel("Ball").SetAlignedPosition 64, 30, FlexDMD_Align_Center
		
		FlexDMD.Stage.GetLabel("Content_1").Font = FontScoreActive
		FlexDMD.Stage.GetLabel("Content_1").Text = FormatScore(GetPlayerState(SCORE))
		FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 64, 17, FlexDMD_Align_Center

		DmdQ.Update()

	End If
	FlexDMD.UnLockRenderThread

End Sub

Sub DMD_Update
	Exit Sub
	dim tmp
	If DMD_Slide > 0 Then DMD_slide = DMD_slide - 2
	If frame mod 3 = 1 Then
		If DMDDisplay(20,7) = "shake" And Not DMD_ShakePos = 0 Then ' shaking
			If DMD_ShakePos < 0 Then DMD_ShakePos = ABS(DMD_ShakePos) - 1 Else DMD_ShakePos = - DMD_ShakePos + 1
		End If
	End If
	If DMDDisplay(20,7) = "blink" or DMDDisplay(20,7) = "noslide2blink" or DMDDisplay(20,7) = "noslideoffblink" Then ' blinking
		If frame mod 30 > 15 Then
			FlexDMD.Stage.GetLabel("TextSmalLine1").visible = False
			If DMDDisplay(20,11) > 1 Then  FlexDMD.Stage.GetLabel("TextSmalLine2").visible = False
		Else
			FlexDMD.Stage.GetLabel("TextSmalLine1").visible = True
			If DMDDisplay(20,11) > 1 Then  FlexDMD.Stage.GetLabel("TextSmalLine2").visible = True
		End If
	End If
	'Marque
    If DMDDisplay(20,3) < DMDDisplay(20,5) Then DMDDisplay(20,3) = DMDDisplay(20,3) + 2
    If DMDDisplay(20,3) > DMDDisplay(20,5) Then DMDDisplay(20,3) = DMDDisplay(20,3) - 2
    If DMDDisplay(20,4) < DMDDisplay(20,6) Then DMDDisplay(20,4) = DMDDisplay(20,4) + 2
    If DMDDisplay(20,4) > DMDDisplay(20,6) Then DMDDisplay(20,4) = DMDDisplay(20,4) - 2
	'Shake
	If DMDDisplay(20,11) = 1 Then
		FlexDMD.Stage.GetLabel("TextSmalLine1").SetAlignedPosition DMDDisplay(20,3) + DMD_ShakePos ,DMDDisplay(20,4) - DMD_Slide , FlexDMD_Align_Center
	Elseif DMDDisplay(20,11) = 2 Then
		FlexDMD.Stage.GetLabel("TextSmalLine1").SetAlignedPosition DMDDisplay(20,3) + DMD_ShakePos ,DMDDisplay(20,4)-16 - DMD_Slide , FlexDMD_Align_Center
		FlexDMD.Stage.GetLabel("TextSmalLine2").SetAlignedPosition DMDDisplay(20,3) + DMD_ShakePos ,DMDDisplay(20,4)+16 - DMD_Slide , FlexDMD_Align_Center
	End If
 
	If DMDDisplay(20, 9) <> "noimage"  Then FlexDMD.Stage.GetImage(DMDDisplay(20, 9)).SetPosition 0, - DMD_slide
	If DMDDisplay(20,10) <> "novideo" Then FlexDMD.Stage.GetVideo(DMDDisplay(20,10)).SetPosition 0, - DMD_slide


	Set label = FlexDMD.Stage.GetLabel("TextSmalLine2")
	If InStr(1, DMDDisplay(20,1), "GetPlayerState") > 0 Then
		label.Text = Eval(DMDDisplay(20,1))
	End If
End Sub

Sub DMD_Flasher
	Dim DMDp
		DMDp = FlexDMD.DmdColoredPixels
		If Not IsEmpty(DMDp) Then
			DMDWidth = FlexDMD.Width
			DMDHeight = FlexDMD.Height
			DMDColoredPixels = DMDp
		End If
End Sub

Function FormatScore(ByVal Num)
    dim NumString
    NumString = CStr(abs(Num) )
	If len(NumString)>9 then NumString = left(NumString, Len(NumString)-9) & "," & right(NumString,9)
	If len(NumString)>6 then NumString = left(NumString, Len(NumString)-6) & "," & right(NumString,6) 
	If len(NumString)>3 then NumString = left(NumString, Len(NumString)-3) & "," & right(NumString,3)
	FormatScore = NumString
End function


