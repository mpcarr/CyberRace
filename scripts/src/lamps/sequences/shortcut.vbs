Dim lsShortcut1: Set lsShortcut1 = New LightChangeItem
lsShortcut1.Init 46,1,60,"pal_purple"
Dim lsShortcut1Off: Set lsShortcut1Off = New LightChangeItem
lsShortcut1Off.Init 46,0,60,"pal_purple"

Dim lsShortcut2: Set lsShortcut2 = New LightChangeItem
lsShortcut2.Init 47,1,60,"pal_purple"
Dim lsShortcut2Off: Set lsShortcut2Off = New LightChangeItem
lsShortcut2Off.Init 47,0,60,"pal_purple"

Dim lsShortcut3: Set lsShortcut3 = New LightChangeItem
lsShortcut3.Init 48,1,60,"pal_purple"
Dim lsShortcut3Off: Set lsShortcut3Off = New LightChangeItem
lsShortcut3Off.Init 48,0,60,"pal_purple"

Dim lSeqShortcutBlink: Set lSeqShortcutBlink = new LightSeqItem
lSeqShortcutBlink.Name = "lSeqShortcutBlink"
lSeqShortcutBlink.Image = "pal_purple"
lSeqShortcutBlink.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)


Dim lSeqShortcutActiveShot: Set lSeqShortcutActiveShot = new LightSeqItem
lSeqShortcutActiveShot.Name = "lSeqShortcutActiveShot"
lSeqShortcutActiveShot.Image = "pal_purple"
lSeqShortcutActiveShot.Sequence = Array(Array(lsShortcut1,lsShortcut2),lsShortcut3,Array(lsShortcut1Off,lsShortcut2Off),lsShortcut3Off)

Dim lSeqShortcut: Set lSeqShortcut = new LightSeq
lSeqShortcut.Name = "lSeqShortcut"
lSeqShortcut.Repeat = 1