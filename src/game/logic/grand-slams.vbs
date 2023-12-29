
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
        ' Adding the wizard light sequences to the lightCtrl object
        SetPlayerState MODE_WIZARD, True
        SetPlayerState GRANDSLAM_WIZARD_READY, False
        lightCtrl.AddTableLightSeq "WIZARDL48", wizardFadeL48Seq
        lightCtrl.AddTableLightSeq "WIZARDL46", wizardFadeL46Seq
        lightCtrl.AddTableLightSeq "WIZARDL47", wizardFadeL47Seq
        lightCtrl.AddTableLightSeq "WIZARDL23", wizardFadeL23Seq
        lightCtrl.AddTableLightSeq "WIZARDL64", wizardFadeL64Seq
        lightCtrl.AddTableLightSeq "WIZARDL63", wizardFadeL63Seq
        lightCtrl.AddTableLightSeq "WIZARDL65", wizardFadeL65Seq
        lightCtrl.AddTableLightSeq "WIZARD1", lSeqWizCorners
        lightCtrl.AddTableLightSeq "WIZARDGI", lSeqGIWiz
        SetTimer "WizKickOut", "raceVuk.TimerEnabled = True", 8000
        SetTimer "WizAddBall1", "DispatchPinEvent ADD_BALL", 9000
        SetTimer "WizAddBall2", "DispatchPinEvent ADD_BALL", 10000
        SetTimer "WizAddBall3", "DispatchPinEvent ADD_BALL", 11000
        SetTimer "WizAddBall4", "DispatchPinEvent ADD_BALL", 12000
        BlockAllPinEvents = True
        AllowPinEventsList.RemoveAll
        AllowPinEventsList.Add SWITCH_HIT_SHORTCUT_WIZARD, True
        AllowPinEventsList.Add SWITCH_HIT_RIGHT_RAMP_WIZARD, True
        AllowPinEventsList.Add SWITCH_HIT_LEFT_RAMP_WIZARD, True
        AllowPinEventsList.Add SWITCH_HIT_LEFT_ORBIT_WIZARD, True
        AllowPinEventsList.Add SWITCH_HIT_RIGHT_ORBIT_WIZARD, True
        AllowPinEventsList.Add SWITCH_HIT_SPINNER1_WIZARD, True
        AllowPinEventsList.Add SWITCH_HIT_SPINNER2_WIZARD, True
        AllowPinEventsList.Add SWITCH_HIT_HYPER, True
        AllowPinEventsList.Add BALL_DRAIN, True
        AllowPinEventsList.Add ADD_BALL, True
        AllowPinEventsList.Add BALL_SAVE, True
        AllowPinEventsList.Add SWITCH_HIT_RACE_KICKER, True
        AllowPinEventsList.Add GAME_BONUS_TIMER_ENDED, True
        garageKicker.enabled=False
        EnableBallSaver 30
    End If
End Sub
