'***********************************************************************************************************************
'*****  DOF    	                                                                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Class DOFClass

    Private m_b2sOn
    Private m_b2sAlt

    Public Property Let B2SOn(ByVal value)
        m_b2sOn = value
    End Property
    
    Public Property Get B2SOn
        B2SOn = m_b2sOn
    End Property

    Public Property Let B2SAlt(ByVal value)
        m_b2sAlt = value
    End Property
    
    Public Property Get B2SAlt
        B2SAlt = m_b2sAlt
    End Property

    Public Sub DOF(DOFevent, State)
        If m_b2sOn Then
            If State = 2 Then
                Controller.B2SSetData DOFevent, 1:Controller.B2SSetData DOFevent, 0
            Else
                Controller.B2SSetData DOFevent, State
            End If
        End If
    End Sub

    Public Sub DOFALT(DOFevent, State)
        If m_b2sAlt Then
            If State = 2 Then
                B2SController.B2SSetData DOFevent, 1:B2SController.B2SSetData DOFevent, 0
            Else
                B2SController.B2SSetData DOFevent, State
            End If
        End If
    End Sub

End Class


Dim myDOF
Set myDOF = new DOFClass

'***********************************************************************************************************************
