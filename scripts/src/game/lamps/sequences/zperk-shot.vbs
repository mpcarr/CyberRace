

Dim lSeqLeftOrbitPerkShot: Set lSeqLeftOrbitPerkShot = new LightSeqItem
lSeqLeftOrbitPerkShot.Name = "lSeqLeftOrbitPerkShot"
lSeqLeftOrbitPerkShot.Image = "pal_orange"
lSeqLeftOrbitPerkShot.Sequence = Array(lsLeftOrbit,lsLeftOrbitOff)

Dim lSeqRightOrbitPerkShot: Set lSeqRightOrbitPerkShot = new LightSeqItem
lSeqRightOrbitPerkShot.Name = "lSeqRightOrbitPerkShot"
lSeqRightOrbitPerkShot.Image = "pal_orange"
lSeqRightOrbitPerkShot.Sequence = Array(lsRightOrbit,lsRightOrbitOff)

Dim lSeqHyperJumpPerkShot: Set lSeqHyperJumpPerkShot = new LightSeqItem
lSeqHyperJumpPerkShot.Name = "lSeqHyperJumpPerkShot"
lSeqHyperJumpPerkShot.Image = "pal_orange"
lSeqHyperJumpPerkShot.Sequence = Array(lsHyperJump5,lsHyperJump4,Array(lsHyperJump5Off,lsHyperJump3),Array(lsHyperJump4Off,lsHyperJump2),Array(lsHyperJump3Off,lsHyperJump1),lsHyperJump2Off, lsHyperJump1Off)
lSeqHyperJumpPerkShot.UpdateInterval = 60

Dim lSeqShortcutPerkShot: Set lSeqShortcutPerkShot = new LightSeqItem
lSeqShortcutPerkShot.Name = "lSeqShortcutPerkShot"
lSeqShortcutPerkShot.Image = "pal_orange"
lSeqShortcutPerkShot.UpdateInterval = 60
lSeqShortcutPerkShot.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)

Dim lSeqRightRampPerkShot: Set lSeqRightRampPerkShot = new LightSeqItem
lSeqRightRampPerkShot.Name = "lSeqRightRampPerkShot"
lSeqRightRampPerkShot.Image = "pal_orange"
lSeqRightRampPerkShot.Sequence = Array(lsRightRamp,lsRightRampOff)

Dim lSeqLeftRampPerkShot: Set lSeqLeftRampPerkShot = new LightSeqItem
lSeqLeftRampPerkShot.Name = "lSeqLeftRampPerkShot"
lSeqLeftRampPerkShot.Image = "pal_orange"
lSeqLeftRampPerkShot.Sequence = Array(lsLeftRamp,lsLeftRampOff)

Dim lSeqCenterRampPerkShot: Set lSeqCenterRampPerkShot = new LightSeqItem
lSeqCenterRampPerkShot.Name = "lSeqCenterRampPerkShot"
lSeqCenterRampPerkShot.Image = "pal_orange"
lSeqCenterRampPerkShot.Sequence = Array(lsCenterRamp,lsCenterRampOff)

Dim lSeqSpinnerPerkShot: Set lSeqSpinnerPerkShot = new LightSeqItem
lSeqSpinnerPerkShot.Name = "lSeqSpinnerPerkShot"
lSeqSpinnerPerkShot.Image = "pal_orange"
lSeqSpinnerPerkShot.Sequence = Array(Array(lsSpinner1,lsSpinner2), Array(lsSpinner1Off,lsSpinner2Off))

Dim lSeqBumpersPerkShot: Set lSeqBumpersPerkShot = new LightSeqItem
lSeqBumpersPerkShot.Name = "lSeqBumpersPerkShot"
lSeqBumpersPerkShot.LampColor = gameColors(2)
lSeqBumpersPerkShot.Sequence = Array(Array(lsBump1flash,lsBump2flash,lsBump3flash), Array(lsBump1flashOff,lsBump2flashOff,lsBump3flashOff))