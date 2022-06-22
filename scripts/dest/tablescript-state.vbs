'***********************************************************************************************************************
'*****  COLORS                                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim c_augmentationResearch,c_augmentationResearchFull,c_black, c_normal,c_normal_full, c_multiball, c_race, c_perkshot
Dim gameColors(7), gameDomes(7)

gameColors(0) = RGB(99, 13, 95)
gameColors(1) = RGB(17, 247, 255)
gameColors(2) = RGB(173, 112, 20)
gameColors(3) = RGB(4, 120, 255)
gameColors(4) = RGB(255, 0, 0)
gameColors(5) = RGB(64,62,2)
gameColors(6) = RGB(255, 240, 33)
gameColors(7) = RGB(13, 109, 18)

gameDomes(0) = "dome2litpurple"
gameDomes(1) = "dome2litcyan"
gameDomes(2) = "dome2litorange"
gameDomes(3) = "dome2litblue"
gameDomes(4) = "dome2litred"
gameDomes(5) = "dome2litblack"
gameDomes(6) = "dome2lityellow"

const ColorMultiplier = 0.8
const FullColorMultiplier = 0.95


c_augmentationResearch = RGB(8,247,254)
c_multiball = RGB(13, 109, 18)
c_race = RGB(207, 194, 11)
'c_empire_full = RGB(61*FullColorMultiplier,12*FullColorMultiplier,97*FullColorMultiplier)
'c_soviet = RGB(133*ColorMultiplier,12*ColorMultiplier,12*ColorMultiplier)
'c_soviet_full = RGB(133*FullColorMultiplier,12*FullColorMultiplier,12*FullColorMultiplier)

'c_allied = RGB(29*ColorMultiplier,44*ColorMultiplier,144*ColorMultiplier)
'c_allied_full = RGB(29*FullColorMultiplier,44*FullColorMultiplier,144*FullColorMultiplier)

c_black = RGB(0,0,0)
c_normal = RGB(243*ColorMultiplier,242*ColorMultiplier, 255*ColorMultiplier)
c_normal_full = RGB(243*ColorMultiplier,242*ColorMultiplier, 255*ColorMultiplier)

'***********************************************************************************************************************

Sub InitFlexDMD()
	Set FlexDMD = CreateObject("FlexDMD.FlexDMD")
    If FlexDMD is Nothing Then
        MsgBox "No FlexDMD found. This table will NOT run without it."
        Exit Sub
    End If
	SetLocale(1033)
	With FlexDMD
		.GameName = cGameName
		.TableFile = Table1.Filename & ".vpx"
		.Color = RGB(255, 88, 32)
		.RenderMode = FlexDMD_RenderMode_DMD_RGB
		.Width = 128
		.Height = 32
		.Clear = True
		.ProjectFolder = "./CyberRaceDMD/"
		.Run = True
	End With
	FlexDMDCreateWelcomeScene()
End Sub

Sub FlexDMDTimerTest_Timer
Dim DMDp
If FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB Then
	DMDp = FlexDMD.DmdColoredPixels
	If Not IsEmpty(DMDp) Then
		DMDWidth = FlexDMD.Width
		DMDHeight = FlexDMD.Height
		DMDColoredPixels = DMDp
	End If
Else
	DMDp = FlexDMD.DmdPixels
	If Not IsEmpty(DMDp) Then
		DMDWidth = FlexDMD.Width
		DMDHeight = FlexDMD.Height
		DMDPixels = DMDp
	End If
End If
End Sub

'If usePUP = False Then
	InitFlexDMD()
'End Ifs

Dim font : Set font = FlexDMD.NewFont("FlexDMD.Resources.teeny_tiny_pixls-5.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)
Dim bigFont : Set bigFont = FlexDMD.NewFont("FlexDMD.Resources.bm_army-12.fnt", RGB(207, 11, 198),RGB(207, 11, 198), 0)
Sub DisplayCurrentAudioTrack()

	Dim scene : Set scene = FlexDMD.NewGroup("GameModeNormal")

	Dim lblMusic : Set lblMusic = FlexDMD.NewLabel("lblMusic", font, audioTracks(currentTrack)(1))

	scene.AddActor lblMusic
	
	lblMusic.SetAlignedPosition -500, 0, FlexDMD_Align_Center

	Dim afMusic : Set afMusic = lblMusic.ActionFactory
	Dim list : Set list = afMusic.Sequence()
	list.Add afMusic.MoveTo(128, 22, 0)
	list.Add afMusic.Wait(0.5)
	list.Add afMusic.MoveTo(-128, 22, 5.0)
	list.Add afMusic.Show(False)
	lblMusic.AddAction afMusic.Repeat(list, 1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread

End Sub


'Dim BetFrameB: Set BetFrameB = FlexDMD.NewImage("BetFrame_B", "VPX.flexBET&region=0,0,512,128")
'BetFrameB.SetBounds 0, 6, 128, 26
'Dim BetFrameE: Set BetFrameE = FlexDMD.NewImage("BetFrame_E", "VPX.flexBET&region=0,128,512,128")
'BetFrameE.SetBounds 0, 6, 128, 26
'Dim BetFrameT: Set BetFrameT = FlexDMD.NewImage("BetFrame_T", "VPX.flexBET&region=0,256,512,128")
'BetFrameT.SetBounds 0, 6, 128, 26
'Dim BetScene : Set BetScene = FlexDMD.NewGroup("BetCharacters")
'BetScene.AddActor FlexDMD.NewLabel("BetHurryUp", font, "")
'BetScene.AddActor BetFrameB
'BetScene.AddActor BetFrameE
'BetScene.AddActor BetFrameT

Sub DisplayFlexBetHitScreen(frame)
	Exit Sub
	BetFrameB.Visible = False
	BetFrameE.Visible = False
	BetFrameT.Visible = False
	Dim label: Set label = BetScene.GetLabel("BetHurryUp")
	label.SetAlignedPosition 64, 5, FlexDMD_Align_Center
	label.Text = gameState("game")("betHits") & " More Hits"
	Execute frame&".Visible = True"
	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor BetScene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub

Sub vpmTimerFlexUpdateMain
	FlexDMDGameModeNormal()
End Sub
Sub FlexDMDGameModeNormal()
	'DotMatrix.color = RGB(255, 88, 32)

	DisplayFlexBetHitScreen("BetFrameB")
	Exit Sub

	Dim scene : Set scene = FlexDMD.NewGroup("Welcome")
	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "...CYBERRACE...")
	
	scene.AddActor lblTitle
	
	lblTitle.SetBounds 0, 0, 128, 16

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub
Sub FlexDMDGameModeSkillshot()
	'DotMatrix.color = RGB(255, 88, 32)
	Dim scene : Set scene = FlexDMD.NewGroup("GameModeNormal")

	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "SKILLSHOT")
	Dim lblMusic : Set lblMusic = FlexDMD.NewLabel("lblMusic", font, audioTracks(currentTrack)(1))
	Dim lblLeft : Set lblLeft = FlexDMD.NewLabel("lblLeft", bigFont, "<")
	Dim lblRight : Set lblRight = FlexDMD.NewLabel("lblRight", bigFont, ">")

	scene.AddActor lblTitle
	scene.AddActor lblMusic
	scene.AddActor lblLeft
	scene.AddActor lblRight
	
	lblLeft.SetAlignedPosition 3, 2, FlexDMD_Align_TopLeft
	lblRight.SetAlignedPosition 125, 2, FlexDMD_Align_TopRight
	lblTitle.SetAlignedPosition 64, 8, FlexDMD_Align_Center
	
	lblMusic.SetAlignedPosition -500, 0, FlexDMD_Align_TopLeft

	Dim afLeft : Set afLeft = lblLeft.ActionFactory
	dim blinkLeft : Set blinkLeft = afLeft.Sequence()
	blinkLeft.Add afLeft.Show(False)
	blinkLeft.Add afLeft.Wait(0.5)
	blinkLeft.Add afLeft.Show(True)
	blinkLeft.Add afLeft.Wait(0.5)
	lblLeft.AddAction afLeft.Repeat(blinkLeft, -1)

	Dim afRight : Set afRight = lblRight.ActionFactory
	dim blinkRight : Set blinkRight = afRight.Sequence()
	blinkRight.Add afRight.Show(False)
	blinkRight.Add afRight.Wait(0.5)
	blinkRight.Add afRight.Show(True)
	blinkRight.Add afRight.Wait(0.5)
	lblRight.AddAction afRight.Repeat(blinkRight, -1)


	Dim afMusic : Set afMusic = lblMusic.ActionFactory
	Dim list : Set list = afMusic.Sequence()
	list.Add afMusic.MoveTo(128, 22, 0)
	list.Add afMusic.Wait(0.5)
	list.Add afMusic.MoveTo(-128, 22, 5.0)
	list.Add afMusic.Show(False)
	lblMusic.AddAction afMusic.Repeat(list, 1)


	'scene.AddActor FlexDMD.NewLabel("Info", font, "Use Left and Right Magna" & vbLf & "to select Demo")
	'scene.GetLabel("Info").SetAlignedPosition 64, 32, FlexDMD_Align_Bottom

	'scene.AddActor FlexDMD.NewLabel("Left", bigFont, "<")
	'scene.AddActor FlexDMD.NewLabel("Right", bigFont, ">")
	'scene.GetLabel("Left").SetAlignedPosition 3, 32, FlexDMD_Align_BottomLeft
	'scene.GetLabel("Right").SetAlignedPosition 125, 32, FlexDMD_Align_BottomRight
	
	'Dim af
	'Set af = scene.GetLabel("Left").ActionFactory
	'dim blinkLeft : Set blinkLeft = af.Sequence()
	'blinkLeft.Add af.Show(False)
	'blinkLeft.Add af.Wait(0.5)
	'blinkLeft.Add af.Show(True)
	'blinkLeft.Add af.Wait(0.5)
	'scene.GetLabel("Left").AddAction af.Repeat(blinkLeft, -1)

	'Set af = scene.GetLabel("Right").ActionFactory
	'dim blinkRight : Set blinkRight = af.Sequence()
	'blinkRight.Add af.Show(True)
	'blinkRight.Add af.Wait(0.5)
	'blinkRight.Add af.Show(False)
	'blinkRight.Add af.Wait(0.5)
	'scene.GetLabel("Right").AddAction af.Repeat(blinkRight, -1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub

Sub FlexDMDCreateWelcomeScene()


	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor FlexDMD.NewVideo("videoplaying", "videos/attract.gif")
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread


	Exit Sub
	'DotMatrix.color = RGB(255, 88, 32)
	Dim scene : Set scene = FlexDMD.NewGroup("Welcome")
	Dim lblTitle : Set lblTitle = FlexDMD.NewLabel("lblTitle", bigFont, "...CYBERRACE...")
	Dim lblPressStart : Set lblPressStart = FlexDMD.NewLabel("lblPressStart", bigFont, "PRESS START")
	scene.AddActor lblTitle
	scene.AddActor lblPressStart
	
	lblTitle.SetBounds 0, 0, 128, 16
	lblPressStart.SetBounds 0, 16, 128, 16
	'lblPressStart.SetAlignedPosition 128, 32, FlexDMD_Align_Bottom

	Dim afPressStart
	Set afPressStart = lblPressStart.ActionFactory
	dim blinkLeft : Set blinkLeft = afPressStart.Sequence()
	blinkLeft.Add afPressStart.Show(False)
	blinkLeft.Add afPressStart.Wait(0.5)
	blinkLeft.Add afPressStart.Show(True)
	blinkLeft.Add afPressStart.Wait(0.5)
	lblPressStart.AddAction afPressStart.Repeat(blinkLeft, -1)


	'Dim afTitle : Set af = lblTitle.ActionFactory
	'Dim list : Set list = afTitle.Sequence()
	'list.Add afTitle.MoveTo(128, 0, 0)
	'list.Add afTitle.Wait(0.5)
	'list.Add afTitle.MoveTo(-128, 0, 3.0)
	'list.Add afTitle.Wait(0.5)
	'lblTitle.AddAction afTitle.Repeat(list, -1)


	'scene.AddActor FlexDMD.NewLabel("Info", font, "Use Left and Right Magna" & vbLf & "to select Demo")
	'scene.GetLabel("Info").SetAlignedPosition 64, 32, FlexDMD_Align_Bottom

	'scene.AddActor FlexDMD.NewLabel("Left", bigFont, "<")
	'scene.AddActor FlexDMD.NewLabel("Right", bigFont, ">")
	'scene.GetLabel("Left").SetAlignedPosition 3, 32, FlexDMD_Align_BottomLeft
	'scene.GetLabel("Right").SetAlignedPosition 125, 32, FlexDMD_Align_BottomRight
	
	'Dim af
	'Set af = scene.GetLabel("Left").ActionFactory
	'dim blinkLeft : Set blinkLeft = af.Sequence()
	'blinkLeft.Add af.Show(False)
	'blinkLeft.Add af.Wait(0.5)
	'blinkLeft.Add af.Show(True)
	'blinkLeft.Add af.Wait(0.5)
	'scene.GetLabel("Left").AddAction af.Repeat(blinkLeft, -1)

	'Set af = scene.GetLabel("Right").ActionFactory
	'dim blinkRight : Set blinkRight = af.Sequence()
	'blinkRight.Add af.Show(True)
	'blinkRight.Add af.Wait(0.5)
	'blinkRight.Add af.Show(False)
	'blinkRight.Add af.Wait(0.5)
	'scene.GetLabel("Right").AddAction af.Repeat(blinkRight, -1)

	FlexDMD.LockRenderThread
	FlexDMD.RenderMode = FlexDMD_RenderMode_DMD_RGB
	FlexDMD.Stage.RemoveAll
	FlexDMD.Stage.AddActor scene
	FlexDMD.Show = True
	FlexDMD.UnlockRenderThread
End Sub

'Dim audioBGTracks: Set gameLogic=CreateObject("Scripting.Dictionary")

Dim audioTracks, currentTrack, trackCount
audioTracks = Array(Array("500", "White Bat Audio - Glitch in Reality", "195600", "601"), Array("501", "Rob Avery - Untitled", "67200", "602"), Array("508", "WBA - Race Against Sunset", "206400", "603"),Array("509", "WBA - Existence", "212400", "604"))
currentTrack = RndNum(0,UBound(audioTracks))
trackCount = 0
'audioBGTracks.Add "E500", "White Bat Audio - Glitch in Reality"
'audioBGTracks.Add "E501", "Rob Avery - Untitled"

Sub PlayBGAudio

    If currentTrack > -1 Then
        Dim pupCode: pupCode = audioTracks(currentTrack)(0)
        pupevent pupCode
        trackCount=trackCount+1
        DisplayCurrentAudioTrack()
        vpmTimer.AddTimer audioTracks(currentTrack)(2), "vpmTimerNextTrack "&pupCode&","&trackCount&" '"
    End If

End Sub

Sub vpmTimerNextTrack(pupCode, count)
    Debug.print ">"&pupCode&"<"
    Debug.print ">"&count&"<"
    Debug.print ">"&trackCount&"<"
    If currentTrack > -1 Then
        If count = trackCount Then
            Debug.print "MAtch"
            PlayBGAudioNext()
        End If
    End If
End Sub

Sub PlayBGAudioNext()

    If currentTrack = -1 Then
        currentTrack = RndNum(0,UBound(audioTracks))
    End If

    'Debug.Print(currentTrack)
    'Debug.Print(UBound(audioTracks))
    currentTrack=currentTrack+1
    If currentTrack > UBound(audioTracks) Then
        currentTrack = 0
    End If

    PlayBGAudio()

End Sub

Sub StopBGAudio
    dim track
    for each track in audioTracks
        pupevent track(3)
    next
    currentTrack = -1
    pupevent 605'hurryup
    pupevent 503'hackers

End sub


Sub InitPupLabels
    if (usePUP=false or PUPStatus=false) then Exit Sub
    
    PuPlayer.LabelInit pBackglass
    Dim sendhaFont:sendhaFont="Sendha"

    'syntax - PuPlayer.LabelNew <screen# or pDMD>,<Labelname>,<fontName>,<size%>,<colour>,<rotation>,<xAlign>,<yAlign>,<xpos>,<ypos>,<PageNum>,<visible>
    'PuPlayer.LabelNew pBackglass,"Play1",sendhaFont,3,16777215,0,0,1,23,81,1,1

    '				    Scrn        LblName                 Fnt         Size	        Color	 		    R   Ax    Ay    X       Y           pagenum     Visible 
    'PuPlayer.LabelNew pBackglass,"Player"  ,sendhaFont,21*1,RGB(3, 57, 252)	,1,0,0, 0,0,	1,	0
    PuPlayer.LabelNew   pBackglass, "CurScore1",            sendhaFont,    8,           RGB(0, 255, 220),  0,  1,    1,    0,      0,          1,          1
    PuPlayer.LabelNew   pBackglass, "lblPlayer",            sendhaFont,    6,           RGB(0, 255, 220),  0,  0,    0,    26,     33,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblBall",              sendhaFont,    6,           RGB(0, 255, 220),  0,  0,    0,    63,     33,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblAug",               sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    PuPlayer.LabelNew   pBackglass, "lblPerk1",             sendhaFont,	4,              RGB(0, 255, 220),  0,  0,    0,    26,     60,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblPerk2",             sendhaFont,	4,              RGB(18, 155, 143),  0,  0,    0,    26,     65,         1,          1

    PuPlayer.LabelNew   pBackglass, "lblResearchNode",      sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     35,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblLocks",             sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     45,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblSpeeder",           sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     55,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblCombos",            sendhaFont,	3,              RGB(18, 155, 143),  0,  0,    0,    85,     65,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblCombosMade",        sendhaFont,	4,              RGB(18, 155, 143),  0,  0,    0,    85,     70,         1,          1

    'PuPlayer.LabelNew   pBackglass, "lblE",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblS",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblE2",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblA",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblR2",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblC",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblH",                 sendhaFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1

    PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\augLion.png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"
    PuPlayer.LabelSet   pBackglass, "lblPlayer",     "",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblBall",       "",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblPerk1",      "",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblPerk2",      "",                        1,  "{}"

    PuPlayer.LabelSet   pBackglass, "lblResearchNode",      "Research Nodes",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblLocks",      "Locks",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblSpeeder",      "Speeder Parts",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblCombos",      "Combos",                        1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblCombosMade",      "0",                        1,  "{}"
    
End Sub
'***********************************************************************************************************************
'*****  PIN UP UPDATE SCORES                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Dim ScoreSize(4)

Sub pupDMDupdate_Timer()
	If gameStarted Then
		pUpdateScores
	End If
End Sub

'************************ called during gameplay to update Scores ***************************
Sub pUpdateScores  'call this ONLY on timer 300ms is good enough
    
	if (usePUP=false or PUPStatus=false) then Exit Sub

	Dim StatusStr
    Dim Size(4)
    Dim ScoreTag(4)
	

	StatusStr = ""
	'DebugScore = DebugScore + 1000000000

	Dim lenScore:lenScore = Len(DebugScore & "")
	Dim scoreScale:scoreScale=0.6
	If lenScore>10 Then
		scoreScale=scoreScale - ((lenScore-10)/20)
	End If
	ScoreSize(0) = 12*scoreScale

	'if PlayersPlayingGame>1 then ScoreSize(CurrentPlayer)=ScoreSize(CurrentPlayer)-(PlayersPlayingGame+.5)
	ScoreTag(0)="{'mt':2,'size':"& ScoreSize(0) &"}"
	'ScoreTag(1)="{'mt':2,'size':"& ScoreSize(1) &"}"
	'ScoreTag(2)="{'mt':2,'size':"& ScoreSize(2) &"}"
	'ScoreTag(3)="{'mt':2,'size':"& ScoreSize(3) &"}"


    'ScoreTag(CurrentPlayer)=""

	'puPlayer.LabelSet pBackglass,"Player",	"Player " & CurrentPlayer+1	,1,""
	'puPlayer.LabelSet pBackglass,"Ball",	"BALL " & Balls	 & "    "	,1,""
	'Select case PlayersPlayingGame
		'case 1:
		'	if Score(CurrentPlayer)=0 then 
		'		puPlayer.LabelSet pBackglass,"CurScore1", "00"								,1,ScoreTag(0)
		'	else
			'Debug.print("Updating Scores")
			If gameState("game")("hideScore") = False Then
				puPlayer.LabelSet pBackglass,"CurScore1", FormatScore(DebugScore)	 ,1,ScoreTag(0)
				PuPlayer.LabelSet pBackglass, "lblCombosMade",  gameState("game")("combosMade").Count & " / " & GameCombos.Count,                        1,  "{}"
			End If
		'	End if
		'case 2:
		'	PuPlayer.LabelSet pBackglass,"Play1score",FormatScore(Score(0)),1,ScoreTag(0)
		'	PuPlayer.LabelSet pBackglass,"Play2score",FormatScore(Score(1)),1,ScoreTag(1)
		'case 3:
		'	PuPlayer.LabelSet pBackglass,"Play1score",FormatScore(Score(0)),1,ScoreTag(0)
		'	PuPlayer.LabelSet pBackglass,"Play2score",FormatScore(Score(1)),1,ScoreTag(1)
		'	PuPlayer.LabelSet pBackglass,"Play3score",FormatScore(Score(2)),1,ScoreTag(2)
		'case 4:
		'	PuPlayer.LabelSet pBackglass,"Play1score",FormatScore(Score(0)),1,ScoreTag(0)
		'	PuPlayer.LabelSet pBackglass,"Play2score",FormatScore(Score(1)),1,ScoreTag(1)
		'	PuPlayer.LabelSet pBackglass,"Play3score",FormatScore(Score(2)),1,ScoreTag(2)
		'	PuPlayer.LabelSet pBackglass,"Play4score",FormatScore(Score(3)),1,ScoreTag(3)
	'End Select 

	'puPlayer.LabelSet pDMD,"Player",	"Player " & CurrentPlayer+1				,1,""
	'puPlayer.LabelSet pDMD,"Ball",		"Ball " & Balls							,1,""
	'puPlayer.LabelSet pDMD,"CurScore",	FormatScore(Score(CurrentPlayer))		,1,""
	'puPlayer.LabelSet pDMD,"Status",	StatusStr								,1,"1"
	'puPlayer.LabelSet pDMD,"Credits", 	"C  " & Credits							,1,""

end Sub

Function FormatScore(ByVal Num) 'it returns a string with commas
    dim i
    dim NumString
	
    NumString = CStr(abs(Num))

    For i = Len(NumString)-3 to 1 step -3
        if IsNumeric(mid(NumString, i, 1))then
            NumString = left(NumString, i) & "," & right(NumString, Len(NumString)-i)
        end if
    Next
    FormatScore = NumString
End function
'***********************************************************************************************************************
'*****  PIN UP                                                 	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


' COPY EVERYTHING BELOW TO THE TOP OF YOUR TABLE SCRIPT UNDER OPTION EXPLICIT

'****** PuP Variables ******

Dim cPuPPack: Dim PuPlayer: Dim PUPStatus: PUPStatus=false ' dont edit this line!!!

'*************************** PuP Settings for this table ********************************

cPuPPack = "cyberrace"    ' name of the PuP-Pack / PuPVideos folder for this table

'//////////////////// PINUP PLAYER: STARTUP & CONTROL SECTION //////////////////////////

' This is used for the startup and control of Pinup Player

Sub PuPStart(cPuPPack)
    If PUPStatus=true then Exit Sub
    If usePUP=true then
        Set PuPlayer = CreateObject("PinUpPlayer.PinDisplay")
        If PuPlayer is Nothing Then
            usePUP=false
            PUPStatus=false
        Else
            PuPlayer.B2SInit "",cPuPPack 'start the Pup-Pack
            PUPStatus=true
            InitPupLabels
        End If
    End If
End Sub

Sub pupevent(EventNum)
    if (usePUP=false or PUPStatus=false) then Exit Sub
    PuPlayer.B2SData "E"&EventNum,1  'send event to Pup-Pack
End Sub

' ******* How to use PUPEvent to trigger / control a PuP-Pack *******

' Usage: pupevent(EventNum)

' EventNum = PuP Exxx trigger from the PuP-Pack

' Example: pupevent 102

' This will trigger E102 from the table's PuP-Pack

' DO NOT use any Exxx triggers already used for DOF (if used) to avoid any possible confusion

'************ PuP-Pack Startup **************

PuPStart(cPuPPack) 'Check for PuP - If found, then start Pinup Player / PuP-Pack

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Backglass PUP / FlexDMD                             	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const TIMINGS_START_AUG_RESEARCH = "Timings Start Aug Research"
Const TIMINGS_COLLECT_AUGMENTATION = "Timings Collect Augmentation"
Const TIMINGS_BALL_LOCKED = "Timings Ball Locked"
Const TIMINGS_START_MULTIBALL = "Timings Smart Multiball"

Dim pupTimings: Set pupTimings=CreateObject("Scripting.Dictionary")
Dim dmdTimings: Set dmdTimings=CreateObject("Scripting.Dictionary")

