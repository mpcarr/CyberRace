'****************************
' Race Ready
' Event Listeners:      
    RegisterPlayerStateEvent RACE_MODE_READY, "RaceModeReady"
    RegisterPlayerStateEvent MODE_MULTIBALL, "RaceModeReady"
'
'*****************************
Sub RaceModeReady()
    If GetPlayerState(RACE_MODE_READY) = True And GetPlayerState(MODE_MULTIBALL) = False Then
        lightCtrl.Blink l73
        lightCtrl.Blink l74
        lightCtrl.Blink l75
        lightCtrl.Blink l76
        lightCtrl.AddShot RACE_MODE_READY, l63, GAME_RACE_COLOR
    Else
        lightCtrl.LightOff l73
        lightCtrl.LightOff l74
        lightCtrl.LightOff l75
        lightCtrl.LightOff l76
        lightCtrl.RemoveShot RACE_MODE_READY, l63
    End If
End Sub


'****************************
' LightsRaceMode
' Event Listeners:      
    RegisterPlayerStateEvent RACE_MODE_SELECTION, "LightsRaceMode"
    RegisterPlayerStateEvent MODE_RACE_SELECT, "LightsRaceMode"
'
'*****************************
Sub LightsRaceMode()
    If GetPlayerState(MODE_RACE_SELECT) = True Then
        lightCtrl.RemoveAllTableLightSeqs()
        If GetPlayerState(RACE_1) = 1 Then
            lightCtrl.AddTableLightSeq "RaceSelection1On", lSeqRaceMode1On
        End If
        If GetPlayerState(RACE_2) = 1 Then
            lightCtrl.AddTableLightSeq "RaceSelection2On", lSeqRaceMode2On
        End If
        If GetPlayerState(RACE_3) = 1 Then
            lightCtrl.AddTableLightSeq "RaceSelection3On", lSeqRaceMode3On
        End If
        If GetPlayerState(RACE_4) = 1 Then
            lightCtrl.AddTableLightSeq "RaceSelection4On", lSeqRaceMode4On
        End If
        If GetPlayerState(RACE_5) = 1 Then
            lightCtrl.AddTableLightSeq "RaceSelection5On", lSeqRaceMode5On
        End If
        If GetPlayerState(RACE_6) = 1 Then
            lightCtrl.AddTableLightSeq "RaceSelection6On", lSeqRaceMode6On
        End If
        Select Case GetPlayerState(RACE_MODE_SELECTION):
            Case 1: 
                lightCtrl.AddTableLightSeq "RaceSelection", lSeqRaceModeSelection1
            Case 2
                lightCtrl.AddTableLightSeq "RaceSelection", lSeqRaceModeSelection2
            Case 3:
                lightCtrl.AddTableLightSeq "RaceSelection", lSeqRaceModeSelection3
            Case 4:
                lightCtrl.AddTableLightSeq "RaceSelection", lSeqRaceModeSelection4
            Case 5:
                lightCtrl.AddTableLightSeq "RaceSelection", lSeqRaceModeSelection5
            Case 6:
                lightCtrl.AddTableLightSeq "RaceSelection", lSeqRaceModeSelection6
        End Select
    Else

    End If
End Sub


'****************************
' Mode Race
' Event Listeners:      
    RegisterPlayerStateEvent MODE_RACE, "ModeRace"
'
'*****************************
Sub ModeRace()
    If GetPlayerState(MODE_RACE) = True Then
        Select Case GetPlayerState(RACE_MODE_SELECTION):
            Case 1: 
                lightCtrl.Blink l53
            Case 2
                lightCtrl.Blink l54
            Case 3:
                lightCtrl.Blink l55
            Case 4:
                lightCtrl.Blink l56
            Case 5:
                lightCtrl.Blink l57
            Case 6:
                lightCtrl.Blink l58
        End Select
    Else
        LightsModeRace1()
        LightsModeRace2()
        LightsModeRace3()
        LightsModeRace4()
        LightsModeRace5()
        LightsModeRace6()
    End If
End Sub

'****************************
' Mode Race 1
' Event Listeners:      
    RegisterPlayerStateEvent RACE_1, "LightsModeRace1"
'
'*****************************
Sub LightsModeRace1()
    lightCtrl.LightState l53, GetPlayerState(RACE_1)
End Sub

'****************************
' Mode Race 2
' Event Listeners:      
    RegisterPlayerStateEvent RACE_2, "LightsModeRace2"
'
'*****************************
Sub LightsModeRace2()
    lightCtrl.LightState l54, GetPlayerState(RACE_2)
End Sub

'****************************
' Mode Race 3
' Event Listeners:      
    RegisterPlayerStateEvent RACE_3, "LightsModeRace3"
'
'*****************************
Sub LightsModeRace3()
    lightCtrl.LightState l55, GetPlayerState(RACE_3)
End Sub

'****************************
' Mode Race 4
' Event Listeners:      
    RegisterPlayerStateEvent RACE_4, "LightsModeRace4"
'
'*****************************
Sub LightsModeRace4()
    lightCtrl.LightState l56, GetPlayerState(RACE_4)
End Sub

'****************************
' Mode Race 5
' Event Listeners:      
    RegisterPlayerStateEvent RACE_5, "LightsModeRace5"
'
'*****************************
Sub LightsModeRace5()
    lightCtrl.LightState l57, GetPlayerState(RACE_5)
End Sub

'****************************
' Mode Race 6
' Event Listeners:      
    RegisterPlayerStateEvent RACE_6, "LightsModeRace6"
'
'*****************************
Sub LightsModeRace6()
    lightCtrl.LightState l58, GetPlayerState(RACE_6)
End Sub
