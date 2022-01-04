'***********************************************************************************************************************
'*****  LAMPS                                                	                                                    ****
'*****                                                                                                              ****
'***********************************************************************************************************************


'***************************************
'***Begin nFozzy lamp handling***
'***************************************

Dim NullFader : set NullFader = new NullFadingObject
Dim Lampz : Set Lampz = New LampFader
Dim ModLampz : Set ModLampz = New DynamicLamps
InitLampsNF              ' Setup lamp assignments

Sub InitLampsNF()

	'Filtering (comment out to disable)
	Lampz.Filter = "LampFilter"	'Puts all lamp intensity scale output (no callbacks) through this function before updating
	ModLampz.Filter = "LampFilter"
	'Adjust fading speeds (1 / full MS fading time)
	dim x : for x = 0 to 140 : Lampz.FadeSpeedUp(x) = 1/80 : Lampz.FadeSpeedDown(x) = 1/100 : next
	Lampz.FadeSpeedUp(110) = 1/64 'GI

'*********************************************************************************************************************************************************
'End nfozzy lamp handling
'*********************************************************************************************************************************************************
	Lampz.MassAssign(0) = l_aug1
    Lampz.MassAssign(1) = l_aug4
	Lampz.MassAssign(2) = l_aug7
    Lampz.MassAssign(3) = l_aug2
    Lampz.MassAssign(4) = l_aug5
	Lampz.MassAssign(5) = l_aug8
    Lampz.MassAssign(6) = l_aug3
    Lampz.MassAssign(7) = l_aug6
	Lampz.MassAssign(8) = l_aug9
	Lampz.MassAssign(9) = l_bet1
	Lampz.MassAssign(10) = l_bet2
	Lampz.MassAssign(11) = l_bet3
	Lampz.MassAssign(21) = l_pw2
	Lampz.MassAssign(22) = l_pw3
	Lampz.MassAssign(23) = l_pw4
	Lampz.MassAssign(25) = l_research

	
	Lampz.MassAssign(26) = l_captive1
	Lampz.MassAssign(27) = l_captive2
	Lampz.MassAssign(28) = l_captive3
	Lampz.MassAssign(29) = l_captive4
	Lampz.MassAssign(30) = l_holdaug


	Lampz.MassAssign(31) = l_leftOrbit
	Lampz.MassAssign(32) = l_leftRamp
	Lampz.MassAssign(33) = l_spinner1
	Lampz.MassAssign(39) = l_spinner2
	Lampz.MassAssign(34) = l_centerRamp
	Lampz.MassAssign(35) = l_rightRamp
	Lampz.MassAssign(36) = l_rightOrbit
	Lampz.MassAssign(37) = l_shortcutReady
	Lampz.MassAssign(38) = l_hyperJump1
	Lampz.MassAssign(45) = l_hyperJump2
	Lampz.MassAssign(43) = l_hyperJump3
	Lampz.MassAssign(44) = l_hyperJump4
	Lampz.MassAssign(68) = l_hyperJump5

	Lampz.MassAssign(40) = LBBump1Flash
	Lampz.MassAssign(41) = LBBump2Flash
	Lampz.MassAssign(42) = LBBump3Flash

	Lampz.MassAssign(46) = l_shortcut1
	Lampz.MassAssign(47) = l_shortcut2
	Lampz.MassAssign(48) = l_shortcut3

	Lampz.MassAssign(49) = l_finish

	Lampz.MassAssign(50) = l_olr1a
	Lampz.MassAssign(51) = l_olr1b
	Lampz.MassAssign(52) = l_olr2a
	Lampz.MassAssign(53) = l_olr2b
	Lampz.MassAssign(54) = l_olr3a
	Lampz.MassAssign(55) = l_olr3b
	Lampz.MassAssign(56) = l_olr4a
	Lampz.MassAssign(57) = l_olr4b
	Lampz.MassAssign(58) = l_olr5a
	Lampz.MassAssign(59) = l_olr5b
	Lampz.MassAssign(60) = l_olr6a
	Lampz.MassAssign(61) = l_olr6b
	Lampz.MassAssign(62) = l_olr7a
	Lampz.MassAssign(63) = l_olr7b
	Lampz.MassAssign(64) = l_olr8a
	Lampz.MassAssign(65) = l_olr8b
	Lampz.MassAssign(66) = l_olr9a
	Lampz.MassAssign(67) = l_olr9b

	Lampz.MassAssign(70) = l_oll1a
	Lampz.MassAssign(71) = l_oll1b
	Lampz.MassAssign(72) = l_oll2a
	Lampz.MassAssign(73) = l_oll2b
	Lampz.MassAssign(74) = l_oll3a
	Lampz.MassAssign(75) = l_oll3b
	Lampz.MassAssign(76) = l_oll4a
	Lampz.MassAssign(77) = l_oll4b
	Lampz.MassAssign(78) = l_oll5a
	Lampz.MassAssign(79) = l_oll5b
	Lampz.MassAssign(80) = l_oll6a
	Lampz.MassAssign(81) = l_oll6b
	Lampz.MassAssign(82) = l_oll7a
	Lampz.MassAssign(83) = l_oll7b
	Lampz.MassAssign(84) = l_oll8a
	Lampz.MassAssign(85) = l_oll8b
	Lampz.MassAssign(86) = l_oll9a
	Lampz.MassAssign(87) = l_oll9b

	Lampz.MassAssign(90) = l_lane1
	Lampz.MassAssign(91) = l_lane2
	Lampz.MassAssign(92) = l_lane3
	Lampz.MassAssign(93) = l_lane4
	
	Lampz.MassAssign(94) = l_px2
	Lampz.MassAssign(95) = l_px4
	Lampz.MassAssign(96) = l_px5

	Lampz.MassAssign(97) = l_extraball
	Lampz.MassAssign(98) = l_lock

	Lampz.MassAssign(100) = l_race1
	Lampz.MassAssign(101) = l_race2
	Lampz.MassAssign(102) = l_race3
	Lampz.MassAssign(103) = l_race4
	Lampz.MassAssign(104) = l_race5
	Lampz.MassAssign(105) = l_race6
	Lampz.MassAssign(106) = l_raceWizard

	Lampz.MassAssign(107) = l_bx2
	Lampz.MassAssign(108) = l_bx4
	Lampz.MassAssign(109) = l_bx5

	Lampz.MassAssign(110) = l_cyber1
	Lampz.MassAssign(111) = l_cyber2
	Lampz.MassAssign(112) = l_cyber3
	Lampz.MassAssign(113) = l_cyber4
	Lampz.MassAssign(114) = l_cyber5

	Lampz.MassAssign(115) = l_combo1
	Lampz.MassAssign(116) = l_combo2
	Lampz.MassAssign(117) = l_combo3
	Lampz.MassAssign(118) = l_combo4
	Lampz.MassAssign(119) = l_combo5
	
	Lampz.MassAssign(120) = l_pop1
	Lampz.MassAssign(121) = l_pop2
	Lampz.MassAssign(122) = l_pop3

	Lampz.MassAssign(130) = l_watch
	Lampz.Callback(130) = "DisableLighting p_watchdisplay_full, 45,"
	Lampz.MassAssign(131) = l_watch
	Lampz.Callback(131) = "DisableLighting p_watchdisplay_left, 45,"
	Lampz.MassAssign(132) = l_watch
	Lampz.Callback(132) = "DisableLighting p_watchdisplay_right, 45,"
	'Lampz.MassAssign(100) = L58
	'Lampz.MassAssign(101) = L25
	'Lampz.MassAssign(110) = l_alert_a
	