pupTimings.Add TIMINGS_START_AUG_RESEARCH, 7000
dmdTimings.Add TIMINGS_START_AUG_RESEARCH, 1000

pupTimings.Add TIMINGS_COLLECT_AUGMENTATION, 10500
dmdTimings.Add TIMINGS_COLLECT_AUGMENTATION, 1000

pupTimings.Add TIMINGS_BALL_LOCKED, 3000
pupTimings.Add TIMINGS_START_MULTIBALL, 5000


Function Timings(tcode)
    If usePup = True Then
        Timings = pupTimings(tcode)
    Else
        Timings = dmdTimings(tcode)
    End If
End Function
Dim dbs1, dbs2, dbsdelta, dbstime, dbstens, dbsones, dbsdecimals
Sub EnableBallSaver(seconds)
	seconds = seconds + 0.3  'padding
	BallSaverTimerExpired.Interval = 1000 * seconds
	BallSaverTimerExpired.Enabled = True

	'p_watchdisplay_full.Visible = True
	p_watchdisplay_left.Visible = True
	p_watchdisplay_right.Visible = True

	LightBlink(lsBallSave)
	'Set display to x seconds 
	dbstime = seconds
	dbsdelta = .1
	BallSaverUpdateTimer.Interval = 100

	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
    BallSaverUpdateTimer.Enabled = True
End Sub

Sub StopBallSaver
	BallSaverTimerExpired.Enabled = False
	BallSaverUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
End Sub

Sub BallSaverTimerExpired_Timer()
    BallSaverTimerExpired.Enabled = False
    BallSaverUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
	DISPATCH GAME_BALL_SAVE_ENDED, null
End Sub

Sub ResetBallSaveDisplay
	p_watchdisplay_left.Visible = False
	p_watchdisplay_right.Visible = False
	p_watchdisplay_full.blenddisablelighting = 0
	p_watchdisplay_left.blenddisablelighting = 0
	p_watchdisplay_right.blenddisablelighting = 0
End Sub

Sub BallSaverUpdateTimer_Timer()
	Dim tmp
	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
End Sub
'***********************************************************************************************************************
'*****  GAME                                                  	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Dim DebugScore
Dim gameState: Set gameState = CreateObject("Scripting.Dictionary")

'----- Phsyics Mods -----
Const RubberizerEnabled = 1			'0 = normal flip rubber, 1 = more lively rubber for flips, 2 = a different rubberizer
Const FlipperCoilRampupMode = 0   	'0 = fast, 1 = medium, 2 = slow (tap passes should work)
Const TargetBouncerEnabled = 1 		'0 = normal standup targets, 1 = bouncy targets, 2 = orig TargetBouncer
Const TargetBouncerFactor = 0.7 	'Level of bounces. Recommmended value of 0.7 when TargetBouncerEnabled=1, and 1.1 when TargetBouncerEnabled=2

Dim FlexDMD
' FlexDMD constants
Const 	FlexDMD_RenderMode_DMD_GRAY = 0, _
		FlexDMD_RenderMode_DMD_GRAY_4 = 1, _
		FlexDMD_RenderMode_DMD_RGB = 2, _
		FlexDMD_RenderMode_SEG_2x16Alpha = 3, _
		FlexDMD_RenderMode_SEG_2x20Alpha = 4, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num = 5, _
		FlexDMD_RenderMode_SEG_2x7Alpha_2x7Num_4x1Num = 6, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num = 7, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_10x1Num = 8, _
		FlexDMD_RenderMode_SEG_2x7Num_2x7Num_4x1Num_gen7 = 9, _
		FlexDMD_RenderMode_SEG_2x7Num10_2x7Num10_4x1Num = 10, _
		FlexDMD_RenderMode_SEG_2x6Num_2x6Num_4x1Num = 11, _
		FlexDMD_RenderMode_SEG_2x6Num10_2x6Num10_4x1Num = 12, _
		FlexDMD_RenderMode_SEG_4x7Num10 = 13, _
		FlexDMD_RenderMode_SEG_6x4Num_4x1Num = 14, _
		FlexDMD_RenderMode_SEG_2x7Num_4x1Num_1x16Alpha = 15, _
		FlexDMD_RenderMode_SEG_1x16Alpha_1x16Num_1x7Num = 16

Const 	FlexDMD_Align_TopLeft = 0, _
		FlexDMD_Align_Top = 1, _
		FlexDMD_Align_TopRight = 2, _
		FlexDMD_Align_Left = 3, _
		FlexDMD_Align_Center = 4, _
		FlexDMD_Align_Right = 5, _
		FlexDMD_Align_BottomLeft = 6, _
		FlexDMD_Align_Bottom = 7, _
		FlexDMD_Align_BottomRight = 8

Sub StartGame()
	
    Dim colors,materials,army,laneLights,lights,gameLogic,switches
    Set gameState = CreateObject("Scripting.Dictionary")
    Set materials = CreateObject("Scripting.Dictionary")

    Set laneLights = InitLaneLightsState
    Set lights = InitLightsState
	Set switches = InitSwitchesState
    Set gameLogic = InitGameLogicState

    materials.Add "allied", mat_allied
    materials.Add "soviet", mat_soviet
    materials.Add "empire", mat_empire
    materials.Add "rgb", mat_rgb
    gameState.Add "materials", materials
    gameState.Add "laneLights", laneLights
    gameState.Add "lights", lights
	gameState.Add "switches", switches
    gameState.Add "game", gameLogic
	
    
	
	StartLightSeq(lSeqHyperJump)
	StartLightSeq(lSeqLeftOrbit)
	StartLightSeq(lSeqLeftRamp)
	StartLightSeq(lSeqSpinner)
	StartLightSeq(lSeqCenterRamp)
	StartLightSeq(lSeqBumpers)
	StartLightSeq(lSeqBumpersFlash)
	StartLightSeq(lSeqRightRamp)
	StartLightSeq(lSeqRightOrbit)
	StartLightSeq(lSeqShortcut)
	StartLightSeq(lSeqPlungerLane)
	StartLightSeq(lSeqMultiballC)
	StartLightSeq(lSeqMultiballY)
	StartLightSeq(lSeqMultiballB)
	StartLightSeq(lSeqMultiballE)
	StartLightSeq(lSeqMultiballR)
	StartLightSeq(lSeqMultiballCYBER)

	gameState("game")("playerName") = "Player 1"
  	gameState("game")("playerBall") = 1
	
	StartLightSeq(lSeqAugmentation)
	StartLightSeq(lSeqCaptive)
	
	gameState("switches")("lightlock") = 1

	StartLightSeq(lSeqLeftDrain)
	StartLightSeq(lSeqRightDrain)

	DebugScore = "0"
	
	LockPin.IsDropped = False
	DISPATCH LIGHTS_RESEARCH_RESET, null
	DISPATCH RESET_LANE_LIGHTS, Null
	DISPATCH GAME_START_OF_BALL, null
	DISPATCH GAME_CHECK_BET, Null
	gameStarted = True
End Sub

'*********************************************************************
'           Game Timer, Ball Rolling, Ball Shadows, Ball Drop
'*********************************************************************

Const tnob = 10 ' total number of balls
ReDim rolling(tnob)
InitRolling

Function BallSpeed(ball) 'Calculates the ball speed
    BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

Sub InitRolling
    Dim i
    For i = 0 to tnob
        rolling(i) = False
    Next
End Sub

Const PlayFDivStart = 180.7

Sub GameTimer_timer()

	Dim BOT, b
	BOT = GetBalls

    'Diverter.RotZ = DiverterFlipper.CurrentAngle
    'Diverter001.RotZ = DiverterFlipper.CurrentAngle

	For b = UBound(BOT) + 1 to tnob
		if rolling(b) Then
			rolling(b) = False
			StopSound("fx_ballrolling" & b)
		End if 
    Next

	' play the rolling sound for each ball
	For b = 0 to UBound(BOT)
		If BallSpeed(BOT(b) ) > 1 AND BOT(b).z < 27 and BOT(b).radius > 23  Then
			rolling(b) = True
			PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b))*RollingSoundFactor, AudioPan(BOT(b)), 0, Pitch(BOT(b)), 1, 0, AudioFade(BOT(b))
		Else
			If rolling(b) = True Then
				StopSound("fx_ballrolling" & b)
				rolling(b) = False
			End If
		End If

		'***Ball Drop Sounds***
		If BOT(b).radius > 23 and BOT(b).VelZ < -1 and BOT(b).z < 55 and BOT(b).z > 27 Then 'height adjust for ball drop sounds
			PlaySound "fx_ball_drop" & b, 0, (ABS(BOT(b).velz)/17)^2, AudioPan(BOT(b)), 0, Pitch(BOT(b)), 1, 0, AudioFade(BOT(b))
		End If

	Next

	cor.update

End Sub

Sub FrameTimer_Timer()
	If gameStarted Then
	'BallShadowUpdate
	'RDampen
	'GatesTimer
	'RollingSound
		LampTimer
		FlipperVisualUpdate
		If DynamicBallShadowsOn=1 Then DynamicBSUpdate 'update ball shadows
	'VR_Primary_plunger.Y = -50 + (5* Plunger.Position) -20
	End IF
End Sub

'******************************************************
'						FUNCTIONS
'******************************************************

'*** PI returns the value for PI
Function PI()
	PI = 4*Atn(1)
End Function

'*** Determines if a Points (px,py) is inside a 4 point polygon A-D in Clockwise/CCW order
Function InRect(px,py,ax,ay,bx,by,cx,cy,dx,dy)
	Dim AB, BC, CD, DA
	AB = (bx*py) - (by*px) - (ax*py) + (ay*px) + (ax*by) - (ay*bx)
	BC = (cx*py) - (cy*px) - (bx*py) + (by*px) + (bx*cy) - (by*cx)
	CD = (dx*py) - (dy*px) - (cx*py) + (cy*px) + (cx*dy) - (cy*dx)
	DA = (ax*py) - (ay*px) - (dx*py) + (dy*px) + (dx*ay) - (dy*ax)
 
	If (AB <= 0 AND BC <=0 AND CD <= 0 AND DA <= 0) Or (AB >= 0 AND BC >=0 AND CD >= 0 AND DA >= 0) Then
		InRect = True
	Else
		InRect = False       
	End If
End Function

Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

Function DistancePL(px,py,ax,ay,bx,by) ' Distance between a point and a line where point is px,py
	DistancePL = ABS((by - ay)*px - (bx - ax) * py + bx*ay - by*ax)/Distance(ax,ay,bx,by)
End Function

Function AnglePP(ax,ay,bx,by)
	AnglePP = Atn2((by - ay),(bx - ax))*180/PI
End Function

Function Atn2(dy, dx)
	If dx > 0 Then
		Atn2 = Atn(dy / dx)
	ElseIf dx < 0 Then
		Atn2 = Sgn(dy) * (PI - Atn(Abs(dy / dx)))
	ElseIf dy = 0 Then
		Atn2 = 0
	Else
		Atn2 = Sgn(dy) * Pi / 2
	End If
End Function

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Light Change Item Class                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightChangeItem
	
	Private m_Frames, m_Idx, m_State, m_initialFrames,m_lampColor,m_image,m_baseImage

        Public Property Get Idx()
                Idx=m_Idx
        End Property

        Public Property Get BaseImage()
                BaseImage=m_baseImage
        End Property

        Public Property Get Image()
                Image=m_image
        End Property
        
	Public Property Let Image(input)
		m_image = input
	End Property

        Public Property Get State()
                State=m_State
        End Property

        Public Property Let State(input)
		m_State = input
	End Property

        Public Sub Blink()
                If m_State = 1 Then
                        m_State = 0
                Else
                        m_State = 1
                End If
                m_Frames = m_initialFrames
	End Sub

        Public Sub Init(idx, state, frames, baseImage)
                m_Idx = idx
                m_State = state
                m_Frames = frames
                m_initialFrames = frames
                m_lampColor = Null
                m_image = baseImage
                m_baseImage = baseImage                
	End Sub

	Public Property Let lampColor(input)
		m_lampColor = input
	End Property

        Public Property Get lampColor()
		lampColor = m_lampColor
	End Property

	Public Property Get Update(framesPassed)
                m_Frames = m_Frames - framesPassed
                
                If m_Idx = 21 Then
                        'Debug.print(m_Idx & ":" & m_Frames)
                        'Debug.print("Frames Passed: "& framesPassed)
                End If
                Update = m_Frames
        End Property

        Public Sub ResetFrames()
                m_Frames = m_initialFrames
        End Sub

End Class

'***********************************************************************************************************************
'*****  Light Seq Item Class                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightSeqItem
	
	Private m_currentIdx, m_sequence, m_name, m_image, m_lampColor,m_updateInterval, m_Frames

        Public Property Get CurrentIdx()
                CurrentIdx=m_currentIdx
        End Property

        Public Property Let CurrentIdx(input)
		m_currentIdx = input
	End Property

        Public Property Get Sequence()
                Sequence=m_sequence
        End Property
        
	Public Property Let Sequence(input)
		m_sequence = input
	End Property

        Public Property Get LampColor()
                LampColor=m_lampColor
        End Property
        
	Public Property Let LampColor(input)
		m_lampColor = input
	End Property

        Public Property Get Image()
                Image=m_image
        End Property
        
	Public Property Let Image(input)
		m_image = input
	End Property

        Public Property Get Name()
                Name=m_name
        End Property
        
	Public Property Let Name(input)
		m_name = input
	End Property        

        Public Property Get UpdateInterval()
                UpdateInterval=m_updateInterval
        End Property

        Public Property Let UpdateInterval(input)
		m_updateInterval = input
	End Property

        Private Sub Class_Initialize()
                m_currentIdx = 0
                m_image = Null
                m_lampColor = Null
                m_updateInterval = 100
        End Sub

        Public Property Get Update(framesPassed)
                m_Frames = m_Frames - framesPassed
                Update = m_Frames
        End Property

        Public Sub ResetFrames()
                m_Frames = m_updateInterval
        End Sub

End Class

'***********************************************************************************************************************
'*****  Light Seq Class                               	                                                            ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightSeq
	
	Private m_repeat, m_name, m_items,m_currentItemIdx,m_resetSequence

        Public Property Get Repeat()
                Repeat=m_repeat
        End Property

        Public Property Let Repeat(input)
		m_repeat = input
	End Property

        Public Property Get Name()
                Name=m_name
        End Property

        Public Property Get Items()
                Items=m_items.Items
        End Property
        
	Public Property Let Name(input)
		m_name = input
	End Property

        Public Property Get ResetSequence()
                ResetSequence=m_resetSequence
        End Property
        
	Public Property Let ResetSequence(input)
		Set m_resetSequence = input
	End Property

        Public Property Get CurrentItem()
                Dim items: items = m_items.Items()
                If UBound(items) = -1 Then       
                        CurrentItem  = Null
                Else
                        Set CurrentItem = items(m_currentItemIdx)                
                End If
	End Property

        Private Sub Class_Initialize()
                m_repeat = 0
                Set m_items = CreateObject("Scripting.Dictionary")
                m_currentItemIdx = 0
                m_resetSequence = Null
        End Sub

        Public Sub AddItem(item)
                If Not IsNull(item) Then
                        If Not m_items.Exists(item.Name) Then
                                m_items.Add item.Name, item
                        End If
                End If
        End Sub

        Public Sub RemoveAll()
                Dim x
                For Each x in items
                        RemoveItem(x)
                Next
        End Sub

        Public Sub RemoveItem(item)
                If Not IsNull(item) Then
                        If m_items.Exists(item.Name) Then
                                m_items.Remove item.Name
                                'DebugOut(item.Name)
                                Dim x
                                For Each x in item.Sequence
                                        If IsArray(x) Then
                                                Dim xx
                                                For Each xx in x
                                                        'DebugOut("Resetting IDX: " & xx.Idx)
                                                        Lampz.state(xx.Idx) = 0
                                                        Lampz.image(xx.Idx) = xx.BaseImage
                                                        xx.Image = xx.BaseImage
                                                Next
                                        Else
                                                'DebugOut("Resetting IDX: " & x.Idx)
                                                Lampz.state(x.Idx) = 0
                                                Lampz.image(x.Idx) = x.BaseImage
                                                x.Image = x.BaseImage
                                        End If
                                Next
                        End If
                End If
        End Sub

        Public Sub NextItem()
                m_currentItemIdx = m_currentItemIdx + 1
                Dim items: items = m_items.Items
                If m_currentItemIdx > UBound(items) Then
                        If Not IsNull(m_resetSequence) Then
                              AddItem(m_resetSequence)  
                              m_resetSequence = Null
                        Else
                                m_currentItemIdx = 0
                                
                                If m_repeat = 0 Then
                                        Dim x
                                        For Each x in items
                                                RemoveItem(x)
                                        Next
                                        m_items.RemoveAll
                                End If
                        End If
                End If
        End Sub

End Class
'***********************************************************************************************************************
'*****     In Game Light Sequences                            	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim lciResearchLit: Set lciResearchLit = New LightChangeItem
lciResearchLit.Init 25,1,180,"pal_purple"

Dim lsResearchReady: Set lsResearchReady = New LightChangeItem
lsResearchReady.Init 25,1,180,"pal_purple"
Dim lsResearchReadyOff: Set lsResearchReadyOff = New LightChangeItem
lsResearchReadyOff.Init 25,0,180,"pal_purple"

Dim lciHoldAug: Set lciHoldAug = New LightChangeItem
lciHoldAug.Init 30,1,180,"pal_purple"

Dim lsHoldAug: Set lsHoldAug = New LightChangeItem
lsHoldAug.Init 30,1,180,"pal_purple"
Dim lsHoldAugOff: Set lsHoldAugOff = New LightChangeItem
lsHoldAugOff.Init 30,0,180,"pal_purple"

Dim lsResearch1: Set lsResearch1 = New LightChangeItem
lsResearch1.Init 21,1,2000,"pal_blue"
Dim lsResearch1Off: Set lsResearch1Off = New LightChangeItem
lsResearch1Off.Init 21,0,180,"pal_blue"

Dim lsResearch2: Set lsResearch2 = New LightChangeItem
lsResearch2.Init 22,1,180,"pal_blue"
Dim lsResearch2Off: Set lsResearch2Off = New LightChangeItem
lsResearch2Off.Init 22,0,180,"pal_blue"

Dim lsResearch3: Set lsResearch3 = New LightChangeItem
lsResearch3.Init 23,0,180,"pal_blue"
Dim lsResearch3Off: Set lsResearch3Off = New LightChangeItem
lsResearch3Off.Init 23,0,180,"pal_blue"


Dim lciFinish: Set lciFinish = New LightChangeItem
lciFinish.Init 49,1,180,"pal_purple"
Dim lciFinishOff: Set lciFinishOff = New LightChangeItem
lciFinishOff.Init 49,0,180,"pal_purple"

Dim lsHyperJump: Set lsHyperJump = New LightChangeItem
lsHyperJump.Init 38,1,180,"pal_purple"





Dim lsShortcut: Set lsShortcut = New LightChangeItem
lsShortcut.Init 37,1,180,"pal_purple"
Dim lsShortcutOff: Set lsShortcutOff = New LightChangeItem
lsShortcutOff.Init 37,0,180,"pal_purple"







Dim lsAug1: Set lsAug1 = New LightChangeItem
lsAug1.Init 0,1,180,"pal_blue"
Dim lsAug1Off: Set lsAug1Off = New LightChangeItem
lsAug1Off.Init 0,0,180,"pal_blue"

Dim lsAug2: Set lsAug2 = New LightChangeItem
lsAug2.Init 3,1,180,"pal_blue"
Dim lsAug2Off: Set lsAug2Off = New LightChangeItem
lsAug2Off.Init 3,0,180,"pal_blue"

Dim lsAug3: Set lsAug3 = New LightChangeItem
lsAug3.Init 6,1,180,"pal_blue"
Dim lsAug3Off: Set lsAug3Off = New LightChangeItem
lsAug3Off.Init 6,0,180,"pal_blue"

Dim lsAug4: Set lsAug4 = New LightChangeItem
lsAug4.Init 1,4,180,"pal_blue"
Dim lsAug4Off: Set lsAug4Off = New LightChangeItem
lsAug4Off.Init 1,0,180,"pal_blue"

Dim lsAug5: Set lsAug5 = New LightChangeItem
lsAug5.Init 4,1,180,"pal_blue"
Dim lsAug5Off: Set lsAug5Off = New LightChangeItem
lsAug5Off.Init 4,0,180,"pal_blue"

Dim lsAug6: Set lsAug6 = New LightChangeItem
lsAug6.Init 7,1,180,"pal_blue"
Dim lsAug6Off: Set lsAug6Off = New LightChangeItem
lsAug6Off.Init 7,0,180,"pal_blue"

Dim lsAug7: Set lsAug7 = New LightChangeItem
lsAug7.Init 2,4,180,"pal_blue"
Dim lsAug7Off: Set lsAug7Off = New LightChangeItem
lsAug7Off.Init 2,0,180,"pal_blue"

Dim lsAug8: Set lsAug8 = New LightChangeItem
lsAug8.Init 5,1,180,"pal_blue"
Dim lsAug8Off: Set lsAug8Off = New LightChangeItem
lsAug8Off.Init 5,0,180,"pal_blue"

Dim lsAug9: Set lsAug9 = New LightChangeItem
lsAug9.Init 8,1,180,"pal_blue"
Dim lsAug9Off: Set lsAug9Off = New LightChangeItem
lsAug9Off.Init 8,0,180,"pal_blue"

Dim lSeqAugmentationFlicker: Set lSeqAugmentationFlicker = new LightSeqItem
lSeqAugmentationFlicker.Name = "lSeqAugmentationFlicker"
lSeqAugmentationFlicker.Image = "pal_blue"
lSeqAugmentationFlicker.Sequence = Array(Array(lsAug1Off,lsAug2Off,lsAug3Off,lsAug4Off,lsAug5Off,lsAug6Off,lsAug7Off,lsAug8Off,lsAug9Off),lsAug1,lsAug2,lsAug3, Array(lsAug1Off,lsAug4),Array(lsAug2Off,lsAug5),Array(lsAug3Off,lsAug6),Array(lsAug4Off,lsAug7),Array(lsAug5Off,lsAug8),Array(lsAug6Off,lsAug9),lsAug7Off,lsAug8Off,lsAug9Off)
lSeqAugmentationFlicker.UpdateInterval = 20

Dim lSeqAugmentation: Set lSeqAugmentation = new LightSeq
lSeqAugmentation.Name = "lSeqAugmentation"

Dim lsBallSaverClock1: Set lsBallSaverClock1 = New LightChangeItem
lsBallSaverClock1.Init 130,1,120,"pal_purple"
Dim lsBallSaverClock1Off: Set lsBallSaverClock1Off = New LightChangeItem
lsBallSaverClock1Off.Init 130,0,120,"pal_purple"

Dim lsBallSaverClock2: Set lsBallSaverClock2 = New LightChangeItem
lsBallSaverClock2.Init 131,1,120,"pal_purple"
Dim lsBallSaverClock2Off: Set lsBallSaverClock2Off = New LightChangeItem
lsBallSaverClock2Off.Init 131,0,120,"pal_purple"

Dim lsBallSaverClock3: Set lsBallSaverClock3 = New LightChangeItem
lsBallSaverClock3.Init 132,1,120,"pal_purple"
Dim lsBallSaverClock3Off: Set lsBallSaverClock3Off = New LightChangeItem
lsBallSaverClock3Off.Init 132,0,120,"pal_purple"

Dim lsBallSave: Set lsBallSave = New LightChangeItem
lsBallSave.Init 123,1,120,"pal_purple"
Dim lsBallSaveOff: Set lsBallSaveOff = New LightChangeItem
lsBallSaveOff.Init 123,0,120,"pal_purple"
Dim lsBet1: Set lsBet1 = New LightChangeItem
lsBet1.Init 9,1,140,"pal_yellow"
Dim lsBet1Off: Set lsBet1Off = New LightChangeItem
lsBet1Off.Init 9,0,140,"pal_yellow"

Dim lsBet2: Set lsBet2 = New LightChangeItem
lsBet2.Init 10,1,140,"pal_yellow"
Dim lsBet2Off: Set lsBet2Off = New LightChangeItem
lsBet2Off.Init 10,0,140,"pal_yellow"

Dim lsBet3: Set lsBet3 = New LightChangeItem
lsBet3.Init 11,1,140,"pal_yellow"
Dim lsBet3Off: Set lsBet3Off = New LightChangeItem
lsBet3Off.Init 11,0,140,"pal_yellow"

Dim lsBonus1: Set lsBonus1 = New LightChangeItem
lsBonus1.Init 107,1,20,"pal_purple"
Dim lsBonus1Off: Set lsBonus1Off = New LightChangeItem
lsBonus1Off.Init 107,0,20,"pal_purple"

Dim lsBonus2: Set lsBonus2 = New LightChangeItem
lsBonus2.Init 108,1,20,"pal_purple"
Dim lsBonus2Off: Set lsBonus2Off = New LightChangeItem
lsBonus2Off.Init 108,0,20,"pal_purple"

