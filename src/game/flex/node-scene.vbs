

Sub InitDMDNodeScene()
    'Dim lbl1 : Set lbl1 = FlexDMD.NewLabel("lblCharge", font20Outline, "EMP CHARGING")
    'Dim lbl2 : Set lbl2 = FlexDMD.NewLabel("lblCharge2", font20Outline, "HITS REMAINING")
	'lbl1.SetAlignedPosition 128, 24, FlexDMD_Align_Center
    'lbl2.SetAlignedPosition 128, 42, FlexDMD_Align_Center
    DMDNodeScene.AddActor DMDNodeCollected
    'DMDNodeScene.AddActor lbl1
    'DMDNodeScene.AddActor lbl2
End Sub

Sub InitDMDNodePerkCollectScene()
    Dim lblLeftLine1 : Set lblLeftLine1 = FlexDMD.NewLabel("lblLeftLine1", font16, "")
    Dim lblLeftLine2 : Set lblLeftLine2 = FlexDMD.NewLabel("lblLeftLine2", font16, "")
    Dim lblRightLine1 : Set lblRightLine1 = FlexDMD.NewLabel("lblRightLine1", font16, "")
    Dim lblRightLine2 : Set lblRightLine2 = FlexDMD.NewLabel("lblRightLine2", font16, "")
    
	lblLeftLine1.SetAlignedPosition 69, 24, FlexDMD_Align_Center
    lblLeftLine2.SetAlignedPosition 69, 40, FlexDMD_Align_Center
    
    lblRightLine1.SetAlignedPosition 187, 24, FlexDMD_Align_Center
    lblRightLine2.SetAlignedPosition 187, 40, FlexDMD_Align_Center
    
    Dim border : Set border = FlexDMD.NewFrame("border")
    border.Thickness = 2
    border.SetBounds 0,0,256,64

    Dim leftBorder : Set leftBorder = FlexDMD.NewFrame("leftBorder")
    leftBorder.Thickness = 2
    leftBorder.SetBounds 20,10,98,44

    Dim rightBorder : Set rightBorder = FlexDMD.NewFrame("rightBorder")
    rightBorder.Thickness = 2
    rightBorder.SetBounds 138,10,98,44


    Dim lblLeftArrow : Set lblLeftArrow = FlexDMD.NewLabel("lblLeftArrow", font18, "<")
    Dim lblRightArrow : Set lblRightArrow = FlexDMD.NewLabel("lblRightArrow", font18, ">")
	lblLeftArrow.SetAlignedPosition 6, 64, FlexDMD_Align_BottomLeft
	lblRightArrow.SetAlignedPosition 250, 64, FlexDMD_Align_BottomRight
	
	Dim af
	Set af = lblLeftArrow.ActionFactory
	dim blinkLeft : Set blinkLeft = af.Sequence()
	blinkLeft.Add af.Show(False)
	blinkLeft.Add af.Wait(0.5)
	blinkLeft.Add af.Show(True)
	blinkLeft.Add af.Wait(0.5)
	lblLeftArrow.AddAction af.Repeat(blinkLeft, -1)

	Set af = lblRightArrow.ActionFactory
	dim blinkRight : Set blinkRight = af.Sequence()
	blinkRight.Add af.Show(True)
	blinkRight.Add af.Wait(0.5)
	blinkRight.Add af.Show(False)
	blinkRight.Add af.Wait(0.5)
	lblRightArrow.AddAction af.Repeat(blinkRight, -1)


    'DMDNodeScene.AddActor DMDNodeCollected
    DMDNodePerkCollectScene.AddActor border
    DMDNodePerkCollectScene.AddActor leftBorder
    DMDNodePerkCollectScene.AddActor rightBorder
    DMDNodePerkCollectScene.AddActor lblLeftArrow
    DMDNodePerkCollectScene.AddActor lblRightArrow
    DMDNodePerkCollectScene.AddActor lblLeftLine1
    DMDNodePerkCollectScene.AddActor lblLeftLine2
    DMDNodePerkCollectScene.AddActor lblRightLine1
    DMDNodePerkCollectScene.AddActor lblRightLine2
    
End Sub

Sub FlexDMDNodeScene()
    'SetPlayerState FLEX_MODE, 5
    
    DMDModeUpdate.Enabled = 0
    DMDModeUpdate.Enabled = 1
    DMDModeUpdate.Interval = DMDNodeCollected.Length*1000
    
    FlexPlayScene(DMDNodeScene)
	'dmdQ.Add "emp", "FlexPlayScene(DMDNodeScene)", 1, 0, 0, DMDChargeEMP.Length*1000, 0, False
End Sub

Sub FlexDMDNodePerkCollectScene()
  '  SetPlayerState FLEX_MODE, 6
    Dim lblLeftLine1 : Set lblLeftLine1 = DMDNodePerkCollectScene.GetLabel("lblLeftLine1")
    Dim lblLeftLine2 : Set lblLeftLine2 = DMDNodePerkCollectScene.GetLabel("lblLeftLine2")

    Dim lblRightLine1 : Set lblRightLine1 = DMDNodePerkCollectScene.GetLabel("lblRightLine1")
    Dim lblRightLine2 : Set lblRightLine2 = DMDNodePerkCollectScene.GetLabel("lblRightLine2")

    Select Case GetPlayerState(NODE_LEVEL):
        Case 2: 'Level 1.  Increase Jackpot 250K OR 5 Million
            lblLeftLine1.Text = "JACKPOT"
            lblLeftLine2.Text = "+250K"

            lblRightLine1.Text = "COLLECT"
            lblRightLine2.Text = "5 MIL"
        Case 3:'Level 2.  Race Timers + 20 Seconds OR 2x B.E.T Hurry Up
            lblLeftLine1.Text = "RACE TIMERS"
            lblLeftLine2.Text = "+20 Secs"

            lblRightLine1.Text = "COLLECT"
            lblRightLine2.Text = "5x BONUS"
        Case 4:'Level 3. Collect 5x Bonus OR Instant MB
            lblLeftLine1.Text = "OUTLANE"
            lblLeftLine2.Text = "BALL SAVES"

            lblRightLine1.Text = "INSTANT"
            lblRightLine2.Text = "MULTIBALL"
        Case 5:'Level 4. Extra Ball
            lblLeftLine1.Text = "EXTRA"
            lblLeftLine2.Text = "BALL"

            lblRightLine1.Text = "COLLECT"
            lblRightLine2.Text = "10x BONUS"
        Case 6:'Level 5. 5x Playfield (30 secs) OR 10x Bonus
            lblLeftLine1.Text = "PLAYFIELD"
            lblLeftLine2.Text = "5x (30 Secs)"

            lblRightLine1.Text = "SPOT"
            lblRightLine2.Text = "GRAND SLAM"
        End Select  

    DMDModeUpdate.Enabled = 0

    FlexPlayScene(DMDNodePerkCollectScene)
	'dmdQ.Add "emp", "FlexPlayScene(DMDNodeScene)", 1, 0, 0, DMDChargeEMP.Length*1000, 0, False
End Sub