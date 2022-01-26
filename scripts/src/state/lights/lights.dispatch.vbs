'***********************************************************************************************************************
'*****  Lights Dispatch                                   	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Sub LightsStartSequence()

    LightsPause()

End Sub

Sub LightsPause()

    Lampz.TurnOffStates()
    FlasherFluxTimer1.Enabled = False
    objFluxBase(1).BlendDisableLighting = FluxFlasherOffBrightness
    FlasherFluxTimer2.Enabled = False
    objFluxBase(2).BlendDisableLighting = FluxFlasherOffBrightness

End Sub

Sub RunLightSeq(lightSeq, k)

    Dim light: Set light = lightSeq.CurrentItem
    'DebugOut(k)
    'DebugOut(light.CurrentIdx)
    'DebugOut(UBound(light.Sequence))
    If UBound(light.Sequence)<light.CurrentIdx Then
        light.CurrentIdx = 0
        lightSeq.NextItem()
    Else
        Dim framesRemaining, seq
        seq = light.Sequence
        If IsArray(seq(light.CurrentIdx)) Then
            Dim ls, x
            
            'DebugOut(light.CurrentIdx)
            For x = 0 To UBound(seq(light.CurrentIdx))
                'DebugOut("X:" & Cstr(x))    
                Set ls = seq(light.CurrentIdx)(x)
                If Not IsNull(light.Image) Then
                    ls.Image = light.Image
                    'ls.LampColor = PaletteToLampLookup(light.Image)
                End If
                If Not IsNull(light.LampColor) Then
                    ls.LampColor = light.LampColor
                End If
                gameState("lights")("changedLamps").Add k+cStr(ls.Idx), ls
                'framesRemaining = ls.Update(FrameTime)
                'If framesRemaining < 0 Then
                '    ls.ResetFrames()
                '    If x = UBound(seq(light.CurrentIdx)) Then
                '        light.CurrentIdx = light.CurrentIdx + 1
                '    End If
                'End If            
            Next
        Else
            If Not IsNull(light.Image) Then
                seq(light.CurrentIdx).Image = light.Image
            End If
            If Not IsNull(light.LampColor) Then
                seq(light.CurrentIdx).LampColor = light.LampColor
            End If
            gameState("lights")("changedLamps").Add k+cStr(seq(light.CurrentIdx).Idx), seq(light.CurrentIdx)
            'framesRemaining = seq(light.CurrentIdx).Update(FrameTime)
            'If framesRemaining < 0 Then
            '    seq(light.CurrentIdx).ResetFrames()
            '    light.CurrentIdx = light.CurrentIdx + 1
            'End If
        End If

        framesRemaining = light.Update(FrameTime)
        If framesRemaining < 0 Then
            light.ResetFrames()
            light.CurrentIdx = light.CurrentIdx + 1
        End If
        
    End If



End Sub



Sub LightsUpdate(FrameTime)
    
    If gameState("game")("pauseLights") = True Then
        Exit Sub
    End If

    If Not IsNull(lSeqLightsOverride.CurrentItem) Then
        RunLightSeq lSeqLightsOverride, "lightsOverride"
    Else

        If HasKeys(gameState("lights")("lightSeqs")) Then
            Dim k
            For Each k in gameState("lights")("lightSeqs").Keys()
                Dim lightSeq: Set lightSeq = gameState("lights")("lightSeqs")(k)
                If Not IsNull(lightSeq.CurrentItem) Then
                    RunLightSeq lightSeq, k
                End If
            Next
        End If

        If HasKeys(gameState("lights")("lightBlinks")) Then
            Dim blinkKey
            For Each blinkKey in gameState("lights")("lightBlinks").Keys()

                Dim blinkLight: Set blinkLight = gameState("lights")("lightBlinks")(blinkKey)
                gameState("lights")("changedLamps").Add blinkKey, blinkLight
                Dim blinkFramesRemaining
                blinkFramesRemaining = blinkLight.Update(FrameTime)
                If blinkFramesRemaining < 0 Then
                    blinkLight.Blink()
                End If
            
            Next

        End If

        If HasKeys(gameState("lights")("lightOn")) Then
            Dim lightKey
            For Each lightKey in gameState("lights")("lightOn").Keys()
                Dim light: Set light = gameState("lights")("lightOn")(lightKey)
                light.State = 1
                gameState("lights")("changedLamps").Add lightKey, light
            Next
        End If

        If HasKeys(gameState("lights")("lightFlash")) Then
            Dim flashKey
            For Each flashKey in gameState("lights")("lightFlash").Keys()

                Dim flashLight: Set flashLight = gameState("lights")("lightFlash")(flashKey)
                
                If flashLight.Enabled = False Then
                    flashLight.Enabled = True
                    FluxObjlevel(flashKey) = 0.1
                End If

            Next

        End If

    End If

    If HasKeys(gameState("lights")("changedLamps")) Then
        Dim changedLamp
        For Each changedLamp in gameState("lights")("changedLamps").Keys()
            Lampz.state(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).State
            'MsgBox(gameState("lights")("changedLamps")(changedLamp).lampColor)
            If Not IsNull(gameState("lights")("changedLamps")(changedLamp).lampColor) Then   
                Lampz.lampColor(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).lampColor
            End If
            If Not IsNull(gameState("lights")("changedLamps")(changedLamp).Image) Then   
                Lampz.image(gameState("lights")("changedLamps")(changedLamp).Idx) = gameState("lights")("changedLamps")(changedLamp).Image
            End If
        Next
    End If
	gameState("lights")("changedLamps").RemoveAll
    
