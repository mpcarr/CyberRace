

Sub FlexDMDTimeTrialScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "timetrial"
        .Duration = 2
        .BGImage = "BGBlack"
        .BGVideo = "novideo"
        .Replacements = Array("GetDMDLabelTTCollected")
    End With
    qItem.AddLabel "TT COLLECTED", 		Font12, DMDWidth/2, DMDHeight*.4, DMDWidth/2, DMDHeight*.4, ""
    qItem.AddLabel "$1 MORE FOR TT MULTIBALL", 		FontWhite3, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
   
    LightSeqRGB.Play SeqStripe2VertOn,5,1
    lightCtrl.SyncWithVpxLights lightSeqRGB
    lightCtrl.SetVpxSyncLightColor RGB(127,0,127)
    lightCtrl.pulse l90, 0
    lightCtrl.pulse l91, 0
    lightCtrl.pulse l92, 0
    lightCtrl.pulse l93, 0
    lightCtrl.pulse l95, 0

End Sub

Function GetDMDLabelTTCollected()
    GetDMDLabelTTCollected = (10 * GetPlayerState(TT_ACTIVATIONS)) - GetPlayerState(TT_COLLECTED)
End Function