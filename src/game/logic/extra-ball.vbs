
'****************************
' PS_RaceExtraBall
' Event Listeners:          
    AddPlayerStateEventListener RACE_1, RACE_1 &   "PS_RaceExtraBall",   "PS_RaceExtraBall",  1000, Null
    AddPlayerStateEventListener RACE_2, RACE_2 &   "PS_RaceExtraBall",   "PS_RaceExtraBall",  1000, Null
    AddPlayerStateEventListener RACE_3, RACE_3 &   "PS_RaceExtraBall",   "PS_RaceExtraBall",  1000, Null
    AddPlayerStateEventListener RACE_4, RACE_4 &   "PS_RaceExtraBall",   "PS_RaceExtraBall",  1000, Null
    AddPlayerStateEventListener RACE_5, RACE_5 &   "PS_RaceExtraBall",   "PS_RaceExtraBall",  1000, Null
    AddPlayerStateEventListener RACE_6, RACE_6 &   "PS_RaceExtraBall",   "PS_RaceExtraBall",  1000, Null
'*****************************
Sub PS_RaceExtraBall()
    If GetPlayerState(RACE_EXTRABALL) = 0 Then
        If  GetPlayerState(RACE_1) = 1 Or _
            GetPlayerState(RACE_2) = 1 Or _
            GetPlayerState(RACE_3) = 1 Or _
            GetPlayerState(RACE_4) = 1 Or _
            GetPlayerState(RACE_5) = 1 Or _
            GetPlayerState(RACE_6) = 1 Then
            SetPlayerState RACE_EXTRABALL, 1
            calloutsQ.Add "extraballlit", "PlayCallout(""extraball-lit"")", 1, 0, 0, 3700, 0, False
        End If
    End If
End Sub

'****************************
' Claim Extra Ball
' Event Listeners:      
AddPinEventListener SWITCH_HIT_SCOOP, SWITCH_HIT_SCOOP &   "ClaimExtraBall",   "ClaimExtraBall",  1000, Null
'
'*****************************
Sub ClaimExtraBall()
    If GetPlayerState(RACE_EXTRABALL) = 1 Then
        SetPlayerState RACE_EXTRABALL, 2
        SetPlayerState EXTRA_BALLS, GetPlayerState(EXTRA_BALLS)+1
        FlexExtraBallScene()
        PlayExtraBallSeq()
        calloutsQ.Add "extraball", "PlayCallout(""extraball"")", 1, 0, 0, 1000, 0, False
    End If
End Sub