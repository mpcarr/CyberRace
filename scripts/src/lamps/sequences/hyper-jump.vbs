Dim lsHyperJump1: Set lsHyperJump1 = New LightChangeItem
lsHyperJump1.Init 38,1,20,"pal_purple"
Dim lsHyperJump1Off: Set lsHyperJump1Off = New LightChangeItem
lsHyperJump1Off.Init 38,0,20,"pal_purple"

Dim lsHyperJump2: Set lsHyperJump2 = New LightChangeItem
lsHyperJump2.Init 45,1,20,"pal_purple"
Dim lsHyperJump2Off: Set lsHyperJump2Off = New LightChangeItem
lsHyperJump2Off.Init 45,0,20,"pal_purple"

Dim lsHyperJump3: Set lsHyperJump3 = New LightChangeItem
lsHyperJump3.Init 43,1,20,"pal_purple"
Dim lsHyperJump3Off: Set lsHyperJump3Off = New LightChangeItem
lsHyperJump3Off.Init 43,0,20,"pal_purple"

Dim lsHyperJump4: Set lsHyperJump4 = New LightChangeItem
lsHyperJump4.Init 44,1,20,"pal_purple"
Dim lsHyperJump4Off: Set lsHyperJump4Off = New LightChangeItem
lsHyperJump4Off.Init 44,0,20,"pal_purple"

Dim lsHyperJump5: Set lsHyperJump5 = New LightChangeItem
lsHyperJump5.Init 68,1,20,"pal_purple"
Dim lsHyperJump5Off: Set lsHyperJump5Off = New LightChangeItem
lsHyperJump5Off.Init 68,0,20,"pal_purple"

Dim lSeqHyperJumpActiveShot: Set lSeqHyperJumpActiveShot = new LightSeqItem
lSeqHyperJumpActiveShot.Name = "lSeqHyperJumpActiveShot"
lSeqHyperJumpActiveShot.Image = "pal_purple"
lSeqHyperJumpActiveShot.Sequence = Array(lsHyperJump5,lsHyperJump4,Array(lsHyperJump5Off,lsHyperJump3),Array(lsHyperJump4Off,lsHyperJump2),Array(lsHyperJump3Off,lsHyperJump1),lsHyperJump2Off, lsHyperJump1Off)
lSeqHyperJumpActiveShot.UpdateInterval = 20

Dim lSeqHyperJump: Set lSeqHyperJump = new LightSeq
lSeqHyperJump.Name = "lSeqHyperJump"
lSeqHyperJump.Repeat = 1