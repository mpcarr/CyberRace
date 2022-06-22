
'***********************************************************************************************************************
'*****  Light Seq Item Class                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightSeqItem
	
	Private m_currentIdx, m_sequence, m_name, m_image, m_lampColor,m_updateInterval, m_Frames

        Public Property Get CurrentIdx()
                CurrentIdx=m_currentIdx
        End Property

        Public Property Let CurrentIdx(input)
		m_currentIdx = input
	End Property

        Public Property Get Sequence()
                Sequence=m_sequence
        End Property
        
	Public Property Let Sequence(input)
		m_sequence = input
	End Property

        Public Property Get LampColor()
                LampColor=m_lampColor
        End Property
        
	Public Property Let LampColor(input)
		m_lampColor = input
	End Property

        Public Property Get Image()
                Image=m_image
        End Property
        
	Public Property Let Image(input)
		m_image = input
	End Property

        Public Property Get Name()
                Name=m_name
        End Property
        
	Public Property Let Name(input)
		m_name = input
	End Property        

        Public Property Get UpdateInterval()
                UpdateInterval=m_updateInterval
        End Property

        Public Property Let UpdateInterval(input)
		m_updateInterval = input
	End Property

        Private Sub Class_Initialize()
                m_currentIdx = 0
                m_image = Null
                m_lampColor = Null
                m_updateInterval = 100
        End Sub

        Public Property Get Update(framesPassed)
                m_Frames = m_Frames - framesPassed
                Update = m_Frames
        End Property

        Public Sub ResetFrames()
                m_Frames = m_updateInterval
        End Sub

End Class