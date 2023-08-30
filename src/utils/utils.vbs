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

Function RndNum(min,max)
	RndNum = Int(Rnd()*(max-min+1))+min     ' Sets a random number between min AND max
End Function

Function FormatScore(ByVal Num) 'it returns a string with commas
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
    FormatScore = NumString
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