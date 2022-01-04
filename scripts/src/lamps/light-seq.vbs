
'***********************************************************************************************************************
'*****  Light Seq Class                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightSeq
	
	Private m_repeat, m_name, m_items,m_currentItemIdx,m_resetSequence

        Public Property Get Repeat()
                Repeat=m_repeat
        End Property

        Public Property Let Repeat(input)
		m_repeat = input
	End Property

        Public Property Get Name()
                Name=m_name
        End Property

        Public Property Get Items()
                Items=m_items.Items
        End Property
        
	Public Property Let Name(input)
		m_name = input
	End Property

        Public Property Get ResetSequence()
                ResetSequence=m_resetSequence
        End Property
        
	Public Property Let ResetSequence(input)
		Set m_resetSequence = input
	End Property

        Public Property Get CurrentItem()
                Dim items: items = m_items.Items()
                If UBound(items) = -1 Then       
                        CurrentItem  = Null
                Else
                        Set CurrentItem = items(m_currentItemIdx)                
                End If
	End Property

        Private Sub Class_Initialize()
                m_repeat = 0
                Set m_items = CreateObject("Scripting.Dictionary")
                m_currentItemIdx = 0
                m_resetSequence = Null
        End Sub

        Public Sub AddItem(item)
                If Not IsNull(item) Then
                        If Not m_items.Exists(item.Name) Then
                                m_items.Add item.Name, item
                        End If
                End If
        End Sub

        Public Sub RemoveAll()
                Dim x
                For Each x in items
                        RemoveItem(x)
                Next
        End Sub

        Public Sub RemoveItem(item)
                If Not IsNull(item) Then
                        If m_items.Exists(item.Name) Then
                                m_items.Remove item.Name
                                'DebugOut(item.Name)
                                Dim x
                                For Each x in item.Sequence
                                        If IsArray(x) Then
                                                Dim xx
                                                For Each xx in x
                                                        'DebugOut("Resetting IDX: " & xx.Idx)
                                                        Lampz.state(xx.Idx) = 0
                                                        Lampz.image(xx.Idx) = "pal_purple"
                                                        xx.Image = xx.BaseImage
                                                Next
                                        Else
                                                'DebugOut("Resetting IDX: " & x.Idx)
                                                Lampz.state(x.Idx) = 0
                                                Lampz.image(x.Idx) = "pal_purple"
                                                x.Image = x.BaseImage
                                        End If
                                Next
                        End If
                End If
        End Sub

        Public Sub NextItem()
                m_currentItemIdx = m_currentItemIdx + 1
                Dim items: items = m_items.Items
                If UBound(items) <= m_currentItemIdx Then
                        If Not IsNull(m_resetSequence) Then
                              AddItem(m_resetSequence)  
                              m_resetSequence = Null
                        Else
                                m_currentItemIdx = 0
                                
                                If m_repeat = 0 Then
                                        Dim x
                                        For Each x in items
                                                RemoveItem(x)
                                        Next
                                        m_items.RemoveAll
                                End If
                        End If
                End If
        End Sub

End Class