''*****************
''GI Assignments
''*****************
'	Lampz.Callback(110) = "GIupdates"
'	Lampz.obj(110) = ColtoArray(GI)	
'	Lampz.state(110) = 1		'Turn on GI to Start

	ModLampz.Callback(0) = "GIUpdates"
	ModLampz.MassAssign(0)= ColToArray(GI) 

	dim ii
	For each ii in GI:ii.IntensityScale = 0.3:Next
	'For each ii in GI_PF:ii.IntensityScale = 1:Next
	'For each ii in GI_PF:ii.Falloff = 400:Next
	

'	'Turn off all lamps on startup
'	lampz.TurnOnStates	'Set any lamps state to 1. (Object handles fading!)
'	lampz.update
		'Turn off all lamps on startup
	lampz.Init	'This just turns state of any lamps to 1
	ModLampz.Init

	'Immediate update to turn on GI, turn off lamps
	lampz.update
	ModLampz.Update


End Sub

dim FrameTime, InitFrameTime : InitFrameTime = 0
Sub LampTimer()
	dim x, chglamp
	
	FrameTime = gametime - InitFrameTime : InitFrameTime = gametime
	Dispatch LIGHTS_UPDATE, FrameTime
	
	'Lampz.Update1 ' what does this do
	Lampz.Update2 ' what does this do
	ModLampz.Update2 ' what does this do
End Sub

Wall9.TimerInterval = -1
Wall9.TimerEnabled = True
Sub Wall9_Timer()	'Stealing this random wall's timer for -1 updates
	'FrameTime = gametime - InitFrameTime : InitFrameTime = gametime	'Count frametime. Unused atm?
	'Lampz.Update 'updates on frametime (Object updates only)
	'ModLampz.Update
End Sub

Function FlashLevelToIndex(Input, MaxSize)
	FlashLevelToIndex = cInt(MaxSize * Input)
End Function



'Material swap arrays.
Dim TextureArray1: TextureArray1 = Array("Plastic with an image trans", "Plastic with an image trans","Plastic with an image trans","Plastic with an image")


