
'****************************
' GrandSlamRacesCheck
' Event Listeners:          
    AddPlayerStateEventListener RACE_1, RACE_1 &   "GrandSlamRacesCheck",   "GrandSlamRacesCheck",  1000, Null
    AddPlayerStateEventListener RACE_2, RACE_2 &   "GrandSlamRacesCheck",   "GrandSlamRacesCheck",  1000, Null
    AddPlayerStateEventListener RACE_3, RACE_3 &   "GrandSlamRacesCheck",   "GrandSlamRacesCheck",  1000, Null
    AddPlayerStateEventListener RACE_4, RACE_4 &   "GrandSlamRacesCheck",   "GrandSlamRacesCheck",  1000, Null
    AddPlayerStateEventListener RACE_5, RACE_5 &   "GrandSlamRacesCheck",   "GrandSlamRacesCheck",  1000, Null
    AddPlayerStateEventListener RACE_6, RACE_6 &   "GrandSlamRacesCheck",   "GrandSlamRacesCheck",  1000, Null
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
            calloutsQ.Add "racesGS", "PlayCallout(""races-grandslam"")", 1, 0, 0, 5500, 0, False
            PlayGrandSlamSeq()
        End If
    End If
End Sub


'****************************
' GrandSlamWizardCheck
' Event Listeners:          
    AddPlayerStateEventListener GRANDSLAM_TT, GRANDSLAM_TT &   "GrandSlamWizardCheck",   "GrandSlamWizardCheck",  1000, Null
    AddPlayerStateEventListener GRANDSLAM_RACES, GRANDSLAM_RACES &   "GrandSlamWizardCheck",   "GrandSlamWizardCheck",  1000, Null
    AddPlayerStateEventListener GRANDSLAM_COMBO, GRANDSLAM_COMBO &   "GrandSlamWizardCheck",   "GrandSlamWizardCheck",  1000, Null
    AddPlayerStateEventListener GRANDSLAM_NODES, GRANDSLAM_NODES &   "GrandSlamWizardCheck",   "GrandSlamWizardCheck",  1000, Null
    AddPlayerStateEventListener GRANDSLAM_SKILLS, GRANDSLAM_SKILLS &   "GrandSlamWizardCheck",   "GrandSlamWizardCheck",  1000, Null
'*****************************
Sub GrandSlamWizardCheck()
    
        If GetPlayerState(GRANDSLAM_TT) = True And _
            GetPlayerState(GRANDSLAM_RACES) = True And _ 
            GetPlayerState(GRANDSLAM_COMBO) = True And _
            GetPlayerState(GRANDSLAM_NODES) = True And _
            GetPlayerState(GRANDSLAM_SKILLS) = True Then
            'Play Callout
            'DMD Animation
            calloutsQ.Add "wizardready", "PlayCallout(""wizard-ready"")", 1, 0, 0, 3000, 0, False
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
AddPinEventListener SWITCH_HIT_RACE_KICKER, SWITCH_HIT_RACE_KICKER &   "CheckWizardReady",   "CheckWizardReady",  1000, Null
'
'*****************************
Dim wizardPointsAddOn
Sub CheckWizardReady()
    If GetPlayerState(GRANDSLAM_WIZARD_READY) = True And RealBallsInPlay = 1 Then
        SetPlayerState MODE_WIZARD, True
        DmdQ.RemoveAll()
        SetPlayerState MODE_WIZARD_STAGE, 1
        wizardPointsAddOn = Round(GetPlayerState(SCORE)*0.05)
        BoostTimer.Enabled = False
        SetPlayerState BOOST_1, 1
        SetPlayerState BOOST_2, 1
        SetPlayerState BOOST_3, 1
        SetPlayerState BOOST_MODE, False
        SetPlayerState BOOST_SHOT, 0  
        SetPlayerState BET_1, 1
        SetPlayerState BET_2, 1
        SetPlayerState BET_3, 1
        SetPlayerState RACE_EXTRABALL, 2
        SetPlayerState CYBER_C, 1
        SetPlayerState CYBER_Y, 1
        SetPlayerState CYBER_B, 1
        SetPlayerState CYBER_E, 1
        SetPlayerState CYBER_R, 1
        SetPlayerState LOCK_HITS, 0
        SetPlayerState LOCK_LIT, False
        SetPlayerState BALLS_LOCKED, 0
        lightCtrl.RemoveShot "WizardMode1", l63
        lightCtrl.RemoveShot "WizardMode2", l63
        lightCtrl.RemoveShot "WizardMode3", l63
        lightCtrl.RemoveShot "WizardMode4", l63
        MusicOff
        calloutsQ.Add "wizard", "PlayCallout(""wizard"")", 1, 0, 0, 4800, 0, False
        calloutsQ.Add "wizards1", "PlayCallout(""wizard-stage1"")", 1, 0, 0, 5000, 0, False
        lightCtrl.AddLightSeq "WIZARDL48", wizardFadeL48Seq
        lightCtrl.AddLightSeq "WIZARDL46", wizardFadeL46Seq
        lightCtrl.AddLightSeq "WIZARDL47", wizardFadeL47Seq
        lightCtrl.AddLightSeq "WIZARDL23", wizardFadeL23Seq
        lightCtrl.AddLightSeq "WIZARDL64", wizardFadeL64Seq
        lightCtrl.AddLightSeq "WIZARDL63", wizardFadeL63Seq
        lightCtrl.AddTableLightSeq "WIZARDGI", lSeqGIWiz
        Debounce "SetWizFalse", "SetWizFalse", 500
        SetTimer "WizKickOut", "TimerWizKickOut", 10000 
        SetTimer "WizAddBall1", "TimerAddaBall", 10000
        SetTimer "WizAddBall2", "TimerAddaBall", 11000
        SetTimer "WizAddBall3", "TimerAddaBall", 12000
        SetTimer "WizAddBall4", "TimerAddaBall", 13000
        SetTimer "releaseLockedBall1", "TimerDropLockpin1", 11000
        SetTimer "releaseLockedBall2", "TimerDropLockpin2", 12000
        SetTimer "releaseLockedBall3", "TimerDropLockpin3", 13000
        GameTimers(GAME_RACE_TIMER_IDX) = 60
        Dim qItem : Set qItem = New QueueItem
        With qItem
            .Name = "wizardmode"
            .Duration = 15
            .BGImage = "noimage"
            .BGVideo = "BGWizardMode"
            .Action = "slideup"
        End With
        DmdQ.Enqueue qItem
        EnableBallSaver 40
    End If
