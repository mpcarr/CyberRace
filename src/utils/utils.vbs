'***********************************************************************************************************************
'*****   Utility Functions                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Function Min(value, minVal)
	if value < minVal then
		Min=Value
	Else 
		Min=minVal
	End If 
End Function

Function FormatScore2(ByVal Num) 'it returns a string with commas
    dim i
    dim NumString

    NumString = CStr(abs(Num))

	If NumString = "0" Then
		NumString = "00"
	Else
		For i = Len(NumString)-3 to 1 step -3
			if IsNumeric(mid(NumString, i, 1))then
				NumString = left(NumString, i) & "," & right(NumString, Len(NumString)-i)
			end if
		Next
	End If
    FormatScore2 = NumString
End function

Function BallsOnBridge()
	Dim lockPinsUp : lockPinsUp = 0
    If LockPin1.IsDropped = 0 Then
        lockPinsUp=lockPinsUp+1
    End If
    If LockPin2.IsDropped = 0 Then
        lockPinsUp=lockPinsUp+1
    End If
	BallsOnBridge = lockPinsUp
End Function

Function RealBallsInPlay()
	RealBallsInPlay = (5-BallsInTrough) - BallsOnBridge()
End Function

Function FlattenArrays(arrays)
    Dim resultArray()
    Dim i, j, totalSize
    totalSize = 0

    ' Calculate total size for the resultant array
    For i = 0 To UBound(arrays)
        totalSize = totalSize + UBound(arrays(i)) - LBound(arrays(i)) + 1
    Next

    ' Resize the resultant array
    ReDim resultArray(totalSize - 1)

    Dim currentIndex
    currentIndex = 0

    ' Iterate over each array and copy its elements to the resultArray
    For i = 0 To UBound(arrays)
        For j = LBound(arrays(i)) To UBound(arrays(i))
            resultArray(currentIndex) = arrays(i)(j)
            currentIndex = currentIndex + 1
        Next
    Next

    FlattenArrays = resultArray
End Function