Dim lsBonus3: Set lsBonus3 = New LightChangeItem
lsBonus3.Init 109,1,20,"pal_purple"
Dim lsBonus3Off: Set lsBonus3Off = New LightChangeItem
lsBonus3Off.Init 109,0,20,"pal_purple"



Dim lsBump1flash: Set lsBump1flash = New LightChangeItem
lsBump1flash.Init 40,1,80,"pal_purple"

Dim lsBump1flashOff: Set lsBump1flashOff = New LightChangeItem
lsBump1flashOff.Init 40,0,80,"pal_purple"

Dim lsBump2flash: Set lsBump2flash = New LightChangeItem
lsBump2flash.Init 41,1,80,"pal_purple"

Dim lsBump2flashOff: Set lsBump2flashOff = New LightChangeItem
lsBump2flashOff.Init 41,0,80,"pal_purple"

Dim lsBump3flash: Set lsBump3flash = New LightChangeItem
lsBump3flash.Init 42,1,80,"pal_purple"

Dim lsBump3flashOff: Set lsBump3flashOff = New LightChangeItem
lsBump3flashOff.Init 42,0,80,"pal_purple"

Dim lSeqBumpersActiveShot: Set lSeqBumpersActiveShot = new LightSeqItem
lSeqBumpersActiveShot.Name = "lSeqBumpersActiveShot"
lSeqBumpersActiveShot.LampColor = gameColors(0)
lSeqBumpersActiveShot.Sequence = Array(Array(lsBump1flash,lsBump2flash,lsBump3flash), Array(lsBump1flashOff,lsBump2flashOff,lsBump3flashOff))
lSeqBumpersActiveShot.UpdateInterval = 80


Dim lSeqBumper1HitFlash: Set lSeqBumper1HitFlash = new LightSeqItem
lSeqBumper1HitFlash.Name = "lSeqBumper1HitFlash"
lSeqBumper1HitFlash.Sequence = Array(lsBump1flash, lsBump1flashOff)
lSeqBumper1HitFlash.UpdateInterval = 40

Dim lSeqBumper2HitFlash: Set lSeqBumper2HitFlash = new LightSeqItem
lSeqBumper2HitFlash.Name = "lSeqBumper2HitFlash"
lSeqBumper2HitFlash.Sequence = Array(lsBump2flash, lsBump2flashOff)
lSeqBumper2HitFlash.UpdateInterval = 40

Dim lSeqBumper3HitFlash: Set lSeqBumper3HitFlash = new LightSeqItem
lSeqBumper3HitFlash.Name = "lSeqBumper3HitFlash"
lSeqBumper3HitFlash.Sequence = Array(lsBump3flash, lsBump3flashOff)
lSeqBumper3HitFlash.UpdateInterval = 40


Dim lSeqBumpers: Set lSeqBumpers = new LightSeq
lSeqBumpers.Name = "lSeqBumpers"
lSeqBumpers.Repeat = 1

Dim lSeqBumpersFlash: Set lSeqBumpersFlash = new LightSeq
lSeqBumpersFlash.Name = "lSeqBumpersFlash"
Dim lsCaptive1: Set lsCaptive1 = New LightChangeItem
lsCaptive1.Init 26,1,20,"pal_purple"
Dim lsCaptive1Off: Set lsCaptive1Off = New LightChangeItem
lsCaptive1Off.Init 26,0,20,"pal_purple"

Dim lsCaptive2: Set lsCaptive2 = New LightChangeItem
lsCaptive2.Init 27,1,20,"pal_purple"
Dim lsCaptive2Off: Set lsCaptive2Off = New LightChangeItem
lsCaptive2Off.Init 27,0,20,"pal_purple"

Dim lsCaptive3: Set lsCaptive3 = New LightChangeItem
lsCaptive3.Init 28,1,20,"pal_purple"
Dim lsCaptive3Off: Set lsCaptive3Off = New LightChangeItem
lsCaptive3Off.Init 28,0,20,"pal_purple"

Dim lsCaptive4: Set lsCaptive4 = New LightChangeItem
lsCaptive4.Init 29,1,20,"pal_purple"
Dim lsCaptive4Off: Set lsCaptive4Off = New LightChangeItem
lsCaptive4Off.Init 29,0,20,"pal_purple"

Dim lsAugSign1: Set lsAugSign1 = New LightChangeItem
lsAugSign1.Init 15,1,100,"pal_red_darker"
Dim lsAugSign1Off: Set lsAugSign1Off = New LightChangeItem
lsAugSign1Off.Init 15,0,100,"pal_red_darker"

Dim lsAugSign2: Set lsAugSign2 = New LightChangeItem
lsAugSign2.Init 16,1,100,"pal_red_darker"
Dim lsAugSign2Off: Set lsAugSign2Off = New LightChangeItem
lsAugSign2Off.Init 16,0,100,"pal_red_darker"

Dim lsAugSign3: Set lsAugSign3 = New LightChangeItem
lsAugSign3.Init 17,1,100,"pal_red_darker"
Dim lsAugSign3Off: Set lsAugSign3Off = New LightChangeItem
lsAugSign3Off.Init 17,0,100,"pal_red_darker"

Dim lsAugSign4: Set lsAugSign4 = New LightChangeItem
lsAugSign4.Init 18,1,100,"pal_red_darker"
Dim lsAugSign4Off: Set lsAugSign4Off = New LightChangeItem
lsAugSign4Off.Init 18,0,100,"pal_red_darker"

Dim lsAugSign5: Set lsAugSign5 = New LightChangeItem
lsAugSign5.Init 19,1,100,"pal_red_darker"
Dim lsAugSign5Off: Set lsAugSign5Off = New LightChangeItem
lsAugSign5Off.Init 19,0,100,"pal_red_darker"


Dim lSeqCaptiveAugHold: Set lSeqCaptiveAugHold = new LightSeqItem
lSeqCaptiveAugHold.Name = "lSeqCaptiveAugHold"
lSeqCaptiveAugHold.Image = "pal_purple"
lSeqCaptiveAugHold.Sequence = Array(lsCaptive4,lsCaptive3,Array(lsCaptive4Off,lsCaptive2),Array(lsCaptive3Off,lsCaptive1),lsCaptive2Off, lsCaptive1Off)
lSeqCaptiveAugHold.UpdateInterval = 60

Dim lSeqCaptive: Set lSeqCaptive = new LightSeq
lSeqCaptive.Name = "lSeqCaptive"
lSeqCaptive.Repeat = 1


Dim lsCenterRamp: Set lsCenterRamp = New LightChangeItem
lsCenterRamp.Init 34,1,180,"pal_purple"
Dim lsCenterRampOff: Set lsCenterRampOff = New LightChangeItem
lsCenterRampOff.Init 34,0,180,"pal_purple"

Dim lSeqCenterRampActiveShot: Set lSeqCenterRampActiveShot = new LightSeqItem
lSeqCenterRampActiveShot.Name = "lSeqCenterRampActiveShot"
lSeqCenterRampActiveShot.Image = "pal_purple"
lSeqCenterRampActiveShot.Sequence = Array(lsCenterRamp,lsCenterRampOff)

Dim lSeqCenterRamp: Set lSeqCenterRamp = new LightSeq
lSeqCenterRamp.Name = "lSeqCenterRamp"
lSeqCenterRamp.Repeat = 1
Dim lsCombo1: Set lsCombo1 = New LightChangeItem
lsCombo1.Init 115,1,100,"pal_purple"
Dim lsCombo1Off: Set lsCombo1Off = New LightChangeItem
lsCombo1Off.Init 115,0,100,"pal_purple"

Dim lsCombo2: Set lsCombo2 = New LightChangeItem
lsCombo2.Init 116,1,100,"pal_purple"
Dim lsCombo2Off: Set lsCombo2Off = New LightChangeItem
lsCombo2Off.Init 116,0,100,"pal_purple"

Dim lsCombo3: Set lsCombo3 = New LightChangeItem
lsCombo3.Init 117,1,100,"pal_purple"
Dim lsCombo3Off: Set lsCombo3Off = New LightChangeItem
lsCombo3Off.Init 117,0,100,"pal_purple"

Dim lsCombo4: Set lsCombo4 = New LightChangeItem
lsCombo4.Init 118,1,100,"pal_purple"
Dim lsCombo4Off: Set lsCombo4Off = New LightChangeItem
lsCombo4Off.Init 118,0,100,"pal_purple"

Dim lsCombo5: Set lsCombo5 = New LightChangeItem
lsCombo5.Init 119,1,100,"pal_purple"
Dim lsCombo5Off: Set lsCombo5Off = New LightChangeItem
lsCombo5Off.Init 119,0,100,"pal_purple"

Dim lsCyber1: Set lsCyber1 = New LightChangeItem
lsCyber1.Init 110,1,20,"pal_green"
Dim lsCyber1Off: Set lsCyber1Off = New LightChangeItem
lsCyber1Off.Init 110,0,20,"pal_green"

Dim lsCyber2: Set lsCyber2 = New LightChangeItem
lsCyber2.Init 111,1,20,"pal_green"
Dim lsCyber2Off: Set lsCyber2Off = New LightChangeItem
lsCyber2Off.Init 111,0,20,"pal_green"

Dim lsCyber3: Set lsCyber3 = New LightChangeItem
lsCyber3.Init 112,1,20,"pal_green"
Dim lsCyber3Off: Set lsCyber3Off = New LightChangeItem
lsCyber3Off.Init 112,0,20,"pal_green"

Dim lsCyber4: Set lsCyber4 = New LightChangeItem
lsCyber4.Init 113,1,20,"pal_green"
Dim lsCyber4Off: Set lsCyber4Off = New LightChangeItem
lsCyber4Off.Init 113,0,20,"pal_green"

Dim lsCyber5: Set lsCyber5 = New LightChangeItem
lsCyber5.Init 114,1,20,"pal_green"
Dim lsCyber5Off: Set lsCyber5Off = New LightChangeItem
lsCyber5Off.Init 114,0,20,"pal_green"

Dim olr1a: Set olr1a = New LightChangeItem
olr1a.Init 50,1,20,"pal_purple"
Dim olr1b: Set olr1b = new LightChangeItem
olr1b.Init 51,1,20,"pal_purple"

Dim olr1aOff: Set olr1aOff = New LightChangeItem
olr1aOff.Init 50,0,20,"pal_purple"
Dim olr1bOff: Set olr1bOff = new LightChangeItem
olr1bOff.Init 51,0,20,"pal_purple"

Dim olr2a: Set olr2a = New LightChangeItem
olr2a.Init 52,1,20,"pal_purple"
Dim olr2b: Set olr2b = new LightChangeItem
olr2b.Init 53,1,20,"pal_purple"

Dim olr2aOff: Set olr2aOff = New LightChangeItem
olr2aOff.Init 52,0,20,"pal_purple"
Dim olr2bOff: Set olr2bOff = new LightChangeItem
olr2bOff.Init 53,0,20,"pal_purple"

Dim olr3a: Set olr3a = New LightChangeItem
olr3a.Init 54,1,20,"pal_purple"
Dim olr3b: Set olr3b = new LightChangeItem
olr3b.Init 55,1,20,"pal_purple"

Dim olr3aOff: Set olr3aOff = New LightChangeItem
olr3aOff.Init 54,0,20,"pal_purple"
Dim olr3bOff: Set olr3bOff = new LightChangeItem
olr3bOff.Init 55,0,20,"pal_purple"

Dim olr4a: Set olr4a = New LightChangeItem
olr4a.Init 56,1,20,"pal_purple"
Dim olr4b: Set olr4b = new LightChangeItem
olr4b.Init 57,1,20,"pal_purple"

Dim olr4aOff: Set olr4aOff = New LightChangeItem
olr4aOff.Init 56,0,20,"pal_purple"
Dim olr4bOff: Set olr4bOff = new LightChangeItem
olr4bOff.Init 57,0,20,"pal_purple"

Dim olr5a: Set olr5a = New LightChangeItem
olr5a.Init 58,1,20,"pal_purple"
Dim olr5b: Set olr5b = new LightChangeItem
olr5b.Init 59,1,20,"pal_purple"

Dim olr5aOff: Set olr5aOff = New LightChangeItem
olr5aOff.Init 58,0,20,"pal_purple"
Dim olr5bOff: Set olr5bOff = new LightChangeItem
olr5bOff.Init 59,0,20,"pal_purple"

Dim olr6a: Set olr6a = New LightChangeItem
olr6a.Init 60,1,20,"pal_purple"
Dim olr6b: Set olr6b = new LightChangeItem
olr6b.Init 61,1,20,"pal_purple"

Dim olr6aOff: Set olr6aOff = New LightChangeItem
olr6aOff.Init 60,0,20,"pal_purple"
Dim olr6bOff: Set olr6bOff = new LightChangeItem
olr6bOff.Init 61,0,20,"pal_purple"

Dim olr7a: Set olr7a = New LightChangeItem
olr7a.Init 62,1,20,"pal_purple"
Dim olr7b: Set olr7b = new LightChangeItem
olr7b.Init 63,1,20,"pal_purple"

Dim olr7aOff: Set olr7aOff = New LightChangeItem
olr7aOff.Init 62,0,20,"pal_purple"
Dim olr7bOff: Set olr7bOff = new LightChangeItem
olr7bOff.Init 63,0,20,"pal_purple"

Dim olr8a: Set olr8a = New LightChangeItem
olr8a.Init 64,1,20,"pal_purple"
Dim olr8b: Set olr8b = new LightChangeItem
olr8b.Init 65,1,20,"pal_purple"

Dim olr8aOff: Set olr8aOff = New LightChangeItem
olr8aOff.Init 64,0,20,"pal_purple"
Dim olr8bOff: Set olr8bOff = new LightChangeItem
olr8bOff.Init 65,0,20,"pal_purple"

Dim olr9a: Set olr9a = New LightChangeItem
olr9a.Init 66,1,20,"pal_purple"
Dim olr9b: Set olr9b = new LightChangeItem
olr9b.Init 67,1,20,"pal_purple"

Dim olr9aOff: Set olr9aOff = New LightChangeItem
olr9aOff.Init 66,0,20,"pal_purple"
Dim olr9bOff: Set olr9bOff = new LightChangeItem
olr9bOff.Init 67,0,20,"pal_purple"

Dim oll1a: Set oll1a = New LightChangeItem
oll1a.Init 70,1,20,"pal_purple"
Dim oll1b: Set oll1b = new LightChangeItem
oll1b.Init 71,1,20,"pal_purple"

Dim oll1aOff: Set oll1aOff = New LightChangeItem
oll1aOff.Init 70,0,20,"pal_purple"
Dim oll1bOff: Set oll1bOff = new LightChangeItem
oll1bOff.Init 71,0,20,"pal_purple"

Dim oll2a: Set oll2a = New LightChangeItem
oll2a.Init 72,1,20,"pal_purple"
Dim oll2b: Set oll2b = new LightChangeItem
oll2b.Init 73,1,20,"pal_purple"

Dim oll2aOff: Set oll2aOff = New LightChangeItem
oll2aOff.Init 72,0,20,"pal_purple"
Dim oll2bOff: Set oll2bOff = new LightChangeItem
oll2bOff.Init 73,0,20,"pal_purple"

Dim oll3a: Set oll3a = New LightChangeItem
oll3a.Init 74,1,20,"pal_purple"
Dim oll3b: Set oll3b = new LightChangeItem
oll3b.Init 75,1,20,"pal_purple"

Dim oll3aOff: Set oll3aOff = New LightChangeItem
oll3aOff.Init 74,0,20,"pal_purple"
Dim oll3bOff: Set oll3bOff = new LightChangeItem
oll3bOff.Init 75,0,20,"pal_purple"

Dim oll4a: Set oll4a = New LightChangeItem
oll4a.Init 76,1,20,"pal_purple"
Dim oll4b: Set oll4b = new LightChangeItem
oll4b.Init 77,1,20,"pal_purple"

Dim oll4aOff: Set oll4aOff = New LightChangeItem
oll4aOff.Init 76,0,20,"pal_purple"
Dim oll4bOff: Set oll4bOff = new LightChangeItem
oll4bOff.Init 77,0,20,"pal_purple"

Dim oll5a: Set oll5a = New LightChangeItem
oll5a.Init 78,1,20,"pal_purple"
Dim oll5b: Set oll5b = new LightChangeItem
oll5b.Init 79,1,20,"pal_purple"

Dim oll5aOff: Set oll5aOff = New LightChangeItem
oll5aOff.Init 78,0,20,"pal_purple"
Dim oll5bOff: Set oll5bOff = new LightChangeItem
oll5bOff.Init 79,0,20,"pal_purple"

Dim oll6a: Set oll6a = New LightChangeItem
oll6a.Init 80,1,20,"pal_purple"
Dim oll6b: Set oll6b = new LightChangeItem
oll6b.Init 81,1,20,"pal_purple"

Dim oll6aOff: Set oll6aOff = New LightChangeItem
oll6aOff.Init 80,0,20,"pal_purple"
Dim oll6bOff: Set oll6bOff = new LightChangeItem
oll6bOff.Init 81,0,20,"pal_purple"

Dim oll7a: Set oll7a = New LightChangeItem
oll7a.Init 82,1,20,"pal_purple"
Dim oll7b: Set oll7b = new LightChangeItem
oll7b.Init 83,1,20,"pal_purple"

Dim oll7aOff: Set oll7aOff = New LightChangeItem
oll7aOff.Init 82,0,20,"pal_purple"
Dim oll7bOff: Set oll7bOff = new LightChangeItem
oll7bOff.Init 83,0,20,"pal_purple"

Dim oll8a: Set oll8a = New LightChangeItem
oll8a.Init 84,1,20,"pal_purple"
Dim oll8b: Set oll8b = new LightChangeItem
oll8b.Init 85,1,20,"pal_purple"

Dim oll8aOff: Set oll8aOff = New LightChangeItem
oll8aOff.Init 84,0,20,"pal_purple"
Dim oll8bOff: Set oll8bOff = new LightChangeItem
oll8bOff.Init 85,0,20,"pal_purple"

Dim oll9a: Set oll9a = New LightChangeItem
oll9a.Init 86,1,20,"pal_purple"
Dim oll9b: Set oll9b = new LightChangeItem
oll9b.Init 87,1,20,"pal_purple"

Dim oll9aOff: Set oll9aOff = New LightChangeItem
oll9aOff.Init 86,0,20,"pal_purple"
Dim oll9bOff: Set oll9bOff = new LightChangeItem
oll9bOff.Init 87,0,20,"pal_purple"


Dim lSeqLeftDrainBlink: Set lSeqLeftDrainBlink = new LightSeqItem
lSeqLeftDrainBlink.Name = "lSeqLeftDrainBlink"
lSeqLeftDrainBlink.Image = "pal_red_darker"
lSeqLeftDrainBlink.Sequence = Array(Array(oll1a,oll1b),Array(oll2a,oll2b),Array(oll1aOff,oll1bOff,oll3a,oll3b),Array(oll2aOff,oll2bOff,oll4a,oll4b),Array(oll3aOff,oll3bOff,oll5a,oll5b), Array(oll4aOff,oll4bOff,oll6a,oll6b),Array(oll5aOff,oll5bOff,oll7a,oll7b),Array(oll6aOff,oll6bOff,oll8a,oll8b),Array(oll7aOff,oll7bOff,oll9a,oll9b),Array(oll8aOff,oll8bOff),Array(oll9aOff,oll9bOff))
lSeqLeftDrainBlink.UpdateInterval = 20

Dim lSeqRightDrainBlink: Set lSeqRightDrainBlink = new LightSeqItem
lSeqRightDrainBlink.Name = "lSeqRightDrainBlink"
lSeqRightDrainBlink.Image = "pal_red_darker"
lSeqRightDrainBlink.Sequence = Array(Array(olr1a,olr1b),Array(olr2a,olr2b),Array(olr1aOff,olr1bOff,olr3a,olr3b),Array(olr2aOff,olr2bOff,olr4a,olr4b),Array(olr3aOff,olr3bOff,olr5a,olr5b), Array(olr4aOff,olr4bOff,olr6a,olr6b),Array(olr5aOff,olr5bOff,olr7a,olr7b),Array(olr6aOff,olr6bOff,olr8a,olr8b),Array(olr7aOff,olr7bOff,olr9a,olr9b),Array(olr8aOff,olr8bOff),Array(olr9aOff,olr9bOff))
lSeqRightDrainBlink.UpdateInterval = 20

Dim lSeqLeftDrain: Set lSeqLeftDrain = new LightSeq
lSeqLeftDrain.Name = "lSeqLeftDrain"

Dim lSeqRightDrain: Set lSeqRightDrain = new LightSeq
lSeqRightDrain.Name = "lSeqRightDrain"
Dim lsExtraBall: Set lsExtraBall = New LightChangeItem
lsExtraBall.Init 97,1,20,"pal_purple"
Dim lsExtraBallOff: Set lsExtraBallOff = New LightChangeItem
lsExtraBallOff.Init 97,0,20,"pal_purple"

Dim lsHyperJump1: Set lsHyperJump1 = New LightChangeItem
lsHyperJump1.Init 38,1,80,"pal_purple"
Dim lsHyperJump1Off: Set lsHyperJump1Off = New LightChangeItem
lsHyperJump1Off.Init 38,0,80,"pal_purple"

Dim lsHyperJump2: Set lsHyperJump2 = New LightChangeItem
lsHyperJump2.Init 45,1,80,"pal_purple"
Dim lsHyperJump2Off: Set lsHyperJump2Off = New LightChangeItem
lsHyperJump2Off.Init 45,0,80,"pal_purple"

Dim lsHyperJump3: Set lsHyperJump3 = New LightChangeItem
lsHyperJump3.Init 43,1,80,"pal_purple"
Dim lsHyperJump3Off: Set lsHyperJump3Off = New LightChangeItem
lsHyperJump3Off.Init 43,0,80,"pal_purple"

Dim lsHyperJump4: Set lsHyperJump4 = New LightChangeItem
lsHyperJump4.Init 44,1,80,"pal_purple"
Dim lsHyperJump4Off: Set lsHyperJump4Off = New LightChangeItem
lsHyperJump4Off.Init 44,0,80,"pal_purple"

Dim lsHyperJump5: Set lsHyperJump5 = New LightChangeItem
lsHyperJump5.Init 68,1,80,"pal_purple"
Dim lsHyperJump5Off: Set lsHyperJump5Off = New LightChangeItem
lsHyperJump5Off.Init 68,0,80,"pal_purple"

Dim lSeqHyperJumpActiveShot: Set lSeqHyperJumpActiveShot = new LightSeqItem
lSeqHyperJumpActiveShot.Name = "lSeqHyperJumpActiveShot"
lSeqHyperJumpActiveShot.Image = "pal_purple"
lSeqHyperJumpActiveShot.Sequence = Array(lsHyperJump5,lsHyperJump4,Array(lsHyperJump5Off,lsHyperJump3),Array(lsHyperJump4Off,lsHyperJump2),Array(lsHyperJump3Off,lsHyperJump1),lsHyperJump2Off, lsHyperJump1Off)
lSeqHyperJumpActiveShot.UpdateInterval = 60

Dim lSeqHyperJump: Set lSeqHyperJump = new LightSeq
lSeqHyperJump.Name = "lSeqHyperJump"
lSeqHyperJump.Repeat = 1
Dim lsLane1: Set lsLane1 = New LightChangeItem
lsLane1.Init 90,1,180,"pal_orange2"
Dim lsLane1Off: Set lsLane1Off = New LightChangeItem
lsLane1Off.Init 90,0,180,"pal_orange2"

Dim lsLane2: Set lsLane2 = New LightChangeItem
lsLane2.Init 91,1,180,"pal_orange2"
Dim lsLane2Off: Set lsLane2Off = New LightChangeItem
lsLane2Off.Init 91,0,180,"pal_orange2"

Dim lsLane3: Set lsLane3 = New LightChangeItem
lsLane3.Init 92,1,180,"pal_orange2"
Dim lsLane3Off: Set lsLane3Off = New LightChangeItem
lsLane3Off.Init 92,0,180,"pal_orange2"

Dim lsLane4: Set lsLane4 = New LightChangeItem
lsLane4.Init 93,1,180,"pal_orange2"
Dim lsLane4Off: Set lsLane4Off = New LightChangeItem
lsLane4Off.Init 93,0,180,"pal_orange2"



Dim lsLeftOrbit: Set lsLeftOrbit = New LightChangeItem
lsLeftOrbit.Init 31,1,180,"pal_purple"
Dim lsLeftOrbitOff: Set lsLeftOrbitOff = New LightChangeItem
lsLeftOrbitOff.Init 31,0,180,"pal_purple"

Dim lSeqLeftOrbitActiveShot: Set lSeqLeftOrbitActiveShot = new LightSeqItem
lSeqLeftOrbitActiveShot.Name = "lSeqLeftOrbitActiveShot"
lSeqLeftOrbitActiveShot.Image = "pal_purple"
lSeqLeftOrbitActiveShot.Sequence = Array(lsLeftOrbit,lsLeftOrbitOff)

