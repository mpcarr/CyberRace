

Dim lsLeftOrbit: Set lsLeftOrbit = New LightChangeItem
lsLeftOrbit.Init 31,1,180,"pal_purple"
Dim lsLeftOrbitOff: Set lsLeftOrbitOff = New LightChangeItem
lsLeftOrbitOff.Init 31,0,180,"pal_purple"

Dim lSeqLeftOrbitActiveShot: Set lSeqLeftOrbitActiveShot = new LightSeqItem
lSeqLeftOrbitActiveShot.Name = "lSeqLeftOrbitActiveShot"
lSeqLeftOrbitActiveShot.Image = "pal_purple"
lSeqLeftOrbitActiveShot.Sequence = Array(lsLeftOrbit,lsLeftOrbitOff)

Dim lSeqLeftOrbit: Set lSeqLeftOrbit = new LightSeq
lSeqLeftOrbit.Name = "lSeqLeftOrbit"
lSeqLeftOrbit.Repeat = 1