Sub PlaySoundAtLevelStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 0, 0, AudioFade(ActiveBall)
End Sub


Sub PlayGameCallout(callout)
    If Not gameState("game")("currentCallOut") = "" Then
        StopSound(gameState("game")("currentCallOut"))
    End If
    PlaySound(callout)
    gameState("game")("currentCallOut") = callout
End Sub