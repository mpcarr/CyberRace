'***********************************************************************************************************************
'*****  GAME DISPATCH                                         	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub Dispatch(action, options)
		
    DebugPost action

    Select Case action

        Case RESET_LANE_LIGHTS:
            ResetLaneLights
        Case ROTATE_LANE_LIGHTS_CLOCKWISE:
            RotateLaneLightsClockwise    
        Case ROTATE_LANE_LIGHTS_ANTI_CLOCKWISE:
            RotateLaneLightsAntiClockwise
        Case LIGHTS_UPDATE:
            LightsUpdate options
        Case LIGHTS_GI_ON:
            LightsGiOn
        Case LIGHTS_GI_OFF:
            LightsGiOff
        Case LIGHTS_GI_NORMAL:
            LightsGiNormal
        Case LIGHTS_GI_AUGMENTATION_RESEARCH:
            LightsGiAugmentationResearch                      
        Case LIGHTS_START_SEQUENCE:
            LightsStartSequence            
        Case LIGHTS_RESEARCH_OFF:
            LightsResearchOff
        Case LIGHTS_RESEARCH_RESET:
            LightsResearchReset
        Case LIGHTS_RESEARCH_READY_OFF:
            LightsResearchReadyOff            
        Case LIGHTS_AUGMENTATIONS_OFF:
            LightsAugmentationsOff
        Case LIGHTS_PAUSE:
            LightsPause
        Case SWITCH_HIT_AUGMENTATION:
            SwitchHitAugmentation
        Case SWITCH_HIT_CAPTIVE:
            SwitchHitCaptive
        Case SWITCH_HIT_RESEARCH_1:
            SwitchHitResearch1
        Case SWITCH_HIT_RESEARCH_2:
            SwitchHitResearch2
        Case SWITCH_HIT_RESEARCH_3:
            SwitchHitResearch3
        Case SWITCH_HIT_PRE_LEFT_ORBIT:
            SwitchHitPreLeftOrbit
        Case SWITCH_HIT_LEFT_ORBIT:
            SwitchHitLeftOrbit
        Case SWITCH_HIT_PRE_RIGHT_ORBIT:
            SwitchHitPreRightOrbit            
        Case SWITCH_HIT_RIGHT_ORBIT:
            SwitchHitRightOrbit            
        Case SWITCH_LEFT_FLIPPER_DOWN:
            SwitchLeftFlipperDown
        Case SWITCH_RIGHT_FLIPPER_DOWN:
            SwitchRightFlipperDown
        Case SWITCH_HIT_CONSOLE:
            SwitchHitConsole
        Case SWITCH_HIT_SPINNER2:
            SwitchHitSpinner2        
        Case SWITCH_HIT_HYPERJUMP:
            SwitchHitHyperJump
        Case SWITCH_HIT_BUMPER:
            SwitchHitBumper          
        Case SWITCH_HIT_LEFT_RAMP:
            SwitchHitLeftRamp
        Case SWITCH_HIT_RIGHT_RAMP:
            SwitchHitRightRamp
        Case SWITCH_HIT_CENTER_RAMP:
            SwitchHitCenterRamp            
        Case SWITCH_HIT_SHORTCUT:
            SwitchHitShortcut     
        Case SWITCH_HIT_RAMP_PIN:
            SwitchHitRampPin
        Case SWITCH_HIT_PLUNGER_LANE:
            SwitchHitPlungerLane    
        Case GAME_START_OF_BALL:
            GameStartOfBall
        Case GAME_END_OF_BALL:
            GameEndOfBall        
        Case GAME_AUGMENTATION_READY:
            GameAugmentationReady
        Case GAME_START_AUGMENTATION_RESEARCH:
            GameStartAugmentationResearch
        Case GAME_LOCK_AUGMENTATIONS:
            GameLockAugmentations
        Case GAME_UNLOCK_AUGMENTATIONS:
            GameUnLockAugmentations            
        Case GAME_SHOW_LABELS:
            GameShowLabels
        Case GAME_HIDE_LABELS:
            GameHideLabels
        Case GAME_MODE_ADVANCE_AUGMENTATION:
            GameModeAdvanceAugmentation
        Case GAME_MODE_FINISH_AUGMENTATION:
            GameModeFinishAugmentation            
        Case GAME_MODE_COLLECT_AUGMENTATION:
            GameModeCollectAugmentation
        Case GAME_ROTATE_SKILLSHOT_ANTI_CLOCKWISE:
            GameRotateSkillshotAntiClockwise
        Case GAME_ROTATE_SKILLSHOT_CLOCKWISE:
            GameRotateSkillshotClockwise            
        Case GAME_AWARD_SKILLSHOT:
            GameAwardSkillshot
        Case GAME_BALL_SAVE_ENDED:
            GameBallSaveEnded
        Case GAME_ENABLE_BALL_SAVE
            GameEnableBallSave
        Case Else
            MsgBox("Action Unknown")
    End Select

End Sub

'***********************************************************************************************************************
