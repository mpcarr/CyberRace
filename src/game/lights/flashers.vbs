
Sub FlashSeq1()
    GIOff
    SetTimer "Flash1", "lightCtrl.Pulse l140, 0", 0
    SetTimer "Flash2", "lightCtrl.Pulse l141, 0", 100
    SetTimer "Flash3", "lightCtrl.Pulse l142, 0", 200
    SetTimer "Flash4", "lightCtrl.Pulse l143, 0", 300
    SetTimer "GIOn", "GIOn", 400
End Sub

Sub FlashSeq2()
    GIOff
    SetTimer "Flash1", "lightCtrl.Pulse l140, 0", 0
    SetTimer "Flash2", "lightCtrl.Pulse l141, 0", 100
    SetTimer "Flash3", "lightCtrl.Pulse l140, 0", 200
    SetTimer "Flash4", "lightCtrl.Pulse l141, 0", 300
    SetTimer "Flash5", "lightCtrl.Pulse l142, 0", 400
    SetTimer "Flash6", "lightCtrl.Pulse l143, 0", 500
    SetTimer "Flash7", "lightCtrl.Pulse l142, 0", 600
    SetTimer "Flash8", "lightCtrl.Pulse l143, 0", 700
    SetTimer "GIOn", "GIOn", 800
End Sub