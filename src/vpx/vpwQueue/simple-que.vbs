Class QueueItem
    Public Name
    Public Duration
    Public Title
    Public Message
    Public Font
    Public MessageFont
    public StartPos
    public EndPos
    public Action
    public BGImage
    public BGVideo
    public Callback

    Private Sub Class_Initialize()
        Callback = Null
        MessageFont = Null
    End Sub
End Class

Class Queue
    Private Items
    Private CurrentItem
    Private PreviousItemExecutedTime
    private Frame
    private CurrentMSGdone
    private DMD_ShakePos
    private DMD_slide

    Private Sub Class_Initialize()
        Set Items = CreateObject("Scripting.Dictionary")
        Frame = 0
    End Sub

    Public Sub Enqueue(queueItem)

        If IsNull(queueItem.MessageFont) Then 
            queueItem.MessageFont = queueItem.Font
        End If
        If Items.Exists(queueItem.Name) Then
            Dim item : Set item = Items(queueItem.Name)
            item.Duration = queueItem.Duration
            item.Title = queueItem.Title
            item.Message = queueItem.Message
            item.Font = queueItem.Font
            item.MessageFont = queueItem.MessageFont
            item.StartPos = queueItem.StartPos
            item.EndPos = queueItem.EndPos
            item.Action = queueItem.Action
            item.callback = queueItem.Callback
            If IsObject(CurrentItem) Then
				If item.Name = CurrentItem.Name Then
					If CurrentItem.BGImage <> "noimage"  Then FlexDMD.Stage.GetImage(CurrentItem.BGImage).Visible = False
					If CurrentItem.BGVideo <> "novideo" Then FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).Visible = False
					item.BGImage = queueItem.BGImage
					item.BGVideo = queueItem.BGVideo
					If CurrentItem.BGImage  <> "noimage" Then FlexDMD.Stage.GetImage(CurrentItem.BGImage).Visible=True : FlexDMD.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
					If CurrentItem.BGVideo <> "novideo" Then FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).Visible=True : FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide
				End If
            Else
                item.BGImage = queueItem.BGImage
                item.BGVideo = queueItem.BGVideo
            End If
        Else
            Items.Add queueItem.Name, queueItem
        End If
    End Sub

    Public Function GetCurrentItem()
        GetCurrentItem = CurrentItem
    End Function

    Public Sub RemoveAll()
        DMDResetAll()
        Items.RemoveAll()
        CurrentItem = Null
    End Sub

    Public Sub Update()

        frame=frame+1
        If IsObject(CurrentItem) Then
            If gameTime >= (PreviousItemExecutedTime+(CurrentItem.Duration*1000)) Then
                DMDSlideOff
            Else
                DMDUpdate
            End If
        End If

        If Not IsObject(CurrentItem) And Items.Count > 0 Then
            Set CurrentItem = Items.Items()(0)
            PreviousItemExecutedTime = gameTime
            If Not IsNull(CurrentItem.Callback) Then
                ExecuteGlobal CurrentItem.Callback
            End If
            DMDResetAll
            DMDNewOverlay
        End If
            
    End Sub

    Public Sub DMDUpdate

        dim tmp
        If DMD_Slide > 0 Then DMD_slide = DMD_slide - 2
        If frame mod 3 = 1 Then
            If CurrentItem.Action = "shake" And Not DMD_ShakePos = 0 Then ' shaking
                If DMD_ShakePos < 0 Then DMD_ShakePos = ABS(DMD_ShakePos) - 1 Else DMD_ShakePos = - DMD_ShakePos + 1
            End If
        End If
        If CurrentItem.Action = "blink" or CurrentItem.Action = "noslide2blink" or CurrentItem.Action = "noslideoffblink" Then ' blinking
            If frame mod 30 > 15 Then
                FlexDMD.Stage.GetLabel("TextSmalLine1").visible = False
                If Not CurrentItem.Message = "" Then  FlexDMD.Stage.GetLabel("TextSmalLine2").visible = False
            Else
                FlexDMD.Stage.GetLabel("TextSmalLine1").visible = True
                If Not CurrentItem.Message = "" Then  FlexDMD.Stage.GetLabel("TextSmalLine2").visible = True
            End If
        End If
        'Marque
        If CurrentItem.StartPos(0) < CurrentItem.EndPos(0) Then CurrentItem.StartPos(0) = CurrentItem.StartPos(0) + 2
        If CurrentItem.StartPos(0) > CurrentItem.EndPos(0) Then CurrentItem.StartPos(0) = CurrentItem.StartPos(0) - 2
        If CurrentItem.StartPos(1) < CurrentItem.EndPos(1) Then CurrentItem.StartPos(1) = CurrentItem.StartPos(1) + 2
        If CurrentItem.StartPos(1) > CurrentItem.EndPos(1) Then CurrentItem.StartPos(1) = CurrentItem.StartPos(1) - 2
        'Shake

    
        If CurrentItem.BGImage <> "noimage"  Then FlexDMD.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
        If CurrentItem.BGVideo <> "novideo" Then FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide

        Set label = FlexDMD.Stage.GetLabel("TextSmalLine1")
        label.Font =  CurrentItem.Font
        If InStr(1, CurrentItem.Title, "GetPlayerState") > 0 Then
            label.Text = Eval(CurrentItem.Title)
        Else
            label.Text = CurrentItem.Title
        End If

        Set label = FlexDMD.Stage.GetLabel("TextSmalLine2")
        label.Font =  CurrentItem.MessageFont
        If InStr(1,  CurrentItem.Message, "GetPlayerState") > 0 Then
            label.Text = Eval(CurrentItem.Message)
        End If

        If CurrentItem.Message = "" Then
            FlexDMD.Stage.GetLabel("TextSmalLine1").SetAlignedPosition CurrentItem.StartPos(0) + DMD_ShakePos ,CurrentItem.StartPos(1) - DMD_Slide , FlexDMD_Align_Center
        Elseif Not CurrentItem.Message = "" Then
            FlexDMD.Stage.GetLabel("TextSmalLine1").SetAlignedPosition CurrentItem.StartPos(0) + DMD_ShakePos ,CurrentItem.StartPos(1)-8 - DMD_Slide , FlexDMD_Align_Center
            FlexDMD.Stage.GetLabel("TextSmalLine2").SetAlignedPosition CurrentItem.StartPos(0) + DMD_ShakePos ,CurrentItem.StartPos(1)+8 - DMD_Slide , FlexDMD_Align_Center
        End If

    End Sub

    Sub DMDNewOverlay
        CurrentMSGdone = 1 ' to get it off screen
        Dim label
        DMD_ShakePos = 0 
        DMD_slide = DMDHeight	

        if CurrentItem.Action = "noslide2" or CurrentItem.Action = "noslide3" Then DMD_slide = 0
        if CurrentItem.Action = "noslide2blink" Then DMD_slide = 0

        If CurrentItem.BGImage  <> "noimage" Then FlexDMD.Stage.GetImage(CurrentItem.BGImage).Visible=True : FlexDMD.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
        If CurrentItem.BGVideo <> "novideo" Then FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).Visible=True : FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide * 1.5 : FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).Seek(0)
        If CurrentItem.Message = "" Then
            Set label = FlexDMD.Stage.GetLabel("TextSmalLine1")
            label.Font =  CurrentItem.Font
            If InStr(1, CurrentItem.Title, "GetPlayerState") > 0 Then
                label.Text = Eval(CurrentItem.Title)
            Else
                label.Text = CurrentItem.Title
            End If

            label.SetAlignedPosition CurrentItem.StartPos(0),CurrentItem.StartPos(1) - DMD_slide ,FlexDMD_Align_Center
            label.visible = True
        End If
        If Not CurrentItem.Message = "" Then

            Set label = FlexDMD.Stage.GetLabel("TextSmalLine1")
            label.Font =  CurrentItem.Font
            If InStr(1, CurrentItem.Title, "GetPlayerState") > 0 Then
                label.Text = Eval(CurrentItem.Title)
            Else
                label.Text = CurrentItem.Title
            End If
            label.SetAlignedPosition CurrentItem.StartPos(0),CurrentItem.StartPos(1)-8 - DMD_slide ,FlexDMD_Align_Center
            label.visible = True

            Set label = FlexDMD.Stage.GetLabel("TextSmalLine2")
            label.Font =  CurrentItem.MessageFont
            If InStr(1, CurrentItem.Message, "GetPlayerState") > 0 Then
                label.Text = Eval(CurrentItem.Message)
            Else
                label.Text = CurrentItem.Message
            End If
            label.SetAlignedPosition CurrentItem.StartPos(0),CurrentItem.StartPos(1)+8 - DMD_slide ,FlexDMD_Align_Center
            label.visible = True
        End If
    End Sub

    Sub DMDSlideOff
        if  CurrentItem.Action = "noslide" Or  CurrentItem.Action = "noslide2" Or  CurrentItem.Action = "noslideoff" Or  CurrentItem.Action = "noslideoffblink" Then CurrentMSGdone = 0
        If CurrentMSGdone > 0 Then
            DMD_Slide = DMD_Slide - 3 
            If DMD_Slide < -DMDHeight Then CurrentMSGdone = 0
            DMDUpdate()
        Else
            Items.Remove CurrentItem.Name
            DMDResetAll()
            CurrentItem = Null
        End If
    End Sub

    Public Sub DMDResetAll
		
		FlexDMD.Stage.GetImage("BG001").Visible=False   ' need all of them
		FlexDMD.Stage.GetImage("BGEMP").Visible=False
		FlexDMD.Stage.GetImage("BGRaceReady").Visible=False
        FlexDMD.Stage.GetVideo("BGBoost").Visible=False
        FlexDMD.Stage.GetVideo("BGCyber").Visible=False


        FlexDMD.Stage.GetVideo("BGEngine").Visible=False
        FlexDMD.Stage.GetVideo("BGCooling").Visible=False
        FlexDMD.Stage.GetVideo("BGFuel").Visible=False
        FlexDMD.Stage.GetVideo("BGNode1").Visible=False
        FlexDMD.Stage.GetVideo("BGNode2").Visible=False
        FlexDMD.Stage.GetVideo("BGNode3").Visible=False
        FlexDMD.Stage.GetVideo("BGNode4").Visible=False
        FlexDMD.Stage.GetVideo("BGNode5").Visible=False
        FlexDMD.Stage.GetVideo("BGNodeComplete").Visible=False

        FlexDMD.Stage.GetVideo("BGRace1").Visible=False
        FlexDMD.Stage.GetVideo("BGRace2").Visible=False
        FlexDMD.Stage.GetVideo("BGRace3").Visible=False
        FlexDMD.Stage.GetVideo("BGRace4").Visible=False
        FlexDMD.Stage.GetVideo("BGRaceLocked").Visible=False

		FlexDMD.Stage.GetLabel("TextSmalLine1").Visible=False
		FlexDMD.Stage.GetLabel("TextSmalLine2").Visible=False
		FlexDMD.Stage.GetLabel("TextSmalLine3").Visible=False
		FlexDMD.Stage.GetLabel("TextSmalLine4").Visible=False
    End Sub


End Class