Dim DLintensity
'***************************************
'***Prim Image Swaps***
'***************************************
Sub ImageSwap(pri, group, DLintensity, ByVal aLvl)	'cp's script  DLintensity = disabled lighting intesity
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
    Select case FlashLevelToIndex(aLvl, 3)
		Case 1:pri.Image = group(0) 'Full
		Case 2:pri.Image = group(1) 'Fading...
		Case 3:pri.Image = group(2) 'Fading...
        Case 4:pri.Image = group(3) 'Off
    End Select
pri.blenddisablelighting = aLvl * DLintensity
End Sub


'***************************************
'***Prim Material Swaps***
'***************************************
Sub MatSwap(pri, group, DLintensity, ByVal aLvl)	'cp's script  DLintensity = disabled lighting intesity
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
    Select case FlashLevelToIndex(aLvl, 3)
		Case 1:pri.Material = group(0) 'Full
		Case 2:pri.Material = group(1) 'Fading...
		Case 3:pri.Material = group(2) 'Fading...
              Case 4:pri.Material = group(3) 'Off
    End Select
pri.blenddisablelighting = aLvl * DLintensity
End Sub


Sub FadeMaterialToys(pri, group, ByVal aLvl)	'cp's script
'	if Lampz.UseFunction then aLvl = LampFilter(aLvl)	'Callbacks don't get this filter automatically
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
    Select case FlashLevelToIndex(aLvl, 3)
		Case 0:pri.Material = group(0) 'Off
		Case 1:pri.Material = group(1) 'Fading...
		Case 2:pri.Material = group(2) 'Fading...
        Case 3:pri.Material = group(3) 'Full
    End Select
	'if tb.text <> pri.image then tb.text = pri.image : debug.print pri.image end If	'debug
pri.blenddisablelighting = aLvl * 1 'Intensity Adjustment
End Sub



Sub DisableLighting(pri, DLintensity, ByVal aLvl)	'cp's script  DLintensity = disabled lighting intesity
	if Lampz.UseFunction then aLvl = Lampz.FilterOut(aLvl)	'Callbacks don't get this filter automatically
	pri.blenddisablelighting = aLvl * DLintensity * 0.4
End Sub






'***************************************
'GI off insert lamps intensity boost
'***************************************
Dim GIoffMult : GIoffMult = 3 'Multiplies all non-GI inserts lights opacities when the GI is off 
Sub GIupdates(ByVal aLvl)	'GI update odds and ends go here

	'DebugOut("GIupdates;"+Cstr(aLvl))
	if Lampz.UseFunction then aLvl = LampFilter(aLvl)	'Callbacks don't get this filter automatically
	'SetGIColor
	'Fade lamps up when GI is off
'	dim GIscale
'	GiScale = (GIoffMult-1) * (ABS(aLvl-1 )  ) + 1	'invert
'	dim x : for x = 0 to uBound(LightsA) 
'		On Error Resume Next
'		LightsA(x).Opacity = LightsB(x) * GIscale
'		LightsA(x).Intensity = LightsB(x) * GIscale
'		'LightsA(x).FadeSpeedUp = LightsC(x) * GIscale
'		'LightsA(x).FadeSpeedDown = LightsD(x) * GIscale
'		On Error Goto 0
'	Next
End Sub

'***************************************
'GI off finsert light falloff-power boost
'***************************************
Dim GiOffFOP
Sub SetGI(aNr, aValue)
	'DebugOut("SETTING GI MAIN FROM CORE.vbs ; "+ Cstr(aNr) + " ; " + Cstr(aValue))
	ModLampz.SetGI aNr, aValue 'Redundant. Could reassign GI indexes here
'	GestioneGIWall
	SetGIColor
End Sub

'***GI Color Mod***
Dim GIxx, ColorModRed, ColorModRedFull, ColorModGreen, ColorModGreenFull, ColorModBlue, ColorModBlueFull
Dim GIColorRed, GIColorGreen, GIColorBlue, GIColorFullRed, GIColorFullGreen, GIColorFullBlue, GIColor

'GIColorRed       =  61
'GIColorGreen     =  12
'GIColorBlue      =  97

GIColorRed       =  255
GIColorGreen     =  195
GIColorBlue      =  100
dim GIColorRedOrig : GIColorRedOrig =  GIColorRed
dim GIColorGreenOrig : GIColorGreenOrig = GIColorGreen
dim GIColorBlueOrig : GIColorBlueOrig = GIColorBlue

Sub SetGIColor ()

'	for each GIxx in GILighting
'	GIxx.Color = rgb(GIColorRed, GIColorGreen, GIColorBlue)
'	GIxx.ColorFull = rgb(GIColorFullRed, GIColorFullGreen, GIColorFullBlue)
'	next
	const ColorMultiplier = 0.8
	const FullColorMultiplier = 0.95
	'debug.print GIColorRed &" - "& GIColorGreen &" - "& GIColorBlue
	for each GIxx in GI
	GIxx.Color = rgb(GIColorRed*ColorMultiplier, GIColorGreen*ColorMultiplier, GIColorBlue*ColorMultiplier)
	GIxx.ColorFull = rgb(GIColorRed*FullColorMultiplier, GIColorGreen*FullColorMultiplier, GIColorBlue*FullColorMultiplier)
	GIColor = GIxx.ColorFull
	next
	'FlasherRGBGI.Color = GIColor
