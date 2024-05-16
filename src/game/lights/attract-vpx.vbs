
'****************************
' Attract
' Event Listeners:          
    AddPinEventListener GAME_OVER, GAME_OVER &   "StartAttract",   "StartAttract",  1000, Null
'
'*****************************
Sub StartAttract()
    lightCtrl.ResetLights()
	lightCtrl.AddTableLightSeq "AttractGI", lSeqGIOn
	lightCtrl.AddTableLightSeq "AttractLanes", lSeqAttLanes
	lightCtrl.AddTableLightSeq "AttractRace", lSeqAttRace
	lightCtrl.AddTableLightSeq "AttractBonus", lSeqAttBonus
	lightCtrl.AddTableLightSeq "AttractSlam", lSeqAttSlam
	lightCtrl.AddTableLightSeq "AttractCyber", lSeqAttCyber
	lightCtrl.AddTableLightSeq "AttractShots", lSeqAttShots
	lightCtrl.AddTableLightSeq "AttractBet", lSeqAttBet
	lightCtrl.AddTableLightSeq "AttractNodes", lSeqAttNodes
	lightCtrl.AddTableLightSeq "AttractHyper", lSeqAttHyper
	lightCtrl.AddTableLightSeq "AttractTT", lSeqAttTT
	lightCtrl.AddTableLightSeq "AttractCombo", lSeqAttCombo
	lightCtrl.AddTableLightSeq "AttractBoost", lSeqAttBoost
End Sub

Dim lSeqAttFlashers : Set lSeqAttFlashers = New LCSeq
lSeqAttFlashers.Name = "lSeqAttFlashers"
lSeqAttFlashers.Sequence = Array( Array("l140|100|FFFFFF", "l141|100|FFFFFF","l142|100|FFFFFF", "l143|100|FFFFFF", "l144|100|FFFFFF"))
lSeqAttFlashers.UpdateInterval = 1000
lSeqAttFlashers.Color = Null
lSeqAttFlashers.Repeat = False

Dim lSeqAttLanes : Set lSeqAttLanes = New LCSeq
lSeqAttLanes.Name = "lSeqAttLanes"
lSeqAttLanes.Sequence = Array( Array("l19|0|FFFFFF", "l17|100|FFFFFF"), Array("l17|0|FFFFFF", "l18|100|FFFFFF"), Array("l18|0|FFFFFF", "l19|100|FFFFFF"))
lSeqAttLanes.UpdateInterval = 280
lSeqAttLanes.Color = Null
lSeqAttLanes.Repeat = True

Dim lSeqAttBet : Set lSeqAttBet = New LCSeq
lSeqAttBet.Name = "lSeqAttBet"
lSeqAttBet.Sequence = Array( Array("l45|0|FFFFFF", "l42|100|FFFFFF"), Array("l42|0|FFFFFF", "l43|100|FFFFFF"), Array("l43|0|FFFFFF", "l44|100|FFFFFF"), Array("l44|0|FFFFFF", "l45|100|FFFFFF"))
lSeqAttBet.UpdateInterval = 280
lSeqAttBet.Color = Null
lSeqAttBet.Repeat = True

Dim lSeqAttRace : Set lSeqAttRace = New LCSeq
lSeqAttRace.Name = "lSeqAttRace"
lSeqAttRace.Sequence = Array( Array("l58|0|FFFFFF", "l53|100|FFFFFF"), Array("l53|0|FFFFFF", "l54|100|FFFFFF"), Array("l54|0|FFFFFF", "l55|100|FFFFFF"), Array("l55|0|FFFFFF", "l56|100|FFFFFF"), Array("l56|0|FFFFFF", "l57|100|FFFFFF") ,Array("l57|0|FFFFFF", "l58|100|FFFFFF"))
lSeqAttRace.UpdateInterval = 280
lSeqAttRace.Color = Null
lSeqAttRace.Repeat = True

Dim lSeqAttBonus : Set lSeqAttBonus = New LCSeq
lSeqAttBonus.Name = "lSeqAttBonus"
lSeqAttBonus.Sequence = Array( Array("l51|0|FFFFFF", "l21|0|FFFFFF","l52|100|FFFFFF", "l22|100|FFFFFF"), Array("l52|0|FFFFFF", "l22|0|FFFFFF","l50|100|FFFFFF", "l20|100|FFFFFF"), Array("l50|0|FFFFFF", "l20|0|FFFFFF","l51|100|FFFFFF", "l21|100|FFFFFF"))
lSeqAttBonus.UpdateInterval = 280
lSeqAttBonus.Color = Null
lSeqAttBonus.Repeat = True

