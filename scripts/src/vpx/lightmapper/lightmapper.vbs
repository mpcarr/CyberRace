
Sub InitLightMapperElements
    Dim p
    If useLightMapper = True Then
        PinCab_Blades.Visible = False
        PinCab_Rails.Visible = False
        p_rightramp.Visible = False
        for each p in inserts
            p.Visible = False  
        next
        for each p in GI
            p.Visible = False  
        next
    Else    
        PinCab_Blades.Visible = True
        PinCab_Rails.Visible = True
        p_rightramp.Visible = True
        for each p in inserts
            p.Visible = True
        next
        for each p in GI
            p.Visible = True
        next
    End If
End Sub