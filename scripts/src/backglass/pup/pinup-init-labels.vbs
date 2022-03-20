

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