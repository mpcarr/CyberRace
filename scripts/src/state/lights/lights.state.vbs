'***********************************************************************************************************************
'*****  Lane Lights State                                      	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function InitLightsState()
    
    Dim lights: Set lights=CreateObject("Scripting.Dictionary")

    lights.Add "lightSeqs", InitLightSeqs()
    lights.Add "lightBlinks", InitLightBlinks()
    lights.Add "lightOn", InitLightOn()
    lights.Add "lightFlash", InitLightFlash()

    lights.Add "activeCommanderIdx", 0
    lights.Add "activeCommanderCol", 0
    lights.Add "activeCommanders", CreateObject("Scripting.Dictionary")
    lights.Add "activeResearch", CreateObject("Scripting.Dictionary")

    lights.Add "changedLamps", CreateObject("Scripting.Dictionary")

    lights.Add "gi", 0

    Set InitLightsState = lights
End Function


Function InitLightSeqs()
    Dim lightSeqs: Set lightSeqs=CreateObject("Scripting.Dictionary")
    Set InitLightSeqs = lightSeqs
End Function

Function InitLightBlinks()
    Dim lightBlinks: Set lightBlinks=CreateObject("Scripting.Dictionary")
    Set InitLightBlinks = lightBlinks
End Function

Function InitLightOn()
    Dim lightOn: Set lightOn=CreateObject("Scripting.Dictionary")
    Set InitLightOn = lightOn
End Function

Function InitLightFlash()
    Dim lightFlash: Set lightFlash=CreateObject("Scripting.Dictionary")
    Set InitLightFlash = lightFlash
End Function

'***********************************************************************************************************************
