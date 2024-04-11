

'****************************
' Start Skillshot
' Event Listeners:  
RegisterPinEvent START_GAME,    "StartSkillShot"
RegisterPinEvent NEXT_PLAYER,   "StartSkillShot"
'
'*****************************
Sub StartSkillShot()
    'lightCtrl.AddShot "skillshotLanes", l66, RGB(255,255,0)
    SetPlayerState MODE_SKILLSHOT_ACTIVE, True
    SetPlayerState LANE_BO, 1
    lightCtrl.AddShot "skillshotramp", l47, RGB(255,255,0)
End Sub

Sub CancelSkillshot
    lightCtrl.RemoveShot "skillshotramp", l47
    SetPlayerState MODE_SKILLSHOT_ACTIVE, False
    'lightCtrl.RemoveShot "skillshotLanes", l66
End Sub
'****************************
' SkillshotLeftRamp
' Event Listeners:          
RegisterPinEvent SWITCH_HIT_LEFT_RAMP, "SkillshotLeftRamp"
'
'*****************************
Sub SkillshotLeftRamp()
    If lightCtrl.IsShotLit("skillshotramp", l47) Then
      AwardSkillshot()
    End If
End Sub

Sub AwardSkillshot()
    AddScore POINTS_MODE_SHOT
    CancelSkillshot()
    SetPlayerState LANE_R, 1
    SetPlayerState LANE_A, 1
    SetPlayerState LANE_C, 1
    SetPlayerState LANE_E, 1
    DOF 251, DOFPulse
    Debounce "dofSkillshot", "TimerDOFSkillshot", 1000
    LightSeqRGB.Play SeqUpOn,50,2
    lightCtrl.SyncWithVpxLights lightSeqRGB
    lightCtrl.SetVpxSyncLightColor RGB(255,255,0)
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "skillshot"
        .Duration = 2
        .BGImage = "BGBlack"
        .BGVideo = "novideo"
        .Action = "slideup"
    End With
    qItem.AddLabel "SKILLSHOT", 	Font12, DMDWidth/2, DMDHeight/2, DMDWidth/2, DMDHeight/2, "blink"
    DmdQ.Enqueue qItem
End Sub

Sub TimerDOFSkillshot
    DOF 252, DOFPulse
End Sub