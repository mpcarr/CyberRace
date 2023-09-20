

Sub StartScorbit
	If IsNull(Scorbit) Then
		If ScorbitActive = 1 then 
			ScorbitExesCheck ' Check the exe's are in the tables folder.
			If ScorbitActive = 1 then ' check again as the check exes may have disabled scorbit
				Set Scorbit = New ScorbitIF
				If Scorbit.DoInit(4152, "CRQR", myVersion, "cyberrace-vpin") then 	' Prod
					tmrScorbit.Interval=2000
					tmrScorbit.UserValue = 0
					tmrScorbit.Enabled=True 
					Scorbit.UploadLog = 0
				End If 
			End If
		End If
	End If
End Sub

Sub InitFlexScorbitDMD()
	If IsNull(FlexDMDScorbit) Then
		Set FlexDMDScorbit = CreateObject("FlexDMD.FlexDMD")
		If FlexDMDScorbit is Nothing Then
			MsgBox "No FlexDMD found. This table will NOT run without it."
			Exit Sub
		End If
		With FlexDMDScorbit
			.ProjectFolder = TablesDir & "\CRQR"
		End With
		FlexDMDScorbit.RenderMode = FlexDMD_RenderMode_DMD_GRAY_4
		FlexDMDScorbit.Width = 400
		FlexDMDScorbit.Height = 100
		FlexDMDScorbit.Clear = True
		FlexDMDScorbit.Show = False
		FlexDMDScorbit.Run = False

		dim scene
		Set scene = FlexDMDScorbit.NewGroup("scene")
		dim qrImage, qrLabel
		Set qrLabel = FlexDMDScorbit.NewLabel("Loading", FlexDMDScorbit.NewFont("FlexDMD.Resources.bm_army-12.fnt", vbWhite, RGB(0, 0, 0), 0), "Loading Scorbit") : qrLabel.Visible = False : scene.AddActor qrLabel
		qrLabel.SetAlignedPosition 200, 50, FlexDMD_Align_Center
		FlexDMDScorbit.LockRenderThread
		FlexDMDScorbit.RenderMode =  FlexDMD_RenderMode_DMD_RGB
		FlexDMDScorbit.Stage.RemoveAll
		FlexDMDScorbit.Stage.AddActor scene
		FlexDMDScorbit.Show = False
		FlexDMDScorbit.Run = True
		FlexDMDScorbit.UnlockRenderThread


		CreateScorebitLoadingDMD()
		'Flasher
		DMDScorebit.Visible = True
		DMDScorebit.TimerEnabled = True
		If ShowDT Then DMDScorebit.RotX = -(Table1.Inclination + Table1.Layback)
	End If

End Sub

Sub DMDScorebit_Timer()
	Dim DMDScoreBitp
	DMDScoreBitp = FlexDMDScorbit.DmdColoredPixels
	If Not IsEmpty(DMDScoreBitp) Then
		DMDScorebit.DMDWidth = FlexDMDScorbit.Width
		DMDScorebit.DMDHeight = FlexDMDScorbit.Height
		DMDScorebit.DMDColoredPixels = DMDScoreBitp
	End If
End Sub

Sub CreateScorebitLoadingDMD

	FlexDMDScorbit.LockRenderThread
	dim scene
	Set scene = FlexDMDScorbit.Stage.GetGroup("scene")
	FlexDMDScorbit.Stage.GetLabel("Loading").Visible = True
	FlexDMDScorbit.Stage.GetLabel("Loading").Text = "LOADING SCORBIT"
	If Not IsNull(Scorbit) Then
		If Scorbit.bNeedsPairing = False Then
			FlexDMDScorbit.Stage.GetLabel("Loading").Text = "PAIRED"
		End If
	End If
	
	FlexDMDScorbit.Stage.GetLabel("Loading").SetAlignedPosition 200, 50, FlexDMD_Align_Center
	If scene.HasChild("QRPairing") = True Then
		FlexDMDScorbit.Stage.GetImage("QRPairing").Visible = False
	End If
	If scene.HasChild("QRClaim") = True Then
		FlexDMDScorbit.Stage.GetImage("QRClaim").Visible = False
	End If
	FlexDMDScorbit.Show = False
	FlexDMDScorbit.Run = True
	FlexDMDScorbit.UnlockRenderThread

End Sub


Sub CreateScorebitPairingDMD

	FlexDMDScorbit.LockRenderThread
	dim scene, qrImage
	Set scene = FlexDMDScorbit.Stage.GetGroup("scene")
	If scene.HasChild("QRPairing") = False Then
		Set qrImage = FlexDMDScorbit.NewImage("QRPairing",		"QRCode.png")	: qrImage.SetBounds 0, 0, 100, 100 : qrImage.Visible = False : scene.AddActor qrImage
	End If
	If Scorbit.bNeedsPairing = True Then
		FlexDMDScorbit.Stage.GetLabel("Loading").Text = "MACHINE NEEDS PAIRING"
	Else
		FlexDMDScorbit.Stage.GetLabel("Loading").Text = "PAIRED"
	End If
	FlexDMDScorbit.Stage.GetLabel("Loading").SetAlignedPosition 250, 50, FlexDMD_Align_Center
	FlexDMDScorbit.Stage.GetLabel("Loading").Visible = True
	If scene.HasChild("QRPairing") = True Then
		FlexDMDScorbit.Stage.GetImage("QRPairing").Visible = True
	End If
	If scene.HasChild("QRClaim") Then
		FlexDMDScorbit.Stage.GetImage("QRClaim").Visible = False
	End If
	FlexDMDScorbit.Show = False
	FlexDMDScorbit.Run = True
	FlexDMDScorbit.UnlockRenderThread

