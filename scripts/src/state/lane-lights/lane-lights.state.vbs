'***********************************************************************************************************************
'*****  Lane Lights State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitLaneLightsState()
    
    Dim laneLights: Set laneLights=CreateObject("Scripting.Dictionary")
    
    laneLights.Add "leftOuter", 0
    laneLights.Add "leftInner", 0
    laneLights.Add "rightOuter", 0
    laneLights.Add "rightInner", 0

    Set InitLaneLightsState = laneLights
End Function
'***********************************************************************************************************************
