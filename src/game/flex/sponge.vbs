
Dim FontScoreActive
Dim FontCyber5
Dim Font7
Dim Font5
Dim Font12
Dim FontCyber16_HURRYUP_COLOR
Dim DMDFontMain
Dim DMDFontBig
Dim DMDFontSmall
Dim DMDFontSmallBold
Dim TeenyTinyPixls5Font
Dim FontWhite3

sub CreateGameDMD

	Dim title, af,list

	IF DmdWidth = 256 Then 
		DMDFontMain = "FONTS/sendha32.fnt" 
	Else 
		DMDFontMain = "FlexDMD.Resources.udmd-f6by12.fnt"
	End If

	IF DmdWidth = 256 Then 
		DMDFontSmall = "FlexDMD.Resources.udmd-f5by7.fnt"
	Else 
		DMDFontSmall = "FlexDMD.Resources.udmd-f5by7.fnt"
	End If

	IF DmdWidth = 256 Then 
		DMDFontSmallBold = "FlexDMD.Resources.udmd-f7by5.fnt"
	Else 
		DMDFontSmallBold = "FlexDMD.Resources.udmd-f7by5.fnt"
	End If


	IF DmdWidth = 256 Then 
		DMDFontBig = "FONTS/sendha52.fnt" 
	Else 
		DMDFontBig = "FONTS/sendha32.fnt" '"FlexDMD.Resources.udmd-f12by24.fnt"
	End If

	Set FontScoreActive = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontWhite3 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", vbWhite, RGB(0,0,0), 0)
	Set FontPurple3 = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(255,0,255), RGB(0,0,0), 0)
	Set FontCyber16_HURRYUP_COLOR = FlexDMD.NewFont("FlexDMD.Resources.udmd-f6by12.fnt", RGB(255, 240, 33), RGB(0, 0, 0), 2)
	Set Font12  = FlexDMD.NewFont("FlexDMD.Resources.udmd-f6by12.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set FontCyber5  = FlexDMD.NewFont("FlexDMD.Resources.udmd-f4by5.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set Font7  = FlexDMD.NewFont(DMDFontSmall, vbWhite, RGB(0, 0, 0), 0)
	Set Font5  = FlexDMD.NewFont("FlexDMD.Resources.udmd-f7by5.fnt", vbWhite, RGB(0, 0, 0), 0)
	Set TeenyTinyPixls5Font  = FlexDMD.NewFont("FONTS/arial16.fnt", vbWhite, RGB(0, 0, 0), 0)


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

	scene.AddActor FlexDMD.NewFrame("VSeparator1")
	scene.GetFrame("VSeparator1").Thickness = 1
	scene.GetFrame("VSeparator1").Visible = False
	scene.GetFrame("VSeparator1").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator1").SetBounds 2, 7, ((DMDWidth/2)-12), 1

	scene.AddActor FlexDMD.NewFrame("VSeparator2")
	scene.GetFrame("VSeparator2").Thickness = 1
	scene.GetFrame("VSeparator2").Visible = False
	scene.GetFrame("VSeparator2").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator2").SetBounds ((DMDWidth/2)+10), 7, ((DMDWidth/2)-12), 1

	scene.AddActor FlexDMD.NewFrame("VSeparator3")
	scene.GetFrame("VSeparator3").Thickness = 1
	scene.GetFrame("VSeparator3").Visible = False
	scene.GetFrame("VSeparator3").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator3").SetBounds 2, 24, ((DMDWidth/2)-12), 1

	scene.AddActor FlexDMD.NewFrame("VSeparator4")
	scene.GetFrame("VSeparator4").Thickness = 1
	scene.GetFrame("VSeparator4").Visible = False
	scene.GetFrame("VSeparator4").BorderColor = RGB(255,255,0)
	scene.GetFrame("VSeparator4").SetBounds ((DMDWidth/2)+10), 24, ((DMDWidth/2)-12), 1


	
    Set title = FlexDMD.NewLabel("Content_1", FontScoreActive, " ")
	Set af = title.ActionFactory
	Set list = af.Sequence()
	title.AddAction af.Repeat(list, 1)
	scene.AddActor title

	Dim scene2 
	Set scene2 = FlexDMD.NewGroup("Overlay")

	Set title = FlexDMD.NewImage("BGBlack",		"BGBlack.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG001",		"BG001.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG002",		"BG002.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG003",		"BG003.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG004",		"BG004.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG005",		"BG005.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("vidIntro",	"videos/attract-c.gif")		: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGBetMode", "videos/bet-hurry.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGBoost", "videos/boost-bg.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGCyber", "videos/cyber-bg.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGEmp", "videos/charge_emp.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGNodes", "videos/nodes-complete.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGSkills", "videos/skills.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGEngine", "videos/garage-engine.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGCooling", "videos/garage-cooling.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGFuel", "videos/garage-fuel.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGNode", "videos/node-bg.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGNodeComplete", "videos/node-complete.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title

	Set title = FlexDMD.NewVideo("BGRace1", "videos/race1.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace2", "videos/race2.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace3", "videos/race3.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace4", "videos/race4.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace5", "videos/race4.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRace6", "videos/race4.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRaceLocked", "videos/RaceLocked.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title

    Set title = FlexDMD.NewVideo("BGBonus1", "videos/bonus1.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGBonus2", "videos/bonus2.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGBonus3", "videos/bonus3.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGBonus4", "videos/bonus4.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGBonus5", "videos/bonus5.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title

	Set title = FlexDMD.NewVideo("Mystery0", "videos/mystery_0.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("Mystery1", "videos/mystery_1.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("Mystery2", "videos/mystery_2.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("Mystery3", "videos/mystery_3.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("Mystery4", "videos/mystery_4.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title

	Set title = FlexDMD.NewVideo("TiltWarning", "videos/tilt-warning.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("Tilt", "videos/tilt.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("ExtraBall", "videos/extra-ball.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("ShootAgain", "videos/shoot-again.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title

	On Error Resume Next
	Set title = FlexDMD.NewVideo("BGJackpot", "videos/jackpot.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGSuperJackpot", "videos/super_jackpot.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGRaceWon", "videos/race_won.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGWizardMode", "videos/wizard-mode.gif"): title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : title.loop = false : scene2.AddActor title
	Set title = FlexDMD.NewImage("BG006",		"BG006.png")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGHyper",		"videos/hyper-bg.gif")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGWizJackpot",		"videos/wizard-jackpot.gif")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	Set title = FlexDMD.NewVideo("BGWizEnd",		"videos/wizard-end.gif")	: title.SetBounds 0, 0, DmdWidth, DmdHeight : title.Visible = False : scene2.AddActor title
	If Err Then MsgBox "Missing DMD Files. Please Update DMD Folder"

	scene2.AddActor FlexDMD.NewLabel("TextSmalLine1", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine2", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine3", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine4", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine5", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine6", FontCyber16_HURRYUP_COLOR, " ")
	scene2.AddActor FlexDMD.NewLabel("TextSmalLine7", FontCyber16_HURRYUP_COLOR, " ")

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode =  FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Stage.AddActor scene2
	FlexDMD.Show = False
    'If VRRoom = 0 Then FlexDMD.Show = True Else FlexDMD.Show = False
	FlexDMD.Run = False
	FlexDMD.UnlockRenderThread

End Sub


Sub DMDTimer_Timer
	Exit Sub
	
	FlexDMD.LockRenderThread
	
	If gameBooted = False Then
		'Dim label : Set label = FlexDMD.Stage.GetLabel("TextSmalLine1")
		'label.Font = Font12
		'label.Text = "PLEASE WAIT"
		'label.SetAlignedPosition 128,32,FlexDMD_Align_Center
		'label.visible = True

		'Set label = FlexDMD.Stage.GetLabel("TextSmalLine2")
		'label.Font = Font12
		'label.Text = "BOOTING"
		'label.SetAlignedPosition CurrentItem.StartPos(0),CurrentItem.StartPos(1)+16 - DMD_slide ,FlexDMD_Align_Center
		'label.visible = True
		'DmdQ.Update()
		FlexDMD.UnLockRenderThread
		Exit Sub	
	End If

	If gameStarted = False and  UBound(playerState.Keys()) = -1 Then
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

		End Select
	Else
		Dim currentBall : currentBall = GetPlayerState(CURRENT_BALL)

		FlexDMD.Stage.GetLabel("Ball").Text = "BALL " & currentBall 'BallInPlay
		If playerState.Exists("PLAYER 1") Then
			If currentPlayer = "PLAYER 1" Then
				If GetPlayerState(PLAYER_NAME) = "" Then
					FlexDMD.Stage.GetLabel("Player1").Text = "Player 1"
				Else
					FlexDMD.Stage.GetLabel("Player1").Text = GetPlayerState(PLAYER_NAME)
				End If
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

		If IsNull(currentPlayer) Then
			FlexDMD.Stage.GetLabel("Ball").Visible = False
			FlexDMD.Stage.GetLabel("Content_1").Text = "GAME OVER"
		Else
			FlexDMD.Stage.GetLabel("Ball").Visible = True
			FlexDMD.Stage.GetLabel("Ball").SetAlignedPosition 64, 30, FlexDMD_Align_Center
			FlexDMD.Stage.GetLabel("Content_1").Font = FontScoreActive
			FlexDMD.Stage.GetLabel("Content_1").Text = FormatScore(GetPlayerState(SCORE))
		End If
		FlexDMD.Stage.GetLabel("Content_1").SetAlignedPosition 64, 17, FlexDMD_Align_Center
		
		'DmdQ.Update()

	End If
	FlexDMD.UnLockRenderThread

End Sub

Function FormatScore(ByVal Num)
    dim NumString
    NumString = CStr(abs(Num) )
	If len(NumString)>9 then NumString = left(NumString, Len(NumString)-9) & "," & right(NumString,9)
	If len(NumString)>6 then NumString = left(NumString, Len(NumString)-6) & "," & right(NumString,6) 
	If len(NumString)>3 then NumString = left(NumString, Len(NumString)-3) & "," & right(NumString,3)
	FormatScore = NumString
End function