End Sub

Sub CreateScorebitGameDMDClaim

	FlexDMDScorbit.LockRenderThread

	dim scene, qrImage
	Set scene = FlexDMDScorbit.Stage.GetGroup("scene")
	If scene.HasChild("QRClaim") = False Then
		Set qrImage = FlexDMDScorbit.NewImage("QRClaim",		"QRClaim.png")	: qrImage.SetBounds 0, 0, 512, 512 : qrImage.Visible = False : scene.AddActor qrImage
	End If
	

	FlexDMDScorbit.Stage.GetLabel("Loading").Visible = False
	If scene.HasChild("QRPairing") = True Then
		FlexDMDScorbit.Stage.GetImage("QRPairing").Visible = False
	End If
	If scene.HasChild("QRClaim") Then
		FlexDMDScorbit.Stage.GetImage("QRClaim").Visible = True
	End If
	
	FlexDMDScorbit.UnlockRenderThread

End Sub

'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
' X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  
'/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
'  SCORBIT Interface
' To Use:
' 1) Define a timer tmrScorbit
' 2) Call DoInit at the end of PupInit or in Table Init if you are nto using pup with the appropriate parameters
'		if Scorbit.DoInit(389, "PupOverlays", "1.0.0", "GRWvz-MP37P") then 
'			tmrScorbit.Interval=2000
'			tmrScorbit.UserValue = 0
'			tmrScorbit.Enabled=True 
'		End if 
' 3) Customize helper functions below for different events if you want or make your own 
' 4) Call 
'		StartSession - When a game starts 
'		StopSession - When the game is over
'		SendUpdate - When Score Changes
'		SetGameMode - When different game events happen like starting a mode, MB etc.  (ScorbitBuildGameModes helper function shows you how)
' 5) Drop the binaries sQRCode.exe and sToken.exe in your Pup Root so we can create session kets and QRCodes.
' 6) Callbacks 
'		Scorbit_Paired   		- Called when machine is successfully paired.  Hide QRCode and play a sound 
'		Scorbit_PlayerClaimed	- Called when player is claimed.  Hide QRCode, play a sound and display name 
'
'
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
' TABLE CUSTOMIZATION START HERE 


Sub Scorbit_NeedsPairing()								' Scorbit callback when new machine needs pairing 
   
	If bInOptions = False Or Not OptPos=2 Then

		DMDScorebit.Visible = False
		DMDScorebit.TimerEnabled = False
		Scorbit = Null
		tmrScorbit.Enabled=False
		ScorbitActive = 0
		If Not IsNull(FlexDMDScorbit) Then
			FlexDMDScorbit.Show = False
			FlexDMDScorbit.Run = False
			FlexDMDScorbit = NULL
		End If

	Else
		CreateScorebitPairingDMD()
	End If
End Sub 

Sub Scorbit_Paired()								' Scorbit callback when new machine is paired 
	If bInOptions = False Or Not OptPos=2 Then
		DMDScorebit.Visible = False
		DMDScorebit.TimerEnabled = False
		If Not IsNull(FlexDMDScorbit) Then
			FlexDMDScorbit.Show = False
			FlexDMDScorbit.Run = False
			FlexDMDScorbit = NULL
		End If
	Else
		CreateScorebitLoadingDMD()
	End If
	
End Sub 

Sub Scorbit_PlayerClaimed(PlayerNum, PlayerName)	' Scorbit callback when QR Is Claimed 

    MsgBox("Scorbit LOGIN: " & PlayerNum & " - " & PlayerName)
	
'debug.print "Scorbit LOGIN: " & PlayerNum & " - " & PlayerName
	'PlaySound "scorbit_login",0,CalloutVol,0,0,1,1,1
	'ScorbitClaimQR(False)
	'Scorepop.enabled=True
	'Scorepop.interval=3000
	'puPlayer.LabelSet pDMD,"Scorlogo","Gif\\sbt.gif",1,"{'mt':2,'color':111111, 'width': 35, 'height': 30., 'anigif': 130 ,}"
	'puPlayer.LabelSet pDMD,"Player","" & PlayerName ,1,"{'mt':2, 'shadowcolor':10646039, 'shadowstate':2,'xoffset':2, 'yoffset':3, 'bold':1, 'outline':2 }"
	'PUPtodo
	'ShowBallCount False
	'DMD_ShowText PlayerName & " claimed player " & PlayerNum,4,FontScoreInactiv1,30,True,40,2500
	'vpmtimer.addtimer 3000, "ShowBallCount True '"
'	msgbox PlayerName
End Sub 


Sub ScorbitClaimQR(bShow)						'  Show QRCode on first ball for users to claim this position
	'if Scorbit.bSessionActive=False then Exit Sub 
	'if ScorbitShowClaimQR=False then Exit Sub
	'if Scorbit.bNeedsPairing then exit sub 

