
Dim json
'json = ObjectToString(WScript.Arguments(0))
MsgBox("here")

Function ObjectToString(o)
    Dim k
    Dim s
    s = "{"
    If(HasKeys(o)) Then
        For Each k in o.Keys()
            If IsObject(o(k)) Then
                s = s & " """ & k & """: " & ObjectToString(o(k))
            Else 
                If IsArray(o(k)) Then
                    s = s & " """ & k & """: " & ArrayToString(o(k))
                Else
                    s = s & " """ & k & """: """ & o(k) & ""","
                End If
            End If
        Next
        s = Left(s, Len(s) - 1) 
    Else

        Dim tableProps
        tableProps = TableItemProperties(o)
        
        If IsArray(tableProps) Then
            Dim prop
            Dim itemCount
            itemCount = UBound(tableProps)
            s = s & " """ & o.Name & """: {"
            s = s & " ""Type"": """ & TypeName(o) & ""","
            For Each prop in tableProps
                Dim pv
                pv = PropertyValue(o,prop)
                s = s & pv & ","
            Next
            s = Left(s, Len(s) - 1) 
            s = s & "}"
        Else
            s = s & " """ & o.Name & """: """ & TypeName(o) & """"
        End If
    End If
    s = s & " },"
    ObjectToString = s
End Function

Function ArrayToString(a)

    Dim s
    Dim item
    s = "[ "

    For Each item in a
        If IsObject(item) Then
            s = s & ObjectToString(item)
        Else
            If IsArray(item) Then
                s = s & ArrayToString(item) & ","
            Else
                s = s & """" & item & """" & ","
            End If
        End If
    Next
    s = Left(s, Len(s) - 1) 
    s = s & " ],"
    

    ArrayToString = s
End Function

Function PropertyValue(o,p)

    Dim pv
    Dim s

    Select Case p(1)
        Case "BSTR"
            Execute "pv = " & o.Name & "." & p(0)
            s = " """ & p(0) & """:" & """" & pv & """"
        Case "float"
            Execute "pv = " & o.Name & "." & p(0)
            s = " """ & p(0) & """:" & pv
        Case "long"
            Execute "pv = " & o.Name & "." & p(0)
            s = " """ & p(0) & """:" & pv
        Case "LightState"
            Execute "pv = " & o.Name & "." & p(0)
            s = " """ & p(0) & """:" & pv
        Case "VARIANT_BOOL"
            Execute "pv = " & o.Name & "." & p(0)
            s = " """ & p(0) & """:" & LCase(CStr(pv))
        Case "OLE_COLOR"
            Execute "pv = " & o.Name & "." & p(0)
            s = " """ & p(0) & """:" & """" & TranslateOleColor(pv) & """"
        Case Else
            s = " """ & p(0) & """: " & """" & """"
    End Select


    PropertyValue = s
End Function

Function HasKeys(o)
    Dim Success
    Success = False

    On Error Resume Next
        ' set for property here
        
        o.Keys()

        Success = (Err.Number = 0)
    On Error Goto 0
    HasKeys = Success
End Function   

Function TableItemProperties(o)

    Dim properties
    properties = -1

    Select Case TypeName(o)
        Case "Light"
            properties = Array(Array("Falloff", "float"),Array("FalloffPower", "float"),Array("State", "LightState"),Array("Color", "OLE_COLOR"),Array("ColorFull", "OLE_COLOR"),Array("TimerEnabled", "VARIANT_BOOL"),Array("TimerInterval", "long"),Array("X", "float"),Array("Y", "float"),Array("BlinkPattern", "BSTR"),Array("BlinkInterval", "long"),Array("Intensity", "float"),Array("TransmissionScale", "float"),Array("IntensityScale", "float"),Array("Surface", "BSTR"),Array("Name", "BSTR"),Array("UserValue", "VARIANT*"),Array("Image", "BSTR"),Array("ImageMode", "VARIANT_BOOL"),Array("DepthBias", "float"),Array("FadeSpeedUp", "float"),Array("FadeSpeedDown", "float"),Array("Bulb", "VARIANT_BOOL"),Array("ShowBulbMesh", "VARIANT_BOOL"),Array("StaticBulbMesh", "VARIANT_BOOL"),Array("ShowReflectionOnBall", "VARIANT_BOOL"),Array("ScaleBulbMesh", "float"),Array("BulbModulateVsAdd", "float"),Array("BulbHaloHeight", "float"),Array("Visible", "VARIANT_BOOL"))
    End Select


    TableItemProperties = properties

End Function

Function TranslateOleColor(c)

    Dim hexV, r, g, b, colorHex
    hexV = Right("000000" & Hex(c), 6)
    r = Left(hexV, 2)
    g = Mid(hexV, 3,2)
    b = Right(hexV, 2)
    colorHex = "#" & r & g & b

    TranslateOleColor = colorHex
End Function