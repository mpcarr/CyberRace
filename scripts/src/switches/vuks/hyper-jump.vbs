'***********************************************************************************************************************
'*****  Allied VUK                                             	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Sub sw_hyperJump_Hit()
    Dim waittime
    waittime = 400
    FlashDome 2, 3, 1 'Idx, color, pulseCount
    StopSound("fx-allied-flasher")
    PlaySoundAt "fx-allied-flasher", Flasherbase2
    DISPATCH SWITCH_HIT_HYPERJUMP, null
    vpmTimer.addtimer waittime, "exitsw_hyperJump '"
End Sub

Sub exitsw_hyperJump
    StopSound("fx-allied-flasher")
    PlaySoundAt "fx-allied-flasher", Flasherbase2
    sw_hyperJump.Kick 0, 60, 1.36
End Sub