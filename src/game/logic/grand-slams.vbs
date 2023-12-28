
'****************************
' GrandSlamRacesCheck
' Event Listeners:          
RegisterPlayerStateEvent RACE_1, "GrandSlamRacesCheck"
RegisterPlayerStateEvent RACE_2, "GrandSlamRacesCheck"
RegisterPlayerStateEvent RACE_3, "GrandSlamRacesCheck"
RegisterPlayerStateEvent RACE_4, "GrandSlamRacesCheck"
RegisterPlayerStateEvent RACE_5, "GrandSlamRacesCheck"
RegisterPlayerStateEvent RACE_6, "GrandSlamRacesCheck"
'
'*****************************
Sub GrandSlamRacesCheck()
    If GetPlayerState(GRANDSLAM_RACES) = False Then
        If GetPlayerState(RACE_1) = 1 And _
            GetPlayerState(RACE_2) = 1 And _ 
            GetPlayerState(RACE_3) = 1 And _
            GetPlayerState(RACE_4) = 1 And _
            GetPlayerState(RACE_5) = 1 And _
            GetPlayerState(RACE_6) = 1 Then
            SetPlayerState LANE_R, 1
            SetPlayerState LANE_A, 1
            SetPlayerState LANE_C, 1
            SetPlayerState LANE_E, 1
            SetPlayerState GRANDSLAM_RACES, True
            PlayGrandSlamSeq()
        End If
    End If
End Sub


'****************************
' GrandSlamWizardCheck
' Event Listeners:          
RegisterPlayerStateEvent GRANDSLAM_TT, "GrandSlamWizardCheck"
RegisterPlayerStateEvent GRANDSLAM_RACES, "GrandSlamWizardCheck"
RegisterPlayerStateEvent GRANDSLAM_COMBO, "GrandSlamWizardCheck"
RegisterPlayerStateEvent GRANDSLAM_NODES, "GrandSlamWizardCheck"
RegisterPlayerStateEvent GRANDSLAM_SKILLS, "GrandSlamWizardCheck"
'
'*****************************
Sub GrandSlamWizardCheck()
    
        If GetPlayerState(GRANDSLAM_TT) = True And _
            GetPlayerState(GRANDSLAM_RACES) = True And _ 
            GetPlayerState(GRANDSLAM_COMBO) = True And _
            GetPlayerState(GRANDSLAM_NODES) = True And _
            GetPlayerState(GRANDSLAM_SKILLS) = True Then
            'Play Callout
            'DMD Animation
            SetPlayerState GRANDSLAM_WIZARD_READY, True
            lightCtrl.AddShot "WizardMode1", l63, RGB(255,0,0)
            lightCtrl.AddShot "WizardMode2", l63, RGB(255,255,0)
            lightCtrl.AddShot "WizardMode3", l63, RGB(255,0,255)
            lightCtrl.AddShot "WizardMode4", l63, RGB(0,255,255)
        End If
End Sub

Dim WizNeonl48
WizNeonl48 = FlattenArrays(Array( _
    lightCtrl.FadeRGB("l48", RGB(255, 20, 147), RGB(30, 144, 255), 10), _
    lightCtrl.FadeRGB("l48", RGB(30, 144, 255), RGB(127, 255, 0), 10), _
    lightCtrl.FadeRGB("l48", RGB(127, 255, 0), RGB(255, 255, 0), 10), _
    lightCtrl.FadeRGB("l48", RGB(255, 255, 0), RGB(255, 165, 0), 10), _
    lightCtrl.FadeRGB("l48", RGB(255, 165, 0), RGB(138, 43, 226), 10), _
    lightCtrl.FadeRGB("l48", RGB(138, 43, 226), RGB(0, 128, 128), 10), _
    lightCtrl.FadeRGB("l48", RGB(0, 128, 128), RGB(255, 20, 147), 10)))

Dim wizardFadeL48Seq : Set wizardFadeL48Seq = new LCSeq
wizardFadeL48Seq.Name = "wizardFadeL48Seq"
wizardFadeL48Seq.Sequence = WizNeonl48
wizardFadeL48Seq.Color = Null
wizardFadeL48Seq.UpdateInterval = 20
wizardFadeL48Seq.Repeat = True



'****************************
' CheckWizardReady
' Event Listeners:  
RegisterPinEvent SWITCH_HIT_RACE_KICKER, "CheckWizardReady"
'
'*****************************
Sub CheckWizardReady()
    If GetPlayerState(GRANDSLAM_WIZARD_READY) = True And RealBallsInPlay = 1 Then
        'LightShow
        'DMD
        'Callout
        lightCtrl.AddTableLightSeq "WIZARD", wizardFadeL48Seq
        lightCtrl.AddTableLightSeq "WIZARD1", lSeqRGBCircle
        
    End If
End Sub