End Sub

'Lamp Filter
Function LampFilter(aLvl)

	LampFilter = aLvl^1.6	'exponential curve?
End Function

Function ColtoArray(aDict)	'converts a collection to an indexed array. Indexes will come out random probably.
	redim a(999)
	dim count : count = 0
	dim x  : for each x in aDict : set a(Count) = x : count = count + 1 : Next
	redim preserve a(count-1) : ColtoArray = a
End Function

Sub SetLamp(aNr, aOn)
	Lampz.state(aNr) = abs(aOn)
End Sub

Sub SetModLamp(aNr, aInput)


	'If aNr=0 Then
		'DebugOut(Cstr(aNr)+"="+Cstr(abs(aInput)/255))
	'End If
	ModLampz.state(aNr) = abs(aInput)/255
End Sub

'*********************************************************************************************************************************************************
'End lamp helper functions
'*********************************************************************************************************************************************************

'*********************************************************************************************************************************************************
'End lamp helper functions
'*********************************************************************************************************************************************************






'====================
'Class jungle nf
'=============

'No-op object instead of adding more conditionals to the main loop
'It also prevents errors if empty lamp numbers are called, and it's only one object
'should be g2g?

Class NullFadingObject : Public Property Let IntensityScale(input) : End Property End Class

'version 0.11 - Mass Assign, Changed modulate style
'version 0.12 - Update2 (single -1 timer update) update method for core.vbs
'Version 0.12a - Filter can now be accessed via 'FilterOut'
'Version 0.12b - Changed MassAssign from a sub to an indexed property (new syntax: lampfader.MassAssign(15) = Light1 )
'Version 0.13 - No longer requires setlocale. Callback() can be assigned multiple times per index
' Note: if using multiple 'LampFader' objects, set the 'name' variable to avoid conflicts with callbacks