End Sub

Sub TimersetWizFalse
    SetPlayerState GRANDSLAM_WIZARD_READY, False
End Sub

Sub TimerWizKickOut
    lightCtrl.RemoveTableLightSeq "WIZARDGI", lSeqGIWiz
    raceVuk.TimerEnabled = True
    PlayMusic "cyberrace" & MUSIC_RACE & ".mp3", MusicVol
End Sub

Sub TimerAddaBall()
    DispatchPinEvent ADD_BALL
End Sub

Sub TimerDropLockpin1()
    LockPin1.isDropped = 1
End Sub

Sub TimerDropLockpin2()
    LockPin2.isDropped = 1
End Sub

Sub TimerDropLockpin3()
    LockPin3.isDropped = 1
End Sub

'****************************
' WizStage1TimerEnded
' Event Listeners:          
AddPinEventListener GAME_RACE_TIMER_ENDED, GAME_RACE_TIMER_ENDED &   "WizStage1TimerEnded",   "WizStage1TimerEnded",  1000, Null
'
'*****************************
Sub WizStage1TimerEnded()
    If GetPlayerState(MODE_WIZARD) = True And GetPlayerState(MODE_WIZARD_STAGE) = 1 Then
        GAME_DRAIN_BALLS_AND_RESET = True
        lightCtrl.PauseMainLights()
    End If
End Sub

'****************************
' Wiz1 Shot
' Event Listeners:      
AddPinEventListener SWITCH_HIT_SPINNER1, SWITCH_HIT_SPINNER1 &   "Wiz1Shot",   "Wiz1Shot",  1000, Null
AddPinEventListener SWITCH_HIT_SPINNER2, SWITCH_HIT_SPINNER2 &   "Wiz1Shot",   "Wiz1Shot",  1000, Null
AddPinEventListener SWITCH_HIT_LEFT_ORBIT, SWITCH_HIT_LEFT_ORBIT &   "Wiz1Shot",   "Wiz1Shot",  1000, Null
AddPinEventListener SWITCH_HIT_LEFT_RAMP, SWITCH_HIT_LEFT_RAMP &   "Wiz1Shot",   "Wiz1Shot",  1000, Null
AddPinEventListener SWITCH_HIT_RIGHT_RAMP, SWITCH_HIT_RIGHT_RAMP &   "Wiz1Shot",   "Wiz1Shot",  1000, Null
AddPinEventListener SWITCH_HIT_RIGHT_ORBIT, SWITCH_HIT_RIGHT_ORBIT &   "Wiz1Shot",   "Wiz1Shot",  1000, Null
'
'*****************************
Sub Wiz1Shot
    If GetPlayerState(MODE_WIZARD_STAGE) = 1 Then
        AwardWizardJackpot true
    End If
