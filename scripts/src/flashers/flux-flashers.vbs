'***********************************************************************************************************************
'*****    Flux Flashers (Flubber alt light hack)           	                                                    	****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim TestFluxFlashers, FluxFlasherFluxLightIntensity, FluxFlasherFlareIntensity, FluxFlasherOffBrightness

								' *********************************************************************
TestFluxFlashers = 0				' *** set this to 1 to check position of flasher object 			***
FluxFlasherFluxLightIntensity = 0.1		' *** lower this, if the VPX lights are too bright (i.e. 0.1)		***
FluxFlasherFlareIntensity = 1		' *** lower this, if the flares are too bright (i.e. 0.1)			***
FluxFlasherOffBrightness = 0.1		' *** brightness of the flasher dome when switched off (range 0-2)	***
								' *********************************************************************

Dim FluxObjLevel(20), objFluxBase(20), objFluxLit(20), objFluxTimer(20)
'Dim tablewidth, tableheight : tablewidth = TableRef.width : tableheight = TableRef.height
'initialise the flasher color, you can only choose from "green", "red", "purple", "blue", "white" and "yellow"
InitFluxFlasher 1, 0.4
InitFluxFlasher 2, 0.4
'InitFluxFlasher 3, 0.4
'InitFluxFlasher 7, "white"
'InitFluxFlasher 8, "white"
'InitFluxFlasher 9, "white"
'InitFluxFlasher 10, "white"
'InitFluxFlasher 11, "white"
'InitFluxFlasher 12, "white"
'InitFluxFlasher 13, "white"
'InitFluxFlasher 14, "white"
'InitFluxFlasher 15, "white"
'InitFluxFlasher 16, "white"
'InitFluxFlasher 1, "green" : InitFluxFlasher 2, "red" : 
'InitFluxFlasher 4, "green" : InitFluxFlasher 5, "red" : InitFluxFlasher 6, "white"
'InitFluxFlasher 7, "green" : InitFluxFlasher 8, "red"
'InitFluxFlasher 9, "green" : InitFluxFlasher 10, "red" : InitFluxFlasher 11, "white" 
' rotate the flasher with the command below (first argument = flasher nr, second argument = angle in degrees)
'RotateFluxFlasher 3,90 ': RotateFluxFlasher 5,0 : RotateFluxFlasher 6,90
'RotateFluxFlasher 7,0 : RotateFluxFlasher 8,0 
'RotateFluxFlasher 9,-45 : RotateFluxFlasher 10,90 : RotateFluxFlasher 11,90

Sub InitFluxFlasher(nr, col)
	' store all objects in an array for use in FlashFluxFlasher subroutine
	Set objFluxBase(nr) = Eval("FlasherFluxBase" & nr)
	objFluxBase(nr).UserValue = col
	''Set objFluxLit(nr) = Eval("FlasherFluxLit" & nr)
	Set objFluxTimer(nr) = Eval("FlasherFluxTimer" & nr)
	' If the flasher is parallel to the playfield, rotate the VPX flasher object for POV and place it at the correct height
	''objFluxLit(nr).visible = 0 : objFluxLit(nr).material = "Flashermaterial" & nr
	''objFluxLit(nr).RotX = objFluxBase(nr).RotX : objFluxLit(nr).RotY = objFluxBase(nr).RotY : objFluxLit(nr).RotZ = objFluxBase(nr).RotZ
	''objFluxLit(nr).ObjRotX = objFluxBase(nr).ObjRotX : objFluxLit(nr).ObjRotY = objFluxBase(nr).ObjRotY : objFluxLit(nr).ObjRotZ = objFluxBase(nr).ObjRotZ
	''objFluxLit(nr).x = objFluxBase(nr).x : objFluxLit(nr).y = objFluxBase(nr).y : objFluxLit(nr).z = objFluxBase(nr).z
	objFluxBase(nr).BlendDisableLighting = FluxFlasherOffBrightness
End Sub

