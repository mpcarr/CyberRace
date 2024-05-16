
Dim totalMbScore : totalMbScore = 0

'****************************
' Captive Ball Hit
' Event Listeners:          
    AddPinEventListener SWITCH_HIT_CAPTIVE, SWITCH_HIT_CAPTIVE &   "SwitchHitCaptive",   "SwitchHitCaptive",  1000, Null
'
'*****************************
Sub SwitchHitCaptive()
    If GetPlayerState(LOCK_LIT) = False AND GetPlayerState(MODE_MULTIBALL) = False And GetPlayerState(MODE_WIZARD) = False Then
        SetPlayerState LOCK_HITS, GetPlayerState(LOCK_HITS) + 1
        AddScore POINTS_BASE
        If GetPlayerState(LOCK_HITS) = 4 Then
            calloutsQ.Add "lock-lit", "PlayCallout(""locks-lit"")", 1, 0, 0, 1300, 0, False         
        End If
    End If
End Sub

Sub MBIdleTimer
    If GetPlayerState(MODE_MULTIBALL) = True Then
        SetTimer "MBIdleTimer1", "MBEnd", 6000
        SetTimer "MBIdleTimer2", "MBIdleTimer", 6000
    End If
End Sub
'****************************
' Ramp Lock Gate Hit
' Event Listeners:          
AddPinEventListener SWITCH_HIT_RAMP_LOCK, SWITCH_HIT_RAMP_LOCK &   "SwitchHitRampLockGate",   "SwitchHitRampLockGate",  1000, Null
'
'*****************************
Sub SwitchHitRampLockGate()
    Dim bStartMB : bStartMB = False
    
    Select Case BallsOnBridge()
        Case 0:
            LockPin1.IsDropped = 0 
        Case 1:
            LockPin2.IsDropped = 0
        Case 2:
            LockPin3.IsDropped = 0 
    End Select
    
    Select Case GetPlayerState(BALLS_LOCKED)
        Case 0:
            SetPlayerState BALLS_LOCKED, 1
            DOF 253, DOFPulse
            calloutsQ.Add "balllocked", "PlayCallout(""ball1locked"")", 1, 0, 0, 3500, 0, False
            If GetPlayerState(MODE_WIZARD) = True And GetPlayerState(MODE_WIZARD_STAGE) = 2 Then
                AwardWizardJackpot true
            End If
        Case 1:
            SetPlayerState BALLS_LOCKED, 2
            DOF 254, DOFPulse
            calloutsQ.Add "balllocked", "PlayCallout(""ball2locked"")", 1, 0, 0, 3500, 0, False
            If GetPlayerState(MODE_WIZARD) = True And GetPlayerState(MODE_WIZARD_STAGE) = 2 Then
                AwardWizardJackpot true
            End If
        Case 2:
            If GetPlayerState(MODE_WIZARD) = True And GetPlayerState(MODE_WIZARD_STAGE) = 2 Then
                DOF 255, DOFPulse
                AwardWizardJackpot true
                If timerQueue.Exists("closeWizLock") Then
                    timerQueue.Remove("closeWizLock")
                End If
                SetPlayerState LOCK_LIT, False
                calloutsQ.Add "balllocked", "PlayCallout(""ball3locked"")", 1, 0, 0, 3500, 0, False
                calloutsQ.Add "wizStage3", "PlayCallout(""wizard-stage3"")", 1, 0, 0, 6000, 0, False
                bStartMB = True
                lightCtrl.RemoveAllTableLightSeqs()
                Debounce "setwizstage2", "TimerSetWizStage2", 9500
                lightCtrl.AddTableLightSeq "WIZARDL48", wizardFadeL48Seq
                lightCtrl.AddTableLightSeq "WIZARDL46", wizardFadeL46Seq
                lightCtrl.AddTableLightSeq "WIZARDL47", wizardFadeL47Seq
                lightCtrl.AddTableLightSeq "WIZARDL23", wizardFadeL23Seq
                lightCtrl.AddTableLightSeq "WIZARDL64", wizardFadeL64Seq
                lightCtrl.AddTableLightSeq "WIZARDL63", wizardFadeL63Seq
                lightCtrl.AddTableLightSeq "WIZARDGI", lSeqGIWiz
                wiz3Spinner1Hit = False
                wiz3Spinner2Hit = False
                wiz3LeftOrbitHit = False
                wiz3LeftRampHit = False
                wiz3RightRampHit = False
                wiz3RightOrbitHit = False
                EnableBallSaver 15
            Else
                DOF 255, DOFPulse
                calloutsQ.Add "balllocked", "PlayCallout(""ball3locked"")", 1, 0, 0, 3500, 0, False
                calloutsQ.Add "prepareformb", "PlayCallout(""prepareformb"")", 1, 0, 0, 3500, 0, False
                SetPlayerState LOCK_LIT, False
                lSeqMBStart.Repeat = True
                lightCtrl.AddTableLightSeq "Multiball", lSeqMBStart
                LockPin1.TimerEnabled = True
                LockPin1.TimerInterval = 5000
                SetTimer "bridgeReleaseCheck", "TimerBridgeReleaseCheck", 8000
                bStartMB = True
            End If
    End Select

    If bStartMB = False Then
        'Decide to Add a ball or release one.
        If GetPlayerState(BALLS_LOCKED) = BallsOnBridge() Then
            DispatchPinEvent ADD_BALL
        Else
            'Release Ball From Bridge.
            LockPin1.IsDropped = 1
            BridgeRelease.Enabled = True
        End If
        EnableBallSaver 15
    End If
            