End Sub

'****************************
' Wiz2 Left Ramp Shot
' Event Listeners:      
AddPinEventListener SWITCH_HIT_LEFT_RAMP, SWITCH_HIT_LEFT_RAMP &   "Wiz2LeftRampShot",   "Wiz2LeftRampShot",  1000, Null
'
'*****************************
Sub Wiz2LeftRampShot
    If GetPlayerState(MODE_WIZARD_STAGE) = 2 Then
        SetPlayerState LOCK_LIT, True
        lightCtrl.AddTableLightSeq "WIZARDL64", wizardFadeL64Seq
        lightCtrl.RemoveTableLightSeq "WIZARDL47", wizardFadeL47Seq
        SetTimer "closeWizLock", "TimerCloseWizLock", 3000
    End If
End Sub

Sub TimerCloseWizLock
    SetPlayerState LOCK_LIT, False
    lightCtrl.AddTableLightSeq "WIZARDL47", wizardFadeL47Seq
    lightCtrl.RemoveTableLightSeq "WIZARDL64", wizardFadeL64Seq
End Sub


'****************************
' Wiz3 Shot1
' Event Listeners:      
AddPinEventListener SWITCH_HIT_SPINNER1, SWITCH_HIT_SPINNER1 &   "Wiz3Shot1",   "Wiz3Shot1",  1000, Null
'
'*****************************
Dim wiz3Spinner1Hit : wiz3Spinner1Hit = False
Sub Wiz3Shot1
    If GetPlayerState(MODE_WIZARD_STAGE) = 3 And wiz3Spinner1Hit = False Then
        AwardWizardJackpot true
        wiz3Spinner1Hit = True
        lightCtrl.RemoveTableLightSeq "WIZARDL48", wizardFadeL48Seq
        SetPlayerState MODE_WIZARD_HITS, GetPlayerState(MODE_WIZARD_HITS) + 1
    End If
End Sub


'****************************
' Wiz3 Shot2
' Event Listeners:      
AddPinEventListener SWITCH_HIT_SPINNER2, SWITCH_HIT_SPINNER2 &   "Wiz3Shot2",   "Wiz3Shot2",  1000, Null
'
'*****************************
Dim wiz3Spinner2Hit : wiz3Spinner2Hit = False
Sub Wiz3Shot2
    If GetPlayerState(MODE_WIZARD_STAGE) = 3 And wiz3Spinner2Hit = False Then
        AwardWizardJackpot true
        wiz3Spinner2Hit = True
        lightCtrl.RemoveTableLightSeq "WIZARDL23", wizardFadeL23Seq
        SetPlayerState MODE_WIZARD_HITS, GetPlayerState(MODE_WIZARD_HITS) + 1
    End If
End Sub

'****************************
' Wiz3 Shot3
' Event Listeners:      
AddPinEventListener SWITCH_HIT_LEFT_ORBIT, SWITCH_HIT_LEFT_ORBIT &   "Wiz3Shot3" ,   "Wiz3Shot3" ,  1000, Null
'
'*****************************
Dim wiz3LeftOrbitHit : wiz3LeftOrbitHit = False
Sub Wiz3Shot3
    If GetPlayerState(MODE_WIZARD_STAGE) = 3 And wiz3LeftOrbitHit = False Then
        AwardWizardJackpot true
        wiz3LeftOrbitHit = True
        lightCtrl.RemoveTableLightSeq "WIZARDL46", wizardFadeL46Seq
        SetPlayerState MODE_WIZARD_HITS, GetPlayerState(MODE_WIZARD_HITS) + 1
    End If
End Sub

