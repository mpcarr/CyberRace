

Dim lsSpinner1: Set lsSpinner1 = New LightChangeItem
lsSpinner1.Init 33,1,100,"pal_purple"
Dim lsSpinner1Off: Set lsSpinner1Off = New LightChangeItem
lsSpinner1Off.Init 33,0,100,"pal_purple"
Dim lsSpinner2: Set lsSpinner2 = New LightChangeItem
lsSpinner2.Init 39,1,100,"pal_purple"
Dim lsSpinner2Off: Set lsSpinner2Off = New LightChangeItem
lsSpinner2Off.Init 39,0,100,"pal_purple"

Dim lSeqSpinnerActiveShot: Set lSeqSpinnerActiveShot = new LightSeqItem
lSeqSpinnerActiveShot.Name = "lSeqSpinnerActiveShot"
lSeqSpinnerActiveShot.Image = "pal_purple"
lSeqSpinnerActiveShot.Sequence = Array(Array(lsSpinner1,lsSpinner2), Array(lsSpinner1Off,lsSpinner2Off))

Dim lSeqSpinner: Set lSeqSpinner = new LightSeq
lSeqSpinner.Name = "lSeqSpinner"
lSeqSpinner.Repeat = 1