Dim lSeqAttSlam : Set lSeqAttSlam = New LCSeq
lSeqAttSlam.Name = "lSeqAttSlam"
lSeqAttSlam.Sequence = Array( Array("l84|0|FFFFFF", "l80|100|FFFFFF"), Array("l80|0|FFFFFF", "l81|100|FFFFFF"), Array("l81|0|FFFFFF", "l82|100|FFFFFF"), Array("l82|0|FFFFFF", "l83|100|FFFFFF"), Array("l83|0|FFFFFF", "l84|100|FFFFFF"))
lSeqAttSlam.UpdateInterval = 280
lSeqAttSlam.Color = Null
lSeqAttSlam.Repeat = True

Dim lSeqAttCyber : Set lSeqAttCyber = New LCSeq
lSeqAttCyber.Name = "lSeqAttCyber"
lSeqAttCyber.Sequence = Array( Array("l29|0|FFFFFF", "l30|100|FFFFFF"), Array("l30|0|FFFFFF", "l31|100|FFFFFF"), Array("l31|0|FFFFFF", "l32|100|FFFFFF"), Array("l32|0|FFFFFF", "l33|100|FFFFFF"), Array("l33|0|FFFFFF", "l29|100|FFFFFF"))
lSeqAttCyber.UpdateInterval = 280
lSeqAttCyber.Color = Null
lSeqAttCyber.Repeat = True

Dim lSeqAttShots : Set lSeqAttShots = New LCSeq
lSeqAttShots.Name = "lSeqAttShots"
lSeqAttShots.Sequence = Array( Array("l63|0|FFFFFF", "l48|100|FFFFFF"), Array("l48|0|FFFFFF", "l46|100|FFFFFF"), Array("l46|0|FFFFFF", "l47|100|FFFFFF"), Array("l47|0|FFFFFF", "l23|100|FFFFFF"), Array("l23|0|FFFFFF", "l64|100|FFFFFF"), Array("l64|0|FFFFFF", "l63|100|FFFFFF"))
lSeqAttShots.UpdateInterval = 280
lSeqAttShots.Color = Null
lSeqAttShots.Repeat = True

Dim lSeqAttNodes : Set lSeqAttNodes = New LCSeq
lSeqAttNodes.Name = "lSeqAttNodes"
lSeqAttNodes.Sequence = Array( Array(), _
Array(), _
Array("l10|100|FFFFFF"), _
Array("l10|100|FFFFFF","l06|100|FFFFFF"), _
Array("l15|100|FFFFFF","l06|100|FFFFFF"), _
Array("l09|100|FFFFFF"), _
Array("l09|100|FFFFFF"), _
Array("l14|100|FFFFFF","l04|100|FFFFFF"), _
Array("l08|100|FFFFFF"), _
Array("l08|100|FFFFFF","l03|100|FFFFFF"), _
Array("l13|100|FFFFFF","l03|100|FFFFFF"), _
Array(), _
Array("l07|100|FFFFFF"), _
Array("l12|100|FFFFFF","l02|100|FFFFFF"), _
Array(), _
Array("l05|100|FFFFFF"), _
Array("l11|100|FFFFFF","l15|0|000000","l06|0|000000","l01|100|FFFFFF"), _
Array("l11|100|FFFFFF","l10|0|000000"), _
Array("l14|100|FFFFFF"), _
Array("l14|0|000000","l04|0|000000"), _
Array("l09|0|000000"), _
Array(), _
Array("l13|0|000000","l03|0|000000"), _
Array("l08|0|000000"), _
Array(), _
Array("l12|0|000000","l02|100|FFFFFF"), _
Array("l07|0|000000","l02|0|000000"), _
Array(), _
Array("l11|0|000000","l01|100|FFFFFF"), _
Array("l05|0|000000","l01|0|000000"), _
Array(), _
Array())
lSeqAttNodes.UpdateInterval = 20
lSeqAttNodes.Color = Null
lSeqAttNodes.Repeat = True

