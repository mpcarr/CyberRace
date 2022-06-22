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

Dim lsAugSign1: Set lsAugSign1 = New LightChangeItem
lsAugSign1.Init 15,1,100,"pal_red_darker"
Dim lsAugSign1Off: Set lsAugSign1Off = New LightChangeItem
lsAugSign1Off.Init 15,0,100,"pal_red_darker"

Dim lsAugSign2: Set lsAugSign2 = New LightChangeItem
lsAugSign2.Init 16,1,100,"pal_red_darker"
Dim lsAugSign2Off: Set lsAugSign2Off = New LightChangeItem
lsAugSign2Off.Init 16,0,100,"pal_red_darker"

Dim lsAugSign3: Set lsAugSign3 = New LightChangeItem
lsAugSign3.Init 17,1,100,"pal_red_darker"
Dim lsAugSign3Off: Set lsAugSign3Off = New LightChangeItem
lsAugSign3Off.Init 17,0,100,"pal_red_darker"

Dim lsAugSign4: Set lsAugSign4 = New LightChangeItem
lsAugSign4.Init 18,1,100,"pal_red_darker"
Dim lsAugSign4Off: Set lsAugSign4Off = New LightChangeItem
lsAugSign4Off.Init 18,0,100,"pal_red_darker"

Dim lsAugSign5: Set lsAugSign5 = New LightChangeItem
lsAugSign5.Init 19,1,100,"pal_red_darker"
Dim lsAugSign5Off: Set lsAugSign5Off = New LightChangeItem
lsAugSign5Off.Init 19,0,100,"pal_red_darker"


Dim lSeqCaptiveAugHold: Set lSeqCaptiveAugHold = new LightSeqItem
lSeqCaptiveAugHold.Name = "lSeqCaptiveAugHold"
lSeqCaptiveAugHold.Image = "pal_purple"
lSeqCaptiveAugHold.Sequence = Array(lsCaptive4,lsCaptive3,Array(lsCaptive4Off,lsCaptive2),Array(lsCaptive3Off,lsCaptive1),lsCaptive2Off, lsCaptive1Off)
lSeqCaptiveAugHold.UpdateInterval = 60

Dim lSeqCaptive: Set lSeqCaptive = new LightSeq
lSeqCaptive.Name = "lSeqCaptive"
lSeqCaptive.Repeat = 1