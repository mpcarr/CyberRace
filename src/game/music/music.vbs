
Const MUSIC1 =  "Karl Casey - White Bat I - 01 Elysium"
Const MUSIC2 =  "Karl Casey - White Bat I - 02 Casualty"
Const MUSIC3 =  "Karl Casey - White Bat I - 04 Patrol Bot"
Const MUSIC4 =  "Karl Casey - White Bat I - 05 Alliance"
Const MUSIC5 =  "Karl Casey - White Bat I - 07 Self Inflicted"
Const MUSIC6 =  "Karl Casey - White Bat I - 08 B.F.G."
Const MUSIC7 =  "Karl Casey - White Bat I - 09 The Witch"
Const MUSIC8 = "Karl Casey - White Bat I - 10 The Traveler"

Const MUSIC_RACE = "Karl Casey - White Bat I - 03 Anima"
Const MUSIC_MULTIBALL =  "Karl Casey - White Bat I - 06 Last Man Standing"

'****************************
' Music
' Event Listeners:  
RegisterPinEvent START_GAME,    "MusicOn"
RegisterPinEvent NEXT_PLAYER,   "MusicOn"
'
'*****************************
Sub MusicOn
    Dim x
    x = RndInt(0,7)
    Select Case x
        Case 0:PlayMusic "cyberrace\" & MUSIC1 & ".mp3", MusicVol
        Case 1:PlayMusic "cyberrace\" & MUSIC2 & ".mp3", MusicVol
        Case 2:PlayMusic "cyberrace\" & MUSIC3 & ".mp3", MusicVol
        Case 3:PlayMusic "cyberrace\" & MUSIC4 & ".mp3", MusicVol
        Case 4:PlayMusic "cyberrace\" & MUSIC5 & ".mp3", MusicVol
        Case 5:PlayMusic "cyberrace\" & MUSIC6 & ".mp3", MusicVol
        Case 6:PlayMusic "cyberrace\" & MUSIC7 & ".mp3", MusicVol
        Case 7:PlayMusic "cyberrace\" & MUSIC8 & ".mp3", MusicVol
    End Select
End Sub

Sub MusicOff
    EndMusic
End Sub

Sub Table1_MusicDone()
    MusicOn
End Sub