End Sub

Sub TimerBridgeReleaseCheck
    LockPin1.isDropped = 1
    LockPin2.isDropped = 1
    LockPin3.isDropped = 1
End Sub

Sub BridgeRelease_Timer()
    If LockPin1.IsDropped = True Then
        LockPin1.IsDropped = 0
        LockPin2.IsDropped = 1
    Else
        If LockPin3.IsDropped = 0 And LockPin2.IsDropped = True Then
            LockPin2.IsDropped = 0
            LockPin3.IsDropped = 1
            BridgeRelease.Enabled = False
        End If
    End If
End Sub

Sub LockPin1_Timer()
    LockPin1.IsDropped = 1
    LockPin1.TimerEnabled = False
    LockPin2.TimerEnabled = True
    LockPin2.TimerInterval = 1000
    SetPlayerState MODE_MULTIBALL, True
    totalMbScore = GetPlayerState(SCORE)
    MBIdleTimer()
    lightCtrl.LightState l97, 1
    lightCtrl.RemoveAllTableLightSeqs()
    SetPlayerState BALLS_LOCKED, 0
    lightCtrl.AddShot "MBSpinner", l48, RGB(0,255,0)
    lightCtrl.AddShot "MBLeftOrbit", l46, RGB(0,255,0)
    lightCtrl.AddShot "MBLeftRamp", l47, RGB(0,255,0)
    lightCtrl.AddShot "MBRightRamp", l64, RGB(0,255,0)
    lightCtrl.AddShot "MBRightOrbit", l63, RGB(0,255,0)
    EnableBallSaver 15
End Sub

Sub LockPin2_Timer()
    LockPin2.IsDropped = 1
    LockPin2.TimerEnabled = False
    LockPin3.TimerEnabled = True
    LockPin3.TimerInterval = 1000
End Sub

Sub LockPin3_Timer()
    LockPin3.IsDropped = 1
    LockPin3.TimerEnabled = False
End Sub

'****************************
' Check Lock Hits
' Event Listeners:          
    AddPlayerStateEventListener LOCK_HITS, LOCK_HITS &   "CheckLockHits",   "CheckLockHits",  1000, Null
'*****************************

Sub CheckLockHits()
    If GetPlayerState(MODE_MULTIBALL) = False Then
        If GetPlayerState(LOCK_HITS) = 4 Then
            SetPlayerState LOCK_LIT, True
        End If
    End If
End Sub

'****************************
' Check Lock Lit
' Event Listeners:          
    AddPlayerStateEventListener LOCK_LIT, LOCK_LIT &   "CheckLockLit",   "CheckLockLit",  1000, Null
    AddPlayerStateEventListener MODE_MULTIBALL, MODE_MULTIBALL &   "CheckLockLit",   "CheckLockLit",  1000, Null
'*****************************

Sub CheckLockLit()
    If GetPlayerState(LOCK_LIT) = True And GetPlayerState(MODE_MULTIBALL) = False Then
        DiverterOn.IsDropped = 0
	    DiverterOff.IsDropped = 1
    Else
        DiverterOn.IsDropped = 1
        DiverterOff.IsDropped = 0
    End If
End Sub

'****************************
' LockCheckDiverter
' Event Listeners:      
AddPinEventListener SWITCH_HIT_RIGHT_RAMP_ENTER, SWITCH_HIT_RIGHT_RAMP_ENTER &   "LockCheckDiverter",   "LockCheckDiverter",  1000, Null
'
'*****************************
Sub LockCheckDiverter
    If RealBallsInPlay > 1 Or GetPlayerState(SKILLS_TRIAL_SHOT) = 1 Or GetPlayerState(RACE_MODE_FINISH) = True Then
        DiverterOn.IsDropped = 1
        DiverterOff.IsDropped = 0
        Debounce "checkDiverter", "CheckLockLit", 2000
    End If
End Sub