'	msgbox "Currentplayer and name: " & CurrentPlayer &" - "& Scorbit.GetName(CurrentPlayer)
	'if bShow and balls=1 and bGameInPlay and Scorbit.GetName(CurrentPlayer)="" then 
'		if PupOption=0 or ScorbitClaimSmall=0 then ' Desktop Make it Larger
'			PuPlayer.LabelSet pDMDText, "ScorbitQR", "PuPOverlays\\QRclaim.png",1,"{'mt':2,'width':20, 'height':40,'xalign':0,'yalign':0,'ypos':40,'xpos':5}"
'			PuPlayer.LabelSet pDMDText, "ScorbitQRIcon", "PuPOverlays\\QRcodeB.png",1,"{'mt':2,'width':23, 'height':52,'xalign':0,'yalign':0,'ypos':38,'xpos':3.5,'zback':1}"
'		else 
'			PuPlayer.LabelSet pDMDText, "ScorbitQR", "PuPOverlays\\QRclaim.png",1,"{'mt':2,'width':12, 'height':24,'xalign':0,'yalign':0,'ypos':60,'xpos':5}"
'			PuPlayer.LabelSet pDMDText, "ScorbitQRIcon", "PuPOverlays\\QRcodeB.png",1,"{'mt':2,'width':14, 'height':32.5,'xalign':0,'yalign':0,'ypos':58,'xpos':4,'zback':1}"
'		End if 
		'Show generated QRclaim and qrcodeB here
	'	showQRClaimImage
	'Else 
'		PuPlayer.LabelSet pDMDText, "ScorbitQR", "PuPOverlays\\clear.png",0,""
'		PuPlayer.LabelSet pDMDText, "ScorbitQRIcon", "PuPOverlays\\clear.png",0,""
'		debug.print "make scorbit disappear here"
	'	hideQRClaim
	'End if 
End Sub 

Sub ScorbitBuildGameModes()		' Custom function to build the game modes for better stats 
	dim GameModeStr
	' if Scorbit.bSessionActive=False then Exit Sub 
	' GameModeStr="NA:"

	' Select Case CurrentMission
	' 	case 0:' No Mode Selected
	' 	Case 1: ' THE HUNT
	' 		GameModeStr="NA{green}:The Hunt"
    '     Case 2: ' RESURRECTION
	' 		GameModeStr="NA{red}:Resurrection"
    '     Case 3: ' CHASE
	' 		GameModeStr="NA{blue}:Chase"
    '     Case 4: ' CEMETERY
	' 		GameModeStr="NA{purple}:Cemetery"
    '     Case 5: ' PORTAL ROOM
	' 		GameModeStr="NA{red}:PortalRoom"
    '     Case 6: ' HEARTOFSTEEL
	' 		GameModeStr="NA{purple}:Heart of Steel"
    '     Case 7: ' BETRAYAL
	' 		GameModeStr="NA{blue}:Betrayal"
	' End Select

	' 'MB's
	' if bCoreyMBOngoing then
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"MB{green}:Corey"
	' End if 
	' if bTracyMBOngoing then
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"MB{purple}:Tracy"
	' End if 
	' if bMimaMBOngoing then
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"MB{purple}:Mima"
	' End if

	' 'Wizard
	' if WizardPhase = 1 then 
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"WM{black}:Lockdown"
	' End if 

	' if WizardPhase = 2 then 
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"WM{red}:Rewind Tracy"
	' End if 

	' if WizardPhase = 3 then 
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"WM{white}:Supernova"
	' End if 

	' if WizardPhase = 4 then 
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"WM{red}:Battle Galdor"
	' End if 

	' if WizardPhase = 5 then 
	' 	if GameModeStr<>"" then GameModeStr=GameModeStr & ";"
	' 	GameModeStr=GameModeStr&"WM{orange}:Galdor Defeated"
	' End if 

	'Scorbit.SetGameMode(GameModeStr)

End Sub 

Sub Scorbit_LOGUpload(state)	' Callback during the log creation process.  0=Creating Log, 1=Uploading Log, 2=Done 
	Select Case state 
		case 0:
			'Debug.print "CREATING LOG"
		case 1:
			'Debug.print "Uploading LOG"
		case 2:
			'Debug.print "LOG Complete"
	End Select 
End Sub 
'<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
' TABLE CUSTOMIZATION END HERE - NO NEED TO EDIT BELOW THIS LINE


dim Scorbit : Scorbit = Null
' Workaround - Call get a reference to Member Function
Sub tmrScorbit_Timer()								' Timer to send heartbeat 
	Scorbit.DoTimer(tmrScorbit.UserValue)
	tmrScorbit.UserValue=tmrScorbit.UserValue+1
	if tmrScorbit.UserValue>5 then tmrScorbit.UserValue=0
End Sub 
Function ScorbitIF_Callback()
	Scorbit.Callback()
