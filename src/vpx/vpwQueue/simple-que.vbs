Class QueueItem
    Public Name
    Public Duration
    public Action
    public BGImage
    public BGVideo
    public Callback
    public Label1
    public Label2
    public Label3
    public Label4
    public Label5
    public Label6
    public Label7
    private LabelIdx

    Private Sub Class_Initialize()
        Callback = Null
        Label1 = Null
        Label2 = Null
        Label3 = Null
        Label4 = Null
        Label5 = Null
        Label6 = Null
        Label7 = Null
        LabelIdx = 1
        Action = ""
    End Sub

    Public Sub AddLabel(msg, font, sposX, sposY, eposX, eposY, action)
        If LabelIdx = 8 Then Exit Sub
        Dim params : params = Array(msg, font, sposX, sposY, eposX, eposY, action)
        Select Case LabelIdx
			Case 1:
                Label1 = params
            Case 2:
                Label2 = params
            Case 3:
                Label3 = params
            Case 4:
                Label4 = params
            Case 5:
                Label5 = params
            Case 6:
                Label6 = params
            Case 7:
                Label7 = params
        End Select
        LabelIdx = LabelIdx + 1
    End Sub

    Public Function GetLabel(idx)
       GetLabel = eval("Label"&idx)
       If typename(GetLabel) = "Empty" Then
          GetLabel = Null
       End If
    End Function
End Class