'FADING ROUTINE
Sub FlashFluxFlasher(nr)
'	If not objFluxFlasher(nr).TimerEnabled Then objFluxFlasher(nr).TimerEnabled = True : objFluxFlasher(nr).visible = 1 : objFluxLit(nr).visible = 1 : End If
'	objFluxFlasher(nr).opacity = 1000 *  FluxFlasherFlareIntensity * FluxObjLevel(nr)^2.5
'	objFluxBase(nr).BlendDisableLighting =  FluxFlasherOffBrightness + 10 * FluxObjLevel(nr)^3	
'	objFluxLit(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2
'	FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
'	If FluxObjLevel(nr) < 0 Then 
'		objFluxFlasher(nr).TimerEnabled = False
'		objFluxFlasher(nr).visible = 0
'		objFluxLit(nr).visible = 0
'	End If
End Sub

'FADING ROUTINE
Sub TurnOnFluxFlasher(nr)
'	If not objFluxFlasher(nr).TimerEnabled Then objFluxFlasher(nr).TimerEnabled = True : objFluxFlasher(nr).visible = 1 : objFluxLit(nr).visible = 1 : End If
'	objFluxFlasher(nr).opacity = 1000 *  FluxFlasherFlareIntensity * FluxObjLevel(nr)^2.5
	objFluxBase(nr).BlendDisableLighting = 10 * 0.4^2 'FluxFlasherOffBrightness + 10 * FluxObjLevel(nr)^3	
'	objFluxLit(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2
	'FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
	'If FluxObjLevel(nr) < 0 Then 
'		objFluxFlasher(nr).TimerEnabled = False
'		objFluxFlasher(nr).visible = 0
'		objFluxLit(nr).visible = 0
'	End If
End Sub

Sub PulseFluxFlasher(nr)
	If not objFluxTimer(nr).Enabled Then objFluxTimer(nr).Enabled = True End If
	objFluxBase(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2	
	If objFluxTimer(nr).UserValue <= 1 Then
		FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
	ElseIf objFluxTimer(nr).UserValue = 2 Then
		FluxObjLevel(nr) = FluxObjLevel(nr) * 1 + 0.01
	End If
	If FluxObjLevel(nr) < FluxFlasherOffBrightness Then 
		If objFluxTimer(nr).UserValue = 0 Then
			TurnOffFluxFlasher(nr)
		Else
			FluxObjLevel(nr) = FluxFlasherOffBrightness
			objFluxTimer(nr).UserValue = 2
		End If
	ElseIf FluxObjLevel(nr) > objFluxBase(nr).UserValue Then 
		FluxObjLevel(nr) = objFluxBase(nr).UserValue
		objFluxTimer(nr).UserValue = 1
	End If
End Sub

Sub TurnOffFluxFlasher(nr)
'	If not objFluxFlasher(nr).TimerEnabled Then objFluxFlasher(nr).TimerEnabled = True : objFluxFlasher(nr).visible = 1 : objFluxLit(nr).visible = 1 : End If
'	objFluxFlasher(nr).opacity = 1000 *  FluxFlasherFlareIntensity * FluxObjLevel(nr)^2.5
	objFluxTimer(nr).Enabled = False
	objFluxBase(nr).BlendDisableLighting = FluxFlasherOffBrightness
	objFluxBase(nr).Material = "FlasherFluxMaterial" & nr

	LightFluxFlashOff(nr)
'	objFluxLit(nr).BlendDisableLighting = 10 * FluxObjLevel(nr)^2
	'FluxObjLevel(nr) = FluxObjLevel(nr) * 0.9 - 0.01
	'If FluxObjLevel(nr) < 0 Then 
'		objFluxFlasher(nr).TimerEnabled = False
'		objFluxFlasher(nr).visible = 0
'		objFluxLit(nr).visible = 0
'	End If
End Sub

Sub FlasherFluxTimer1_Timer() : PulseFluxFlasher(1) : End Sub
Sub FlasherFluxTimer2_Timer() : PulseFluxFlasher(2) : End Sub
Sub FlasherFluxTimer3_Timer() : PulseFluxFlasher(3) : End Sub

'***********************************************************************************************************************