Dim lSeqLeftOrbit: Set lSeqLeftOrbit = new LightSeq
lSeqLeftOrbit.Name = "lSeqLeftOrbit"
lSeqLeftOrbit.Repeat = 1


Dim lsLeftRamp: Set lsLeftRamp = New LightChangeItem
lsLeftRamp.Init 32,1,180,"pal_purple"
Dim lsLeftRampOff: Set lsLeftRampOff = New LightChangeItem
lsLeftRampOff.Init 32,0,180,"pal_purple"

Dim lSeqLeftRampActiveShot: Set lSeqLeftRampActiveShot = new LightSeqItem
lSeqLeftRampActiveShot.Name = "lSeqLeftRampActiveShot"
lSeqLeftRampActiveShot.Image = "pal_purple"
lSeqLeftRampActiveShot.Sequence = Array(lsLeftRamp,lsLeftRampOff)

Dim lSeqLeftRamp: Set lSeqLeftRamp = new LightSeq
lSeqLeftRamp.Name = "lSeqLeftRamp"
lSeqLeftRamp.Repeat = 1
Dim lsLightLock: Set lsLightLock = New LightChangeItem
lsLightLock.Init 98,1,180,"pal_green"
Dim lsLightLockOff: Set lsLightLockOff = New LightChangeItem
lsLightLockOff.Init 98,0,180,"pal_green"

Dim lsPlayfield1: Set lsPlayfield1 = New LightChangeItem
lsPlayfield1.Init 94,1,20,"pal_purple"
Dim lsPlayfield1Off: Set lsPlayfield1Off = New LightChangeItem
lsPlayfield1Off.Init 94,0,20,"pal_purple"

Dim lsPlayfield2: Set lsPlayfield2 = New LightChangeItem
lsPlayfield2.Init 95,1,20,"pal_purple"
Dim lsPlayfield2Off: Set lsPlayfield2Off = New LightChangeItem
lsPlayfield2Off.Init 95,0,20,"pal_purple"

Dim lsPlayfield3: Set lsPlayfield3 = New LightChangeItem
lsPlayfield3.Init 96,1,20,"pal_purple"
Dim lsPlayfield3Off: Set lsPlayfield3Off = New LightChangeItem
lsPlayfield3Off.Init 96,0,20,"pal_purple"

Dim lsPlungerLane1: Set lsPlungerLane1 = New LightChangeItem
lsPlungerLane1.Init 133,1,180,"pal_green"
Dim lsPlungerLane1Off: Set lsPlungerLane1Off = New LightChangeItem
lsPlungerLane1Off.Init 133,0,180,"pal_green"

Dim lsPlungerLane2: Set lsPlungerLane2 = New LightChangeItem
lsPlungerLane2.Init 134,1,180,"pal_green"
Dim lsPlungerLane2Off: Set lsPlungerLane2Off = New LightChangeItem
lsPlungerLane2Off.Init 134,0,180,"pal_green"

Dim lsPlungerLane3: Set lsPlungerLane3 = New LightChangeItem
lsPlungerLane3.Init 135,1,180,"pal_green"
Dim lsPlungerLane3Off: Set lsPlungerLane3Off = New LightChangeItem
lsPlungerLane3Off.Init 135,0,180,"pal_green"

Dim lSeqPlungerLaneItem: Set lSeqPlungerLaneItem = new LightSeqItem
lSeqPlungerLaneItem.Name = "lSeqPlungerLaneItem"
lSeqPlungerLaneItem.Image = "pal_green"
lSeqPlungerLaneItem.Sequence = Array(lsPlungerLane1,lsPlungerLane2,Array(lsPlungerLane1Off,lsPlungerLane3),lsPlungerLane2Off,lsPlungerLane3Off)
lSeqPlungerLaneItem.UpdateInterval = 100

Dim lSeqPlungerLane: Set lSeqPlungerLane = new LightSeq
lSeqPlungerLane.Name = "lSeqPlungerLane"
lSeqPlungerLane.Repeat = 1


Dim lsPop1: Set lsPop1 = New LightChangeItem
lsPop1.Init 120,1,20,"pal_purple"
Dim lsPop1Off: Set lsPop1Off = New LightChangeItem
lsPop1Off.Init 120,0,20,"pal_purple"

Dim lsPop2: Set lsPop2 = New LightChangeItem
lsPop2.Init 121,1,20,"pal_purple"
Dim lsPop2Off: Set lsPop2Off = New LightChangeItem
lsPop2Off.Init 122,0,20,"pal_purple"

Dim lsPop3: Set lsPop3 = New LightChangeItem
lsPop3.Init 122,1,20,"pal_purple"
Dim lsPop3Off: Set lsPop3Off = New LightChangeItem
lsPop3Off.Init 122,0,20,"pal_purple"

Dim lsRace1: Set lsRace1 = New LightChangeItem
lsRace1.Init 100,1,20,"pal_purple"
Dim lsRace1Off: Set lsRace1Off = New LightChangeItem
lsRace1Off.Init 100,0,20,"pal_purple"

Dim lsRace2: Set lsRace2 = New LightChangeItem
lsRace2.Init 101,1,20,"pal_purple"
Dim lsRace2Off: Set lsRace2Off = New LightChangeItem
lsRace2Off.Init 101,0,20,"pal_purple"

Dim lsRace3: Set lsRace3 = New LightChangeItem
lsRace3.Init 102,1,20,"pal_purple"
Dim lsRace3Off: Set lsRace3Off = New LightChangeItem
lsRace3Off.Init 102,0,20,"pal_purple"

Dim lsRace4: Set lsRace4 = New LightChangeItem
lsRace4.Init 103,1,20,"pal_purple"
Dim lsRace4Off: Set lsRace4Off = New LightChangeItem
lsRace4Off.Init 103,0,20,"pal_purple"

Dim lsRace5: Set lsRace5 = New LightChangeItem
lsRace5.Init 104,1,20,"pal_purple"
Dim lsRace5Off: Set lsRace5Off = New LightChangeItem
lsRace5Off.Init 104,0,20,"pal_purple"

Dim lsRace6: Set lsRace6 = New LightChangeItem
lsRace6.Init 105,1,20,"pal_purple"
Dim lsRace6Off: Set lsRace6Off = New LightChangeItem
lsRace6Off.Init 105,0,20,"pal_purple"

Dim lsRaceWizard: Set lsRaceWizard = New LightChangeItem
lsRaceWizard.Init 106,1,20,"pal_purple"
Dim lsRaceWizardOff: Set lsRaceWizardOff = New LightChangeItem
lsRaceWizardOff.Init 106,0,20,"pal_purple"



Dim lsRightOrbit: Set lsRightOrbit = New LightChangeItem
lsRightOrbit.Init 36,1,180,"pal_purple"
Dim lsRightOrbitOff: Set lsRightOrbitOff = New LightChangeItem
lsRightOrbitOff.Init 36,0,180,"pal_purple"

Dim lSeqRightOrbitActiveShot: Set lSeqRightOrbitActiveShot = new LightSeqItem
lSeqRightOrbitActiveShot.Name = "lSeqRightOrbitActiveShot"
lSeqRightOrbitActiveShot.Image = "pal_purple"
lSeqRightOrbitActiveShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqRightOrbitHurryUpShot: Set lSeqRightOrbitHurryUpShot = new LightSeqItem
lSeqRightOrbitHurryUpShot.Name = "lSeqRightOrbitHurryUpShot"
lSeqRightOrbitHurryUpShot.Image = "pal_yellow"
lSeqRightOrbitHurryUpShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqRightOrbit: Set lSeqRightOrbit = new LightSeq
lSeqRightOrbit.Name = "lSeqRightOrbit"
lSeqRightOrbit.Repeat = 1


Dim lsRightRamp: Set lsRightRamp = New LightChangeItem
lsRightRamp.Init 35,1,180,"pal_purple"
Dim lsRightRampOff: Set lsRightRampOff = New LightChangeItem
lsRightRampOff.Init 35,0,180,"pal_purple"

Dim lSeqRightRampActiveShot: Set lSeqRightRampActiveShot = new LightSeqItem
lSeqRightRampActiveShot.Name = "lSeqRightRampActiveShot"
lSeqRightRampActiveShot.Image = "pal_purple"
lSeqRightRampActiveShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqRightRampCollectShot: Set lSeqRightRampCollectShot = new LightSeqItem
lSeqRightRampCollectShot.Name = "lSeqRightRampCollectShot"
lSeqRightRampCollectShot.Image = "pal_green"
lSeqRightRampCollectShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqRightRamp: Set lSeqRightRamp = new LightSeq
lSeqRightRamp.Name = "lSeqRightRamp"
lSeqRightRamp.Repeat = 1
Dim lsShortcut1: Set lsShortcut1 = New LightChangeItem
lsShortcut1.Init 46,1,60,"pal_purple"
Dim lsShortcut1Off: Set lsShortcut1Off = New LightChangeItem
lsShortcut1Off.Init 46,0,60,"pal_purple"

Dim lsShortcut2: Set lsShortcut2 = New LightChangeItem
lsShortcut2.Init 47,1,60,"pal_purple"
Dim lsShortcut2Off: Set lsShortcut2Off = New LightChangeItem
lsShortcut2Off.Init 47,0,60,"pal_purple"

Dim lsShortcut3: Set lsShortcut3 = New LightChangeItem
lsShortcut3.Init 48,1,60,"pal_purple"
Dim lsShortcut3Off: Set lsShortcut3Off = New LightChangeItem
lsShortcut3Off.Init 48,0,60,"pal_purple"

Dim lSeqShortcutBlink: Set lSeqShortcutBlink = new LightSeqItem
lSeqShortcutBlink.Name = "lSeqShortcutBlink"
lSeqShortcutBlink.Image = "pal_purple"
lSeqShortcutBlink.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)


Dim lSeqShortcutActiveShot: Set lSeqShortcutActiveShot = new LightSeqItem
lSeqShortcutActiveShot.Name = "lSeqShortcutActiveShot"
lSeqShortcutActiveShot.Image = "pal_purple"
lSeqShortcutActiveShot.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)

Dim lSeqShortcut: Set lSeqShortcut = new LightSeq
lSeqShortcut.Name = "lSeqShortcut"
lSeqShortcut.Repeat = 1
Dim lsSpeeder: Set lsSpeeder = New LightChangeItem
lsSpeeder.Init 136,1,180,"pal_cyan"
Dim lsSpeederOff: Set lsSpeederOff = New LightChangeItem
lsSpeederOff.Init 136,0,180,"pal_cyan"

'Dim lSeqPlungerLaneItem: Set lSeqPlungerLaneItem = new LightSeqItem
'lSeqPlungerLaneItem.Name = "lSeqPlungerLaneItem"
'lSeqPlungerLaneItem.Image = "pal_green"
'lSeqPlungerLaneItem.Sequence = Array(lsPlungerLane1,lsPlungerLane2,Array(lsPlungerLane1Off,lsPlungerLane3),lsPlungerLane2Off,lsPlungerLane3Off)
'lSeqPlungerLaneItem.UpdateInterval = 100

'Dim lSeqPlungerLane: Set lSeqPlungerLane = new LightSeq
'lSeqPlungerLane.Name = "lSeqPlungerLane"
'lSeqPlungerLane.Repeat = 1




Dim lsSpinner1: Set lsSpinner1 = New LightChangeItem
lsSpinner1.Init 33,1,180,"pal_purple"
Dim lsSpinner1Off: Set lsSpinner1Off = New LightChangeItem
lsSpinner1Off.Init 33,0,180,"pal_purple"
Dim lsSpinner2: Set lsSpinner2 = New LightChangeItem
lsSpinner2.Init 39,1,180,"pal_purple"
Dim lsSpinner2Off: Set lsSpinner2Off = New LightChangeItem
lsSpinner2Off.Init 39,0,180,"pal_purple"

Dim lSeqSpinnerActiveShot: Set lSeqSpinnerActiveShot = new LightSeqItem
lSeqSpinnerActiveShot.Name = "lSeqSpinnerActiveShot"
lSeqSpinnerActiveShot.Image = "pal_purple"
lSeqSpinnerActiveShot.Sequence = Array(Array(lsSpinner1,lsSpinner2), Array(lsSpinner1Off,lsSpinner2Off))

Dim lSeqSpinner: Set lSeqSpinner = new LightSeq
lSeqSpinner.Name = "lSeqSpinner"
lSeqSpinner.Repeat = 1
Dim lSeqMultiballCShot: Set lSeqMultiballCShot = new LightSeqItem
lSeqMultiballCShot.Name = "lSeqMultiballCShot"
lSeqMultiballCShot.Image = "pal_green"
lSeqMultiballCShot.Sequence = Array(lsCyber1,Array(lsCombo1,lsCyber1Off),Array(lsLeftOrbit,lsCombo1Off),lsLeftOrbitOff)
lSeqMultiballCShot.UpdateInterval = 80

Dim lSeqMultiballYShot: Set lSeqMultiballYShot = new LightSeqItem
lSeqMultiballYShot.Name = "lSeqMultiballYShot"
lSeqMultiballYShot.Image = "pal_green"
lSeqMultiballYShot.Sequence = Array(lsCyber2,Array(lsCombo2,lsCyber2Off),Array(lsLeftRamp,lsCombo2Off),lsLeftRampOff)
lSeqMultiballYShot.UpdateInterval = 80

Dim lSeqMultiballBShot: Set lSeqMultiballBShot = new LightSeqItem
lSeqMultiballBShot.Name = "lSeqMultiballBShot"
lSeqMultiballBShot.Image = "pal_green"
lSeqMultiballBShot.Sequence = Array(lsCyber3,Array(lsCombo3,lsCyber3Off),Array(lsCenterRamp,lsCombo3Off),lsCenterRampOff)
lSeqMultiballBShot.UpdateInterval = 80

Dim lSeqMultiballEShot: Set lSeqMultiballEShot = new LightSeqItem
lSeqMultiballEShot.Name = "lSeqMultiballEShot"
lSeqMultiballEShot.Image = "pal_green"
lSeqMultiballEShot.Sequence = Array(lsCyber4,Array(lsCombo4,lsCyber4Off),Array(lsRightRamp,lsCombo4Off),lsRightRampOff)
lSeqMultiballEShot.UpdateInterval = 80

Dim lSeqMultiballRShot: Set lSeqMultiballRShot = new LightSeqItem
lSeqMultiballRShot.Name = "lSeqMultiballRShot"
lSeqMultiballRShot.Image = "pal_green"
lSeqMultiballRShot.Sequence = Array(lsCyber5,Array(lsCombo5,lsCyber5Off),Array(lsRightOrbit,lsCombo5Off),lsRightOrbitOff)
lSeqMultiballRShot.UpdateInterval = 80

Dim lSeqMultiballC: Set lSeqMultiballC = new LightSeq
lSeqMultiballC.Name = "lSeqMultiballC"
lSeqMultiballC.Repeat = 1

Dim lSeqMultiballY: Set lSeqMultiballY = new LightSeq
lSeqMultiballY.Name = "lSeqMultiballY"
lSeqMultiballY.Repeat = 1

Dim lSeqMultiballB: Set lSeqMultiballB = new LightSeq
lSeqMultiballB.Name = "lSeqMultiballB"
lSeqMultiballB.Repeat = 1

Dim lSeqMultiballE: Set lSeqMultiballE = new LightSeq
lSeqMultiballE.Name = "lSeqMultiballE"
lSeqMultiballE.Repeat = 1

Dim lSeqMultiballR: Set lSeqMultiballR = new LightSeq
lSeqMultiballR.Name = "lSeqMultiballR"
lSeqMultiballR.Repeat = 1

Dim lSeqMultiballCYBER: Set lSeqMultiballCYBER = new LightSeq
lSeqMultiballCYBER.Name = "lSeqMultiballCYBER"
lSeqMultiballCYBER.Repeat = 1


Dim lSeqLeftOrbitPerkShot: Set lSeqLeftOrbitPerkShot = new LightSeqItem
lSeqLeftOrbitPerkShot.Name = "lSeqLeftOrbitPerkShot"
lSeqLeftOrbitPerkShot.Image = "pal_orange"
lSeqLeftOrbitPerkShot.Sequence = Array(lsLeftOrbit,lsLeftOrbitOff)

Dim lSeqRightOrbitPerkShot: Set lSeqRightOrbitPerkShot = new LightSeqItem
lSeqRightOrbitPerkShot.Name = "lSeqRightOrbitPerkShot"
lSeqRightOrbitPerkShot.Image = "pal_orange"
lSeqRightOrbitPerkShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqHyperJumpPerkShot: Set lSeqHyperJumpPerkShot = new LightSeqItem
lSeqHyperJumpPerkShot.Name = "lSeqHyperJumpPerkShot"
lSeqHyperJumpPerkShot.Image = "pal_orange"
lSeqHyperJumpPerkShot.Sequence = Array(lsHyperJump5,lsHyperJump4,Array(lsHyperJump5Off,lsHyperJump3),Array(lsHyperJump4Off,lsHyperJump2),Array(lsHyperJump3Off,lsHyperJump1),lsHyperJump2Off, lsHyperJump1Off)
lSeqHyperJumpPerkShot.UpdateInterval = 60

Dim lSeqShortcutPerkShot: Set lSeqShortcutPerkShot = new LightSeqItem
lSeqShortcutPerkShot.Name = "lSeqShortcutPerkShot"
lSeqShortcutPerkShot.Image = "pal_orange"
lSeqShortcutPerkShot.UpdateInterval = 60
lSeqShortcutPerkShot.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)

Dim lSeqRightRampPerkShot: Set lSeqRightRampPerkShot = new LightSeqItem
lSeqRightRampPerkShot.Name = "lSeqRightRampPerkShot"
lSeqRightRampPerkShot.Image = "pal_orange"
lSeqRightRampPerkShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqLeftRampPerkShot: Set lSeqLeftRampPerkShot = new LightSeqItem
lSeqLeftRampPerkShot.Name = "lSeqLeftRampPerkShot"
lSeqLeftRampPerkShot.Image = "pal_orange"
lSeqLeftRampPerkShot.Sequence = Array(lsLeftRamp,lsLeftRampOff)

Dim lSeqCenterRampPerkShot: Set lSeqCenterRampPerkShot = new LightSeqItem
lSeqCenterRampPerkShot.Name = "lSeqCenterRampPerkShot"
lSeqCenterRampPerkShot.Image = "pal_orange"
lSeqCenterRampPerkShot.Sequence = Array(lsCenterRamp,lsCenterRampOff)

Dim lSeqSpinnerPerkShot: Set lSeqSpinnerPerkShot = new LightSeqItem
lSeqSpinnerPerkShot.Name = "lSeqSpinnerPerkShot"
lSeqSpinnerPerkShot.Image = "pal_orange"
lSeqSpinnerPerkShot.Sequence = Array(Array(lsSpinner1,lsSpinner2), Array(lsSpinner1Off,lsSpinner2Off))

Dim lSeqBumpersPerkShot: Set lSeqBumpersPerkShot = new LightSeqItem
lSeqBumpersPerkShot.Name = "lSeqBumpersPerkShot"
lSeqBumpersPerkShot.LampColor = gameColors(2)
lSeqBumpersPerkShot.Sequence = Array(Array(lsBump1flash,lsBump2flash,lsBump3flash), Array(lsBump1flashOff,lsBump2flashOff,lsBump3flashOff))

Dim lSeqSkillshot: Set lSeqSkillshot = new LightSeqItem
lSeqSkillshot.Name = "lSeqSkillshot"
lSeqSkillshot.Image = "pal_yellow"
lSeqSkillshot.Sequence = AppendLightSequenceArray(Array(), Array(lsPop1, lsBet1, lsBet2, lsBet3, lsCenterRamp, lsRace6))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo3, lsRace3, lsBonus2, lsCyber3))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsResearch2, lsCyber4, lsRace1, lsBonus1, lsRightRamp, lsCombo4))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsPop1Off, lsBet1Off, lsBet2Off, lsBet3Off, lsCenterRampOff, lsRace6Off, lsAug1, lsRaceWizard))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo3Off, lsRace3Off, lsBonus1Off, lsCyber4Off, lsAug4, lsAug7, lsBonus3, lsRace2, lsRace5, lsSpinner2, lsPop2))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCyber3Off, lsResearch2Off, lsBonus2Off, lsRace1Off, lsRightRampOff, lsCombo4Off, lciFinish, lsShortcut))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsAug1Off, lsRaceWizardOff, lsHyperJump5, lsHyperJump4, lsHoldAug, lsShortcut1, lsAug2, lsSpinner1))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsAug4Off, lsAug7Off, lsBonus3Off, lsRace2Off, lsRace5Off, lsSpinner2Off, lsPop2Off, lsCombo2, lsCyber2, lsRace4, lsPlayfield2, lsCaptive1, lsCaptive4, lsShortcut2, lsAug5))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lciFinishOff, lsShortcutOff, lsHyperJump5Off, lsLeftRamp, lsHyperJump3, lsCaptive2, lsCaptive3, lsAug8))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsHyperJump4Off, lsHoldAugOff, lsShortcut1Off, lsAug2Off, lsSpinner1Off, lsPlayfield3, lsPop3, lsShortcut3))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo2Off, lsCyber2Off, lsRace4Off, lsPlayfield2Off, lsCaptive1Off, lsCaptive4Off, lsShortcut2Off, lsAug5Off, lsHyperJump2, lsAug3, lsAug6))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLeftRampOff, lsHyperJump3Off, lsCaptive2Off, lsCaptive3Off, lsAug8Off, lsHyperJump1, lsLightLock, lsAug9, lsCyber5))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsPlayfield3Off, lsPop3Off, lsShortcut3Off, lsExtraBall, lsPlayfield1, lsCombo5, lsResearch3, lsLane3))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsHyperJump2Off, lsAug3Off, lsAug6Off, lsResearch1, lsRightOrbit))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsHyperJump1Off, lsLightLockOff, lsAug9Off, lsCyber5Off, lsResearchReady, lsCyber1))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsExtraBallOff, lsPlayfield1Off, lsCombo5Off, lsResearch3Off, lsLane3Off, lsCombo1, lsLane4, olr1a, olr2a, olr3a, olr4a, olr5a, olr6a, olr7a, olr8a, olr9a))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsResearch1Off, lsRightOrbitOff, lsLeftOrbit, olr1b, olr2b, olr3b, olr4b, olr5b, olr6b, olr7b, olr8b, olr9b))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsResearchReadyOff, lsCyber1Off))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsCombo1Off, lsLane4Off, olr1aOff, olr2aOff, olr3aOff, olr4aOff, olr5aOff, olr6aOff, olr7aOff, olr8aOff, olr9aOff, lsLane2))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLeftOrbitOff, olr1bOff, olr2bOff, olr3bOff, olr4bOff, olr5bOff, olr6bOff, olr7bOff, olr8bOff, olr9bOff))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLane2Off, oll1b, oll2b, oll3b, oll4b, oll5b, oll6b, oll7b, oll8b, oll9b))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLane1, oll1a, oll2a, oll3a, oll4a, oll5a, oll6a, oll7a, oll8a, oll9a))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(oll1bOff, oll2bOff, oll3bOff, oll4bOff, oll5bOff, oll6bOff, oll7bOff, oll8bOff, oll9bOff))
lSeqSkillshot.Sequence = AppendLightSequenceArray(lSeqSkillshot.Sequence, Array(lsLane1Off, oll1aOff, oll2aOff, oll3aOff, oll4aOff, oll5aOff, oll6aOff, oll7aOff, oll8aOff, oll9aOff))
lSeqSkillshot.UpdateInterval = 10

Dim lSeqLightsOverride: Set lSeqLightsOverride = new LightSeq
lSeqLightsOverride.Name = "lSeqLightsOverride"

'***********************************************************************************************************************
'*****  COLORS                                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim mat_soviet, mat_empire, mat_allied, mat_rgb

