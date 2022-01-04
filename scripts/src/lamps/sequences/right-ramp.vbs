

Dim lsRightRamp: Set lsRightRamp = New LightChangeItem
lsRightRamp.Init 35,1,100,"pal_purple"
Dim lsRightRampOff: Set lsRightRampOff = New LightChangeItem
lsRightRampOff.Init 35,0,100,"pal_purple"

Dim lSeqRightRampActiveShot: Set lSeqRightRampActiveShot = new LightSeqItem
lSeqRightRampActiveShot.Name = "lSeqRightRampActiveShot"
lSeqRightRampActiveShot.Image = "pal_purple"
lSeqRightRampActiveShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqRightRampCollectShot: Set lSeqRightRampCollectShot = new LightSeqItem
lSeqRightRampCollectShot.Name = "lSeqRightRampCollectShot"
lSeqRightRampCollectShot.Image = "pal_green"
lSeqRightRampCollectShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqRightRamp: Set lSeqRightRamp = new LightSeq
lSeqRightRamp.Name = "lSeqRightRamp"
lSeqRightRamp.Repeat = 1