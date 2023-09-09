

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
    
End Sub

Sub FlexDMDNodesCompleteScene()
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nodes-complete"
        .Duration = 2
        .BGImage = "noimage"
        .BGVideo = "BGNodes"
    End With
    qItem.AddLabel "NODES", 		Font12, DMDWidth*.75, DMDHeight*.25, DMDWidth*.75, DMDHeight*.25, "blink"
    qItem.AddLabel "COMPLETE", 		Font12, DMDWidth*.75, DMDHeight*.75, DMDWidth*.75, DMDHeight*.75, "blink"
    DmdQ.Enqueue qItem
End Sub

Sub FlexDMDNodePerkCollectScene()
    DmdQ.RemoveAll()
    Dim perkLeftTitle,perkLeftDesc,perkRightTitle,perkRightDesc
    Select Case GetPlayerState(NODE_LEVEL):
        Case 2: 
            perkLeftTitle = "JACKPOTS"
            perkLeftDesc = "+250K"
            perkRightTitle = "COLLECT"
            perkRightDesc = "5 MIL"
        Case 3: 
            perkLeftTitle = "RACE"
            perkLeftDesc = "+20 SECS"
            perkRightTitle = "2X BET"
            perkRightDesc = "HURRY UP"
        Case 4: 
            perkLeftTitle = "OUTLANE"
            perkLeftDesc = "SAVES"
            perkRightTitle = "INSTANT"
            perkRightDesc = "MULTIBALL"
        Case 5: 
            perkLeftTitle = "EXTRA"
            perkLeftDesc = "BALL"
            perkRightTitle = "JACKPOTS"
            perkRightDesc = "5X"
        Case 6: 
            perkLeftTitle = "SPOT"
            perkLeftDesc = "G/SLAM"
            perkRightTitle = "MINI"
            perkRightDesc = "WIZARD"
    End Select  
    Dim qItem : Set qItem = New QueueItem
    With qItem
        .Name = "nodes"
        .Duration = 15
        .BGImage = "BGBlack"
        .BGVideo = "BGNode"
        .Callback = "GameTimers(GAME_SELECTION_TIMER_IDX) = 15"
    End With
    qItem.AddLabel perkLeftTitle, 		    font7, DMDWidth*.2, DMDHeight*.35, DMDWidth*.2, DMDHeight*.35, ""
    qItem.AddLabel perkLeftDesc, 		    font7, DMDWidth*.2, DMDHeight*.65, DMDWidth*.2, DMDHeight*.65, ""

    qItem.AddLabel perkRightTitle, 		    font7, DMDWidth*.8, DMDHeight*.35, DMDWidth*.8, DMDHeight*.35, ""
    qItem.AddLabel perkRightDesc, 		    font7, DMDWidth*.8, DMDHeight*.65, DMDWidth*.8, DMDHeight*.65, ""

    qItem.AddLabel "<", font7, DMDWidth*.4, DMDHeight*.9, DMDWidth*.4, DMDHeight*.9, "blink"
    qItem.AddLabel ">", font7, DMDWidth*.6, DMDHeight*.9, DMDWidth*.6, DMDHeight*.9, "blink"
    qItem.AddLabel "GetPlayerState(EMPTY_STR) & Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10) & """" & Int(GameTimers(GAME_SELECTION_TIMER_IDX)-Int(GameTimers(GAME_SELECTION_TIMER_IDX)/10)*10)", 		Font7, DMDWidth/2, DMDHeight*.8, DMDWidth/2, DMDHeight*.8, ""
    DmdQ.Enqueue qItem
   
End Sub