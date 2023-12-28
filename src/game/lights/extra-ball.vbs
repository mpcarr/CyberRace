
'****************************
' Extra Balls
' Event Listeners:          
    RegisterPlayerStateEvent EXTRA_BALLS, "PS_ExtraBalls"
'
'*****************************
Sub PS_ExtraBalls()
    If GetPlayerState(EXTRA_BALLS) > 0 Then
        lightCtrl.LightOn l16
    ElseIf ballSaver = false Then
        lightCtrl.LightOff l16
    End If
End Sub


'****************************
' PS_ClaimExtraBalls
' Event Listeners:          
RegisterPlayerStateEvent RACE_EXTRABALL, "PS_ClaimExtraBalls"
'
'*****************************
Sub PS_ClaimExtraBalls()
    If GetPlayerState(RACE_EXTRABALL) = 1 Then
        lightCtrl.LightOn l34
    Else
        lightCtrl.LightOff l34
    End If
End Sub

Sub PlayExtraBallSeq
    LightSeqRGB.UpdateInterval = 5
    LightSeqRGB.Play SeqUpOn,25,1
    LightSeqRGB.UpdateInterval = 5
    LightSeqRGB.Play SeqDownOn,25,1
    LightSeqRGB.UpdateInterval = 5
    LightSeqRGB.Play SeqRightOn,25,1
    LightSeqRGB.UpdateInterval = 5
    LightSeqRGB.Play SeqLeftOn,25,1
    LightSeqRGB.Play SeqRandom,40,,500

    lightCtrl.SyncWithVpxLights lightSeqRGB
    lightCtrl.SetVpxSyncLightColor RGB(100,5,17)
End Sub