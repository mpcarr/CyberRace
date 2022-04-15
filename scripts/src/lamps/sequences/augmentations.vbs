
Dim lsAug1: Set lsAug1 = New LightChangeItem
lsAug1.Init 0,1,180,"pal_blue"
Dim lsAug1Off: Set lsAug1Off = New LightChangeItem
lsAug1Off.Init 0,0,180,"pal_blue"

Dim lsAug2: Set lsAug2 = New LightChangeItem
lsAug2.Init 3,1,180,"pal_blue"
Dim lsAug2Off: Set lsAug2Off = New LightChangeItem
lsAug2Off.Init 3,0,180,"pal_blue"

Dim lsAug3: Set lsAug3 = New LightChangeItem
lsAug3.Init 6,1,180,"pal_blue"
Dim lsAug3Off: Set lsAug3Off = New LightChangeItem
lsAug3Off.Init 6,0,180,"pal_blue"

Dim lsAug4: Set lsAug4 = New LightChangeItem
lsAug4.Init 1,4,180,"pal_blue"
Dim lsAug4Off: Set lsAug4Off = New LightChangeItem
lsAug4Off.Init 1,0,180,"pal_blue"

Dim lsAug5: Set lsAug5 = New LightChangeItem
lsAug5.Init 4,1,180,"pal_blue"
Dim lsAug5Off: Set lsAug5Off = New LightChangeItem
lsAug5Off.Init 4,0,180,"pal_blue"

Dim lsAug6: Set lsAug6 = New LightChangeItem
lsAug6.Init 7,1,180,"pal_blue"
Dim lsAug6Off: Set lsAug6Off = New LightChangeItem
lsAug6Off.Init 7,0,180,"pal_blue"

Dim lsAug7: Set lsAug7 = New LightChangeItem
lsAug7.Init 2,4,180,"pal_blue"
Dim lsAug7Off: Set lsAug7Off = New LightChangeItem
lsAug7Off.Init 2,0,180,"pal_blue"

Dim lsAug8: Set lsAug8 = New LightChangeItem
lsAug8.Init 5,1,180,"pal_blue"
Dim lsAug8Off: Set lsAug8Off = New LightChangeItem
lsAug8Off.Init 5,0,180,"pal_blue"

Dim lsAug9: Set lsAug9 = New LightChangeItem
lsAug9.Init 8,1,180,"pal_blue"
Dim lsAug9Off: Set lsAug9Off = New LightChangeItem
lsAug9Off.Init 8,0,180,"pal_blue"

Dim lSeqAugmentationFlicker: Set lSeqAugmentationFlicker = new LightSeqItem
lSeqAugmentationFlicker.Name = "lSeqAugmentationFlicker"
lSeqAugmentationFlicker.Image = "pal_blue"
lSeqAugmentationFlicker.Sequence = Array(Array(lsAug1Off,lsAug2Off,lsAug3Off,lsAug4Off,lsAug5Off,lsAug6Off,lsAug7Off,lsAug8Off,lsAug9Off),lsAug1,lsAug2,lsAug3, Array(lsAug1Off,lsAug4),Array(lsAug2Off,lsAug5),Array(lsAug3Off,lsAug6),Array(lsAug4Off,lsAug7),Array(lsAug5Off,lsAug8),Array(lsAug6Off,lsAug9),lsAug7Off,lsAug8Off,lsAug9Off)
lSeqAugmentationFlicker.UpdateInterval = 20

Dim lSeqAugmentation: Set lSeqAugmentation = new LightSeq
lSeqAugmentation.Name = "lSeqAugmentation"
