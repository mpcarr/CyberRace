
'Dim audioBGTracks: Set gameLogic=CreateObject("Scripting.Dictionary")

Dim audioTracks, currentTrack, trackCount
audioTracks = Array(Array("500", "White Bat Audio - Glitch in Reality", "195600", "601"), Array("501", "Rob Avery - Untitled", "67200", "602"), Array("508", "WBA - Race Against Sunset", "206400", "603"),Array("509", "WBA - Existence", "212400", "604"))
currentTrack = RndNum(0,UBound(audioTracks))
trackCount = 0
'audioBGTracks.Add "E500", "White Bat Audio - Glitch in Reality"
'audioBGTracks.Add "E501", "Rob Avery - Untitled"

Sub PlayBGAudio

    If currentTrack > -1 Then
        Dim pupCode: pupCode = audioTracks(currentTrack)(0)
        pupevent pupCode
        trackCount=trackCount+1
        DisplayCurrentAudioTrack()
        vpmTimer.AddTimer audioTracks(currentTrack)(2), "vpmTimerNextTrack "&pupCode&","&trackCount&" '"
    End If

End Sub

Sub vpmTimerNextTrack(pupCode, count)
    Debug.print ">"&pupCode&"<"
    Debug.print ">"&count&"<"
    Debug.print ">"&trackCount&"<"
    If currentTrack > -1 Then
        If count = trackCount Then
            Debug.print "MAtch"
            PlayBGAudioNext()
        End If
    End If
End Sub

Sub PlayBGAudioNext()

    If currentTrack = -1 Then
        currentTrack = RndNum(0,UBound(audioTracks))
    End If

    'Debug.Print(currentTrack)
    'Debug.Print(UBound(audioTracks))
    currentTrack=currentTrack+1
    If currentTrack > UBound(audioTracks) Then
        currentTrack = 0
    End If

    PlayBGAudio()

End Sub

Sub StopBGAudio
    dim track
    for each track in audioTracks
        pupevent track(3)
    next
    currentTrack = -1
    pupevent 605'hurryup
    pupevent 503'hackers

End sub