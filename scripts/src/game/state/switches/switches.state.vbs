'***********************************************************************************************************************
'*****  Switches State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitSwitchesState()
    Dim switches:Set switches=CreateObject("Scripting.Dictionary")

    switches("preLeftOrbit") = 0
    switches("leftOrbit") = 0
    switches("preRightOrbit") = 0
    switches("rightOrbit") = 0
    switches("augmentation") = 0
    switches("captive") = 0
    switches("shortcut") = 0
    switches("lightlock") = 0
    switches("betB") = 1
    switches("betE") = 0
    switches("betT") = 0
    switches("lastFlipperDown") = 0

    Set InitSwitchesState = switches
End Function

'***********************************************************************************************************************
