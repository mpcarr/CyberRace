

'****************************
' TT ORBIT
' Event Listeners:          
AddPinEventListener SWITCH_HIT_LEFT_ORBIT, SWITCH_HIT_LEFT_ORBIT &   "SwitchTTOrbitHit",   "SwitchTTOrbitHit",  1000, Null
'
'*****************************
Sub SwitchTTOrbitHit()
    If GetPlayerState(MODE_TT_MULTIBALL) = False Then
        If GetPlayerState(TT_ORBIT) = 2 Then
            SetPlayerState TT_ORBIT, 0
            AddScore POINTS_MODE_SHOT
            FlexDMDTimeTrialScene
            SetPlayerState TT_COLLECTED, GetPlayerState(TT_COLLECTED)+1
        End If
    End If
End Sub

'****************************
' TT Ramp
' Event Listeners:          
AddPinEventListener SWITCH_HIT_SCOOP, SWITCH_HIT_SCOOP &   "SwitchTTRampHit",   "SwitchTTRampHit",  1000, Null
'
'*****************************
Sub SwitchTTRampHit()
    If GetPlayerState(MODE_TT_MULTIBALL) = False Then
        If GetPlayerState(TT_RAMP) = 2 Then
            SetPlayerState TT_RAMP, 0
            AddScore POINTS_MODE_SHOT
            FlexDMDTimeTrialScene
            SetPlayerState TT_COLLECTED, GetPlayerState(TT_COLLECTED)+1
        End If
    End If
End Sub

'****************************
' TT Target
' Event Listeners:          
AddPinEventListener SWITCH_HIT_BOOST3, SWITCH_HIT_BOOST3 &   "SwitchTTTargetHit",   "SwitchTTTargetHit",  1000, Null
'
'*****************************
Sub SwitchTTTargetHit()
    If GetPlayerState(MODE_TT_MULTIBALL) = False Then
        If GetPlayerState(TT_TARGET) = 2 Then
            SetPlayerState TT_TARGET, 0
            AddScore POINTS_MODE_SHOT
            FlexDMDTimeTrialScene
            SetPlayerState TT_COLLECTED, GetPlayerState(TT_COLLECTED)+1
        End If
    End If
End Sub

'****************************
' TT Captive
' Event Listeners:          
AddPinEventListener SWITCH_HIT_CAPTIVE, SWITCH_HIT_CAPTIVE &   "SwitchTTCaptiveHit",   "SwitchTTCaptiveHit",  1000, Null
'
'*****************************
Sub SwitchTTCaptiveHit()
    If GetPlayerState(MODE_TT_MULTIBALL) = False Then
        If GetPlayerState(TT_CAPTIVE) = 2 Then
            SetPlayerState TT_CAPTIVE, 0
            AddScore POINTS_MODE_SHOT
            FlexDMDTimeTrialScene
            SetPlayerState TT_COLLECTED, GetPlayerState(TT_COLLECTED)+1
        End If
    End If
End Sub

'****************************
' TT Shortcut
' Event Listeners:          
AddPinEventListener SWITCH_HIT_SHORTCUT, SWITCH_HIT_SHORTCUT &   "SwitchTTShortcutHit",   "SwitchTTShortcutHit",  1000, Null
'
'*****************************
Sub SwitchTTShortcutHit()
    If GetPlayerState(MODE_TT_MULTIBALL) = False Then
        If GetPlayerState(TT_SHORTCUT) = 2 Then
            SetPlayerState TT_SHORTCUT, 0
            AddScore POINTS_MODE_SHOT
            FlexDMDTimeTrialScene
            SetPlayerState TT_COLLECTED, GetPlayerState(TT_COLLECTED)+1
        End If
    End If
End Sub

'****************************
' PS_TTCollected
' Event Listeners:          
    AddPlayerStateEventListener TT_COLLECTED, TT_COLLECTED &   "PS_TTCollected",   "PS_TTCollected",  1000, Null
