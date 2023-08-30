
Dim FontScoreActive
Dim FontScoreActiveScaled
Dim FontScoreInactive
Dim FontBig
Dim FontSponge12
Dim FontSponge16
Dim FontSponge16A
Dim FontSponge16B
Dim FontCyber32
Dim FontCyber16_HURRYUP_COLOR
Dim FontScoreCredits
Dim FontHighscore
Dim FontHighscore2
sub CreateGameDMD

	Dim title, af,list

	Set FontScoreActive = FlexDMD.NewFont("FONTS/sendha28.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontScoreActiveScaled = FlexDMD.NewFont("FONTS/sendha28.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontScoreInactive = FlexDMD.NewFont("FONTS/sendha16.fnt", RGB(64, 64, 64), RGB(0, 0, 0), 0)
	Set FontScoreCredits = FlexDMD.NewFont("FONTS/sendha16.fnt", RGB(16, 118, 27),  RGB(0, 0, 0), 0)
	Set FontBig = FlexDMD.NewFont("FONTS/sendha32.fnt", RGB(255, 155, 0), vbWhite, 0)

	Set FontSponge12  = FlexDMD.NewFont("Spongebob12.fnt", RGB(222,155, 0), RGB(0, 0, 0), 0)
	Set FontSponge16  = FlexDMD.NewFont("SpongebobX16.fnt", RGB(255, 222, 0), RGB(0, 0, 0), 0 )
	Set FontSponge16A = FlexDMD.NewFont("SpongebobX16.fnt", RGB(255, 150, 10), RGB(0, 0, 0), 0 )
	Set FontSponge16B = FlexDMD.NewFont("SpongebobX16.fnt", RGB(10, 255, 10), RGB(0, 0, 0), 0 )
	
	Set FontCyber12  = FlexDMD.NewFont("FONTS/sendha12.fnt", RGB(255,255, 255), RGB(0, 0, 0), 0)
	Set FontCyber16_HURRYUP_COLOR = FlexDMD.NewFont("FONTS/sendha24.fnt", RGB(255, 240, 33), RGB(0, 0, 0), 0)
	Set FontCyber14  = FlexDMD.NewFont("FONTS/prox14.fnt", RGB(255,255, 255), RGB(0, 0, 0), 0)
	Set FontCyber32  = FlexDMD.NewFont("FONTS/sendha32.fnt", RGB(255,0, 0), RGB(0, 0, 0), 0)
	
	Set FontHighscore = FlexDMD.NewFont("FONTS/sendha32.fnt", RGB(11,11,11), vbWhite, 0)
	Set FontHighscore2 = FlexDMD.NewFont("FONTS/sendha32.fnt", RGB(255,140,11), vbWhite, 0)

	Dim scene 
	Set scene = FlexDMD.NewGroup("Score")

	scene.SetBounds 0, 0, 256, 64
	Set title = FlexDMD.NewImage("BGP1",		"BGP1.png")			: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene.AddActor title
	Set title = FlexDMD.NewImage("BGP2",		"BGP2.png")			: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene.AddActor title
	Set title = FlexDMD.NewImage("BGP3",		"BGP3.png")			: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene.AddActor title
	Set title = FlexDMD.NewImage("BGP4",		"BGP4.png")			: title.SetBounds 0, 0, 256, 64 : title.Visible = True : scene.AddActor title
	
	scene.AddActor FlexDMD.NewLabel("Ball", FontCyber14, " ")
	scene.AddActor FlexDMD.NewLabel("Player1", FontCyber14, " ")
	scene.AddActor FlexDMD.NewLabel("Player2", FontCyber14, " ")
	scene.AddActor FlexDMD.NewLabel("Player3", FontCyber14, " ")
	scene.AddActor FlexDMD.NewLabel("Player4", FontCyber14, " ")

	
    scene.GetLabel("Ball").SetAlignedPosition 128, 54, FlexDMD_Align_Center
	scene.GetLabel("Player1").SetAlignedPosition 54, 8, FlexDMD_Align_Center
	scene.GetLabel("Player2").SetAlignedPosition 200, 8, FlexDMD_Align_Center
	scene.GetLabel("Player3").SetAlignedPosition 54, 56, FlexDMD_Align_Center
	scene.GetLabel("Player4").SetAlignedPosition 200, 56, FlexDMD_Align_Center
	
    Set title = FlexDMD.NewLabel("Content_1", FontScoreActive, " ")
	Set af = title.ActionFactory
	Set list = af.Sequence()
	title.AddAction af.Repeat(list, 1)
	scene.AddActor title

	

    Dim scene2 
	Set scene2 = FlexDMD.NewGroup("Overlay")


	Set title = FlexDMD.NewImage("Title", 		"Title.png")		: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG001",		"BG001.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG003",		"SquareBG003.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG004",		"SquareBG004.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG005",		"SquareBG005.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG006",		"SquareBG006.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG007",		"SquareBG007.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG008",		"SquareBG008.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG009",		"SquareBG009.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG010",		"SquareBG010.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG011",		"SquareBG011.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG012",		"SquareBG012.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BGEMP",		"cyberEMP.png")		: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BGRaceReady",	"cyberRaceReady.png")		: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("vidIntro",	"videos/attract-c.gif")		: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("betB", "videos/bet-b.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betE", "videos/bet-e.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betT", "videos/bet-t.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betBET", "videos/bet-hurry.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betBE", "videos/bet-be.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betBT", "videos/bet-bt.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("betET", "videos/bet-et.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGBoost", "videos/boost-bg.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGCyber", "videos/cyber-bg.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	
	Set title = FlexDMD.NewVideo("BGEngine", "videos/garage-engine.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGCooling", "videos/garage-cooling.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGFuel", "videos/garage-fuel.gif"): title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title


' bottom tiny text line
	Set title = FlexDMD.NewImage("BG002",		"SquareBG002.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	
    scene2.AddActor FlexDMD.NewLabel("TextSmalLine4", FontCyber16_HURRYUP_COLOR, " ")



	Set title = FlexDMD.NewVideo("VIDchaos",	"videos/garage-engine.gif")		: title.SetBounds 0, 0, 256, 64 : title.Visible = False : title.SetAlignedPosition 64, 12 , FlexDMD_Align_Center : scene2.AddActor title

	Set title = FlexDMD.NewImage("BGtilt",		"SquareBGtilt.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BGwarn",		"SquareBGwarn.png")	: title.SetBounds 0, 0, 256, 64 : title.Visible = False : scene2.AddActor title


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

	If gameStarted = False Then
		FlexDMD.Stage.GetVideo("vidIntro").Visible = True
		Exit Sub
	End If

	If bInOptions = True Then
		Options_UpdateDMD
		Exit Sub
	End If
	
	FlexDMD.LockRenderThread
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
			Else
				FlexDMD.Stage.GetLabel("Player1").Text = FormatScore(PlayerState("PLAYER 1")(SCORE))
			End If
		End If
		If playerState.Exists("PLAYER 2") Then
			If currentPlayer = "PLAYER 2" Then
				FlexDMD.Stage.GetLabel("Player2").Text = "Player 2"
			Else
				FlexDMD.Stage.GetLabel("Player2").Text = FormatScore(PlayerState("PLAYER 2")(SCORE))
			End If
		Else
			If currentBall = 1 Then FlexDMD.Stage.GetLabel("Player2").Text = "PRESS START" Else FlexDMD.Stage.GetLabel("Player2").Text = ""
		End If
		If playerState.Exists("PLAYER 3") Then
			If currentPlayer = "PLAYER 3" Then
				FlexDMD.Stage.GetLabel("Player3").Text = "Player 3"
			Else
				FlexDMD.Stage.GetLabel("Player3").Text = FormatScore(PlayerState("PLAYER 3")(SCORE))
			End If
		Else
			If currentBall = 1 Then FlexDMD.Stage.GetLabel("Player3").Text = "PRESS START" Else FlexDMD.Stage.GetLabel("Player3").Text = ""
		End If
		If playerState.Exists("PLAYER 4") Then
			If currentPlayer = "PLAYER 4" Then
				FlexDMD.Stage.GetLabel("Player4").Text = "Player 4"
			Else
				FlexDMD.Stage.GetLabel("Player4").Text = FormatScore(PlayerState("PLAYER 4")(SCORE))
			End If
		Else
			If currentBall = 1 Then FlexDMD.Stage.GetLabel("Player4").Text = "PRESS START" Else FlexDMD.Stage.GetLabel("Player4").Text = ""
		End If

		If Len(CStr(GetPlayerState(SCORE))) > 9 Then
			FlexDMD.Stage.GetLabel("Content_1").Font = FontScoreActiveScaled
		Else	
			FlexDMD.Stage.GetLabel("Content_1").Font = FontScoreActive
		End If
		FlexDMD.Stage.GetLabel("Content_1").Text = FormatScore(GetPlayerState(SCORE))
		FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 128, 32 , FlexDMD_Align_Center

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
	If len(NumString)>6 then NumString = left(NumString, Len(NumString)-6) & "," & right(NumString,6) 
	If len(NumString)>3 then NumString = left(NumString, Len(NumString)-3) & "," & right(NumString,3)
	FormatScore = NumString
End function


