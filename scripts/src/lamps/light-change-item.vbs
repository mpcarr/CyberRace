
'***********************************************************************************************************************
'*****  Light Change Item Class                               	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************
Class LightChangeItem
	
	Private m_Frames, m_Idx, m_State, m_initialFrames,m_lampColor,m_image,m_baseImage

        Public Property Get Idx()
                Idx=m_Idx
        End Property

        Public Property Get BaseImage()
                BaseImage=m_baseImage
        End Property

        Public Property Get Image()
                Image=m_image
        End Property
        
	Public Property Let Image(input)
		m_image = input
	End Property

        Public Property Get State()
                State=m_State
        End Property

        Public Property Let State(input)
		m_State = input
	End Property

        Public Sub Blink()
                If m_State = 1 Then
                        m_State = 0
                        m_Frames = m_initialFrames
                Else
                        m_State = 1
                        m_Frames = m_initialFrames
                End If
	End Sub

        Public Sub Init(idx, state, frames, baseImage)
                m_Idx = idx
                m_State = state
                m_Frames = frames
                m_initialFrames = frames
                m_lampColor = Null
                m_image = baseImage
                m_baseImage = baseImage                
	End Sub

	Public Property Let lampColor(input)
		m_lampColor = input
	End Property

        Public Property Get lampColor()
		lampColor = m_lampColor
	End Property

	Public Property Get Update(framesPassed)
                m_Frames = m_Frames - framesPassed
                Update = m_Frames
        End Property

        Public Sub ResetFrames()
                m_Frames = m_initialFrames
        End Sub

End Class