mat_empire = "insertPurpleOn"
mat_soviet = "insertRedOn"
mat_allied = "insertBlueOn"
mat_rgb = "insertOff"

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  GAME DISPATCH                                         	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Dispatch(action, options)
		
    'DebugPost action

    Select Case action

        Case RESET_LANE_LIGHTS:
            ResetLaneLights
        Case ROTATE_LANE_LIGHTS_CLOCKWISE:
            RotateLaneLightsClockwise    
        Case ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE:
            RotateLaneLightsAntiClockwise
        Case LIGHTS_UPDATE:
            LightsUpdate
        Case LIGHTS_GI_ON:
            LightsGiOn
        Case LIGHTS_GI_OFF:
            LightsGiOff
        Case LIGHTS_GI_NORMAL:
            LightsGiNormal
        Case LIGHTS_GI_DOMES:
            LightsGiDomes options
        Case LIGHTS_GI_AUGMENTATION_RESEARCH:
            LightsGiAugmentationResearch     
        Case LIGHTS_GI_MULTIBALL:
            LightsGiMultiball  
        Case LIGHTS_GI_HURRYUP:
            LightsGiHurryup                                        
        Case LIGHTS_START_SEQUENCE:
            LightsStartSequence            
        Case LIGHTS_RESEARCH_OFF:
            LightsResearchOff
        Case LIGHTS_RESEARCH_RESET:
            LightsResearchReset
        Case LIGHTS_RESEARCH_READY_OFF:
            LightsResearchReadyOff            
        Case LIGHTS_AUGMENTATIONS_OFF:
            LightsAugmentationsOff
        Case LIGHTS_PAUSE:
            LightsPause
        Case SWITCH_HIT_AUGMENTATION:
            SwitchHitAugmentation
        Case SWITCH_HIT_CAPTIVE:
            SwitchHitCaptive
        Case SWITCH_HIT_RESEARCH_1:
            SwitchHitResearch1
        Case SWITCH_HIT_RESEARCH_2:
            SwitchHitResearch2
        Case SWITCH_HIT_RESEARCH_3:
            SwitchHitResearch3
        Case SWITCH_HIT_PRE_LEFT_ORBIT:
            SwitchHitPreLeftOrbit
        Case SWITCH_HIT_LEFT_ORBIT:
            SwitchHitLeftOrbit
        Case SWITCH_HIT_PRE_RIGHT_ORBIT:
            SwitchHitPreRightOrbit            
        Case SWITCH_HIT_RIGHT_ORBIT:
            SwitchHitRightOrbit            
        Case SWITCH_LEFT_FLIPPER_DOWN:
            SwitchLeftFlipperDown
        Case SWITCH_RIGHT_FLIPPER_DOWN:
            SwitchRightFlipperDown
        Case SWITCH_HIT_CONSOLE:
            SwitchHitConsole
        Case SWITCH_HIT_SPINNER2:
            SwitchHitSpinner2        
        Case SWITCH_HIT_HYPERJUMP:
            SwitchHitHyperJump
        Case SWITCH_HIT_BUMPER:
            SwitchHitBumper          
        Case SWITCH_HIT_LEFT_RAMP:
            SwitchHitLeftRamp
        Case SWITCH_HIT_RIGHT_RAMP:
            SwitchHitRightRamp
        Case SWITCH_HIT_CENTER_RAMP:
            SwitchHitCenterRamp            
        Case SWITCH_HIT_SHORTCUT:
            SwitchHitShortcut     
        Case SWITCH_HIT_RAMP_PIN:
            SwitchHitRampPin
        Case SWITCH_HIT_PLUNGER_LANE:
            SwitchHitPlungerLane    
        Case SWITCH_HIT_LIGHT_LOCK:
            SwitchHitLightLock
        Case SWITCH_HIT_LEFT_OUTLANE:
            SwitchHitLeftOutlane
        Case SWITCH_HIT_LEFT_INLANE:
            SwitchHitLeftInlane
        Case SWITCH_HIT_RIGHT_INLANE:
            SwitchHitRightInlane
        Case SWITCH_HIT_RIGHT_OUTLANE:
            SwitchHitRightOutlane
        Case SWITCH_HIT_BALL_LOCK:
            SwitchHitBallLock
        Case SWITCH_HIT_SECRET_UPGRADE:
            SwitchHitSecretUpgrade
        Case SWITCH_HIT_BET
            SwitchHitBet
        Case GAME_START_OF_BALL:
            GameStartOfBall
        Case GAME_END_OF_BALL:
            GameEndOfBall        
        Case GAME_AUGMENTATION_READY:
            GameAugmentationReady
        Case GAME_RACE_READY
            GameRaceReady
        Case GAME_START_AUGMENTATION_RESEARCH:
            GameStartAugmentationResearch
        Case GAME_LOCK_AUGMENTATIONS:
            GameLockAugmentations
        Case GAME_UNLOCK_AUGMENTATIONS:
            GameUnLockAugmentations            
        Case GAME_SHOW_LABELS:
            GameShowLabels
        Case GAME_HIDE_LABELS:
            GameHideLabels
        Case GAME_MODE_NORMAL
            GameModeNormal
        Case GAME_MODE_ADVANCE_AUGMENTATION:
            GameModeAdvanceAugmentation
        Case GAME_START_MODE_HURRYUP:
            GameStartModeHurryUp
        Case GAME_MODE_FINISH_AUGMENTATION:
            GameModeFinishAugmentation       
        Case GAME_COMBO
            GameCombo options
        Case GAME_AWARD_HURRYUP
            GameAwardHurryup
        Case GAME_MODE_COLLECT_AUGMENTATION:
            GameModeCollectAugmentation
        Case GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE:
            GameRotateSkillshotAntiClockwise
        Case GAME_ROTATE_SKILLSHOT_CLOCKWISE:
            GameRotateSkillshotClockwise            
        Case GAME_AWARD_SKILLSHOT:
            GameAwardSkillshot
        Case GAME_BALL_SAVE_ENDED:
            GameBallSaveEnded
        Case GAME_ENABLE_BALL_SAVE
            GameEnableBallSave
        Case GAME_ENABLE_BALL_LOCK
            GameEnableBallLock
        Case GAME_DISABLE_BALL_LOCK
            GameDisableBallLock
        Case GAME_CHECK_LOCKS
            GameCheckLocks
        Case GAME_CHECK_LANES
            GameCheckLanes
        Case GAME_CHECK_BET
            GameCheckBet
        Case GAME_CLEAR_SHOTS
            GameClearShots
        Case GAME_MULTIBALL_JACKPOT
            GameMultiballJackpot
        Case GAME_AWARD_PERKSHOT
            GameAwardPerkShot
        Case GAME_ADVANCE_MODE1
            GameAdvanceMode1
        Case GAME_END
            GameEnd
        Case Else
            MsgBox("Action Unknown")
    End Select

End Sub

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Games Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const GAME_AUGMENTATION_READY = "Game Augmentation Ready"
Const GAME_RACE_READY = "Game Race Ready"
Const GAME_START_AUGMENTATION_RESEARCH = "Game Start Augmentation Research"
Const GAME_LOCK_AUGMENTATIONS = "Game Lock Augmentations"
Const GAME_UNLOCK_AUGMENTATIONS = "Game UnLock Augmentations"
Const GAME_SHOW_LABELS = "Game Show Labels"
Const GAME_HIDE_LABELS = "Game Hide Labels"
Const GAME_MODE_ADVANCE_AUGMENTATION = "Game Mode Advance Augmentation"
Const GAME_MODE_FINISH_AUGMENTATION = "Game Mode Finish Augmentation"
Const GAME_MODE_COLLECT_AUGMENTATION = "Game Mode Collect Augmentation"
Const GAME_START_MODE_HURRYUP = "Game Start Mode Hurryup"
Const GAME_COMBO = "Game Combo"
Const GAME_AWARD_HURRYUP = "Game Award Hurry Up"

Const GAME_START_OF_BALL = "Game Start of Ball"
Const GAME_END_OF_BALL = "Game End of Ball"
Const GAME_END = "Game End"

Const GAME_ROTATE_SKILLSHOT_CLOCKWISE = "Game Rotate Skillshot Clockwise"
Const GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE = "Game Rotate Skillshot Anti Clockwise"

Const GAME_AWARD_SKILLSHOT = "Game Award Skillshot"
Const GAME_BALL_SAVE_ENDED = "Game Ball Save Ended"
Const GAME_ENABLE_BALL_SAVE = "Game Enable Ball Save"
Const GAME_ENABLE_BALL_LOCK = "Game Enable Ball Lock"
Const GAME_DISABLE_BALL_LOCK = "Game Disable Ball Lock"

Const GAME_CHECK_LOCKS = "Game Check Locks"
Const GAME_CHECK_LANES = "Game Check Lanes"
Const GAME_CLEAR_SHOTS = "Game Clear Shots"
Const GAME_MULTIBALL_JACKPOT = "Game Multiball Jackpot"
Const GAME_AWARD_PERKSHOT = "Game Award Perkshot"
Const GAME_CHECK_BET = "Game Check Bet"

'Table Modes
Const GAME_ADVANCE_MODE1 = "Game Advance Mode 1"

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Game Dispatch                                   	                                                        ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub GameStartOfBall()

  RPin.IsDropped = 1
  
	Dispatch LIGHTS_GI_ON, Null
	Dispatch LIGHTS_GI_NORMAL, null
  PlayBGAudioNext()
  DOF 210, DOFOn 'MX Effects, Ball ready to Shoot
  
	ballRelease.CreateSizedball BallSize / 2
  ballRelease.Kick 90, 4
  gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True
  gameState("game")("modes")(GAME_MODE_NORMAL) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  gameState("game")("modes")(GAME_MODE_MULTIBALL) = False
  gameState("game")("modes")(GAME_MODE_HURRYUP) = False
  gameState("game")("pauseLights") = False
  'Set Random Aug
  Dim c: c = RndNum(0,8)
  gameState("game")("augmentationActive") = c
  PlayGameCallout("choose_skillshot")
  
  SwitchSetAugmentation False, "pal_yellow"
  gameState("game")("ballsInPlay") = 1
  FlexDMDGameModeSkillshot()

	lSeqPlungerLane.RemoveAll()
  lSeqPlungerLane.AddItem(lSeqPlungerLaneItem)

  DISPATCH GAME_CHECK_LOCKS, Null
  DISPATCH GAME_CHECK_LANES, Null
  DISPATCH GAME_CHECK_BET, Null
  DISPATCH GAME_SHOW_LABELS, null
  diverterWall3On.IsDropped = True
  diverterWall3Off.IsDropped = False
  LightOn(lsCyber4)
  
  
End Sub

Sub GameEndOfBall()
  EndMusic
  Dispatch LIGHTS_GI_OFF, Null
  If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
    DISPATCH LIGHTS_RESEARCH_OFF, Null
    StopLightBlink(lciFinish)
    GameModeSetShot -1, "pal_purple"
  End If
  DISPATCH GAME_CLEAR_SHOTS, Null
  gameState("game")("pauseLights") = True
  StopBallSaver()
  DISPATCH LIGHTS_PAUSE, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
  lsSpeeder.Image="pal_cyan"
  LightOff(lsSpeeder)
  'play pup
  StopBGAudio()
  vpmTimer.addtimer 3000, "vpmTimerGameEndOfBallStage2 '"

End Sub

Sub vpmTimerGameEndOfBallStage2()

  If gameState("game")("playerBall") = 3 Then
    DISPATCH GAME_END, Null
  Else
    gameState("game")("playerBall") = gameState("game")("playerBall") + 1
    DISPATCH GAME_START_OF_BALL, Null
  End If
End Sub

Sub GameEnd
  'END GAME
  gameStarted = false
  LockPin.IsDropped = True
End Sub

Sub GameRotateSkillshotAntiClockwise()

  Dim i:i=gameState("game")("augmentationActive")-1
  If i<0 Then
    i = 8
  End If
  gameState("game")("augmentationActive") = i
  SwitchSetAugmentation False, "pal_yellow"

End Sub

Sub GameRotateSkillshotClockwise()

  Dim i:i=gameState("game")("augmentationActive")+1
  If i>8 Then
    i = 0
  End If
  gameState("game")("augmentationActive") = i
  SwitchSetAugmentation False, "pal_yellow"

End Sub

Sub GameAugmentationReady()
    gameState("game")("augmentationReady") = True
    LightBlink(lciResearchLit)
    'objFluxTimer(1).UserValue = 1
    'objFluxBase(1).UserValue = 0.4
    'FluxObjlevel(1) = 0.1 : FlasherFluxTimer1_Timer
    'LightFluxFlash 1, FlasherFluxTimer1
    'objFluxTimer(2).UserValue = 1
    'objFluxBase(2).UserValue = 0.4
    'FluxObjlevel(2) = 0.1 : FlasherFluxTimer2_Timer
    'LightFluxFlash 2, FlasherFluxTimer2
End Sub

Sub GameRaceReady()
    gameState("game")("raceReady") = True
End Sub

Sub GameStartAugmentationResearch()
  
  gameState("game")("modes")(GAME_MODE_NORMAL) = False
  gameState("game")("modes")(GAME_MODE_HURRYUP) = False
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True
  'gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = 0
  gameState("game")("augmentationReady") = False
  TurnOffFluxFlasher(1)
  TurnOffFluxFlasher(2)
  LightOff(lsBet1)
  LightOff(lsBet2)
  LightOff(lsBet3)
  DISPATCH LIGHTS_RESEARCH_OFF, null
  DISPATCH LIGHTS_RESEARCH_READY_OFF, null
  DISPATCH GAME_HIDE_LABELS, null
  DISPATCH LIGHTS_AUGMENTATIONS_OFF, null
  DISPATCH GAME_CHECK_LOCKS, Null
  GameModeSetShot -1, "pal_purple"
  LightOff(lsSpeeder)
  Select Case gameState("game")("augmentationActive")
    Case 0:
      pupevent 404 'tiger, spinner
    Case 1:
      pupevent 401 'bumpers,bat
    Case 2:
      pupevent 400 'hyperjump,bull
    Case 3:
      pupevent 405 'left orbit, lion
    Case 4:
      pupevent 402 'right orbit,hawk
    Case 5:
      pupevent 407 'shortcut,deer
    Case 6:
      pupevent 403 'panther, left ramp
    Case 7:
      pupevent 406 'rightramp,owl
    Case 8:
      pupevent 408 'centerramp,rhino
  End Select  
  StopBGAudio()
  vpmTimer.addtimer Timings(TIMINGS_START_AUG_RESEARCH), "vpmTimerGameStartAugmentationResearchStage2 '"
End Sub

Sub vpmTimerGameStartAugmentationResearchStage2
    pupevent 600 'main bg
    pupevent 504 'music - hackers
    DISPATCH GAME_SHOW_LABELS, null
    DISPATCH GAME_LOCK_AUGMENTATIONS, null
    DISPATCH LIGHTS_GI_AUGMENTATION_RESEARCH, null
    LightBlink(lsResearch1)
    LightBlink(lsResearch2)
    LightBlink(lsResearch3)
    'Setup Shots
    SetAugmentationResearchShots()
    lsSpeeder.Image="pal_purple"
    LightOn(lsSpeeder)
    DISPATCH GAME_ENABLE_BALL_SAVE, Null
    'consoleKicker.Kick 0, 30, 1.36
    vukCenterRamp.Kick 0, 120, .5
End Sub

Sub GameLockAugmentations()
  gameState("game")("augmentationHold") = 2
  
  'Set Aug Lights to Hold Mode.
  Dim aug
  For Each aug in lcAugmentations
      aug.Image = "pal_red_darker"
      LightOn(aug)
  Next

  If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
    LightOn(lsAugSign1)
    LightOn(lsAugSign2)
    LightOn(lsAugSign3)
    LightOn(lsAugSign4)
    LightBlink(lsAugSign5)
    gameState("game")("augmentationHoldCountdown") = 5
    vpmTimer.addtimer 10000, "vpmTimerGameAugmentationHeldCountdown '"
  End If

  lcAugmentations(gameState("game")("augmentationActive")).Image = "pal_blue"
  LightBlink(lcAugmentations(gameState("game")("augmentationActive")))
  lSeqCaptive.RemoveItem(lSeqCaptiveAugHold)
  StopLightBlink(lciHoldAug)
  gameState("switches")("captive") = 1
End Sub

Sub vpmTimerGameAugmentationHeldCountdown

  If gameState("game")("modes")(GAME_MODE_NORMAL) = False Then
    LightOff(lsAugSign1)
    LightOff(lsAugSign2)
    LightOff(lsAugSign3)
    LightOff(lsAugSign4)
    LightOff(lsAugSign5)
    Exit Sub
  End If

  Dim x: x = gameState("game")("augmentationHoldCountdown")
  If gameState("game")("augmentationHold") = 2 Then
    If x > 1 Then
      Execute "LightOff(lsAugSign"&x&") : LightBlink(lsAugSign"&x-1&")"
      vpmTimer.addtimer 10000, "vpmTimerGameAugmentationHeldCountdown '"
      gameState("game")("augmentationHoldCountdown") = x-1
    Else
      Execute "LightOff(lsAugSign"&x&")"
      DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
      gameState("game")("augmentationHoldCountdown") =0
    End If
  End If
End Sub

Sub GameUnlockAugmentations()
  gameState("game")("augmentationHold") = 1
  gameState("game")("augmentationHoldCountdown") =0
  Dim aug
  For Each aug in lcAugmentations
      aug.Image = "pal_blue"
  Next
  LightOff(lsAug1)
  LightOff(lsAug2)
  LightOff(lsAug3)
  LightOff(lsAug4)
  LightOff(lsAug5)
  LightOff(lsAug6)
  LightOff(lsAug7)
  LightOff(lsAug8)
  LightOff(lsAug9)
  LightOn(lcAugmentations(gameState("game")("augmentationActive")))
  lSeqCaptive.AddItem(lSeqCaptiveAugHold)
  LightBlink(lciHoldAug)
  gameState("switches")("captive") = 0
  LightOff(lsAugSign1)
  LightOff(lsAugSign2)
  LightOff(lsAugSign3)
  LightOff(lsAugSign4)
  LightOff(lsAugSign5)
End Sub

Sub GameHideLabels()
  gameState("game")("hideScore") = True

  if (usePUP=false or PUPStatus=false) then Exit Sub
  
  PuPlayer.LabelSet   pBackglass, "lblAug",         "PupOverlays\\augLion.png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':100}"
  PuPlayer.LabelSet   pBackglass, "lblPlayer",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblBall",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblPerk1",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblPerk2",        "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "CurScore1",      "",   1,  "{}"

  PuPlayer.LabelSet   pBackglass, "lblResearchNode",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblLocks",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblSpeeder",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombos",      "",   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombosMade",      "",   1,  "{}"
End Sub

Sub GameShowLabels()
  gameState("game")("hideScore") = False

  if (usePUP=false or PUPStatus=false) then Exit Sub
  
  PuPlayer.LabelSet   pBackglass, "lblPlayer",    gameState("game")("playerName"),                 1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblBall",      "Ball "&gameState("game")("playerBall"),                   1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\aug" & AugmentationNames(gameState("game")("augmentationActive")) & ".png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"

  PuPlayer.LabelSet   pBackglass, "lblResearchNode",      "Research Nodes",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblLocks",      "Locks",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblSpeeder",      "Speeder Parts",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombos",      "Combos",                        1,  "{}"
  PuPlayer.LabelSet   pBackglass, "lblCombosMade",  gameState("game")("combosMade").Count & " / " & GameCombos.Count,                        1,  "{}"

End Sub

Sub GameSetAugmentationPerkLabels()

  Dim augName
  Select Case gameState("game")("augmentationActive")
    Case 0:
      augName = "Tiger"
    Case 1:
      augName = "Bat"
    Case 2:
      augName = "Bull"
    Case 3:
      augName = "Lion"
    Case 4:
      augName = "Hawk"
    Case 5:
      augName = "Deer"
    Case 6:
      augName = "Panther"
    Case 7:
      augName = "Owl"
    Case 8:
      augName = "Rhino"
  End Select
  Dim augLvl
  Execute "augLvl = AugmentationPerksLvl"&  gameState("game")("aug" & augName & "Lvl")+1 &"(gameState(""game"")(""augmentationActive""))"
  Execute "PuPlayer.LabelSet   pBackglass, ""lblPerk1"",      ""Perk :             " & augLvl & """,                        1,  ""{}"""
  If Not gameState("game")("aug" & augName & "Lvl") = 2 Then
    Dim augLvl2
    Execute "augLvl2 = AugmentationPerksLvl"&  gameState("game")("aug" & augName & "Lvl")+2 &"(gameState(""game"")(""augmentationActive""))"
    Execute "PuPlayer.LabelSet   pBackglass, ""lblPerk2"",      ""Next Level :   " & augLvl2 & """,                        1,  ""{}"""
  Else
    PuPlayer.LabelSet   pBackglass, "lblPerk2",      "Next Level :   Frenzy",                   1,  "{}"
  End If

End Sub

Sub GameModeNormal()
  gameState("game")("modes")(GAME_MODE_NORMAL) = True
  DISPATCH LIGHTS_GI_NORMAL, null
  DISPATCH GAME_SHOW_LABELS, null
  DISPATCH GAME_CHECK_LOCKS, Null
  DISPATCH GAME_CHECK_LANES, Null
  DISPATCH GAME_CHECK_BET, Null
  'TODO CHECK RESEARCH NODES
End Sub

Sub GameModeAdvanceAugmentation()

  LightSeqAttract.StopPlay
  LightSeqAttract.UpdateInterval = 8
  LightSeqAttract.Play SeqStripe1VertOn , 10, 0
  PlaySound "shothit2"

  lSeqHyperJump.RemoveItem(lSeqHyperJumpActiveShot)
  lSeqLeftOrbit.RemoveItem(lSeqLeftOrbitActiveShot)
  lSeqShortcut.RemoveItem(lSeqShortcutActiveShot)
  lSeqRightOrbit.RemoveItem(lSeqRightOrbitActiveShot)
  lSeqRightRamp.RemoveItem(lSeqRightRampActiveShot)
  lSeqCenterRamp.RemoveItem(lSeqCenterRampActiveShot)
  lSeqSpinner.RemoveItem(lSeqSpinnerActiveShot)
  lSeqBumpers.RemoveItem(lSeqBumpersActiveShot)
  lSeqLeftRamp.RemoveItem(lSeqLeftRampActiveShot)

  gameState("game")("gameShots")(GAME_MODE_AUGMENTATION_RESEARCH).RemoveAll()

  gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") + 1
  SetAugmentationResearchShots()
End Sub

Sub SetAugmentationResearchShots()

  Select Case gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage")
    Case 0:
      GameModeSetShot gameState("game")("augmentationActive"), "pal_purple"
    Case 1:
      Dim s1: s1 = RndNum(0,8)
      Do While s1=gameState("game")("augmentationActive")
        s1=RndNum(0,8)
      Loop
      'Random Two Shots
      GameModeSetShot s1, "pal_purple"

      Dim s2: s2 = RndNum(0,8)
      Do While s2=gameState("game")("augmentationActive") Or s2=s1
        s2=RndNum(0,8)
      Loop
      'Random Two Shots
      GameModeSetShot s2, "pal_purple"
    Case 2:
      GameModeSetShot gameState("game")("augmentationActive"), "pal_purple"
    Case 3:
      'Finish Shot
      lSeqRightRamp.AddItem(lSeqRightRampCollectShot)
      LightBlink(lciFinish)
      AddGameTargetShot GAME_SHOT_RIGHT_RAMP_COLLECT, GAME_MODE_AUGMENTATION_RESEARCH
  End Select

End Sub

Sub GameModeFinishAugmentation()
  gameState("game")("augmentationResearch"&gameState("game")("augmentationActive")&"Stage") = 0
  lSeqRightRamp.RemoveItem(lSeqRightRampCollectShot)
  StopLightBlink(lciFinish)
  RPin.IsDropped = 0
End Sub

Sub GameModeCollectAugmentation()

  DISPATCH LIGHTS_GI_OFF, Null
  'pupevent 503 'stop music hackers
  EndMusic
  gameState("game")("gameShots")(GAME_MODE_AUGMENTATION_RESEARCH).RemoveAll()
  DISPATCH GAME_HIDE_LABELS, null
  PlaySound "shothit2"
  
  gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) + 1
  If gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 2 Then
    'TODO PUPEVENT OVERDRIVE MULTIBALL

  Else

    Select Case gameState("game")("augmentationActive")
      Case 0:
        pupevent 411 'tiger, hyperjump
      Case 1:
        pupevent 413 'leftorbit,bat
      Case 2:
        'pupevent 400 'leftramp,bull
      Case 3:
        pupevent 410 'spinner, lion
      Case 4:
        pupevent 414 'bumpers,hawk
      Case 5:
        'pupevent 407 'center ramps,deer
      Case 6:
        'pupevent 403 'rightramp,panther
      Case 7:
        'pupevent 406 'right orbit,owl
      Case 8:
        'pupevent 408 'shortcut,rhino
    End Select

  End If

  vpmTimer.addtimer Timings(TIMINGS_COLLECT_AUGMENTATION), "vpmTimerGameFinishAugmentationResearchStage2 '"

End Sub

Sub vpmTimerGameFinishAugmentationResearchStage2
  pupevent 600
  PlayBGAudioNext()
  RPin.IsDropped = 1
  DISPATCH LIGHTS_GI_ON, Null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, null
  DISPATCH LIGHTS_RESEARCH_RESET, null
  DISPATCH GAME_CHECK_BET, Null
  gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = False
  
  DISPATCH GAME_MODE_NORMAL, Null
  
  If gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 2 Then
    'TODO DISPATCH OVERDRIVE MULTIBALL
    gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 1
  End If

  SwitchSetAugmentation True, "pal_orange"
End Sub

