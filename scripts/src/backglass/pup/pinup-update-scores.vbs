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