Class LampFader
	Public FadeSpeedDown(140), FadeSpeedUp(140)
	Private Lock(140), Loaded(140), OnOff(140)
	Public UseFunction
	Private cFilter
	Public UseCallback(140), cCallback(140)
	Public Lvl(140), Obj(140)
	Private Mult(140)
	Public FrameTime
	Private InitFrame
	Public Name

	Sub Class_Initialize()
		InitFrame = 0
		dim x : for x = 0 to uBound(OnOff) 	'Set up fade speeds
			FadeSpeedDown(x) = 1/100	'fade speed down
			FadeSpeedUp(x) = 1/80		'Fade speed up
			UseFunction = False
			lvl(x) = 0
			OnOff(x) = False
			Lock(x) = True : Loaded(x) = False
			Mult(x) = 1
		Next
		Name = "LampFaderNF" 'NEEDS TO BE CHANGED IF THERE'S MULTIPLE OF THESE OBJECTS, OTHERWISE CALLBACKS WILL INTERFERE WITH EACH OTHER!!
		for x = 0 to uBound(OnOff) 		'clear out empty obj
			if IsEmpty(obj(x) ) then Set Obj(x) = NullFader' : Loaded(x) = True
		Next
	End Sub

	Public Property Get Locked(idx) : Locked = Lock(idx) : End Property		'debug.print Lampz.Locked(100)	'debug
	Public Property Get state(idx) : state = OnOff(idx) : end Property
	Public Property Get lampColor(idx) : lampColor = obj(idx).colorFull : end Property
	Public Property Get image(idx) : image = obj(idx).Image : end Property
	
	Public Property Let Filter(String) : Set cFilter = GetRef(String) : UseFunction = True : End Property
	Public Function FilterOut(aInput) : if UseFunction Then FilterOut = cFilter(aInput) Else FilterOut = aInput End If : End Function
	'Public Property Let Callback(idx, String) : cCallback(idx) = String : UseCallBack(idx) = True : End Property
	Public Property Let Callback(idx, String)
		UseCallBack(idx) = True
		'cCallback(idx) = String 'old execute method
		'New method: build wrapper subs using ExecuteGlobal, then call them
		cCallback(idx) = cCallback(idx) & "___" & String	'multiple strings dilineated by 3x _

		dim tmp : tmp = Split(cCallback(idx), "___")

		dim str, x : for x = 0 to uBound(tmp)	'build proc contents
			'If Not tmp(x)="" then str = str & "	" & tmp(x) & " aLVL" & "	'" & x & vbnewline	'more verbose
			If Not tmp(x)="" then str = str & tmp(x) & " aLVL:"
		Next

		dim out : out = "Sub " & name & idx & "(aLvl):" & str & "End Sub"
		'if idx = 132 then msgbox out	'debug
		ExecuteGlobal Out

	End Property

	Public Property Let state(ByVal idx, input) 'Major update path
		if Input <> OnOff(idx) then  'discard redundant updates
			OnOff(idx) = input
			Lock(idx) = False
			If input = 1 Then
				Lvl(idx) = 0
			Else
				Lvl(idx) = 1
			End If
			If not typename(obj(idx)) = "NullFadingObject" Then 'if empty, use Set
				obj(idx).State = input
			End If
			Loaded(idx) = False
		End If
	End Property

	Public Property Let lampColor(ByVal idx, input) 'Major update path
		obj(idx).colorFull = input
		obj(idx).color = input
	End Property

	Public Property Let image(ByVal idx, input) 'Major update path
		obj(idx).Image = input
	End Property

	'Mass assign, Builds arrays where necessary
	'Sub MassAssign(aIdx, aInput)
	Public Property Let MassAssign(aIdx, aInput)
		If typename(obj(aIdx)) = "NullFadingObject" Then 'if empty, use Set
			if IsArray(aInput) then
				obj(aIdx) = aInput
			Else
				Set obj(aIdx) = aInput
			end if
		Else
			Obj(aIdx) = AppendArray(obj(aIdx), aInput)
		end if
	end Property

	Sub SetLamp(aIdx, aOn) : state(aIdx) = aOn : End Sub	'Solenoid Handler

	Public Sub TurnOffStates()
		dim idx : for idx = 0 to uBound(OnOff)
			state(idx) = 0
		Next
	End Sub

	Public Sub TurnOnStates()	'If obj contains any light objects, set their states to 1 (Fading is our job!)
		dim debugstr
		dim idx : for idx = 0 to uBound(obj)
			if IsArray(obj(idx)) then
				'debugstr = debugstr & "array found at " & idx & "..."
				dim x, tmp : tmp = obj(idx) 'set tmp to array in order to access it
				for x = 0 to uBound(tmp)
					if typename(tmp(x)) = "Light" then DisableState tmp(x)' : debugstr = debugstr & tmp(x).name & " state'd" & vbnewline
					tmp(x).intensityscale = 0.001 ' this can prevent init stuttering
				Next
			Else
				if typename(obj(idx)) = "Light" then DisableState obj(idx)' : debugstr = debugstr & obj(idx).name & " state'd (not array)" & vbnewline
				obj(idx).intensityscale = 0.001 ' this can prevent init stuttering
			end if
		Next
		'debug.print debugstr
	End Sub
	Private Sub DisableState(ByRef aObj) : aObj.FadeSpeedUp = 0.2 : aObj.State = 1 : End Sub	'turn state to 1

	Public Sub Init()	'Just runs TurnOnStates right now
		'TurnOnStates
	End Sub

	Public Property Let Modulate(aIdx, aCoef) : Mult(aIdx) = aCoef : Lock(aIdx) = False : Loaded(aIdx) = False: End Property
	Public Property Get Modulate(aIdx) : Modulate = Mult(aIdx) : End Property

	Public Sub Update1()	 'Handle all boolean numeric fading. If done fading, Lock(x) = True. Update on a '1' interval Timer!
		dim x : for x = 0 to uBound(OnOff)
			if not Lock(x) then 'and not Loaded(x) then
				if OnOff(x) then 'Fade Up
					Lvl(x) = Lvl(x) + FadeSpeedUp(x)
					if Lvl(x) >= 1 then Lvl(x) = 1 : Lock(x) = True
				elseif Not OnOff(x) then 'fade down
					Lvl(x) = Lvl(x) - FadeSpeedDown(x)
					if Lvl(x) <= 0 then Lvl(x) = 0 : Lock(x) = True
				end if
			end if
		Next
	End Sub

	Public Sub Update2()	 'Both updates on -1 timer (Lowest latency, but less accurate fading at 60fps vsync)
		FrameTime = gametime - InitFrame : InitFrame = GameTime	'Calculate frametime
		dim x : for x = 0 to uBound(OnOff)
			if not Lock(x) then 'and not Loaded(x) then
				if OnOff(x) then 'Fade Up
					Lvl(x) = Lvl(x) + FadeSpeedUp(x) * FrameTime
					if Lvl(x) >= 1 then Lvl(x) = 1 : Lock(x) = True
				elseif Not OnOff(x) then 'fade down
					Lvl(x) = Lvl(x) - FadeSpeedDown(x) * FrameTime
					if Lvl(x) <= 0 then Lvl(x) = 0 : Lock(x) = True
				end if
			end if
		Next
		Update
	End Sub

	Public Sub Update()	'Handle object updates. Update on a -1 Timer! If done fading, loaded(x) = True
		dim x,xx : for x = 0 to uBound(OnOff)
			if not Loaded(x) then
				if IsArray(obj(x) ) Then	'if array
					If UseFunction then
						for each xx in obj(x) : xx.IntensityScale = cFilter(Lvl(x)*Mult(x)) : Next
					Else
						for each xx in obj(x) : xx.IntensityScale = Lvl(x)*Mult(x) : Next
					End If
				else						'if single lamp or flasher
					If UseFunction then
						obj(x).Intensityscale = cFilter(Lvl(x)*Mult(x))
					Else
						obj(x).Intensityscale = Lvl(x)
					End If
				end if
				if TypeName(lvl(x)) <> "Double" and typename(lvl(x)) <> "Integer" then msgbox "uhh " & 2 & " = " & lvl(x)
				'If UseCallBack(x) then execute cCallback(x) & " " & (Lvl(x))	'Callback
				If UseCallBack(x) then Proc name & x,Lvl(x)*mult(x)	'Proc
				If Lock(x) Then
					if Lvl(x) = 1 or Lvl(x) = 0 then Loaded(x) = True	'finished fading
					If not typename(obj(x)) = "NullFadingObject" Then 'if empty, use Set
						If OnOff(x) = 0 Then
							'MsgBox("off")
							'debug.print obj(x).Name
							'finished fading the lamp off.
							obj(x).IntensityScale=1
							obj(x).State = 0
						End if
					End If
				end if
			end if
		Next
	End Sub
