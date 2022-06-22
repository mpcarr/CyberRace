

Dim lsRightOrbit: Set lsRightOrbit = New LightChangeItem
lsRightOrbit.Init 36,1,180,"pal_purple"
Dim lsRightOrbitOff: Set lsRightOrbitOff = New LightChangeItem
lsRightOrbitOff.Init 36,0,180,"pal_purple"

Dim lSeqRightOrbitActiveShot: Set lSeqRightOrbitActiveShot = new LightSeqItem
lSeqRightOrbitActiveShot.Name = "lSeqRightOrbitActiveShot"
lSeqRightOrbitActiveShot.Image = "pal_purple"
lSeqRightOrbitActiveShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqRightOrbitHurryUpShot: Set lSeqRightOrbitHurryUpShot = new LightSeqItem
lSeqRightOrbitHurryUpShot.Name = "lSeqRightOrbitHurryUpShot"
lSeqRightOrbitHurryUpShot.Image = "pal_yellow"
lSeqRightOrbitHurryUpShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqRightOrbit: Set lSeqRightOrbit = new LightSeq
lSeqRightOrbit.Name = "lSeqRightOrbit"
lSeqRightOrbit.Repeat = 1