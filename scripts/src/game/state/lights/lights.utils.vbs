'***********************************************************************************************************************
'*****    Light Utils                                                  	                                            ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Function AppendLightSequenceArray(ByVal aArray, aInput)	'append one value, object, or Array onto the end of a 1 dimensional array
    dim tmp : tmp = aArray
    Redim Preserve tmp(uBound(aArray) +1)
    tmp(uBound(aArray)+1) = aInput
    AppendLightSequenceArray = tmp
End Function

Sub LightOn(light)
    If gameState("lights")("lightOn").Exists(light.Idx) Then 
        Exit Sub
    End If

    StopLightBlink(light)

    light.State = 1
    'If Not gameState("lights")("lightOn").Exists(light.Idx) Then 
    gameState("lights")("lightOn").Add light.Idx, light
    'End If
End Sub

Sub LightOff(light)
    StopLightBlink(light)
End Sub

Sub LightFluxFlash(nr, light)

    If Not gameState("lights")("lightFlash").Exists(nr) Then 
        gameState("lights")("lightFlash").Add nr, light
    End If

End Sub

Sub LightFluxFlashOff(nr)

    If gameState("lights")("lightFlash").Exists(nr) Then 
        gameState("lights")("lightFlash").Remove nr
    End If

End Sub

Sub LightBlink(light)

    If Not gameState("lights")("lightBlinks").Exists(light.Idx) Then 
        gameState("lights")("lightBlinks").Add light.Idx, light
    End If

    If gameState("lights")("lightOn").Exists(light.Idx) Then
        gameState("lights")("lightOn").Remove light.Idx
    End If

End Sub

Sub StopLightBlink(light)

    Lampz.State(light.Idx) = 0
    light.State = 1
    light.ResetFrames()

    If gameState("lights")("lightBlinks").Exists(light.Idx) Then
        gameState("lights")("lightBlinks").Remove light.Idx
    End If

    If gameState("lights")("lightOn").Exists(light.Idx) Then	
        gameState("lights")("lightOn").Remove light.Idx
    End If

End Sub

Sub StopLightSeq(seq)
    If Not IsNull(seq) Then
        Dim item
        For Each item in seq.Items
            Dim x
            For Each x in item.Sequence

                If IsArray(x) Then
                    Dim xx
                    For Each xx in x
                        Lampz.State(xx.Idx) = 0
                    Next
                Else
                    Lampz.State(x.Idx) = 0
                
                End If
            Next
            item.CurrentIdx = 0
        Next
        If gameState("lights")("lightSeqs").Exists(seq.Name) Then
            gameState("lights")("lightSeqs").Remove seq.Name
        End If
    End If
End Sub

Sub StartLightSeq(seq)
    If Not IsNull(seq) Then
        If Not gameState("lights")("lightSeqs").Exists(seq.Name) Then
            gameState("lights")("lightSeqs").Add seq.Name, seq
        End If
    End If
End Sub

Function IsLightOn(light)
    If gameState("lights")("lightBlinks").Exists(light.Idx) Or gameState("lights")("lightOn").Exists(light.Idx) Then 
        IsLightOn = True
    Else
        IsLightOn = False
    End If
End Function