'*****************************
Sub PS_TTCollected()
    If GetPlayerState(TT_COLLECTED) = 10 * GetPlayerState(TT_ACTIVATIONS) Then
        'Start TT_MULTIBALL
        SetPlayerState TT_ACTIVATIONS, GetPlayerState(TT_ACTIVATIONS) + 1
        SetPlayerState BONUS_TT_COMPLETED, GetPlayerState(BONUS_TT_COMPLETED) + 1
        SetPlayerState TT_ORBIT, 0
        SetPlayerState TT_TARGET, 0
        SetPlayerState TT_RAMP, 0
        SetPlayerState TT_CAPTIVE, 0
        SetPlayerState TT_SHORTCUT, 0
        SetPlayerState MODE_TT_MULTIBALL, True
        Debounce "TTAddBall1",  "TimerAddaBall", 100
        Debounce "TTAddBall2",  "TimerAddaBall", 200
        EnableBallSaver 15
        GameTimers(GAME_TT_TIMER_IDX) = 90
        lightCtrl.AddShot "MBTTSpinner", l48, RGB(127,0,127)
        lightCtrl.AddShot "MBTTLeftOrbit", l46, RGB(127,0,127)
        lightCtrl.AddShot "MBTTLeftRamp", l47, RGB(127,0,127)
        lightCtrl.AddShot "MBTTRightRamp", l64, RGB(127,0,127)
        lightCtrl.AddShot "MBTTRightOrbit", l63, RGB(127,0,127)
        LightSeqRGB.UpdateInterval = 5
        LightSeqRGB.Play SeqUpOn,25,2
        LightSeqRGB.UpdateInterval = 5
        LightSeqRGB.Play SeqDownOn,25,2
        calloutsQ.Add "ttMB", "PlayCallout(""tt-multiball"")", 1, 0, 0, 5500, 0, False
        lightCtrl.SyncWithVpxLights lightSeqRGB
        lightCtrl.SetVpxSyncLightColor RGB(127,0,127)
    Else
        If GetPlayerState(MODE_TT_MULTIBALL) = False And GetPlayerState(GRANDSLAM_TT) = False Then
            Dim t1,t2,t3,t4,t5
            SetPlayerState TT_ORBIT, 2
            SetPlayerState TT_TARGET, 2
            SetPlayerState TT_RAMP, 2
            SetPlayerState TT_CAPTIVE, 2
            SetPlayerState TT_SHORTCUT, 2

            Dim i
            for i=0 to 3
                Dim off1 : off1 = Round(RndNum(1,5))
                
                Select Case off1
                    Case 1:
                        SetPlayerState TT_ORBIT, 0
                    Case 2:
                        SetPlayerState TT_TARGET, 0
                    Case 3:
                        SetPlayerState TT_RAMP, 0
                    Case 4:
                        SetPlayerState TT_CAPTIVE, 0
                    Case 5:
                        SetPlayerState TT_SHORTCUT, 0  
                End Select
            Next
        End If
    End If
End Sub

'****************************
' PS_TTJackpots
' Event Listeners:          
    AddPlayerStateEventListener TT_JACKPOTS, TT_JACKPOTS &   "PS_TTJackpots",   "PS_TTJackpots",  1000, Null
'*****************************
Sub PS_TTJackpots()
    If GetPlayerState(MODE_TT_MULTIBALL) = True And GetPlayerState(TT_JACKPOTS) = 5 And GetPlayerState(GRANDSLAM_TT) = False Then
        'Award TT Grand Slam
        calloutsQ.Add "ttMB", "PlayCallout(""tt-grandslam"")", 1, 0, 0, 5500, 0, False
        SetPlayerState GRANDSLAM_TT, True
        SetPlayerState TT_ORBIT, 1
        SetPlayerState TT_TARGET, 1
        SetPlayerState TT_RAMP, 1
        SetPlayerState TT_CAPTIVE, 1
        SetPlayerState TT_SHORTCUT, 1
        SetPlayerState BONUS_TT_COMPLETED, GetPlayerState(BONUS_TT_COMPLETED) + 1
        PlayGrandSlamSeq()
        lightCtrl.AddShot "MBTTSpinner", l48, RGB(127,0,127)
        lightCtrl.AddShot "MBTTLeftOrbit", l46, RGB(127,0,127)
        lightCtrl.AddShot "MBTTLeftRamp", l47, RGB(127,0,127)
        lightCtrl.AddShot "MBTTRightRamp", l64, RGB(127,0,127)
        lightCtrl.AddShot "MBTTRightOrbit", l63, RGB(127,0,127)
    ElseIf GetPlayerState(MODE_TT_MULTIBALL) = True And GetPlayerState(TT_JACKPOTS) MOD 5 = 0 Then
        lightCtrl.AddShot "MBTTSpinner", l48, RGB(127,0,127)
        lightCtrl.AddShot "MBTTLeftOrbit", l46, RGB(127,0,127)
        lightCtrl.AddShot "MBTTLeftRamp", l47, RGB(127,0,127)
        lightCtrl.AddShot "MBTTRightRamp", l64, RGB(127,0,127)
        lightCtrl.AddShot "MBTTRightOrbit", l63, RGB(127,0,127)
    End If
End Sub

