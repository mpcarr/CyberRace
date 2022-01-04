'***********************************************************************************************************************
'*****    Flubber Flashers                                    	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************

Dim TestHexFlashers, HexFlasherHexLightIntensity, HexFlasherFlareIntensity, HexFlasherOffBrightness

								' *********************************************************************
TestHexFlashers = 0				' *** set this to 1 to check position of flasher object 			***
HexFlasherHexLightIntensity = 0.1		' *** lower this, if the VPX lights are too bright (i.e. 0.1)		***
HexFlasherFlareIntensity = 1		' *** lower this, if the flares are too bright (i.e. 0.1)			***
HexFlasherOffBrightness = 0.1		' *** brightness of the flasher dome when switched off (range 0-2)	***
								' *********************************************************************

Dim HexObjLevel(20), objHexBase(20), objHexLit(20), objHexFlasher(20)
'Dim tablewidth, tableheight : tablewidth = TableRef.width : tableheight = TableRef.height
'initialise the flasher color, you can only choose from "green", "red", "purple", "blue", "white" and "yellow"
InitHexFlasher 1, "white"
InitHexFlasher 2, "white"
InitHexFlasher 3, "white"
InitHexFlasher 4, "white"
'InitHexFlasher 5, "white"
'InitHexFlasher 6, "white"
'InitHexFlasher 7, "white"
'InitHexFlasher 8, "white"
'InitHexFlasher 9, "white"
'InitHexFlasher 10, "white"
'InitHexFlasher 11, "white"
'InitHexFlasher 12, "white"
'InitHexFlasher 13, "white"
'InitHexFlasher 14, "white"
'InitHexFlasher 15, "white"
'InitHexFlasher 16, "white"
'InitHexFlasher 1, "green" : InitHexFlasher 2, "red" : 
'InitHexFlasher 4, "green" : InitHexFlasher 5, "red" : InitHexFlasher 6, "white"
'InitHexFlasher 7, "green" : InitHexFlasher 8, "red"
'InitHexFlasher 9, "green" : InitHexFlasher 10, "red" : InitHexFlasher 11, "white" 
' rotate the flasher with the command below (first argument = flasher nr, second argument = angle in degrees)
'RotateHexFlasher 3,90 ': RotateHexFlasher 5,0 : RotateHexFlasher 6,90
'RotateHexFlasher 7,0 : RotateHexFlasher 8,0 
'RotateHexFlasher 9,-45 : RotateHexFlasher 10,90 : RotateHexFlasher 11,90

Sub InitHexFlasher(nr, col)
	' store all objects in an array for use in FlashHexFlasher subroutine
	Set objHexBase(nr) = Eval("FlasherHexBase" & nr) : Set objHexLit(nr) = Eval("FlasherHexLit" & nr)
	Set objHexFlasher(nr) = Eval("FlasherHexFlash" & nr)
	' If the flasher is parallel to the playfield, rotate the VPX flasher object for POV and place it at the correct height
	If objHexBase(nr).RotY = 0 Then
		'objHexBase(nr).ObjRotZ =  atn( (tablewidth/2 - objHexBase(nr).x) / (objHexBase(nr).y - tableheight*1.1)) * 180 / 3.14159
		'objHexFlasher(nr).RotZ = objHexBase(nr).ObjRotZ : objHexFlasher(nr).height = objHexBase(nr).z + 60
	End If
	' set all effects to invisible and move the lit primitive at the same position and rotation as the base primitive
	objHexLit(nr).visible = 0 : objHexLit(nr).material = "Flashermaterial" & nr
	objHexLit(nr).RotX = objHexBase(nr).RotX : objHexLit(nr).RotY = objHexBase(nr).RotY : objHexLit(nr).RotZ = objHexBase(nr).RotZ
	objHexLit(nr).ObjRotX = objHexBase(nr).ObjRotX : objHexLit(nr).ObjRotY = objHexBase(nr).ObjRotY : objHexLit(nr).ObjRotZ = objHexBase(nr).ObjRotZ
	objHexLit(nr).x = objHexBase(nr).x : objHexLit(nr).y = objHexBase(nr).y : objHexLit(nr).z = objHexBase(nr).z
	objHexBase(nr).BlendDisableLighting = HexFlasherOffBrightness
	' set the texture and color of all objects
	select case objHexBase(nr).image
		Case "dome2basewhite" : objHexBase(nr).image = "dome2base" & col : objHexLit(nr).image = "dome2lit" & col 
		Case "ronddomebasewhite" : objHexBase(nr).image = "ronddomebase" & col : objHexLit(nr).image = "ronddomelit" & col
		Case "domeearbasewhite" : objHexBase(nr).image = "domeearbase" & col : objHexLit(nr).image = "domeearlit" & col
	end select
	If TestHexFlashers = 0 Then objHexFlasher(nr).imageA = "domeflashwhite" : objHexFlasher(nr).visible = 0 : End If
	select case col
		Case "blue" :   objHexFlasher(nr).color = RGB(200,255,255)
		Case "green" :  objHexFlasher(nr).color = RGB(12,255,4)
		Case "red" :    objHexFlasher(nr).color = RGB(255,32,4)
		Case "purple" : objHexFlasher(nr).color = RGB(255,64,255) 
		Case "yellow" : objHexFlasher(nr).color = RGB(255,200,50)
		Case "white" :  objHexFlasher(nr).color = RGB(100,86,59)
	end select
	
	If TableRef.ShowDT and objHexFlasher(nr).RotX = -45 Then 
		objHexFlasher(nr).height = objHexFlasher(nr).height - 20 * objHexFlasher(nr).y / tableheight
		objHexFlasher(nr).y = objHexFlasher(nr).y + 10
	End If
