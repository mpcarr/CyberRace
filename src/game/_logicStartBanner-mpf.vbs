
Dim useBCP : useBCP = False

Sub TurnAllLightsOn

    Dim light
    For Each light in alights2
        light.State = 1
        light.Color = RGB(0,0,0)
        lightCtrl.LightColor light,RGB(0,0,0)
    Next

End Sub