'****************************
' MBTT Spinner Shot
' Event Listeners:      
AddPinEventListener SWITCH_HIT_SPINNER1, SWITCH_HIT_SPINNER1 &   "MBTTSpinnerShot",   "MBTTSpinnerShot",  1000, Null
'
'*****************************
Sub MBTTSpinnerShot
    If GetPlayerState(MODE_TT_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBTTSpinner", l48) = True Then
            lightCtrl.RemoveShot "MBTTSpinner", l48
            SetPlayerState BONUS_TT_COMPLETED, GetPlayerState(BONUS_TT_COMPLETED) + 1
            SetPlayerState TT_JACKPOTS, GetPlayerState(TT_JACKPOTS) + 1
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MBTt Left Orbit Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_LEFT_ORBIT, SWITCH_HIT_LEFT_ORBIT &   "MBTTLeftOrbitShot",   "MBTTLeftOrbitShot",  1000, Null
'
'*****************************
Sub MBTTLeftOrbitShot
    If GetPlayerState(MODE_TT_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBTTLeftOrbit", l46) = True Then
            lightCtrl.RemoveShot "MBTTLeftOrbit", l46
            SetPlayerState BONUS_TT_COMPLETED, GetPlayerState(BONUS_TT_COMPLETED) + 1
            SetPlayerState TT_JACKPOTS, GetPlayerState(TT_JACKPOTS) + 1
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MBTT Left Ramp Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_LEFT_RAMP, SWITCH_HIT_LEFT_RAMP &   "MBTTLeftRampShot",   "MBTTLeftRampShot",  1000, Null
'
'*****************************
Sub MBTTLeftRampShot
    If GetPlayerState(MODE_TT_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBTTLeftRamp", l47) = True Then
            lightCtrl.RemoveShot "MBTTLeftRamp", l47
            SetPlayerState BONUS_TT_COMPLETED, GetPlayerState(BONUS_TT_COMPLETED) + 1
            SetPlayerState TT_JACKPOTS, GetPlayerState(TT_JACKPOTS) + 1
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MBTT Right Ramp Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_RIGHT_RAMP, SWITCH_HIT_RIGHT_RAMP &   "MBTTRightRampShot",   "MBTTRightRampShot",  1000, Null
'
'*****************************
Sub MBTTRightRampShot
    If GetPlayerState(MODE_TT_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBTTRightRamp", l64) = True Then
            lightCtrl.RemoveShot "MBTTRightRamp", l64
            SetPlayerState BONUS_TT_COMPLETED, GetPlayerState(BONUS_TT_COMPLETED) + 1
            SetPlayerState TT_JACKPOTS, GetPlayerState(TT_JACKPOTS) + 1
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MBTT Right Orbit Shot
' Event Listeners:      
    AddPinEventListener SWITCH_HIT_RIGHT_ORBIT, SWITCH_HIT_RIGHT_ORBIT &   "MBTTRightOrbitShot",   "MBTTRightOrbitShot",  1000, Null
'
'*****************************
Sub MBTTRightOrbitShot
    If GetPlayerState(MODE_TT_MULTIBALL) = True Then
        If lightCtrl.IsShotLit("MBTTRightOrbit", l63) = True Then
            lightCtrl.RemoveShot "MBTTRightOrbit", l63
            SetPlayerState BONUS_TT_COMPLETED, GetPlayerState(BONUS_TT_COMPLETED) + 1
            SetPlayerState TT_JACKPOTS, GetPlayerState(TT_JACKPOTS) + 1
            AwardJackpot()
        End If
    End If
End Sub

'****************************
' MBTT End
' Event Listeners:      
AddPinEventListener BALL_DRAIN, BALL_DRAIN &   "MBTTEnd",   "MBTTEnd",  1000, Null
'
'*****************************
Sub MBTTEnd
    If GetPlayerState(MODE_TT_MULTIBALL) = True AND RealBallsInPlay = 1 AND ballSaver = False Then
        SetPlayerState MODE_TT_MULTIBALL, False
        GameTimers(GAME_TT_TIMER_IDX) = 0
        SetPlayerState TT_COLLECTED, 0
        lightCtrl.RemoveShot "MBTTSpinner", l48
        lightCtrl.RemoveShot "MBTTLeftOrbit", l46
        lightCtrl.RemoveShot "MBTTLeftRamp", l47
        lightCtrl.RemoveShot "MBTTRightRamp", l64
        lightCtrl.RemoveShot "MBTTRightOrbit", l63
    End If
End Sub

'****************************
' MBTT Timer End
' Event Listeners:      
AddPinEventListener GAME_TT_TIMER_ENDED, GAME_TT_TIMER_ENDED &   "MBTTTimerEnd",   "MBTTTimerEnd",  1000, Null
'
'*****************************
Sub MBTTTimerEnd
    If GetPlayerState(MODE_TT_MULTIBALL) = True Then
        SetPlayerState MODE_TT_MULTIBALL, False
        SetPlayerState TT_COLLECTED, 0
        lightCtrl.RemoveShot "MBTTSpinner", l48
        lightCtrl.RemoveShot "MBTTLeftOrbit", l46
        lightCtrl.RemoveShot "MBTTLeftRamp", l47
        lightCtrl.RemoveShot "MBTTRightRamp", l64
        lightCtrl.RemoveShot "MBTTRightOrbit", l63
        If GetPlayerState(MODE_MULTIBALL) = False Then
            GAME_DRAIN_BALLS_AND_RESET = True
            lightCtrl.PauseMainLights()
        End If
    End If
End Sub