Sub CheckSuperJackpot()
    If lightCtrl.IsShotLit("MBSuperLeftRamp", l47) = False Then
        If  lightCtrl.IsShotLit("MBSpinner", l48) = False And lightCtrl.IsShotLit("MBLeftOrbit", l46) = False And lightCtrl.IsShotLit("MBLeftRamp", l47) = False And lightCtrl.IsShotLit("MBRightRamp", l64) = False And lightCtrl.IsShotLit("MBRightOrbit", l63) = False Then
            lightCtrl.AddShot "MBSuperLeftRamp", l47, RGB(255,127,0) 'Super Jackpot
        End If
    End If
End Sub


'****************************
' MB Spinner Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_SPINNER1, SWITCH_HIT_SPINNER1 &   "MBSpinnerShot",   "MBSpinnerShot",  1000, Null
'
'*****************************
Sub MBSpinnerShot
    If GetPlayerState(MODE_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBSpinner", l48) = True Then
            lightCtrl.RemoveShot "MBSpinner", l48
            CheckSuperJackpot()
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MB Left Orbit Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_LEFT_ORBIT, SWITCH_HIT_LEFT_ORBIT &   "MBLeftOrbitShot",   "MBLeftOrbitShot",  1000, Null
'
'*****************************
Sub MBLeftOrbitShot
    If GetPlayerState(MODE_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBLeftOrbit", l46) = True Then
            lightCtrl.RemoveShot "MBLeftOrbit", l46
            CheckSuperJackpot()
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MB Left Ramp Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_LEFT_RAMP, SWITCH_HIT_LEFT_RAMP &   "MBLeftRampShot",   "MBLeftRampShot",  1000, Null
'
'*****************************
Sub MBLeftRampShot
    If GetPlayerState(MODE_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBLeftRamp", l47) = True Then
            lightCtrl.RemoveShot "MBLeftRamp", l47
            CheckSuperJackpot()
            AwardJackpot()
        Else
            If lightCtrl.IsShotLit("MBSuperLeftRamp", l47) = True Then
                AwardSuperJackpot()
                lightCtrl.RemoveShot "MBSuperLeftRamp", l47
                lightCtrl.AddShot "MBSpinner", l48, RGB(0,255,0)
                lightCtrl.AddShot "MBLeftOrbit", l46, RGB(0,255,0)
                lightCtrl.AddShot "MBLeftRamp", l47, RGB(0,255,0)
                lightCtrl.AddShot "MBRightRamp", l64, RGB(0,255,0)
                lightCtrl.AddShot "MBRightOrbit", l63, RGB(0,255,0)
            End If
        End If
    End If
End Sub

'****************************
' MB Right Ramp Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_RIGHT_RAMP, SWITCH_HIT_RIGHT_RAMP &   "MBRightRampShot",   "MBRightRampShot",  1000, Null
'
'*****************************
Sub MBRightRampShot
    If GetPlayerState(MODE_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBRightRamp", l64) = True Then
            lightCtrl.RemoveShot "MBRightRamp", l64
            CheckSuperJackpot()
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MB Right Orbit Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_RIGHT_ORBIT, SWITCH_HIT_RIGHT_ORBIT &   "MBRightOrbitShot",   "MBRightOrbitShot",  1000, Null
'
'*****************************
Sub MBRightOrbitShot
    If GetPlayerState(MODE_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBRightOrbit", l63) = True Then
            lightCtrl.RemoveShot "MBRightOrbit", l63
            CheckSuperJackpot()
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MB End
' Event Listeners:      
AddPinEventListener BALL_DRAIN, BALL_DRAIN &   "MBEnd",   "MBEnd",  1000, Null
'
'*****************************
Sub MBEnd
    If GetPlayerState(MODE_MULTIBALL) = True AND RealBallsInPlay = 1 AND ballSaver = False Then
        SetPlayerState MODE_MULTIBALL, False
        Dim qItem : Set qItem = New QueueItem
        With qItem
            .Name = "mbtotal"
            .Duration = 2
            .BGImage = "BG005"
            .BGVideo = "novideo"
            .Action = "slideup"
            .Replacements = Array("GetDMDLabelMultiballTotal")
        End With
        qItem.AddLabel "MB Total: $1", FlexDMD.NewFont(DMDFontSmall, RGB(0,0,0), RGB(0, 0, 0), 0), DMDWidth/2, DMDHeight*.9, DMDWidth/2, DMDHeight*.9, "blink"
        DmdQ.Enqueue qItem
        SetPlayerState LOCK_HITS, 1
        lightCtrl.RemoveShot "MBSpinner", l48
        lightCtrl.RemoveShot "MBLeftOrbit", l46
        lightCtrl.RemoveShot "MBLeftRamp", l47
        lightCtrl.RemoveShot "MBRightRamp", l64
        lightCtrl.RemoveShot "MBRightOrbit", l63
        lightCtrl.RemoveShot "MBSuperLeftRamp", l47
    End If
End Sub

Function GetDMDLabelMultiballTotal()
    GetDMDLabelMultiballTotal = FormatScore(GetPlayerState(SCORE)-totalMbScore)
End Function