Class Queue
    Private Items
    Private CurrentItem
    Private PreviousItemExecutedTime
    private Frame
    private CurrentMSGdone
    private DMD_slide

    Private Sub Class_Initialize()
        Set Items = CreateObject("Scripting.Dictionary")
        Frame = 0
    End Sub

    Public Sub Enqueue(queueItem)
        'queueItem.Action = ""
        'queueItem.BGVideo = "novideo"
        If Items.Exists(queueItem.Name) Then
            Dim item : Set item = Items(queueItem.Name)
            item.Duration = queueItem.Duration
            item.Action = queueItem.Action
            item.callback = queueItem.Callback
            item.Label1 = queueItem.Label1
            item.Label2 = queueItem.Label2
            item.Label3 = queueItem.Label3
            item.Label4 = queueItem.Label4
            item.Label5 = queueItem.Label5
            item.Label6 = queueItem.Label6
            item.Label7 = queueItem.Label7
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

    Public Sub Dequeue(name)
        If Items.Exists(name) Then
            If IsObject(CurrentItem) Then
                If CurrentItem.Name = name Then
                    Items.Remove CurrentItem.Name
                    DMDResetAll()
                    CurrentItem = Null
                Else
                    Items.Remove name
                End If
            Else
                Items.Remove name
            End If
        End If
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
            Dim mItems : mItems = Items.Items()
            Set CurrentItem = mItems(0)
            PreviousItemExecutedTime = gameTime
            If Not IsNull(CurrentItem.Callback) Then
                ExecuteGlobal CurrentItem.Callback
            End If
            DMDResetAll
            DMDNewOverlay
        End If
            
    End Sub

    Public Sub DMDUpdate

        dim tmp, flabel
        if CurrentItem.Action = "slidedown" Then
            If DMD_Slide > 0 Then DMD_slide = DMD_slide - 2
        End If
        if CurrentItem.Action = "slideup" Then
            If DMD_Slide < 0 Then DMD_slide = DMD_slide + 2
        End If

        If CurrentItem.BGImage <> "noimage"  Then FlexDMD.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
        If CurrentItem.BGVideo <> "novideo" Then FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide

        Dim i
         For i = 1 to 7
             
             dim label : label = CurrentItem.GetLabel(i)
            If Not IsNull(label) Then

                Set flabel = FlexDMD.Stage.GetLabel("TextSmalLine" & CStr(i))
                flabel.Font = label(1)
                flabel.visible = True
                If InStr(1, label(0), "GetPlayerState") > 0 Then
                    flabel.Text = Eval(label(0))
                Else
                    flabel.Text = label(0)
                End If

                If label(6) = "blink" Then ' blinking
                    If frame mod 30 > 15 Then
                        flabel.visible = False
                    Else
                        flabel.visible = True
                    End If
                End If

                If label(2) < label(4) Then label(2) = label(2) + 1
                If label(2) > label(4) Then label(2) = label(2) - 1
                If label(3) < label(5) Then label(3) = label(3) + 1
                If label(3) > label(5) Then label(3) = label(3) - 1
                

                Select Case i
                    Case 1:
                        CurrentItem.Label1(2) = label(2)
                        CurrentItem.Label1(3) = label(3)
                    Case 2:
                        CurrentItem.Label2(2) = label(2)
                        CurrentItem.Label2(3) = label(3)
                    Case 3:
                        CurrentItem.Label3(2) = label(2)
                        CurrentItem.Label3(3) = label(3)
                    Case 4:
                        CurrentItem.Label4(2) = label(2)
                        CurrentItem.Label4(3) = label(3)
                    Case 5:
                        CurrentItem.Label5(2) = label(2)
                        CurrentItem.Label5(3) = label(3)
                    Case 6:
                        CurrentItem.Label6(2) = label(2)
                        CurrentItem.Label6(3) = label(3)
                    Case 7:
                        CurrentItem.Label7(2) = label(2)
                        CurrentItem.Label7(3) = label(3)                        
                End Select

                flabel.SetAlignedPosition label(2),label(3) - DMD_slide ,FlexDMD_Align_Center
                '

            End If
       Next

    End Sub

    Sub DMDNewOverlay
        CurrentMSGdone = 1 ' to get it off screen
        Dim flabel
        DMD_slide = 0

        if CurrentItem.Action = "slidedown" Then DMD_slide = DMDHeight
        if CurrentItem.Action = "slideup" Then DMD_slide = -DMDHeight

        If CurrentItem.BGImage  <> "noimage" Then FlexDMD.Stage.GetImage(CurrentItem.BGImage).Visible=True : FlexDMD.Stage.GetImage(CurrentItem.BGImage).SetPosition 0, - DMD_slide
        If CurrentItem.BGVideo <> "novideo" Then FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).Visible=True : FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).SetPosition 0, - DMD_slide * 1.5 : FlexDMD.Stage.GetVideo(CurrentItem.BGVideo).Seek(0)
        
        Dim i
        For i = 1 to 7
            
            dim label : label = CurrentItem.GetLabel(i)
            If Not IsNull(label) Then

                Set flabel = FlexDMD.Stage.GetLabel("TextSmalLine" & CStr(i))
                flabel.Font = label(1)
                If InStr(1, label(0), "GetPlayerState") > 0 Then
                    flabel.Text = Eval(label(0))
                Else
                    flabel.Text = label(0)
                End If

                flabel.SetAlignedPosition label(2),label(3) - DMD_slide ,FlexDMD_Align_Center
                flabel.visible = True

            End If
        Next
     
    End Sub

    Sub DMDSlideOff
        If CurrentItem.Action = "" Then CurrentMSGdone = 0
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
		
        FlexDMD.Stage.GetImage("BGBlack").Visible=False 
		FlexDMD.Stage.GetImage("BG001").Visible=False
        FlexDMD.Stage.GetImage("BG002").Visible=False 
        FlexDMD.Stage.GetImage("BG003").Visible=False 
        FlexDMD.Stage.GetImage("BG004").Visible=False 
        FlexDMD.Stage.GetImage("BG005").Visible=False 
        FlexDMD.Stage.GetVideo("BGBoost").Visible=False

        FlexDMD.Stage.GetVideo("BGBetMode").Visible=False
        FlexDMD.Stage.GetVideo("BGBoost").Visible=False
        FlexDMD.Stage.GetVideo("BGCyber").Visible=False
        FlexDMD.Stage.GetVideo("BGEmp").Visible=False
        FlexDMD.Stage.GetVideo("BGNodes").Visible=False
        FlexDMD.Stage.GetVideo("BGSkills").Visible=False

        FlexDMD.Stage.GetVideo("BGEngine").Visible=False
        FlexDMD.Stage.GetVideo("BGCooling").Visible=False
        FlexDMD.Stage.GetVideo("BGFuel").Visible=False

        FlexDMD.Stage.GetVideo("BGNode").Visible=False
        FlexDMD.Stage.GetVideo("BGNodeComplete").Visible=False

        
        FlexDMD.Stage.GetVideo("BGRace1").Visible=False
        FlexDMD.Stage.GetVideo("BGRace2").Visible=False
        FlexDMD.Stage.GetVideo("BGRace3").Visible=False
        FlexDMD.Stage.GetVideo("BGRace4").Visible=False
        FlexDMD.Stage.GetVideo("BGRaceLocked").Visible=False

        FlexDMD.Stage.GetVideo("BGBonus1").Visible=False
        FlexDMD.Stage.GetVideo("BGBonus2").Visible=False
        FlexDMD.Stage.GetVideo("BGBonus3").Visible=False
        FlexDMD.Stage.GetVideo("BGBonus4").Visible=False
        FlexDMD.Stage.GetVideo("BGBonus5").Visible=False
        
        FlexDMD.Stage.GetVideo("BGJackpot").Visible=False

		FlexDMD.Stage.GetLabel("TextSmalLine1").Visible=False
		FlexDMD.Stage.GetLabel("TextSmalLine2").Visible=False
		FlexDMD.Stage.GetLabel("TextSmalLine3").Visible=False
		FlexDMD.Stage.GetLabel("TextSmalLine4").Visible=False
        FlexDMD.Stage.GetLabel("TextSmalLine5").Visible=False
        FlexDMD.Stage.GetLabel("TextSmalLine6").Visible=False
        FlexDMD.Stage.GetLabel("TextSmalLine7").Visible=False
    End Sub


End Class
