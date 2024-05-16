
'****************************
' Cyber C 
' Event Listeners:          
AddPinEventListener SWITCH_HIT_SPINNER1, SWITCH_HIT_SPINNER1 &   "SwitchCyberCHit",   "SwitchCyberCHit",  1000, Null
'
'*****************************
Sub SwitchCyberCHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_C) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_C, 1
            FlexDMDCyberScene "blink", "", "", "", ""
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_C) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_SPINNER1_MULTIPLIER, GetPlayerState(SHOT_SPINNER1_MULTIPLIER) + 1
            Set qItem = New QueueItem
            With qItem
                .Name = "cybermode"
                .Duration = 2
                .BGImage = "BGBlack"
                .BGVideo = "novideo"
                .Replacements = Array("GetDMDLabelCyberSpinnerShot")
            End With
            qItem.AddLabel "SPINNER SHOT", 		font12, DMDWidth/2, DMDHeight*.2, DMDWidth/2, DMDHeight*.2, "blink"
            qItem.AddLabel "$1", font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub

Function GetDMDLabelCyberSpinnerShot()
    GetDMDLabelCyberSpinnerShot = FormatScore(GetPlayerState(SHOT_SPINNER1_MULTIPLIER)*POINTS_SPINNER)
End Function

'****************************
' Cyber Y 
' Event Listeners:          
AddPinEventListener SWITCH_HIT_LEFT_ORBIT, SWITCH_HIT_LEFT_ORBIT &   "SwitchCyberYHit",   "SwitchCyberYHit",  1000, Null
'
'*****************************
Sub SwitchCyberYHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_Y) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_Y, 1
            FlexDMDCyberScene "", "blink", "", "", ""
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_Y) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_LEFT_ORBIT_MULTIPLIER, GetPlayerState(SHOT_LEFT_ORBIT_MULTIPLIER) + 1
            Set qItem = New QueueItem
            With qItem
                .Name = "cybermode"
                .Duration = 2
                .BGImage = "BGBlack"
                .BGVideo = "novideo"
                .Replacements = Array("GetDMDLabelCyberLeftOrbit")
            End With
            qItem.AddLabel "LEFT ORBIT", 		font12, DMDWidth/2, DMDHeight*.2, DMDWidth/2, DMDHeight*.2, "blink"
            qItem.AddLabel "$1", font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub

Function GetDMDLabelCyberLeftOrbit()
    GetDMDLabelCyberLeftOrbit = FormatScore(GetPlayerState(SHOT_LEFT_ORBIT_MULTIPLIER)*POINTS_BASE)
End Function


'****************************
' Cyber B
' Event Listeners:          
AddPinEventListener SWITCH_HIT_LEFT_RAMP, SWITCH_HIT_LEFT_RAMP &   "SwitchCyberBHit",   "SwitchCyberBHit",  1000, Null
'
'*****************************
Sub SwitchCyberBHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_B) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_B, 1
            FlexDMDCyberScene "", "", "blink", "", ""
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_B) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_LEFT_RAMP_MULTIPLIER, GetPlayerState(SHOT_LEFT_RAMP_MULTIPLIER) + 1
            Set qItem = New QueueItem
            With qItem
                .Name = "cybermode"
                .Duration = 2
                .BGImage = "BGBlack"
                .BGVideo = "novideo"
                .Replacements = Array("GetDMDLabelCyberLeftRamp")
            End With
            qItem.AddLabel "LEFT RAMP", 		font12, DMDWidth/2, DMDHeight*.2, DMDWidth/2, DMDHeight*.2, "blink"
            qItem.AddLabel "$1", font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub

Function GetDMDLabelCyberLeftRamp()
    GetDMDLabelCyberLeftRamp = FormatScore(GetPlayerState(SHOT_LEFT_RAMP_MULTIPLIER)*POINTS_BASE)
End Function