Sub GameModeSetShot(s, palette)
  Select Case s
    Case -1:
      StopLightBlink(lciHoldAug)
      lSeqHyperJump.RemoveAll()
      lSeqLeftOrbit.RemoveAll()
      lSeqShortcut.RemoveAll()
      lSeqRightOrbit.RemoveAll()
      lSeqRightRamp.RemoveAll()
      lSeqCenterRamp.RemoveAll()
      lSeqSpinner.RemoveAll()
      lSeqBumpers.RemoveAll()
      lSeqLeftRamp.RemoveAll()
    Case 0:
      'lSeqHyperJumpActiveShot.Image = palette
      lSeqHyperJump.AddItem(lSeqHyperJumpActiveShot)
      AddGameTargetShot GAME_SHOT_HYPER_JUMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 1:
      'lSeqLeftOrbitActiveShot.Image = palette
      lSeqLeftOrbit.AddItem(lSeqLeftOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH
    Case 2:
      'lSeqLeftRampActiveShot.Image = palette
      lSeqLeftRamp.AddItem(lSeqLeftRampActiveShot)
      AddGameTargetShot GAME_SHOT_LEFT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 3:
      'lSeqSpinnerActiveShot.Image = palette
      lSeqSpinner.AddItem(lSeqSpinnerActiveShot)
      AddGameTargetShot GAME_SHOT_SPINNER,GAME_MODE_AUGMENTATION_RESEARCH
    Case 4:
      'lSeqBumpersActiveShot.Image = palette
      lSeqBumpers.AddItem(lSeqBumpersActiveShot)
      AddGameTargetShot GAME_SHOT_BUMPERS,GAME_MODE_AUGMENTATION_RESEARCH
    Case 5:
      'lSeqCenterRampActiveShot.Image = palette
      lSeqCenterRamp.AddItem(lSeqCenterRampActiveShot)
      AddGameTargetShot GAME_SHOT_CENTER_RAMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 6:
      'lSeqRightRampActiveShot.Image = palette
      lSeqRightRamp.AddItem(lSeqRightRampActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH
    Case 7:
      'lSeqRightOrbitActiveShot.Image = palette
      lSeqRightOrbit.AddItem(lSeqRightOrbitActiveShot)
      AddGameTargetShot GAME_SHOT_RIGHT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH
    Case 8:
      'lSeqShortcutActiveShot.Image = palette
      lSeqShortcut.AddItem(lSeqShortcutActiveShot)
      AddGameTargetShot GAME_SHOT_SHORTCUT,GAME_MODE_AUGMENTATION_RESEARCH
  End Select
End Sub

Sub AddGameTargetShot(shot, gameMode)

	If Not gameState("game")("gameShots")(gameMode).Exists(shot) Then
		gameState("game")("gameShots")(gameMode).Add shot, True
	End If

End Sub

Function IsActiveGameShot(shot, gameMode)

  If gameState("game")("gameShots")(gameMode).Exists(shot) Then
    IsActiveGameShot = True
  Else
    IsActiveGameShot = False
  End If
  
End Function

Sub RemoveGameTargetShot(shot, gameMode)

	If gameState("game")("gameShots")(gameMode).Exists(shot) Then
		gameState("game")("gameShots")(gameMode).Remove shot
	End If

End Sub

Sub GameAwardSkillshot()
  gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
  PlayGameCallout("skillshot")
  DOF 251, DOFOn 'MX Effects, Skill Flashing On
  SwitchSetAugmentation False, "pal_orange"
  lSeqLightsOverride.AddItem(lSeqSkillshot)
	DISPATCH LIGHTS_START_SEQUENCE, null
  DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
  DISPATCH GAME_CHECK_BET, Null
  FlashDomes 6, 2
  vpmTimer.AddTimer 1200, "vpmTimerAwardEarlyResearch '"
  vpmTimer.AddTimer 400, "vpmTimerAwardSkillshotDof1 '"
End Sub

Sub vpmTimerAwardSkillshotDof1
  DOF 251, DOFOff 'MX Effects, Skill Flashing Off
  DOF 252, DOFOn 'MX Effects, Shot Flashing On
  vpmTimer.AddTimer 400, "vpmTimerAwardSkillshotDof2 '"
End Sub

Sub vpmTimerAwardSkillshotDof2
  DOF 252, DOFOff 'MX Effects, Shot Flashing Off
End Sub

Sub vpmTimerAwardEarlyResearch()
  
  If gameState("lights")("activeResearch").Count < 3 Then
    gameState("lights")("activeResearch").RemoveAll()  
    gameState("lights")("activeResearch").Add "aug1", True
    gameState("lights")("activeResearch").Add "aug2", True
    gameState("lights")("activeResearch").Add "aug3", True
    LightOn(lsResearch1)
    LightOn(lsResearch2)
    LightOn(lsResearch3)
    CheckResearchLights
  End If
End Sub


Sub GameBallSaveEnded()

  gameState("game")("ballSave") = False

End Sub

Sub GameEnableBallSave()

  EnableBallSaver(15)
  gameState("game")("ballSave") = True
  p_watchdisplay_left.blenddisablelighting = 5
  p_watchdisplay_right.blenddisablelighting = 5

End Sub

Sub GameEnableBallLock()

  DiverterDir = -1
  DiverterOff.IsDropped=1
  DiverterOn.IsDropped=0
  'timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
  'PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002

End Sub

Sub GameDisableBallLock()

  DiverterDir = 1
  DiverterOff.IsDropped=0
  DiverterOn.IsDropped=1
  'timerRampDiverter.Interval = 2:timerRampDiverter.Enabled =1
  'PlaySoundAt SoundFX("DiverterOff",DOFContactors),DiverterP002

End Sub

Sub GameCheckLocks()

  If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
    If gameState("switches")("lightlock") = 2 Then 'Lock Open
      'Set Diverters
      LightOn(lsLightLock)
      DISPATCH GAME_ENABLE_BALL_LOCK, Null
    Else
      LightBlink(lsLightLock)
      DISPATCH GAME_DISABLE_BALL_LOCK, Null
    End If
  Else
    LightOff(lsLightLock)
    DISPATCH GAME_DISABLE_BALL_LOCK, Null
  End If

End Sub

Sub GameCheckBet()


End Sub

Sub GameCheckLanes()

  CheckLaneLights()

End Sub

Sub GameClearShots()
  lSeqHyperJump.RemoveAll()
  lSeqLeftOrbit.RemoveAll()
  lSeqShortcut.RemoveAll()
  lSeqRightOrbit.RemoveAll()
  lSeqRightRamp.RemoveAll()
  lSeqCenterRamp.RemoveAll()
  lSeqSpinner.RemoveAll()
  lSeqBumpers.RemoveAll()
  lSeqLeftRamp.RemoveAll()
  gameState("game")("gameShots")(GAME_MODE_AUGMENTATION_RESEARCH).RemoveAll()
  gameState("game")("gameShots")(GAME_MODE_NORMAL).RemoveAll()
  gameState("game")("gameShots")(GAME_MODE_MULTIBALL).RemoveAll()
  gameState("game")("gameShots")(GAME_MODE_HURRYUP).RemoveAll()
  gameState("game")("perkShot") = ""
End Sub

Sub GameMultiballJackpot
  GameAddScore GAME_POINTS_JACKPOT
  gameState("game")("multiballJackpots") = gameState("game")("multiballJackpots") +1
  If gameState("game")("multiballJackpots")=5 Then
    LightOff(lsCyber1)
    LightOff(lsCyber2)
    LightOff(lsCyber3)
    LightOff(lsCyber4)
    LightOff(lsCyber5)
    lSeqMultiballCShot.Image = "pal_orange"
    lSeqMultiballYShot.Image = "pal_orange"
    lSeqMultiballBShot.Image = "pal_orange"
    lSeqMultiballEShot.Image = "pal_orange"
    lSeqMultiballRShot.Image = "pal_orange"
    lSeqMultiballC.AddItem(lSeqMultiballCShot)
    lSeqMultiballY.AddItem(lSeqMultiballYShot)
    lSeqMultiballB.AddItem(lSeqMultiballBShot)
    lSeqMultiballE.AddItem(lSeqMultiballEShot)
    lSeqMultiballR.AddItem(lSeqMultiballRShot)
    AddGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
  End If
  If gameState("game")("multiballJackpots")=6 Then
    'Super Jackpot
    LightOff(lsCyber1)
    LightOff(lsCyber2)
    LightOff(lsCyber3)
    LightOff(lsCyber4)
    LightOff(lsCyber5)
    AddGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
    AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
    lSeqMultiballCShot.Image = "pal_green"
    lSeqMultiballYShot.Image = "pal_green"
    lSeqMultiballBShot.Image = "pal_green"
    lSeqMultiballEShot.Image = "pal_green"
    lSeqMultiballRShot.Image = "pal_green"
    lSeqMultiballC.AddItem(lSeqMultiballCShot)
    lSeqMultiballY.AddItem(lSeqMultiballYShot)
    lSeqMultiballB.AddItem(lSeqMultiballBShot)
    lSeqMultiballE.AddItem(lSeqMultiballEShot)
    lSeqMultiballR.AddItem(lSeqMultiballRShot)
    gameState("game")("multiballJackpots") = 0
  End If
End Sub

Sub GameAwardPerkShot()
  FlashDomes 2, 2
  DOF 230, DOFOn
  gameState("game")("perkShotActive") = True
  vpmTimer.AddTimer 1000, "vpmTimerAwardPerkShotCooldown '"
  If gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 0 Then
    
    Select Case gameState("game")("augmentationActive")
      Case 0:
        GameAddScore GAME_POINTS_BASE    
      Case 1:
        GameAddScore GAME_POINTS_BASE
      Case 2:
        GameAddScore GAME_POINTS_BASE
      Case 3:
        GameAddScore GAME_POINTS_SPINNER
      Case 4:
        GameAddScore GAME_POINTS_BUMPERS
      Case 5:
        GameAddScore GAME_POINTS_BASE
      Case 6:
        GameAddScore GAME_POINTS_BASE
      Case 7:
        GameAddScore GAME_POINTS_BASE
      Case 8:
        GameAddScore GAME_POINTS_BASE
    End Select

  ElseIf gameState("game")(AugmentationLvlNames(gameState("game")("augmentationActive"))) = 1 Then
  
    Select Case gameState("game")("augmentationActive")
      Case 0:

      Case 1:
          
      Case 2:
          
      Case 3:
          
      Case 4:
          
      Case 5:
          
      Case 6:
          
      Case 7:
          
      Case 8:
          
    End Select

  End IF


  

End Sub

Sub vpmTimerAwardPerkShotCooldown

  gameState("game")("perkShotActive") = False
  DOF 230, DOFOff

End Sub


Sub GameAddScore(score)

  'Apply any modifiers

  DebugScore = DebugScore + score

End Sub

Sub GameCombo(combo)

  If IsLightOn(combo) Or gameState("game")("combo") = 0 Then
    gameState("game")("combo") = gameState("game")("combo") + 1
    gameState("game")("comboTime") = GameTime
    If gameState("game")("combo") = 1 Then
      LightBlink(lsCombo1)
      LightBlink(lsCombo2)
      LightBlink(lsCombo3)
      LightBlink(lsCombo4)
      LightBlink(lsCombo5)
    Else
      GameAddScore GAME_POINTS_COMBO * gameState("game")("combo")
    End If
    LightOff(combo)
    comboTimer.Enabled = True
    gameState("game")("currentCombo") = gameState("game")("currentCombo") & CStr(combo.Idx)
    Debug.print gameState("game")("currentCombo")
    If GameCombos.Exists(gameState("game")("currentCombo")) Then
      Debug.print "add combo"
      'TODO Check combo isn't already in gamestate
      If Not gameState("game")("combosMade").Exists(gameState("game")("currentCombo")) Then 
        gameState("game")("combosMade").Add gameState("game")("currentCombo"), GameCombos(gameState("game")("currentCombo"))
      End If
    End If
  End If
  
End Sub

Sub comboTimer_Timer

  If GameTime - gameState("game")("comboTime") > 6000 Then
    comboTimer.Enabled = False
    LightOff(lsCombo1)
    LightOff(lsCombo2)
    LightOff(lsCombo3)
    LightOff(lsCombo4)
    LightOff(lsCombo5)
    gameState("game")("combo") = 0
    gameState("game")("currentCombo") = ""
  End If

End Sub

Sub GameStartModeHurryUp
 
  gameState("game")("modes")(GAME_MODE_HURRYUP) = True
  'gameState("switches")("betB") = 0
  'gameState("switches")("betE") = 0
  'gameState("switches")("betT") = 0
  DISPATCH GAME_CHECK_BET, Null
  'pupevent music
  LightOff(lsSpeeder)
  lsSpeeder.Image="pal_yellow"
  LightOn(lsSpeeder)
  StopBGAudio()
  pupevent 510 ' hurryup
  DISPATCH LIGHTS_GI_HURRYUP, null
  vpmTimer.AddTimer 30000, "vpmTimerEndHurryUp '"
  p_watchdisplay_left.blenddisablelighting = 5
  p_watchdisplay_right.blenddisablelighting = 5
  EnableWatchTimer(30)
  
  lSeqRightOrbit.AddItem(lSeqRightOrbitHurryUpShot)
  AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_HURRYUP

End Sub

Sub vpmTimerEndHurryUp

  If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
    gameState("game")("modes")(GAME_MODE_HURRYUP) = False
    'pupevent music
    StopBGAudio()
    lSeqRightOrbit.RemoveItem(lSeqRightOrbitHurryUpShot)
    gameState("game")("gameShots")(GAME_MODE_HURRYUP).RemoveAll()
    LightOff(lsSpeeder)
    lsSpeeder.Image="pal_blue"
    LightOn(lsSpeeder)
    StopWatchDisplay()
    PlayBGAudioNext()
    DISPATCH GAME_MODE_NORMAL, Null
  End If
End Sub

Sub GameAwardHurryup
  vpmTimerEndHurryUp()
  FlashDomes 6, 2
  GameAddScore GAME_POINTS_HURRYUP
End Sub

'Sub vpmTimerDOFOff(DOFCode)
'  Execute "DOF "&code&", DOFOff"
'End Sub

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Game State                                           	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitGameLogicState()
    Dim gameLogic: Set gameLogic=CreateObject("Scripting.Dictionary")
    gameLogic.Add "playerName", ""
    gameLogic.Add "playerBall", 0
    gameLogic.Add "augmentationReady", False
    gameLogic.Add "raceReady", False
    gameLogic.Add "augmentationActive", 0
    gameLogic.Add "augmentationHold", 1
    gameLogic.Add "augmentationHoldCountdown", 0
    gameLogic.Add "currentSound", ""
    gameLogic.Add "hideScore", False
    gameLogic.Add "pauseLights", False
    gameLogic.Add "ballSave", False
    gameLogic.Add "multiballPlayed", False
    gameLogic.Add "multiballJackpots", 0
    gameLogic.Add "perkShot", ""
    gameLogic.Add "perkShotActive", false
    gameLogic.Add "augmentationResearch0Stage", 0
    gameLogic.Add "augmentationResearch1Stage", 0
    gameLogic.Add "augmentationResearch2Stage", 0
    gameLogic.Add "augmentationResearch3Stage", 0
    gameLogic.Add "augmentationResearch4Stage", 0
    gameLogic.Add "augmentationResearch5Stage", 0
    gameLogic.Add "augmentationResearch6Stage", 0
    gameLogic.Add "augmentationResearch7Stage", 0
    gameLogic.Add "augmentationResearch8Stage", 0
    gameLogic.Add "augTigerLvl", 0
    gameLogic.Add "augBatLvl", 0
    gameLogic.Add "augBullLvl", 0
    gameLogic.Add "augLionLvl", 0
    gameLogic.Add "augHawkLvl", 0
    gameLogic.Add "augDeerLvl", 0
    gameLogic.Add "augPantherLvl", 0
    gameLogic.Add "augOwlLvl", 0
    gameLogic.Add "augRhinoLvl", 0
    gameLogic.Add "ballsLocked", 0
    gameLogic.Add "outlaneDrain", False
    gameLogic.Add "ballsInPlay", 0
    gameLogic.Add "combo", 0
    gameLogic.Add "comboTime", 0
    gameLogic.Add "currentCombo", ""
    Dim combosMade: Set combosMade = CreateObject("Scripting.Dictionary")
    gameLogic.Add "combosMade", combosMade
    Dim gameModes: Set gameModes=CreateObject("Scripting.Dictionary")
    gameLogic.Add "betHits", 2
    gameLogic.Add "betTimesRan", 0
    gameLogic.Add "mode1Hits", 0
    gameLogic.Add "mode1TimesRan", 0
    gameModes.Add GAME_MODE_NORMAL, False
    gameModes.Add GAME_MODE_CHOOSE_SKILLSHOT, False
    gameModes.Add GAME_MODE_SKILLSHOT_ACTIVE, False
    gameModes.Add GAME_MODE_AUGMENTATION_RESEARCH, False
    gameModes.Add GAME_MODE_MULTIBALL, False
    gameModes.Add GAME_MODE_HURRYUP, False
    gameLogic.Add "modes", gameModes

    Dim gameShots: Set gameShots=CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_NORMAL, CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_AUGMENTATION_RESEARCH, CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_MULTIBALL, CreateObject("Scripting.Dictionary")
    gameShots.Add GAME_MODE_HURRYUP, CreateObject("Scripting.Dictionary")
    gameLogic.Add "gameShots", gameShots

    Set InitGameLogicState = gameLogic
End Function

Dim AugmentationNames: AugmentationNames = Array("Tiger", "Bat", "Bull","Lion","Hawk","Deer","Panther","Owl","Rhino")
Dim AugmentationLvlNames: AugmentationLvlNames = Array("augTigerLvl", "augBatLvl", "augBullLvl","augLionLvl","augHawkLvl","augDeerLvl","augPantherLvl","augOwlLvl","augRhinoLvl")
Dim AugmentationPerksLvl1: AugmentationPerksLvl1 = Array("2x Hyper Jump", "2x Left Orbit", "2x Left Ramp","2x Spinner","2x Bumpers","2x Center Ramp","2x Right Right","2x Right Orbit","2x Shortcut")
Dim AugmentationPerksLvl2: AugmentationPerksLvl2 = Array("Advance Playfield Multiplier", "1 Million Orbits", "2x Left Ramp","Super Spinner","Increase Bet Limit","Advance Extra Ball","Increase Ball Save","Light Mystery","Activate Lane Save")
Dim AugmentationPerksLvl3: AugmentationPerksLvl3 = Array("Hyper Jump Overdrive", "Left Orbit Overdrive", "Left Ramp Overdrive","Spinner Overdrive","Bumpers Overdrive","Center Ramp Overdrive","Right Right Overdrive","Right Orbit Overdrive","Shortcut Overdrive")
Dim PaletteToLampLookup: Set PaletteToLampLookup = CreateObject("Scripting.Dictionary")
PaletteToLampLookup.Add "pal_purple", gameColors(0)
PaletteToLampLookup.Add "pal_orange", gameColors(2)
PaletteToLampLookup.Add "pal_red_darker", gameColors(4)
PaletteToLampLookup.Add "pal_yellow", gameColors(5)
PaletteToLampLookup.Add "pal_green", gameColors(7)
Dim AugmentationSounds : AugmentationSounds = Array(Array("2x_hyperjump", "2x_hyperjump", "2x_hyperjump"), Array("2x_leftorbit", "1million_orbits", "2x_leftorbit"), Array("2x_left_ramp","2x_left_ramp", "2x_left_ramp"), Array("2x_spinners","2x_spinners", "2x_spinners"), Array("2x_bumpers","2x_bumpers", "2x_bumpers"), Array("2x_centerramp", "2x_centerramp", "2x_centerramp"), Array("2x_rightramp", "2x_rightramp", "2x_rightramp"), Array("2x_rightorbit", "2x_rightorbit", "2x_rightorbit"), Array("2x_shortcut", "2x_shortcut","2x_shortcut"))

'Light Collections
Dim lcAugmentations: lcAugmentations = Array(lsAug1,lsAug4,lsAug7,lsAug2,lsAug5,lsAug8,lsAug3,lsAug6,lsAug9)

'Shots
Const GAME_SHOT_HYPER_JUMP = "Game Shot Hyper Jump"
Const GAME_SHOT_LEFT_ORBIT = "Game Shot Left Orbit"
Const GAME_SHOT_LEFT_RAMP = "Game Shot Left Ramp"
Const GAME_SHOT_SPINNER = "Game Shot Spinner"
Const GAME_SHOT_CENTER_RAMP = "Game Shot Center Ramp"
Const GAME_SHOT_BUMPERS = "Game Shot Bumpers"
Const GAME_SHOT_RIGHT_RAMP = "Game Shot Right Ramp"
Const GAME_SHOT_RIGHT_RAMP_COLLECT = "Game Shot Right Ramp Collect"
Const GAME_SHOT_RIGHT_ORBIT = "Game Shot Right Oribt"
Const GAME_SHOT_SHORTCUT = "Game Shot Shortcut"

Dim GameShots: GameShots = Array(GAME_SHOT_HYPER_JUMP, GAME_SHOT_LEFT_ORBIT,GAME_SHOT_LEFT_RAMP,GAME_SHOT_SPINNER,GAME_SHOT_BUMPERS,GAME_SHOT_CENTER_RAMP,GAME_SHOT_RIGHT_RAMP,GAME_SHOT_RIGHT_ORBIT,GAME_SHOT_SHORTCUT)
Dim GameCombos: Set GameCombos = CreateObject("Scripting.Dictionary")

GameCombos.Add "116118", "Left Ramp -> Right Ramp"
GameCombos.Add "118116", "Right Ramp -> Left Ramp"

Const GAME_MODE_NORMAL = "Game_Mode_Normal"
Const GAME_MODE_CHOOSE_SKILLSHOT = "Game_Mode_Choose_Skillshot"
Const GAME_MODE_SKILLSHOT_ACTIVE = "Game_Mode_Skillshot_Active"
Const GAME_MODE_AUGMENTATION_RESEARCH = "Game_Mode_Augmentation_Research"
Const GAME_MODE_MULTIBALL = "Game_Mode_Multiball"
Const GAME_MODE_HURRYUP = "Game_Mode_Hurry Up"

Const GAME_BET_MAX_HITS = 20

'Base Points
Const GAME_POINTS_BASE = 10000
Const GAME_POINTS_JACKPOT = 250000
Const GAME_POINTS_BUMPERS = 2000
Const GAME_POINTS_SPINNER = 2000
Const GAME_POINTS_COMBO = 75000
Const GAME_POINTS_RESEARCH_NODE = 10000
Const GAME_POINTS_HURRYUP = 1000000

'***********************************************************************************************************************

' Mode 1 - Left Return Shot.
' X Shots Starts a 3 Way Combo
' Post Pops up on left inlane
' Shot 1 - Right Ramp
' Shot 2 - Left Orbit
' Shot 3 - Left Ramp.
' Awards at Left Inlane.
Sub GameAdvanceMode1()

    gameState("game")("mode1Hits") = gameState("game")("mode1Hits") + 1
    If gameState("game")("mode1Hits") > Min(5 * (gameState("game")("mode1TimesRan")+1),15) Then
        'start mode
        MsgBox("Start Mode 1")
        gameState("game")("mode1Hits") = 0
        gameState("game")("mode1TimesRan") = gameState("game")("mode1TimesRan")+1
    End If
    

End Sub
'***********************************************************************************************************************
'*****  Lane Lights Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const ROTATE_LANE_LIGHTS_CLOCKWISE = "ROTATE_LANE_LIGHTS_CLOCKWISE"
Const ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE = "ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE"
Const RESET_LANE_LIGHTS = "RESET_LANE_LIGHTS"

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lane Lights Dispatch                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub RotateLaneLightsClockwise()
    Dim temp : temp = gameState("laneLights")("leftOuter")
    gameState("laneLights")("leftOuter") = gameState("laneLights")("rightOuter")
    gameState("laneLights")("rightOuter") = gameState("laneLights")("rightInner")
    gameState("laneLights")("rightInner") = gameState("laneLights")("leftInner")
    gameState("laneLights")("leftInner") = temp
    CheckLaneLights()
End Sub

Sub RotateLaneLightsAntiClockwise()
    Dim temp : temp = gameState("laneLights")("leftOuter")
    gameState("laneLights")("leftOuter") = gameState("laneLights")("leftInner")
    gameState("laneLights")("leftInner") = gameState("laneLights")("rightInner")
    gameState("laneLights")("rightInner") = gameState("laneLights")("rightOuter")
    gameState("laneLights")("rightOuter") = temp
    CheckLaneLights()
End Sub

Sub ResetLaneLights()
    gameState("laneLights")("leftOuter") = 0
    gameState("laneLights")("leftInner") = 0
    gameState("laneLights")("rightInner") = 0
    gameState("laneLights")("rightOuter") = 0
    CheckLaneLights()
End Sub


'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Lane Lights State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitLaneLightsState()
    
    Dim laneLights: Set laneLights=CreateObject("Scripting.Dictionary")
    
    laneLights.Add "leftOuter", 0
    laneLights.Add "leftInner", 0
    laneLights.Add "rightOuter", 0
    laneLights.Add "rightInner", 0

    Set InitLaneLightsState = laneLights
End Function
'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lights Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const LIGHTS_UPDATE = "Lights Update"
Const LIGHTS_GI_ON = "Lights GI ON"
Const LIGHTS_GI_OFF = "Lights GI OFF"
Const LIGHTS_GI_NORMAL = "Lights GI Normal"
Const LIGHTS_GI_DOMES = "Lights GI Domes"
Const LIGHTS_GI_AUGMENTATION_RESEARCH = "Lights GI Augmentation Research"
Const LIGHTS_GI_HURRYUP = "Lights GI Hurry Up"
Const LIGHTS_GI_MULTIBALL = "Lights GI Multiball"
Const LIGHTS_GI_SOVIET = "Lights GI Soviet"
Const LIGHTS_GI_ALLIED = "Lights GI Allied"
Const LIGHTS_RESEARCH_OFF = "Lights Research Off"
Const LIGHTS_RESEARCH_RESET = "Lights Research Reset"
Const LIGHTS_RESEARCH_READY_OFF = "Lights Research Ready Off"
Const LIGHTS_AUGMENTATIONS_OFF = "Lights Augmentations Off"
Const LIGHTS_START_SEQUENCE = "Lights Start Sequence"
Const LIGHTS_PAUSE = "Lights Pause"

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lights Dispatch                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub LightsStartSequence()

    LightsPause()

End Sub

Sub LightsPause()

    Lampz.TurnOffStates()
    'FlasherFluxTimer1.Enabled = False
    'objFluxBase(1).BlendDisableLighting = FluxFlasherOffBrightness
    'FlasherFluxTimer2.Enabled = False
    'objFluxBase(2).BlendDisableLighting = FluxFlasherOffBrightness

End Sub

Sub RunLightSeq(lightSeq, k)

    Dim light: Set light = lightSeq.CurrentItem
    'DebugOut(k)
    'DebugOut(light.CurrentIdx)
    'DebugOut(UBound(light.Sequence))
    If UBound(light.Sequence)<light.CurrentIdx Then
        light.CurrentIdx = 0
        lightSeq.NextItem()
    Else
        Dim framesRemaining, seq
        seq = light.Sequence
        If IsArray(seq(light.CurrentIdx)) Then
            Dim ls, x
            
            'DebugOut(light.CurrentIdx)
            For x = 0 To UBound(seq(light.CurrentIdx))
                'DebugOut("X:" & Cstr(x))    
                Set ls = seq(light.CurrentIdx)(x)
                If Not IsNull(light.Image) Then
                    ls.Image = light.Image
                    'ls.LampColor = PaletteToLampLookup(light.Image)
                End If
                If Not IsNull(light.LampColor) Then
                    ls.LampColor = light.LampColor
                End If
                gameState("lights")("changedLamps").Add k+cStr(ls.Idx), ls
                'framesRemaining = ls.Update(FrameTime)
                'If framesRemaining < 0 Then
                '    ls.ResetFrames()
                '    If x = UBound(seq(light.CurrentIdx)) Then
                '        light.CurrentIdx = light.CurrentIdx + 1
                '    End If
                'End If            
            Next
        Else
            If Not IsNull(light.Image) Then
                seq(light.CurrentIdx).Image = light.Image
            End If
            If Not IsNull(light.LampColor) Then
                seq(light.CurrentIdx).LampColor = light.LampColor
            End If
            gameState("lights")("changedLamps").Add k+cStr(seq(light.CurrentIdx).Idx), seq(light.CurrentIdx)
            'framesRemaining = seq(light.CurrentIdx).Update(FrameTime)
            'If framesRemaining < 0 Then
            '    seq(light.CurrentIdx).ResetFrames()
            '    light.CurrentIdx = light.CurrentIdx + 1
            'End If
        End If

        framesRemaining = light.Update(FrameTime)
        If framesRemaining < 0 Then
            light.ResetFrames()
            light.CurrentIdx = light.CurrentIdx + 1
        End If
        
    End If



End Sub



Sub LightsUpdate()
    
    If gameState("game")("pauseLights") = True Then
        Exit Sub
    End If

    If Not IsNull(lSeqLightsOverride.CurrentItem) Then
        RunLightSeq lSeqLightsOverride, "lightsOverride"
    Else

        If HasKeys(gameState("lights")("lightSeqs")) Then
            Dim k
            For Each k in gameState("lights")("lightSeqs").Keys()
                Dim lightSeq: Set lightSeq = gameState("lights")("lightSeqs")(k)
                If Not IsNull(lightSeq.CurrentItem) Then
                    RunLightSeq lightSeq, k
                End If
            Next
        End If

        If HasKeys(gameState("lights")("lightBlinks")) Then
            Dim blinkKey
            For Each blinkKey in gameState("lights")("lightBlinks").Keys()

                Dim blinkLight: Set blinkLight = gameState("lights")("lightBlinks")(blinkKey)
                gameState("lights")("changedLamps").Add blinkKey, blinkLight
                Dim blinkFramesRemaining
                blinkFramesRemaining = blinkLight.Update(FrameTime)
                If blinkFramesRemaining < 0 Then
                    blinkLight.Blink()
                End If
            
            Next

        End If

        If HasKeys(gameState("lights")("lightOn")) Then
            Dim lightKey
            For Each lightKey in gameState("lights")("lightOn").Keys()
                Dim light: Set light = gameState("lights")("lightOn")(lightKey)
                light.State = 1
                gameState("lights")("changedLamps").Add lightKey, light
            Next
        End If

        If HasKeys(gameState("lights")("lightFlash")) Then
            Dim flashKey
            For Each flashKey in gameState("lights")("lightFlash").Keys()

                Dim flashLight: Set flashLight = gameState("lights")("lightFlash")(flashKey)
                
                If flashLight.Enabled = False Then
                    flashLight.Enabled = True
                    FluxObjlevel(flashKey) = 0.1
                End If

            Next

        End If

    End If

    If HasKeys(gameState("lights")("changedLamps")) Then
        Dim changedLamp
        For Each changedLamp in gameState("lights")("changedLamps").Keys()
            Lampz.state(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).State
            'MsgBox(gameState("lights")("changedLamps")(changedLamp).lampColor)
            If Not IsNull(gameState("lights")("changedLamps")(changedLamp).lampColor) Then   
                Lampz.lampColor(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).lampColor
            End If
            If Not IsNull(gameState("lights")("changedLamps")(changedLamp).Image) Then   
                Lampz.image(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).Image
                Lampz.lampColor(gameState("lights")("changedLamps")(changedLamp).Idx) = PaletteToLampLookup(gameState("lights")("changedLamps")(changedLamp).Image)
            End If
        Next
    End If
	gameState("lights")("changedLamps").RemoveAll
    
End Sub

Sub LightsStartFlicker()
    
    'Dim fOn1: Set fOn1 = New LightChangeItem
    'fOn1.Init 0,1,62,"pal_purple"
    'Dim fOff1: Set fOff1 = new LightChangeItem
    'fOff1.Init 0,0,62,"pal_purple"

    'Dim fOn2: Set fOn2 = New LightChangeItem
    'fOn2.Init 0,1,62,"pal_purple"
    'Dim fOff2: Set fOff2 = new LightChangeItem
    'fOff2.Init 0,0,62,"pal_purple"

    'Dim fOn3: Set fOn3 = New LightChangeItem
    'fOn3.Init 0,1,62,"pal_purple"
    'Dim fOff3: Set fOff3 = new LightChangeItem
    'fOff3.Init 0,0,62,"pal_purple"

    'Dim fOn4: Set fOn4 = New LightChangeItem
    'fOn4.Init 0,1,62,"pal_purple"
    'Dim fOff4: Set fOff4 = new LightChangeItem
    'fOff4.Init 0,0,62,"pal_purple"

    'Dim flicker: Set flicker=CreateObject("Scripting.Dictionary")
    'flicker.Add "currentIdx", 0
    'flicker.Add "sequence", Array(fOn1, fOff1, fOn2, fOff2, fOn3, fOff3, fOn4, fOff4)
    'If Not gameState("lights")("lightSeqs").Exists("flicker") Then
    '    gameState("lights")("lightSeqs").Add "flicker", flicker
    'End If
    
End Sub

Sub LightsAugmentationAttract()

    'Dim x
    'for each x in insertsAugmentations
    '    Dim l: Set l = New LightChangeItem
    '    l.Init x.Uservalue,1,0,"pal_purple"
    '    If gameState("lights")("changedLamps").Exists(x.Name) Then
    '        gameState("lights")("changedLamps").Remove x.Name
    '    End If
        'MsgBox(x.IntensityScale)
    '    gameState("lights")("changedLamps").Add x.Name, l
    'next
    
    'LightSeqInsertsAugmentations.StopPlay
    'LightSeqInsertsAugmentations.Play SeqAllOn
    'LightSeqInsertsAugmentations.UpdateInterval = 12
    'LightSeqInsertsAugmentations.Play SeqFanLeftUpOn, 24, 10
    'LightSeqInsertsAugmentations.UpdateInterval = 15
    'LightSeqInsertsAugmentations.Play SeqUpOn, 12, 2
    'LightSeqInsertsAugmentations.UpdateInterval = 15
    'LightSeqInsertsAugmentations.Play SeqRadarRightOn, 12, 2
    

    'LightSeqInsertsCyber.StopPlay
    'LightSeqInsertsCyber.UpdateInterval = 10
    'LightSeqInsertsCyber.Play SeqLeftOn, 16, 10
    'LightSeqInsertsCyber.UpdateInterval = 20
    'LightSeqInsertsCyber.Play SeqRightOn, 8, 10
    'LightSeqInsertsCyber.UpdateInterval = 20
    'LightSeqInsertsCyber.Play SeqUpOn, 8, 10
    'LightSeqInsertsCyber.Play SeqDownOn, 8, 10


    LightSeqAttract.StopPlay
    LightSeqAttract.UpdateInterval = 10
    LightSeqAttract.Play SeqLeftOn, 16, 2
    LightSeqAttract.UpdateInterval = 20
    LightSeqAttract.Play SeqRightOn, 8, 1
    LightSeqAttract.UpdateInterval = 20
    LightSeqAttract.Play SeqUpOn, 8, 1
    LightSeqAttract.Play SeqDownOn, 8, 1
    
    
    'Dim aug1On: Set aug1On = New LightChangeItem
    'aug1On.Init 0,1,180,"pal_purple"
    'Dim aug1Off: Set aug1Off = new LightChangeItem
    'aug1Off.Init 0,0,180,"pal_purple"

    'Dim aug2On: Set aug2On = New LightChangeItem
    'aug2On.Init 3,1,180,"pal_purple"
    'Dim aug2Off: Set aug2Off = new LightChangeItem
    'aug2Off.Init 3,0,180,"pal_purple"

    'Dim aug3On: Set aug3On = New LightChangeItem
    'aug3On.Init 6,1,180,"pal_purple"
    'Dim aug3Off: Set aug3Off = new LightChangeItem
    'aug3Off.Init 6,0,180,"pal_purple"

    'Dim flicker: Set flicker=CreateObject("Scripting.Dictionary")
    'flicker.Add "currentIdx", 0
    'flicker.Add "repeat", 1
    'flicker.Add "sequence", Array(aug1On, aug1Off, aug2On, aug2Off, aug3On, aug3Off)
    'If Not gameState("lights")("lightSeqs").Exists("augAttract") Then
    '    gameState("lights")("lightSeqs").Add "augAttract", flicker
    'End If
    
End Sub

Sub LightSeqInsertsAugmentations_PlayDone()
    PlaySound "fx-spinner2"
    'LightSeqInsertsAugmentations.Play SeqAllOff
    'LightSeqInsertsAugmentations.StopPlay
    'DISPATCH LIGHTS_RESET_COMMANDERS, null
End Sub

Sub LightsGIOn()
    gameState("lights")("gi") = 1
    
    'LightsAugmentationAttract()
    'TurnOffFluxFlasher(3)
    'FluxObjlevel(3) = 2
    LightOn(lsSpeeder)

    'playfield_lm.visible = True
    'p_artblades_back.Image = "artbladesbackgion"
    'p_plastics.Image = "plastics-new"
    gameState("game")("modes")(GAME_MODE_NORMAL) = True
    ModLampz.SetGI 0, 9
    
    SetGI 0,9
    SetGIPerk 0,0
    'Dispatch LIGHTS_GI_NORMAL, Null
    for each GIxx in GI
        GIxx.Color = gameState("lights")("GIColor")
        GIxx.ColorFull = gameState("lights")("GIColor")
        'GIxx.Intensity = 30
        GIxx.visible = False
    next
End Sub

Sub LightsGIOff()
    gameState("lights")("gi") = 0
    'playfield_lm.visible = False
    'p_artblades_back.Image = "artbladesbackgioff"
    'p_plastics.Image = "plastics-off"
    ModLampz.SetGI 0, 0
    LightOff(lsSpeeder)
End Sub

Sub LightsGINormal()
    for each GIxx in GI
        GIxx.Color = c_normal
        GIxx.ColorFull = c_normal_full
        'GIxx.Intensity = 30
    next
    'p_plastics.Image = "plastics-new"
    ModLampz.SetGI 0, 9
    gameState("lights")("GIColor") = c_normal
End Sub

Sub LightsGIDomes(color)
    'for each GIxx in GISLings
    '    GIxx.Color = gameColors(color)
    '    GIxx.ColorFull = gameColors(color)
    '    GIxx.Intensity = 2
    'next
    'p_plastics.Image = gamePlastics(color)
    'SetGIPerk 0,9
End Sub

Sub LightsGiAugmentationResearch()
    for each GIxx in GI
        GIxx.Color = c_augmentationResearch
        GIxx.ColorFull = c_augmentationResearch
       ' GIxx.Intensity = 3
    next
    'p_plastics.Image = "plastics-blue"
    gameState("lights")("GIColor") = c_augmentationResearch
End Sub

Sub LightsGiHurryUp()
    for each GIxx in GI
        GIxx.Color = gameColors(6)
        GIxx.ColorFull = gameColors(6)
       ' GIxx.Intensity = 3
    next
    'p_plastics.Image = "plastics-yellow"
    gameState("lights")("GIColor") = gameColors(6)
End Sub

Sub LightsGiMultiball()
    for each GIxx in GI
        GIxx.Color = c_multiball
        GIxx.ColorFull = c_multiball
    next
    'p_plastics.Image = "plastics-green"
    gameState("lights")("GIColor") = c_multiball
End Sub

Sub LightsResearchReset()
    LightBlink(lsResearch1)
    LightBlink(lsResearch2)
    LightBlink(lsResearch3)
    If gameState("lights")("activeResearch").Exists("aug1") Then
        gameState("lights")("activeResearch").Remove "aug1"
    End If
    If gameState("lights")("activeResearch").Exists("aug2") Then
        gameState("lights")("activeResearch").Remove "aug2"
    End If
    If gameState("lights")("activeResearch").Exists("aug3") Then
        gameState("lights")("activeResearch").Remove "aug3"
    End If
End Sub

Sub LightsResearchOff()
    StopLightBlink(lsResearch1)
    StopLightBlink(lsResearch2)
    StopLightBlink(lsResearch3)
    If gameState("lights")("activeResearch").Exists("aug1") Then
        gameState("lights")("activeResearch").Remove "aug1"
    End If
    If gameState("lights")("activeResearch").Exists("aug2") Then
        gameState("lights")("activeResearch").Remove "aug2"
    End If
    If gameState("lights")("activeResearch").Exists("aug3") Then
        gameState("lights")("activeResearch").Remove "aug3"
    End If
End Sub

Sub LightsResearchReadyOff()
    StopLightBlink(lciResearchLit)
    Lampz.state(25) = 0
End Sub

Sub LightsAugmentationsOff()
    Lampz.State(0) = 0
    Lampz.State(1) = 0
    Lampz.State(2) = 0
    Lampz.State(3) = 0
    Lampz.State(4) = 0
    Lampz.State(5) = 0
    Lampz.State(6) = 0
    Lampz.State(7) = 0
    Lampz.State(8) = 0
End Sub

'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Lane Lights State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitLightsState()
    
    Dim lights: Set lights=CreateObject("Scripting.Dictionary")

    lights.Add "lightSeqs", InitLightSeqs()
    lights.Add "lightBlinks", InitLightBlinks()
    lights.Add "lightOn", InitLightOn()
    lights.Add "lightFlash", InitLightFlash()

    lights.Add "GIColor", c_normal
    lights.Add "activeResearch", CreateObject("Scripting.Dictionary")

    lights.Add "changedLamps", CreateObject("Scripting.Dictionary")

    lights.Add "gi", 0

    Set InitLightsState = lights
End Function


Function InitLightSeqs()
    Dim lightSeqs: Set lightSeqs=CreateObject("Scripting.Dictionary")
    Set InitLightSeqs = lightSeqs
End Function

Function InitLightBlinks()
    Dim lightBlinks: Set lightBlinks=CreateObject("Scripting.Dictionary")
    Set InitLightBlinks = lightBlinks
End Function

Function InitLightOn()
    Dim lightOn: Set lightOn=CreateObject("Scripting.Dictionary")
    Set InitLightOn = lightOn
End Function

Function InitLightFlash()
    Dim lightFlash: Set lightFlash=CreateObject("Scripting.Dictionary")
    Set InitLightFlash = lightFlash
End Function

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****    Light Utils                                                  	                                            ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Function AppendLightSequenceArray(ByVal aArray, aInput)	'append one value, object, or Array onto the end of a 1 dimensional array
    dim tmp : tmp = aArray
    Redim Preserve tmp(uBound(aArray) +1)
    tmp(uBound(aArray)+1) = aInput
    AppendLightSequenceArray = tmp
End Function

Sub LightOn(light)
    If gameState("lights")("lightOn").Exists(light.Idx) Then 
        Exit Sub
    End If

    StopLightBlink(light)

    light.State = 1
    'If Not gameState("lights")("lightOn").Exists(light.Idx) Then 
    gameState("lights")("lightOn").Add light.Idx, light
    'End If
End Sub

Sub LightOff(light)
    StopLightBlink(light)
End Sub

Sub LightFluxFlash(nr, light)

    If Not gameState("lights")("lightFlash").Exists(nr) Then 
        gameState("lights")("lightFlash").Add nr, light
    End If

End Sub

Sub LightFluxFlashOff(nr)

    If gameState("lights")("lightFlash").Exists(nr) Then 
        gameState("lights")("lightFlash").Remove nr
    End If

End Sub

Sub LightBlink(light)

    If Not gameState("lights")("lightBlinks").Exists(light.Idx) Then 
        gameState("lights")("lightBlinks").Add light.Idx, light
    End If

    If gameState("lights")("lightOn").Exists(light.Idx) Then
        gameState("lights")("lightOn").Remove light.Idx
    End If

End Sub

Sub StopLightBlink(light)

    Lampz.State(light.Idx) = 0
    light.State = 1
    light.ResetFrames()

    If gameState("lights")("lightBlinks").Exists(light.Idx) Then
        gameState("lights")("lightBlinks").Remove light.Idx
    End If

    If gameState("lights")("lightOn").Exists(light.Idx) Then	
        gameState("lights")("lightOn").Remove light.Idx
    End If

End Sub

Sub StopLightSeq(seq)
    If Not IsNull(seq) Then
        Dim item
        For Each item in seq.Items
            Dim x
            For Each x in item.Sequence

                If IsArray(x) Then
                    Dim xx
                    For Each xx in x
                        Lampz.State(xx.Idx) = 0
                    Next
                Else
                    Lampz.State(x.Idx) = 0
                
                End If
            Next
            item.CurrentIdx = 0
        Next
        If gameState("lights")("lightSeqs").Exists(seq.Name) Then
            gameState("lights")("lightSeqs").Remove seq.Name
        End If
    End If
End Sub

Sub StartLightSeq(seq)
    If Not IsNull(seq) Then
        If Not gameState("lights")("lightSeqs").Exists(seq.Name) Then
            gameState("lights")("lightSeqs").Add seq.Name, seq
        End If
    End If
End Sub

Function IsLightOn(light)
    If gameState("lights")("lightBlinks").Exists(light.Idx) Or gameState("lights")("lightOn").Exists(light.Idx) Then 
        IsLightOn = True
    Else
        IsLightOn = False
    End If
End Function

Sub SwitchHitBumper()
    
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BUMPERS
        If gameState("game")("perkShot") = GAME_SHOT_BUMPERS Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 4 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_BUMPERS, GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_BUMPERS, GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
End Sub
Sub SwitchHitCenterRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_CENTER_RAMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 5 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If
    

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_CENTER_RAMP, GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If IsActiveGameShot(GAME_SHOT_CENTER_RAMP,GAME_MODE_MULTIBALL) Then
            RemoveGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
            LightOn(lsCyber3)
            lSeqMultiballB.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_CENTER_RAMP,GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
        DISPATCH GAME_COMBO, lsCombo3
        DISPATCH GAME_ADVANCE_MODE1, null
    End If
End Sub

Sub SwitchHitHyperJump()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_HYPER_JUMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 0 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_HYPER_JUMP,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_HYPER_JUMP,GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
    
End Sub
Sub SwitchHitPreLeftOrbit()
    If gameState("switches")("leftOrbit") = 1 Then
        gameState("switches")("preLeftOrbit") = 0
        gameState("switches")("leftOrbit") = 0
    Else
        gameState("switches")("preLeftOrbit") = 1
    End If
End Sub

Sub SwitchHitLeftOrbit()
    If gameState("switches")("preLeftOrbit") = 1 Then

        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            PlaySound "left_orbit"    
            'LightSeqGIUpperLeft.StopPlay   
            'LightSeqGIUpperLeft.UpdateInterval = 2
            'LightSeqGIUpperLeft.Play SeqArcTopLeftUpOn, 2, 0
            'LightSeqGIUpperLeft.Play SeqArcTopLeftUpOff, 2, 0
            GameAddScore GAME_POINTS_BASE
            If gameState("game")("perkShot") = GAME_SHOT_LEFT_ORBIT Then
                DISPATCH GAME_AWARD_PERKSHOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
            If gameState("game")("augmentationActive") = 1 Then
                DISPATCH GAME_AWARD_SKILLSHOT, Null
            End If
        End If
    
        If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_MULTIBALL) Then
                RemoveGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
                LightOn(lsCyber1)
                lSeqMultiballC.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
            If IsActiveGameShot(GAME_SHOT_LEFT_ORBIT,GAME_MODE_HURRYUP) Then
                DISPATCH GAME_AWARD_HURRYUP, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
            DISPATCH GAME_COMBO, lsCombo1
        End If
    Else
        gameState("switches")("leftOrbit") = 1
    End If
    gameState("switches")("preLeftOrbit") = 0
    gameState("switches")("preRightOrbit") = 0
End Sub
Sub SwitchHitLeftRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_LEFT_RAMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 2 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_LEFT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If IsActiveGameShot(GAME_SHOT_LEFT_RAMP,GAME_MODE_MULTIBALL) Then
            RemoveGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
            LightOn(lsCyber2)
            lSeqMultiballY.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_LEFT_RAMP,GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
        DISPATCH GAME_COMBO, lsCombo2
    End If
End Sub
Sub SwitchHitPreRightOrbit()
    If gameState("switches")("rightOrbit") = 1 Then
        gameState("switches")("preRightOrbit") = 0
        gameState("switches")("rightOrbit") = 0
    Else
        gameState("switches")("preRightOrbit") = 1
    End If
End Sub

Sub SwitchHitRightOrbit()
    If gameState("switches")("preRightOrbit") = 1 Then
        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            PlaySound "left_orbit"
            'LightSeqGIUpperLeft.StopPlay
            'LightSeqGIUpperLeft.UpdateInterval = 2
            'LightSeqGIUpperLeft.Play SeqArcTopRightUpOn, 2, 0
            'LightSeqGIUpperLeft.Play SeqArcTopRightUpOff, 2, 0
            GameAddScore GAME_POINTS_BASE
            If gameState("game")("perkShot") = GAME_SHOT_RIGHT_ORBIT Then
                DISPATCH GAME_AWARD_PERKSHOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
            If gameState("game")("augmentationActive") = 7 Then
                DISPATCH GAME_AWARD_SKILLSHOT, Null
            End If
        End If
    
        If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
            If IsActiveGameShot(GAME_SHOT_RIGHT_ORBIT,GAME_MODE_AUGMENTATION_RESEARCH) Then
                DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
            If IsActiveGameShot(GAME_SHOT_RIGHT_ORBIT,GAME_MODE_MULTIBALL) Then
                RemoveGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
                LightOn(lsCyber5)
                lSeqMultiballR.RemoveAll()
                DISPATCH GAME_MULTIBALL_JACKPOT, null
            End If
        End If

        If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
            If IsActiveGameShot(GAME_SHOT_RIGHT_ORBIT,GAME_MODE_HURRYUP) Then
                DISPATCH GAME_AWARD_HURRYUP, null
            End If
        End If

        
        If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
            DISPATCH GAME_COMBO, lsCombo5
        End If
    Else
        gameState("switches")("rightOrbit") = 1
    End If
    gameState("switches")("preRightOrbit") = 0
    gameState("switches")("preLeftOrbit") = 0
End Sub
Sub SwitchHitRightRamp()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_RIGHT_RAMP Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 6 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP_COLLECT,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_FINISH_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = True Then
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP,GAME_MODE_MULTIBALL) Then
            RemoveGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
            LightOn(lsCyber4)
            lSeqMultiballE.RemoveAll()
            DISPATCH GAME_MULTIBALL_JACKPOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP,GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_MULTIBALL) = False Then
        DISPATCH GAME_COMBO, lsCombo4
    End If