End Class




'version 0.11 - Mass Assign, Changed modulate style
'version 0.12 - Update2 (single -1 timer update) update method for core.vbs
'Version 0.12a - Filter can now be publicly accessed via 'FilterOut'
'Version 0.12b - Changed MassAssign from a sub to an indexed property (new syntax: lampfader.MassAssign(15) = Light1 )
'Version 0.13 - No longer requires setlocale. Callback() can be assigned multiple times per index
'Version 0.13a - fixed DynamicLamps hopefully
' Note: if using multiple 'DynamicLamps' objects, change the 'name' variable to avoid conflicts with callbacks

Class DynamicLamps 'Lamps that fade up and down. GI and Flasher handling
	Public Loaded(50), FadeSpeedDown(50), FadeSpeedUp(50)
	Private Lock(50), SolModValue(50)
	Private UseCallback(50), cCallback(50)
	Public Lvl(50)
	Public Obj(50)
	Private UseFunction, cFilter
	private Mult(50)
	Public Name

	Public FrameTime
	Private InitFrame

	Private Sub Class_Initialize()
		InitFrame = 0
		dim x : for x = 0 to uBound(Obj)
			FadeSpeedup(x) = 0.01
			FadeSpeedDown(x) = 0.01
			lvl(x) = 0.0001 : SolModValue(x) = 0
			Lock(x) = True : Loaded(x) = False
			mult(x) = 1
			Name = "DynamicFaderNF" 'NEEDS TO BE CHANGED IF THERE'S MULTIPLE OBJECTS, OTHERWISE CALLBACKS WILL INTERFERE WITH EACH OTHER!!
			if IsEmpty(obj(x) ) then Set Obj(x) = NullFader' : Loaded(x) = True
		next
	End Sub

	Public Property Get Locked(idx) : Locked = Lock(idx) : End Property
	'Public Property Let Callback(idx, String) : cCallback(idx) = String : UseCallBack(idx) = True : End Property
	Public Property Let Filter(String) : Set cFilter = GetRef(String) : UseFunction = True : End Property
	Public Function FilterOut(aInput) : if UseFunction Then FilterOut = cFilter(aInput) Else FilterOut = aInput End If : End Function

	Public Property Let Callback(idx, String)
		UseCallBack(idx) = True
		'cCallback(idx) = String 'old execute method
		'New method: build wrapper subs using ExecuteGlobal, then call them
		cCallback(idx) = cCallback(idx) & "___" & String	'multiple strings dilineated by 3x _

		dim tmp : tmp = Split(cCallback(idx), "___")

		dim str, x : for x = 0 to uBound(tmp)	'build proc contents
			'debugstr = debugstr & x & "=" & tmp(x) & vbnewline
			'If Not tmp(x)="" then str = str & "	" & tmp(x) & " aLVL" & "	'" & x & vbnewline	'more verbose
			If Not tmp(x)="" then str = str & tmp(x) & " aLVL:"
		Next

		dim out : out = "Sub " & name & idx & "(aLvl):" & str & "End Sub"
		'if idx = 132 then msgbox out	'debug
		ExecuteGlobal Out

	End Property


	Public Property Let State(idx,Value)
		'If Value = SolModValue(idx) Then Exit Property ' Discard redundant updates
		If Value <> SolModValue(idx) Then ' Discard redundant updates
			SolModValue(idx) = Value
			Lock(idx) = False : Loaded(idx) = False
		End If
	End Property
	Public Property Get state(idx) : state = SolModValue(idx) : end Property

	'Mass assign, Builds arrays where necessary
	'Sub MassAssign(aIdx, aInput)
	Public Property Let MassAssign(aIdx, aInput)
		If typename(obj(aIdx)) = "NullFadingObject" Then 'if empty, use Set
			if IsArray(aInput) then
				obj(aIdx) = aInput
			Else
				Set obj(aIdx) = aInput
			end if
		Else
			Obj(aIdx) = AppendArray(obj(aIdx), aInput)
		end if
	end Property

	'solcallback (solmodcallback) handler
	Sub SetLamp(aIdx, aInput) : state(aIdx) = aInput : End Sub	'0->1 Input
	Sub SetModLamp(aIdx, aInput) : state(aIdx) = aInput/255 : End Sub	'0->255 Input
	Sub SetGI(aIdx, ByVal aInput) 
		'DebugOut("SETTING GI ON MODLAMPZ ; "+ Cstr(aIdx) + " ; " + CStr(aInput))
		if aInput = 8 then 
			aInput = 7 
		end if 
		state(aIdx) = aInput/7
	End Sub	'0->8 WPC GI input

	Public Sub TurnOnStates()	'If obj contains any light objects, set their states to 1 (Fading is our job!)
		dim debugstr
		dim idx : for idx = 0 to uBound(obj)
			if IsArray(obj(idx)) then
				'debugstr = debugstr & "array found at " & idx & "..."
				dim x, tmp : tmp = obj(idx) 'set tmp to array in order to access it
				for x = 0 to uBound(tmp)
					if typename(tmp(x)) = "Light" then DisableState tmp(x) ': debugstr = debugstr & tmp(x).name & " state'd" & vbnewline

				Next
			Else
				if typename(obj(idx)) = "Light" then DisableState obj(idx) ': debugstr = debugstr & obj(idx).name & " state'd (not array)" & vbnewline

			end if
		Next
		'debug.print debugstr
	End Sub
	Private Sub DisableState(ByRef aObj) : aObj.FadeSpeedUp = 1000 : aObj.State = 1 : End Sub	'turn state to 1

	Public Sub Init()	'just call turnonstates for now
		TurnOnStates
	End Sub

	Public Property Let Modulate(aIdx, aCoef) : Mult(aIdx) = aCoef : Lock(aIdx) = False : Loaded(aIdx) = False: End Property
	Public Property Get Modulate(aIdx) : Modulate = Mult(aIdx) : End Property

	Public Sub Update1()	 'Handle all numeric fading. If done fading, Lock(x) = True
		'dim stringer
		dim x : for x = 0 to uBound(Lvl)
			'stringer = "Locked @ " & SolModValue(x)






			if not Lock(x) then 'and not Loaded(x) then
				If lvl(x) < SolModValue(x) then '+
					'stringer = "Fading Up " & lvl(x) & " + " & FadeSpeedUp(x)
					Lvl(x) = Lvl(x) + FadeSpeedUp(x)
					if Lvl(x) >= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				ElseIf Lvl(x) > SolModValue(x) Then '-
					Lvl(x) = Lvl(x) - FadeSpeedDown(x)
					'stringer = "Fading Down " & lvl(x) & " - " & FadeSpeedDown(x)
					if Lvl(x) <= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				End If
			end if
		Next
		'tbF.text = stringer
	End Sub

	Public Sub Update2()	 'Both updates on -1 timer (Lowest latency, but less accurate fading at 60fps vsync)
		FrameTime = gametime - InitFrame : InitFrame = GameTime	'Calculate frametime
		dim x : for x = 0 to uBound(Lvl)

			if not Lock(x) then 'and not Loaded(x) then
				If lvl(x) < SolModValue(x) then '+
					Lvl(x) = Lvl(x) + FadeSpeedUp(x) * FrameTime
					if Lvl(x) >= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				ElseIf Lvl(x) > SolModValue(x) Then '-
					Lvl(x) = Lvl(x) - FadeSpeedDown(x) * FrameTime
					if Lvl(x) <= SolModValue(x) then Lvl(x) = SolModValue(x) : Lock(x) = True
				End If
			end if
		Next
		Update
	End Sub

	Public Sub Update()	'Handle object updates. Update on a -1 Timer! If done fading, loaded(x) = True
		dim x,xx
		for x = 0 to uBound(Lvl)
			if not Loaded(x) then
				if IsArray(obj(x) ) Then	'if array
					If UseFunction then
						for each xx in obj(x) 

							xx.IntensityScale = cFilter(abs(Lvl(x))*mult(x))
							If xx.Name = "LA014" Then
								'DebugOut(xx.Name + ":" + cStr(cFilter(abs(Lvl(x))*mult(x))))
							End If
						Next
					Else
						for each xx in obj(x) : xx.IntensityScale = Lvl(x)*mult(x) : Next
					End If
				else						'if single lamp or flasher
					If UseFunction then
						obj(x).Intensityscale = cFilter(abs(Lvl(x))*mult(x))
					Else
						obj(x).Intensityscale = Lvl(x)*mult(x)
					End If
				end if
				'If UseCallBack(x) then execute cCallback(x) & " " & (Lvl(x)*mult(x))	'Callback
				If UseCallBack(x) then Proc name & x,Lvl(x)*mult(x)	'Proc
				If Lock(x) Then
					Loaded(x) = True
				end if





			end if
		Next
	End Sub
