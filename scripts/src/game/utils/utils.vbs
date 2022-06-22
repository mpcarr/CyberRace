'***********************************************************************************************************************
'*****   Utilitiy Functions                                    	                                                    ****
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