End Sub

Sub LightsStartFlicker()
    
    'Dim fOn1: Set fOn1 = New LightChangeItem
    'fOn1.Init 0,1,62,"pal_purple"
    'Dim fOff1: Set fOff1 = new LightChangeItem
    'fOff1.Init 0,0,62,"pal_purple"

    'Dim fOn2: Set fOn2 = New LightChangeItem
    'fOn2.Init 0,1,62,"pal_purple"
    'Dim fOff2: Set fOff2 = new LightChangeItem
    'fOff2.Init 0,0,62,"pal_purple"

    'Dim fOn3: Set fOn3 = New LightChangeItem
    'fOn3.Init 0,1,62,"pal_purple"
    'Dim fOff3: Set fOff3 = new LightChangeItem
    'fOff3.Init 0,0,62,"pal_purple"

    'Dim fOn4: Set fOn4 = New LightChangeItem
    'fOn4.Init 0,1,62,"pal_purple"
    'Dim fOff4: Set fOff4 = new LightChangeItem
    'fOff4.Init 0,0,62,"pal_purple"

    'Dim flicker: Set flicker=CreateObject("Scripting.Dictionary")
    'flicker.Add "currentIdx", 0
    'flicker.Add "sequence", Array(fOn1, fOff1, fOn2, fOff2, fOn3, fOff3, fOn4, fOff4)
    'If Not gameState("lights")("lightSeqs").Exists("flicker") Then
    '    gameState("lights")("lightSeqs").Add "flicker", flicker
    'End If
    
End Sub

Sub LightsAugmentationAttract()

    'Dim x
    'for each x in insertsAugmentations
    '    Dim l: Set l = New LightChangeItem
    '    l.Init x.Uservalue,1,0,"pal_purple"
    '    If gameState("lights")("changedLamps").Exists(x.Name) Then
    '        gameState("lights")("changedLamps").Remove x.Name
    '    End If
        'MsgBox(x.IntensityScale)
    '    gameState("lights")("changedLamps").Add x.Name, l
    'next
    
    'LightSeqInsertsAugmentations.StopPlay
    'LightSeqInsertsAugmentations.Play SeqAllOn
    'LightSeqInsertsAugmentations.UpdateInterval = 12
    'LightSeqInsertsAugmentations.Play SeqFanLeftUpOn, 24, 10
    'LightSeqInsertsAugmentations.UpdateInterval = 15
    'LightSeqInsertsAugmentations.Play SeqUpOn, 12, 2
    'LightSeqInsertsAugmentations.UpdateInterval = 15
    'LightSeqInsertsAugmentations.Play SeqRadarRightOn, 12, 2
    

    'LightSeqInsertsCyber.StopPlay
    'LightSeqInsertsCyber.UpdateInterval = 10
    'LightSeqInsertsCyber.Play SeqLeftOn, 16, 10
    'LightSeqInsertsCyber.UpdateInterval = 20
    'LightSeqInsertsCyber.Play SeqRightOn, 8, 10
    'LightSeqInsertsCyber.UpdateInterval = 20
    'LightSeqInsertsCyber.Play SeqUpOn, 8, 10
    'LightSeqInsertsCyber.Play SeqDownOn, 8, 10


    LightSeqAttract.StopPlay
    LightSeqAttract.UpdateInterval = 10
    LightSeqAttract.Play SeqLeftOn, 16, 2
    LightSeqAttract.UpdateInterval = 20
    LightSeqAttract.Play SeqRightOn, 8, 1
    LightSeqAttract.UpdateInterval = 20
    LightSeqAttract.Play SeqUpOn, 8, 1
    LightSeqAttract.Play SeqDownOn, 8, 1
    
    
    'Dim aug1On: Set aug1On = New LightChangeItem
    'aug1On.Init 0,1,100,"pal_purple"
    'Dim aug1Off: Set aug1Off = new LightChangeItem
    'aug1Off.Init 0,0,100,"pal_purple"

    'Dim aug2On: Set aug2On = New LightChangeItem
    'aug2On.Init 3,1,100,"pal_purple"
    'Dim aug2Off: Set aug2Off = new LightChangeItem
    'aug2Off.Init 3,0,100,"pal_purple"

    'Dim aug3On: Set aug3On = New LightChangeItem
    'aug3On.Init 6,1,100,"pal_purple"
    'Dim aug3Off: Set aug3Off = new LightChangeItem
    'aug3Off.Init 6,0,100,"pal_purple"

    'Dim flicker: Set flicker=CreateObject("Scripting.Dictionary")
    'flicker.Add "currentIdx", 0
    'flicker.Add "repeat", 1
    'flicker.Add "sequence", Array(aug1On, aug1Off, aug2On, aug2Off, aug3On, aug3Off)
    'If Not gameState("lights")("lightSeqs").Exists("augAttract") Then
    '    gameState("lights")("lightSeqs").Add "augAttract", flicker
    'End If
    
