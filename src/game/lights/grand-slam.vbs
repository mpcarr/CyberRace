
Sub PlayGrandSlamSeq
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
    lightCtrl.SetVpxSyncLightColor RGB(127,0,127)
End Sub

'****************************
' PS_GrandSlamTT
' Event Listeners:  
RegisterPlayerStateEvent GRANDSLAM_TT, "PS_GrandSlamTT"
'
'*****************************
Sub PS_GrandSlamTT()
    If GetPlayerState(GRANDSLAM_TT) = True Then
        lightCtrl.LightOn l83
    Else
        lightCtrl.LightOff l83
    End If
End Sub

'****************************
' PS_GrandSlamRaces
' Event Listeners:  
RegisterPlayerStateEvent GRANDSLAM_RACES, "PS_GrandSlamRaces"
'
'*****************************
Sub PS_GrandSlamRaces()
    If GetPlayerState(GRANDSLAM_RACES) = True Then
        lightCtrl.LightOn l80
    Else
        lightCtrl.LightOff l80
    End If
End Sub

'****************************
' PS_GrandSlamSkills
' Event Listeners:  
RegisterPlayerStateEvent GRANDSLAM_SKILLS, "PS_GrandSlamSkills"
'
'*****************************
Sub PS_GrandSlamSkills()
    If GetPlayerState(GRANDSLAM_SKILLS) = True Then
        lightCtrl.LightOn l81
    Else
        lightCtrl.LightOff l81
    End If
End Sub

'****************************
' PS_GrandSlamNodes
' Event Listeners:  
RegisterPlayerStateEvent GRANDSLAM_NODES, "PS_GrandSlamNodes"
'
'*****************************
Sub PS_GrandSlamNodes()
    If GetPlayerState(GRANDSLAM_NODES) = True Then
        lightCtrl.LightOn l82
    Else
        lightCtrl.LightOff l82
    End If
End Sub

'****************************
' PS_GrandSlamCombo
' Event Listeners:  
RegisterPlayerStateEvent GRANDSLAM_COMBO, "PS_GrandSlamCombo"
'
'*****************************
Sub PS_GrandSlamCombo()
    If GetPlayerState(GRANDSLAM_COMBO) = True Then
        lightCtrl.LightOn l84
    Else
        lightCtrl.LightOff l84
    End If
End Sub