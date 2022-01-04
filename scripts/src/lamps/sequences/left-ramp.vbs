

Dim lsLeftRamp: Set lsLeftRamp = New LightChangeItem
lsLeftRamp.Init 32,1,100,"pal_purple"
Dim lsLeftRampOff: Set lsLeftRampOff = New LightChangeItem
lsLeftRampOff.Init 32,0,100,"pal_purple"

Dim lSeqLeftRampActiveShot: Set lSeqLeftRampActiveShot = new LightSeqItem
lSeqLeftRampActiveShot.Name = "lSeqLeftRampActiveShot"
lSeqLeftRampActiveShot.Image = "pal_purple"
lSeqLeftRampActiveShot.Sequence = Array(lsLeftRamp,lsLeftRampOff)

Dim lSeqLeftRamp: Set lSeqLeftRamp = new LightSeq
lSeqLeftRamp.Name = "lSeqLeftRamp"
lSeqLeftRamp.Repeat = 1