End Sub

Sub LightSeqInsertsAugmentations_PlayDone()
    PlaySound "fx-spinner2"
    'LightSeqInsertsAugmentations.Play SeqAllOff
    'LightSeqInsertsAugmentations.StopPlay
    'DISPATCH LIGHTS_RESET_COMMANDERS, null
End Sub

Sub LightsGIOn()
    gameState("lights")("gi") = 1
    
    'LightsAugmentationAttract()

    playfield_lm.visible = True
    p_artblades_back.Image = "artbladesbackgion"
    p_plastics.Image = "plastics_on"
    ModLampz.SetGI 0, 9
    SetGI 0,9
    Dispatch LIGHTS_GI_NORMAL, Null
    
End Sub

Sub LightsGIOff()
    gameState("lights")("gi") = 0
    playfield_lm.visible = False
    'p_artblades_back.Image = "artbladesbackgioff"
    'p_plastics.Image = "plastics_off"
    ModLampz.SetGI 0, 0
End Sub

Sub LightsGINormal()
    for each GIxx in GI
        GIxx.Color = c_normal
        GIxx.ColorFull = c_normal_full
    next
End Sub


Sub LightsGiAugmentationResearch()
    for each GIxx in GI
        GIxx.Color = c_augmentationResearch
        GIxx.ColorFull = c_augmentationResearch
    next
End Sub

Sub LightsResearchReset()
    LightBlink(lsResearch1)
    LightBlink(lsResearch2)
    LightBlink(lsResearch3)
    If gameState("lights")("activeResearch").Exists("aug1") Then
        gameState("lights")("activeResearch").Remove "aug1"
    End If
    If gameState("lights")("activeResearch").Exists("aug2") Then
        gameState("lights")("activeResearch").Remove "aug2"
    End If
    If gameState("lights")("activeResearch").Exists("aug3") Then
        gameState("lights")("activeResearch").Remove "aug3"
    End If
End Sub

Sub LightsResearchOff()
    StopLightBlink(lsResearch1)
    StopLightBlink(lsResearch2)
    StopLightBlink(lsResearch3)
    If gameState("lights")("activeResearch").Exists("aug1") Then
        gameState("lights")("activeResearch").Remove "aug1"
    End If
    If gameState("lights")("activeResearch").Exists("aug2") Then
        gameState("lights")("activeResearch").Remove "aug2"
    End If
    If gameState("lights")("activeResearch").Exists("aug3") Then
        gameState("lights")("activeResearch").Remove "aug3"
    End If
End Sub

Sub LightsResearchReadyOff()
    StopLightBlink(lSeqResearchLit)
    Lampz.state(25) = 0
End Sub

Sub LightsAugmentationsOff()
    Lampz.State(0) = 0
    Lampz.State(1) = 0
    Lampz.State(2) = 0
    Lampz.State(3) = 0
    Lampz.State(4) = 0
    Lampz.State(5) = 0
    Lampz.State(6) = 0
    Lampz.State(7) = 0
    Lampz.State(8) = 0
End Sub

'***********************************************************************************************************************