Dim lSeqAttHyper : Set lSeqAttHyper = New LCSeq
lSeqAttHyper.Name = "lSeqAttHyper"
lSeqAttHyper.Sequence = Array( Array(), _
Array(), _
Array(), _
Array("l37|100|FFFFFF"), _
Array("l37|100|FFFFFF"), _
Array(), _
Array(), _
Array(), _
Array("l38|100|FFFFFF"), _
Array("l38|100|FFFFFF","l37|100|FFFFFF"), _
Array("l37|0|000000"), _
Array(), _
Array(), _
Array("l39|100|FFFFFF"), _
Array("l38|100|FFFFFF"), _
Array("l38|0|000000"), _
Array(), _
Array("l40|100|FFFFFF"), _
Array("l40|100|FFFFFF"), _
Array("l39|0|000000"), _
Array(), _
Array(), _
Array("l41|100|FFFFFF"), _
Array("l41|100|FFFFFF","l40|100|FFFFFF"), _
Array("l40|0|000000"), _
Array(), _
Array(), _
Array(), _
Array("l41|100|FFFFFF"), _
Array("l41|0|000000"), _
Array(), _
Array(), _
Array(), _
Array(), _
Array("l41|100|FFFFFF"), _
Array("l41|100|FFFFFF"), _
Array(), _
Array(), _
Array(), _
Array("l40|100|FFFFFF"), _
Array("l41|100|FFFFFF","l40|100|FFFFFF"), _
Array("l41|0|000000"), _
Array(), _
Array(), _
Array("l39|100|FFFFFF"), _
Array("l40|100|FFFFFF"), _
Array("l40|0|000000"), _
Array(), _
Array("l38|100|FFFFFF"), _
Array("l38|100|FFFFFF"), _
Array("l39|0|000000"), _
Array(), _
Array(), _
Array("l37|100|FFFFFF"), _
Array("l38|100|FFFFFF","l37|100|FFFFFF"), _
Array("l38|0|000000"), _
Array(), _
Array(), _
Array(), _
Array("l37|100|FFFFFF"), _
Array("l37|0|000000"), _
Array(), _
Array())
lSeqAttHyper.UpdateInterval = 20
lSeqAttHyper.Color = Null
lSeqAttHyper.Repeat = True


Dim lSeqAttTT : Set lSeqAttTT = New LCSeq
lSeqAttTT.Name = "lSeqAttTT"
lSeqAttTT.Sequence = Array( Array(), _
Array(), _
Array(), _
Array("l91|100|FFFFFF"), _
Array("l90|100|FFFFFF"), _
Array(), _
Array("l92|100|FFFFFF"), _
Array("l92|100|FFFFFF"), _
Array(), _
Array("l95|100|FFFFFF"), _
Array("l93|100|FFFFFF"), _
Array("l91|0|000000"), _
Array("l95|100|FFFFFF"), _
Array("l92|0|000000","l95|0|000000"), _
Array("l90|0|000000"), _
Array(), _
Array(), _
Array(), _
Array(), _
Array("l93|0|000000"), _
Array())
lSeqAttTT.UpdateInterval = 180
lSeqAttTT.Color = Null
lSeqAttTT.Repeat = True

Dim lSeqAttCombo : Set lSeqAttCombo = New LCSeq
lSeqAttCombo.Name = "lSeqAttCombo"
lSeqAttCombo.Sequence = Array( Array(), _
Array(), _
Array(), _
Array(), _
Array("l24|100|FFFFFF"), _
Array("l25|100|FFFFFF","l24|100|FFFFFF"), _
Array("l24|100|FFFFFF"), _
Array("l24|0|000000"), _
Array(), _
Array("l26|100|FFFFFF"), _
Array(), _
Array("l26|100|FFFFFF"), _
Array("l27|100|FFFFFF","l26|0|000000"), _
Array("l27|100|FFFFFF"), _
Array("l27|0|000000","l25|0|000000","l24|100|FFFFFF"), _
Array("l24|0|000000"), _
Array(), _
Array("l28|100|FFFFFF","l27|100|FFFFFF","l26|100|FFFFFF"), _
Array("l26|100|FFFFFF"), _
Array("l28|0|000000","l27|100|FFFFFF"), _
Array("l27|0|000000","l26|100|FFFFFF"), _
Array("l26|0|000000"), _
Array("l28|100|FFFFFF","l27|100|FFFFFF"), _
Array("l27|100|FFFFFF"), _
Array(), _
Array("l28|0|000000","l27|0|000000"), _
Array(), _
Array(), _
Array("l28|100|FFFFFF"), _
Array(), _
Array("l28|0|000000"))
lSeqAttCombo.UpdateInterval = 180
lSeqAttCombo.Color = Null
lSeqAttCombo.Repeat = True

Dim lSeqAttBoost : Set lSeqAttBoost = New LCSeq
lSeqAttBoost.Name = "lSeqAttBoost"
lSeqAttBoost.Sequence = Array( Array(), _
Array("l59|100|FFFFFF"), _
Array(), _
Array("l49|100|FFFFFF","l59|0|000000"), _
Array(), _
Array("l49|0|000000"), _
Array("l60|100|FFFFFF"), _
Array(), _
Array("l60|0|000000"), _
Array("l35|100|FFFFFF"), _
Array(), _
Array("l35|0|000000"), _
Array(), _
Array(), _
Array(), _
Array("l61|100|FFFFFF"), _
Array("l61|100|FFFFFF"), _
Array("l61|0|000000"), _
Array())
lSeqAttBoost.UpdateInterval = 180
lSeqAttBoost.Color = Null
lSeqAttBoost.Repeat = True
