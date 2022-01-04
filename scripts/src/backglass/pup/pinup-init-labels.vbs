

Sub InitPupLabels
    if (usePUP=false or PUPStatus=false) then Exit Sub
    
    PuPlayer.LabelInit pBackglass
    Dim popFont:popfont="Sendha"

    'syntax - PuPlayer.LabelNew <screen# or pDMD>,<Labelname>,<fontName>,<size%>,<colour>,<rotation>,<xAlign>,<yAlign>,<xpos>,<ypos>,<PageNum>,<visible>
    'PuPlayer.LabelNew pBackglass,"Play1",popFont,3,16777215,0,0,1,23,81,1,1

    '				    Scrn        LblName                 Fnt         Size	        Color	 		    R   Ax    Ay    X       Y           pagenum     Visible 
    'PuPlayer.LabelNew pBackglass,"Player"  ,popFont,21*1,RGB(3, 57, 252)	,1,0,0, 0,0,	1,	0
    PuPlayer.LabelNew   pBackglass, "CurScore1",            popFont,    8,              RGB(0, 255, 220),  0,  1,    1,    0,      0,          1,          1
    PuPlayer.LabelNew   pBackglass, "lblPlayer",            popFont,    8,              RGB(0, 255, 220),  0,  0,    0,    26,     33,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblBall",              popFont,    8,              RGB(0, 255, 220),  0,  0,    0,    63,     33,         1,          1
    PuPlayer.LabelNew   pBackglass, "lblAug",               popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    PuPlayer.LabelNew   pBackglass, "lblPerk",              popFont,	4,              RGB(0, 255, 220),  0,  0,    0,    26,     60,         1,          1
    'PuPlayer.LabelNew   pBackglass, "lblE",                 popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblS",                 popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblE2",                 popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblA",                 popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblR2",                 popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblC",                 popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1
    'PuPlayer.LabelNew   pBackglass, "lblH",                 popFont,	6,              RGB(0, 0, 0)	,  0,  0,    0,    0,      0,          1,          1

    PuPlayer.LabelSet   pBackglass, "lblAug",       "PupOverlays\\augLion.png", 1,  "{'mt':2,'width':25, 'height':25, 'ypos':37,'xpos':0}"
    PuPlayer.LabelSet   pBackglass, "lblPlayer",    "Player 1",                 1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblBall",      "Ball 1",                   1,  "{}"
    PuPlayer.LabelSet   pBackglass, "lblPerk",      "Perk: 2x Left Orbit",            1,  "{}"
    
    
End Sub