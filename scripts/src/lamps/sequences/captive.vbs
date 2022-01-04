Dim lsCaptive1: Set lsCaptive1 = New LightChangeItem
lsCaptive1.Init 26,1,20,"pal_purple"
Dim lsCaptive1Off: Set lsCaptive1Off = New LightChangeItem
lsCaptive1Off.Init 26,0,20,"pal_purple"

Dim lsCaptive2: Set lsCaptive2 = New LightChangeItem
lsCaptive2.Init 27,1,20,"pal_purple"
Dim lsCaptive2Off: Set lsCaptive2Off = New LightChangeItem
lsCaptive2Off.Init 27,0,20,"pal_purple"

Dim lsCaptive3: Set lsCaptive3 = New LightChangeItem
lsCaptive3.Init 28,1,20,"pal_purple"
Dim lsCaptive3Off: Set lsCaptive3Off = New LightChangeItem
lsCaptive3Off.Init 28,0,20,"pal_purple"

Dim lsCaptive4: Set lsCaptive4 = New LightChangeItem
lsCaptive4.Init 29,1,20,"pal_purple"
Dim lsCaptive4Off: Set lsCaptive4Off = New LightChangeItem
lsCaptive4Off.Init 29,0,20,"pal_purple"


Dim lSeqCaptiveAugHold: Set lSeqCaptiveAugHold = new LightSeqItem
lSeqCaptiveAugHold.Name = "lSeqCaptiveAugHold"
lSeqCaptiveAugHold.Image = "pal_purple"
lSeqCaptiveAugHold.Sequence = Array(lsCaptive4,lsCaptive3,Array(lsCaptive4Off,lsCaptive2),Array(lsCaptive3Off,lsCaptive1),lsCaptive2Off, lsCaptive1Off)
lSeqCaptiveAugHold.UpdateInterval = 20

Dim lSeqCaptive: Set lSeqCaptive = new LightSeq
lSeqCaptive.Name = "lSeqCaptive"
lSeqCaptive.Repeat = 1