End Function 
Class ScorbitIF

	Public bSessionActive
	Public bNeedsPairing
	Private bUploadLog
	Private bActive
	Private LOGFILE(10000000)
	Private LogIdx

	Private bProduction

	Private TypeLib
	Private MyMac
	Private Serial
	Private MyUUID
	Private TableVersion

	Private SessionUUID
	Private SessionSeq
	Private SessionTimeStart
	Private bRunAsynch
	Private bWaitResp
	Private GameMode
	Private GameModeOrig		' Non escaped version for log
	Private VenueMachineID
	Private CachedPlayerNames(4)
	Private SaveCurrentPlayer

	Public bEnabled
	Private sToken
	Private machineID
	Private dirQRCode
	Private opdbID
	Private wsh

	Private objXmlHttpMain
	Private objXmlHttpMainAsync
	Private fso
	Private Domain

	Public Sub Class_Initialize()
		bActive="false"
		bSessionActive=False
		bEnabled=False 
	End Sub 

	Property Let UploadLog(bValue)
		bUploadLog = bValue
	End Property

	Sub DoTimer(bInterval)	' 2 second interval
		dim holdScores(4)
		dim i

		if bInterval=0 then 
			SendHeartbeat()
		elseif bRunAsynch then ' Game in play
			Scorbit.SendUpdate GetPlayerScore(1), GetPlayerScore(2), GetPlayerScore(3), GetPlayerScore(4), GetPlayerState(CURRENT_BALL), GetCurrentPlayerNumber(), NumberOfPlayers
		End if 
	End Sub 

	Function GetName(PlayerNum)	' Return Parsed Players name  
		if PlayerNum<1 or PlayerNum>4 then 
			GetName=""
		else 
			GetName=CachedPlayerNames(PlayerNum)
		End if 
	End Function 

	Function DoInit(MyMachineID, Directory_PupQRCode, Version, opdb)
		dim Nad
		Dim EndPoint
		Dim resultStr 
		Dim UUIDParts 
		Dim UUIDFile

		bProduction=1
'		bProduction=0
		SaveCurrentPlayer=0
		VenueMachineID=""
		bWaitResp=False 
		bRunAsynch=False 
		DoInit=False 
		opdbID=opdb
		dirQrCode=Directory_PupQRCode
		MachineID=MyMachineID
		TableVersion=version
		bNeedsPairing=False 
		if bProduction then 
			domain = "api.scorbit.io"
		else 
			domain = "staging.scorbit.io"
			domain = "scorbit-api-staging.herokuapp.com"
		End if 
		'msgbox "production: " & bProduction
		Set fso = CreateObject("Scripting.FileSystemObject")
		dim objLocator:Set objLocator = CreateObject("WbemScripting.SWbemLocator")
		Dim objService:Set objService = objLocator.ConnectServer(".", "root\cimv2")
		Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP")
		Set objXmlHttpMainAsync = CreateObject("Microsoft.XMLHTTP")
		objXmlHttpMain.onreadystatechange = GetRef("ScorbitIF_Callback")
		Set wsh = CreateObject("WScript.Shell")

		' Get Mac for Serial Number 
		dim Nads: set Nads = objService.ExecQuery("Select * from Win32_NetworkAdapter where physicaladapter=true")
		for each Nad in Nads
			if not isnull(Nad.MACAddress) then
				'msgbox "Using MAC Addresses:" & Nad.MACAddress & " From Adapter:" & Nad.description   
				MyMac=replace(Nad.MACAddress, ":", "")
				Exit For 
			End if 
		Next
		Serial=eval("&H" & mid(MyMac, 5))
'		Serial=123456
		debug.print "Serial: " & Serial
		serial = serial + MachineID
		debug.print "New Serial with machine id: " & Serial

		' Get System UUID
		set Nads = objService.ExecQuery("SELECT * FROM Win32_ComputerSystemProduct")
		for each Nad in Nads
			'msgbox "Using UUID:" & Nad.UUID   
			MyUUID=Nad.UUID
			Exit For 
		Next

		if MyUUID="" then 
			MsgBox "SCORBIT - Can get UUID, Disabling."
			Exit Function
		elseif MyUUID="03000200-0400-0500-0006-000700080009" or ScorbitAlternateUUID then
			If fso.FolderExists(UserDirectory) then 
				If fso.FileExists(UserDirectory & "ScorbitUUID.dat") then
					Set UUIDFile = fso.OpenTextFile(UserDirectory & "ScorbitUUID.dat",1)
					MyUUID = UUIDFile.ReadLine()
					UUIDFile.Close
					Set UUIDFile = Nothing
				Else 
					MyUUID=GUID()
					Set UUIDFile=fso.CreateTextFile(UserDirectory & "ScorbitUUID.dat",True)
					UUIDFile.WriteLine MyUUID
					UUIDFile.Close
					Set UUIDFile=Nothing
		End if
			End if 
		End if

		' Clean UUID
		UUIDParts=split(MyUUID, "-")
		'msgbox UUIDParts(0)
		MyUUID=LCASE(Hex(eval("&h" & UUIDParts(0))+MyMachineID)) & UUIDParts(1) &  UUIDParts(2) &  UUIDParts(3) & UUIDParts(4)		 ' Add MachineID to UUID
		'msgbox UUIDParts(0)
		MyUUID=LPad(MyUUID, 32, "0")
'		MyUUID=Replace(MyUUID, "-",  "")
		Debug.print "MyUUID:" & MyUUID 


