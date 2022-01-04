'***********************************************************************************************************************
'*****  Allied VUK                                             	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


Sub sw_hyperJump_Hit()
    Dim waittime
    waittime = 400
    'objbase(2).image = "dome2baseblue"
    objlit(2).image = "dome2litblue" 
    objlight(2).color = gameColors(3)
    'objflasher(2).color = gameColors(3)
    objlight(2).colorfull = objlight(2).color
    Objlevel(2) = 1 : FlasherFlash2_Timer
    Objlevel(1) = 1 : FlasherFlash1_Timer
    Objlevel(3) = 1 : FlasherFlash3_Timer
    StopSound("fx-allied-flasher")
    PlaySoundAt "fx-allied-flasher", Flasherbase2
    DISPATCH SWITCH_HIT_HYPERJUMP, null
    vpmTimer.addtimer waittime, "exitsw_hyperJump '"
End Sub

Sub exitsw_hyperJump
    Objlevel(2) = 1 : FlasherFlash2_Timer
    Objlevel(1) = 1 : FlasherFlash1_Timer
    Objlevel(3) = 1 : FlasherFlash3_Timer
    StopSound("fx-allied-flasher")
    PlaySoundAt "fx-allied-flasher", Flasherbase2
    sw_hyperJump.Kick 0, 60, 1.36
End Sub