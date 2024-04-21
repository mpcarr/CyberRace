
'****************************
' Switch Left Flipper Down
' Event Listeners:  
    RegisterPinEvent SWITCH_LEFT_FLIPPER_DOWN, "SwitchLeftFlipperDown"
'
'*****************************
Sub SwitchLeftFlipperDown()
    SetGameState SWITCHES_LAST_FLIPPER_DOWN_TIME, GameTime
End Sub

'****************************
' Switch Right Flipper Down
' Event Listeners:  
    RegisterPinEvent SWITCH_RIGHT_FLIPPER_DOWN, "SwitchRightFlipperDown"
'
'*****************************
Sub SwitchRightFlipperDown()
    SetGameState SWITCHES_LAST_FLIPPER_DOWN_TIME, GameTime
End Sub