' Debug
'		myUUID="adc12b19a3504453a7414e722f58737f"
'		Serial="123456778"

		'create own folder for table QRCodes TablesDir & "\" & dirQrCode
		If Not fso.FolderExists(TablesDir & "\" & dirQrCode) then
			fso.CreateFolder(TablesDir & "\" & dirQrCode)
		end if

		' Authenticate and get our token 
		if getStoken() then 
			bEnabled=True 
'			SendHeartbeat
			DoInit=True
		End if 
	End Function 



	Sub Callback()
		Dim ResponseStr
		Dim i 
		Dim Parts
		Dim Parts2
		Dim Parts3
		if bEnabled=False then Exit Sub 

		if bWaitResp and objXmlHttpMain.readystate=4 then 
			'Debug.print "CALLBACK: " & objXmlHttpMain.Status & " " & objXmlHttpMain.readystate
			if objXmlHttpMain.Status=200 and objXmlHttpMain.readystate = 4 then 
				ResponseStr=objXmlHttpMain.responseText
				'Debug.print "RESPONSE: " & ResponseStr

				' Parse Name 
				if CachedPlayerNames(SaveCurrentPlayer-1)="" then  ' Player doesnt have a name
					if instr(1, ResponseStr, "cached_display_name") <> 0 Then	' There are names in the result
						Parts=Split(ResponseStr,",{")							' split it 
						if ubound(Parts)>=SaveCurrentPlayer-1 then 				' Make sure they are enough avail
							if instr(1, Parts(SaveCurrentPlayer-1), "cached_display_name")<>0 then 	' See if mine has a name 
								CachedPlayerNames(SaveCurrentPlayer-1)=GetJSONValue(Parts(SaveCurrentPlayer-1), "cached_display_name")		' Get my name
								CachedPlayerNames(SaveCurrentPlayer-1)=Replace(CachedPlayerNames(SaveCurrentPlayer-1), """", "")
								Scorbit_PlayerClaimed SaveCurrentPlayer, CachedPlayerNames(SaveCurrentPlayer-1)
								'Debug.print "Player Claim:" & SaveCurrentPlayer & " " & CachedPlayerNames(SaveCurrentPlayer-1)
							End if 
						End if
					End if 
				else												    ' Check for unclaim 
					if instr(1, ResponseStr, """player"":null")<>0 Then	' Someone doesnt have a name
						Parts=Split(ResponseStr,"[")						' split it 
'Debug.print "Parts:" & Parts(1)
						Parts2=Split(Parts(1),"}")							' split it 
						for i = 0 to Ubound(Parts2)
'Debug.print "Parts2:" & Parts2(i)
						if instr(1, Parts2(i), """player"":null")<>0 Then
								CachedPlayerNames(i)=""
							End if 
						Next 
					End if 
				End if
			End if 
			bWaitResp=False
		End if 
	End Sub



	Public Sub StartSession()
		if bEnabled=False then Exit Sub 
'msgbox  "Scorbit Start Session" 
		CachedPlayerNames(0)=""
		CachedPlayerNames(1)=""
		CachedPlayerNames(2)=""
		CachedPlayerNames(3)=""
		bRunAsynch=True 
		bActive="true"
		bSessionActive=True
		SessionSeq=0
		SessionUUID=GUID()
		SessionTimeStart=GameTime
		LogIdx=0
		SendUpdate 0, 0, 0, 0, 1, 1, 1
	End Sub 

	Public Sub StopSession(P1Score, P2Score, P3Score, P4Score, NumberPlayers)
		StopSession2 P1Score, P2Score, P3Score, P4Score, NumberPlayers, False
	End Sub 

	Public Sub StopSession2(P1Score, P2Score, P3Score, P4Score, NumberPlayers, bCancel)
		Dim i
		dim objFile
		if bEnabled=False then Exit Sub 
		if bSessionActive=False then Exit Sub 
Debug.print "Scorbit Stop Session" 

		bRunAsynch=False 
		bActive="false" 
		bSessionActive=False
		SendUpdate P1Score, P2Score, P3Score, P4Score, -1, -1, NumberPlayers
'		SendHeartbeat

		if bUploadLog and LogIdx<>0 and bCancel=False then 
			Debug.print "Creating Scorbit Log: Size" & LogIdx
			Scorbit_LOGUpload(0)
'			Set objFile = fso.CreateTextFile(puplayer.getroot&"\" & cGameName & "\sGameLog.csv")
			Set objFile = fso.CreateTextFile(TablesDir & "\CRQR\sGameLog.csv")
			For i = 0 to LogIdx-1 
				objFile.Writeline LOGFILE(i)
			Next 
			objFile.Close
			LogIdx=0
			Scorbit_LOGUpload(1)
'			pvPostFile "https://" & domain & "/api/session_log/", puplayer.getroot&"\" & cGameName & "\sGameLog.csv", False
			pvPostFile "https://" & domain & "/api/session_log/", TablesDir & "\CRQR\sGameLog.csv", False
			Scorbit_LOGUpload(2)
			on error resume next
'			fso.DeleteFile(puplayer.getroot&"\" & cGameName & "\sGameLog.csv")
			fso.DeleteFile(TablesDir & "\CRQR\sGameLog.csv")
			on error goto 0
		End if 

	End Sub 

	Public Sub SetGameMode(GameModeStr)
		GameModeOrig=GameModeStr
		GameMode=GameModeStr
		GameMode=Replace(GameMode, ":", "%3a")
		GameMode=Replace(GameMode, ";", "%3b")
		GameMode=Replace(GameMode, " ", "%20")
		GameMode=Replace(GameMode, "{", "%7B")
		GameMode=Replace(GameMode, "}", "%7D")
	End sub 

	Public Sub SendUpdate(P1Score, P2Score, P3Score, P4Score, CurrentBall, CurrentPlayer, NumberPlayers)
		SendUpdateAsynch P1Score, P2Score, P3Score, P4Score, CurrentBall, CurrentPlayer, NumberPlayers, bRunAsynch
	End Sub 

	Public Sub SendUpdateAsynch(P1Score, P2Score, P3Score, P4Score, CurrentBall, CurrentPlayer, NumberPlayers, bAsynch)
		dim i
		Dim PostData
		Dim resultStr
		dim LogScores(4)

		if bUploadLog then 
			if NumberPlayers>=1 then LogScores(0)=P1Score
			if NumberPlayers>=2 then LogScores(1)=P2Score
			if NumberPlayers>=3 then LogScores(2)=P3Score
			if NumberPlayers>=4 then LogScores(3)=P4Score
			LOGFILE(LogIdx)=DateDiff("S", "1/1/1970", Now()) & "," & LogScores(0) & "," & LogScores(1) & "," & LogScores(2) & "," & LogScores(3) & ",,," &  CurrentPlayer & "," & CurrentBall & ",""" & GameModeOrig & """"
			LogIdx=LogIdx+1
		End if 

		if bEnabled=False then Exit Sub 
		if bWaitResp then exit sub ' Drop message until we get our next response 
'		debug.print "Current players: " & CurrentPlayer
		SaveCurrentPlayer=CurrentPlayer
'		PostData = "session_uuid=" & SessionUUID & "&session_time=" & DateDiff("S", "1/1/1970", Now()) & _
'					"&session_sequence=" & SessionSeq & "&active=" & bActive
		PostData = "session_uuid=" & SessionUUID & "&session_time=" & GameTime-SessionTimeStart+1 & _
					"&session_sequence=" & SessionSeq & "&active=" & bActive

		SessionSeq=SessionSeq+1
		if NumberPlayers > 0 then 
			for i = 0 to NumberPlayers-1
				PostData = PostData & "&current_p" & i+1 & "_score="
				if i <= NumberPlayers-1 then 
                    if i = 0 then PostData = PostData & P1Score
                    if i = 1 then PostData = PostData & P2Score
                    if i = 2 then PostData = PostData & P3Score
                    if i = 3 then PostData = PostData & P4Score
				else 
					PostData = PostData & "-1"
				End if 
			Next 

			PostData = PostData & "&current_ball=" & CurrentBall & "&current_player=" & CurrentPlayer
			if GameMode<>"" then PostData=PostData & "&game_modes=" & GameMode
		End if 
		resultStr = PostMsg("https://" & domain, "/api/entry/", PostData, bAsynch)
		if resultStr<>"" then Debug.print "SendUpdate Resp:" & resultStr
	End Sub 

' PRIVATE BELOW 
	Private Function LPad(StringToPad, Length, CharacterToPad)
	  Dim x : x = 0
	  If Length > Len(StringToPad) Then x = Length - len(StringToPad)
	  LPad = String(x, CharacterToPad) & StringToPad
	End Function

	Private Function GUID()		
		Dim TypeLib
		Set TypeLib = CreateObject("Scriptlet.TypeLib")
		GUID = Mid(TypeLib.Guid, 2, 36)

'		Set wsh = CreateObject("WScript.Shell")
'		Set fso = CreateObject("Scripting.FileSystemObject")
'
'		dim rc
'		dim result
'		dim objFileToRead
'		Dim sessionID:sessionID=puplayer.getroot&"\" & cGameName & "\sessionID.txt"
'
'		on error resume next
'		fso.DeleteFile(sessionID)
'		On error goto 0 
'
'		rc = wsh.Run("powershell -Command ""(New-Guid).Guid"" | out-file -encoding ascii " & sessionID, 0, True)
'		if FileExists(sessionID) and rc=0 then
'			Set objFileToRead = fso.OpenTextFile(sessionID,1)
'			result = objFileToRead.ReadLine()
'			objFileToRead.Close
'			GUID=result
'		else 
'			MsgBox "Cant Create SessionUUID through powershell. Disabling Scorbit"
'			bEnabled=False 
'		End if

	End Function

	Private Function GetJSONValue(JSONStr, key)
		dim i 
		Dim tmpStrs,tmpStrs2
		if Instr(1, JSONStr, key)<>0 then 
			tmpStrs=split(JSONStr,",")
			for i = 0 to ubound(tmpStrs)
				if instr(1, tmpStrs(i), key)<>0 then 
					tmpStrs2=split(tmpStrs(i),":")
					GetJSONValue=tmpStrs2(1)
					exit for
				End if 
			Next 
		End if 
	End Function

	Private Sub SendHeartbeat()
		Dim resultStr
		dim TmpStr
		Dim Command
		Dim rc
'		Dim QRFile:QRFile=puplayer.getroot&"\" & cGameName & "\" & dirQrCode
		Dim QRFile:QRFile=TablesDir & "\" & dirQrCode
		if bEnabled=False then Exit Sub 
		resultStr = GetMsgHdr("https://" & domain, "/api/heartbeat/", "Authorization", "SToken " & sToken)
'Debug.print "Heartbeat Resp:" & resultStr
		If VenueMachineID="" then 

			if resultStr<>"" and Instr(resultStr, """unpaired"":true")=0 then 	' We Paired
				bNeedsPairing=False
				debug.print "Paired"
				Scorbit_Paired()
			else 
				debug.print "Needs Pairing"
				bNeedsPairing=True
				Scorbit_NeedsPairing()
'				if not FScorbitQRIcon.visible then showQRPairImage
			End if 

			TmpStr=GetJSONValue(resultStr, "venuemachine_id")
			if TmpStr<>"" then 
				VenueMachineID=TmpStr
'Debug.print "VenueMachineID=" & VenueMachineID			
'				Command = puplayer.getroot&"\" & cGameName & "\sQRCode.exe " & VenueMachineID & " " & opdbID & " " & QRFile
				debug.print "RUN sqrcode"
				Command = """" & TablesDir & "\sQRCode.exe"" " & VenueMachineID & " " & opdbID & " """ & QRFile & """"
'				msgbox Command
				rc = wsh.Run(Command, 0, False)
			End if 
		End if 
	End Sub 

	Private Function getStoken()
		Dim result
		Dim results
'		dim wsh
		Dim tmpUUID:tmpUUID="adc12b19a3504453a7414e722f58736b"
		Dim tmpVendor:tmpVendor="vscorbitron"
		Dim tmpSerial:tmpSerial="999990104"
'		Dim QRFile:QRFile=puplayer.getroot&"\" & cGameName & "\" & dirQrCode
		Dim QRFile:QRFile=TablesDir & "\" & dirQrCode
'		Dim sTokenFile:sTokenFile=puplayer.getroot&"\" & cGameName & "\sToken.dat"
		Dim sTokenFile:sTokenFile=TablesDir & "\sToken.dat"

		' Set everything up
		tmpUUID=MyUUID
		tmpVendor="vpin"
		tmpSerial=Serial
		
		on error resume next
		fso.DeleteFile("""" & sTokenFile & """")
		On error goto 0 

		' get sToken and generate QRCode
'		Set wsh = CreateObject("WScript.Shell")
		Dim waitOnReturn: waitOnReturn = True
		Dim windowStyle: windowStyle = 0
		Dim Command 
		Dim rc
		Dim objFileToRead

'		msgbox """" & " 55"

'		Command = puplayer.getroot&"\" & cGameName & "\sToken.exe " & tmpUUID & " " & tmpVendor & " " &  tmpSerial & " " & MachineID & " " & QRFile & " " & sTokenFile & " " & domain
		debug.print "RUN sToken"
		Command = """" & TablesDir & "\sToken.exe"" " & tmpUUID & " " & tmpVendor & " " &  tmpSerial & " " & MachineID & " """ & QRFile & """ """ & sTokenFile & """ " & domain
'msgbox "RUNNING:" & Command
		rc = wsh.Run(Command, windowStyle, waitOnReturn)
'msgbox "Return:" & rc
'		if FileExists(puplayer.getroot&"\" & cGameName & "\sToken.dat") and rc=0 then
'		msgbox """" & TablesDir & "\sToken.dat"""
		if FileExists(TablesDir & "\sToken.dat") and rc=0 then
'			Set objFileToRead = fso.OpenTextFile(puplayer.getroot&"\" & cGameName & "\sToken.dat",1)
'			msgbox """" & TablesDir & "\sToken.dat"""
			Set objFileToRead = fso.OpenTextFile(TablesDir & "\sToken.dat",1)
			result = objFileToRead.ReadLine()
			objFileToRead.Close
			Set objFileToRead = Nothing
'msgbox result

			if Instr(1, result, "Invalid timestamp")<> 0 then 
				MsgBox "Scorbit Timestamp Error: Please make sure the time on your system is exact"
				getStoken=False
			elseif Instr(1, result, "Internal Server error")<> 0 then 
				MsgBox "Scorbit Internal Server error ??"
				getStoken=False
			elseif Instr(1, result, ":")<>0 then 
				results=split(result, ":")
				sToken=results(1)
				sToken=mid(sToken, 3, len(sToken)-4)
Debug.print "Got TOKEN:" & sToken
				getStoken=True
			Else 
Debug.print "ERROR:" & result
				getStoken=False
			End if 
		else 
'msgbox "ERROR No File:" & rc
		End if 

	End Function 

	private Function FileExists(FilePath)
		If fso.FileExists(FilePath) Then
			FileExists=CBool(1)
		Else
			FileExists=CBool(0)
		End If
	End Function

	Private Function GetMsg(URLBase, endpoint)
		GetMsg = GetMsgHdr(URLBase, endpoint, "", "")
	End Function

	Private Function GetMsgHdr(URLBase, endpoint, Hdr1, Hdr1Val)
		Dim Url
		Url = URLBase + endpoint & "?session_active=" & bActive
'Debug.print "Url:" & Url  & "  Async=" & bRunAsynch
		objXmlHttpMain.open "GET", Url, bRunAsynch
'		objXmlHttpMain.setRequestHeader "Content-Type", "text/xml"
		objXmlHttpMain.setRequestHeader "Cache-Control", "no-cache"
		if Hdr1<> "" then objXmlHttpMain.setRequestHeader Hdr1, Hdr1Val

'		on error resume next
			err.clear
			objXmlHttpMain.send ""
			if err.number=-2147012867 then 
				MsgBox "Multiplayer Server is down (" & err.number & ") " & Err.Description
				bEnabled=False
			elseif err.number <> 0 then 
				debug.print "Server error: (" & err.number & ") " & Err.Description
			End if 
			if bRunAsynch=False then 
			    Debug.print "Status: " & objXmlHttpMain.status
			    If objXmlHttpMain.status = 200 Then
				    GetMsgHdr = objXmlHttpMain.responseText
				Else 
				    GetMsgHdr=""
			    End if 
			Else 
				bWaitResp=True
				GetMsgHdr=""
			End if 
'		On error goto 0

	End Function

	Private Function PostMsg(URLBase, endpoint, PostData, bAsynch)
		Dim Url

		Url = URLBase + endpoint
'debug.print "PostMSg:" & Url & " " & PostData

		objXmlHttpMain.open "POST",Url, bAsynch
		objXmlHttpMain.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		objXmlHttpMain.setRequestHeader "Content-Length", Len(PostData)
		objXmlHttpMain.setRequestHeader "Cache-Control", "no-cache"
		objXmlHttpMain.setRequestHeader "Authorization", "SToken " & sToken
		if bAsynch then bWaitResp=True 

		on error resume next
			objXmlHttpMain.send PostData
			if err.number=-2147012867 then 
				MsgBox "Multiplayer Server is down (" & err.number & ") " & Err.Description
				bEnabled=False
			elseif err.number <> 0 then 
				'debug.print "Multiplayer Server error (" & err.number & ") " & Err.Description
			End if 
			If objXmlHttpMain.status = 200 Then
				PostMsg = objXmlHttpMain.responseText
			else 
				PostMsg="ERROR: " & objXmlHttpMain.status & " >" & objXmlHttpMain.responseText & "<"
			End if 
		On error goto 0
	End Function

	Private Function pvPostFile(sUrl, sFileName, bAsync)
Debug.print "Posting File " & sUrl & " " & sFileName & " " & bAsync & " File:" & Mid(sFileName, InStrRev(sFileName, "\") + 1)
		Dim STR_BOUNDARY:STR_BOUNDARY  = GUID()
		Dim nFile  
		Dim baBuffer()
		Dim sPostData
		Dim Response

		'--- read file
		Set nFile = fso.GetFile(sFileName)
		With nFile.OpenAsTextStream()
			sPostData = .Read(nFile.Size)
			.Close
		End With
'		fso.Open sFileName For Binary Access Read As nFile
'		If LOF(nFile) > 0 Then
'			ReDim baBuffer(0 To LOF(nFile) - 1) As Byte
'			Get nFile, , baBuffer
'			sPostData = StrConv(baBuffer, vbUnicode)
'		End If
'		Close nFile

		'--- prepare body
		sPostData = "--" & STR_BOUNDARY & vbCrLf & _
			"Content-Disposition: form-data; name=""uuid""" & vbCrLf & vbCrLf & _
			SessionUUID & vbcrlf & _
			"--" & STR_BOUNDARY & vbCrLf & _
			"Content-Disposition: form-data; name=""log_file""; filename=""" & SessionUUID & ".csv""" & vbCrLf & _
			"Content-Type: application/octet-stream" & vbCrLf & vbCrLf & _
			sPostData & vbCrLf & _
			"--" & STR_BOUNDARY & "--"

'Debug.print "POSTDATA: " & sPostData & vbcrlf

		'--- post
		With objXmlHttpMain
			.Open "POST", sUrl, bAsync
			.SetRequestHeader "Content-Type", "multipart/form-data; boundary=" & STR_BOUNDARY
			.SetRequestHeader "Authorization", "SToken " & sToken
			.Send sPostData ' pvToByteArray(sPostData)
			If Not bAsync Then
				Response= .ResponseText
				pvPostFile = Response
Debug.print "Upload Response: " & Response
			End If
		End With

	End Function

	Private Function pvToByteArray(sText)
		pvToByteArray = StrConv(sText, 128)		' vbFromUnicode
	End Function

End Class 
'  END SCORBIT 
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


''QRView support by iaakki
Function GetTablesFolder()
    Dim GTF
    Set GTF = CreateObject("Scripting.FileSystemObject")
    GetTablesFolder= GTF.GetParentFolderName(userdirectory) & "\Tables"
    set GTF = nothing 
End Function

' Checks that all needed binaries are available in correct place..
Sub ScorbitExesCheck
	dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")

	If fso.FileExists(TablesDir & "\sToken.exe") then
'		msgbox "Stoken.exe found at: " & TablesDir & "\sToken.exe"
	else
		msgbox "Stoken.exe NOT found at: " & TablesDir & "\sToken.exe Disabling Scorbit for now."
		Scorbitactive = 0
		SaveValue cGameName, "SCORBIT", ScorbitActive
	end if

	If fso.FileExists(TablesDir & "\sQRCode.exe") then
'		msgbox "sQRCode.exe found at: " & TablesDir & "\sQRCode.exe"
	else
		msgbox "sQRCode.exe NOT found at: " & TablesDir & "\sQRCode.exe Disabling Scorbit for now."
		Scorbitactive = 0
		SaveValue cGameName, "SCORBIT", ScorbitActive
	end if
end sub