End Sub

Sub RotateHexFlasher(nr, angle) : angle = ((angle + 360 - objHexBase(nr).ObjRotZ) mod 180)/30 : objHexBase(nr).showframe(angle) : objHexLit(nr).showframe(angle) : End Sub

Sub FlashHexFlasher(nr)
	If not objHexFlasher(nr).TimerEnabled Then objHexFlasher(nr).TimerEnabled = True : objHexFlasher(nr).visible = 1 : objHexLit(nr).visible = 1 : End If
	objHexFlasher(nr).opacity = 1000 *  HexFlasherFlareIntensity * HexObjLevel(nr)^2.5
	objHexBase(nr).BlendDisableLighting =  HexFlasherOffBrightness + 10 * HexObjLevel(nr)^3	
	objHexLit(nr).BlendDisableLighting = 10 * HexObjLevel(nr)^2
	HexObjLevel(nr) = HexObjLevel(nr) * 0.9 - 0.01
	If HexObjLevel(nr) < 0 Then 
		'objHexBase(nr).Image = "hexbase"
		'objHexLit(nr).Image = "hexbase"
		objHexFlasher(nr).TimerEnabled = False
		objHexFlasher(nr).visible = 0
		objHexLit(nr).visible = 0
	End If
	
End Sub

Sub FlasherHexFlash1_Timer() : FlashHexFlasher(1) : End Sub 
Sub FlasherHexFlash2_Timer() : FlashHexFlasher(2) : End Sub 
Sub FlasherHexFlash3_Timer() : FlashHexFlasher(3) : End Sub 
Sub FlasherHexFlash4_Timer() : FlashHexFlasher(4) : End Sub 
Sub FlasherHexFlash5_Timer() : FlashHexFlasher(5) : End Sub 
Sub FlasherHexFlash6_Timer() : FlashHexFlasher(6) : End Sub 
Sub FlasherHexFlash7_Timer() : FlashHexFlasher(7) : End Sub
Sub FlasherHexFlash8_Timer() : FlashHexFlasher(8) : End Sub
Sub FlasherHexFlash9_Timer() : FlashHexFlasher(9) : End Sub
Sub FlasherHexFlash10_Timer() : FlashHexFlasher(10) : End Sub
Sub FlasherHexFlash11_Timer() : FlashHexFlasher(11) : End Sub
Sub FlasherHexFlash12_Timer() : FlashHexFlasher(12) : End Sub
Sub FlasherHexFlash13_Timer() : FlashHexFlasher(13) : End Sub
Sub FlasherHexFlash14_Timer() : FlashHexFlasher(14) : End Sub
Sub FlasherHexFlash15_Timer() : FlashHexFlasher(15) : End Sub
Sub FlasherHexFlash16_Timer() : FlashHexFlasher(16) : End Sub

'***********************************************************************************************************************
