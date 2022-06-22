

Dim lsBump1flash: Set lsBump1flash = New LightChangeItem
lsBump1flash.Init 40,1,80,"pal_purple"

Dim lsBump1flashOff: Set lsBump1flashOff = New LightChangeItem
lsBump1flashOff.Init 40,0,80,"pal_purple"

Dim lsBump2flash: Set lsBump2flash = New LightChangeItem
lsBump2flash.Init 41,1,80,"pal_purple"

Dim lsBump2flashOff: Set lsBump2flashOff = New LightChangeItem
lsBump2flashOff.Init 41,0,80,"pal_purple"

Dim lsBump3flash: Set lsBump3flash = New LightChangeItem
lsBump3flash.Init 42,1,80,"pal_purple"

Dim lsBump3flashOff: Set lsBump3flashOff = New LightChangeItem
lsBump3flashOff.Init 42,0,80,"pal_purple"

Dim lSeqBumpersActiveShot: Set lSeqBumpersActiveShot = new LightSeqItem
lSeqBumpersActiveShot.Name = "lSeqBumpersActiveShot"
lSeqBumpersActiveShot.LampColor = gameColors(0)
lSeqBumpersActiveShot.Sequence = Array(Array(lsBump1flash,lsBump2flash,lsBump3flash), Array(lsBump1flashOff,lsBump2flashOff,lsBump3flashOff))
lSeqBumpersActiveShot.UpdateInterval = 80


Dim lSeqBumper1HitFlash: Set lSeqBumper1HitFlash = new LightSeqItem
lSeqBumper1HitFlash.Name = "lSeqBumper1HitFlash"
lSeqBumper1HitFlash.Sequence = Array(lsBump1flash, lsBump1flashOff)
lSeqBumper1HitFlash.UpdateInterval = 40

Dim lSeqBumper2HitFlash: Set lSeqBumper2HitFlash = new LightSeqItem
lSeqBumper2HitFlash.Name = "lSeqBumper2HitFlash"
lSeqBumper2HitFlash.Sequence = Array(lsBump2flash, lsBump2flashOff)
lSeqBumper2HitFlash.UpdateInterval = 40

Dim lSeqBumper3HitFlash: Set lSeqBumper3HitFlash = new LightSeqItem
lSeqBumper3HitFlash.Name = "lSeqBumper3HitFlash"
lSeqBumper3HitFlash.Sequence = Array(lsBump3flash, lsBump3flashOff)
lSeqBumper3HitFlash.UpdateInterval = 40


Dim lSeqBumpers: Set lSeqBumpers = new LightSeq
lSeqBumpers.Name = "lSeqBumpers"
lSeqBumpers.Repeat = 1

Dim lSeqBumpersFlash: Set lSeqBumpersFlash = new LightSeq
lSeqBumpersFlash.Name = "lSeqBumpersFlash"