End Class

'Helper functions
Sub Proc(string, Callback)	'proc using a string and one argument
	'On Error Resume Next
	dim p : Set P = GetRef(String)
	P Callback
	If err.number = 13 then  msgbox "Proc error! No such procedure: " & vbnewline & string
	if err.number = 424 then msgbox "Proc error! No such Object"
End Sub

Function AppendArray(ByVal aArray, aInput)	'append one value, object, or Array onto the end of a 1 dimensional array
	if IsArray(aInput) then 'Input is an array...
		dim tmp : tmp = aArray
		If not IsArray(aArray) Then	'if not array, create an array
			tmp = aInput
		Else						'Append existing array with aInput array
			Redim Preserve tmp(uBound(aArray) + uBound(aInput)+1)	'If existing array, increase bounds by uBound of incoming array
			dim x : for x = 0 to uBound(aInput)
				if isObject(aInput(x)) then
					Set tmp(x+uBound(aArray)+1 ) = aInput(x)
				Else
					tmp(x+uBound(aArray)+1 ) = aInput(x)
				End If
			Next
		AppendArray = tmp	 'return new array
		End If
	Else 'Input is NOT an array...
		If not IsArray(aArray) Then	'if not array, create an array
			aArray = Array(aArray, aInput)
		Else
			Redim Preserve aArray(uBound(aArray)+1)	'If array, increase bounds by 1
			if isObject(aInput) then
				Set aArray(uBound(aArray)) = aInput
			Else
				aArray(uBound(aArray)) = aInput
			End If
		End If
		AppendArray = aArray 'return new array
	End If
