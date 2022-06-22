

Dim lsCenterRamp: Set lsCenterRamp = New LightChangeItem
lsCenterRamp.Init 34,1,180,"pal_purple"
Dim lsCenterRampOff: Set lsCenterRampOff = New LightChangeItem
lsCenterRampOff.Init 34,0,180,"pal_purple"

Dim lSeqCenterRampActiveShot: Set lSeqCenterRampActiveShot = new LightSeqItem
lSeqCenterRampActiveShot.Name = "lSeqCenterRampActiveShot"
lSeqCenterRampActiveShot.Image = "pal_purple"
lSeqCenterRampActiveShot.Sequence = Array(lsCenterRamp,lsCenterRampOff)

Dim lSeqCenterRamp: Set lSeqCenterRamp = new LightSeq
lSeqCenterRamp.Name = "lSeqCenterRamp"
lSeqCenterRamp.Repeat = 1