End Sub

Sub SwitchHitShortcut()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        GameAddScore GAME_POINTS_BASE
        If gameState("game")("perkShot") = GAME_SHOT_SHORTCUT Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 8 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_SHORTCUT,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_SHORTCUT,GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If

    gameState("switches")("shortcut") = 1
End Sub
Sub SwitchHitSpinner2()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        PlaySoundAt "fx-spinner2", Spinner2
        GameAddScore GAME_POINTS_SPINNER
        If gameState("game")("perkShot") = GAME_SHOT_SPINNER Then
            DISPATCH GAME_AWARD_PERKSHOT, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        If gameState("game")("augmentationActive") = 3 Then
            DISPATCH GAME_AWARD_SKILLSHOT, Null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        PlaySoundAt "fx-spinner2", Spinner2
        If IsActiveGameShot(GAME_SHOT_SPINNER,GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_ADVANCE_AUGMENTATION, null
        End If
    End If

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        If IsActiveGameShot(GAME_SHOT_SPINNER,GAME_MODE_HURRYUP) Then
            DISPATCH GAME_AWARD_HURRYUP, null
        End If
    End If
End Sub

'***********************************************************************************************************************
'*****  Switches Actions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Const SWITCH_HIT_AUGMENTATION = "Switches Hit Augmentation"
Const SWITCH_HIT_CAPTIVE = "Switches Hit Captive"
Const SWITCH_HIT_RESEARCH_1 = "Switches Hit Research 1"
Const SWITCH_HIT_RESEARCH_2 = "Switches Hit Research 2"
Const SWITCH_HIT_RESEARCH_3 = "Switches Hit Research 3"
Const SWITCH_LEFT_FLIPPER_DOWN = "Switches Left Flipper Down"
Const SWITCH_RIGHT_FLIPPER_DOWN = "Switches Right Flipper Down"
Const SWITCH_HIT_PRE_LEFT_ORBIT = "Switches Hit Pre Left Orbit"
Const SWITCH_HIT_LEFT_ORBIT = "Switches Hit Left Orbit"
Const SWITCH_HIT_PRE_RIGHT_ORBIT = "Switches Hit Pre Right Orbit"
Const SWITCH_HIT_RIGHT_ORBIT = "Switches Hit Right Orbit"
Const SWITCH_HIT_CONSOLE = "Switches Hit Console"
Const SWITCH_HIT_SPINNER2 = "Switches Hit Spinner 2"
Const SWITCH_HIT_HYPERJUMP = "Switches Hit Hyper Jump"
Const SWITCH_HIT_BUMPER = "Switches Hit Bumper"
Const SWITCH_HIT_LEFT_RAMP = "Switches Hit Left Ramp"
Const SWITCH_HIT_RIGHT_RAMP = "Switches Hit Right Ramp"
Const SWITCH_HIT_CENTER_RAMP = "Switches Hit Center Ramp"
Const SWITCH_HIT_SHORTCUT = "Switches Hit Shortcut"
Const SWITCH_HIT_RAMP_PIN = "Switches Hit Ramp Pin"
Const SWITCH_HIT_PLUNGER_LANE = "Switches Hit Plunger Lane"
Const SWITCH_HIT_LIGHT_LOCK = "Switches Hit Light Lock"
Const SWITCH_HIT_LEFT_OUTLANE = "Switches Hit Left Outlane"
Const SWITCH_HIT_LEFT_INLANE = "Switches Hit Left Inlane"
Const SWITCH_HIT_RIGHT_INLANE = "Switches Hit Right Inlane"
Const SWITCH_HIT_RIGHT_OUTLANE = "Switches Hit Right Outlane"
Const SWITCH_HIT_BALL_LOCK = "Switches Hit Ball Lock"
Const SWITCH_HIT_SECRET_UPGRADE = "Switches Hit Secret Upgrade"
Const SWITCH_HIT_BET = "Switches Hit Bet"


'***********************************************************************************************************************

'***********************************************************************************************************************
'*****  Lights Dispatch                                   	                                                        ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub SwitchHitAugmentation()
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        Exit Sub
    End If

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If gameState("switches")("augmentation") = 0 And gameState("game")("augmentationHold") = 1 Then
            Dim c: c = RndNum(0,8)

            LightOff(lcAugmentations(gameState("game")("augmentationActive")))
            
            gameState("game")("augmentationActive") = c
            gameState("switches")("augmentation") = 1
            
            PlaySoundAt "fx_aug_switch_hit", ActiveBall
    
            Dim lActiveAug: Set lActiveAug = New LightChangeItem
            lActiveAug.Init c,1,20,"pal_blue"
            
            'Dim lSeqReset: Set lSeqReset = new LightSeqItem
            'lSeqReset.Name = "lSeqReset"
            'lSeqReset.Sequence = Array(Array(lsAug1Off,lsAug2Off,lsAug3Off,lsAug4Off,lsAug5Off,lsAug6Off,lsAug7Off,lsAug8Off,lsAug9Off),lActiveAug)
            'lSeqAugmentation.ResetSequence = lSeqReset
            lSeqAugmentation.AddItem(lSeqAugmentationFlicker)
            
            vpmTimer.addtimer 600, "SwitchSetAugmentation True, ""pal_orange"" '"
            vpmTimer.addtimer 1200, "SwitchSetAugmentationCooldown '"

    
        End If
    End If

End Sub

Sub SwitchSetAugmentationCooldown()

    gameState("switches")("augmentation") = 0

End Sub

Sub SwitchSetAugmentation(playCallout, palette)
    
    If usePUP = True Then
        PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\aug" & AugmentationNames(gameState("game")("augmentationActive")) & ".png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"
        GameSetAugmentationPerkLabels()
    End If
    
    
    LightOff(lsAug1)
    LightOff(lsAug2)
    LightOff(lsAug3)
    LightOff(lsAug4)
    LightOff(lsAug5)
    LightOff(lsAug6)
    LightOff(lsAug7)
    LightOff(lsAug8)
    LightOff(lsAug9)
    
    LightOn(lcAugmentations(gameState("game")("augmentationActive")))
    
    If palette = "pal_orange" Then
        gameState("game")("perkShot") = GameShots(gameState("game")("augmentationActive"))
    End If
    
    lSeqHyperJump.RemoveItem(lSeqHyperJumpPerkShot)
    lSeqLeftOrbit.RemoveItem(lSeqLeftOrbitPerkShot)
    lSeqShortcut.RemoveItem(lSeqShortcutPerkShot)
    lSeqRightOrbit.RemoveItem(lSeqRightOrbitPerkShot)
    lSeqRightRamp.RemoveItem(lSeqRightRampPerkShot)
    lSeqCenterRamp.RemoveItem(lSeqCenterRampPerkShot)
    lSeqSpinner.RemoveItem(lSeqSpinnerPerkShot)
    lSeqBumpers.RemoveItem(lSeqBumpersPerkShot)
    lSeqLeftRamp.RemoveItem(lSeqLeftRampPerkShot)
    
    Select Case gameState("game")("augmentationActive")
        Case 0:
            lSeqHyperJumpPerkShot.Image = palette
            lSeqHyperJump.AddItem(lSeqHyperJumpPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(0)(gameState("game")("augTigerLvl")) End If
        Case 1:
            lSeqLeftOrbitPerkShot.Image = palette
            lSeqLeftOrbit.AddItem(lSeqLeftOrbitPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(1)(gameState("game")("augBatLvl")) End If
        Case 2:
            lSeqLeftRampPerkShot.Image = palette
            lSeqLeftRamp.AddItem(lSeqLeftRampPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(2)(gameState("game")("augBullLvl")) End If
        Case 3:
            lSeqSpinnerPerkShot.Image = palette
            lSeqSpinner.AddItem(lSeqSpinnerPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(3)(gameState("game")("augLionLvl")) End If
        Case 4:
            lSeqBumpersPerkShot.LampColor = PaletteToLampLookup(palette)
            lSeqBumpers.AddItem(lSeqBumpersPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(4)(gameState("game")("augHawkLvl")) End If
        Case 5:
            lSeqCenterRampPerkShot.Image = palette
            lSeqCenterRamp.AddItem(lSeqCenterRampPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(5)(gameState("game")("augDeerLvl")) End If
        Case 6:
            lSeqRightRampPerkShot.Image = palette
            lSeqRightRamp.AddItem(lSeqRightRampPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(6)(gameState("game")("augPAntherLvl")) End If
        Case 7:
            lSeqRightOrbitPerkShot.Image = palette
            lSeqRightOrbit.AddItem(lSeqRightOrbitPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(7)(gameState("game")("augOwlLvl")) End If
        Case 8:
            lSeqShortcutPerkShot.Image = palette
            lSeqShortcut.AddItem(lSeqShortcutPerkShot)
            If playCallout Then PlayGameCallout AugmentationSounds(8)(gameState("game")("augRhinoLvl")) End If
    End Select
    
End Sub

Sub SwitchHitCaptive()
    
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If gameState("switches")("captive") = 0 Then
    
            If gameState("game")("augmentationHold") = 1 Then
                'Turn off lights
                DISPATCH GAME_LOCK_AUGMENTATIONS, null
                PlayGameCallout "augmentation_held"
                'Activate Timer.
            End If
            PlaySoundAt "fx_target", ActiveBall
        End If
    End If
End Sub

Sub SwitchHitResearch1()

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug1") Then
            LightOn(lsResearch1)
            PlayGameCallout "research_node_collected"
            gameState("lights")("activeResearch").Add "aug1", True
            CheckResearchLights
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug1") Then
            LightOn(lsResearch1)
            gameState("lights")("activeResearch").Add "aug1", True
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If
End Sub

Sub SwitchHitResearch2()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug2") Then
            LightOn(lsResearch2)
            PlayGameCallout "research_node_collected"
            gameState("lights")("activeResearch").Add "aug2", True
            CheckResearchLights
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug2") Then
            LightOn(lsResearch2)
            gameState("lights")("activeResearch").Add "aug2", True
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If
End Sub

Sub SwitchHitResearch3()  
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug3") Then
            LightOn(lsResearch3)
            PlayGameCallout "research_node_collected"
            gameState("lights")("activeResearch").Add "aug3", True
            CheckResearchLights
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If

    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If Not gameState("lights")("activeResearch").Exists("aug3") Then
            LightOn(lsResearch3)
            gameState("lights")("activeResearch").Add "aug3", True
        End If
        GameAddScore GAME_POINTS_RESEARCH_NODE
    End If
End Sub

Sub CheckResearchLights()

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        Dim powerLights: powerLights = gameState("lights")("activeResearch").Count

        If gameState("lights")("activeResearch").Exists("aug1") Then
            LightOn(lsResearch1)
        End If
        If gameState("lights")("activeResearch").Exists("aug2") Then
            LightOn(lsResearch2)
        End If
        If gameState("lights")("activeResearch").Exists("aug3") Then
            LightOn(lsResearch3)
        End If

        If powerLights=3 Then
            PlayGameCallout "research_ready"
            Dispatch GAME_AUGMENTATION_READY, Null
        End If
    End If

End Sub

Sub CheckLaneLights()

    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        Dim lanesOn: lanesOn = 0

        If gameState("laneLights")("leftOuter")=1 Then
            LightOn(lsLane1)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane1)
        End If
        If gameState("laneLights")("leftInner")=1 Then
            LightOn(lsLane2)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane2)            
        End If
        If gameState("laneLights")("rightInner")=1 Then
            LightOn(lsLane3)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane3)            
        End If
        If gameState("laneLights")("rightOuter")=1 Then
            LightOn(lsLane4)
            lanesOn = lanesOn + 1
        Else
            LightOff(lsLane4)
        End If

        If lanesOn=4 And gameState("game")("raceReady") = 0 Then
            PlayGameCallout "race_ready"
            Dispatch GAME_RACE_READY, Null
        End If
    Else
        LightOff(lsLane1)
        LightOff(lsLane2)
        LightOff(lsLane3)
        LightOff(lsLane4)
    End If

End Sub

Sub SwitchLeftFlipperDown()

    If gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True Then
        'Rotate Skillshot
        gameState("switches")("lastFlipperDown") = GameTime
        DISPATCH GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE, Null
    End If

    Dispatch ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE, Null
End Sub

Sub SwitchRightFlipperDown()

    If gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True Then
        'Rotate Skillshot
        gameState("switches")("lastFlipperDown") = GameTime
        DISPATCH GAME_ROTATE_SKILLSHOT_CLOCKWISE, Null
    End If

    Dispatch ROTATE_LANE_LIGHTS_CLOCKWISE, Null
End Sub

Sub SwitchHitConsole()
    Dim waittime
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then        
        If gameState("game")("augmentationReady") = True Then
            DISPATCH GAME_START_AUGMENTATION_RESEARCH, null
            Exit Sub
        End If
    End If

    PlaySound "console_off"
    'objFluxTimer(1).UserValue = 0
    'objFluxBase(1).UserValue = 1
    'objFluxBase(1).Material = "Console_HUD_Red"
    DOF 235, DOFPulse
    'FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
    waittime = 400
    vpmTimer.addtimer waittime, "exitConsoleKickerWithFlash '"

End Sub

Sub exitConsoleKickerWithFlash
    'objFluxTimer(1).UserValue = 0
    'objFluxBase(1).UserValue = 1
    'objFluxBase(1).Material = "Console_HUD_Red"
    'FluxObjlevel(1) = 1 : FlasherFluxTimer1_Timer
    'consoleKicker.Kick 0, 30, 1.36
    vukCenterRamp.Kick 0, 120, .5
End Sub

Sub SwitchHitRampPin()
    If gameState("game")("modes")(GAME_MODE_AUGMENTATION_RESEARCH) = True Then
        If IsActiveGameShot(GAME_SHOT_RIGHT_RAMP_COLLECT, GAME_MODE_AUGMENTATION_RESEARCH) Then
            DISPATCH GAME_MODE_COLLECT_AUGMENTATION, null
        End If
    End If
End Sub

Sub SwitchHitPlungerLane()
    If gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = True Then
        DISPATCH GAME_MODE_NORMAL, Null
        DOF 210, DOFOff 'Plunger Lane Off
        gameState("game")("modes")(GAME_MODE_CHOOSE_SKILLSHOT) = False
        DISPATCH GAME_LOCK_AUGMENTATIONS, null
        DISPATCH GAME_ENABLE_BALL_SAVE, null
        lSeqPlungerLane.RemoveAll()
        FlexDMDGameModeNormal()
        vpmTimer.addtimer 10000, "vpmTimerEndSkillshot '"
    End If
End Sub

Sub vpmTimerEndSkillshot()
    If gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = True Then
        gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
        If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
            SwitchSetAugmentation False, "pal_orange"
            DISPATCH GAME_UNLOCK_AUGMENTATIONS, Null
            DISPATCH GAME_CHECK_BET, Null
        End If
    End If
End Sub

Sub SwitchHitLightLock()
    If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
        If gameState("switches")("lightlock") = 0 Then 'Off
            gameState("switches")("lightlock") = 1
        ElseIf gameState("switches")("lightlock") = 1 Then 'Blinking
            PlayGameCallout "locks_lit"
            LockPin.IsDropped = False
            gameState("switches")("lightlock") = 2
            'TurnOffFluxFlasher(4)
            'FluxObjlevel(4) = 1.5
            'TurnOnFluxFlasher(4)
        
            'objFluxTimer(5).UserValue = 2
            'objFluxBase(5).UserValue = 1
            'objFluxOffBrightness(5) = 0.5
            'FluxObjlevel(5) = 0.1 : FlasherFluxTimer5_Timer
            'LightFluxFlash 5, FlasherFluxTimer5

        ElseIf gameState("switches")("lightlock") = 2 Then 'On
            ' Callout locks already activate
        End If
        DISPATCH GAME_CHECK_LOCKS, Null
    End If
    
End Sub

Sub SwitchHitLeftOutlane()
    gameState("laneLights")("leftOuter") = 1
    'gameState("game")("outlaneDrain") = True
    CheckLaneLights()
    lSeqLeftDrain.AddItem(lSeqLeftDrainBlink)
    PlaySound "drain"
    DOF 220, DOFPulse
    If gameState("game")("ballSave") = True Then
        ballRelease.CreateSizedball BallSize / 2
        ballRelease.Kick 90, 4
        vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
        PlungerIM.AutoFire
    End If
End Sub

Sub SwitchHitLeftInlane()
    gameState("laneLights")("leftInner") = 1
    CheckLaneLights()
End Sub

Sub SwitchHitRightInlane()
    gameState("laneLights")("rightInner") = 1
    CheckLaneLights()
End Sub

Sub SwitchHitRightOutlane()
    gameState("laneLights")("rightOuter") = 1
    'gameState("game")("outlaneDrain") = True
    CheckLaneLights()
    lSeqRightDrain.AddItem(lSeqRightDrainBlink)
    PlaySound "drain"
    DOF 221, DOFPulse
    If gameState("game")("ballSave") = True Then
        ballRelease.CreateSizedball BallSize / 2
        ballRelease.Kick 90, 4
        vpmTimer.addtimer 1000, "vpmTimerDelayedAutoPlunge '"
        PlungerIM.AutoFire
    End If
End Sub

Sub SwitchHitBallLock()
    'If gameState("game")("modes")(GAME_MODE_NORMAL) = True Then
    'gameState("switches")("lockPinHit") = True

    If gameState("game")("ballsLocked")=2 Then
        'StartMultiball
        PlayGameCallout "ball_3_locked"
        DOF 255, DOFOn
        gameState("game")("modes")(GAME_MODE_MULTIBALL) = True
        gameState("game")("modes")(GAME_MODE_NORMAL) = False
        gameState("game")("modes")(GAME_MODE_HURRYUP) = False
        gameState("game")("modes")(GAME_MODE_SKILLSHOT_ACTIVE) = False
        AddGameTargetShot GAME_SHOT_LEFT_ORBIT, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_LEFT_RAMP, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_CENTER_RAMP, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_RIGHT_RAMP, GAME_MODE_MULTIBALL
        AddGameTargetShot GAME_SHOT_RIGHT_ORBIT, GAME_MODE_MULTIBALL
        gameState("game")("ballsInPlay") = 3
        'Turn Scoop off
        StopBGAudio()
        TurnOffFluxFlasher(1)
        TurnOffFluxFlasher(2)
        LightOff(lsResearchReady)
        DISPATCH GAME_HIDE_LABELS, null
        pupevent 506 'music multiball
        pupevent 412 'backglass multiball
        gameState("game")("multiballPlayed") = True
        vpmTimer.addtimer Timings(TIMINGS_START_MULTIBALL), "vpmTimerMultiBallStage2 '"
        gameState("switches")("lightlock") = 0
        gameState("game")("ballsLocked") = 0
        DISPATCH GAME_DISABLE_BALL_LOCK, Null
        DISPATCH GAME_CHECK_LOCKS, Null
    Else
        gameState("game")("ballsLocked")=gameState("game")("ballsLocked")+1
        If gameState("game")("ballsLocked")=1 Then
            DOF 253, DOFOn
        Else
            DOF 254, DOFOn
        End If
        PlayGameCallout "ball_" & gameState("game")("ballsLocked") & "_locked"
        ballRelease.CreateSizedball BallSize / 2
        ballRelease.Kick 90, 4
        If gameState("game")("multiballPlayed") = True Then
            DISPATCH GAME_DISABLE_BALL_LOCK, Null
            gameState("switches")("lightlock") = 1
            DISPATCH GAME_CHECK_LOCKS, Null
        End If
    End If
    vpmTimer.addtimer Timings(TIMINGS_START_MULTIBALL), "vpmTimerMultiBallDOFOff '"
    'End If
End Sub

Sub vpmTimerMultiBallDOFOff
    DOF 253, DOFOff
    DOF 254, DOFOff
    DOF 255, DOFOff
End Sub

Sub vpmTimerMultiBallStage2
    DISPATCH LIGHTS_GI_MULTIBALL, Null
    DISPATCH GAME_ENABLE_BALL_SAVE, Null
    pupevent 600
    DISPATCH GAME_SHOW_LABELS, null
    LockPin.IsDropped = True
    lSeqMultiballC.AddItem(lSeqMultiballCShot)
	lSeqMultiballY.AddItem(lSeqMultiballYShot)
	lSeqMultiballB.AddItem(lSeqMultiballBShot)
	lSeqMultiballE.AddItem(lSeqMultiballEShot)
	lSeqMultiballR.AddItem(lSeqMultiballRShot)
End Sub	

Sub SwitchHitSecretUpgrade()

    diverterWall3Off.IsDropped = 1
	diverterWall3On.IsDropped = 0
    vpmTimer.addtimer 1000, "vpmTimerCloseSecretUpgrade '"
End Sub

Sub vpmTimerCloseSecretUpgrade()
    diverterWall3Off.IsDropped = 0
    diverterWall3On.IsDropped = 1
End Sub

Sub SwitchHitBet

    If gameState("game")("modes")(GAME_MODE_HURRYUP) = True Then
        Exit Sub
    End If

    gameState("game")("betHits") = gameState("game")("betHits") - 1
    
    DISPATCH GAME_CHECK_BET, Null

    If gameState("game")("betHits") = 0 Then
        gameState("game")("betTimesRan") = gameState("game")("betTimesRan") + 1
        gameState("game")("betHits") = 3 * (gameState("game")("betTimesRan")+1)
        If gameState("game")("betHits") > GAME_BET_MAX_HITS Then
            gameState("game")("betHits") = GAME_BET_MAX_HITS
        End If
        DISPATCH GAME_START_MODE_HURRYUP, Null
    End If
End Sub


'***********************************************************************************************************************


'***********************************************************************************************************************
'*****  Switches State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitSwitchesState()
    Dim switches:Set switches=CreateObject("Scripting.Dictionary")

    switches("preLeftOrbit") = 0
    switches("leftOrbit") = 0
    switches("preRightOrbit") = 0
    switches("rightOrbit") = 0
    switches("augmentation") = 0
    switches("captive") = 0
    switches("shortcut") = 0
    switches("lightlock") = 0
    switches("betB") = 1
    switches("betE") = 0
    switches("betT") = 0
    switches("lastFlipperDown") = 0

    Set InitSwitchesState = switches
End Function

'***********************************************************************************************************************

'***********************************************************************************************************************
'*****   Utilitiy Functions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function Min(value, minVal)
	if value < minVal then
		Min=Value
	Else 
		Min=minVal
	End If 
End Function

Function RndNum(min,max)
	RndNum = Int(Rnd()*(max-min+1))+min     ' Sets a random number between min AND max
End Function
Sub EnableWatchTimer(seconds)
	seconds = seconds + 0.3  'padding
	WatchDisplayTimerExpired.Interval = 1000 * seconds
	WatchDisplayTimerExpired.Enabled = True

	'p_watchdisplay_full.Visible = True
	p_watchdisplay_left.Visible = True
	p_watchdisplay_right.Visible = True

	'Set display to x seconds 
	dbstime = seconds
	dbsdelta = .1
	WatchDisplayUpdateTimer.Interval = 100

	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
    WatchDisplayUpdateTimer.Enabled = True
End Sub

Sub StopWatchDisplay
	WatchDisplayTimerExpired.Enabled = False
	WatchDisplayUpdateTimer.Enabled = False
	ResetBallSaveDisplay
	StopLightBlink(lsBallSave)
End Sub

Sub WatchDisplayTimerExpired_Timer()
    WatchDisplayTimerExpired.Enabled = False
    WatchDisplayUpdateTimer.Enabled = False
	ResetBallSaveDisplay
End Sub

Sub ResetWatchDisplay
	p_watchdisplay_left.Visible = False
	p_watchdisplay_right.Visible = False
	p_watchdisplay_full.blenddisablelighting = 0
	p_watchdisplay_left.blenddisablelighting = 0
	p_watchdisplay_right.blenddisablelighting = 0
End Sub

Sub WatchDisplayUpdateTimer_Timer()
	Dim tmp
	dbstens = Int(dbstime/10)
	dbsones = Int(dbstime-dbstens*10)
	dbsdecimals = Int((dbstime-dbstens*10-dbsones)*10)

	if dbstime > 10 then 
		p_watchdisplay_left.Image = "digit_" & Eval(dbstens)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsones)
	else
		p_watchdisplay_left.Image = "digit_" & Eval (dbsones + 10)
		p_watchdisplay_right.Image = "digit_" & Eval(dbsdecimals)
	end if
	dbstime = dbstime - dbsdelta
End Sub