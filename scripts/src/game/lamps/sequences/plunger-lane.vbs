Dim lsPlungerLane1: Set lsPlungerLane1 = New LightChangeItem
lsPlungerLane1.Init 133,1,180,"pal_green"
Dim lsPlungerLane1Off: Set lsPlungerLane1Off = New LightChangeItem
lsPlungerLane1Off.Init 133,0,180,"pal_green"

Dim lsPlungerLane2: Set lsPlungerLane2 = New LightChangeItem
lsPlungerLane2.Init 134,1,180,"pal_green"
Dim lsPlungerLane2Off: Set lsPlungerLane2Off = New LightChangeItem
lsPlungerLane2Off.Init 134,0,180,"pal_green"

Dim lsPlungerLane3: Set lsPlungerLane3 = New LightChangeItem
lsPlungerLane3.Init 135,1,180,"pal_green"
Dim lsPlungerLane3Off: Set lsPlungerLane3Off = New LightChangeItem
lsPlungerLane3Off.Init 135,0,180,"pal_green"

Dim lSeqPlungerLaneItem: Set lSeqPlungerLaneItem = new LightSeqItem
lSeqPlungerLaneItem.Name = "lSeqPlungerLaneItem"
lSeqPlungerLaneItem.Image = "pal_green"
lSeqPlungerLaneItem.Sequence = Array(lsPlungerLane1,lsPlungerLane2,Array(lsPlungerLane1Off,lsPlungerLane3),lsPlungerLane2Off,lsPlungerLane3Off)
lSeqPlungerLaneItem.UpdateInterval = 100

Dim lSeqPlungerLane: Set lSeqPlungerLane = new LightSeq
lSeqPlungerLane.Name = "lSeqPlungerLane"
lSeqPlungerLane.Repeat = 1