End Function


Sub LightOn(light)

	light.State = 1
	If Not gameState("lights")("lightOn").Exists(light.Idx) Then 
		gameState("lights")("lightOn").Add light.Idx, light
	End If
	
	If gameState("lights")("lightBlinks").Exists(light.Idx) Then 
		gameState("lights")("lightBlinks").Remove light.Idx
	End If

End Sub

Sub LightOff(light)

	Lampz.State(light.Idx) = 0
	If gameState("lights")("lightOn").Exists(light.Idx) Then	
		gameState("lights")("lightOn").Remove light.Idx
	End If

	If gameState("lights")("lightBlinks").Exists(light.Idx) Then	
		gameState("lights")("lightBlinks").Remove light.Idx
	End If

End Sub

Sub LightFluxFlash(nr, light)

	If Not gameState("lights")("lightFlash").Exists(nr) Then 
		gameState("lights")("lightFlash").Add nr, light
	End If

End Sub

Sub LightFluxFlashOff(nr)

	If gameState("lights")("lightFlash").Exists(nr) Then 
		gameState("lights")("lightFlash").Remove nr
	End If

End Sub

Sub LightBlink(light)

	If Not gameState("lights")("lightBlinks").Exists(light.Idx) Then 
		gameState("lights")("lightBlinks").Add light.Idx, light
	End If

	If gameState("lights")("lightOn").Exists(light.Idx) Then
		gameState("lights")("lightOn").Remove light.Idx
	End If

End Sub

Sub StopLightBlink(light)

	Lampz.State(light.Idx) = 0
	light.State = 1
	light.ResetFrames()
	If gameState("lights")("lightBlinks").Exists(light.Idx) Then	
		gameState("lights")("lightBlinks").Remove light.Idx
	End If

	If gameState("lights")("lightOn").Exists(light.Idx) Then	
		gameState("lights")("lightOn").Remove light.Idx
	End If

End Sub

Sub StopLightSeq(seq)
	If Not IsNull(seq) Then
		Dim item
		For Each item in seq.Items
			Dim x
			For Each x in item.Sequence

				If IsArray(x) Then
					Dim xx
					For Each xx in x
						Lampz.State(xx.Idx) = 0
					Next
				Else
					Lampz.State(x.Idx) = 0
					
				End If
			Next
			item.CurrentIdx = 0
		Next
		If gameState("lights")("lightSeqs").Exists(seq.Name) Then
			gameState("lights")("lightSeqs").Remove seq.Name
		End If
	End If
End Sub

Sub StartLightSeq(seq)
	If Not IsNull(seq) Then
		If Not gameState("lights")("lightSeqs").Exists(seq.Name) Then
			gameState("lights")("lightSeqs").Add seq.Name, seq
		End If
	End If
End Sub





'***********************************************************************************************************************