'****************************
' Cyber E
' Event Listeners:          
AddPinEventListener SWITCH_HIT_RIGHT_RAMP, SWITCH_HIT_RIGHT_RAMP &   "SwitchCyberEHit",   "SwitchCyberEHit",  1000, Null
'
'*****************************
Sub SwitchCyberEHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_E) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_E, 1
            FlexDMDCyberScene "", "", "", "blink", ""
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_E) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_RIGHT_RAMP_MULTIPLIER, GetPlayerState(SHOT_RIGHT_RAMP_MULTIPLIER) + 1
            Set qItem = New QueueItem
            With qItem
                .Name = "cybermode"
                .Duration = 2
                .BGImage = "BGBlack"
                .BGVideo = "novideo"
                .Replacements = Array("GetDMDLabelCyberRightRamp")
            End With
            qItem.AddLabel "RIGHT RAMP", 		font12, DMDWidth/2, DMDHeight*.2, DMDWidth/2, DMDHeight*.2, "blink"
            qItem.AddLabel "$1", font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub

Function GetDMDLabelCyberRightRamp()
    GetDMDLabelCyberRightRamp = FormatScore(GetPlayerState(SHOT_RIGHT_RAMP_MULTIPLIER)*POINTS_BASE)
End Function

'****************************
' Cyber E
' Event Listeners:          
AddPinEventListener SWITCH_HIT_RIGHT_ORBIT, SWITCH_HIT_RIGHT_ORBIT &   "SwitchCyberRHit",   "SwitchCyberRHit",  1000, Null
'
'*****************************
Sub SwitchCyberRHit()
    If GetPlayerState(MODE_CYBER) = False Then
        If GetPlayerState(CYBER_R) = 0 Then
            AddScore POINTS_BASE
            SetPlayerState CYBER_R, 1
            FlexDMDCyberScene "", "", "", "", "blink"
            CheckCyberModeActive()
        End If
    Else
        If GetPlayerState(CYBER_R) = 2 Then
            AddScore POINTS_MODE_SHOT
            SetPlayerState MODE_CYBER, False
            SetPlayerState SHOT_RIGHT_ORBIT_MULTIPLIER, GetPlayerState(SHOT_RIGHT_ORBIT_MULTIPLIER) + 1
            Set qItem = New QueueItem
            With qItem
                .Name = "cybermode"
                .Duration = 2
                .BGImage = "BGBlack"
                .BGVideo = "novideo"
                .Replacements = Array("GetDMDLabelCyberRightOrbit")
            End With
            qItem.AddLabel "RIGHT ORBIT", 		font12, DMDWidth/2, DMDHeight*.2, DMDWidth/2, DMDHeight*.2, "blink"
            qItem.AddLabel "$1", font12, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, "blink"
            DmdQ.Enqueue qItem
        End If
    End If
End Sub

Function GetDMDLabelCyberRightOrbit()
    GetDMDLabelCyberRightOrbit = FormatScore(GetPlayerState(SHOT_RIGHT_ORBIT_MULTIPLIER)*POINTS_BASE)
End Function

Sub CheckCyberModeActive()
    If GetPlayerState(CYBER_C) = 1 AND GetPlayerState(CYBER_Y) = 1 AND GetPlayerState(CYBER_B) = 1 AND GetPlayerState(CYBER_E) = 1 AND GetPlayerState(CYBER_R) = 1 Then
        SetPlayerState MODE_CYBER, True
    End If
End Sub

'****************************
' Cyber Mode Change
' Event Listeners:              
    AddPlayerStateEventListener MODE_CYBER, MODE_CYBER &   "CyberModeChange",   "CyberModeChange",  1000, Null
'*****************************
Sub CyberModeChange()
    If GetPlayerState(MODE_CYBER) = True Then
        SetPlayerState CYBER_C, 2
        SetPlayerState CYBER_Y, 2
        SetPlayerState CYBER_B, 2
        SetPlayerState CYBER_E, 2
        SetPlayerState CYBER_R, 2
    Else
        SetPlayerState CYBER_C, 0
        SetPlayerState CYBER_Y, 0
        SetPlayerState CYBER_B, 0
        SetPlayerState CYBER_E, 0
        SetPlayerState CYBER_R, 0
    End If
End Sub