'****************************
' Wiz3 Shot4
' Event Listeners:      
AddPinEventListener SWITCH_HIT_LEFT_RAMP, SWITCH_HIT_LEFT_RAMP &   "Wiz3Shot4",   "Wiz3Shot4",  1000, Null
'
'*****************************
Dim wiz3LeftRampHit : wiz3LeftRampHit = False
Sub Wiz3Shot4
    If GetPlayerState(MODE_WIZARD_STAGE) = 3 And wiz3LeftRampHit = False Then
        AwardWizardJackpot true
        wiz3LeftRampHit = True
        lightCtrl.RemoveTableLightSeq "WIZARDL47", wizardFadeL47Seq
        SetPlayerState MODE_WIZARD_HITS, GetPlayerState(MODE_WIZARD_HITS) + 1
    End If
End Sub

'****************************
' Wiz3 Shot5
' Event Listeners:      
AddPinEventListener SWITCH_HIT_RIGHT_RAMP, SWITCH_HIT_RIGHT_RAMP &   "Wiz3Shot5",   "Wiz3Shot5",  1000, Null
'
'*****************************
Dim wiz3RightRampHit : wiz3RightRampHit = False
Sub Wiz3Shot5
    If GetPlayerState(MODE_WIZARD_STAGE) = 3 And wiz3RightRampHit = False Then
        AwardWizardJackpot true
        wiz3RightRampHit = True
        lightCtrl.RemoveTableLightSeq "WIZARDL64", wizardFadeL64Seq
        SetPlayerState MODE_WIZARD_HITS, GetPlayerState(MODE_WIZARD_HITS) + 1
    End If
End Sub

'****************************
' Wiz3 Shot6
' Event Listeners:      
AddPinEventListener SWITCH_HIT_RIGHT_ORBIT, SWITCH_HIT_RIGHT_ORBIT &   "Wiz3Shot6",   "Wiz3Shot6",  1000, Null
'
'*****************************
Dim wiz3RightOrbitHit : wiz3RightOrbitHit = False
Sub Wiz3Shot6
    If GetPlayerState(MODE_WIZARD_STAGE) = 3 And wiz3RightOrbitHit = False Then
        AwardWizardJackpot true
        wiz3RightOrbitHit = True
        lightCtrl.RemoveTableLightSeq "WIZARDL63", wizardFadeL63Seq
        SetPlayerState MODE_WIZARD_HITS, GetPlayerState(MODE_WIZARD_HITS) + 1
    End If
End Sub

'****************************
' Check Wiz 3 Hits
' Event Listeners:          
    AddPlayerStateEventListener MODE_WIZARD_HITS, MODE_WIZARD_HITS &   "CheckWiz3Hits",   "CheckWiz3Hits",  1000, Null
'*****************************

Sub CheckWiz3Hits()
    If GetPlayerState(MODE_WIZARD_STAGE) = 3 And GetPlayerState(MODE_WIZARD_HITS) >=6 Then
        GAME_DRAIN_BALLS_AND_RESET = True
        lightCtrl.RemoveAllTableLightSeqs()
        DmdQ.RemoveAll()
        lightCtrl.ResumeMainLights()
        calloutsQ.Add "wizardscomplete", "PlayCallout(""wizard-complete"")", 1, 0, 0, 5500, 0, False
        lSeqJackpotRGB.Repeat = True
        lSeqJackpotNonRGB.Repeat = True
        lightCtrl.AddTableLightSeq "RGB", lSeqJackpotRGB
        lightCtrl.AddTableLightSeq "NonRGB", lSeqJackpotNonRGB
        lSeqJackpotRGB.Repeat = True
        PlayShootAgainSeq
        GAME_DRAIN_BALLS_AND_RESET = True
        Set qItem = New QueueItem
        With qItem
            .Name = "wizend"
            .Duration = 5
            .BGImage = "noimage"
            .BGVideo = "BGWizEnd"
            .Action = "slidedown"
        End With
        DmdQ.Enqueue qItem
        Set qItem = New QueueItem
        With qItem
            .Name = "wizend1"
            .Duration = 5
            .BGImage = "noimage"
            .BGVideo = "BGWizEnd"
            .Action = "slidedown"
        End With
        DmdQ.Enqueue qItem
        Set qItem = New QueueItem
        With qItem
            .Name = "wizend2"
            .Duration = 5
            .BGImage = "noimage"
            .BGVideo = "BGWizEnd"
            .Action = "slidedown"
        End With
        DmdQ.Enqueue qItem
        Set qItem = New QueueItem
        With qItem
            .Name = "wizend3"
            .Duration = 5
            .BGImage = "noimage"
            .BGVideo = "BGWizEnd"
            .Action = "slidedown"
        End With
        DmdQ.Enqueue qItem
        timerQueue.RemoveAll()
    End If
End Sub