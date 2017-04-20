#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=GGT.ico
#AutoIt3Wrapper_Outfile=GGTunnelGUI.exe
#AutoIt3Wrapper_Outfile_x64=GGTunnelGUIx64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=GGTunnelGUI is a Remote Support tunnel tool to connect to ISDN, VPN and Ramses customers of ALU NL, DE and UK, executed from the Lab, Alcanet or the Internet.
#AutoIt3Wrapper_Res_Description=GGTunnelGui for Windows XP, Vista and Windows7
#AutoIt3Wrapper_Res_Fileversion=4.3.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Henk van der Hulst.
#AutoIt3Wrapper_Res_Field=Author|© 2008-2016 Henk van der Hulst
#AutoIt3Wrapper_Res_Field=Copyright|Henk van der Hulst, © 2008-2017
#AutoIt3Wrapper_Res_Field=CompanyName|NOKIA Netherlands
#AutoIt3Wrapper_Res_Field=ProductName|Remote Support TunnelGUI
#AutoIt3Wrapper_Res_Field=OriginalFilename|GGTunnelGUI.exe
#AutoIt3Wrapper_Res_File_Add=psexec.exe
#AutoIt3Wrapper_Res_File_Add=sqlite3.dll
#AutoIt3Wrapper_Res_File_Add=session_putty_tray
#AutoIt3Wrapper_Res_File_Add=putty_tray.exe
#AutoIt3Wrapper_Res_File_Add=TCPRecvAndFwdTool.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;#RequireAdmin
;#AutoIt3Wrapper_Res_File_Add=TCPRecvAndFwdTool.exe
#Include <File.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <GuiTreeView.au3>
#include <TreeViewConstants.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <SQLite.au3>
;#include <SQLite.dll.au3>
#include <ProgressConstants.au3>
#include <Array.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>
#Include <String.au3>
#include <Date.au3>
#Include <Misc.au3>
#include <GuiEdit.au3>
#include <TabConstants.au3>
#include <Constants.au3>
#include <C:\Users\hhulst\Documents\Spaces\Projects\GGTunnelGUI\encrypt.au3>


;#### KPN-TPA includes ################
#include <Inet.au3>



Opt("TrayOnEventMode",1)
Opt("TrayMenuMode",1)
Opt('MustDeclareVars', 1)
AutoItSetOption("WinDetectHiddenText", 1)

Global $AllCustomers, $cust, $NMS, $aRow, $bRow, $cRow, $dRow, $eRow, $DBmem, $GGDB, $TreeItem, $rootId, $par, $Custmr[50], $CustmrId[50], $nn
Global $hQuery, $hQuery2, $hQuery3, $hQuery4, $uxversion
Global $RadioSwdl, $RadioVPN, $RadioDame, $RadioVLAN, $state, $oneup
Global $GGDIR, $GGDIR214, $GGDIR225, $GGDIR365, $GGDIR1, $x
Global $SwdlPID, $VPCPID, $pingBICSPID, $pingPTPID, $pingEliaPID, $SQliteDB
Global $EssentGWPID, $EssentGW, $GuiTitle, $SSHprivKey_nlsdh1, $SSHnlsdh1User, $nlsdh1_passID, $nlsdh1_pass, $nlsdh1
Global $SSHprivKey_VPC, $VPC_pass, $VPC_passID
Global $pass1Label, $pass2Label, $pass3Label, $pass4Label,$xtop, $ytop, $SSHprivKey_nlsdh1_ID, $SSHprivKey_VPC_ID, $TunnelPID, $DameWarePID
Global $GGDIR1_ID, $GGDIR214_ID, $GGDIR225_ID, $GGDIR365_ID, $EssentGW_ID, $HomeGW, $HomeGW_ID
Global $DameLabel, $DameWarePC_ID, $DameWarePC, $ConnectVia
Global $ADSLWANIP, $ADSLWANIP_ID, $SQLiteDB_ID, $SSHprivKey_VPC_button, $xtop, $ytop, $SSHytop, $i, $s, $progressbar1, $progressLabel
Global $AllTunnelPIDS, $array, $GGDIR_PID, $AllGGDIRPIDS, $array1, $array2, $GGtunnelDir, $GGDIRWIN, $GGDIRWIN4, $PuTTYDIR, $NXDIR, $SessionPIDS
Global $INIFile, $RouteViaGatewayPID, $IPHomeLabel, $UseHomeGW, $UseHomeGW_ID
Global $IconFile, $VNCbuttonID, $hImage, $VNCDIR, $VNCDIR_org, $VNCDIR_button, $VNCDIR_ID
Global $RDPbuttonID, $RDPDIR, $RDPDIRdef, $RDPDIR_org, $RDPDIR_button, $RDPDIR_ID
Global $TVbuttonID, $TVDIR, $TVDIRdef, $TVDIR_org, $TVDIR_button, $TVDIR_ID
Global $treeview, $Customer, $SSHVPCUser, $SSHVPCUser_ID, $SSHVPCUser_org
Global $VPCWait_org, $VPCWait, $VPCWait_ID, $SdhswdlWait_org, $SdhswdlWait, $SdhswdlWait_ID, $DEParents_org, $DEParents_ID,$DE_LAB_Parents_org, $DE_LAB_Parents_ID
Global $Nlsdh1Wait, $Nlsdh1Wait_ID, $Nlsdh1Wait_org, $EssentGWWait_org, $EssentGWWait, $EssentGWWait_ID, $DamewareWait, $DamewareWait_ID, $DamewareWait_org
Global $AlcanetGW, $AlcanetGWPasswd, $AlcanetGWUser, $AlcanetGWPasswd_ID, $AlcanetGWPasswd_org, $AlcanetGWUser_ID
Global $AlcanetGWUser_org, $AlcanetGW_org, $AlcanetGW_ID, $PassEncrypted_ID
Global $AlcanetGWNL, $AlcanetGWNLPasswd, $AlcanetGWNLUser, $AlcanetGWNLPasswd_ID, $AlcanetGWNLPasswd_org, $AlcanetGWNLUser_ID
Global $AlcanetGWNLUser_org, $AlcanetGWNL_org, $AlcanetGWNL_ID
Global $AlcanetGWDE, $AlcanetGWDEPasswd, $AlcanetGWDEUser, $AlcanetGWDEPasswd_ID, $AlcanetGWDEPasswd_org, $AlcanetGWDEUser_ID
Global $AlcanetGWDEUser_org, $AlcanetGWDE_org, $AlcanetGWDE_ID
Global $GGWINuser, $GGWINuser_ID, $GGWINuser_org, $HTTPDIR, $HTTPPID, $HTTPDIR_ID, $HTTPDIR_org, $passPassword, $PublicIP, $TunnelGGWin
Global $HostAddress, $HostAddress_ID, $HostLabel, $HostAddressLabel, $IP, $Host_ID
Global $UserLabel, $User_ID, $PasswordLabel, $Password_ID, $GGPassword, $GGUser, $IniGui, $SSHinfo_ID, $SSHinfo2_ID, $HostInfo_ID
Global $RadioGG, $RadioSSH, $RadioSCP, $RadioWeb, $RadioTelnet, $WinSCPDIR, $EncryptPassword, $PassEncrypted, $DameRemark, $Fileversion, $NewFileVersion, $Download
Global $UpdateGGItem, $UpdateDBItem, $GGUpdateCheck_ID, $DBUpdateCheck_ID, $GGUpdateCheck, $DBUpdateCheck, $DBversion, $DBCountry, $UpdateOnGoing, $UpdateDBOnGoing, $UpdateGGID, $UpdateIP
Global $DEParents, $DEArrayParents, $NLParents, $NLArrayParents, $ArrayParents, $DamewareArrayPCs, $DamewarePCs, $PC, $PCs, $RadioConsole, $CountryGW_ID, $CountryGW, $C
Global $RadioDEGW, $ISDNGW, $nautilus, $rmthtl, $SlsvhoPID, $LastSSHPID, $CheckDialinbutton, $DE_LAB_Parents, $DE_LAB_ArrayParents
Global $SlsvhoUser, $SlsvhoPass, $RmthtlUser, $RmthtlPass

Global $item, $text, $SSHport, $MDsshport, $ggport, $Webport, $Telnetport, $Tunnelstring, $Application, $GObutton, $GoState, $UsernameLoad, $PasswordLoad, $tunssh, $tuntelnet

Global $AppPort, $SSHlport2, $Lanconsole, $RadioTelnetConsole, $RadioWebConsole, $RadioLanConsole, $TelnetConsoleIP, $WebConsoleIP, $LanconsoleIP
Global $TelnetConsoleport,$LanConsoleport,$WebConsoleport, $DameWareHostIP, $SQLquery_server, $x2, $DEBUG, $VNCport, $RDPport, $NXport
Global $SlsvhoWait, $SlsvhoWait_ID, $SlsvhoWait_org, $RadioVNC, $RadioRDP, $Radioftp, $RadioNX, $RadioTV
Global $SSHProductName, $VNCProductName, $VNCCompanyName, $PuTTYLOG, $loadFile, $LoadSession, $Customer_host, $PuTTYSession,$PUTTYDR, $ytopHostInfo,$ybottom
Global $FTPDIR, $ftpgw,$ftpport, $NATportPC1, $NATportPC2,$NATport, $PUTTYDIR_Default_Check_ID, $PUTTYDIR_Default_Check, $tmpPuTTYLOG
Global $VPNHostPC1, $VPNHostPC2, $VPNHostPC3, $VPNHostPC4, $VPNHostPC5, $VPNHostPC6, $VPNHostPC7, $PC1VirtualPC, $PC2VirtualPC, $VirtualPC_ID, $OKbutton, $VPCmsg, $TunnelVPCs
Global $VirtualHostPC1, $VirtualHostPC1Array, $VirtualHostPC2, $VirtualHostPC2Array, $VirtualHostPCArray,$VirtualPC, $VPCLabel, $SSHinfoVPC_ID, $VPC
Global $AllSessionsandPIDs, $VPCGWPID, $VirtualPCsPC1, $VirtualPCsPC2, $SSHtunnels, $x1width, $x2width, $OldPassword, $OldCustomerAndHost
Global $AllPuTTYPIDS, $AllSessionPIDs
Global $Database, $DatabaseArray, $Database_ID, $Databases, $DB, $DBs, $DB_file, $DB_Index, $SQliteDB_old, $GGDBold
Global $LastReadDatabase, $DBCountryBox, $szDrive,$szDir,$szFName,$szExt,$DrvStatus,$APPUSERDIR,$INIDIR, $PSEXECDir, $APPDataDir, $InfoIcon_ID, $CreateInfoLabel,$InfoIcon2_ID, $CreateInfoLabel2
Global $DATABASEDIR, $OSVersion, $FileReady, $PersonalAccounts, $ver, $RASDIAL_TIMEOUT, $RASDIAL_TIMEOUT_ID, $RASDIAL_TIMEOUT_org, $TEMPDIR, $NATportDefault
Global $IT_LAB_Parents, $UK_Parents, $IT_LAB_ArrayParents, $UK_ArrayParents, $SSHWANport2288_ID, $SSHWANport2288, $SSHWANport443_ID, $SSHWANport443, $SSHNATport, $DebugLevels_ID, $DebugLevels
Global $SSHWANport2290_ID, $SSHWANport2290, $NATportPC4, $SSHWANport2291_ID, $SSHWANport2291, $NATportPC5, $NATportPC6, $NATportPC7, $SSHWANport2292_ID, $SSHWANport2292, $SSHWANport2293_ID, $SSHWANport2293
Global $httpDownlDB, $httpDownlGG, $httpGetDBv, $httpGetGGv, $DBid, $DBident, $DBidentArray, $DBpasswd
Global $DBParents,$DBParents_org, $DBParents_ID, $PossibleDBparents, $ShowPasswd, $ShowPasswd_ID, $ReadPW, $InputLength1, $InputLength2, $ShowPasswdLabel, $EmptyUser
Global $UpdateUserPasswd_DB, $DBUpdateFile, $SessionsLogFile, $SessionFWportLogFile
Global $ToolsMenu, $DBUpdateUserPasswdItem, $uQuery, $UserEdit, $ForwardItem
Global $AllowPortForwCheck_ID, $AllowPortForwCheck, $UseHostAsHop, $NewLocalPort, $Hostname
Global $EndHostAddress_ID,$EndHostUser_ID,$EndHostPasswd_ID,$EndHostAddress,$EndHostUser,$EndHostPasswd,$UseHostAsHop_ID, $UseAsJumpHost_Group
Global $JportFwProcess, $array3, $array4, $jPortFWPIDS
Global $SSHWANport2289_ID, $SSHWANport2289, $SSHWANportAuto, $SSHWANportAuto_ID, $NATportPC3, $VirtualPCsPC3, $VirtualHostPC3, $VirtualPCsPC4, $VirtualPCsPC5, $VirtualPCsPC6, $VirtualPCsPC7
Global $VirtualHostPC4, $VirtualHostPC3Array, $VirtualHostPC4Array
Global $ProxyHostname, $ProxyHostname_ID, $ProxyType, $ProxyTypeHTTP_ID, $ProxyTypeNone_ID
Global $ProxyUsername, $ProxyUsername_ID, $ProxyPassword, $ProxyPassword_ID, $ProxyPort, $ProxyPort_ID
Global $ProxyHostname_org, $ProxyPort_org, $ProxyPassword_org, $ProxyType_org, $ProxyUsername_org, $ProxyPassword_ASCIIarray
Global $SCPprivateKey, $RetryAnswer
Global $currentversion, $javahome
Global $OfficeUpdateServ, $VLANUpdateServ, $GGTunnelGuiUpdServ, $GGTunnelGuiUpdServ_ID
Global $InfoIcon3_ID, $CreateInfoLabel3
Global $application_y0, $connectvia_y0, $connectViahigth, $applicationhigth, $ytop0, $oldhostid = ""
;Global $SCPprivateKey

; freeNX variables:
Global $numValidCharList, $dummyString, $password,$scrambled_string, $InstallerVersion
Global $leftDatabase,$topDatabase,$WidthDatabase,$HeightDatabase
Global $GUIwidth, $GUIheight, $leftTreeView, $topTreeView, $HeightTreeView, $WidthTreeView
Global $leftConnectVia, $topConnectVia, $HeightConnectVia, $WidthConnectVia
Global $leftApplication, $topApplication, $HeightApplication, $WidthApplication
Global $leftHostInfo, $topHostInfo, $HeightHostInfo, $WidthHostInfo
Global $leftSSHinfo, $topSSHinfo, $HeightSSHinfo, $WidthSSHinfo

Global $ApplicationLabel1,$ApplicationLabel2, $ApplicationVersion_ID, $ApplicationVersion
Global $leftInfoText, $topInfoText, $topActionButtons, $leftActionButtons
Global $leftAntwerpPC, $topAntwerpPC, $WidthAntwerpPC, $HeightAntwerpPC
Global $leftProgressBar, $topProgressBar, $leftProgressLabel, $topProgressLabel, $version
Global $TV8DIR_ID, $TV8DIR_button, $TV7DIR_ID, $TV7DIR_button, $TV7DIR, $TV8DIR, $TV9DIR_ID, $TV9DIR_button, $TV9DIR, $TV10DIR_ID, $TV10DIR_button, $TV10DIR, $ViaSelected
Global $RamsesActive, $RamsesRASdial
Global $Aventail_DialUp, $OrgProxyAddress, $OrgProxyPort, $LoadedItem, $SSHVPC7User, $CaptivePortal

;################## KPN-TPA Globals ######################


;##############################
;# Variables (will normally not change)
;##############################
; Version number
;Global $sVersion = "20130131";
Global $sVersion = "20130202";
; The KPN internal IPSEC endpoint
Global $sIP, $sHostname = "vpnportal-internal.kpn.com."
Global $arrGW[2][4] = [ _
		["139.156.76.1", "GW-KPN_Haarlem", "https://139.156.76.1/", "kpn01"], _
		["139.156.76.17", "GW-KPN_Aalsmeer", "https://139.156.76.17/", "kpn17"] _
		]
; The RAMSES MD as Proxy.
; The Temp_Spare_RAMSES-DMZ-Fr-Vx will be replaced by a new temp in HFD (NL)
; "France - Alcatel-Lucent" - "RAMSES_Test_Lan2Lan" - "Access Gates" (temp  backup)
; Always use Main_RAMSES-DMZ-Fr-Vz via
; "Netherlands - KPN" - "The_Hague" - "Access Gates" (main connection) <<
Global $ArrFFProxy[2][2] = [ _
		["155.132.4.52", "Temp_Spare_RAMSES-DMZ-Fr-Vx"], _
		["155.132.138.166", "Main_RAMSES-DMZ-Fr-Vz"] _
		]
; The proxy info coming from RAMSES MD and used by FF (and manually on IE)
; [LOCAL Firefox, not FireFoxPortable  - RAMSES Client - Options - Config]
Global $sFFprefs = "C:\Temp\ramses_" & @UserName & "\ramses\tools\firefox\ramses2\prefs.js"
; Rest of variables
Global $sAventailIP, $sTPAgw, $sTPAhl
Global $Input_AventailIP, $Input_RAMSES, $Input_ActiveGW, $Input_ActiveGWHL, $Input_Firefox, $Input_FF_Proxy
Global $msg, $sFFhl, $sRAMSES, $sFFProxy
#forceref $Input_AventailIP, $Input_RAMSES, $Input_ActiveGW, $Input_ActiveGWHL, $Input_Firefox, $Input_FF_Proxy, $msg

;Opt("GUIOnEventMode", 1)

Global $ExitID




Func SetConstants()
	$Fileversion = "4.3.0-Gamma"
	$InstallerVersion = $Fileversion & ".0"
	$ver = FileGetVersion(@ScriptName)
	;$GuiTitle = "Remote Support TunnelGUI v" & $Fileversion & " for Vista"
	$GuiTitle = "Remote Support TunnelGUI v" & $Fileversion
	;$DBversion = "0.74A"
	$SwdlPID = "0"
	$SlsvhoPID = "0"
	$VPCPID = "0"
	$RouteViaGatewayPID = "0"
	$pingBICSPID = "0"
	$pingEliaPID = "0"
	$pingPTPID = "0"
	;$PublicIP = _GetIP()
	$ConnectVia = ""
	$nlsdh1_pass = ""
	$VPC_pass = ""
	$TunnelGGWin = ""
	$DameWarePC = "172.31.208.5"
	$PC1VirtualPC = "10.0.0.101"
	$PC2VirtualPC = "10.0.0.104"
	;$xtop = 190

	;$TreeviewHight = 376
	$xtop = 250
	;$x1width = 160 ;Width of first column
	;$x1width = $TreeviewWidth ;Width of first column
	;$InputLength1 = $x1width - 30
	;$x2 = $TreeviewWidth + 20 ;Xposition of second column (Connect via etc.)

	$x2width = 160 ;Width of second column
	$InputLength2 = $x2width-20
	$InputLength1 = $InputLength2
	;$SSHytop = 335
	;$SSHytop = 368
	$ytop0 = 0
	$SSHytop = 400 + $ytop0
	;$ytopHostInfo = 368
	$ytopHostInfo = $ytop0
	;$SSHytop = 425
	;$ytop = $SSHytop
	$ytop = $ytopHostInfo
	$ybottom = 400 + $ytopHostInfo + 234 + $ytop0
	$application_y0 = 130 + $ytop0
	$connectvia_y0 = 5 + $ytop0
	$connectViahigth = 123
	$applicationhigth = 271

	$leftDatabase = 10
	$topDatabase = 5
	$WidthDatabase = 205

	$leftConnectVia = $leftDatabase + $WidthDatabase + 10
	$topConnectVia = 5
	$HeightConnectVia = 123
	$WidthConnectVia = 160
	$leftApplication = $leftDatabase + $WidthDatabase + 10
	$topApplication = $topConnectVia + $HeightConnectVia + 5
	$HeightApplication = 301
	$WidthApplication = 160


	$HeightDatabase = $HeightConnectVia + 5 + $HeightApplication

	$leftTreeView = 10
	$topTreeView = 10
	$HeightTreeView = $HeightDatabase - 10 - 15
	$WidthTreeView = 191

	$leftHostInfo = $leftDatabase + $WidthDatabase + 10 + $WidthConnectVia + 10
	$topHostInfo = 5
	$HeightHostInfo = 264
	$WidthHostInfo = 160
	;$leftSSHinfo = $leftDatabase + $WidthDatabase + 10 + $WidthConnectVia + 10 + $WidthHostInfo + 10
	$leftSSHinfo = $leftHostInfo
	$topSSHinfo = $topHostInfo + $HeightHostInfo + 10
	$HeightSSHinfo = $HeightDatabase - $HeightHostInfo -10
	$WidthSSHinfo = 160

	$leftInfoText = 10
	$topInfoText = 12 + $HeightDatabase

	$leftProgressBar = $leftConnectVia
	$topProgressBar = $topInfoText -2

	$leftProgressLabel = 10
	$topProgressLabel = $topProgressBar +4

	$leftActionButtons = 20
	$topActionButtons = 10 + $HeightDatabase + 35

	$GUIwidth = 10 + $WidthDatabase + 10 + $WidthConnectVia + 10 + $WidthHostInfo + 10
	$GUIheight = 10 + $HeightDatabase + 10 + 75

	$leftAntwerpPC = $leftHostInfo
	$topAntwerpPC = $HeightHostInfo +10
	$WidthAntwerpPC = 160
	$HeightAntwerpPC = $HeightDatabase - $HeightHostInfo -5

	$AllTunnelPIDS = ""
	$AllGGDIRPIDS = ""
	$AllSessionPIDs = ""
	$SessionPIDS = ""
	$jPortFWPIDS = ""
	$AllSessionsandPIDs = ""
	$AllPuTTYPIDS = ""
	$EncryptPassword = "alcatel"
	$Download = "0"
	$nlsdh1 = "192.168.1.5"
	$nautilus = "149.204.185.77"
	$rmthtl = "149.204.160.235"
	$VPNHostPC1 = "192.168.2.2"
	$VPNHostPC2 = "192.168.2.3"
	$VPNHostPC3 = "192.168.2.4"
	$VPNHostPC4 = "192.168.2.5"
	$VPNHostPC5 = "192.168.2.6"
	$VPNHostPC6 = "10.0.0.200"
	$VPNHostPC7 = "10.0.0.210"
	$UpdateIP = ""
	$PuTTYLOG = "putty_tray.log"
	$LoadSession = "session_putty_tray"
	$OldPassword = ""
	$DBCountry = ""
	$InfoIcon_ID = GUICtrlCreateIcon("shell32.dll", 10, 20, 20)
    $numValidCharList = "85";
    $dummyString = "{{{{";
EndFunc


Func FileExist($DrivePATH)
	_PathSplit($DrivePATH, $szDrive,$szDir,$szFName,$szExt)
	$FileReady = ""
	;0 Failure
	;1 Exsists
	$DrvStatus = DriveGetSerial($szDrive)
	If $DrvStatus Then $FileReady = FileExists($DrivePATH)
	Return $FileReady
EndFunc

Func SetDefaultSettings()
Local $CheckCopy, $FileList, $dbfile
	$DEBUG=""
	;$WorkingDir = @ScriptDir
	$GGTunnelDir = @ScriptDir
	;$APPUSERDIR = @AppDataCommonDir ;Common Application dir
	$APPUSERDIR = @AppDataDir ;Current User Application dir
	$APPDataDir = $APPUSERDIR & "\GGTunnelGui"
	If Not FileExists($APPDataDir) Then DirCreate($APPDataDir)
	;$TEMPDIR = "C:\GGTMP\"
	$TEMPDIR = @TempDir & "\"
	If Not FileExists($TEMPDIR) Then DirCreate($TEMPDIR)
	;MsgBox(0,"file","TCPRecvAndFwdTool.exe" & "AND" & $APPDataDir & "\TCPRecvAndFwdTool.exe")
	If Not FileExists($APPDataDir & "\TCPRecvAndFwdTool.exe") Then FileInstall("TCPRecvAndFwdTool.exe",$APPDataDir & "\TCPRecvAndFwdTool.exe")
	$UpdateUserPasswd_DB = $APPDataDir & "\DBUpdateUserPassword.dat"
	$SessionsLogFile = $APPDataDir & "\GGSessions.log"
	$SessionFWportLogFile = $APPDataDir & "\FWports.log"
	;$INIDIR = $APPDataDir
	;MsgBox(0,"APPDataDir APPUSERDIR",$APPDataDir & " " & $APPUSERDIR & " Appuserdir: " & @AppDataDir & " CommonFIlesDir: " & @CommonFilesDir & "Tempdir: "& @TempDir)

	;$INIDir = $GGtunnelDir
	$UpdateOnGoing = ""
	$UpdateDBOnGoing = ""
	$INIFile = "\GGTunSettings.ini"
	$PassEncrypted = "1"
	$SQliteDB = ""
	$PuTTYDIR = "C:\Program Files\PuTTY\putty.exe"
	;$NXDIR = "C:\Program Files\NX Client for Windows\nxclient.exe"
	$NXDIR = $GGTunnelDir & "\programs\NXclient\"
	;$TVDIR = $GGTunnelDir & "\programs\TeamViewer\TV7\TeamViewer.exe"


	;$RDPDIRdef = @SystemDir & "\mstsc.exe"
	$RDPDIRdef = $GGtunnelDir & "\programs\rdp\rdp.exe"

	If FileExist($GGtunnelDir & "\programs\ftp\") Then
		$FTPDIR = $GGtunnelDir & "\programs\ftp\FileZillaPortable\FileZillaPortable.exe"
	Else
		$FTPDIR = "C:\Program Files\FileZilla\filezilla.exe"
	EndIf
	;$OSVersion = "WIN_VISTA"
	;$OSVersion = "WIN_XP" ; Force Windows XP mode (also when OS is Vista)
	$OSVersion = @OSVersion
	;MsgBox(0,"OSversion",$OSVersion)
	;MsgBox(0,"Program files",@ProgramFilesDir)
	$PUTTYDIR_Default_Check = "1"
	Select
		case ($OSVersion = "WIN_VISTA" Or $OSVersion = "WIN_7" Or $OSVersion = "WIN_2008R2" Or $OSVersion = "WIN_8" Or $OSVersion = "WIN_2008")
			If (Not FileExist($APPDataDir & "\programs\putty\")) Then DirCreate($APPDataDir & "\programs\putty\")
			If Not FileExist($APPDataDir & "\programs\putty\putty_tray.exe") Then FileInstall("putty_tray.exe",$APPDataDir & "\programs\putty\putty_tray.exe")
			If FileExist($APPDataDir & "\programs\putty\putty_tray.exe") Then $PUTTYDIR = $APPDataDir & "\programs\putty\putty_tray.exe"
			$PSEXECDir = $APPDataDir & "\"
			$INIDIR = $APPDataDir
			$DATABASEDIR = $APPDataDir & "\databases"
			if Not FileExist($DATABASEDIR) Then DirCreate($DATABASEDIR)
			If FileExist($GGTunnelDir & "\databases\*.db") Then $CheckCopy = FileCopy($GGTunnelDir & "\databases\*.db",$DATABASEDIR & "\")
			;MsgBox(0,"DB dir",$GGTunnelDir & "\databases\")
			$FileList=_FileListToArray($GGTunnelDir & "\databases\","*.db")
			For $dbfile = 1 to $FileList[0]
				FileCopy($GGTunnelDir & "\databases\" & $FileList[$dbfile],$DATABASEDIR & "\")
				;MsgBox(0,"copy", $FileList[$dbfile] & " TO " & $DATABASEDIR & "\")
			Next
			;_ArrayDisplay($FileList,"$FileList")
			;MsgBox(0,"APPDataDir en DATABASEDIR en GGTunnelDir en INIDIR and CheckCopy",$APPDataDir & " --- " & $DATABASEDIR & " --- " & $GGTunnelDir & " --- " & $INIDIR & "----" & $CheckCopy)
			If Not FileExist($PSEXECDir & "psexec.exe") Then FileInstall("psexec.exe",$PSEXECDir & "psexec.exe")
			if Not FileExist($APPDataDir & "\programs\NXclient\config") Then DirCreate($APPDataDir & "\programs\NXclient\config")
			FileCopy($GGTunnelDir & "\programs\NXclient\nxclient.exe",$APPDataDir & "\programs\NXclient\")
			$NXDIR = $APPDataDir & "\programs\NXclient\"
		case Else
			;MsgBox(0,"OSversion",$OSVersion)
			If Not FileExist($GGtunnelDir & "\programs\putty\") Then DirCreate($GGtunnelDir & "\programs\putty\")
			If Not FileExist($GGtunnelDir & "\programs\putty\putty_tray.exe") Then FileInstall("putty_tray.exe",$GGtunnelDir & "\programs\putty\putty_tray.exe")
			If FileExist($GGtunnelDir & "\programs\putty\putty_tray.exe") Then $PUTTYDIR = $GGtunnelDir & "\programs\putty\putty_tray.exe"
			$PSEXECDir = $GGTunnelDir & "\"
			$INIDIR = $GGTunnelDir
			$DATABASEDIR = $GGTunnelDir & "\databases"
			if Not FileExist($DATABASEDIR) Then DirCreate($DATABASEDIR)
			If Not FileExist($PSEXECDir & "psexec.exe") Then FileInstall("psexec.exe",$PSEXECDir & "psexec.exe")
	EndSelect
	;MsgBox(0,"INIDIR",$INIDIR)

	If FileExists($GGtunnelDir & "\programs\winSCP\WinSCP.exe") Then
		$WinSCPDIR = $GGtunnelDir & "\programs\winSCP\WinSCP.exe"
	Else
		$WinSCPDIR = "C:\Program Files\WinSCP\WinSCP.exe"
	EndIf
	$SSHprivKey_VPC = ""
	$SSHprivKey_nlsdh1 = $GGtunnelDir & "\SSHKeys\id_dsa_PuTTY_ttacvpn.ppk"
	$SSHnlsdh1User = "ttacvpn"
	;$SSHVPCUser = @UserName
	If FileExists($GGtunnelDir & "\programs\graphon\") Then
		$GGDIR1 = $GGtunnelDir & "\programs\graphon\ux11\bridges.exe"
		$GGDIR214 = $GGtunnelDir & "\programs\graphon\ux21\goglobal_ux.exe"
		$GGDIR225 = $GGtunnelDir & "\programs\graphon\ux22\goglobal_ux.exe"
		$GGDIR365 = $GGtunnelDir & "\programs\graphon\go\GLOBAL.EXE"
		$GGDIRWIN = $GGtunnelDir & "\programs\graphon\win\ggw.exe"
		$GGDIRWIN4 = $GGtunnelDir & "\programs\graphon\win4\gg-client.exe"
	Else
		$GGDIR1 = "C:\Program Files\GraphOn\GO-Global UX 1.1\bridges.exe"
		$GGDIR214 = "C:\Program Files\GraphOn\GO-Global UX v2.1.4\goglobal_ux.exe"
		$GGDIR225 = "C:\Program Files\GO-Global for UNIX v2.2\goglobal_ux.exe"
		$GGDIR365 = "C:\Program Files\GO-Global\GLOBAL.EXE"
		$GGDIRWIN = "C:\Program Files\GraphOn\GO-Global Client\ggw.exe"
		$GGDIRWIN4 = "C:\Program Files\GraphOn\GO-Global\Client\gg-client.exe"
	EndIf

	If FileExists($GGtunnelDir & "\programs\vnc\") Then
		$VNCDIR = $GGtunnelDir & "\programs\vnc\vncviewer.exe"
	Else
		$VNCDIR = "C:\Program Files\UltraVNC\vncviewer.exe"
	EndIf
	$HTTPDIR = "C:\Program Files\Internet Explorer\iexplore.exe"
	If FileExists($GGtunnelDir & "\programs\TeamViewer\TV7\") Then
		$TV7DIR = $GGtunnelDir & "\programs\TeamViewer\TV7\TeamViewer.exe"
	Else
		$TV7DIR = "C:\Program Files\TeamViewer\Version7\TeamViewer.exe"
	EndIf
	If FileExists($GGtunnelDir & "\programs\TeamViewer\TV8\") Then
		$TV8DIR = $GGtunnelDir & "\programs\TeamViewer\TV8\TeamViewer.exe"
	Else
		$TV8DIR = "C:\Program Files\TeamViewer\Version8\TeamViewer.exe"
	EndIf
	If FileExists($GGtunnelDir & "\programs\TeamViewer\TV9\") Then
		$TV9DIR = $GGtunnelDir & "\programs\TeamViewer\TV9\TeamViewer.exe"
	Else
		$TV9DIR = "C:\Program Files\TeamViewer\Version9\TeamViewer.exe"
	EndIf
	If FileExists($GGtunnelDir & "\programs\TeamViewer\TV10\") Then
		$TV10DIR = $GGtunnelDir & "\programs\TeamViewer\TV10\TeamViewer.exe"
	Else
		$TV10DIR = "C:\Program Files\TeamViewer\Version10\TeamViewer.exe"
	EndIf
	;$EssentGW = "10.240.12.245"
	$ISDNGW = "192.168.1.5"
	$HomeGW = ""
	$ADSLWANIP = "83.163.172.203"
	$OfficeUpdateServ = "135.85.48.200"
	$GGTunnelGuiUpdServ = "135.85.48.200"
	$VLANUpdateServ = "20.100.100.200"
	$AlcanetGWDE = "slsvho.de.alcatel-lucent.com"
	$AlcanetGWNL = "135.85.48.200"
	$AlcanetGWUser = "alcatel"
	$AlcanetGWPasswd = "alcatel"
	$AlcanetGWNLUser = "alcatel"
	$AlcanetGWNLPasswd = "alcatel"
	$AlcanetGWDEUser = "alcatel"
	$AlcanetGWDEPasswd = "alcatel"
	;$GGWINuser = "hhulst"
	;$GGWINuser = @UserName
	$VPCWait = 11
	$SdhswdlWait = 10
	$SlsvhoWait = 5
	;$EssentGWWait =	5
	$Nlsdh1Wait = 10
	$DamewareWait = 5
	$RASDIAL_TIMEOUT = 20
	$CountryGW = "DE_NOC"
	$DamewarePCs = "172.31.208.5,172.31.208.6"
	$VirtualHostPC1 = "10.0.0.101,10.0.0.102,10.0.0.103"
	$VirtualHostPC2 = "10.0.0.104,10.0.0.105,10.0.0.106"
	$VirtualHostPC3 = "10.0.0.107,10.0.0.108,10.0.0.109"
	$VirtualHostPC4 = "10.0.0.110,10.0.0.111,10.0.0.112"
	$DamewareArrayPCs = StringSplit($DamewarePCs,",")
	$VirtualHostPC1Array = StringSplit($VirtualHostPC1,",")
	$VirtualHostPC2Array = StringSplit($VirtualHostPC2,",")
	$VirtualHostPC3Array = StringSplit($VirtualHostPC3,",")
	$VirtualHostPC4Array = StringSplit($VirtualHostPC4,",")
	$VirtualPCsPC1 = "VirtualPC1-3"
	$VirtualPCsPC2 = "VirtualPC4-6"
	$VirtualPCsPC3 = "VirtualPC7-9"
	$VirtualPCsPC4 = "VirtualPC10-12"
	$VirtualPCsPC5 = "VirtualPC13-15"
	$VirtualPCsPC6 = "VirtualPC-Win7-1"
	$VirtualPCsPC7 = "VirtualPC-Win7-2"
	$SSHlport2 = "2222"
	$NATportPC1 = "443"
	$NATportPC2 = "2288"
	$NATportPC3 = "2289"
	$NATportPC4 = "2290"
	$NATportPC5 = "2291"
	$NATportPC6 = "2292"
	$NATportPC7 = "2293"
	$NATportDefault = $NATportPC2
	$DebugLevels = ""
	$ShowPasswd = "4"
	$AllowPortForwCheck = "4"
	$ProxyType = "None"
	;$ProxyHostname = "gnetcache.alcatel.fr"
	;$ProxyPort = "3128"
	$ProxyHostname = "global.proxy.lucent.com"
	$ProxyPort = "8000"
	$ProxyUsername = @UserName
	$javahome = ""
	$currentversion = ""
	;$RetryAnswer = "0"
	$UpdateGGID = ""
	$OrgProxyAddress = ""
	$OrgProxyPort = ""
	$LoadedItem = "0"
	$SSHVPC7User = "aluras"
	$CaptivePortal = "FALSE"
EndFunc


Func ReadSettings()
	Local $MissingItems, $DrvStatus,$szDrive,$szDrive, $szDir, $szFName, $szExt, $DrvSerial, $RDPDIR1, $CopyCheck, $AlcanetGWNL_read
	$MissingItems = ""
	;MsgBox(0,"GGtunnelIni","Appdir: " & $GGTunnelDir & $INIFile & " INIdir: "& $INIDir & $INIFile)
	If (FileExists($GGTunnelDir & $INIFile) And Not FileExists($INIDir & $INIFile)) Then FileMove($GGTunnelDir & $INIFile,$INIDir & $INIFile)
	If FileExists($INIDir & $INIFile) Then
	;if FileOpen($INIDir & $INIFile,0) <> -1 Then
		$SSHprivKey_VPC = IniRead($INIDir & $INIFile, "SSH key directories", "SSHprivKey_VPC", $SSHprivKey_VPC)
		$SSHprivKey_nlsdh1 = IniRead($INIDir & $INIFile, "SSH key directories", "SSHprivKey_nlsdh1", $SSHprivKey_nlsdh1)
		$SSHnlsdh1User = IniRead($INIDir & $INIFile, "SSH key directories", "SSHnlsdh1uSER", $SSHnlsdh1User)
		$SSHVPCUser = IniRead($INIDir & $INIFile, "SSH key directories", "SSHVPCUser", $SSHVPCUser)
		$SSHVPCUser_org = $SSHVPCUser
		;$AlcanetGWUser = IniRead($INIDir & $INIFile, "SSH key directories", "AlcanetGWUser", $AlcanetGWUser)
		;$AlcanetGWPasswd = IniRead($INIDir & $INIFile, "SSH key directories", "AlcanetGWPasswd", $AlcanetGWPasswd)
		$AlcanetGWNLUser = IniRead($INIDir & $INIFile, "SSH key directories", "AlcanetGWNLUser", $AlcanetGWNLUser)
		$AlcanetGWNLPasswd = IniRead($INIDir & $INIFile, "SSH key directories", "AlcanetGWNLPasswd", $AlcanetGWNLPasswd)
		$AlcanetGWDEUser = IniRead($INIDir & $INIFile, "SSH key directories", "AlcanetGWDEUser", $AlcanetGWDEUser)
		$AlcanetGWDEPasswd = IniRead($INIDir & $INIFile, "SSH key directories", "AlcanetGWDEPasswd", $AlcanetGWDEPasswd)
		$ProxyHostname = IniRead($INIDir & $INIFile, "Proxy", "ProxyHostname", $ProxyHostname)
		$ProxyPort = IniRead($INIDir & $INIFile, "Proxy", "ProxyPort", $ProxyPort)
		$ProxyType = IniRead($INIDir & $INIFile, "Proxy", "ProxyType", $ProxyType)
		$ProxyUsername = IniRead($INIDir & $INIFile, "Proxy", "ProxyUsername", $ProxyUsername)
		;$ProxyPassword = IniRead($INIDir & $INIFile, "Proxy", "ProxyPassword", $ProxyPassword)
		$ProxyPassword = _StringEncrypt(0,IniRead($INIDir & $INIFile, "Proxy", "ProxyPassword", $ProxyPassword),$EncryptPassword)
		;MsgBox(0,"Passwd",$ProxyPassword)
		$GGDIR1 = IniRead($INIDir & $INIFile, "Program directories", "GGDIR1", $GGDIR1)
		$GGDIR214 = IniRead($INIDir & $INIFile, "Program directories", "GGDIR214", $GGDIR214)
		$GGDIR225 = IniRead($INIDir & $INIFile, "Program directories", "GGDIR225", $GGDIR225)
		$GGDIR365 = IniRead($INIDir & $INIFile, "Program directories", "GGDIR365", $GGDIR365)
		$GGDIRWIN = IniRead($INIDir & $INIFile, "Program directories", "GGDIRWIN", $GGDIRWIN)
		$GGDIRWIN4 = IniRead($INIDir & $INIFile, "Program directories", "GGDIRWIN4", $GGDIRWIN4)
		$PuTTYDIR = IniRead($INIDir & $INIFile, "Program directories", "PuTTYDIR", $PuTTYDIR)
		$FTPDIR = IniRead($INIDir & $INIFile, "Program directories", "FTPDIR", $FTPDIR)
		$WinSCPDIR = IniRead($INIDir & $INIFile, "Program directories", "WinSCPDIR", $WinSCPDIR)
		$HTTPDIR = IniRead($INIDir & $INIFile, "Program directories", "HTTPDIR", $HTTPDIR)
		$VNCDIR = IniRead($INIDir & $INIFile, "Program directories", "VNCDIR", $VNCDIR)
		$RDPDIR = IniRead($INIDir & $INIFile, "Program directories", "RDPDIR", $RDPDIR)
		$TV7DIR = IniRead($INIDir & $INIFile, "Program directories", "TV7DIR", $TV7DIR)
		$TV8DIR = IniRead($INIDir & $INIFile, "Program directories", "TV8DIR", $TV8DIR)
		$TV9DIR = IniRead($INIDir & $INIFile, "Program directories", "TV9DIR", $TV9DIR)
		$TV10DIR = IniRead($INIDir & $INIFile, "Program directories", "TV10DIR", $TV10DIR)

		If (Not $ProxyHostname Or $ProxyHostname = "gnetcache.alcatel.fr") Then
			$ProxyHostname = "global.proxy.lucent.com"
			$ProxyPort = "8000"
		EndIf
		If $SSHVPCUser <> $SSHVPC7User Then
			$SSHVPCUser = $SSHVPC7User
			IniWrite($INIDir & $INIFile, "SSH key directories", "SSHVPCUser", $SSHVPCUser)
		EndIf

		If not $RDPDIR Then
			$RDPDIR = $RDPDIRdef
			IniWrite($INIDir & $INIFile, "Program directories", "RDPDIR", $RDPDIR)
		EndIf
		;$RDPDIR = $RDPDIR1
		$GGWINuser = IniRead($INIDir & $INIFile, "Program directories", "GGWINUser", $GGWINUser)
		$SQliteDB = IniRead($INIDir & $INIFile, "SQLite Database", "SQLiteDB", $SQliteDB)
		;If (StringInStr($SQliteDB,@ProgramFilesDir) <> 0 And ($OSVersion = "WIN_VISTA" Or $OSVersion = "WIN_7" Or $OSVersion = "WIN_2008R2" Or $OSVersion = "WIN_8" Or $OSVersion = "WIN_2008")) Then
		If ( ($OSVersion = "WIN_VISTA" Or $OSVersion = "WIN_7" Or $OSVersion = "WIN_2008R2" Or $OSVersion = "WIN_8" Or $OSVersion = "WIN_2008")) Then
			_PathSplit($SQliteDB, $szDrive,$szDir,$szFName,$szExt)
			;If FileExist($GGTunnelDir & "\databases\*.db") Then FileCopy($GGTunnelDir & "\databases\*.db",$DATABASEDIR & "\",8)
			$CopyCheck = FileCopy($GGTunnelDir & "\databases\" & $szFName & $szExt,$DATABASEDIR & "\",0)
			$SQliteDB = $DATABASEDIR & "\" & $szFName & $szExt
			IniWrite($INIDir & $INIFile, "SQLite Database", "SQLiteDB", $SQliteDB)
		EndIf
		$PassEncrypted = IniRead($INIDir & $INIFile, "SQLite Database", "PassEncrypted", $PassEncrypted)
		$DamewarePCs = IniRead($INIDir & $INIFile, "Dameware", "DamewarePCs", $DamewarePCs)
		$DamewareArrayPCs = StringSplit($DamewarePCs,",")
		;$EssentGW = IniRead($INIDir & $INIFile, "Gateways IP", "EssentGW", $EssentGW)
		$HomeGW = IniRead($INIDir & $INIFile, "Gateways IP", "HomeGW", $HomeGW)
		$ADSLWANIP = IniRead($INIDir & $INIFile, "Gateways IP", "ADSLWANIP", $ADSLWANIP)
		$SSHNATport = IniRead($INIDir & $INIFile, "Gateways IP", "SSHNATport", $SSHNATport)
		If not $SSHNATport Then
			$SSHNATport = $NATportDefault
			IniWrite($INIDir & $INIFile, "Gateways IP", "SSHNATport", $SSHNATport)
		EndIf
		;$AlcanetGW = IniRead($INIDir & $INIFile, "Gateways IP", "AlcanetGW", $AlcanetGW)
		$AlcanetGWNL = IniRead($INIDir & $INIFile, "Gateways IP", "AlcanetGWNL", $AlcanetGWNL)
		;MsgBox(0,"NL gateway",$AlcanetGWNL)
		If $AlcanetGWNL = "172.31.7.221" Then IniWrite($INIDir & $INIFile, "Gateways IP", "AlcanetGWNL","135.85.48.200")
		$AlcanetGWDE = IniRead($INIDir & $INIFile, "Gateways IP", "AlcanetGWDE", $AlcanetGWDE)
		$GGTunnelGuiUpdServ = IniRead($INIDir & $INIFile, "Gateways IP", "GGTunnelGuiUpdServ", $GGTunnelGuiUpdServ)
		If $GGTunnelGuiUpdServ = "172.31.7.221" Then IniWrite($INIDir & $INIFile, "Gateways IP", "GGTunnelGuiUpdServ","135.85.48.200")
		If $UpdateIP <> $GGTunnelGuiUpdServ Then
			If $UpdateIP <> $VLANUpdateServ Then $UpdateIP = $GGTunnelGuiUpdServ
		EndIf
		$VPCWait = IniRead($INIDir & $INIFile, "Timers", "VPCWait", $VPCWait)
		$SdhswdlWait = IniRead($INIDir & $INIFile, "Timers", "SdhswdlWait", $SdhswdlWait)
		$SlsvhoWait = IniRead($INIDir & $INIFile, "Timers", "SlsvhoWait", $SlsvhoWait)
		;$EssentGWWait =	IniRead($INIDir & $INIFile, "Timers", "EssentGWWait", $EssentGWWait)
		$Nlsdh1Wait =	IniRead($INIDir & $INIFile, "Timers", "Nlsdh1Wait", $Nlsdh1Wait)
		$DamewareWait =	IniRead($INIDir & $INIFile, "Timers", "DamewareWait", $DamewareWait)
		$RASDIAL_TIMEOUT =	IniRead($INIDir & $INIFile, "Timers", "RASDIAL_TIMEOUT", $RASDIAL_TIMEOUT)
		$GGUpdateCheck = Iniread($INIDir & $INIFile, "Updates", "GGUpdateCheck", $GGUpdateCheck)
		$SlsvhoUser = Iniread($INIDir & $INIFile, "DEISDN", "SlsvhoUser", $SlsvhoUser)
		$SlsvhoPass = Iniread($INIDir & $INIFile, "DEISDN", "SlsvhoPass", $SlsvhoPass)
		$RmthtlUser = Iniread($INIDir & $INIFile, "DEISDN", "RmthtlUser", $RmthtlUser)
		$RmthtlPass = Iniread($INIDir & $INIFile, "DEISDN", "RmthtlPass", $RmthtlPass)

		$DEBUG = Iniread($INIDir & $INIFile, "Maintenance", "DEBUG", $DEBUG)
		If $DEBUG = "Y" Then
			$DEBUG = "1 4 9"
			IniWrite($INIDir & $INIFile, "Maintenance", "DEBUG", $DEBUG)
		EndIf
		$PUTTYDIR_Default_Check = Iniread($INIDir & $INIFile, "Program directories", "PuTTYAPPDEF", $PUTTYDIR_Default_Check)
		;MsgBox(0,"PUTTY DEF", $PUTTYDIR_Default_Check)
		If $PUTTYDIR_Default_Check = 1 Then
			Select
				Case ($OSVersion = "WIN_VISTA" Or $OSVersion = "WIN_7" Or $OSVersion = "WIN_2008R2" Or $OSVersion = "WIN_8" Or $OSVersion = "WIN_2008")
					If FileExists($APPDataDir & "\programs\putty\putty_tray.exe") Then $PUTTYDIR = $APPDataDir & "\programs\putty\putty_tray.exe"
				Case Else
					If FileExists($GGtunnelDir & "\programs\putty\putty_tray.exe") Then $PUTTYDIR = $GGtunnelDir & "\programs\putty\putty_tray.exe"
			EndSelect
			;If FileExists($GGtunnelDir & "\programs\putty\putty_tray.exe") Then $PuTTYDIR = $GGtunnelDir & "\programs\putty\putty_tray.exe"
			IniWrite($INIDir & $INIFile, "Program directories", "PuTTYAPPDEF", $PUTTYDIR_Default_Check)
			IniWrite($INIDir & $INIFile, "Program directories", "PuTTYDIR", $PuTTYDIR)
		EndIf
		$SSHProductName = FileGetVersion ( $PuTTYDIR ,"ProductName" )
		$VNCProductName = FileGetVersion ( $VNCDIR ,"ProductName" )
		$VNCCompanyName = FileGetVersion ( $VNCDIR ,"CompanyName" )
		If Not $SSHnlsdh1User Then $MissingItems = $MissingItems & "- Nlsdh1 SSH user" & @CRLF

		_PathSplit($SSHprivKey_nlsdh1, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- Nlsdh1 SSH-key" & @CRLF
		ElseIf Not FileExists($SSHprivKey_nlsdh1) Then
			$MissingItems = $MissingItems & "- Nlsdh1 SSH-key" & @CRLF
		EndIf

		;If Not $SSHVPCUser Then $SSHVPCUser = "aluras"
		If Not $SSHVPCUser Then $MissingItems = $MissingItems & "- VPNHostPC SSH user" & @CRLF

		_PathSplit($SSHprivKey_VPC, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- VPNHostPC SSH-key" & @CRLF
		ElseIf Not FileExists($SSHprivKey_VPC) Then
			$MissingItems = $MissingItems & "- VPNHostPC SSH-key" & @CRLF
		EndIf

		If Not $GGWINuser Then $MissingItems = $MissingItems & "- GoGlobal for Windows user" & @CRLF

		_PathSplit($GGDIR1, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- GOGlobal-Bridges 1.1" & @CRLF
		ElseIf Not FileExists($GGDIR1) Then
			$MissingItems = $MissingItems & "- GOGlobal-Bridges 1.1" & @CRLF
		EndIf

		_PathSplit($GGDIR214, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- GOGlobal-UX 2.1" & @CRLF
		ElseIf Not FileExists($GGDIR214) Then
			$MissingItems = $MissingItems & "- GOGlobal-UX 2.1" & @CRLF
		EndIf

		_PathSplit($GGDIR225, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- GOGlobal-UX 2.2" & @CRLF
		ElseIf Not FileExists($GGDIR225) Then
			$MissingItems = $MissingItems & "- GOGlobal-UX 2.2" & @CRLF
		EndIf

		_PathSplit($GGDIR365, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- GOGlobal 3.65" & @CRLF
		ElseIf Not FileExists($GGDIR365) Then
			$MissingItems = $MissingItems & "- GOGlobal 3.65" & @CRLF
		EndIf

		_PathSplit($GGDIRWIN, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- GOGlobal for Windows" & @CRLF
		ElseIf Not FileExists($GGDIRWIN) Then
			$MissingItems = $MissingItems & "- GOGlobal for Windows" & @CRLF
		EndIf

		_PathSplit($GGDIRWIN4, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- GOGlobal for Windows Cloud 4" & @CRLF
		ElseIf Not FileExists($GGDIRWIN4) Then
			$MissingItems = $MissingItems & "- GOGlobal for Windows Cloud 4" & @CRLF
		EndIf

		_PathSplit($HTTPDIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- Webbrowser" & @CRLF
		ElseIf Not FileExists($HTTPDIR) Then
			$MissingItems = $MissingItems & "- Webbrowser" & @CRLF
		EndIf

		_PathSplit($PuTTYDIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- PuTTY" & @CRLF
		ElseIf Not FileExists($PuTTYDIR) Then
			$MissingItems = $MissingItems & "- PuTTY" & @CRLF
		EndIf

		_PathSplit($FTPDIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- FileZilla" & @CRLF
		ElseIf Not FileExists($FTPDIR) Then
			$MissingItems = $MissingItems & "- FileZilla" & @CRLF
		EndIf

		_PathSplit($WinSCPDIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- (Win)SCP" & @CRLF
		ElseIf Not FileExists($WinSCPDIR) Then
			$MissingItems = $MissingItems & "- (Win)SCP" & @CRLF
		EndIf

		_PathSplit($VNCDIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- VNC-viewer" & @CRLF
		ElseIf Not FileExists($VNCDIR) Then
			$MissingItems = $MissingItems & "- VNC-viewer" & @CRLF
		EndIf

		_PathSplit($RDPDIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- RDP-viewer" & @CRLF
		ElseIf Not FileExists($RDPDIR) Then
			$MissingItems = $MissingItems & "- RDP-viewer" & @CRLF
		EndIf

		_PathSplit($TV7DIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- TeamViewer7" & @CRLF
		ElseIf Not FileExists($TV7DIR) Then
			$MissingItems = $MissingItems & "- TeamViewer7" & @CRLF
		EndIf

		_PathSplit($TV8DIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- TeamViewer8" & @CRLF
		ElseIf Not FileExists($TV8DIR) Then
			$MissingItems = $MissingItems & "- TeamViewer8" & @CRLF
		EndIf


		_PathSplit($TV9DIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- TeamViewer9" & @CRLF
		ElseIf Not FileExists($TV9DIR) Then
			$MissingItems = $MissingItems & "- TeamViewer9" & @CRLF
		EndIf


		_PathSplit($TV10DIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- TeamViewer10" & @CRLF
		ElseIf Not FileExists($TV10DIR) Then
			$MissingItems = $MissingItems & "- TeamViewer10" & @CRLF
		EndIf

		_PathSplit($SQliteDB, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- SQLite database" & @CRLF
		ElseIf Not FileExists($SQliteDB) Then
			$MissingItems = $MissingItems & "- SQLite database" & @CRLF
		EndIf

		;If Not $DEParents Then $MissingItems = $MissingItems & "- DE database Parents" & @CRLF
		;If Not $DE_LAB_Parents Then $MissingItems = $MissingItems & "- DE_LAB database Parents" & @CRLF
		If Not $DamewarePCs Then $MissingItems = $MissingItems & "- List of Antwerp PC's" & @CRLF


		_PathSplit($HTTPDIR, $szDrive,$szDir,$szFName,$szExt)
		$DrvStatus = DriveGetSerial($szDrive)
		If Not $DrvStatus Then
			$MissingItems = $MissingItems & "- Webbrowser" & @CRLF
		ElseIf Not FileExists($HTTPDIR) Then
			$MissingItems = $MissingItems & "- Webbrowser" & @CRLF
		EndIf

		;If Not $HomeGW Then $MissingItems = $MissingItems & "- Home Gateway" & @CRLF

		If $MissingItems Then MsgBox(48,"Missing or wrong Information!","Following items not found: " & @CRLF & $MissingItems)
	Else
		MsgBox(48,"No ini file found!","No settings ini file found at: " & @CRLF & $INIDir & "." & @CRLF & "Please look at Options -> Settings to set directives.")
	EndIf
	;FileClose($INIDir & $INIFile)
EndFunc ; Function ReadSettings


Func Settings()
	Local $textlen = 320
	Local $SaveSetButton, $msg, $SettingGui, $CancelSetbutton, $ApplySetbutton
	Local $SSHprivKey_VPC_org, $SSHprivKey_nlsdh1_org, $GGDIR1_org, $GGDIR214_org, $GGDIR225_org, $GGDIR365_org
	Local $SSHprivKey_VPC_org, $SSHprivKey_nlsdh1_org, $GGDIR1_org, $GGDIR214_org, $GGDIR225_org, $GGDIR365_org
	Local $EssentGW_org, $HomeGW_org, $ADSLWANIP_org, $SQliteDB_org, $SSHprivKey_nlsdh1_button, $ypos, $xpos
	Local $GGDIR1_button, $GGDIR214_button, $GGDIR225_button, $GGDIR365_button, $EssentGW_button, $HomeGW_button
	Local $SQliteDB_button, $ADSLWANIP_button, $GGDIRWIN_button, $GGDIRWIN_ID, $GGDIRWIN_org, $HTTPDIR_button
	Local $GGDIRWIN4_button, $GGDIRWIN4_ID, $GGDIRWIN4_org
	Local $PuTTYDIR_button, $PuTTYDIR_ID, $PuTTYDIR_org, $ApPath, $SSHnlsdh1User_org, $SSHnlsdh1User_ID
	Dim $szDrive, $szDir, $szFName, $szExt
	Local $tab, $tab0, $tab1, $tab2, $tab3, $tab4, $tab5, $tab6, $tab7, $tab8
	Local $WinSCPDIR_ID, $WinSCPDIR_button, $WinSCPDIR_org, $ypos, $ystartpos, $xleft, $xbutleft, $WidthGui, $HightGui
	Local $FTPDIR_org, $FTPDIR_ID, $FTPDIR_button, $SSHNATport_org, $DebugLevels_org, $GGTunnelGuiUpdServ_org
	Local $TV7DIR_org, $TV8DIR_org, $TV9DIR_org, $TV10DIR_org

	$PuTTYDIR_org = $PuTTYDIR
	$FTPDIR_org = $FTPDIR
	$WinSCPDIR_org = $WinSCPDIR
	$SSHprivKey_VPC_org = $SSHprivKey_VPC
	$SSHprivKey_nlsdh1_org = $SSHprivKey_nlsdh1
	$SSHnlsdh1User_org = $SSHnlsdh1User
	$SSHVPCUser_org = $SSHVPCUser
	$GGDIR1_org = $GGDIR1
	$GGDIR214_org = $GGDIR214
	$GGDIR225_org = $GGDIR225
	$GGDIR365_org = $GGDIR365
	$GGDIRWIN_org = $GGDIRWIN
	$GGDIRWIN4_org = $GGDIRWIN4
	$GGWINuser_org = $GGWINuser
	$HTTPDIR_org = $HTTPDIR
	$VNCDIR_org = $VNCDIR
	$RDPDIR_org = $RDPDIR
	$TV7DIR_org = $TV7DIR
	$TV8DIR_org = $TV8DIR
	$TV9DIR_org = $TV9DIR
	$TV10DIR_org = $TV10DIR
	;$EssentGW_org = $EssentGW
	$HomeGW_org = $HomeGW
	$ADSLWANIP_org = $ADSLWANIP
	$SQliteDB_org = $SQliteDB
	$VPCWait_org = $VPCWait
	$SdhswdlWait_org = $SdhswdlWait
	$SlsvhoWait_org = $SlsvhoWait
	;$EssentGWWait_org = $EssentGWWait
	$Nlsdh1Wait_org = $Nlsdh1Wait
	$DamewareWait_org = $DamewareWait
	$RASDIAL_TIMEOUT_org = $RASDIAL_TIMEOUT
	$AlcanetGW_org = $AlcanetGW
	$SSHNATport_org = $SSHNATport
	;$AlcanetGWUser_org = $AlcanetGWUser
	;$AlcanetGWPasswd_org = $AlcanetGWPasswd
	$AlcanetGWNL_org = $AlcanetGWNL
	;MsgBox(0,"Settings",$AlcanetGWNL_org)
	$AlcanetGWNLUser_org = $AlcanetGWNLUser
	$AlcanetGWNLPasswd_org = $AlcanetGWNLPasswd
	$AlcanetGWDE_org = $AlcanetGWDE
	$AlcanetGWDEUser_org = $AlcanetGWDEUser
	$AlcanetGWDEPasswd_org = $AlcanetGWDEPasswd
	$GGTunnelGuiUpdServ_org = $GGTunnelGuiUpdServ
	$DBParents_org = $DBParents
	$ProxyHostname_org = $ProxyHostname
	$ProxyPort_org = $ProxyPort
	$ProxyPassword_org = $ProxyPassword
	$ProxyType_org = $ProxyType
	$ProxyUsername_org = $ProxyUsername
	;$DE_LAB_Parents_org = $DE_LAB_Parents
	$DebugLevels_org = $DebugLevels
	$ystartpos = 50+20
	$xleft = 20
	$xbutleft = 350
	$WidthGui = 535
	$HightGui = 620
	GUICreate($GuiTitle & " - Settings", $WidthGui, $HightGui)
	$tab = GUICtrlCreateTab(10, 10, $WidthGui-20, $HightGui-60,$TCS_MULTILINE)
	;$tab = GUICtrlCreateTab(10, 10, $WidthGui-20, $HightGui-60)


	$tab0 = GUICtrlCreateTabItem("Program Directories 1")

    $ypos=$ystartpos
	GUICtrlCreateLabel("GOGlobal-Bridges:",$xleft,$ypos,$textlen)
	$GGDIR1_ID = GUICtrlCreateInput($GGDIR1,$xleft,$ypos+15,$textlen,20)
	$GGDIR1_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("GOGlobal-UX2.1.x:",$xleft,$ypos,$textlen)
	$GGDIR214_ID = GUICtrlCreateInput($GGDIR214,$xleft,$ypos+15,$textlen,20)
	$GGDIR214_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("GOGlobal-UX2.2.x:",$xleft,$ypos,$textlen)
	$GGDIR225_ID = GUICtrlCreateInput($GGDIR225,$xleft,$ypos+15,$textlen,20)
	$GGDIR225_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("GOGlobal-3.65:",$xleft,$ypos,$textlen)
	$GGDIR365_ID = GUICtrlCreateInput($GGDIR365,$xleft,$ypos+15,$textlen,20)
	$GGDIR365_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("GOGlobal for Windows 3.x:",$xleft,$ypos,$textlen)
	$GGDIRWIN_ID = GUICtrlCreateInput($GGDIRWIN,$xleft,$ypos+15,$textlen,20)
	$GGDIRWIN_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("GOGlobal for Windows Cloud 4.x:",$xleft,$ypos,$textlen)
	$GGDIRWIN4_ID = GUICtrlCreateInput($GGDIRWIN4,$xleft,$ypos+15,$textlen,20)
	$GGDIRWIN4_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("PuTTY:",$xleft,$ypos,40)
	$PUTTYDIR_Default_Check_ID = GUICtrlCreateCheckbox("Set to GGTunnelGui prefered application !", $xleft + 50, $ypos-4,214,20, $BS_RIGHT)
	GUICtrlSetState($PUTTYDIR_Default_Check_ID,$PUTTYDIR_Default_Check)
	$PuTTYDIR_ID = GUICtrlCreateInput($PuTTYDIR,$xleft,$ypos+16,$textlen,20)
	$PuTTYDIR_button = GUICtrlCreateButton("...",350,$ypos+16,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("WinSCP:",$xleft,$ypos,$textlen)
	$WinSCPDIR_ID = GUICtrlCreateInput($WinSCPDIR,$xleft,$ypos+15,$textlen,20)
	$WinSCPDIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)

	$ypos = $ypos + 45

	$tab1 = GUICtrlCreateTabItem("Program Directories 2")

    $ypos=$ystartpos
	GUICtrlCreateLabel("VNC viewer:",$xleft,$ypos,$textlen)
	$VNCDIR_ID = GUICtrlCreateInput($VNCDIR,$xleft,$ypos+15,$textlen,20)
	$VNCDIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("Remote Desktop viewer:",$xleft,$ypos,$textlen)
	$RDPDIR_ID = GUICtrlCreateInput($RDPDIR,$xleft,$ypos+15,$textlen,20)
	$RDPDIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("Web Browser:",$xleft,$ypos,$textlen)
	$HTTPDIR_ID = GUICtrlCreateInput($HTTPDIR,$xleft,$ypos+15,$textlen,20)
	$HTTPDIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("Ftp (FileZilla):",$xleft,$ypos,$textlen)
	$FTPDIR_ID = GUICtrlCreateInput($FTPDIR,$xleft,$ypos+15,$textlen,20)
	$FTPDIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("TeamViewer7:",$xleft,$ypos,$textlen)
	$TV7DIR_ID = GUICtrlCreateInput($TV7DIR,$xleft,$ypos+15,$textlen,20)
	$TV7DIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("TeamViewer8:",$xleft,$ypos,$textlen)
	$TV8DIR_ID = GUICtrlCreateInput($TV8DIR,$xleft,$ypos+15,$textlen,20)
	$TV8DIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("TeamViewer9:",$xleft,$ypos,$textlen)
	$TV9DIR_ID = GUICtrlCreateInput($TV9DIR,$xleft,$ypos+15,$textlen,20)
	$TV9DIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("TeamViewer10:",$xleft,$ypos,$textlen)
	$TV10DIR_ID = GUICtrlCreateInput($TV10DIR,$xleft,$ypos+15,$textlen,20)
	$TV10DIR_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 45

	$tab2 = GUICtrlCreateTabItem("Authorization Info")
    $ypos=$ystartpos
	GUICtrlCreateGroup("nlsdh1:", $xleft-5, $ypos, $textlen+50, 115)
	$ypos = $ypos + 20
	GUICtrlCreateLabel("SSH username nlsdh1 (group account):",$xleft,$ypos,$textlen)
	$SSHnlsdh1User_ID = GUICtrlCreateInput($SSHnlsdh1User,$xleft,$ypos+15,$textlen,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("SSH private key nlsdh1:",$xleft,$ypos,$textlen)
	$SSHprivKey_nlsdh1_ID = GUICtrlCreateInput($SSHprivKey_nlsdh1,$xleft,$ypos+15,$textlen,20)
	$SSHprivKey_nlsdh1_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 65
	GUICtrlCreateGroup("VPNHostPC:", $xleft-5, $ypos, $textlen+50, 115)
	$ypos = $ypos + 20
	GUICtrlCreateLabel("SSH username VPNHostPC:",$xleft,$ypos,$textlen)
	$SSHVPCUser_ID = GUICtrlCreateInput($SSHVPCUser,$xleft,$ypos+15,$textlen,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("SSH private key VPNHostPC:",$xleft,$ypos,$textlen)
	$SSHprivKey_VPC_ID = GUICtrlCreateInput($SSHprivKey_VPC,$xleft,$ypos+15,$textlen,20)
	$SSHprivKey_VPC_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)
	$ypos = $ypos + 65
	GUICtrlCreateGroup("Alcanet-Lab Gateways:", $xleft-5, $ypos, $textlen+50, 170)
	$ypos = $ypos + 20
	GUICtrlCreateGroup("Alcanet-Lab Gateway NL:", $xleft, $ypos, $textlen, 65)
	$ypos = $ypos + 20
	GUICtrlCreateLabel("SSH username:",$xleft+5,$ypos,$textlen/2)
	$AlcanetGWNLUser_ID = GUICtrlCreateInput($AlcanetGWNLUser,$xleft+5,$ypos+15,$textlen/2-20,20)
	GUICtrlCreateLabel("SSH password:",$xleft+160,$ypos,$textlen/2)
	$AlcanetGWNLPasswd_ID = GUICtrlCreateInput($AlcanetGWNLPasswd,$xleft+($textlen/2),$ypos+15,$textlen/2-20,20)
	$ypos = $ypos + 55
	GUICtrlCreateGroup("Alcanet-Lab Gateway DE:", $xleft, $ypos, $textlen, 65)
	$ypos = $ypos + 20
	GUICtrlCreateLabel("SSH username:",$xleft+5,$ypos,$textlen/2)
	$AlcanetGWDEUser_ID = GUICtrlCreateInput($AlcanetGWDEUser,$xleft+5,$ypos+15,$textlen/2-20,20)
	GUICtrlCreateLabel("SSH password:",$xleft+160,$ypos,$textlen/2)
	$AlcanetGWDEPasswd_ID = GUICtrlCreateInput($AlcanetGWDEPasswd,$xleft+($textlen/2),$ypos+15,$textlen/2-20,20)
	$ypos = $ypos + 65
	GUICtrlCreateLabel("GOGlobal for Windows username (personal account):",$xleft,$ypos,$textlen)
	$GGWINuser_ID = GUICtrlCreateInput($GGWINuser,$xleft,$ypos+15,$textlen,20)

	$tab3 = GUICtrlCreateTabItem("Proxy")
    $ypos=$ystartpos
	GUICtrlCreateGroup("Controlling proxy usage", $xleft-5, $ypos, $textlen+50, 225)
	$ypos = $ypos + 20
	GUICtrlCreateLabel("Proxy type:",$xleft,$ypos,$textlen)
	$ProxyTypeNone_ID = GUICtrlCreateRadio("None ", $xleft, $ypos+15, 50, 22, $BS_LEFT)
	$ProxyTypeHTTP_ID = GUICtrlCreateRadio("HTTP ", $xleft + 55, $ypos+15, 50, 22, $BS_LEFT)
	If $ProxyType = "None" Then
		GUICtrlSetState($ProxyTypeNone_ID, $GUI_CHECKED)
	ElseIf $ProxyType = "HTTP" Then
		GUICtrlSetState($ProxyTypeHTTP_ID, $GUI_CHECKED)
		$SSHNATport = "443"
	EndIf
	$ypos = $ypos + 45
	GUICtrlCreateLabel("Proxy hostname:",$xleft,$ypos,$textlen)
	$ProxyHostname_ID = GUICtrlCreateInput($ProxyHostname,$xleft,$ypos+15,$textlen-70,20)
    GUICtrlCreateLabel("Port:",$xleft+$textlen-70+5,$ypos,40)
	$ProxyPort_ID = GUICtrlCreateInput($ProxyPort,$xleft+$textlen-70+5,$ypos+15,45,20)
	$ypos = $ypos + 50
	GUICtrlCreateLabel("Username:",$xleft,$ypos,$textlen)
	$ProxyUsername_ID = GUICtrlCreateInput($ProxyUsername,$xleft,$ypos+15,$textlen-70,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("Password:",$xleft,$ypos,$textlen)
	$ProxyPassword_ID = GUICtrlCreateInput($ProxyPassword,$xleft,$ypos+15,$textlen-70,20,$ES_PASSWORD)
	SetInfoText2("Password will be set encrypted in INI file!",$xleft,$ypos+40)

    $ypos=$ystartpos
	$tab4 = GUICtrlCreateTabItem("IP addresses")
	;GUICtrlCreateLabel("IP Essent Gateway:",$xleft,$ypos,$textlen)
	;$EssentGW_ID = GUICtrlCreateInput($EssentGW,$xleft,$ypos+15,100,20)
	;$ypos = $ypos + 45
	GUICtrlCreateLabel("Home Internet Gateway:   (to bypass ALU-proxy if possible)",$xleft,$ypos,$textlen)
	$HomeGW_ID = GUICtrlCreateInput($HomeGW,$xleft,$ypos+15,100,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("ADSL-TTAC WAN IP:",$xleft,$ypos,$textlen)
	$ADSLWANIP_ID = GUICtrlCreateInput($ADSLWANIP,$xleft,$ypos+15,100,20)
	GUICtrlCreateLabel("Port:",$xleft + 105, $ypos+17, 25)

	;$GGUpdateCheck_ID = GUICtrlCreateCheckbox("Check GGTunnelGui App and DB updates at startup.", $xleft, $ypos, 270, 20, $BS_RIGHT)
	;GUICtrlSetState($GGUpdateCheck_ID,$GGUpdateCheck)

	$SSHWANport443_ID = GUICtrlCreateRadio("443 ", $xleft + 140, $ypos+15, 50, 22, $BS_LEFT)
	;GUICtrlSetState($SSHWANport2288_ID,$SSHWANport2288)
	$SSHWANport2288_ID = GUICtrlCreateRadio("2288 ", $xleft + 190, $ypos+15, 50, 22, $BS_LEFT)
	;GUICtrlSetState($SSHWANport443_ID,$SSHWANport443)
	$SSHWANport2289_ID = GUICtrlCreateRadio("2289 ", $xleft + 240, $ypos+15, 50, 22, $BS_LEFT)
	$SSHWANport2290_ID = GUICtrlCreateRadio("2290 ", $xleft + 290, $ypos+15, 50, 22, $BS_LEFT)
	$SSHWANport2291_ID = GUICtrlCreateRadio("2291 ", $xleft + 140, $ypos+32, 50, 22, $BS_LEFT)
	$SSHWANport2292_ID = GUICtrlCreateRadio("2292 ", $xleft + 190, $ypos+32, 50, 22, $BS_LEFT)
	$SSHWANport2293_ID = GUICtrlCreateRadio("2293 ", $xleft + 240, $ypos+32, 50, 22, $BS_LEFT)
	$SSHWANportAuto_ID = GUICtrlCreateRadio("Auto ", $xleft + 290, $ypos+32, 50, 22, $BS_LEFT)
	If $SSHNATport = "2288" Then
		GUICtrlSetState($SSHWANport2288_ID, $GUI_CHECKED)
	ElseIf $SSHNATport = "2289" Then
		GUICtrlSetState($SSHWANport2289_ID, $GUI_CHECKED)
	ElseIf $SSHNATport = "2290" Then
		GUICtrlSetState($SSHWANport2290_ID, $GUI_CHECKED)
	ElseIf $SSHNATport = "2291" Then
		GUICtrlSetState($SSHWANport2291_ID, $GUI_CHECKED)
	ElseIf $SSHNATport = "443" Then
		GUICtrlSetState($SSHWANport443_ID, $GUI_CHECKED)
	ElseIf $SSHNATport = "2292" Then
		GUICtrlSetState($SSHWANport2292_ID, $GUI_CHECKED)
	ElseIf $SSHNATport = "2293" Then
		GUICtrlSetState($SSHWANport2293_ID, $GUI_CHECKED)
	ElseIf $SSHNATport = "Auto" Then
		GUICtrlSetState($SSHWANportAuto_ID, $GUI_CHECKED)
	EndIf
	$ypos = $ypos + 50

	GUICtrlCreateLabel("Alcanet Gateway NL to Lab:",$xleft,$ypos,$textlen)
	$AlcanetGWNL_ID = GUICtrlCreateInput($AlcanetGWNL,$xleft,$ypos+15,100,20)
	$ypos = $ypos + 45
	GUICtrlCreateLabel("Alcanet Gateway DE to Lab:",$xleft,$ypos,$textlen)
	$AlcanetGWDE_ID = GUICtrlCreateInput($AlcanetGWDE,$xleft,$ypos+15,$textlen,20)
	$ypos = $ypos + 60
	GUICtrlCreateLabel("GGTunnelGui Update server:",$xleft,$ypos,$textlen)
	$GGTunnelGuiUpdServ_ID = GUICtrlCreateInput($GGTunnelGuiUpdServ,$xleft,$ypos+15,100,20)

    $ypos=$ystartpos
	$tab5 = GUICtrlCreateTabItem("SQLite DB")
	GUICtrlCreateLabel("GOGlobal-Tunnel SQLite Database (to be loaded at startup):",$xleft,$ypos,$textlen)
	$SQLiteDB_ID = GUICtrlCreateInput($SQliteDB,$xleft,$ypos+15,$textlen,20)
	$SQliteDB_button = GUICtrlCreateButton("...",350,$ypos+15,25,20)

	$ypos = $ypos + 45
	GUICtrlCreateLabel("Database Parent-keys (comma separated):",$xleft,$ypos,$textlen)
	$DBParents_ID = GUICtrlCreateInput($DBParents,$xleft,$ypos+15,$textlen,20)
	$ypos = $ypos + 40
	GUICtrlCreateLabel("Possible Parent-keys: " & $PossibleDBparents,$xleft,$ypos,$textlen+20)
	;$ypos = $ypos + 45
	;GUICtrlCreateLabel("DE LAB database Parent-keys (comma separated):",$xleft,$ypos,$textlen)
	;$DE_LAB_Parents_ID = GUICtrlCreateInput($DE_LAB_Parents,$xleft,$ypos+15,$textlen,20)
    $ypos=$ystartpos
	$tab6 = GUICtrlCreateTabItem("Timers")
	GUICtrlCreateLabel("Wait time to let SSH session respond (in seconds):",$xleft,$ypos,250)
	$ypos = $ypos + 30
	GUICtrlCreateLabel("Wait for VPNHostPC :",$xleft,$ypos,150)
	$VPCWait_ID = GUICtrlCreateInput($VPCWait,190,$ypos,40,20)
	$ypos = $ypos+25
	GUICtrlCreateLabel("Wait for sdhswdl (NL AlcaNet GW):",$xleft,$ypos,180)
	$SdhswdlWait_ID = GUICtrlCreateInput($SdhswdlWait,190,$ypos,40,20)
	$ypos = $ypos+25
	GUICtrlCreateLabel("Wait for slsvho (DE AlcaNet GW):",$xleft,$ypos,170)
	$SlsvhoWait_ID = GUICtrlCreateInput($SlsvhoWait,190,$ypos,40,20)
	$ypos=$ypos+25
	GUICtrlCreateLabel("Wait for Nlsdh1:",$xleft,$ypos,150)
	$Nlsdh1Wait_ID = GUICtrlCreateInput($Nlsdh1Wait,190,$ypos,40,20)
	$ypos=$ypos+25
	;GUICtrlCreateLabel("Wait for Essent gateway:",$xleft,$ypos,150)
	;$EssentGWWait_ID = GUICtrlCreateInput($EssentGWWait,190,$ypos,40,20)
	;$ypos=$ypos+25
	GUICtrlCreateLabel("Wait for Antwerp PC:",$xleft,$ypos,150)
	$DamewareWait_ID = GUICtrlCreateInput($DamewareWait,190,$ypos,40,20)
	$ypos=$ypos+25
	GUICtrlCreateLabel("Wait for Antwerp PC DialinStatus:",$xleft,$ypos,170)
	$RASDIAL_TIMEOUT_ID = GUICtrlCreateInput($RASDIAL_TIMEOUT,190,$ypos,40,20)
    $ypos=$ystartpos
	$tab7 = GUICtrlCreateTabItem("Updates")
	$GGUpdateCheck_ID = GUICtrlCreateCheckbox("Check GGTunnelGui App and DB updates at startup.", $xleft, $ypos, 270, 20, $BS_RIGHT)
	GUICtrlSetState($GGUpdateCheck_ID,$GGUpdateCheck)
    $ypos=$ystartpos
	$tab8 = GUICtrlCreateTabItem("Maintenance")
	GUICtrlCreateLabel("Debug Levels:",$xleft,$ypos,100)
	$DebugLevels_ID = GUICtrlCreateInput($DebugLevels,120,$ypos,100,20)
	GUICtrlCreateLabel("Possible debug Levels (space delimited): 1 4 9 ",$xleft+220,$ypos,230)

	;$ypos = 500
	GUICtrlCreateTabItem("")

	$SaveSetButton = GUICtrlCreateButton("&OK", $xleft, $HightGui-25, 70, 20)
	$CancelSetbutton = GUICtrlCreateButton("&Cancel",$xleft+80,$HightGui-25,70,20)
	$ApplySetbutton = GUICtrlCreateButton("&Apply",$xleft+160,$HightGui-25,70,20)
	GUISetState()
	While 1
		$msg = GUIGetMsg()
		Select
			Case (($msg = $SaveSetButton) Or ($msg = $ApplySetbutton ))
				;If FileOpen($INIDir & $INIFile,0) Then FileClose($INIDir & $INIFile)
				;FileOpen($INIDir & $INIFile,0)
				$SSHprivKey_VPC = GUICtrlRead($SSHprivKey_VPC_ID)
				$SSHnlsdh1User = GUICtrlRead($SSHnlsdh1User_ID)
				;$AlcanetGWUser = GUICtrlRead($AlcanetGWUser_ID)
				;$AlcanetGWPasswd = GuiCtrlRead($AlcanetGWPasswd_ID)
				$AlcanetGWNLUser = GUICtrlRead($AlcanetGWNLUser_ID)
				$AlcanetGWNLPasswd = GuiCtrlRead($AlcanetGWNLPasswd_ID)
				$AlcanetGWDEUser = GUICtrlRead($AlcanetGWDEUser_ID)
				$AlcanetGWDEPasswd = GuiCtrlRead($AlcanetGWDEPasswd_ID)
				$GGTunnelGuiUpdServ = GUICtrlRead($GGTunnelGuiUpdServ_ID)
				$SSHVPCUser = GuiCtrlRead($SSHVPCUser_ID)
				$PersonalAccounts = ""
				If $SSHVPCUser = "" Then
					;$PersonalAccounts = "SSH username VPNHostPC will be set to: " & @UserName
					$PersonalAccounts = "SSH username VPNHostPC will be set to: " & $SSHVPC7User
					$SSHVPCUser = $SSHVPC7User
				EndIf
				$SSHprivKey_nlsdh1 = GUICtrlRead($SSHprivKey_nlsdh1_ID)
				$PuTTYDIR = GUICtrlRead($PuTTYDIR_ID)
				$FTPDIR = GUICtrlRead($FTPDIR_ID)
				$WinSCPDIR = GUICtrlRead($WinSCPDIR_ID)
				$GGDIR1 = GUICtrlRead($GGDIR1_ID)
				$GGDIR214 = GUICtrlRead($GGDIR214_ID)
				$GGDIR225 = GUICtrlRead($GGDIR225_ID)
				$GGDIR365 = GUICtrlRead($GGDIR365_ID)
				$GGDIRWIN = GUICtrlRead($GGDIRWIN_ID)
				$GGDIRWIN4 = GUICtrlRead($GGDIRWIN4_ID)
				$GGWINuser = GUICtrlRead($GGWINuser_ID)
				If $GGWINUser = "" Then
					$PersonalAccounts = $PersonalAccounts & @CRLF & "Goglobal for Windows username VPNHostPC will be set to: " & @UserName
					$GGWINuser = @UserName
				EndIf
				If ($PersonalAccounts And $msg = $SaveSetButton) Then MsgBox(48,"Personal accounts",$PersonalAccounts & @CRLF & "Please check if this is correct!")
				If FileGetSize($INIDir & $INIFile) = 0 Then MsgBox(64,"Writing !","Writing the INI Settings file." & @CRLF & "This can take a while.",2)
				;$EssentGW = GUICtrlRead($EssentGW_ID)
				$VNCDIR = GUICtrlRead($VNCDIR_ID)
				$RDPDIR = GUICtrlRead($RDPDIR_ID)
				$TV7DIR = GUICtrlRead($TV7DIR_ID)
				$TV8DIR = GUICtrlRead($TV8DIR_ID)
				$TV9DIR = GUICtrlRead($TV9DIR_ID)
				$TV10DIR = GUICtrlRead($TV10DIR_ID)
				$HTTPDIR = GuiCtrlRead($HTTPDIR_ID)
				$HomeGW = GUICtrlRead($HomeGW_ID)
				$ADSLWANIP = GUICtrlRead($ADSLWANIP_ID)
				;$ProxyType = GUICtrlRead($Pro
				If BitAND(GUICtrlRead($ProxyTypeHTTP_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$ProxyType = "HTTP"
				EndIf
				If BitAND(GUICtrlRead($ProxyTypeNone_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$ProxyType = "None"
				EndIf

				If $ProxyType <> "None" Then GUICtrlSetState($SSHWANport443_ID, $GUI_CHECKED)
				;$SSHWanport = GUICtrlRead($SSHWANport2288_ID)
				If BitAND(GUICtrlRead($SSHWANport2288_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "2288"
				EndIf
				If BitAND(GUICtrlRead($SSHWANport443_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "443"
				EndIf
				If BitAND(GUICtrlRead($SSHWANport2289_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "2289"
				EndIf
				If BitAND(GUICtrlRead($SSHWANport2290_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "2290"
				EndIf
				If BitAND(GUICtrlRead($SSHWANport2291_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "2291"
				EndIf
				If BitAND(GUICtrlRead($SSHWANport2292_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "2292"
				EndIf
				If BitAND(GUICtrlRead($SSHWANport2293_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "2293"
				EndIf
				If BitAND(GUICtrlRead($SSHWANportAuto_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$NATportDefault = "Auto"
				EndIf
				$SQliteDB = GUICtrlRead($SQLiteDB_ID)
				$PassEncrypted = GUICtrlRead($PassEncrypted_ID)
				$DBParents = GUICtrlRead($DBParents_ID)
				$DE_LAB_Parents = GUICtrlRead($DE_LAB_Parents_ID)
				$VPCWait = GuiCtrlRead($VPCWait_ID)
				$SdhswdlWait = GUICtrlRead($SdhswdlWait_ID)
				$SlsvhoWait = GUICtrlRead($SlsvhoWait_ID)
				;$EssentGWWait = GUICtrlRead($EssentGWWait_ID)
				;$AlcanetGW = GUICtrlRead($AlcanetGW_ID)
				$AlcanetGWNL = GUICtrlRead($AlcanetGWNL_ID)
				;MsgBox(0,"Settings2 NL",$AlcanetGWNL)
				$AlcanetGWDE = GUICtrlRead($AlcanetGWDE_ID)
				If $AlcanetGWNL_org = $AlcanetGW Then $AlcanetGW = $AlcanetGWNL
				If $AlcanetGWDE_org = $AlcanetGW Then $AlcanetGW = $AlcanetGWDE
				$Nlsdh1Wait = GUICtrlRead($Nlsdh1Wait_ID)
				$DamewareWait = GUICtrlRead($DamewareWait_ID)
				$RASDIAL_TIMEOUT = GUICtrlRead($RASDIAL_TIMEOUT_ID)
				$GGUpdateCheck = GuiCtrlRead($GGUpdateCheck_ID)
				$DBUpdateCheck = GuiCtrlRead($DBUpdateCheck_ID)
				$PUTTYDIR_Default_Check = GUICtrlRead($PUTTYDIR_Default_Check_ID)
				$DebugLevels = GUICtrlRead($DebugLevels_ID)
				$ProxyHostname = GUICtrlRead($ProxyHostname_ID)
				$ProxyUsername = GUICtrlRead($ProxyUsername_ID)

				;$ProxyPassword_ASCIIarray = StringToASCIIArray(GUICtrlRead($ProxyPassword_ID),0,StringLen(GUICtrlRead($ProxyPassword_ID)),2)
				;MsgBox(0,"Proxypassword",GUICtrlRead($ProxyPassword_ID))
			;For $x = 1 to $ProxyPassword_ASCIIarray[0]

			;Next
				;_ArrayDisplay($ProxyPassword_ASCIIarray)

				$ProxyPassword = _StringEncrypt(1,GUICtrlRead($ProxyPassword_ID),$EncryptPassword)
				$ProxyPort = GUICtrlRead($ProxyPort_ID)
				$ProxyType = GUICtrlRead($ProxyTypeHTTP_ID)
				If BitAND(GUICtrlRead($ProxyTypeHTTP_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$ProxyType = "HTTP"
				EndIf
				If BitAND(GUICtrlRead($ProxyTypeNone_ID), $GUI_CHECKED) = $GUI_CHECKED Then
					$ProxyType = "None"
				EndIf

				IniWrite($INIDir & $INIFile, "SSH key directories", "SSHprivKey_VPC", $SSHprivKey_VPC)
				IniWrite($INIDir & $INIFile, "SSH key directories", "SSHprivKey_nlsdh1", $SSHprivKey_nlsdh1)
				IniWrite($INIDir & $INIFile, "SSH key directories", "SSHnlsdh1User", $SSHnlsdh1User)
				;IniWrite($INIDir & $INIFile, "SSH key directories", "AlcanetGWUser", $AlcanetGWUser)
				;IniWrite($INIDir & $INIFile, "SSH key directories", "AlcanetGWPasswd", $AlcanetGWPasswd)
				IniWrite($INIDir & $INIFile, "SSH key directories", "AlcanetGWNLUser", $AlcanetGWNLUser)
				IniWrite($INIDir & $INIFile, "SSH key directories", "AlcanetGWNLPasswd", $AlcanetGWNLPasswd)
				IniWrite($INIDir & $INIFile, "SSH key directories", "AlcanetGWDEUser", $AlcanetGWDEUser)
				IniWrite($INIDir & $INIFile, "SSH key directories", "AlcanetGWDEPasswd", $AlcanetGWDEPasswd)
				IniWrite($INIDir & $INIFile, "SSH key directories", "SSHVPCUser", $SSHVPCUser)
				IniWrite($INIDir & $INIFile, "Proxy","ProxyUsername",$ProxyUsername)



				IniWrite($INIDir & $INIFile, "Proxy","ProxyPassword",$ProxyPassword)
				IniWrite($INIDir & $INIFile, "Proxy","ProxyHostname",$ProxyHostname)
				IniWrite($INIDir & $INIFile, "Proxy","ProxyPort",$ProxyPort)
				IniWrite($INIDir & $INIFile, "Proxy","ProxyType",$ProxyType)
				IniWrite($INIDir & $INIFile, "Program directories", "GGDIR1", $GGDIR1)
				IniWrite($INIDir & $INIFile, "Program directories", "GGDIR214", $GGDIR214)
				IniWrite($INIDir & $INIFile, "Program directories", "GGDIR225", $GGDIR225)
				IniWrite($INIDir & $INIFile, "Program directories", "GGDIR365", $GGDIR365)
				IniWrite($INIDir & $INIFile, "Program directories", "GGDIRWIN", $GGDIRWIN)
				IniWrite($INIDir & $INIFile, "Program directories", "GGDIRWIN4", $GGDIRWIN4)
				If $PUTTYDIR_Default_Check = "1" Then
					If FileExists($GGtunnelDir & "\programs\putty\putty_tray.exe") Then $PuTTYDIR = $GGtunnelDir & "\programs\putty\putty_tray.exe"
					;$PuTTYDIR = $GGtunnelDir & "\programs\putty\putty_tray.exe"
				EndIf
				IniWrite($INIDir & $INIFile, "Program directories", "PuTTYDIR", $PuTTYDIR)
				IniWrite($INIDir & $INIFile, "Program directories", "FTPDIR", $FTPDIR)
				IniWrite($INIDir & $INIFile, "Program directories", "WinSCPDIR", $WinSCPDIR)
				IniWrite($INIDir & $INIFile, "Program directories", "HTTPDIR", $HTTPDIR)
				IniWrite($INIDir & $INIFile, "Program directories", "VNCDIR", $VNCDIR)
				IniWrite($INIDir & $INIFile, "Program directories", "RDPDIR", $RDPDIR)
				IniWrite($INIDir & $INIFile, "Program directories", "TV7DIR", $TV7DIR)
				IniWrite($INIDir & $INIFile, "Program directories", "TV8DIR", $TV8DIR)
				IniWrite($INIDir & $INIFile, "Program directories", "TV9DIR", $TV9DIR)
				IniWrite($INIDir & $INIFile, "Program directories", "TV10DIR", $TV10DIR)
				IniWrite($INIDir & $INIFile, "Program directories", "GGWINUser", $GGWINUser)
				IniWrite($INIDir & $INIFile, "SQLite Database", "SQLiteDB", $SQliteDB)
				IniWrite($INIDir & $INIFile, "SQLite Database", "PassEncrypted", $PassEncrypted)
				IniWrite($INIDir & $INIFile, "SQLite Database", "DBparents", $DBParents)
				;IniWrite($INIDir & $INIFile, "SQLite Database", "DE_LAB_parents", $DE_LAB_Parents)
				_SQLite_Exec($GGDB,"update comments set comment = '" & $DBParents & "' where id = '1000'")
				;IniWrite($INIDir & $INIFile, "Gateways IP", "EssentGW", $EssentGW)
				;IniWrite($INIDir & $INIFile, "Gateways IP", "AlcanetGW", $AlcanetGW)
				IniWrite($INIDir & $INIFile, "Gateways IP", "AlcanetGWNL", $AlcanetGWNL)
				IniWrite($INIDir & $INIFile, "Gateways IP", "SSHNATport", $NATportDefault)
				IniWrite($INIDir & $INIFile, "Gateways IP", "AlcanetGWDE", $AlcanetGWDE)
				IniWrite($INIDir & $INIFile, "Gateways IP", "GGTunnelGuiUpdServ", $GGTunnelGuiUpdServ)
				IniWrite($INIDir & $INIFile, "Gateways IP", "HomeGW", $HomeGW)
				IniWrite($INIDir & $INIFile, "Gateways IP", "ADSLWANIP", $ADSLWANIP)
				IniWrite($INIDir & $INIFile, "Timers", "VPCWait", $VPCWait)
				IniWrite($INIDir & $INIFile, "Timers", "SdhswdlWait", $SdhswdlWait)
				IniWrite($INIDir & $INIFile, "Timers", "SlsvhoWait", $SlsvhoWait)
				;IniWrite($INIDir & $INIFile, "Timers", "EssentGWWait", $EssentGWWait)
				IniWrite($INIDir & $INIFile, "Timers", "Nlsdh1Wait", $Nlsdh1Wait)
				IniWrite($INIDir & $INIFile, "Timers", "DamewareWait", $DamewareWait)
				IniWrite($INIDir & $INIFile, "Timers", "RASDIAL_TIMEOUT", $RASDIAL_TIMEOUT)
				IniWrite($INIDir & $INIFile, "Updates", "GGUpdateCheck", $GGUpdateCheck)
				IniWrite($INIDir & $INIFile, "Program directories", "PuTTYAPPDEF", $PUTTYDIR_Default_Check)
				IniWrite($INIDir & $INIFile, "Maintenance","DEBUG", $DebugLevels)
				FileClose($INIDir & $INIFile)
				ReadSettings()
				If $msg = $SaveSetButton Then ExitLoop
			Case $msg = $CancelSetbutton OR $msg = $GUI_EVENT_CLOSE
				ReadSettings()
				ExitLoop
			Case $msg = $PuTTYDIR_button
				$PuTTYDIR_org = $PuTTYDIR
				$ApPath = _PathSplit($PuTTYDIR_org, $szDrive, $szDir, $szFName, $szExt)
				$PuTTYDIR = FileOpenDialog("PuTTY", $szDrive & $szDir & "", "PuTTY (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($PuTTYDIR_ID,$PuTTYDIR)
			Case $msg = $FTPDIR_button
				$FTPDIR_org = $FTPDIR
				$ApPath = _PathSplit($FTPDIR_org, $szDrive, $szDir, $szFName, $szExt)
				$FTPDIR = FileOpenDialog("FileZilla", $szDrive & $szDir & "", "FileZilla (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($FTPDIR_ID,$FTPDIR)
			Case $msg = $WinSCPDIR_button
				$WinSCPDIR_org = $WinSCPDIR
				$ApPath = _PathSplit($WinSCPDIR_org, $szDrive, $szDir, $szFName, $szExt)
				$WinSCPDIR = FileOpenDialog("WinSCP", $szDrive & $szDir & "", "WinSCP (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($WinSCPDIR_ID,$WinSCPDIR)
			Case $msg = $VNCDIR_button
				$VNCDIR_org = $VNCDIR
				$ApPath = _PathSplit($VNCDIR_org, $szDrive, $szDir, $szFName, $szExt)
				$VNCDIR = FileOpenDialog("VNC viewer", $szDrive & $szDir & "", "vncviewer (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($VNCDIR_ID,$VNCDIR)
			Case $msg = $RDPDIR_button
				$RDPDIR_org = $RDPDIR
				$ApPath = _PathSplit($RDPDIR_org, $szDrive, $szDir, $szFName, $szExt)
				$RDPDIR = FileOpenDialog("Remote Desktop viewer", $szDrive & $szDir & "", "mstsc (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($RDPDIR_ID,$RDPDIR)
			Case $msg = $TV7DIR_button
				$TV7DIR_org = $TV7DIR
				$ApPath = _PathSplit($TV7DIR_org, $szDrive, $szDir, $szFName, $szExt)
				$TV7DIR = FileOpenDialog("TeamViewer7", $szDrive & $szDir & "", "TeamViewer (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($TV7DIR_ID,$TV7DIR)
			Case $msg = $TV8DIR_button
				$TV8DIR_org = $TV8DIR
				$ApPath = _PathSplit($TV8DIR_org, $szDrive, $szDir, $szFName, $szExt)
				$TV8DIR = FileOpenDialog("TeamViewer8", $szDrive & $szDir & "", "TeamViewer (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($TV8DIR_ID,$TV8DIR)
			Case $msg = $TV9DIR_button
				$TV9DIR_org = $TV7DIR
				$ApPath = _PathSplit($TV9DIR_org, $szDrive, $szDir, $szFName, $szExt)
				$TV9DIR = FileOpenDialog("TeamViewer9", $szDrive & $szDir & "", "TeamViewer (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($TV9DIR_ID,$TV9DIR)
			Case $msg = $TV10DIR_button
				$TV10DIR_org = $TV10DIR
				$ApPath = _PathSplit($TV10DIR_org, $szDrive, $szDir, $szFName, $szExt)
				$TV10DIR = FileOpenDialog("TeamViewer10", $szDrive & $szDir & "", "TeamViewer (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($TV10DIR_ID,$TV10DIR)
			Case $msg = $HTTPDIR_button
				$HTTPDIR_org = $HTTPDIR
				$ApPath = _PathSplit($HTTPDIR_org, $szDrive, $szDir, $szFName, $szExt)
				$HTTPDIR = FileOpenDialog("Web Browser", $szDrive & $szDir & "", " (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($HTTPDIR_ID,$HTTPDIR)
			Case $msg = $SSHprivKey_VPC_button
				$SSHprivKey_VPC_org = $SSHprivKey_VPC
				If $SSHprivKey_VPC_org = "" Then
					$szDrive = $GGtunnelDir
					$szDir = "\SSHkeys\"
				Else
					$ApPath = _PathSplit($SSHprivKey_VPC_org, $szDrive, $szDir, $szFName, $szExt)
				EndIf
				$SSHprivKey_VPC = FileOpenDialog("Private key VPNHostPC", $szDrive & $szDir & "", "SSH Private keys (*.ppk)", 1 + 4 )
				if not @error then GUICtrlSetData($SSHprivKey_VPC_ID,$SSHprivKey_VPC)
			Case $msg = $SSHprivKey_nlsdh1_button
				$SSHprivKey_nlsdh1_org = $SSHprivKey_nlsdh1
				If $SSHprivKey_nlsdh1_org = "" Then
					$szDrive = $GGtunnelDir
					$szDir = "\SSHkeys\"
				Else
					$ApPath = _PathSplit($SSHprivKey_nlsdh1_org, $szDrive, $szDir, $szFName, $szExt)
				EndIf
				$SSHprivKey_nlsdh1 = FileOpenDialog("Private key nlsdh1", $szDrive & $szDir & "", "SSH Private keys (*.ppk)", 1 + 4 )
				if not @error then GUICtrlSetData($SSHprivKey_nlsdh1_ID,$SSHprivKey_nlsdh1)
			Case $msg = $GGDIR1_button
				$GGDIR1_org = $GGDIR1
				$ApPath = _PathSplit($GGDIR1_org, $szDrive, $szDir, $szFName, $szExt)
				$GGDIR1 = FileOpenDialog("GOGlobal Bridges 1.1", $szDrive & $szDir & "", "Bridges (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($GGDIR1_ID,$GGDIR1)
			Case $msg = $GGDIR214_button
				$GGDIR214_org = $GGDIR214
				$ApPath = _PathSplit($GGDIR214_org, $szDrive, $szDir, $szFName, $szExt)
				$GGDIR214 = FileOpenDialog("GOGlobal-UX 2.1", $szDrive & $szDir & "", "goglobalux (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($GGDIR214_ID,$GGDIR214)
			Case $msg = $GGDIR225_button
				$GGDIR225_org = $GGDIR225
				$ApPath = _PathSplit($GGDIR225_org, $szDrive, $szDir, $szFName, $szExt)
				$GGDIR225 = FileOpenDialog("GOGlobal-UX 2.2", $szDrive & $szDir & "", "goglobalux (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($GGDIR225_ID,$GGDIR225)
			Case $msg = $GGDIRWIN_button
				$GGDIRWIN_org = $GGDIRWIN
				$ApPath = _PathSplit($GGDIRWIN_org, $szDrive, $szDir, $szFName, $szExt)
				$GGDIRWIN = FileOpenDialog("GOGlobal for Windows", $szDrive & $szDir & "", "ggwin (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($GGDIRWIN_ID,$GGDIRWIN)
			Case $msg = $GGDIRWIN4_button
				$GGDIRWIN4_org = $GGDIRWIN4
				$ApPath = _PathSplit($GGDIRWIN4_org, $szDrive, $szDir, $szFName, $szExt)
				$GGDIRWIN4 = FileOpenDialog("GOGlobal for Windows Cloud", $szDrive & $szDir & "", "gg-client (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($GGDIRWIN4_ID,$GGDIRWIN4)
			Case $msg = $GGDIR365_button
				$GGDIR365_org = $GGDIR365
				$ApPath = _PathSplit($GGDIR365_org, $szDrive, $szDir, $szFName, $szExt)
				$GGDIR365 = FileOpenDialog("GOGlobal 3.65", $szDrive & $szDir & "", "GLOBAL (*.exe)", 1 + 4 )
				if not @error then GUICtrlSetData($GGDIR365_ID,$GGDIR365)
			Case $msg = $SQliteDB_button
				$SQliteDB_org = $SQliteDB
				If $SQliteDB_org = "" Then
					$szDrive = ""
					$szDir = $DATABASEDIR
				Else
					$ApPath = _PathSplit($SQliteDB_org, $szDrive, $szDir, $szFName, $szExt)
				EndIf
				$SQliteDB = FileOpenDialog("SQLite database GGTunnel", $szDrive & $szDir & "", "SQLiteDB (*.db)", 1 + 4 )
				if not @error then GUICtrlSetData($SQLiteDB_ID,$SQliteDB)
		EndSelect
    WEnd
	GUIDelete()
	$GGDB = _SQLite_Open ($SQliteDB)
	_SQLite_Exec ($DBmem, "DELETE FROM cust;")
	_SQLite_Exec ($DBmem, "DELETE FROM hosts;")
	StartMyMenu()
EndFunc ; Function Settings



; freeNX encrypted password creation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Func getvalidCharList($pos)
Local $validCharList[$numValidCharList] = ["!", "#", "$", "%", "&", "(", ")", "*", "+", "-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", ">", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "]", "_", "a", "b", "c", "d","e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}"];

;["!", "#", "\$", "%", "&", "(", ")", "*", "+", "-",
;".", "0", "1", "2", "3", "4", "5", "6", "7", "8",
;"9", ":", ";", "<", ">", "?", "@", "A", "B", "C",
;"D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
;"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W",
;"X", "Y", "Z", "[", "]", "_", "a", "b", "c", "d",
;"e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
;"o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
;"y", "z", "{", "|", "}"];
return $validCharList[$pos];
EndFunc

Func encodePassword($p)
Local $sPass = ":"
Local $sTmp = ""
Local $i,$c, $a
Local $helestring=""

if not $p Then return ""
for $i = 1 to StringLen($p)
  $c = StringMid($p,$i,1)
  $helestring=$helestring & $c
  $a=asc($c)
  $sTmp=($a+$i) & ":"

  $sPass = $sPass & $sTmp
  $sTmp = ""
Next
return $sPass
EndFunc


Func findCharInList($c)
Local $j,$randchar
Local $i = -1

for $j = 0 To $numValidCharList-1
  $randchar = getvalidCharList($j);
  if ($randchar == $c) Then
    $i = $j;
    return $i;
  EndIf
Next
return $i;
EndFunc


Func getRandomValidCharFromList()
Local $k;
$k = @SEC
;$k = 10
return getvalidCharList($k)
EndFunc



func scrambleString($s)
Local $app, $k, $l, $i1, $car, $i,$c,$c2, $iR, $str, $app2, $j
Local $sRet = ""

if not $s Then return $s

$str = encodePassword($s)

if (StringLen($str) < 32) Then $sRet = $sRet & $dummyString

$sRet = _StringReverse($str)

if (stringlen($sRet) < 32) Then $sRet = $sRet & $dummyString

$app=getRandomValidCharFromList()

$k=asc($app)
$l=$k + stringlen($sRet) -2
$sRet= $app & $sRet

for $i1 = 2 to StringLen($sRet)
  $app2=StringMid($sRet,$i1,1)
  $j = findCharInList($app2)
  if ($j == -1) Then return $sRet

  $i = mod($j + $l * ($i1),$numValidCharList)
  $car=getvalidCharList($i)
  $sRet=StringReplace($sRet,$i1,$car,1)
Next

$c = (asc(getRandomValidCharFromList())) + 2
$c2=chr($c)

$sRet=$sRet & $c2

return URLEncode($sRet)
EndFunc

Func URLEncode($theURL)
$theURL = StringReplace($theURL,"&","&amp;")
$theURL = StringReplace($theURL,"""","&quot;")
$theURL = StringReplace($theURL,"'","&apos;")
$theURL = StringReplace($theURL,"<","&lt;")
$theURL = StringReplace($theURL,">","&gt;")
return $theURL;
EndFunc

; END FreeNX encrypted password creation ;;;;;;;;;;;;;;;;



Func ReadAllDatabases()
Local $szDrive, $szDir, $szFName, $szExt, $DBfile, $DBC, $DBv, $SQDB, $DBstrip
    _PathSplit($SQliteDB, $szDrive, $szDir, $szFName, $szExt)
	;_PathSplit($GGDIR1, $szDrive,$szDir,$szFName,$szExt)
	$DrvStatus = DriveGetSerial($szDrive)
	If $DrvStatus Then
		If FileExists($szDrive & $szDir) Then
			$Database = $DBCountry & " database v" & $DBversion & " " & $UserEdit
			; Put all db filenames in an array.
			$Databases = _FileListToArray($szDrive & $szDir,"*.db")
			$DBs = ""
			; Do for all filenames:
			For $DB = 1 to $Databases[0]
				$DBfile = $szDrive & $szDir & $Databases[$DB]
				$DBC = ""
				$DBv = ""
				If FileExists($DBfile) Then
					$SQDB = _SQLite_Open ($DBfile)
					; If Comments row with Id 24 exsists, go on.
					If _SQLite_QuerySingleRow($SQDB,"SELECT autor, comment from comments where id = 24",$hQuery3) = $SQLITE_OK Then
						_SQLite_QuerySingleRow($SQDB,"SELECT autor from comments where id = 1001",$uQuery)
						$UserEdit = $uQuery[0]
						;MsgBox(0,"DBeditUswer and reading Database and defaault database",$UserEdit & " *** " & $Databases[$DB] & " *** " & $Database)
						;$DBC is DBCountry
						$DBC = $hQuery3[0]
						If $DBC = "" Then
							$DBC = $Databases[$DB]
							$DBv = "?"
						Else
							; $DBv is DB version.
							$DBv = $hQuery3[1]
						EndIf
						_SQLite_Close($SQDB)
					Else
						; Databasefile is not a GGTunnnelGui database.
						_SQLite_Close($SQDB)
						MsgBox(16,"Database error",$DBfile & " is not a valid database file !" & @CRLF & "File will be renamed to " & $DBfile & ".NOK")
						FileMove($DBfile,$DBfile & ".NOK")
						sleep(1000)
					EndIf
				EndIf
				If $DBC And $DBv Then
					$DBs = $DBs & "|" & $DBC & " database v" & $DBv & " " & $UserEdit
					; $Databases gets dir+filename and separator '|' and then the label it gets in the combobox.
					$Databases[$DB] = $szDrive & $szDir & $Databases[$DB] & "|" & $DBC & " database v" & $DBv & " " & $UserEdit
				EndIf
			Next
			$LastReadDatabase =$DBC & " database v" & $DBv & " " & $UserEdit
			$DBstrip = $DBs
			If StringLeft($DBs, 1) = "|" Then $DBstrip = StringTrimLeft($DBs, 1)
			$DBs = $DBstrip
			If ($Database = " database v " Or $Database = "") Then $Database = "Choose Database !"
			;MsgBox(0,"Database (regel 1068)",$Database)
			GUICtrlSetData($Database_ID, "","")
			GUICtrlSetData($Database_ID, $DBs,$Database)
			GUICtrlSetState($Database_ID,$GUI_FOCUS)
		Else
			MsgBox(16,"No databases found!","No databases found in " & $szDrive & $szDir & "." & @CRLF & "Please update your database location via 'Settings'.")
		EndIf
	Else
		MsgBox(16,"No databases found!","No databases found in " & $szDrive & $szDir & " (drive not ready)." & @CRLF & "Please update your database location via 'Settings'.")
	EndIf
EndFunc


Func SaveSessionsToFile()
local $fhSessionsLogFile
	$fhSessionsLogFile = FileOpen($SessionsLogFile,1)
	_SQLite_Query($DBmem,"SELECT Customer, Host, IP, Starttime, ConnectVia from connections order by Customer",$hQuery4)
	While _SQLite_FetchData ($hQuery4, $dRow) = $SQLITE_OK ;
		FileWrite($fhSessionsLogFile,$dRow[0] & "  |  "  & $dRow[1] & "  |  " & $dRow[2] & "  |  "  & $dRow[3] & "  |  " & $dRow[4] & @CRLF)
	WEnd
	FileClose($fhSessionsLogFile)
EndFunc


Func UpdateDBUserPasswd()
Local $DBUpdateFile, $UpdateDBArray, $line
Local $DBlistview, $button, $item1, $item2, $item3, $input1, $DBmsg, $SSHport, $Telnetport, $Webport, $ReadPW, $ViewPW
Local $OKbutton, $Cancelbutton

	$DBUpdateFile = FileOpen($UpdateUserPasswd_DB,0)
	;MsgBox(0,"User/passwd file",$UpdateUserPasswd_DB)
	GUICreate("User changed username/passwords " & $DBCountry , 390, 250)
	$DBlistview = GUICtrlCreateListView("  Customer |   Host   |   User   |   Password ",-1,-1,390,200);,$LVS_SORTDESCENDING)
	$OKbutton = GUICtrlCreateButton("&Update", 122,220, 70, 20)
	$Cancelbutton = GUICtrlCreateButton("&Cancel", 198,220, 70, 20)
	;If $PassEncrypted = "1" Then $ReadPW = InputBox("Encryption password","Give password to decrypt the user-passwords: ","","*",280,120)
	;_SQLite_Query($DBmem,"SELECT Customer, Host, ServerIP, User, Password, ServerId, GGversion, TelnetConsole, WebConsole, tunnel, tunnelip from hosts order by Customer",$hQuery4)
	;While _SQLite_FetchData ($hQuery4, $dRow) = $SQLITE_OK ;
	while 1
		$line = FileReadLine($DBUpdateFile)
		If (@error = -1) Then ExitLoop
		$UpdateDBArray = StringSplit($line,";")
		If $PassEncrypted = "1" Then
			$ViewPW = _StringEncrypt(0, $UpdateDBArray[7], $EncryptPassword)
		Else
			$ViewPW = $UpdateDBArray[7]
		EndIf
		;FileWrite($DBUpdateFile, $SQliteDB & ";" & $DBCountry & ";" & $DBid & ";" & $Customer & ";" & $NMShost1 & ";" & $EncryptPasswd & ";" & "update server set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "' where id = '" & $dRow[0] & "' and hostname = '" & $NMShost1 & "'" & @CRLF)
		If $DBCountry = $UpdateDBArray[2] Then GUICtrlCreateListViewItem($UpdateDBArray[4] & "|" & $UpdateDBArray[5] & "|" & $UpdateDBArray[6] & "|" & $ViewPW, $DBlistview)
	WEnd
	FileClose($DBUpdateFile)
	GUISetState()
	While 1
		$DBmsg = GUIGetMsg()
		If ($DBmsg = $GUI_EVENT_CLOSE Or $DBmsg = $Cancelbutton) Then ExitLoop
		If $DBmsg = $OKbutton Then
				$DBUpdateFile = FileOpen($UpdateUserPasswd_DB,0)
				;FileWrite($DBUpdateFile, $SQliteDB & ";" & $DBCountry & ";" & $DBid & ";" & "update server set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "' where id = '" & $dRow[0] & "' and hostname = '" & $NMShost1 & "'" & @CRLF)
				;$file = FileOpen ( $DBUpdateFile, 0 )

				While 1
					$line = FileReadLine($DBUpdateFile)
					If (@error = -1) Then ExitLoop
					;MsgBox(0,"line",$line)
					$UpdateDBArray = StringSplit($line,";")
					;MsgBox(0,"array",$UpdateDBArray[2] & " ## " & $UpdateDBArray[8])
					If $UpdateDBArray[2] = $DBCountry Then
						;MsgBox(0," "," ")
						_SQLite_Exec($GGDB,$UpdateDBArray[8])
					EndIf
					;MsgBox(0, "Line read:", $line)
				Wend
				FileClose($DBUpdateFile)
				MsgBox(0,"Update","Passwords Updated!")
				ExitLoop
		EndIf
	WEnd
	GUIDelete()
;FileWrite($DBUpdateFileTemp, $SQliteDB & ";" & $DBCountry & ";" & $DBid & ";" & $Customer & ";" & $NMShost1 & ";" & $EncryptPasswd & ";" & "update server set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "' where id = '" & $dRow[0] & "' and hostname = '" & $NMShost1 & "'" & @CRLF)
EndFunc


Func ExitGG()
	GUIDelete()
	EndProcesses("end")
	;SaveSessionsToFile()
	_SQLite_Close()
	_SQLite_Close($GGDB)
	_SQLite_Shutdown ()
	Exit
EndFunc


Func _ProcessGetChildren($i_pid)
    Local Const $TH32CS_SNAPPROCESS = 0x00000002

    Local $a_tool_help = DllCall('Kernel32.dll', 'long', 'CreateToolhelp32Snapshot', 'int', $TH32CS_SNAPPROCESS, 'int', 0)
    If IsArray($a_tool_help) = 0 Or $a_tool_help[0] = -1 Then Return SetError(1, 0, $i_pid)

    Local $tagPROCESSENTRY32 = _
            DllStructCreate _
            ( _
            'dword dwsize;' & _
            'dword cntUsage;' & _
            'dword th32ProcessID;' & _
            'uint th32DefaultHeapID;' & _
            'dword th32ModuleID;' & _
            'dword cntThreads;' & _
            'dword th32ParentProcessID;' & _
            'long pcPriClassBase;' & _
            'dword dwFlags;' & _
            'char szExeFile[260]' _
            )
    DllStructSetData($tagPROCESSENTRY32, 1, DllStructGetSize($tagPROCESSENTRY32))

    Local $p_PROCESSENTRY32 = DllStructGetPtr($tagPROCESSENTRY32)

    Local $a_pfirst = DllCall('Kernel32.dll', 'int', 'Process32First', 'long', $a_tool_help[0], 'ptr', $p_PROCESSENTRY32)
    If IsArray($a_pfirst) = 0 Then Return SetError(2, 0, $i_pid)

    Local $a_pnext, $a_children[11] = [10], $i_child_pid, $i_parent_pid, $i_add = 0
    $i_child_pid = DllStructGetData($tagPROCESSENTRY32, 'th32ProcessID')
    If $i_child_pid <> $i_pid Then
        $i_parent_pid = DllStructGetData($tagPROCESSENTRY32, 'th32ParentProcessID')
        If $i_parent_pid = $i_pid Then
            $i_add += 1
            $a_children[$i_add] = $i_child_pid
        EndIf
    EndIf

    While 1
        $a_pnext = DllCall('Kernel32.dll', 'int', 'Process32Next', 'long', $a_tool_help[0], 'ptr', $p_PROCESSENTRY32)
        If IsArray($a_pnext) And $a_pnext[0] = 0 Then ExitLoop
        $i_child_pid = DllStructGetData($tagPROCESSENTRY32, 'th32ProcessID')
        If $i_child_pid <> $i_pid Then
            $i_parent_pid = DllStructGetData($tagPROCESSENTRY32, 'th32ParentProcessID')
            If $i_parent_pid = $i_pid Then
                If $i_add = $a_children[0] Then
                    ReDim $a_children[$a_children[0] + 10]
                    $a_children[0] = $a_children[0] + 10
                EndIf
                $i_add += 1
                $a_children[$i_add] = $i_child_pid
            EndIf
        EndIf
    WEnd

    If $i_add <> 0 Then
        ReDim $a_children[$i_add + 1]
        $a_children[0] = $i_add
    EndIf

    DllCall('Kernel32.dll', 'int', 'CloseHandle', 'long', $a_tool_help[0])
    If $i_add Then Return $a_children
    Return SetError(3, 0, 0)
EndFunc   ;==>_ProcessGetChildren


Func EndProcesses($reset)
	Local $aRes, $child

	If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"SessionPIDS",$SessionPIDS)
	If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"AllSessionPIDS",$AllSessionPIDS)
	If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"AllTunnelPIDS",$AllTunnelPIDS)
	If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"AllGGDIRPIDS",$AllGGDIRPIDS)
	If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"SwdlPID",$SwdlPID)
	If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"AllSessionsAndPIDS",$AllSessionsandPIDs)

	$array = StringSplit($AllGGDIRPIDS, '|', 1)

	For $x = 1 to $array[0]
		ProcessClose($array[$x])
		ProcessWaitClose($array[$x])
	Next
	$array1 = StringSplit($AllTunnelPIDS, '|', 1)
	For $x = 1 to $array1[0]
		ProcessClose($array1[$x])
		ProcessWaitClose($array1[$x])
	Next

	$array2 = StringSplit($SessionPIDS, '|', 1)
	For $x = 1 to $array2[0]
		ProcessClose($array2[$x])
		ProcessWaitClose($array2[$x])
	Next

	$array2 = StringSplit($AllSessionPIDS, '|', 1)
	For $x = 1 to $array2[0]
		$aRes = _ProcessGetChildren($array2[$x])
		For $child = 1 to $aRes[0]
			ProcessClose($aRes[$child])
		Next
		;_ArrayDisplay($aRes)
		ProcessClose($array2[$x])
		ProcessWaitClose($array2[$x])
	Next

	$array3 = StringSplit($jPortFWPIDS, '|', 1)
	For $x = 1 to $array3[0]
		ProcessClose($array3[$x])
		ProcessWaitClose($array3[$x])
	Next

	$array4 = StringSplit($AllPuTTYPIDS, '|', 1)
	For $x = 1 to $array4[0]
		ProcessClose($array4[$x])
		ProcessWaitClose($array4[$x])
	Next

	ProcessClose($SwdlPID)
	ProcessWaitClose($SwdlPID)
	ProcessClose($SlsvhoPID)
	ProcessWaitClose($SlsvhoPID)
	ProcessClose($VPCPID)
	ProcessWaitClose($VPCPID)
	If FileExist($TEMPDIR) Then DirRemove($TEMPDIR,1)
	If FileExists($TEMPDIR & "rasAventail.txt") Then FileDelete($TEMPDIR & "rasAventail.txt")
	If ProcessExists("psexec.exe") Then ProcessClose("psexec.exe")
	ProcessClose("conime.exe")

	$SwdlPID = "0"
	$SlsvhoPID = "0"
	$VPCPID = "0"
	$RouteViaGatewayPID = "0"
	$pingBICSPID = "0"
	$pingEliaPID = "0"
	$pingPTPID = "0"
	$AllTunnelPIDS = ""
	$AllGGDIRPIDS = ""
	$AllSessionsandPIDs = ""
	$AllPuTTYPIDS = ""
EndFunc


Func GUIChangeItems($hidestart, $hideend, $showstart, $showend)
	Local $idx
	For $idx = $hidestart To $hideend
		GUICtrlSetState($idx, $GUI_HIDE)
	Next
	For $idx = $showstart To $showend
		GUICtrlSetState($idx, $GUI_SHOW)
	Next
EndFunc   ;==>GUIChangeItems


Func ViewDB()
	Local $DBlistview, $button, $item1, $item2, $item3, $input1, $DBmsg, $SSHport, $Telnetport, $Webport, $ReadPW, $ViewPW

	GUICreate("GGTunnel Database", 500, 400, 200, 100, -1, $WS_SIZEBOX)
	$DBlistview = GUICtrlCreateListView("Customer|Hostname|IP|User|Password|GGPortId|GGversion|Telnet|Web|Tunnel|TunnelIP", 10, 10, 480, 350);,$LVS_SORTDESCENDING)
	$button = GUICtrlCreateButton("Exit", 200, 370, 70, 20)
	If $PassEncrypted = "1" Then $ReadPW = InputBox("Encryption password","Give password to decrypt the user-passwords: ","","*",280,120)
	_SQLite_Query($DBmem,"SELECT Customer, Host, ServerIP, User, Password, ServerId, GGversion, TelnetConsole, WebConsole, tunnel, tunnelip from hosts order by Customer",$hQuery4)
	While _SQLite_FetchData ($hQuery4, $dRow) = $SQLITE_OK ;
		If $PassEncrypted = "1" Then
			$ViewPW = _StringEncrypt(0, $dRow[4], $ReadPW)
		Else
			$ViewPW = $dRow[4]
		EndIf
		GUICtrlCreateListViewItem($dRow[0] & "|"  & $dRow[1] & "|" & $dRow[2] & "|" & $dRow[3] &  "|" & $ViewPW & "|" & $dRow[5] & "|" & $dRow[6] & "|" & $dRow[7] & "|" & $dRow[8] & "|" & $dRow[9] & "|" & $dRow[10], $DBlistview)
	WEnd
	GUISetState()
	While 1
		$DBmsg = GUIGetMsg()
		Select
			Case $DBmsg = $GUI_EVENT_CLOSE Or $DBmsg = $button
				ExitLoop
		EndSelect
	WEnd
	GUIDelete()
EndFunc


Func ShowPuTTYConnections()
	Local $DBlistview, $button, $item1, $item2, $item3, $input1, $DBmsg, $SSHport, $Telnetport, $Webport, $ReadPW, $ViewPW, $ShowQuery,$ShowRow

	GUICreate("Tunnel sessions connected during this TunnelGUI session", 440, 280, 250, 100, -1, $WS_EX_ACCEPTFILES)
	$DBlistview = GUICtrlCreateListView(" Customer          | Hostname                 |TunnelSession              | IP                       | Started at        | Connected via | PID", 10, 10, 420, 220);,$LVS_SORTDESCENDING)
	$button = GUICtrlCreateButton("Exit", 195, 250, 70, 20)
	_SQLite_Query($DBmem,"SELECT PConn, Customer, Host, IP, Starttime, ConnectVia, PID from PuTTYconnections order by Customer",$ShowQuery)
	While _SQLite_FetchData ($ShowQuery, $ShowRow) = $SQLITE_OK ;
		GUICtrlCreateListViewItem($ShowRow[1] & "  |  "  & $ShowRow[2] & "  |  " & $ShowRow[0] & "  |  "  & $ShowRow[3] & "  |  " & $ShowRow[4] & "  |  " & $ShowRow[5] & "  |  " & $ShowRow[6] & "  |  ", $DBlistview)
	WEnd
	GUISetState()
	While 1
		$DBmsg = GUIGetMsg()
		Select
			Case $DBmsg = $GUI_EVENT_CLOSE Or $DBmsg = $button
				ExitLoop
		EndSelect
	WEnd
	GUIDelete()
EndFunc

Func ShowConnections()
	Local $DBlistview, $button, $item1, $item2, $item3, $input1, $DBmsg, $SSHport, $Telnetport, $Webport, $ReadPW, $ViewPW

	GUICreate("Servers connected during this TunnelGUI session", 440, 280, 250, 100, -1, $WS_EX_ACCEPTFILES)
	$DBlistview = GUICtrlCreateListView(" Customer              | Hostname                 | IP                       | Started at        | Connected via", 10, 10, 420, 220);,$LVS_SORTDESCENDING)
	$button = GUICtrlCreateButton("Exit", 195, 250, 70, 20)
	_SQLite_Query($DBmem,"SELECT Customer, Host, IP, Starttime, ConnectVia from connections order by Customer",$hQuery4)
	While _SQLite_FetchData ($hQuery4, $dRow) = $SQLITE_OK ;
		GUICtrlCreateListViewItem($dRow[0] & "  |  "  & $dRow[1] & "  |  " & $dRow[2] & "  |  "  & $dRow[3] & "  |  " & $dRow[4] , $DBlistview)
	WEnd
	GUISetState()
	While 1
		$DBmsg = GUIGetMsg()
		Select
			Case $DBmsg = $GUI_EVENT_CLOSE Or $DBmsg = $button
				ExitLoop
		EndSelect
	WEnd
	GUIDelete()
EndFunc

Func CopyClipboard2VPC()
	Dim $CopiedText, $WaitSecs

	MsgBox(0,"Start of Clipboard copy","Select and copy text now and then press OK.")
	$CopiedText = ClipGet()
	MsgBox(0, "The Clipboard contains:", $CopiedText)

	$CopiedText = StringReplace($CopiedText, @CRLF, @LF)

	$WaitSecs = InputBox("Copying Clipboard to destination","Number of seconds before clipboard text will be copied to an activated (destination) window: ","5")
	sleep($WaitSecs * 1000)
	Beep(1300, 100)
	Send ($CopiedText, 1)
EndFunc

Func GetMyIPs()
Local $n, $MyIPaddress, $MyIPAddresses
	$n = 1

	while ($n < 5 And $MyIPaddress <> "0.0.0.0")

		Select
			case $n = 1
				$MyIPaddress = @IPAddress1
			case $n = 2
				$MyIPaddress = @IPAddress2
			case $n = 3
				$MyIPaddress = @IPAddress3
			case $n = 4
				$MyIPaddress = @IPAddress4
		EndSelect
		$MyIPAddresses = $MyIPaddress & @CRLF & $MyIPAddresses
		$n = $n + 1
	WEnd
	return($MyIPAddresses)
EndFunc


Func ShowFWPorts()
	Local $DBlistview, $button, $item1, $item2, $item3, $input1, $DBmsg, $SSHport, $Telnetport, $Webport, $ReadPW, $ViewPW
	Local $fhSessionFWogFile, $line, $AllFwStringArray, $IPbutton

	GUICreate("Locally Forwarded ports during this TunnelGUI session", 440, 280, 250, 100, -1, $WS_SIZEBOX)
	$DBlistview = GUICtrlCreateListView(" Local Port              | Destination Hostname           | Destination IP       | Destination port |  Customer   ", 10, 10, 420, 220);,$LVS_SORTDESCENDING)
	$button = GUICtrlCreateButton("Exit", 245, 250, 70, 20)
	$IPbutton = GUICtrlCreateButton("MyIPs", 125, 250, 70, 20)
	;MsgBox(0,"FWlog",$SessionFWportLogFile)
	$fhSessionFWogFile = FileOpen($SessionFWportLogFile,0)
	If $fhSessionFWogFile = -1 Then
		MsgBox(48, "Port forwarding", "No Local ports are forwarded.")
	Else
		While 1
			$line = FileReadLine($fhSessionFWogFile)
			;MsgBox(0, "Line read:", $line)
			If @error = -1 Then ExitLoop
			$AllFwStringArray = StringSplit($line,";",1)
			;MsgBox(0, "Line read and first element:", $line & " - " & $AllFwStringArray[1])
			If $line Then GUICtrlCreateListViewItem($AllFwStringArray[3] & "  |  "  & $AllFwStringArray[2] & "  |  " & $AllFwStringArray[4] & "  |  "  & $AllFwStringArray[5] & "  |  " & $AllFwStringArray[1] , $DBlistview)
		WEnd
		FileClose($fhSessionFWogFile)
		GUISetState()
		While 1
			$DBmsg = GUIGetMsg()
			Select
				Case $DBmsg = $GUI_EVENT_CLOSE Or $DBmsg = $button
					ExitLoop
				Case $DBmsg = $IPbutton
					MsgBox(64,"My Local IP addres(ses)",GetMyIPs())
			EndSelect
		WEnd
	EndIf
	GUIDelete()
EndFunc


Func ViewINI()
Local $INIfh, $line, $INIGUI, $myedit, $line1, $msg, $array, $l, $slen, $space
	$INIfh = FileOpen($INIDir & $INIFile,0)
	If $INIfh = -1 Then
		MsgBox(0, "Error", "Unable to open file.")
    Else
		$INIGUI = GUICreate("GGTunnelGui INI file: " & $INIDir & $INIFile,600,500,-1,-1,$WS_SIZEBOX)
		GUISetFont(9, 400, 0, "Courier")
		GUISetState()
		$myedit = GUICtrlCreateEdit("", -1, -1, 599, 499)
		;GUISetState()

		While 1
			$line = FileReadLine($INIfh)
			$line1 = $line

			If StringInStr( $line1, "=") > 0 Then
				$array = StringSplit($line1,"=")
				$slen = StringLen($array[1])
				$space = ""
				for $l = 1 to (20-$slen)
					$space = $space & " "
				next
				$line1 = $array[1] & $space & "=" & @TAB & $array[2]
			EndIf
			if StringLeft($line,1) = "[" then $line1 = @CRLF & $line
				;MsgBox(0,$line,"@@@" & StringLeft($line,1) & "##")
				;$line1 = @CR & $line
			If @error = -1 Then ExitLoop
			;if StringLeft($line,5) = "[Main" then ExitLoop
			If $line = "" Then ExitLoop
			GUICtrlSetData($myedit, $line1 & @CRLF,1)
			;MsgBox(0, "Line read:", $line)
		Wend
	EndIf

	FileClose($INIfh)

	While 1
        $msg = GUIGetMsg()

        If $msg = $GUI_EVENT_CLOSE Then ExitLoop
    WEnd

    GUIDelete($INIGUI);

EndFunc


Func EditINI()
	RunWait("notepad.exe " & $INIDir & $INIFile)
EndFunc


Func GGWebpage()
	If not $UpdateIP Then GetUpdateServer("Web")
	If $UpdateIP Then run("""" & $HTTPDIR & """" & " http://" & $UpdateIP & "/RemoteSupport/tools/GGTunnelGui/","")
EndFunc


Func LocalPortForward()
	Local $FORWGUI,$SaveSetButton ,$CancelSetbutton, $ApplySetbutton, $msg

	$FORWGUI = GUICreate("Local Port Forwarding for other hosts", 330, 135, 250, 100, -1, $WS_EX_ACCEPTFILES)
	GUISetState()
	;MsgBox(0,"test","test")
	GUICtrlCreateGroup("Port forwarding Settings:", 10, 10, 310, 70)
	$AllowPortForwCheck_ID = GUICtrlCreateCheckbox("Allow that Local ports accept connections from other hosts.", 15, 25, 300, 20)
	GUICtrlSetState($AllowPortForwCheck_ID, $AllowPortForwCheck)
	If $SSHProductName <> "PuTTY Tray" Then
		GUICtrlCreateLabel("WARNING: This option is only available if PuTTY Tray is used !" & @CRLF & "Check the radiobox to the prefered SSH client in the Program Directories TAB in the Settings menu.", 15, 50, 300,50)
		GUICtrlSetState($AllowPortForwCheck_ID,$GUI_DISABLE)
	EndIf

	$SaveSetButton = GUICtrlCreateButton("&OK", 75, 100, 70, 20)
	$CancelSetbutton = GUICtrlCreateButton("&Cancel",185,100,70,20)
	;$ApplySetbutton = GUICtrlCreateButton("&Apply",240,200,70,20)
	GUISetState()
	While 1
		$msg = GUIGetMsg()
		Select
			;Case (($msg = $SaveSetButton) Or ($msg = $ApplySetbutton ))
			Case ($msg = $SaveSetButton)
				$AllowPortForwCheck = GuiCtrlRead($AllowPortForwCheck_ID)
				;if $AllowPortForwCheck = "1" Then
					;GUICtrlCreateGroup("Port forwarding Settings:", 10, 10, 350, 170)
				;	$AllowPortForwCheck_ID = GUICtrlCreateCheckbox("Create SSH connection with port forwarding in case of direct connection.", 15, 40, 330, 20)
				;	GUICtrlSetState($AllowPortForwCheck_ID, $AllowPortForwCheck)
				;EndIf
				 ExitLoop
			 Case $msg = $CancelSetButton
				 ExitLoop
		EndSelect
	WEnd
	GUIDelete($FORWGUI)
EndFunc


Func HelpAbout()
	CheckDBversion()
	;If not $UpdateIP Then GetUpdateServer("")
	MsgBox(0,"              About GGTunnelGui        ","                  GGTunnelGUI" & @CRLF & "            Version " & $Fileversion & " (" & $ver & ")" & @CRLF & @CRLF & "               SQLiteDB - " & $DBCountry & " " & $DBversion & @CRLF & @CRLF & "      (C) Henk van der Hulst - 2008-2016")
EndFunc


Func GetUpdateServer($server)
Local $pingAlcaServer, $pingTACServer
	$pingAlcaServer = ping($GGTunnelGuiUpdServ,2000)
	$pingTACServer = ping($VLANUpdateServ,2000)
	If $pingAlcaServer <> 0 Then
		$UpdateIP = $GGTunnelGuiUpdServ
	ElseIf $pingTACServer <> 0 Then
		$UpdateIP = $VLANUpdateServ
	Else
		MsgBox(64,"Server availability",$server & " server not reachable! ")
		$UpdateIP = ""
	EndIf
EndFunc


Func ShowDocs()
	Local $file, $line, $pingAlcaServer, $pingTACServer
	MsgBox(0,"Checking for Documentation","       Please Wait!",2)
	If not $UpdateIP Then GetUpdateServer("Documentation")
	If $UpdateIP Then
		run("""" & $HTTPDIR & """" & " http://" & $UpdateIP & "/GGTunnelGui/docs/GOGlobalTunnelGui.pdf","")
	EndIf
EndFunc


Func ShowSharePoint()
	run("""" & $HTTPDIR & """" & " https://all1.eu.alcatel-lucent.com/teams/emeatso/Optics/CTA/CustomerDB/Shared%20Documents/Forms/AllItems.aspx","")
	MsgBox(64,"SharePoint availability","SharePoint only reachable via Alcanet",8)
EndFunc


Func ShowSharedDrive()
	run("explorer \\" & $GGTunnelGuiUpdServ & "\remdiag\share\RemoteSupport\ ","")
	MsgBox(64,"VirtualPC's Shared Drive Availability.","The Shared drive is only reachable via Alcanet",8)
EndFunc


Func ShowUsedVPCs()
	run("""" & $HTTPDIR & """" & " http://135.85.48.200:8080","")
	MsgBox(64,"Status availability","Status only reachable via Alcanet",8)
EndFunc

Func DownloadGGUpdate()
	Local $file, $line, $pingAlcaServer, $pingTACServer
	MsgBox(0,"Checking for Updates","             Please Wait!",2)
	If not $UpdateIP Then GetUpdateServer("Update")
	If $UpdateIP Then
		$httpGetGGv = InetGet("http://" & $UpdateIP & "/GGTunnelGui/GGversion.txt", $TEMPDIR & "/GGversion.txt")
		$file = FileOpen ( $TEMPDIR & "/GGversion.txt", 0 )
		$line = FileReadLine($file,1)
		FileClose($file)
		FileDelete($TEMPDIR & "/GGversion.txt")
		$NewFileVersion = $line
		;if $line <> $Fileversion Then
		if $line <> $InstallerVersion Then
			;$UpdateGGID = MsgBox(4,"GGTunnelGui update found (v" & $Fileversion & " --> v" & $NewFileVersion & ")","    An Application update is available! (v" & $NewFileVersion & ")" & @CRLF & "                  Download ? (y/n)")
			$UpdateGGID = MsgBox(4,"GGTunnelGui update found (v" & $InstallerVersion & " --> v" & $NewFileVersion & ")","    An Application update is available! (v" & $NewFileVersion & ")" & @CRLF & "                  Download ? (y/n)")
		Else
			MsgBox(0,"GGTunnelGui App Update","   No App update available!")
		EndIf
		;20120520 commented next line:
		;$UpdateOnGoing = "TRUE"
		If $UpdateGGID = "6" then
			$UpdateOnGoing = "TRUE"
			;MsgBox(0,"http://" & $UpdateIP & "/GGTunnelGui/downloads/GGTunnelGUI-GGAppOnly_v" & $NewFileVersion & "-Installer.exe",$GGtunnelDir & "GGTunnelGUI-GGAppOnly_v" & $NewFileVersion & "-Installer.exe")
			;$httpDownlGG = InetGet("http://" & $UpdateIP & "/GGTunnelGui/downloads/GGTunnelGUI-v" & $NewFileVersion & "-GGAppOnly-Installer.exe",$TEMPDIR & "\GGTunnelGUI-v" & $NewFileVersion & "-GGAppOnly-Installer.exe",1,1)
			;Now downloading the whole package.
			$httpDownlGG = InetGet("http://" & $UpdateIP & "/GGTunnelGui/downloads/GGTunnelGUI-v" & $NewFileVersion & "-Full-Installer.exe",$TEMPDIR & "\GGTunnelGUI-v" & $NewFileVersion & "-Full-Installer.exe",1,1)
		EndIf
	EndIf
EndFunc


Func CheckDBversion()
	local $DBUpdateQuery
	If FileExist($SQliteDB) And FileGetSize($SQliteDB) > 0 Then
		;MsgBox(0,"into select","select")
		If _SQLite_QuerySingleRow($GGDB,"SELECT autor, comment from comments where id = 24",$DBUpdateQuery) = $SQLITE_OK Then
			$DBCountry = $DBUpdateQuery[0]
			If $DBCountry = "" Then
				$DBversion = ""
			Else
				$DBversion = $DBUpdateQuery[1]
			EndIf
		EndIf
	EndIf
	If (Not $DBversion) Then $DBversion = "?"
EndFunc


Func DownloadDBUpdate()
	Local $file, $line, $UpdateDBID, $pingAlcaServer, $pingTACServer, $ApPath, $szDrive, $szDir, $szFName, $szExt
		If not $UpdateIP Then GetUpdateServer("Update")
		If $UpdateIP Then
			$httpGetDBv = InetGet("http://" & $UpdateIP & "/GGTunnelGui/DBversion.txt", $TEMPDIR & "/DBversion.txt")
			CheckDBversion()
			If $DBversion <> "?" Then
				$file = FileOpen ( $TEMPDIR & "/DBversion.txt", 0 )
				While 1
					$line = FileReadLine($file)
					If (@error = -1 Or $line = $DBCountry) Then ExitLoop
					;MsgBox(0, "Line read:", $line)
				Wend
				$line = FileReadLine($file)
				FileClose($file)
				FileDelete($TEMPDIR & "/DBversion.txt")
				$NewFileVersion = $line
				if ($line <> $DBversion And $NewFileVersion <> "") Then
					$UpdateDBID = MsgBox(4,"TunnelGui DB update found","       A DB update (" & $NewFileVersion & ") is available! " & @CRLF & "            Download ? (y/n)")
				Else
					MsgBox(0,"GGTunnelGui DB Update","   No DB update available!")
				EndIf
				If $UpdateDBID = "6" then
					$UpdateDBOnGoing = "TRUE"
					$ApPath = _PathSplit($SQliteDB, $szDrive, $szDir, $szFName, $szExt)
					$SQliteDB_old = $SQliteDB
					$GGDBold = $GGDB
					$SQliteDB = $szDrive & $szDir & "GUI_SQ_" & $DBCountry & "_database_V" & $NewFileVersion & $szExt
					;MsgBox(0,"http://" & $UpdateIP & "/GGTunnelGui/downloads/GUI_SQ_" & $DBCountry & "_database_V" & $NewFileVersion & ".db", $szDrive & $szDir & "GUI_SQ_" & $DBCountry & "_database_V" & $NewFileVersion & $szExt)
					$httpDownlDB = InetGet("http://" & $UpdateIP & "/GGTunnelGui/downloads/GUI_SQ_" & $DBCountry & "_database_V" & $NewFileVersion & ".db", $szDrive & $szDir & "GUI_SQ_" & $DBCountry & "_database_V" & $NewFileVersion & $szExt,1,1)
				EndIf
			Else
				MsgBox(0,"Database problem","No (valid) database loaded!")
			EndIf
		EndIf
EndFunc


Func CheckUpdateSettings()
	Local $UpdateYN
	$UpdateYN = MsgBox(4,"Updates","Check for updates ?")
	If $UpdateYN = "6" Then
		MsgBox(0,"Checking for Updates","Please Wait!",1)
		If $GGUpdateCheck = "1" Then DownloadGGUpdate()
		sleep(10000)
		While Not InetGetInfo($httpDownlGG,2)
			sleep(1000)
		Wend
		If $DBUpdateCheck = "1" Then DownloadDBUpdate()
	EndIf
EndFunc


Func HideViaOptions()
	GUICtrlSetState($VPC_passID, $GUI_HIDE)
	GUICtrlSetState($nlsdh1_passID, $GUI_HIDE)
	GUICtrlSetState($pass1Label, $GUI_HIDE)
	GUICtrlSetState($pass2Label, $GUI_HIDE)
	GUICtrlSetState($pass3Label, $GUI_HIDE)
	GUICtrlSetState($pass4Label, $GUI_HIDE)
	GUICtrlSetState($DameLabel, $GUI_HIDE)
	GUICtrlSetState($DameWarePC_ID, $GUI_HIDE)
	GUICtrlSetState($VPCLabel, $GUI_HIDE)
	GUICtrlSetState($VirtualPC_ID, $GUI_HIDE)
	GUICtrlSetState($IPHomeLabel, $GUI_HIDE)
	GUICtrlSetState($UseHomeGW_ID, $GUI_HIDE)
	GUICtrlSetState($VNCbuttonID, $GUI_HIDE)
	GUICtrlSetState($Host_ID, $GUI_HIDE)
	GUICtrlSetState($HostLabel, $GUI_HIDE)
	GUICtrlSetState($HostAddressLabel, $GUI_HIDE)
	GUICtrlSetState($HostAddress_ID, $GUI_HIDE)
	GUICtrlSetState($UserLabel, $GUI_HIDE)
	GUICtrlSetState($User_ID, $GUI_HIDE)
	GUICtrlSetState($ApplicationLabel1, $GUI_HIDE)
	GUICtrlSetState($ApplicationLabel2, $GUI_HIDE)
	GUICtrlSetState($ApplicationVersion_ID, $GUI_HIDE)
	GUICtrlSetState($PasswordLabel, $GUI_HIDE)
	GUICtrlSetState($Password_ID, $GUI_HIDE)
	GUICtrlSetState($ShowPasswd_ID, $GUI_HIDE)
	GuiCtrlSetState($SSHinfo_ID, $GUI_HIDE)
	GuiCtrlSetState($SSHinfoVPC_ID, $GUI_HIDE)
	GuiCtrlSetState($SSHinfo2_ID, $GUI_HIDE)
	GuiCtrlSetState($HostInfo_ID, $GUI_HIDE)
	GuiCtrlSetState($DameRemark, $GUI_HIDE)
	GuiCtrlSetState($CheckDialinbutton, $GUI_HIDE)
	GUICtrlSetState($ShowPasswd_ID, $GUI_HIDE)
	GUICtrlSetState($ShowPasswdLabel, $GUI_HIDE)
	GUICtrlSetState($UseHostAsHop_ID, $GUI_HIDE)
	GUICtrlSetState($UseAsJumpHost_Group, $GUI_HIDE)
	;GUICtrlSetState($JumpHostbutton, $GUI_HIDE)
EndFunc

Func HideTheViaOptions()

EndFunc

Func CheckRAMSESConnection()
Local $lineRAS, $file, $RASDIAL_Aventail_PID
If FileExists($TEMPDIR & "rasAventail.txt") Then FileDelete($TEMPDIR & "rasAventail.txt")
			$RASDIAL_Aventail_PID = RunWait(@ComSpec & ' /c ' & "rasdial.exe " & ' > ' & $TEMPDIR & 'rasAventail.txt',"",@SW_HIDE)
			;sleep(1000)
			for $t = 1 to $RASDIAL_TIMEOUT
				If (FileExists($TEMPDIR & "rasAventail.txt") AND FileGetSize($TEMPDIR & "rasAventail.txt") > 0) Then ExitLoop
			Next
			$lineRAS = ""
			;MsgBox(0,"sdsdas",@ComSpec & ' /c ' & "rasdial.exe " & ' > ' & $TEMPDIR & 'rasAventail.txt')
			$file = FileOpen($TEMPDIR & "rasAventail.txt", 0)
			;While 1
			;	$line = FileReadLine($file)
			;	MsgBox(0,"Raddial", "##" & $line & "##")
			;	$lineRAS = $lineRAS & " " & $line
			;	StringStripCR ( $line )
			;	;If @error <> -1 Then
			;	;	If StringInStr($line,"RAMSES") Then
			;	;		$RamsesRASdial = $line
			;	;	EndIf
			;	;EndIf
			;	;$line4 = $line4 & @LF & FileReadLine($file)
			;	If @error = -1 Then ExitLoop
			;Wend
			$lineRAS = FileReadLine($file,2)
			StringStripCR ( $lineRAS )
			FileClose($file)
			;If StringInStr($lineRAS,"RAMSES") Then $RamsesRASdial = $lineRAS
			If StringInStr($lineRAS,"RAMSES") Then $Aventail_DialUp = $lineRAS
			;MsgBox(0,"RAMSES Connection", "##" & $RamsesRASdial & "##")
			;MsgBox(0,"dsds",StringInStr($lineRAS,"Aventail VPN Connection"))
			;If (Not ProcessExists("ngmonitor.exe")) Then
			;MsgBox(0,"Aventail",$lineRAS)

			Return $lineRAS

EndFunc


Func CheckSecurityAlert()
	Local $AlertTitle = "PuTTY Security Alert"
	Local $RiskTitle = "Security risk"
	If WinExists($AlertTitle) Then
		If Not WinActive($AlertTitle) Then WinActivate($AlertTitle)
		Send("Y")
		Send("J")
		sleep(1000)
	EndIf
	If WinExists($RiskTitle) Then
		If Not WinActive($RiskTitle) Then WinActivate($RiskTitle)
		Send("Y")
		Send("J")
		sleep(1000)
	EndIf
EndFunc

Func CheckPuTTYError()
If WinExists("PuTTY Fatal Error") Then
    MsgBox(16, "PuTTY timeout or wrong info provided", "Please check if you gave the right passphrases or increase the timeouts !" & @CRLF & "Click on 'Reset', check your input and try again")
EndIf
EndFunc


Func RemovePuTTYSessions()
	If FileExists($PUTTYDR & "sessions") Then FileDelete($PUTTYDR & "sessions\*_session")
	If FileExists($PUTTYDR & "putty_tray*.log*") Then FileDelete($PUTTYDR & "putty_tray*.log*")
EndFunc

Func RemoveFwTunnelSessions()
	If FileExists($SessionFWportLogFile) Then FileDelete($SessionFWportLogFile)
EndFunc

Func CheckSessionExsists2($SSHcon)
	Local $AllSessionsandPIDsArray, $iIndex, $PIDstr, $PID, $xarray
	While WinExists("PuTTY Fatal Error")
		If Not WinActive("PuTTY Fatal Error") Then WinActivate("PuTTY Fatal Error")
		Send("{ENTER}")
		sleep(300)
	WEnd
	While WinExists("PuTTY (inactive)")
		If Not WinActive("PuTTY (inactive)") Then WinActivate("PuTTY (inactive)")
		Send("!{F4}")
		sleep(300)
	WEnd
	$PuTTYSession = $SSHcon & "_" & $Customer & "_" & $Customer_host & "_session"
	$AllSessionsandPIDsArray = StringSplit($AllSessionsandPIDs,"|",1)
	_ArrayDisplay($AllSessionsandPIDsArray, "AllPuTTYSessions, checking " & $PuTTYSession )
	$iIndex = _ArraySearch($AllSessionsandPIDsArray, $PuTTYSession, 1, 0, 0, 1)
	If @error Then
		CreatePuTTYSession($SSHcon)
	Else
		$PIDstr = StringSplit($AllSessionsandPIDsArray[$iIndex],$PuTTYSession , 1)
		$PID = StringTrimLeft($PIDstr[2],1)
		If ProcessExists($PID) Then
			;MsgBox(0,$PID,$PID & " bestaat")
			Return 1
		Else
			_ArrayDelete($AllSessionsandPIDsArray, $iIndex)
			$AllSessionsandPIDsArray[0] = $AllSessionsandPIDsArray[0] -1
			$AllSessionsandPIDs = ""
			for $xarray = 1 to $AllSessionsandPIDsArray[0]
				$AllSessionsandPIDs =  $AllSessionsandPIDs & "|" & $AllSessionsandPIDsArray[$xarray]
			Next
			StringTrimLeft($AllSessionsandPIDs,1)
			_ArrayDisplay($AllSessionsandPIDsArray, $PuTTYSession & " er uit")
			CreatePuTTYSession($SSHcon)
		EndIf
	EndIf

EndFunc

Func CheckSessionExsists($SSHcon)
	Local $AllSessionsandPIDsArray, $iIndex, $PIDstr, $PID, $xarray, $ConQuery, $Session, $PuTTYPID
	While WinExists("PuTTY Fatal Error")
		If Not WinActive("PuTTY Fatal Error") Then WinActivate("PuTTY Fatal Error")
		Send("{ENTER}")
		sleep(300)
	WEnd
	While WinExists("PuTTY (inactive)")
		If Not WinActive("PuTTY (inactive)") Then WinActivate("PuTTY (inactive)")
		Send("!{F4}")
		sleep(300)
	WEnd
	$PuTTYSession = $Customer & "_" & $Customer_host & "_" & $SSHcon & "_session"
	$Session = ""
	$PuTTYPID = ""
	_SQLite_QuerySingleRow($DBmem,"SELECT count(*) from PuTTYConnections where PConn = '" & $PuTTYSession & "'",$ConQuery)
	If $conQuery[0] = "0" Then
		CreatePuTTYSession($SSHcon)
	Else
		_SQLite_QuerySingleRow($DBmem,"SELECT PConn, PID from PuTTYConnections where PConn = '" & $PuTTYSession & "'",$ConQuery)
		$Session = $ConQuery[0]
		$PuTTYPID = $ConQuery[1]
		If ProcessExists($PuTTYPID) Then
			Return 1
		Else
			; Delete row
			_SQLite_Exec($DBmem,"delete from PuTTYConnections where PConn = " & "'" & $PuTTYSession & "'")
			CreatePuTTYSession($SSHcon)
		EndIf
	EndIf

EndFunc


Func SetInfoText($infotext)
	$InfoIcon_ID = GUICtrlCreateIcon("shell32.dll", 1001, $leftInfoText, $topInfoText,16,16)
	$CreateInfoLabel = GUICtrlCreateLabel($infotext, $leftInfoText + 23, $topInfoText, 220)
	GUICtrlSetColor ($CreateInfoLabel, 0x0000D0)
EndFunc

Func SetInfoText2($infotext,$x,$y)
	$InfoIcon2_ID = GUICtrlCreateIcon("shell32.dll", 1001, $x, $y,16,16)
	$CreateInfoLabel2 = GUICtrlCreateLabel($infotext, $x+23, $y, 220)
	GUICtrlSetColor ($CreateInfoLabel, 0x0000C0)
EndFunc

Func SetInfoText3($infotext)
	$InfoIcon3_ID = GUICtrlCreateIcon("shell32.dll", 1001, 6, $ybottom-24,16,16)
	$CreateInfoLabel3 = GUICtrlCreateLabel($infotext, 29, $ybottom-24, 220)
	GUICtrlSetColor ($CreateInfoLabel, 0x0000C0)
EndFunc

Func DelInfoText3()
	GUICtrlSetState($CreateInfoLabel3,$GUI_HIDE)
	GUICtrlSetState($InfoIcon3_ID,$GUI_HIDE)
EndFunc


Func DelInfoText2()
	GUICtrlSetState($CreateInfoLabel2,$GUI_HIDE)
	GUICtrlSetState($InfoIcon2_ID,$GUI_HIDE)
EndFunc

Func DelInfoText()
	GUICtrlSetState($CreateInfoLabel,$GUI_HIDE)
	GUICtrlSetState($InfoIcon_ID,$GUI_HIDE)
EndFunc


Func CreateNXSessionConfigFile($host,$user,$NXport,$password,$Customer_host)
Local $configfile, $key, $scrambled_nxpassword
	;MsgBox(0,"NXPORT in SessionConfig", $NXport)
	;FileCopy($NXDIR & "\config\NXclient-template.nxs",$NXDIR & "\config\" & $Customer_host & ".nxs",1)
	FileCopy($GGTunnelDir & "\programs\NXclient\config\NXclient-template.nxs",$NXDIR & "config\" & $Customer_host & ".nxs",1)
	;MsgBox(0,"copy template",$GGTunnelDir & "programs\NXclient\config\NXclient-template.nxs   copied too:   " & $NXDIR & "config\" & $Customer_host & ".nxs")
	_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXUSERNAME",$user)
	_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXHOSTNAME",$host)
	_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXPORT",$NXport)
	if $password Then
		$scrambled_nxpassword = scrambleString($password)
		_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXSCRAMBLEDPASSWORD",$scrambled_nxpassword)
		_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXREMEMBERPASSWD_BOOLEAN","true")
	Else
		_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXSCRAMBLEDPASSWORD","EMPTY_PASSWORD")
		_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXREMEMBERPASSWD_BOOLEAN","false")
	EndIf
	$configfile = FileOpen($GGTunnelDir & "\programs\NXclient\config\" & $Customer_host & "-key.txt",0)
	$key = FileRead($configfile)
	FileClose($configfile)
	_ReplaceStringInFile($NXDIR & "config\" & $Customer_host & ".nxs","NXPUBLICKEY",$key)
	;MsgBox(0,"NX config",$NXDIR & "\config\NXclient-template.nxs")
EndFunc


Func CreatePuTTYSession($SSHcon)
Local $OpenFile,$aRecords,$szDrive,$szDir,$szFName,$szExt, $PuTTYLG, $CreatePuTTYSessionLabel, $pass, $ProxyLength
	$loadFile = ""
	;$SSHProductName = FileGetVersion ( $PuTTYDIR ,"ProductName" )
	If $SSHProductName = "PuTTY Tray" Then
		SetInfoText("Creating PuTTY session !")
		_PathSplit($PuTTYDIR, $szDrive, $szDir, $szFName, $szExt)
		$PUTTYDR = $szDrive & $szDir
		$PuTTYLOG = $PUTTYDR & "putty_tray_" & $SSHcon & "_" & $Customer & "_" & $Customer_host & ".log"
		$PuTTYLG = StringReplace($PuTTYLOG, "\", "%5C")
		$tmpPuTTYLOG = $PuTTYLOG & ".tmp"
		If Not FileExists($PUTTYDR & "sessions") Then DirCreate($PUTTYDR & "sessions")
		If Not FileExists($PUTTYDR & "sessions\session_putty_tray") Then FileInstall("session_putty_tray",$PUTTYDR & "sessions\session_putty_tray")
		FileCopy($PUTTYDR & "sessions\" & $LoadSession,$PUTTYDR & "sessions\" & $PuTTYSession,1)
		_ReplaceStringInFile($PUTTYDR & "sessions\" & $PuTTYSession,"putty_tray.log",$PuTTYLG)
		If $AllowPortForwCheck = "1" Then _ReplaceStringInFile($PUTTYDR & "sessions\" & $PuTTYSession,"LocalPortAcceptAll\0","LocalPortAcceptAll\1")
		If $ProxyType <> "None" Then
			$ProxyPassword_ASCIIarray = StringToASCIIArray($ProxyPassword)
			;_ArrayDisplay($ProxyPassword_ASCIIarray)
			$ProxyLength = StringLen($ProxyPassword)
			;MsgBox(0,"Lengte",$ProxyLength)
			$ProxyPassword = ""
			For $x = 0 to $ProxyLength-1

				;MsgBox(0,"lengte array",$ProxyPassword_ASCIIarray[0])
				$pass = $ProxyPassword_ASCIIarray[$x]
				Select
					Case $pass = "37"
						$ProxyPassword = $ProxyPassword & "%25"
					Case $pass = "42"
						$ProxyPassword = $ProxyPassword & "%2A"
					Case $pass = "92"
						$ProxyPassword = $ProxyPassword & "%5C"
					Case $pass = "63"
						$ProxyPassword = $ProxyPassword & "%3F"
					Case $pass = "176"
						$ProxyPassword = $ProxyPassword & "%B0"
					Case $pass = "167"
						$ProxyPassword = $ProxyPassword & "%A7"
					Case $pass = "223"
						$ProxyPassword = $ProxyPassword & "%DF"
					Case $pass = "180"
						$ProxyPassword = $ProxyPassword & "%B4"
					Case $pass = "220"
						$ProxyPassword = $ProxyPassword & "%DC"
					Case $pass = "252"
						$ProxyPassword = $ProxyPassword & "%FC"
					Case $pass = "214"
						$ProxyPassword = $ProxyPassword & "%D6"
					Case $pass = "246"
						$ProxyPassword = $ProxyPassword & "%F6"
					Case $pass = "196"
						$ProxyPassword = $ProxyPassword & "%C4"
					Case $pass = "228"
						$ProxyPassword = $ProxyPassword & "%E4"

					Case $pass = "178"
						$ProxyPassword = $ProxyPassword & "%B2"
					Case $pass = "233"
						$ProxyPassword = $ProxyPassword & "%E9"
					Case $pass = "232"
						$ProxyPassword = $ProxyPassword & "%E8"
					Case $pass = "231"
						$ProxyPassword = $ProxyPassword & "%E7"
					Case $pass = "224"
						$ProxyPassword = $ProxyPassword & "%E0"
					Case $pass = "176"
						$ProxyPassword = $ProxyPassword & "%B0"
					Case $pass = "168"
						$ProxyPassword = $ProxyPassword & "%A8"
					Case $pass = "163"
						$ProxyPassword = $ProxyPassword & "%A3"
					Case $pass = "249"
						$ProxyPassword = $ProxyPassword & "%F9"
					Case $pass = "181"
						$ProxyPassword = $ProxyPassword & "%B5"
					Case $pass = "42"
						$ProxyPassword = $ProxyPassword & "%2A"

					Case Else
						$ProxyPassword = $ProxyPassword & chr($ProxyPassword_ASCIIarray[$x])

				EndSelect
			Next
			_ReplaceStringInFile($PUTTYDR & "sessions\" & $PuTTYSession,"ProxyPassword\\","ProxyPassword\" & $ProxyPassword & "\")
			_ReplaceStringInFile($PUTTYDR & "sessions\" & $PuTTYSession,"ProxyUsername\\","ProxyUsername\" & $ProxyUsername & "\")
			;MsgBox(0,"ProxyPort" & $ProxyPassword,$ProxyPort)
			_ReplaceStringInFile($PUTTYDR & "sessions\" & $PuTTYSession,"ProxyPort\0\","ProxyPort\" & $ProxyPort & "\")
			_ReplaceStringInFile($PUTTYDR & "sessions\" & $PuTTYSession,"ProxyHost\proxy\","ProxyHost\" & $ProxyHostname & "\")
			_ReplaceStringInFile($PUTTYDR & "sessions\" & $PuTTYSession,"ProxyMethod\0\","ProxyMethod\" & "3" & "\")
			; ProxyMethod = ProxyType; HTTP=3
		EndIf
		_FileReadToArray($PUTTYDR & "sessions\" & $PuTTYSession,$aRecords)
		$OpenFile = FileOpen($PUTTYDR & "sessions\" & $PuTTYSession,2)
		If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Session file and logfile", $PUTTYDR & "sessions\" & $PuTTYSession & @CRLF & $PuTTYLOG & @CRLF & $PuTTYLG)
		For $x = 1 to $aRecords[0]
			FileWriteLine($OpenFile,$aRecords[$x] & @LF)
		Next
		FileClose($OpenFile)
		If FileExists($PuTTYLOG) Then FileDelete($PuTTYLOG)
		If FileExists($tmpPuTTYLOG) Then FileDelete($tmpPuTTYLOG)
		$loadFile = " -loadfile " & $PuTTYSession
		DelInfoText()
	EndIf
EndFunc


Func SSHviaSlsvho()
;If (CheckSessionExsists("AlcanetGW-DE_") = "1" Or $RetryAnswer = "3") Then Return 0
If (CheckSessionExsists("AlcanetGW-DE_") = "1") Then Return 0

$s = 0
$xtop = 6
GUICtrlSetState($progressbar1, $GUI_HIDE)
GUICtrlSetState($progressLabel, $GUI_HIDE)
$progressLabel = GUICtrlCreateLabel("Progress SSH connection to Alcanet GW:", $leftProgressLabel, $topProgressLabel, 210)
$progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
If $DEBUG Then
	If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"SSHviaSlsvho",$PuTTYDIR & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW & " -pw " & $AlcanetGWPasswd)
	If StringInStr($DEBUG,"1") <> "0" Then $SlsvhoPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW & " -pw " & $AlcanetGWPasswd,"")
Else
	$SlsvhoPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW & " -pw " & $AlcanetGWPasswd,"",@SW_HIDE)
EndIf
$LastSSHPID = $SlsvhoPID
$AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $SlsvhoPID
_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $SlsvhoPID & "','" & _Now() & "')")
WinWait($AlcanetGW & " - PuTTY")
If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
For $i = $s To $SlsvhoWait
	If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
	If FileExists($tmpPuTTYLOG) And  _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
	CheckSecurityAlert()
	GUICtrlSetData($progressbar1, ($i*$x2width)/$SlsvhoWait)
	sleep(1000)
Next
CheckSecurityAlert()
GUICtrlSetState($progressbar1, $GUI_HIDE)
GUICtrlSetState($progressLabel, $GUI_HIDE)
EndFunc


Func SSHviaSlsvhoNew()
;Local $RetryAnswer
  ;If (CheckSessionExsists("AlcanetGW-NL_") = "1" Or $RetryAnswer = "3") Then Return 0
  If (CheckSessionExsists("AlcanetGW-DE_") = "1" ) Then Return 0

  $s = 0
  $xtop = 6
  ;MsgBox(0,"Gateay in sdhswl", $AlcanetGW)
  ;MsgBox(0,"Tunnelstring in SSHviaSwdl", $Tunnelstring)
  GUICtrlSetState($progressbar1, $GUI_HIDE)
  GUICtrlSetState($progressLabel, $GUI_HIDE)
  $progressLabel = GUICtrlCreateLabel("Progress SSH connection to Alcanet GW:", $leftProgressLabel, $topProgressLabel, 210)
  $progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
  If $DEBUG Then
	If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Putty Alcanet GW sdhswdl",$PuTTYDIR & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW)
	If StringInStr($DEBUG,"1") <> "0" Then $SlsvhoPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " " & $Tunnelstring & " " & $AlcanetGWUser & "@" & $AlcanetGW,"")
  Else
	;$SwdlPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW,"",@SW_HIDE)
	$SlsvhoPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " " & $Tunnelstring & " " & $AlcanetGWUser & "@" & $AlcanetGW,"",@SW_HIDE)
  EndIf
  $LastSSHPID = $SlsvhoPID
  sleep(1000)
  WinWaitActive($AlcanetGW & " - PuTTY")
 ;sleep(1000)
 ;MsgBox(0,"Putty opened " & $AlcanetGW & " " & $GuiTitle, $RetryAnswer)
  If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
  ;If $RetryAnswer <> "3" Then
	$RetryAnswer = "0"
  	Do
		$s = 0
		For $i = $s To $SdhswdlWait
			CheckSecurityAlert()
			GUICtrlSetData($progressbar1, $i * ($x2width/$SdhswdlWait))
			sleep(1000)
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:") > 0 Then ExitLoop
		Next
		If (Not FileExists($tmpPuTTYLOG) Or (FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:")) <= 0) And $SSHProductName = "PuTTY Tray" Then $RetryAnswer = MsgBox(5,"SSH Connection not ready yet","Press 'Retry' to wait for connection." & @CRLF & "Press 'Cancel' to end this session to " & $Customer & ".")
		If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:") > 0 Then ExitLoop
		If $SSHProductName <> "PuTTY Tray" Then ExitLoop
	Until ($RetryAnswer = "2" Or $SSHProductName <> "PuTTY Tray")
	If $RetryAnswer = "2" Then
		ProcessClose($SlsvhoPID)
		$SlsvhoPID = ""
	Else
		If Not WinActive($AlcanetGW & " - PuTTY") Then WinActivate($AlcanetGW & " - PuTTY")
		sleep(200)
		Send($AlcanetGWPasswd & "{ENTER}")
		 $AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $SlsvhoPID
		_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $SlsvhoPID & "','" & _Now() & "')")
 	EndIf
	GUICtrlSetState($progressbar1, $GUI_HIDE)
	GUICtrlSetState($progressLabel, $GUI_HIDE)
	$AllPuTTYPIDS = $AllPuTTYPIDS & "|" & $SlsvhoPID
EndFunc


Func SSHviaSwdl()
;Local $RetryAnswer
  ;If (CheckSessionExsists("AlcanetGW-NL_") = "1" Or $RetryAnswer = "3") Then Return 0
  If (CheckSessionExsists("AlcanetGW-NL_") = "1" ) Then Return 0

  $s = 0
  $xtop = 6
  ;MsgBox(0,"Gateay in sdhswl", $AlcanetGW)
  ;MsgBox(0,"Tunnelstring in SSHviaSwdl", $Tunnelstring)
  GUICtrlSetState($progressbar1, $GUI_HIDE)
  GUICtrlSetState($progressLabel, $GUI_HIDE)
  $progressLabel = GUICtrlCreateLabel("Progress SSH connection to Alcanet GW:", $leftProgressLabel, $topProgressLabel, 210)
  $progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
  If $DEBUG Then
	If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Putty Alcanet GW sdhswdl",$PuTTYDIR & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW)
	If StringInStr($DEBUG,"1") <> "0" Then $SwdlPID = run("""" & $PuTTYDIR & """" &  " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW,"")
  Else
	$SwdlPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW,"",@SW_HIDE)
  EndIf
  $LastSSHPID = $SwdlPID
 WinWait($AlcanetGW & " - PuTTY")
  If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
  ;If $RetryAnswer <> "3" Then
	$RetryAnswer = "0"
  	Do
		$s = 0
		For $i = $s To $SdhswdlWait
			CheckSecurityAlert()
			GUICtrlSetData($progressbar1, $i * ($x2width/$SdhswdlWait))
			sleep(1000)
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:") > 0 Then ExitLoop
		Next
		If (Not FileExists($tmpPuTTYLOG) Or (FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:")) <= 0) And $SSHProductName = "PuTTY Tray" Then $RetryAnswer = MsgBox(5,"SSH Connection not ready yet","Press 'Retry' to wait for connection." & @CRLF & "Press 'Cancel' to end this session to " & $Customer & ".")
		If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:") > 0 Then ExitLoop
		If $SSHProductName <> "PuTTY Tray" Then ExitLoop
	Until ($RetryAnswer = "2" Or $SSHProductName <> "PuTTY Tray")
	If $RetryAnswer = "2" Then
		ProcessClose($SwdlPID)
		$SwdlPID = ""
	Else
		If Not WinActive($AlcanetGW & " - PuTTY") Then WinActivate($AlcanetGW & " - PuTTY")
		sleep(200)
		Send($AlcanetGWPasswd & "{ENTER}")
		 $AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $SwdlPID
		_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $SwdlPID & "','" & _Now() & "')")
 	EndIf
	GUICtrlSetState($progressbar1, $GUI_HIDE)
	GUICtrlSetState($progressLabel, $GUI_HIDE)
	$AllPuTTYPIDS = $AllPuTTYPIDS & "|" & $SwdlPID
EndFunc

Func SSHviaSwdlNew()
;Local $RetryAnswer
  ;If (CheckSessionExsists("AlcanetGW-NL_") = "1" Or $RetryAnswer = "3") Then Return 0
  If (CheckSessionExsists("AlcanetGW-NL_") = "1" ) Then Return 0

  $s = 0
  $xtop = 6
  ;MsgBox(0,"Gateay in sdhswl", $AlcanetGW)
  ;MsgBox(0,"Tunnelstring in SSHviaSwdl", $Tunnelstring)
  GUICtrlSetState($progressbar1, $GUI_HIDE)
  GUICtrlSetState($progressLabel, $GUI_HIDE)
  $progressLabel = GUICtrlCreateLabel("Progress SSH connection to Alcanet GW:", $leftProgressLabel, $topProgressLabel, 210)
  $progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
  If $DEBUG Then
	If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Putty Alcanet GW sdhswdl",$PuTTYDIR & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW)
	If StringInStr($DEBUG,"1") <> "0" Then $SwdlPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " " & $Tunnelstring & " " & $AlcanetGWUser & "@" & $AlcanetGW,"")
  Else
	;$SwdlPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $AlcanetGWUser & "@" & $AlcanetGW,"",@SW_HIDE)
	$SwdlPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " " & $Tunnelstring & " " & $AlcanetGWUser & "@" & $AlcanetGW,"",@SW_HIDE)
  EndIf
  $LastSSHPID = $SwdlPID
  sleep(1000)
  WinWaitActive($AlcanetGW & " - PuTTY")
 ;sleep(1000)
 ;MsgBox(0,"Putty opened " & $AlcanetGW & " " & $GuiTitle, $RetryAnswer)
  If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
  ;If $RetryAnswer <> "3" Then
	$RetryAnswer = "0"
  	Do
		$s = 0
		For $i = $s To $SdhswdlWait
			CheckSecurityAlert()
			GUICtrlSetData($progressbar1, $i * ($x2width/$SdhswdlWait))
			sleep(1000)
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:") > 0 Then ExitLoop
		Next
		If (Not FileExists($tmpPuTTYLOG) Or (FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:")) <= 0) And $SSHProductName = "PuTTY Tray" Then $RetryAnswer = MsgBox(5,"SSH Connection not ready yet","Press 'Retry' to wait for connection." & @CRLF & "Press 'Cancel' to end this session to " & $Customer & ".")
		If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"password:","password:") > 0 Then ExitLoop
		If $SSHProductName <> "PuTTY Tray" Then ExitLoop
	Until ($RetryAnswer = "2" Or $SSHProductName <> "PuTTY Tray")
	If $RetryAnswer = "2" Then
		ProcessClose($SwdlPID)
		$SwdlPID = ""
	Else
		If Not WinActive($AlcanetGW & " - PuTTY") Then WinActivate($AlcanetGW & " - PuTTY")
		sleep(200)
		Send($AlcanetGWPasswd & "{ENTER}")
		$s = 0
		;MsgBox(0,"Putty",$PuTTYLOG)
		For $i = $s To $SdhswdlWait
			;MsgBox(0,"Putty",$i)
			sleep(300)
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Last login:","Last login:") > 0 Then ExitLoop
		Next
		 $AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $SwdlPID
		_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $SwdlPID & "','" & _Now() & "')")
 	EndIf
	GUICtrlSetState($progressbar1, $GUI_HIDE)
	GUICtrlSetState($progressLabel, $GUI_HIDE)
	$AllPuTTYPIDS = $AllPuTTYPIDS & "|" & $SwdlPID
EndFunc


Func HomeGateWay()
	$pass2Label = GUICtrlCreateLabel("Ip address HomeGateway", $xtop, $ytop+200, 120)
	$HomeGW_ID = GUICtrlCreateInput($HomeGW, $xtop,$ytop+15, 120, 20)
	GUICtrlSetState($HomeGW_ID,$GUI_FOCUS)
EndFunc


Func CheckADSLRoute()
Local $checkRoute = Run(@ComSpec & " /c netstat -rnv | findstr " & $ADSLWANIP & " | findstr " & $HomeGW, @SystemDir, @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
Local $line
Local $YesorNo = "FALSE"

While 1
	$line = StdoutRead($checkRoute)
	If @error Then ExitLoop
	;MsgBox(0, "STDOUT read:", $line)
	If $line Then
		;MsgBox(0, "STDOUT read:", $line)
		$YesorNo = "TRUE"
		Return $YesorNo
	EndIf
WEnd

While 1
	$line = StderrRead($checkRoute)
	If @error Then ExitLoop
	;MsgBox(0, "STDERR read:", $line)
WEnd


EndFunc

Func SSHviaInternet()
;Local $RetryAnswer

	;If (CheckSessionExsists("InternetGW_") = "1" Or $RetryAnswer = "3") Then Return 0
	If (CheckSessionExsists("InternetGW_") = "1") Then Return 0

	If Not $VPC_pass Then
		$VPC_pass = InputBox("Missing passphrase!","Please provide VPNHostPC passphrase:","","*M",220,120)
		sleep(200)
		GUICtrlSetData($VPC_passID,$VPC_pass)
	EndIf
	SetInfoText("Creating SSH connection to VPNHostPC !")
	;If ($UseHomeGW = "1") AND $HomeGW Then $RouteViaGatewayPID = run("route add " & $ADSLWANIP & " "  & $HomeGW,"",@SW_HIDE)
    ;$OSVersion = "WIN_2008"
	;MsgBox(0,"OS",$OSVersion)
	; Note: ipsecc.exe to check if a ShrewVPN connection is made.
	; Not completely OK, because if screen is open, but no login is made, the outcome is false....
	; Better to check if realy a VPN connection is up. To be done ;-)
	If ($HomeGW And $ProxyType = "None" And (ProcessExists("trayicon.exe") Or ProcessExists("ipsecc.exe"))) Then
		;MsgBox(0,"OS version",$OSVersion)
		;If ($OSVersion = "WIN_VISTA" Or $OSVersion = "WIN_7" Or $OSVersion = "WIN_2008R2" Or $OSVersion = "WIN_8" Or $OSVersion = "WIN_2008") And ( ProcessExists("trayicon.exe") Or ProcessExists("ipsecc.exe") ) Then
		If (not StringRegExp(@OSVersion, "_(XP|200(0|3))") and Not IsAdmin())  Then
			If CheckADSLRoute() = "TRUE" Then
			;If ProcessExists("trayicon.exe") Or ProcessExists("ipseca.exe") Then
				MsgBox(48,"Manualy add route to ADSL-Gateway.","Please open a DOS prompt with 'run as Administrator' " & @CRLF & "and add the route to the ADSL gateway." & @CRLF & "Click 'OK' and copy the command from next to be opened window.")
				ClipPut("route add " & $ADSLWANIP & " "  & $HomeGW)
				InputBox("Please add manualy route to ADSL-Gateway","BEFORE proceeding by clicking 'OK'," & @CRLF & "please open DOS prompt as Administrator and type/paste:","route add " & $ADSLWANIP & " "  & $HomeGW)
			EndIf
		Else

			RunWait("route delete " & $ADSLWANIP,"",@SW_HIDE)
			$RouteViaGatewayPID = run("route add " & $ADSLWANIP & " "  & $HomeGW,"",@SW_HIDE)
		;	$RouteViaGatewayPID = run("route add " & $ADSLWANIP & " "  & $HomeGW,"")
		EndIf

	EndIf
	;MsgBox(0,"OEPS",$OSVersion)

	If (not $HomeGW aND $ProxyType = "None") then
		MsgBox(48,"No Home Gateway set!","If connected via RAS, it is not possible to connect with PuTTY via the ALU-proxy. You have to bypass it, by routing the connection via your Home gateway instead of the ALU-RAS gateway. To bypass the ALU-proxy you have to give the IP address of your home gateway. Nevertheless it is possible that the RAS-VPN connection blocks your local network, so also your local gateway.")
		$HomeGW = InputBox("Missing Home Gateway","Please provide local gateway to bypass ALU-proxy:","","",290,120)
		sleep(200)
		SetInfoText("Preparing SSH connection to VPNHostPC !")
		GUICtrlSetData($HomeGW_ID,$HomeGW)
		IniWrite($INIDir & $INIFile, "Gateways IP", "HomeGW", $HomeGW)
		If $HomeGW Then
			RunWait("route delete " & $ADSLWANIP,"",@SW_HIDE)
			$RouteViaGatewayPID = run("route add " & $ADSLWANIP & " "  & $HomeGW,"",@SW_HIDE)
		EndIf
		;If $HomeGW Then IniWrite($INIDir & $INIFile, "Gateways IP", "HomeGW", $HomeGW)
	EndIf

	$TunnelVPCs = ""
	If $Customer_host = $VirtualPCsPC2 Then
		$NATport = $NATportPC2
		$VPC = "VirtualHostPC2"
		$TunnelVPCs = " -L 22154:10.0.0.104:22 -L 22155:10.0.0.105:22 -L 22156:10.0.0.106:22"
	ElseIf $Customer_host = $VirtualPCsPC1 Then
		$NATport = $NATportPC1
		$VPC = "VirtualHostPC1"
		$TunnelVPCs = " -L 22151:10.0.0.101:22 -L 22152:10.0.0.102:22 -L 22153:10.0.0.103:22"
	ElseIf $Customer_host = $VirtualPCsPC4 Then
		$NATport = $NATportPC4
		$VPC = "VirtualHostPC4"
		$TunnelVPCs = " -L 22160:10.0.0.110:22 -L 22161:10.0.0.111:22 -L 22162:10.0.0.112:22"
	ElseIf $Customer_host = $VirtualPCsPC5 Then
		$NATport = $NATportPC5
		$VPC = "VirtualHostPC5"
		$TunnelVPCs = " -L 22163:10.0.0.113:22 -L 22164:10.0.0.114:22 -L 22165:10.0.0.115:22"
	ElseIf $Customer_host = $VirtualPCsPC3 Then
		$NATport = $NATportPC3
		$VPC = "VirtualHostPC3"
		$TunnelVPCs = " -L 22157:10.0.0.107:22 -L 22158:10.0.0.108:22 -L 22159:10.0.0.109:22"
	ElseIf $Customer_host = $VirtualPCsPC6 Then
		$NATport = $NATportPC6
		$VPC = "VirtualHostPC6"
		$TunnelVPCs = " -L 22166:10.0.0.116:22 -L 22167:10.0.0.117:22 -L 22168:10.0.0.118:22"
	ElseIf $Customer_host = $VirtualPCsPC7 Then
		$NATport = $NATportPC7
		$VPC = "VirtualHostPC7"
		$TunnelVPCs = " -L 22169:10.0.0.119:22 -L 22170:10.0.0.120:22 -L 22171:10.0.0.121:22"

	Else
		;MsgBox(0,"SSHNATport en NATport en NATportDefault before",$SSHNATport & " - " & $NATport & " - " & $NATportDefault)
		;Use this port if not connecting to the VirtualPC's
		$NATport = $NATportDefault
	EndIf
	;MsgBox(0,"SSHNATport en NATport en NATportDefault before",$SSHNATport & " - " & $NATport & " - " & $NATportDefault)
	; $NATport does not reflect the configuration doen in the Settings menu. There $SSHNATport is leading.
	; So to use this configuration I set here the $NATport to $SSHNATport:
	If $ProxyType <> "None" Then $NATport = $SSHNATport ;Because ProxyType <> "None", $SSHNATport is already set to "443"
	If $SSHNATport <> "Auto" Then $NATport = $SSHNATport
	;MsgBox(0,"SSHNATport " & $SSHNATport & " NATport=" & $NATport,$SSHNATport & " " & $NATport)

	If $DEBUG Then
		Select
			Case StringInStr($DEBUG,"2") <> "0"
				;MsgBox(0,"SSHviaInternet",$PuTTYDIR & " -ssh " & $loadFile & " -P " & $NATport & " -i " & """" & $SSHprivKey_VPC & """" & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 -L 2207:10.0.0.107:22 -L 5900:" & $VPNHostPC1 & ":5900 " & $TunnelGGWin & " -L 5960:" & $VPNHostPC2 & ":5900 -L 3360:" & $VPNHostPC2 & ":3389 " & $SSHVPCUser & "@" & $ADSLWANIP)
				MsgBox(0,"SSHviaInternet","""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $NATport & " -i " & """" & $SSHprivKey_VPC & """" & $TunnelVPCs & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $TunnelGGWin & $SSHVPCUser & "@" & $ADSLWANIP)
			Case StringInStr($DEBUG,"1") <> "0"
				$VPCPID = Run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $NATport & " -i " & """" & $SSHprivKey_VPC & """" & $TunnelVPCs & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $TunnelGGWin & $SSHVPCUser & "@" & $ADSLWANIP,"")
		EndSelect

	Else
		$VPCPID = Run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $NATport & " -i " & """" & $SSHprivKey_VPC & """" & $TunnelVPCs & " -L " & $SSHlport2 & ":" & $ISDNGW & ":22 " & $TunnelGGWin & $SSHVPCUser & "@" & $ADSLWANIP,"",@SW_HIDE)
	EndIf
	DelInfoText()
	$LastSSHPID = $VPCPID
	If WinWait($ADSLWANIP & " - PuTTY","",$VPCWait) = 0 Then MsgBox(48,"SSH Connection problem","SSH connection is not started !")
	If Not WinActive("GOglobal TunnelGUI") Then WinActivate("GOglobal TunnelGUI")
	$xtop = 6
	;MsgBox(0,"Hoogte ", $ytop+55)
	DelInfoText()
	$progressLabel = GUICtrlCreateLabel("Progress SSH connection to VPNHostPC:", $leftProgressLabel, $topProgressLabel, 220)
	$progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
	$RetryAnswer = "0"

	Do
		$s = 0
		For $i = $s To $VPCWait
			CheckSecurityAlert()
			GUICtrlSetData($progressbar1, $i * ($x2width/$VPCWait))
			sleep(1000)
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase") > 0 Then ExitLoop
		Next
		;MsgBox(0,"Out loop", _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase") & "i=" & $i)
		If (Not FileExists($tmpPuTTYLOG) Or (FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase")) <= 0) AND $SSHProductName = "PuTTY Tray" Then $RetryAnswer = MsgBox(5,"SSH Connection not ready yet","Press 'Retry' to wait for connection." & @CRLF & "Press 'Cancel' to end this session to " & $Customer & ".")
		If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase") > 0 Then ExitLoop
		If $SSHProductName <> "PuTTY Tray" Then ExitLoop
	Until ($RetryAnswer = "2" Or ($SSHProductName <> "PuTTY Tray"))
	If $RetryAnswer = "2" Then
		ProcessClose($VPCPID)
	Else
    ;If $RetryAnswer = "3" Then ExitLoop

		If Not WinActive($ADSLWANIP & " - PuTTY") Then WinActivate($ADSLWANIP & " - PuTTY")
		sleep(500)
		Send($VPC_pass & "{ENTER}")
		sleep(500)
		If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
		If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Wrong passphrase","Wrong passphrase") > 0 Then
			MsgBox(16,"Wrong passphrase","You entered the wrong passphrase. " & @CRLF & "Enter the right passphrase in the 'Passphrase VPNHostPC' field," & @CRLF & "after you selected 'Load'." & @CRLF & "This session to " & $Customer & " will be canceled now.")
			$RetryAnswer = "2"
			ProcessClose($VPCPID)
			$VPCPID = ""
		EndIf
		$AllTunnelPIDS = $VPCPID & "|" & $AllTunnelPIDS
		$AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $VPCPID
		_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $VPCPID & "','" & _Now() & "')")
	EndIf
	GUICtrlSetState($progressbar1, $GUI_HIDE)
	GUICtrlSetState($progressLabel, $GUI_HIDE)
	$AllPuTTYPIDS = $AllPuTTYPIDS & "|" & $VPCPID
EndFunc


Func CheckSSHDameware($DameWarePC)
Local $NewopenSessions, $openSessions, $t, $ReadBox
	If FileExists($DameWarePC & ".txt") Then FileDelete($DameWarePC & ".txt")
	RunWait(@ComSpec & " /c " & 'netstat | findstr ' & $DameWarePC & ':22 | findstr ESTABLISHED > ' & $DameWarePC & '.txt',"",@SW_HIDE)
	;sleep(500)
	$openSessions = _ReplaceStringInFile($DameWarePC & ".txt","ESTABLISHED","ESTABLISHED")
	$NewopenSessions = $openSessions
	$t = 0
	$xtop = 6
	$progressLabel = GUICtrlCreateLabel("Progress SSH connection to DamewarePC:", $leftProgressLabel, $topProgressLabel, 220)
	$progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
	Do
		If StringInStr($DEBUG,"9") <> "0" Then
			Run(@ComSpec & " /c " & 'netstat | findstr ' & $DameWarePC & ':22 | findstr ESTABLISHED > ' & $DameWarePC & '.txt',"")
		Else
			Run(@ComSpec & " /c " & 'netstat | findstr ' & $DameWarePC & ':22 | findstr ESTABLISHED > ' & $DameWarePC & '.txt',"",@SW_HIDE)
		EndIf
		sleep(500)
		$t = $t + 1
		GUICtrlSetData($progressbar1, $t*($x2width/10))
		CheckSecurityAlert()
		$NewopenSessions = _ReplaceStringInFile($DameWarePC & ".txt","ESTABLISHED","ESTABLISHED")
	Until (($NewopenSessions = $openSessions + 1) Or $t = 40)
	GUICtrlSetState($progressbar1, $GUI_HIDE)
	GUICtrlSetState($progressLabel, $GUI_HIDE)
	If $NewopenSessions = $openSessions Then
		$ReadBox = MsgBox(6,"Warning","SSH connection not ready yet! ")
		If $ReadBox = 10 Then CheckSSHDameware($DameWarePC)
	EndIf
	FileDelete($DameWarePC & ".txt")
EndFunc


Func JumpToHost()
Local $EndHostAddressLabel,$EndHostUserLabel,$EndHostPasswdLabel
Local $OKbutton,$IPmsg, $GuiIP
	;MsgBox(0,"Jump","Jump")
	;$UseHostAsHop = "1"
	$GuiIP = GUICreate("HostInfo Endhost ",200,235)
	GUISetState(@SW_SHOW)
	GUICtrlCreateLabel("Reachable via " & $Hostname & ".", 14, 25, 170)
	GUICtrlCreateGroup("HostInfo Endhost:", 5, 10, 195, 185)
	$EndHostAddressLabel = GUICtrlCreateLabel("Host address:", 10, 50, 120)
	If $EndHostAddress Then
		$EndHostAddress_ID = GUICtrlCreateInput($EndHostAddress, 10,65, 150, 20)
	Else
		$EndHostAddress_ID = GUICtrlCreateInput("", 10,65, 150, 20)
	EndIf

	$EndHostUserLabel = GUICtrlCreateLabel("Username:", 10, 95, 120)
	If $EndHostUser Then
		$EndHostUser_ID = GUICtrlCreateInput($EndHostUser, 10,110, 150, 20)
	Else
		$EndHostUser_ID = GUICtrlCreateInput(GuiCtrlRead($User_ID), 10,110, 150, 20)
	EndIf

	$EndHostPasswdLabel = GUICtrlCreateLabel("Password:", 10,140 , 120)
	If $EndHostPasswd Then
		$EndHostPasswd_ID = GUICtrlCreateInput($EndHostPasswd, 10,155, 150, 20)
	Else
		;$EndHostPasswd_ID = GUICtrlCreateInput(GuiCtrlRead($Password_ID), 10,135, 150, 20)
		$EndHostPasswd_ID = GUICtrlCreateInput("", 10,155, 150, 20)
	EndIf

	$OKbutton = GUICtrlCreateButton("&OK", 65,200, 70, 20)
			;$UseIPAnswer = MsgBox(0,"IP and IPread", $IP & " " & $IPread)
			;GUISetState()
			While 1
				$IPmsg = GUIGetMsg()
				;If ($DBmsg = $GUI_EVENT_CLOSE Or $DBmsg = $Cancelbutton) Then ExitLoop
				If $IPmsg = $OKbutton Then
					$EndHostAddress = GuiCtrlRead($EndHostAddress_ID)
					$EndHostUser = GuiCtrlRead($EndHostUser_ID)
					$EndHostPasswd = GuiCtrlRead($EndHostPasswd_ID)
					;If $RadioEndIP And BitAND(GUICtrlRead($RadioEndIP), $GUI_CHECKED) = $GUI_CHECKED Then $UseHostAsHop = "1"
					;If $RadioNewIP And BitAND(GUICtrlRead($RadioNewIP), $GUI_CHECKED) = $GUI_CHECKED Then $IP = $IPread
					ExitLoop
				EndIf
			WEnd


	GUIDelete($GuiIP)

EndFunc

Func TunnelViaNMS($Application,$SSHport,$LocalPort,$EndHost, $version, $user, $passwd)
	Local $AppPrt
	;If (CheckSessionExsists("TunnelviaNMS_") = "1" Or $RetryAnswer = "3") Then Return 0
	If (CheckSessionExsists("TunnelviaNMS_") = "1") Then Return 0

	;MsgBox(0,"TunnelviaNMS",$SSHport & " " & $EndHost & " " & $user & " " & $passwd)
	;MsgBox(0,"Tunnel via NMS","""" & $PuTTYDIR & """" & " -P " & $SSHport & " " & $loadFile & " " & " -L 49490:" & $EndHost & ":491" & " -pw " & $passwd & " " & $user & "@127.0.0.1")
		Select
		Case $Application = "GG"
			$AppPrt = "491"
			$NewLocalPort = $LocalPort
		Case $Application = "SSH"
			$AppPrt = "22"
			$NewLocalPort = $LocalPort - 49000 + 22000
		Case ($Application = "Telnet" )
			$AppPrt = "23"
			$NewLocalPort = $LocalPort - 49000 + 23000
		Case ($Application = "TelnetConsole" )
			$AppPrt = "23"
			$NewLocalPort = $LocalPort - 49000 + 23023
		Case ($Application = "LanConsole")
			$AppPrt = "23"
			$NewLocalPort = $LocalPort - 49000 + 23025
		Case ($Application = "WebConsole")
			$AppPrt = "80"
			$NewLocalPort = $LocalPort - 49000 + 8080
		Case $Application = "SCP"
			$AppPrt = "22"
			$NewLocalPort = $LocalPort - 49000 + 22000
		Case $Application = "ftp"
			$AppPrt = "21"
			$NewLocalPort = $LocalPort - 49000 + 21000
		Case $Application = "WEB"
			$AppPrt = "80"
			$NewLocalPort = $LocalPort - 49000 + 8000
		Case ($Application = "VNC" )
			$AppPrt = "5900"
			$NewLocalPort = $LocalPort - 49000 + 59000
		Case ($Application = "RDP" )
			$AppPrt = "3389"
			$NewLocalPort = $LocalPort - 49000 + 33890
	EndSelect
	;MsgBox(0,"NewLocalPort-100", $NewLocalPort-100)
	If $DEBUG Then
		;If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Tunnel via NMS",$PuTTYDIR & """" & " -P " & $SSHport & " " & $loadFile & " " & " -L 49490:" & $EndHost & ":491" & " -pw " & $user & ":" & $passwd & " 127.0.0.1")
		If StringInStr($DEBUG,"1") <> "0" Then $DameWarePID = run("""" & $PuTTYDIR & """" & " -ssh " & " -P " & $SSHport & " " & $loadFile & " " & " -L " & $NewLocalPort-100 & ":" & $EndHost & ":" & $AppPrt & " -pw " & $passwd & " " & $user & "@127.0.0.1","")
	Else
		$DameWarePID = run("""" & $PuTTYDIR & """" & " -ssh " & " -P " & $SSHport & " " & $loadFile & " " & " -L " & $NewLocalPort-100 & ":" & $EndHost & ":" & $AppPrt & " -pw " & $passwd & " " & $user & "@127.0.0.1","",@SW_HIDE)
	EndIf
	If $SSHProductName = "PuTTY Tray" Then
		$s=0
		For $i = $s to 8
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And  _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
			sleep($DamewareWait*200)
			CheckSecurityAlert()
		Next
	Else
		sleep($DamewareWait*1000)
		CheckSecurityAlert()
	EndIf
	$LastSSHPID = $DameWarePID
	$SessionPIDS = $DameWarePID & "|" & $SessionPIDS
	$AllTunnelPIDS = $DameWarePID & "|" & $AllTunnelPIDS
	$AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $DameWarePID
	_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $DamewarePID & "','" & _Now() & "')")
EndFunc


Func SSHviaDameWare($Tunnelstring,$Customer)
	;If (CheckSessionExsists("Dameware_" & $DameWarePC & "_") = "1" Or $RetryAnswer = "3") Then Return 0
	If (CheckSessionExsists("Dameware_" & $DameWarePC & "_") = "1") Then Return 0

	If $DEBUG Then
		If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Dameware",$PuTTYDIR & " -ssh " & $loadFile & " " & $Tunnelstring & " -pw alcatel@10 tcp@" & $DameWarePC)
		If StringInStr($DEBUG,"1") <> "0" Then $DameWarePID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " " & $Tunnelstring & " -pw alcatel@10 tcp@" & $DameWarePC,"")
	Else
		$DameWarePID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " " & $Tunnelstring & " -pw alcatel@10 tcp@" & $DameWarePC,"",@SW_HIDE)
	EndIf
	If $SSHProductName = "PuTTY Tray" Then
		$s=0
		For $i = $s to 8
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And  _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
			sleep($DamewareWait*200)
			CheckSecurityAlert()
		Next
	Else
		sleep($DamewareWait*1000)
	EndIf
	$LastSSHPID = $DameWarePID
	$SessionPIDS = $DameWarePID & "|" & $SessionPIDS
	$AllTunnelPIDS = $DameWarePID & "|" & $AllTunnelPIDS
	$AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $DameWarePID
	_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $DamewarePID & "','" & _Now() & "')")
EndFunc



Func ShowDialinStatus()
Dim  $line4, $line5, $line6, $line7, $t
Local $CheckFilesText, $file, $line, $CheckDamewareLabel, $RASDIAL4_PID, $RASDIAL5_PID, $RASDIAL6_PID, $RASDIAL7_PID, $RASDIAL9_PID, $ComCompl

	SetInfoText("Checking Dameware dialin connections !")
	If ($ConnectVia <> "Internet" And $ConnectVia <> "TTACVLAN" And $ConnectVia <> "") Then
		If FileExists($TEMPDIR & "ras5.txt") Then FileDelete($TEMPDIR & "ras5.txt")
		If FileExists($TEMPDIR & "ras6.txt") Then FileDelete($TEMPDIR & "ras6.txt")


		If $DEBUG Then
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"psexec", @ComSpec & ' /c ' & """" & $PSEXECDir & "psexec.exe" & """" & " -n 20 -u tcp -p alcatel@10 \\172.31.208.4 /accepteula rasdial " & '> ' & $TEMPDIR & 'ras4.txt')
		EndIf
		$RASDIAL5_PID = Run(@ComSpec & ' /c ' & """" & $PSEXECDir & "psexec.exe" & """" & " -n " & $RASDIAL_TIMEOUT & " -u tcp -p alcatel@10 \\172.31.208.5 /accepteula rasdial " & '> ' & $TEMPDIR & 'ras5.txt',"",@SW_HIDE)
		$RASDIAL6_PID = Run(@ComSpec & ' /c ' & """" & $PSEXECDir & "psexec.exe" & """" & " -n " & $RASDIAL_TIMEOUT & " -u tcp -p alcatel@10 \\172.31.208.6 /accepteula rasdial " & '> ' & $TEMPDIR & 'ras6.txt',"",@SW_HIDE)
		$ytop=$SSHytop
		$xtop =6
		$progressbar1 = GUICtrlCreateProgress($x2+10,$ybottom-24, $x2width-10, 20,$PBS_SMOOTH)
		for $t = 1 to $RASDIAL_TIMEOUT/2
			If ((FileExists($TEMPDIR & "ras5.txt") AND FileExists($TEMPDIR & "ras6.txt")) AND (FileGetSize($TEMPDIR & "ras5.txt") > 0 AND FileGetSize($TEMPDIR & "ras6.txt") > 0 )) Then ExitLoop
			GUICtrlSetData($progressbar1, $t*(($x2width-10)/($RASDIAL_TIMEOUT/2)))
			sleep(2200)
		Next
		sleep(1000)
		GUICtrlSetState($progressbar1, $GUI_HIDE)
		GUICtrlSetState($progressLabel, $GUI_HIDE)

		$line5 = @LF & "Dialin connection on 172.31.208.5: "
		If (FileExists($TEMPDIR & "ras5.txt") AND FileGetSize($TEMPDIR & "ras5.txt") > 0) Then
			$file = FileOpen($TEMPDIR & "ras5.txt", 0)
			While 1
				$line = FileReadLine($file)
				If ($line And StringInStr($line,"Command completed") = 0) Then $line5 = $line5 & @LF & $line
				If @error = -1 Then ExitLoop
			Wend
			FileClose($file)
		Else
			$line5 = $line5 & @LF & "Problem with connection to PC!"
		EndIf

		$line6 = @LF & "Dialin connection on 172.31.208.6: "
		If (FileExists($TEMPDIR & "ras6.txt") AND FileGetSize($TEMPDIR & "ras6.txt") > 0) Then
			$file = FileOpen($TEMPDIR & "ras6.txt", 0)
			While 1
				$line = FileReadLine($file)
				If ($line And StringInStr($line,"Command completed") = 0) Then $line6 = $line6 & @LF & $line
				If @error = -1 Then ExitLoop
			Wend
			FileClose($file)
		Else
			$line6 = $line6 & @LF & "Problem with connection to PC!"
		EndIf

		MsgBox(0,"Dialin status Antwerp PC's", $line5 & @CRLF & $line6)
		If FileExists($TEMPDIR & "ras5.txt") Then FileDelete($TEMPDIR & "ras5.txt")
		If FileExists($TEMPDIR & "ras6.txt") Then FileDelete($TEMPDIR & "ras6.txt")
	Else
		MsgBox(48,"Check not possible","You did not choose how to connect or " & @CRLF & "you are not connecting via the Alcanet.")
	EndIf
	DelInfoText()
EndFunc


Func DialCustomer($Customer)
Local $dialuser, $dialpasswd, $dialname, $dialRow, $dialQuery, $rasdialtext, $DecryptPasswd, $CommandSend
	If Not WinActive($DameWarePC & " - PuTTY") Then WinActivate($DameWarePC & " - PuTTY")
	sleep(1000)
	_SQLite_Query($GGDB,"SELECT name, username, password from dialin where name = (select name from tree where (parentid = (select id from tree where name = '" & $Customer & "' )) AND typ = 'dialin')",$dialQuery)
	While _SQLite_FetchData ($dialQuery, $dialRow) = $SQLITE_OK ;
		$dialuser = $dialRow[1]
		$dialpasswd = $dialRow[2]
		$dialname = $dialRow[0]
		$DecryptPasswd = _StringEncrypt(0, $dialpasswd, $EncryptPassword)
	WEnd
	$DecryptPasswd = _StringEncrypt(0, $dialpasswd, $EncryptPassword)
	send("rasdial " & $dialname & " " & $dialuser & " " & $Decryptpasswd & "{ENTER}")
	MsgBox(64,"Please Wait","Waiting for dialup connection")
	sleep(10000)
	$rasdialtext = WinGetText($DameWarePC & " - PuTTY", "")
	$CommandSend = ""
	Select
		Case $dialname = "Scarlet"
			$CommandSend = "route add 172.21.2.0 mask 255.255.255.0 192.168.100.1 "
		Case $dialname = "Elia"
			$CommandSend ="route add 172.31.123.0 mask 255.255.255.0 10.120.0.20 {ENTER}"
			$CommandSend = $CommandSend & "route add 172.31.123.0 mask 255.255.255.0 10.120.0.21 {ENTER}"
			$CommandSend = $CommandSend & "route add 172.31.123.0 mask 255.255.255.0 10.120.0.22 "
		Case $dialname = "bics"
			$CommandSend = "route add 10.245.22.0 mask 255.255.255.0 45.102.3.213 {ENTER}"
			$CommandSend = $CommandSend & "route add 10.245.20.0 mask 255.255.255.0 45.102.3.213 "
		Case $dialname = "Lithuania telecom"
			$CommandSend = "route add 172.31.4.0 mask 255.255.255.0 192.168.101.206 "
		Case $dialname = "MET"
			$CommandSend = "route add 10.164.122.0 mask 255.255.255.0 172.18.1.10 "
		Case $dialname = "Televorgu Estonia"
			$CommandSend = "route add 192.168.224.0 mask 255.255.255.0 10.120.0.10 "
	EndSelect
	If Not WinActive($DameWarePC & " - PuTTY") Then WinActivate($DameWarePC & " - PuTTY")
	send($CommandSend & "{ENTER}")

EndFunc


Func PingProgressDummy($CustomerDummy)
	$xtop = 6
 	GUICtrlSetState($progressbar1, $GUI_HIDE)
	GUICtrlSetState($progressLabel, $GUI_HIDE)
	$progressLabel = GUICtrlCreateLabel("Pinging dummy IP address " & $CustomerDummy & ":", $xtop, $ytop+60, 200)
	$progressbar1 = GUICtrlCreateProgress($x2,$ytop+55, $x2width, 20,$PBS_SMOOTH)
	If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
	$s = 0
	For $i = $s To 100
		GUICtrlSetData($progressbar1, $i*($x2width/100))
		sleep(80)
	Next
	If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
    GUICtrlSetState($progressbar1, $GUI_HIDE)
    GUICtrlSetState($progressLabel, $GUI_HIDE)
EndFunc


Func PingDummy($Customer)
	If Not WinActive("127.0.0.1 - PuTTY") Then WinActivate("127.0.0.1 - PuTTY")
	Select
	case $Customer = "BICS"
		Send("ping dummy.bics.dmz -w 8{ENTER}")
		PingProgressDummy($Customer)
	case $Customer = "P_T"
        Send("ping dummy.pt.dmz -w 8{ENTER}")
		PingProgressDummy($Customer)
    case $Customer = "Elia"
        Send("ping dummy.elia.dmz -w 8{ENTER}")
		PingProgressDummy($Customer)
	EndSelect
EndFunc


Func SSHtunnelCust($port,$Tunnelstring,$Customer,$SSHhost)
;Local $SSHkeyparameter, $SSHUserISDNGW, $aRecords, $RetryAnswer
Local $SSHkeyparameter, $SSHUserISDNGW, $aRecords
    ;MsgBox(0,"Entering SSHtunnelCust",$RetryAnswer & " " & $SSHhost)
;	If (CheckSessionExsists("nlsdh1_") = "1" Or $RetryAnswer = "3") Then Return 0
	If (CheckSessionExsists("nlsdh1_") = "1") Then Return 0
	If $RetryAnswer = "2" Then Return 0
	$xtop = 6
	;CreatePuTTYSession("nlsdh1_")
	Select
		Case ($ConnectVia = "sdhswdl" or $ConnectVia = "Internet" or $ConnectVia = "TTACVLAN")
			If Not $nlsdh1_pass Then
				$nlsdh1_pass = InputBox("Missing passphrase!","Please provide nlsdh1 passphrase:","","*M",220,120)
				sleep(200)
				GUICtrlSetData($nlsdh1_passID,$nlsdh1_pass)
			EndIf
			GUICtrlSetState($progressbar1, $GUI_HIDE)
			GUICtrlSetState($progressLabel, $GUI_HIDE)
			$progressLabel = GUICtrlCreateLabel("Progress SSH connection to nlsdh1:", $leftProgressLabel, $topProgressLabel, 220)
			$progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
			$SSHkeyparameter = " -i " & """" & $SSHprivKey_nlsdh1 & """"
			$SSHUserISDNGW = $SSHnlsdh1User
			If $ISDNGW = $nautilus Then
				$SSHkeyparameter = " -pw wijkrijs"
				$SSHUserISDNGW = "rijswijk"
			EndIf

			If $DEBUG Then
				If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Session file and PuTTYLOG and PUTTYDIR and WorkingDIR", $PUTTYDR & "sessions\" & $PuTTYSession & @CRLF & $PuTTYLOG & @CRLF & $PUTTYDIR & @CRLF & $GGtunnelDir & " " )
				If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Tunnelstring in SSHtunnelCust",$Tunnelstring)
				If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"SSHTunnelCust via sdhswdl or VPC",$PuTTYDIR & $loadFile & " -P " & $port & $SSHkeyparameter & " " & $Tunnelstring & " " & $SSHUserISDNGW & "@" & $SSHhost)
				If StringInStr($DEBUG,"1") <> "0" Then $TunnelPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $port & $SSHkeyparameter & " " & $Tunnelstring & " " & $SSHUserISDNGW & "@" & $SSHhost,"")
			Else
				$TunnelPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $port & $SSHkeyparameter & " " & $Tunnelstring & " " & $SSHUserISDNGW & "@" & $SSHhost,"",@SW_HIDE)
			EndIf
			$LastSSHPID = $TunnelPID
			$AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $TunnelPID
			_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $TunnelPID & "','" & _Now() & "')")
			WinWait($SSHhost & " - PuTTY")
			If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)

			$RetryAnswer = "0"

			Do
				$s = 0
				For $i = $s To $Nlsdh1Wait
					CheckSecurityAlert()
					GUICtrlSetData($progressbar1, $i * ($x2width/$Nlsdh1Wait))
					sleep(1000)
					If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
					If FileExists($tmpPuTTYLOG) And $ISDNGW = $nautilus And  _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
					If FileExists($tmpPuTTYLOG) And $ISDNGW = $nlsdh1 And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase") > 0 Then ExitLoop
				Next
				If (Not FileExists($tmpPuTTYLOG) Or (FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase"))  <= 0 ) And $ISDNGW = $nlsdh1 Then $RetryAnswer = MsgBox(5,"SSH Connection not ready yet","Press 'Retry' to wait for connection." & @CRLF & "Press 'Cancel' to end this session to " & $Customer & ".")
				If (Not FileExists($tmpPuTTYLOG) Or (FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login"))  <= 0 ) And $ISDNGW = $nautilus Then $RetryAnswer = MsgBox(5,"SSH Connection not ready yet","Press 'Retry' to wait for connection." & @CRLF & "Press 'Cancel' to end this session to " & $Customer & ".")
				If FileExists($tmpPuTTYLOG) And $ISDNGW = $nlsdh1 And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase") > 0 Then ExitLoop
				If FileExists($tmpPuTTYLOG) And $ISDNGW = $nautilus And _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
				If $SSHProductName <> "PuTTY Tray" Then ExitLoop
			Until ($RetryAnswer = "2")
			GUICtrlSetState($progressbar1, $GUI_HIDE)
			GUICtrlSetState($progressLabel, $GUI_HIDE)
			If $RetryAnswer = "2" Then
				ProcessClose($TunnelPID)
			Else
				If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
				;GUICtrlSetState($progressbar1, $GUI_HIDE)
				;GUICtrlSetState($progressLabel, $GUI_HIDE)
				If Not WinActive($SSHhost & " - PuTTY") Then WinActivate($SSHhost & " - PuTTY")
				Send($nlsdh1_pass & "{ENTER}")
				sleep(300)
				If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
				If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Wrong passphrase","Wrong passphrase") > 0 Then
					MsgBox(16,"Wrong passphrase","You entered the wrong passphrase. " & @CRLF & "Enter the right passphrase in the 'Passphrase nlsdh1' field," & @CRLF & "after you selected 'Load'." & @CRLF & "This session to " & $Customer & " will be canceled now.")
					$RetryAnswer = "2"
					ProcessClose($TunnelPID)
				EndIf
				$s = 0
				For $i = $s To 3
					If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
					If FileExists($tmpPuTTYLOG) And $ISDNGW = $nautilus And  _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
					If FileExists($tmpPuTTYLOG) And $ISDNGW = $nlsdh1 And _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
					sleep(1000)
				Next
				PingDummy($Customer)
			EndIf
		Case $ConnectVia = "slsvho"
			;$SSHkeyparameter = " -pw install10"
			;$SSHUserISDNGW = "root"
			If Not $RmthtlUser Then
				$SSHUserISDNGW = "ggtn"
			Else
				$SSHUserISDNGW = $RmthtlUser
			EndIf
			If Not $RmthtlPass Then
				$SSHkeyparameter = " -pw ggtn"
			Else
				$SSHkeyparameter = " -pw " & $RmthtlPass
			EndIf
			;$SSHkeyparameter = " -pw ggtn"

		;$SSHUserISDNGW = "ggtn"
			If $DEBUG Then
				If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Tunnel via slsvho",$PuTTYDIR & $loadFile & " -P " & $port & $SSHkeyparameter & " " & $Tunnelstring & " " & $SSHUserISDNGW & "@" & $SSHhost)
				If StringInStr($DEBUG,"1") <> "0" Then $TunnelPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $port & $SSHkeyparameter & " " & $Tunnelstring & " " & $SSHUserISDNGW & "@" & $SSHhost,"")
			Else
				$TunnelPID = run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $port & $SSHkeyparameter & " " & $Tunnelstring & " " & $SSHUserISDNGW & "@" & $SSHhost,"",@SW_HIDE)
			EndIf
			$LastSSHPID = $TunnelPID
			WinWait($SSHhost & " - PuTTY")
			If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
			$s = 0
			For $i = $s To 2
				CheckSecurityAlert()
				If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
				If FileExists($tmpPuTTYLOG) And  _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
				sleep(1000)
			Next
			CheckSecurityAlert()
	EndSelect
	$AllTunnelPIDS = $TunnelPID & "|" & $AllTunnelPIDS
	$SessionPIDS = $TunnelPID & "|" & $SessionPIDS
EndFunc


Func OpenVPNHostPC($localPort,$VPCGW,$Tunnelstring,$Customer)
Local $TunnelPW, $TunnelUser, $ReadyForPassphrase
;Local $TunnelPW, $TunnelUser, $RetryAnswer, $ReadyForPassphrase
;	If (CheckSessionExsists("VPNPC_" & $ConnectVia & "_") = "1" Or $RetryAnswer = "3") Then Return 0
	If (CheckSessionExsists("VPNPC_" & $ConnectVia & "_") = "1") Then Return 0

	$TunnelPW = ""
	$TunnelUser = $SSHVPCUser
	$TunnelPW = " -i " &  """" & $SSHprivKey_VPC & """"

	If FileExists($PuTTYLOG) Then FileDelete($PuTTYLOG)
	$SSHProductName = FileGetVersion ( $PuTTYDIR ,"ProductName" )
	;$loadFile = ""

	If Not $VPC_pass Then
		$VPC_pass = InputBox("Missing passphrase!","Please provide VPNHostPC passphrase:","","*M",220,120)
		sleep(200)
		GUICtrlSetData($VPC_passID,$VPC_pass)
	EndIf

	If $DEBUG Then
		If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Command SSHviaVPC2Gateway","""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $localPort & " " & $Tunnelstring & " -L 3360:127.0.0.1:3389 " & $TunnelUser & "@" & $VPCGW & $TunnelPW)
		If StringInStr($DEBUG,"1") <> "0" Then $VPCGWPID = Run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $localPort & " " & $Tunnelstring & " -L 3360:127.0.0.1:3389 " & $TunnelUser & "@" & $VPCGW & $TunnelPW,"")
	Else
		$VPCGWPID = Run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $localPort & " " & $Tunnelstring & " -L 3360:127.0.0.1:3389 " & $TunnelUser & "@" & $VPCGW & $TunnelPW,"",@SW_HIDE)
	EndIf
	$LastSSHPID = $VPCGWPID

	$AllTunnelPIDS = $VPCGWPID & "|" & $AllTunnelPIDS
	WinWait($VPCGW & " - PuTTY")
	If Not WinActive($GuiTitle) Then WinActivate($GuiTitle)
	$xtop = 6
	$progressLabel = GUICtrlCreateLabel("Progress SSH connection to VPNHostPC:", $leftProgressLabel, $topProgressLabel, 220)
	$progressbar1 = GUICtrlCreateProgress($leftProgressBar,$topProgressBar, $x2width, 20,$PBS_SMOOTH)
	$RetryAnswer = "0"

	Do
		$s = 0
		For $i = $s To $VPCWait
			CheckSecurityAlert()
			GUICtrlSetData($progressbar1, $i * ($x2width/$VPCWait))
			sleep(1000)
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase") > 0 Then ExitLoop
		Next
		If Not FileExists($tmpPuTTYLOG) Or (FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase")) <= 0 Then $RetryAnswer = MsgBox(5,"SSH Connection","SSH connection is not ready yet." & @CRLF & "Wait for connection setup ?")
		If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Passphrase","Passphrase") > 0 Then ExitLoop
		If $SSHProductName <> "PuTTY Tray" Then ExitLoop
	Until ($RetryAnswer = "2")
	If $RetryAnswer = "2" Then
		ProcessClose($VPCGWPID)
		$VPCGWPID = ""
	Else
		If Not WinActive($VPCGW & " - PuTTY") Then WinActivate($VPCGW & " - PuTTY")
		sleep(500)
		Send($VPC_pass & "{ENTER}")
		$AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $VPCGWPID
		_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $VPCGWPID & "','" & _Now() & "')")
	EndIf
	GUICtrlSetState($progressbar1, $GUI_HIDE)
	GUICtrlSetState($progressLabel, $GUI_HIDE)
	$AllPuTTYPIDS = $AllPuTTYPIDS & "|" & $VPCGWPID
EndFunc


Func SSHviaEssentGateway($localPort,$EssentGW,$Tunnelstring,$Customer)
Local $TunnelPW, $TunnelUser
;	If (CheckSessionExsists("CustomerGW_") = "1" Or $RetryAnswer = "3") Then Return 0
	If (CheckSessionExsists("CustomerGW_") = "1") Then Return 0

    $TunnelPW = ""
	Select
		Case $Customer = "Ziggo_Essent"
			$TunnelPW = " -pw alca321"
			$TunnelUser = "alcatel"
			$loadFile = ""
		Case $Customer_host = $VirtualPCsPC2
			$TunnelUser = $SSHVPCUser
			$TunnelPW = " -i " & $VPC_pass
		Case Else
			$TunnelPW = " -pw wijkrijs"
			$TunnelUser = "rijswijk"
	EndSelect
	If $DEBUG Then
		If StringInStr($DEBUG,"2") <> "0" Then MsgBox(0,"Command SSHviaEssentGateway","""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $localPort & " " & $Tunnelstring & " " & $TunnelUser & "@" & $EssentGW & $TunnelPW)
		If StringInStr($DEBUG,"1") <> "0" Then $EssentGWPID = Run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $localPort & " " & $Tunnelstring & " " & $TunnelUser & "@" & $EssentGW & $TunnelPW,"")
	Else
		$EssentGWPID = Run("""" & $PuTTYDIR & """" & " -ssh " & $loadFile & " -P " & $localPort & " " & $Tunnelstring & " " & $TunnelUser & "@" & $EssentGW & $TunnelPW,"",@SW_HIDE)
	EndIf
	$LastSSHPID = $EssentGWPID
	sleep(2000)
	$s = 0
	If $loadfile Then
		For $i = $s To 4
			CheckSecurityAlert()
			If FileExists($PuTTYLOG) Then FileCopy($PuTTYLOG,$tmpPuTTYLOG,1)
			If FileExists($tmpPuTTYLOG) And _ReplaceStringInFile($tmpPuTTYLOG,"Last login","Last login") > 0 Then ExitLoop
			sleep(500)
		Next
	Else
		sleep($EssentGWWait*500)
	EndIf
	CheckSecurityAlert()
	$AllTunnelPIDS = $EssentGWPID & "|" & $AllTunnelPIDS
	$AllSessionsandPIDs = $AllSessionsandPIDs & "|" & $PuTTYSession & "_" & $EssentGWPID
	_SQLite_Exec($DBmem,"insert into PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $PuTTYSession & "','" & $Customer & "','" & $Customer_host & "','" & $IP & "','" & $ConnectVia & "','" & $EssentGWPID & "','" & _Now() & "')")
	$SessionPIDS = $EssentGWPID & "|" & $SessionPIDS
	;sleep($EssentGWWait*500)
	CheckSecurityAlert()
EndFunc


Func CheckForPing($Customer, $host, $localPort, $version, $user, $password)
	If $ConnectVia = "TTACVLAN" Then
		Select
			case $Customer = "BICS"
				If $pingBICSPID = "0" Then
					$pingBICSPID = Run("ping dummy.bics.dmz -w 8","",@SW_HIDE )
					PingProgressDummy($Customer)
					ProcessClose($pingBICSPID)
				EndIf
			Case $Customer = "P_T"
				If $pingPTPID = "0" Then
					$pingPTPID = Run("ping dummy.pt.dmz -w 8","",@SW_HIDE)
					PingProgressDummy($Customer)
					ProcessClose($pingPTPID)
				EndIf
			case $Customer = "Elia"
				If $pingEliaPID = "0" Then
					$pingEliaPID = Run("ping dummy.elia.dmz -w 8","",@SW_HIDE)
					PingProgressDummy($Customer)
					ProcessClose($pingEliaPID)
				EndIf
		EndSelect
	EndIf
EndFunc


Func RunGOGlobal($Customer, $host, $localPort, $version, $user, $password)
	$user = $GGUser
	if $user = "" Then $user = "alcatel"
	If $UseHostAsHop = "4" Then $password = $GGPassword
	Select
		case ($version = "ux225" OR $version = "ux226")
			$GGDIR = $GGDIR225
			$GGDIR_PID = run("""" & $GGDIR & """" & " host=" & $host & " port=" & $localPort & " username=" & $user & " transport=tcp  launch=" & " password=" & $password,"")
		case $version = "ux214"
			$GGDIR = $GGDIR214
			$GGDIR_PID = Run("""" & $GGDIR & """" & " host=" & $host & " port=" & $localPort & " username=" & $user & " transport=libtcpip.btu  launch=1" & " password=" & $password,"")
		case $version = "ux"
			$GGDIR = $GGDIR214
			$GGDIR_PID = run("""" & $GGDIR & """" & " host=" & $host & " port=" & $localPort & " username=" & $user & " transport=libtcpip.btu  launch=1" & " password=" & $password,"")
		case $version = "bridges"
			$GGDIR = $GGDIR1
			$GGDIR_PID = run("""" & $GGDIR & """" & " -h " & $host & ":" & $localPort & " -u " & $user & " -pe " & $password,"")
		case $version = "goglobal"
			$GGDIR = $GGDIR365
			$GGDIR_PID = run("""" & $GGDIR & """" & " -h " & $host & ":" & $localPort & " -u " & $user & " -pe " & $password,"")
		case $version = "win312"
			$GGDIR = $GGDIRWIN
			If $password <> "" Then $password = " -p " & $password
			;$GGDIR_PID = run("""" & $GGDIR & """" & " -h " & $host & " -hp " & $localPort & " -u " & $GGWINuser & $password,"")
			$GGDIR_PID = run("""" & $GGDIR & """" & " -h " & $host & " -hp " & $localPort & " -u " & $user & $password,"")
		case $version = "win4"
			$GGDIR = $GGDIRWIN4
			If $password <> "" Then $password = " -p " & $password
			;$GGDIR_PID = run("""" & $GGDIR & """" & " -h " & $host & " -hp " & $localPort & " -u " & $GGWINuser & $password,"")
			$GGDIR_PID = run("""" & $GGDIR & """" & " -h " & $host & " -hp " & $localPort & " -u " & $user & $password,"")
	EndSelect
	If Not WinActive("GO-Global UX") Then WinActivate("GO-Global UX")
	$AllGGDIRPIDS = $GGDIR_PID & "|" & $AllGGDIRPIDS
	$SessionPIDS = $GGDIR_PID & "|" & $SessionPIDS
EndFunc


Func RunRealVNC($host, $VNCport, $user, $password)
Local $VNCProductName, $VNCPID, $APPDataVNCDir, $vncfile, $vncClientFile, $UserName, $iPID, $sOutput
	$iPID = Run(@ComSpec & ' /C programs\vnc\vnc_enc\vnc_enc.exe ' & $password, $GGTunnelDir, @SW_HIDE, $STDOUT_CHILD)
	ProcessWaitClose($iPID)
	$sOutput = StringStripCR(StdoutRead($iPID))
	$APPUSERDIR = @AppDataDir ;Current User Application dir
	$APPDataVNCDir = $APPUSERDIR & "\GGTunnelGui\programs\vnc"
	If Not FileExists($APPDataVNCDir) Then DirCreate($APPDataVNCDir)
	$vncClientFile = $APPDataVNCDir & "\" & $host & "-" & $VNCport & ".vnc"
	$vncfile = FileOpen($vncClientFile,2)
	FileWriteLine($vncfile,"[Connection]")
	FileWriteLine($vncfile,"Host=" & $host & ":" & $VNCport)
	FileWriteLine($vncfile,"UserName=" & $user)
	FileWriteLine($vncfile,"Password=" & $sOutput)
	FileWriteLine($vncfile,"Encryption=Server")
	FileClose($vncfile)
	$VNCPID = run("""" & $VNCDIR & """" & " " & $vncClientFile, "")
EndFunc


Func StartApplication($Application, $Customer, $host, $localPort, $ServerPort, $version, $user, $password,$SSHHopport,$IPread,$UseHostAsHop)
Local $SSHport, $SSHPID, $NXPID, $TVPID, $WinSCPPID, $FTPPID, $Webport, $WebConsoleport, $WebPID, $Telnetport, $TelnetPID, $VNCPID, $RDPPID, $ConnHostID, $isConnected, $HostIP, $HostLabel
Local $SCPpassword, $SCPport, $SCPuser, $VPChost, $fhSessionsLogFile, $StartTime, $SSHFWPID
Local $AllFwStringArray, $Fw, $EachFwStringArray, $EachFw, $FWeach, $SSHsocket, $fhSessionFWogFile, $RDPUserPasswd, $VNCportSelected, $RDPportSelected

	;MsgBox(0,"Into Application", $host & " " & $Application & " " & $version  & " " & $IPread)
	;$version = $ApplicationVersion ; CHECK THIS
	If $RetryAnswer = "2" Then SetInfotext3("Session to " & $Customer & " is canceled!")
    If $RetryAnswer = "2" Then Return 0
	If $UseHostAsHop = "1" Then
		TunnelViaNMS($Application,$SSHHopport,$LocalPort,$EndHostAddress, $version, $user, $password)
		$localPort = $LocalPort-100
		$host = "127.0.0.1"

		$user = $EndHostUser
		$password = $EndHostPasswd
	EndIf
	CheckForPing($Customer, $host, $localPort, $version, $user, $password)
	$isConnected = ""
	If $LastSSHPID = "" Then
		$isConnected = "0"
	Else
		$isConnected = $LastSSHPID
	EndIf
	_SQLite_QuerySingleRow($DBmem,"SELECT host,ServerIP from hosts where Serverid = '" & $ServerPort & "'" ,$hQuery4)
	$HostLabel = $hQuery4[0]
	$HostIP = $hQuery4[1]
	$StartTime = _Now()
	If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Connected?",$Customer & " " & $IP & $HostLabel & $ConnectVia & " insert into connections (ServerId,PID) values ( '" & $ServerPort & "','" & $isConnected & "')")
	_SQLite_Exec($DBmem,"insert into connections (ServerId,Customer,host,IP,ConnectVia,PID,starttime) values ( '" & $ServerPort & "','" & $Customer & "','" & $HostLabel & "','" & $HostIP & "','" & $ConnectVia & "','" & $isConnected & "','" & $StartTime & "')")
	$fhSessionFWogFile = FileOpen($SessionFWportLogFile,1)
	;MsgBox(0,"##Host", $host)
;If ($host <> "localhost" And $AllowPortForwCheck = "1" And ($ConnectVia = "sdhswdl" Or $ConnectVia = "slsvho" Or $ConnectVia = "Internet") ) Then
If ($AllowPortForwCheck = "1" And ($ConnectVia = "sdhswdl" Or $ConnectVia = "slsvho" Or $ConnectVia = "Internet") ) Then
	;MsgBox(0,"##App ",$HostIP)
	$AllFwStringArray = StringSplit($Tunnelstring,"-L",1)
	$FWeach = ""
	For $Fw = 2 to $AllFwStringArray[0]
		$EachFwStringArray = StringSplit($AllFwStringArray[$Fw],":")
		$FWeach = $FWeach & "tcp " & $EachFwStringArray[1] & " " & $EachFwStringArray[2] & ":" & $EachFwStringArray[3] & @CRLF
		;MsgBox(0,"portsfile",$FWeach)
		FileWrite($fhSessionFWogFile,$Customer & ";" & $Hostname & ";" & $EachFwStringArray[1] & ";" & $EachFwStringArray[2] & ";" & $EachFwStringArray[3] & @CRLF)
		;MsgBox(0,$Tunnelstring & " " & $AllFwStringArray[0] & " AllFwString ",$AllFwStringArray[$Fw])
	Next
	For $EachFw = 1 to $EachFwStringArray[0]
		;MsgBox(0,$Tunnelstring & " " & $EachFwStringArray[0] & " EachFwString ",$EachFwStringArray[$EachFw])
	Next
	Local $JportFile
	;If Not FileExist($APPDataDir & "TCPRecvAndFwdTool.exe") Then FileInstall("TCPRecvAndFwdTool.exe",$APPDataDir & "TCPRecvAndFwdTool.exe")
	;MsgBox(0,"JPortFile",$APPDataDir & "\ports.txt")
	$JportFile = FileOpen($APPDataDir & "\ports.txt",2)
	If $JportFile = -1 Then MsgBox($MB_SYSTEMMODAL, "", "An error occurred when opening the file.")

	FileWrite($JportFile, $FWeach)
	FileClose($JportFile)
	FileClose($fhSessionFWogFile)
	;MsgBox(0,"jportforward",@ComSpec & " /c " & "java -cp " & @ScriptDir & "\programs\JPortForwarder\JPortForwarder.jar jportforwarder.JPortForwarder " & """" & $APPDataDir & "\ports.txt & " & """")
    ;$JportFwProcess = Run(@ComSpec & " /c " & "java -cp " & @ScriptDir & "\programs\JPortForwarder\JPortForwarder.jar jportforwarder.JPortForwarder " & """" & $APPDataDir & "\ports.txt  " & """","")
	If $javahome = "" Then
		$currentversion = RegRead("HKLM64\SOFTWARE\JavaSoft\Java Development Kit", "CurrentVersion")
		;MsgBox(0,"Java current version", $currentversion)
		If @error <> 0 Then MsgBox(0, "Error", "The Java Development Kit installation path could not be determined")
		; Obtain the JavaHome path from HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Development Kit\<current version>\JavaHome
		$javahome = RegRead("HKLM64\SOFTWARE\JavaSoft\Java Development Kit\" & $currentversion, "JavaHome")
		If @error <> 0 Then
			;MsgBox(0, "Error", "The Java Development Kit installation path could not be determined")
			$javahome = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\javaws.exe","Path")
			If @error <> 0 Then
				MsgBox(0, "Error", "The Java Runtime Environment installation path could not be determined." & @CRLF & "Please install JRE or JDK 1.6!")
				$javahome = ""
			Else
				$javahome = $javahome & "\"
			EndIf
		Else
			$javahome = $javahome & "\bin\"
		EndIf
   	EndIf
	;MsgBox(0,"java","""" & $javahome & "java.exe" & """" & " -cp " & """" & @ScriptDir & "\programs\JPortForwarder\JPortForwarder.jar" & """" & " jportforwarder.JPortForwarder " & """" & $APPDataDir & "\ports.txt" & """")
    $JportFwProcess = Run("""" & $javahome & "java.exe" & """" & " -cp " & """" & @ScriptDir & "\programs\JPortForwarder\JPortForwarder.jar" & """" & " jportforwarder.JPortForwarder " & """" & $APPDataDir & "\ports.txt" & """","")

	;Run(@ComSpec & " /c " & 'commandName', "", @SW_HIDE)
	;MsgBox(0,"Jportforw process", $JportFwProcess)
	$jPortFWPIDS = $JportFwProcess & "|" & $jPortFWPIDS
EndIf
	;MsgBox(0,"## Case App" , $Application )
	DelInfoText()
	SetInfoText("Starting " & $Application & " application ! ")
	Select
		Case $Application = "GG"
			;MsgBox(0,"GGuser in APP",$user)
			;MsgBox(0,"Password to GG", $password)
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Run GoGlobal",$Customer & " " & $user & "@" & $host & ":" & $localPort & " " & $version)
			RunGOGlobal($Customer, $host, $localPort, $version, $user, $password)
		Case $Application = "SSH"
			$SSHport = $localPort - 49000 + 22000
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"SSH connection to customer",$PuTTYDIR & " -ssh " & " -P " & $SSHport & " -pw " & $password & " " & $user & "@" & $host)
			;If $uxversion = "nx" Then
			;	$SSHPID = run("""" & $NXDIR & """" & " --config " & """" & "programs\NXclient\config\exfirewall Hfd.nxs" & """" ,"")
			;Else

			If Not $password Then
				$password = InputBox("Please provide password:","Password: ","","*M",220,120)
				sleep(200)
				;GUICtrlSetData($VPC_passID,$VPC_pass)
			EndIf

				$SSHPID = run("""" & $PuTTYDIR & """" & " -ssh " & " -P " & $SSHport & " -pw " & $password & " " & $user & "@" & $host ,"")
			;EndIf
			$SessionPIDS = $SSHPID & "|" & $SessionPIDS
		Case $Application = "NX"
			$SSHport = $localPort - 49000 + 22000
			If ($Customer = "VirtualPCs" And $host <> "localhost") Then
				$NXport = $localPort - 49000 + 24200
			Else
				$NXport = $SSHport
			EndIf
			$NXport = $localport - 49000 + 24200
			if ($Customer <> "VirtualPCs") Then $NXport = $NXport - 2200
			;MsgBox(0,"localport and NXport and host",$localPort & " and " & $NXport & " and " & $host)
			CreateNXSessionConfigFile($host,$user,$NXport,$password,$Customer_host)
			;MsgBox(0,"NX","""" & $NXDIR & """" & " --session " & """" & "programs\NXclient\config\" & $Customer_host & ".nxs" & """")
			;$NXPID = run("""" & $NXDIR & """" & " --session " & """" & "programs\NXclient\config\" & $Customer_host & ".nxs" & """" ,"")
			$NXPID = run($NXDIR & "nxclient.exe --session " & """" & $NXDIR & "config\" & $Customer_host & ".nxs" & """" ,"")
			;MsgBox(0,"NXstart",$NXDIR & " --session " & """" & "programs\NXclient\config\" & $Customer_host & ".nxs" & """")
			$SessionPIDS = $NXPID & "|" & $SessionPIDS
		Case ($Application = "Telnet" )
			$Telnetport = $localPort - 49000 + 23000
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Telnet",$PuTTYDIR & " -telnet " & $user & "@" & $host & " " & $Telnetport)
			$TelnetPID = run("""" & $PuTTYDIR & """" & " -telnet " & $user & "@" & $host & " " & $Telnetport,"")
			$SessionPIDS = $TelnetPID & "|" & $SessionPIDS
		Case ($Application = "TelnetConsole" )
			$TelnetConsoleport = $localPort - 49000 + 23023
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"TelnetConsole" & $localPort,$PuTTYDIR & " -telnet " & $user & "@" & $host & " " & $TelnetConsoleport)
			$TelnetPID = run("""" & $PuTTYDIR & """" & " -telnet " & $user & "@" & $host & " " & $TelnetConsoleport,"")
			$SessionPIDS = $TelnetPID & "|" & $SessionPIDS
		Case ($Application = "LanConsole")
			$LanConsoleport = $localPort - 49000 + 23025
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"LanConsole",$PuTTYDIR & " -telnet " & " " & $host & " " & $LanConsoleport)
			$TelnetPID = run("""" & $PuTTYDIR & """" & " -telnet " & " " & $host & " " & $LanConsoleport,"")
			$SessionPIDS = $TelnetPID & "|" & $SessionPIDS
		Case ($Application = "WebConsole")
			;MsgBox(0,"##WebConsole", $host )
			If StringInStr($host,":") Then
			  If StringSplit($host,":")[2] Then
				  ;MsgBox(0,"##Split", $host)
				  $Webport = StringSplit($host,":")[2]
				  $host = StringSplit($host,":")[1]
			  Else

				  $Webport = $localPort - 49000 + 8080
			  EndIf
		    Else
			    $Webport = $localPort - 49000 + 8080
			EndIf
			;MsgBox(0,"WebConsole",$HTTPDIR & """" & " http://" & $host & ":" & $Webport)
			$WebPID = run("""" & $HTTPDIR & """" & " http://" & $host & ":" & $Webport,"")

			$SessionPIDS = $WebPID & "|" & $SessionPIDS
		Case $Application = "SCP"
			$SSHport = $localPort - 49000 + 22000
			$SCPport = $SSHport
			$SCPuser = $user
			$SCPprivateKey = ""
			If (StringInStr($Customer_host,"VirtualPC")) Then
				$SCPprivateKey = " /privatekey=" & """" & $SSHprivKey_VPC & """"
				$SCPuser = $SSHVPCUser
			EndIf
			$SCPpassword = $password
			$VPChost = $host
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"SCP connection to customer",$WinSCPDIR & " " & $SCPuser & ":" & $SCPpassword & "@" & $host & ":" & $SCPport & $SCPprivateKey)
			$WinSCPPID = run("""" & $WinSCPDIR & """" & " " & $SCPuser & ":" & $SCPpassword & "@" & $host & ":" & $SCPport & $SCPprivateKey,"")
			If $SCPprivateKey Then
				sleep(1000)
				If Not WinActive("Key passphrase - " & $SCPuser & "@" & $host) Then WinActivate("Key passphrase - " & $SCPuser & "@" & $host)
				sleep(500)
				Send($VPC_pass & "{ENTER}")
			EndIf
			$SessionPIDS = $WinSCPPID & "|" & $SessionPIDS
		Case $Application = "ftp"
			$ftpport = $localPort - 49000 + 21000
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Ftp connection to customer",$FTPDIR & " " & $user & $ftpgw & ":" & $password & "@" & $host & ":" & $ftpport)
			$FTPPID = run("""" & $FTPDIR & """" & " " & $user & $ftpgw & ":" & $password & "@" & $host & ":" & $ftpport,"")
			$SessionPIDS = $FTPPID & "|" & $SessionPIDS
		Case $Application = "WEB"
			$Webport = $localPort - 49000 + 8000
			$WebPID = run("""" & $HTTPDIR & """" & " http://" & $host & ":" & $Webport,"")
			$SessionPIDS = $WebPID & "|" & $SessionPIDS
		Case ($Application = "VNC" )
			$VNCport = $localPort - 49000 + 59000
			;MsgBox(0,"VNCport", $VNCport & "Localport= " & $localPort)
			$passPassword = ""
			;If $VNCDIR = "C:\Program Files\UltraVNC\vncviewer.exe" Then $passPassword = " /password " & $password
			$VNCportSelected = GUICtrlRead($ApplicationVersion_ID)
			If $VNCportSelected <> "vnc" Then $VNCport = $VNCportSelected - 5900 + ($localPort - 49000 + 59000)
			Select
				Case $VNCCompanyName = "UltraVNC"
					$passPassword = " /password " & $password
					$VNCPID = run("""" & $VNCDIR & """" & " " & $host & ":" & $VNCport & $passPassword,"")
					;MsgBox(0,"jep","nog niet daar")
					sleep(1000)
					Local $wintit = WinGetTitle(" Ul")
					;MsgBox(0,"jep",$wintit)

					;If WinActive("Ultr@VNC Info","No configured security type is supported by 3.3 viewer") Then
					WinActivate(" Ul")
					If WinActive(" Ul") Then
						Local $VNCError = WinGetText(" Ul")
						If StringInStr($VNCError,"No configured security type is supported") Then


							WinActivate(" Ul")
							Send("{ENTER}")
							MsgBox(48,"Ultr@VNC Info  ", _
							"No configured security type is supported by the UltraVNC viewer.            " & @CRLF _
							& "RealVNC will be used instead for this session after pressing OK.          " & @CRLF _
							& "Default viewer can be set via Settings -> Options -> Program Directories 2")
							$VNCDIR_org = $VNCDIR
							$VNCDIR = $GGTunnelDir & "\programs\vnc\realvncviewer.exe"
							If Not FileExists($VNCDIR) Then
								MsgBox(48,"VNC viewer application not found.","RealVNC viewer not found. " & @CRLF & "VNC viewer can be set via Settings -> Options -> Program Directories 2")
							Else
								RunRealVNC($host, $VNCport, $user, $password)
								$VNCDIR = $VNCDIR_org
							EndIf
						EndIf
					EndIf


				Case $VNCCompanyName = "RealVNC Ltd"
					RunRealVNC($host, $vncport, $user, $password)
				EndSelect
			;If $VNCProductName = "UltraVNC VNCViewer" Then $passPassword = " /password " & $password

			;If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"VNC " & $localPort,$VNCDIR & " " & $host & ":" & $VNCport & $passPassword)

			;$VNCPID = run("""" & $VNCDIR & """" & " " & $host & ":" & $VNCport & $passPassword,"")

			$SessionPIDS = $VNCPID & "|" & $SessionPIDS
		Case ($Application = "RDP" )
			$RDPport = $localPort - 49000 + 33890
			$passPassword = ""
			$RDPportSelected = GUICtrlRead($ApplicationVersion_ID)
			If $RDPportSelected <> "rdp" Then
				Select
					case $RDPportSelected = "VBox-UK"
						$RDPportSelected = "3394"
					case $RDPportSelected = "VPC1"
						$RDPportSelected = "3391"
					case $RDPportSelected = "VPC2"
						$RDPportSelected = "3392"
					case $RDPportSelected = "VPC3"
						$RDPportSelected = "3393"
				EndSelect
				$RDPport = ($RDPportSelected - 3389)*10 + ($localPort - 49000 + 33890) -10
			EndIf
			;MsgBox(0,"RDPpoort",$RDPport)
			If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"RDP " & $localPort,$RDPDIR & " " & $host & ":" & $RDPport)
			If StringInStr($RDPDIR,"rdp.exe") Then
				$RDPUserPasswd = ""
				If ($user And $password) Then
					$RDPUserPasswd = " /u:" & $user & " /p:" & $password
				EndIf
				$RDPPID = run("""" & $RDPDIR & """" & " /v:" & $host & ":" & $RDPport & $RDPUserPasswd & " /f /title:" & $Customer_host & ":" & $user,"")
			Else
				$RDPPID = run("""" & $RDPDIR & """" & " /v:" & $host & ":" & $RDPport,"")
			EndIf
			$SessionPIDS = $RDPPID & "|" & $SessionPIDS
			;MsgBox(0,"RDPPID en allSessionPIDS: ", "All: " & $AllSessionPIDS & "Sess: " & $SessionPIDS)
		Case $Application = "TV"
			$Webport = $localPort - 49000 + 8000
			;MsgBox(0,$Application & " - " & $version ,$TVDIR)
			$passPassword = ""
			If $password Then $passPassword = " --Password " & $password
			Select
				Case $version = "tv7"
					$TVDIR = $TV7DIR
				Case $version = "tv8"
					$TVDIR = $TV8DIR
				Case $version = "tv9"
					$TVDIR = $TV9DIR
				Case $version = "tv10"
					$TVDIR = $TV10DIR
			EndSelect
			$TVPID = run("""" & $TVDIR & """" & " -i " & $user & $passPassword,"")
			$SessionPIDS = $WebPID & "|" & $SessionPIDS
	EndSelect
	$fhSessionsLogFile = FileOpen($SessionsLogFile,1)
	FileWrite($fhSessionsLogFile,$Application & ";" & $Customer & ";" & $HostLabel & ";" & $HostIP & ";" & $StartTime & ";" & $ConnectVia & @CRLF)
	FileClose($fhSessionsLogFile)

	_SQLite_QuerySingleRow($DBmem,"SELECT hostid from hosts where Serverid = '" & $ServerPort & "'" ,$hQuery4)
	$ConnHostID = $hQuery4[0]
	DelInfoText()
	GUICtrlSetColor($ConnhostID,0x10A010)
	GUISetState()
	sleep(2500)
	CheckSecurityAlert()
EndFunc


Func CreateIconList()
	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 110)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 131)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 165)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 168)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 137) ;green arrow
	_GUIImageList_AddIcon($hImage, "shell32.dll", 146)
	_GUICtrlTreeView_SetNormalImageList($treeView, $hImage)
EndFunc


Func GetSSHkeyInfo($Connect)
	Local $ybot, $DameWarePCnew, $VNCicon_ID

	$xtop = $x2+10
	If ($Connect = "Internet" ) Then
		$SSHinfo_ID = GUICtrlCreateGroup("SSH info:",$leftSSHinfo,$topSSHinfo,$WidthSSHinfo,$HeightSSHinfo)
		$pass1Label = GUICtrlCreateLabel("Passphrase VPNHostPC:", $leftSSHinfo+10, $topSSHinfo+20, 120)
		If (StringInStr($Customer_host,"Win7",2)) Then
			$SSHVPCUser = $SSHVPC7User
		Else
			$SSHVPCUser = $SSHVPCUser_org
		EndIf
		$pass3Label = GUICtrlCreateLabel("(Username: " & $SSHVPCUser & ")",$leftSSHinfo+10, $topSSHinfo+35, 120)
		;MsgBox(0,$Customer,$Customer_host)
		;MsgBox(0,"VPNC-passwd","##" & $VPC_pass & "##")
	    $VPC_passID = GUICtrlCreateInput($VPC_pass, $leftSSHinfo+10,$topSSHinfo+50, $InputLength2, 20, $ES_PASSWORD)
		$ytop = $SSHytop + 60
	EndIf
	If ($Connect = "sdhswdl" Or $Connect = "TTACVLAN") And Not StringInStr($Customer_host,"VirtualPC") Then
	;If ($Connect = "sdhswdl" Or $Connect = "TTACVLAN") Then
		$ybot = $ytop - $SSHytop
		$SSHinfo2_ID = GUICtrlCreateGroup("SSH info:",$leftSSHinfo,$topSSHinfo,$WidthSSHinfo,$HeightSSHinfo)
		$pass2Label = GUICtrlCreateLabel("Passphrase nlsdh1:", $leftSSHinfo+10, $topSSHinfo+80, 120)
		$pass4Label = GUICtrlCreateLabel("(Username: " & $SSHnlsdh1User & ")",$leftSSHinfo+10, $topSSHinfo+95, 120)
		$nlsdh1_passID = GUICtrlCreateInput($nlsdh1_pass, $leftSSHinfo+10,$topSSHinfo+110, $InputLength2, 20, $ES_PASSWORD)
		GUICtrlSetState($nlsdh1_passID,$GUI_FOCUS)
		$ytop = $SSHytop + 120
	EndIf
	If $Connect = "DameWare" Then
		$SSHinfo_ID = GUICtrlCreateGroup("Antwerp dialin PC's:",$leftAntwerpPC,$topAntwerpPC,$WidthAntwerpPC,$HeightAntwerpPC)

		$ytop = $topAntwerpPC + 20
		$DameLabel = GUICtrlCreateLabel("Connect to PC:", $leftAntwerpPC+10, $ytop, 120)
		If GUICtrlRead($DameWarePC_ID) Then
			$DameWarePC = GUICtrlRead($DameWarePC_ID)
		Else
			$DamewarePC = $DamewareArrayPCs[1]
		EndIf
		$DameWarePC_ID = GUICtrlCreateCombo($DamewarePC,$leftAntwerpPC+10 ,$ytop+20,100,100 )
		$PCs = ""
		For $PC = 1 to $DamewareArrayPCs[0]
			$PCs = $PCs & "|" & $DamewareArrayPCs[$PC]
		Next
	    GUICtrlSetData(-1, $PCs,$DamewarePC)
		GUICtrlSetState($DameWarePC_ID,$GUI_FOCUS)
		$hImage = _GUIImageList_Create(16, 16, 5, 1, 2)
		If $VNCDIR Then	$VNCicon_ID = _GUIImageList_AddIcon($hImage, $VNCDIR, 0, True)
		$VNCbuttonID = GUICtrlCreateButton("", $leftAntwerpPC+115, $ytop+20, 20, 20)
		if ($VNCicon_ID = -1 Or $VNCDIR = "") Then
			$VNCbuttonID = GUICtrlCreateButton("..", $leftAntwerpPC+115, $ytop+20, 20, 20)
			GUICtrlSetData ( $VNCbuttonID, "PC")

		Else
			_GUICtrlButton_SetImageList($VNCbuttonID, $hImage,4)
		EndIf
		$DameRemark = GUICtrlCreateLabel("Note: " & @CRLF & "First start dialin connection" & @CRLF & "on PC before pressing GO!", $leftAntwerpPC+10, $ytop+45, 140,40)
		GUICtrlSetColor($DameRemark, 0x0000C0)
		$ytop=$ytop+35
		$CheckDialinbutton = GUICtrlCreateButton("&Check dialin connections", $leftAntwerpPC+10, $ytop+55, 130, 20)
	EndIf
	$ybot = $ytop-$SSHytop+30
EndFunc


Func GetCustomer($TreeChildId)
Local $ParentTreeID
If $TreeChildId <> $AllCustomers Then
	$ParentTreeID = _GUICtrlTreeView_GetParentParam($TreeView, $TreeChildId)
	GetCustomer($ParentTreeID)
EndIf
	$nn = $nn+1
	$Custmr[$nn] = GUICtrlRead($ParentTreeID,1)
	$CustmrId[$nn] = $ParentTreeID
EndFunc

Func DisableAllViaRadio()
	GUICtrlSetState($RadioVLAN,$GUI_DISABLE)
	GUICtrlSetState($RadioSwdl,$GUI_DISABLE)
	GUICtrlSetState($RadioDEGW,$GUI_DISABLE)
	GUICtrlSetState($RadioVPN,$GUI_DISABLE)
	GUICtrlSetState($RadioDame,$GUI_DISABLE)

EndFunc

Func EnableAllViaRadio()
	GUICtrlSetState($RadioVLAN,$GUI_ENABLE)
	GUICtrlSetState($RadioSwdl,$GUI_ENABLE)
	GUICtrlSetState($RadioDEGW,$GUI_ENABLE)
	GUICtrlSetState($RadioVPN,$GUI_ENABLE)
	GUICtrlSetState($RadioDame,$GUI_ENABLE)
EndFunc


Func EnableAllApplications()
	GUICtrlSetState($RadioGG,$GUI_ENABLE)
	GUICtrlSetState($RadioSSH,$GUI_ENABLE)
	GUICtrlSetState($RadioTelnet,$GUI_ENABLE)
	GUICtrlSetState($RadioSCP,$GUI_ENABLE)
	GuiCtrlSetState($Radioftp,$GUI_ENABLE)
	GUICtrlSetState($RadioWeb,$GUI_ENABLE)
	GUICtrlSetState($RadioLanConsole,$GUI_ENABLE)
	GUICtrlSetState($RadioWebConsole,$GUI_ENABLE)
	GUICtrlSetState($RadioTelnetConsole,$GUI_ENABLE)
	GUICtrlSetState($RadioVNC,$GUI_ENABLE)
	GUICtrlSetState($RadioRDP,$GUI_ENABLE)
	GUICtrlSetState($RadioNX,$GUI_ENABLE)
	GUICtrlSetState($RadioTV,$GUI_ENABLE)
EndFunc


Func DisableAllApplications()
	GUICtrlSetState($RadioGG,$GUI_UNCHECKED)
	GUICtrlSetState($RadioGG,$GUI_DISABLE)
	GUICtrlSetState($RadioSSH,$GUI_UNCHECKED)
	GUICtrlSetState($RadioTelnet,$GUI_UNCHECKED)
	GUICtrlSetState($RadioSCP,$GUI_UNCHECKED)
	GuiCtrlSetState($Radioftp,$GUI_UNCHECKED)
	GUICtrlSetState($RadioWeb,$GUI_UNCHECKED)
	GUICtrlSetState($RadioLanConsole,$GUI_UNCHECKED)
	GUICtrlSetState($RadioWebConsole,$GUI_UNCHECKED)
	GUICtrlSetState($RadioTelnetConsole,$GUI_UNCHECKED)
	GUICtrlSetState($RadioVNC,$GUI_UNCHECKED)
	GUICtrlSetState($RadioRDP,$GUI_UNCHECKED)
	GUICtrlSetState($RadioNX,$GUI_UNCHECKED)
	GUICtrlSetState($RadioTV,$GUI_UNCHECKED)
	GUICtrlSetState($RadioSSH,$GUI_DISABLE)
	GUICtrlSetState($RadioTelnet,$GUI_DISABLE)
	GUICtrlSetState($RadioSCP,$GUI_DISABLE)
	GuiCtrlSetState($Radioftp,$GUI_DISABLE)
	GUICtrlSetState($RadioWeb,$GUI_DISABLE)
	GUICtrlSetState($RadioLanConsole,$GUI_DISABLE)
	GUICtrlSetState($RadioWebConsole,$GUI_DISABLE)
	GUICtrlSetState($RadioTelnetConsole,$GUI_DISABLE)
	GUICtrlSetState($RadioVNC,$GUI_DISABLE)
	GUICtrlSetState($RadioRDP,$GUI_DISABLE)
	GUICtrlSetState($RadioNX,$GUI_DISABLE)
	GUICtrlSetState($RadioTV,$GUI_DISABLE)

EndFunc


Func SetJPortFworwarder($GGfw, $SSHfw, $Webfw, $Telnetfw)
	Local $JportFile

	$JportFile = FileOpen("programs\JPortForwarder\ports.txt",2)
	If $JportFile = -1 Then MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading/writing the file.")

	FileWriteLine($JportFile, "tcp " & $GGfw & @CRLF)
	FileWriteLine($JportFile, "tcp " & $SSHfw & @CRLF)
	FileWriteLine($JportFile, "tcp " & $Webfw & @CRLF)
	FileWriteLine($JportFile, "tcp " & $Telnetfw & @CRLF)

	FileClose($JportFile)

	;RunWait("programs\JPortForwarder\run.bat","")
	Run("java -cp programs\JPortForwarder\JPortForwarder.jar jportforwarder.JPortForwarder programs\JPortForwarder\ports.txt","")

EndFunc


Func LoadNMS($item)
Local $LanconsoleTun,$WebConsoleTun, $TelnetConsoleTun,$ConsoleIp, $VNCTun, $RDPTun, $VNC, $l, $comRow, $Comment, $GGDBRow, $GGDBr, $hostid
Local $fwftpport, $fwggport, $fwtelnetport, $fwtunssh, $fwtuntelnet, $ver, $vertype, $verQuery, $verRow, $vers, $VNCportSelected
CheckApplicationBox()
HideViaOptions()
$ytop = $SSHytop
DelInfoText()

If $ConnectVia = "" Then
	MsgBox(64,"Warning","First choose how to connect.")
Else
	$item = GUICtrlRead($treeview)
	If $item = 0 Then
    	MsgBox(64, "Database", "No item currently selected.")
	Else
		$text = GUICtrlRead($item, 1)
		;MsgBox(0,"ITEM",$item)


		EnableAllApplications()
		$EndHostAddress = ""
		$EndHostPasswd = ""
		$EndHostUser = ""
		;$UseHostAsHop = "4"
		;_SQLite_Query($DBmem,"SELECT ServerId, ServerIP, Customer, GGversion, User, Password, TelnetConsole, WebConsole, tunnel, tunnelip, HostId, lanconsole, DameWareIP, host from hosts where hostid = '" & $item & "'",$hQuery4)
		_SQLite_QuerySingleRow($DBmem,"SELECT ServerId, ServerIP, Customer, GGversion, User, Password, TelnetConsole, WebConsole, tunnel, tunnelip, HostId, lanconsole, DameWareIP, host, Comment from hosts where hostid = '" & $item & "'",$dRow)

		;While _SQLite_FetchData ($hQuery4, $dRow) = $SQLITE_OK ;
		;MsgBox(0,"dasdas",$dRow[0])
		If $dRow[0] Then
			$SSHport = $dRow[0]-49000+22000
			$hostid = $dRow[0]
			$Webport = $dRow[0]-49000+8000
			$Telnetport = $dRow[0]-49000+23000
			$TelnetConsoleport = $dRow[0]-49000+23023
			$LanConsoleport = $dRow[0]-49000+23025
			$WebConsoleport = $dRow[0]-49000+8080
			$VNCport = $dRow[0] -49000+59000
			$VNCportSelected = GUICtrlRead($ApplicationVersion_ID)
			If ($VNCportSelected <> "vnc" And $VNCportSelected <> 0) Then $VNCport = $VNCportSelected - 5900 + ($dRow[0] - 49000 + 59000)
			$RDPport = $dRow[0] -49000+33890
			$NXport = $dRow[0] -49000+24200
			$WebConsoleIP = $dRow[7]
			$LanconsoleIP = $dRow[11]
			$TelnetConsoleIP = $dRow[6]
			$DameWareHostIP = $dRow[12]
			$uxversion = $dRow[3]
			$LanconsoleTun = ""
			$WebConsoleTun = ""
			$TelnetConsoleTun = ""
			$VNCTun = ""
			$RDPtun = ""
			$Customer = $dRow[2]
			$Customer_host = $dRow[13]
			$Comment = $dRow[14]
			$SSHtunnels = $dRow[8]
			$IP = $dRow[1]

			$Hostname = $dRow[13]
			;MsgBox(0,"Load # tunnels, hostname, uxversion", $SSHtunnels & ", " & $Hostname & ", " & $uxversion)
			;MsgBox(0,"GGDB ID", $GGDBr)
			$GGDBr = _SQLite_Open ($SQliteDB)
			_SQLite_QuerySingleRow($GGDBr,"select name from tree where id = (select parentid from tree where id = " & $dRow[0] & ")",$GGDBRow)
			$Customer = $GGDBRow[0]
			;MsgBox(0,"GGDB ID after", $GGDBr)
			_SQLite_Close($GGDBr)

			;MsgBox(0,"Application",$Application)
			;_SQLite_QuerySingleRow($DBmem,"select comment from hosts where serverid = '" & $dRow[0] & "'", $comRow)
			;MsgBox(0,"Comment " & $dRow[0] & " " ,$Comment)
			;CheckComments($Comment)

			If $hostid <> $oldhostid Then

				$vertype = $dRow[3]
				;MsgBox(0,$hostid & " - " & $oldhostid,$vertype)
				$ver = ""
			EndIf


			If $dRow[3] = "ramses-KPN" Then
				DisableAllApplications()
				GUICtrlSetState($RadioWeb,$GUI_ENABLE)
				GUICtrlSetState($RadioWeb,$GUI_CHECKED)
				$Application = "WEB"

			EndIf
			if StringInStr($dRow[3],"ux") Then
				GuiCtrlSetState($RadioNX,$GUI_UNCHECKED)
				GuiCtrlSetState($RadioNX,$GUI_DISABLE)
				GuiCtrlSetState($RadioTV,$GUI_UNCHECKED)
				GuiCtrlSetState($RadioTV,$GUI_DISABLE)

			EndIf
			if $dRow[3] = "nx" Then
				GUICtrlSetState($RadioVNC,$GUI_UNCHECKED)
				GUICtrlSetState($RadioRDP,$GUI_UNCHECKED)
				GUICtrlSetState($RadioVNC,$GUI_DISABLE)
				GuiCtrlSetState($RadioRDP,$GUI_DISABLE)
				GUICtrlSetState($Radioftp,$GUI_UNCHECKED)
				GUICtrlSetState($Radioftp,$GUI_DISABLE)
				GuiCtrlSetState($RadioGG,$GUI_UNCHECKED)
				GuiCtrlSetState($RadioGG,$GUI_DISABLE)
				GUICtrlSetState($RadioTelnetConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioTelnetConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioLanConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioLanConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioWebConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioWebConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioTelnet,$GUI_UNCHECKED)
				GUICtrlSetState($RadioTelnet,$GUI_DISABLE)
				GUICtrlSetState($RadioTV,$GUI_UNCHECKED)
				GUICtrlSetState($RadioTV,$GUI_DISABLE)
				;GUICtrlSetState($RadioWeb,$GUI_UNCHECKED)
				;GUICtrlSetState($RadioWeb,$GUI_DISABLE)
				If ($hostid <> $oldhostid) And StringInStr($dRow[3],"nx") = "1" Then
					$oldhostid = $hostid
					GuiCtrlSetState($RadioNX,$GUI_ENABLE)
					GuiCtrlSetState($RadioNX,$GUI_CHECKED)
					$Application = "NX"
				EndIf

			EndIf
			if $dRow[3] = "rdp" Then
				;GUICtrlSetState($RadioVNC,$GUI_UNCHECKED)
				;GUICtrlSetState($RadioVNC,$GUI_DISABLE)
				GUICtrlSetState($Radioftp,$GUI_UNCHECKED)
				GUICtrlSetState($Radioftp,$GUI_DISABLE)
				GuiCtrlSetState($RadioGG,$GUI_UNCHECKED)
				GuiCtrlSetState($RadioGG,$GUI_DISABLE)
				GUICtrlSetState($RadioLanConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioLanConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioWebConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioWebConsole,$GUI_DISABLE)
				GuiCtrlSetState($RadioNX,$GUI_UNCHECKED)
				GuiCtrlSetState($RadioNX,$GUI_DISABLE)
				;GuiCtrlSetState($RadioRDP,$GUI_ENABLE)
				;GuiCtrlSetState($RadioRDP,$GUI_CHECKED)
				If ($hostid <> $oldhostid) And StringInStr($dRow[3],"rdp") = "1" Then
					;MsgBox(0,$hostid,$oldhostid)
					$oldhostid = $hostid
					GuiCtrlSetState($RadioRDP,$GUI_ENABLE)
					GuiCtrlSetState($RadioRDP,$GUI_CHECKED)
					$Application = "RDP"
				EndIf
			EndIf
			if $dRow[3] = "vnc" Then
				If ($hostid <> $oldhostid) And StringInStr($dRow[3],"vnc") = "1" Then
					;MsgBox(0,$hostid,$oldhostid)
					$oldhostid = $hostid
					GuiCtrlSetState($RadioVNC,$GUI_ENABLE)
					GuiCtrlSetState($RadioVNC,$GUI_CHECKED)
					$Application = "VNC"
				EndIf
			EndIf
			if StringInStr($dRow[3],"tv") Then
				GUICtrlSetState($RadioVNC,$GUI_UNCHECKED)
				GUICtrlSetState($RadioRDP,$GUI_UNCHECKED)
				GUICtrlSetState($RadioVNC,$GUI_DISABLE)
				GuiCtrlSetState($RadioRDP,$GUI_DISABLE)
				GUICtrlSetState($Radioftp,$GUI_UNCHECKED)
				GUICtrlSetState($Radioftp,$GUI_DISABLE)
				GuiCtrlSetState($RadioGG,$GUI_UNCHECKED)
				GuiCtrlSetState($RadioGG,$GUI_DISABLE)
				GUICtrlSetState($RadioSCP,$GUI_DISABLE)
				GUICtrlSetState($RadioSCP,$GUI_UNCHECKED)
				GUICtrlSetState($RadioTelnetConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioTelnetConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioLanConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioLanConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioWebConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioWebConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioTelnet,$GUI_UNCHECKED)
				GUICtrlSetState($RadioTelnet,$GUI_DISABLE)
				GUICtrlSetState($RadioNX,$GUI_UNCHECKED)
				GUICtrlSetState($RadioNX,$GUI_DISABLE)
				GUICtrlSetState($RadioSSH,$GUI_DISABLE)
				GUICtrlSetState($RadioSSH,$GUI_UNCHECKED)
				GUICtrlSetState($RadioWeb,$GUI_UNCHECKED)
				GUICtrlSetState($RadioWeb,$GUI_DISABLE)
				If ($hostid <> $oldhostid) And StringInStr($dRow[3],"tv") = "1" Then
					$oldhostid = $hostid
					GuiCtrlSetState($RadioTV,$GUI_ENABLE)
					GuiCtrlSetState($RadioTV,$GUI_CHECKED)
					$Application = "TV"
				EndIf
			EndIf
			If $dRow[3] = "rdp" Or $dRow[3] = "vnc" Or $dRow[3] = "win312" Or $dRow[3] = "win4" Then
				;MsgBox(0,"UXVERSION",$dRow[3])
				;If $dRow[3] = "vnc" Then
				;	GUICtrlSetState($RadioVNC,$GUI_ENABLE)
				;	GUICtrlSetState($RadioVNC,$GUI_CHECKED)
				;EndIf
				GUICtrlSetState($RadioVNC,$GUI_ENABLE)
				GuiCtrlSetState($RadioRDP,$GUI_ENABLE)
				;If $dRow[3] = "vnc" Then GUICtrlSetState($RadioVNC,$GUI_CHECKED)
				$VNCTun = " -L " & $VNCport & ":" & $dRow[1] & ":5900 "
				$RDPTun = " -L " & $RDPport & ":" & $dRow[1] & ":3389 "
				$RDPTun = $RDPTun & " -L " & $RDPport+10 & ":" & $dRow[1] & ":3391 "
				$RDPTun = $RDPTun & " -L " & $RDPport+20 & ":" & $dRow[1] & ":3392 "
				$RDPTun = $RDPTun & " -L " & $RDPport+30 & ":" & $dRow[1] & ":3393 "
				$RDPTun = $RDPTun & " -L " & $RDPport+40 & ":" & $dRow[1] & ":3394 "

				;MsgBox(0,"RDP tunnel",$RDPTun)
				If ($hostid <> $oldhostid) And StringInStr($dRow[3],"win") = "1" Then
					$oldhostid = $hostid
					GuiCtrlSetState($RadioGG,$GUI_ENABLE)
					GuiCtrlSetState($RadioGG,$GUI_CHECKED)
					$Application = "GG"
				EndIf
				GuiCtrlSetState($RadioNX,$GUI_UNCHECKED)
				GuiCtrlSetState($RadioNX,$GUI_DISABLE)
			Else
			 ;If $dRow[3] <> "rdp" Then
				;GUICtrlSetState($RadioVNC,$GUI_UNCHECKED)
				GUICtrlSetState($RadioRDP,$GUI_UNCHECKED)
				;GUICtrlSetState($RadioVNC,$GUI_DISABLE)
				GuiCtrlSetState($RadioRDP,$GUI_DISABLE)
				If ($hostid <> $oldhostid) And StringInStr($dRow[3],"ux") = "1" Then
					$oldhostid = $hostid
					GuiCtrlSetState($RadioGG,$GUI_ENABLE)
					GuiCtrlSetState($RadioGG,$GUI_CHECKED)
					$Application = "GG"
				EndIf
             ;EndIf
			EndIf
			If $LanconsoleIP Then
				$LanconsoleTun = " -L " & $LanConsoleport & ":" & $LanconsoleIP & ":23 "
				$ConsoleIp = $Lanconsole
			EndIf
			If $WebConsoleIP Then
				$WebConsoleTun = " -L " & $WebConsoleport & ":" & $WebconsoleIP & ":80 "
				$ConsoleIp = $WebconsoleIP
			EndIf
			If $TelnetConsoleIP Then
				$TelnetConsoleTun = " -L " & $TelnetConsoleport & ":" & $TelnetconsoleIP & ":23 "
				$ConsoleIp = $TelnetconsoleIP
			EndIf
			If Not $LanconsoleIP Then GUICtrlSetState($RadioLanConsole,$GUI_DISABLE)
			If Not $WebconsoleIP Then GUICtrlSetState($RadioWebConsole,$GUI_DISABLE)
			If Not $TelnetconsoleIP Then GUICtrlSetState($RadioTelnetConsole,$GUI_DISABLE)
			If (($SSHtunnels = "0" Or $dRow[3] = "ramses") And ($Application <> "TV" And $Application <> "WEB")) Then
				GUICtrlSetState($Radioftp,$GUI_ENABLE)
				GUICtrlSetState($RadioSSH,$GUI_ENABLE)
			Else
				If $dRow[3] <> "vnc" Then
					GUICtrlSetState($Radioftp,$GUI_UNCHECKED)
					GUICtrlSetState($Radioftp,$GUI_DISABLE)
				EndIf
			EndIf
			If ($dRow[3] = "ramses" Or $dRow[3] = "win312" Or $dRow[3] = "win4") Then
				GUICtrlSetState($RadioWeb,$GUI_UNCHECKED)


				;GUICtrlSetState($RadioVNC,$GUI_UNCHECKED)
				GUICtrlSetState($RadioTelnetConsole,$GUI_UNCHECKED)
				GUICtrlSetState($RadioLanConsole,$GUI_UNCHECKED)
				;MsgBox(0,"webconsole",$WebconsoleIP)
				If Not $WebconsoleIP Then
					GUICtrlSetState($RadioWebConsole,$GUI_DISABLE)
					GUICtrlSetState($RadioWebConsole,$GUI_UNCHECKED)

				EndIf
				GUICtrlSetState($RadioWeb,$GUI_DISABLE)
				If $dRow[3] = "ramses" Then
					GUICtrlSetState($RadioVNC,$GUI_UNCHECKED)
					GUICtrlSetState($RadioVNC,$GUI_DISABLE)
					GUICtrlSetState($RadioSCP,$GUI_DISABLE)
					GUICtrlSetState($RadioSCP,$GUI_UNCHECKED)
					;GUICtrlSetState($RadioSSH,$GUI_DISABLE)

				EndIf
				;GUICtrlSetState($RadioVNC,$GUI_DISABLE)
				GUICtrlSetState($RadioTelnetConsole,$GUI_DISABLE)
				GUICtrlSetState($RadioLanConsole,$GUI_DISABLE)
				;GUICtrlSetState($RadioWebConsole,$GUI_DISABLE)
				If ($dRow[3] = "win312" Or $dRow[3] = "win4") Then
					GUICtrlSetState($RadioSSH,$GUI_DISABLE)
					GUICtrlSetState($RadioSSH,$GUI_UNCHECKED)
					GUICtrlSetState($RadioTelnet,$GUI_UNCHECKED)
					GUICtrlSetState($RadioTelnet,$GUI_DISABLE)
					GUICtrlSetState($Radioftp,$GUI_UNCHECKED)
					GUICtrlSetState($Radioftp,$GUI_DISABLE)
				EndIf
			EndIf
			If $dRow[3] = "ramses" Then
				_SQLite_Query($GGDB,"SELECT Id, hostname, serverip, uxversion, ggport, telnetport, ftpport, ftpgw, sshport from ramses where Id = '" & $dRow[0] & "'",$hQuery4)
				While _SQLite_FetchData ($hQuery4, $eRow) = $SQLITE_OK
					$IP = $eRow[2]
					;MsgBox(0,"IP Ramses",$IP)
					$uxversion = $eRow[3]
					$fwggport = $eRow[4]
					$fwtelnetport = $eRow[5]
					$fwtuntelnet = ""
					if $eRow[5] Then $fwtuntelnet = " -L " & $Telnetport & ":" & $eRow[2] & ":" & $eRow[5]
				    $fwftpport = $eRow[6]
					$ftpgw = "@" & $eRow[7]
					$MDsshport = $eRow[8]
					$fwtunssh = ""
					if $eRow[8] Then $fwtunssh = " -L " & $SSHport & ":" & $eRow[2] & ":" & $eRow[8]
				WEnd
				$Tunnelstring = "-L " & $dRow[0] & ":" & $IP & ":" & $fwggport & $fwtunssh & " -L " & $Webport & ":" & $IP & ":80 " & $fwtuntelnet & $LanconsoleTun & $WebConsoleTun & $TelnetConsoleTun & $VNCTun & $RDPTun & $TunnelVPCs & " "
			Else
				$Tunnelstring = "-L " & $dRow[0] & ":" & $dRow[1] & ":491 " & " -L " & $SSHport & ":" & $dRow[1] & ":22 " & "-L " & $Webport & ":" & $dRow[1] & ":80 " & " -L " & $NXport & ":" & $dRow[1] & ":2222 " & "-L " & $Telnetport & ":" & $dRow[1] & ":23 " & $LanconsoleTun & $WebConsoleTun & $TelnetConsoleTun & $VNCTun & $RDPTun & $TunnelVPCs & " "
				;MsgBox(0,"TunnelString",$Tunnelstring)
			EndIf
			;MsgBox(0,"Tunnelstring",$Tunnelstring)
		Else
			MsgBox(16,"Wrong object","Please select a server hostname!")
		EndIf
		;WEnd
	EndIf
	if ($Tunnelstring And $dRow[0]) Then

		Select
			Case (($dRow[3] = "win312" Or $dRow[3] = "win4" Or $dRow[3] = "nx" Or $dRow[3] = "rdp") And $ConnectVia = "Internet")
			;Case ($ConnectVia = "Internet")
			;Case ($dRow[3] = "win312" )
				$TunnelGGWin = $Tunnelstring
				GUICtrlSetState($nlsdh1_passID, $GUI_HIDE)
				GUICtrlSetState($pass2Label, $GUI_HIDE)
				GetSSHkeyInfo($ConnectVia)
				If (($Customer_host = $VirtualPCsPC2 OR $Customer_host = $VirtualPCsPC1 OR $Customer_host = $VirtualPCsPC3 OR $Customer_host = $VirtualPCsPC4) AND $Application = "SCP") Then GetSSHkeyInfo("SCPtoVirtualPC")
			Case (($dRow[3] = "win312" Or $dRow[3] = "win4") And $ConnectVia = "sdhswdl")
				GUICtrlSetState($VPC_passID, $GUI_HIDE)
				GUICtrlSetState($pass1Label, $GUI_HIDE)
				If (($Customer_host = $VirtualPCsPC2 OR $Customer_host = $VirtualPCsPC1 OR $Customer_host = $VirtualPCsPC3 OR $Customer_host = $VirtualPCsPC4) AND $Application = "SCP") Then
					GetSSHkeyInfo("Internet")
					GetSSHkeyInfo($ConnectVia)
					GetSSHkeyInfo("SCPtoVirtualPC")
				ElseIf Not StringInStr($Customer_host,"VirtualPC") Then
					; IF NOT A VIRTUALPC CHOOSEN, THEN AN EXTRA HOP IS NEEDED. THE VIRTUALPC's ARE NOW REACHABLE DIRECTLY FROM THE ONDSWDL
					GetSSHkeyInfo($ConnectVia)
				EndIf
			Case $dRow[3] = "http"
				HideViaOptions()
				$ytop = $SSHytop
				$ConnectVia = $ConnectVia
				GUICtrlSetState($RadioWeb, $GUI_CHECKED)
				$Application = "WEB"
			Case $ConnectVia = "DameWare"
				HideViaOptions()
				$DameWarePC = GUICtrlRead($DameWarePC_ID)
				GetSSHkeyInfo($ConnectVia)
			Case $ConnectVia = "TTACVLAN"
				HideViaOptions()
				If (($Customer_host = $VirtualPCsPC2 OR $Customer_host = $VirtualPCsPC1 OR $Customer_host = $VirtualPCsPC3 OR $Customer_host = $VirtualPCsPC4) AND $Application = "SCP") Then
					GetSSHkeyInfo("Internet")
					GetSSHkeyInfo("SCPtoVirtualPC")
				EndIf
				If $SSHtunnels = "2" Then GetSSHkeyInfo($ConnectVia)
				$ytop = $SSHytop
			Case Else
				If $ConnectVia = "Internet" Then
					If $SSHtunnels <> "0" Then
						GetSSHkeyInfo("Internet")
						GetSSHkeyInfo("sdhswdl")
					EndIf
				EndIf
				If $ConnectVia = "sdhswdl" Then
					If $SSHtunnels <> "0" Then GetSSHkeyInfo($ConnectVia)
				EndIf
		EndSelect
		GUICtrlSetState($GObutton,$GUI_ENABLE)
		$GoState = "ENABLED"
		$ytop = $topHostInfo
		;$xtop = $WidthTreeView + $WidthConnectVia

		$HostInfo_ID = GUICtrlCreateGroup("Host info - " & StringLeft ($Customer, $WidthHostInfo-108) & ":", $leftHostInfo, $topHostInfo, $WidthHostInfo, $HeightHostInfo )
		;MsgBox(0,"Y hoogte",$ytop-20+225)
		$ytop=$ytop + 20
		$HostLabel = GUICtrlCreateLabel("Hostname:", $leftHostInfo+10, $ytop, 120)
		$ytop = $ytop + 15
		;GUICtrlSetState($JumpHostbutton, $GUI_SHOW)
		$Host_ID = GUICtrlCreateInput($dRow[13], $leftHostInfo+10,$ytop, $InputLength1, 20,BitOR($ES_READONLY, $ES_AUTOHSCROLL))
		$ytop = $ytop + 30
		$IP = $dRow[1]
		If $dRow[3] = "http" Then $IP = $dRow[7]
		If $dRow[3] = "ramses-KPN" Then
			$sIP = GetActiveIP($sHostname)
			ShowActiveGateway($sIP, $arrGW)
			$IP = $sTPAhl
		EndIf
		If $Application = "WebConsole" Then $IP = $WebConsoleIp
		If $Application = "LanConsole" Then $IP = $LanconsoleIP
		If $Application = "TelnetConsole" Then $IP = $TelnetconsoleIP

		;$ytop = $ytop+45
		$HostAddressLabel = GUICtrlCreateLabel("Host address:", $leftHostInfo+10, $ytop, 120)
		;$HostAddress_ID = GUICtrlCreateInput($IP, $xtop+10,$ytop+15, $InputLength1, 20,BitOR($ES_READONLY, $ES_AUTOHSCROLL))
		$HostAddress_ID = GUICtrlCreateInput($IP, $leftHostInfo+10,$ytop+15, $InputLength1, 20)
		;$ytop = $ytop+45
		$EmptyUser = ""
		If Not $dRow[4] Or Not $dRow[5] Then $EmptyUser = "YES"
		;MsgBox(0,"app",$Application)
		If ($Application = "GG" Or ($Application = "TV" And StringInStr($dRow[3],"tv")) Or $Application = "VNC") Then
			;If (($Application = "GG") Or $Application = "VNC" Or StringInStr($dRow[3],"tv")) Then

			;	_SQLite_QuerySingleRow($DBmem,"select GGversion from hosts where ServerId = '" & $dRow[0] & "'",$vers)
			;MsgBox(0,$Customer, $Customer_host)
			;If (StringInStr($dRow[3],"ux") Or StringInStr($dRow[3],"tv")) Then
				$ytop = $ytop+45

				$ver = ""
				Select
					Case $Application = "GG"
						;_SQLite_Query($DBmem,"select distinct GGVersion from hosts where GGVersion like '" & StringLeft($dRow[3],2) & "%'",$verQuery)
						;_SQLite_Query($DBmem,"select distinct GGVersion from hosts where GGVersion like '" & StringLeft($dRow[3],2) & "%'",$verQuery)
						_SQLite_Query($DBmem,"select distinct GGVersion from hosts where GGVersion like 'ux%'",$verQuery)
						If $Customer = "VirtualPCs" Then _SQLite_Query($DBmem,"select distinct GGVersion from hosts where GGVersion like 'win%'",$verQuery)
					Case $Application = "TV"
						_SQLite_Query($DBmem,"select distinct GGVersion from hosts where GGVersion like 'tv%'",$verQuery)
					Case $Application = "VNC"
						$ver = "5900|5901|5902|5903|5904|5905|5906|5907|5908|5909|5910"
						$uxversion = "vnc"
						;$vertype = "vnc"
				EndSelect

				While _SQLite_FetchData ($verQuery, $aRow) = $SQLITE_OK ;
					$vertype = $aRow[0]
					;$vertype = $dRow[3]
					$ver = $ver & "|" & $vertype
					;$ver = $vertype & "|" & $ver
				WEnd

				;MsgBox(0,$vertype,$ver)
				;If $Application = "VNC" Then
				;	$ver = "5900|5901|5902|5903|5904|5905|5906|5907|5908|5909|5910"
				;	$vertype = "vnc"
				;EndIf

				;If $hostid <> $oldhostid Then
				;	MsgBox(0,$hostid, $oldhostid)
				;	$vertype = $dRow[3]
				;	$ver = ""
				;EndIf

				;MsgBox(0,"Versions",$ver)
				;MsgBox(0,"Application",$Application)
				;If ($Application = "GG" ) Or $Application = "VNC" Or ($Application = "TV" And StringInStr($dRow[3],"tv")) Then
					;If ($Application = "GG" And StringInStr($dRow[3],"ux")) Or ($Application = "TV" And StringInStr($dRow[3],"tv")) Then

					;If $hostid <> $oldhostid Then
					;	$vertype = $dRow[3]
					;	;MsgBox(0,"Changed "  & $vertype & " - " & "new: " & $hostid, "old: " & $oldhostid & " 000     oooooooooooooooooooooooooooooo            000 ")

					;	$ver = $vertype
					;EndIf

					$ApplicationLabel1 = GUICtrlCreateLabel("Protocol",  $leftHostInfo+10, $ytop, 60)
					$ApplicationLabel2 = GUICtrlCreateLabel("( port/version):",  $leftHostInfo+10, $ytop+12, 70)
					$ApplicationVersion_ID = GUICtrlCreateCombo($uxversion,$leftHostinfo+90 ,$ytop+2,60,100 )
					;$ApplicationVersion_ID = GUICtrlCreateCombo($vertype,$leftHostinfo+90 ,$ytop+2,60,100 )
					;	If StringInStr($dRow[3],"ux") Then
					;MsgBox(0,"select GGversion from hosts where ServerId = '" & $dRow[0] & "'","bla")
					;_SQLite_QuerySingleRow($DBmem,"select GGversion from hosts where ServerId = '" & $dRow[0] & "'",$vers)
					;MsgBox(0,"version DBmem " & "ver=" & $ver & "***" & $vers[0] & " " & $dRow[0],"select Host from hosts where ServerId = " & $dRow[0] & "##")
					GUICtrlSetData($ApplicationVersion_ID, $ver,$uxversion)
					GUICtrlSetState($ApplicationVersion_ID,$GUI_FOCUS)
				;EndIf
				$ytop = $ytop-15

			;EndIf
		ElseIf ($Application = "rdp") Then
			$ytop = $ytop+45
			; If the VMWare VIrtualPC's can be reached directly via RDP (Like VirtualBox), then 3391-3393 can be added
			; See also SSH portforwarding RDPTun in LoadNMS function
			; See also the Stat Application function for name to port replacement.
			;$ver = "3391|3392|3393|VBox-UK"
			$ver = "VBox-UK"
			$ApplicationLabel1 = GUICtrlCreateLabel("Protocol",  $leftHostInfo+10, $ytop, 60)
			$ApplicationLabel2 = GUICtrlCreateLabel("( port/version):",  $leftHostInfo+10, $ytop+12, 70)
			$ApplicationVersion_ID = GUICtrlCreateCombo($uxversion,$leftHostinfo+84 ,$ytop+2,66,100 )
			GUICtrlSetData($ApplicationVersion_ID, $ver,$uxversion)
			GUICtrlSetState($ApplicationVersion_ID,$GUI_FOCUS)
		Else


			Select
				Case $Application = "SSH"
					$uxversion = "ssh"
				Case $Application = "SCP"
					$uxversion = "ssh"
				Case $Application = "ftp"
					$uxversion = "ftp"
				Case $Application = "Telnet"
					$uxversion = "telnet"
				Case $Application = "LanConsole"
					$uxversion = "telnet"
				Case $Application = "TelnetConsole"
					$uxversion = "telnet"
				Case $Application = "WebConsole"
					$uxversion = "http"
				;Case $Application = "WEB"
				;	$uxversion = "http"
			EndSelect


			$ytop = $ytop+45
			$ApplicationLabel1 = GUICtrlCreateLabel("Protocol",  $leftHostInfo+10, $ytop, 60)
			$ApplicationLabel2 = GUICtrlCreateLabel("( port/version):",  $leftHostInfo+10, $ytop+12, 70)
			;$ApplicationVersion_ID = GUICtrlCreateCombo($dRow[3],$leftHostinfo+90 ,$ytop+2,60,100 )
			;If $Application = "vnc" Then
			;	$ApplicationVersion_ID = GUICtrlCreateCombo("5900",$leftHostinfo+90 ,$ytop+2,60,100 )
			;	GUICtrlSetData($ApplicationVersion_ID, "5900|5901|5902|5903|5904|5905|5906|5907|5908|5909|5910", "5900")
			;Else
				$ApplicationVersion_ID = GUICtrlCreateInput($uxversion, $leftHostInfo+90,$ytop+2, 60, 20,BitOR($ES_READONLY, $ES_AUTOHSCROLL))
			;EndIf

			$ytop = $ytop-15
			;GUICtrlSetData(-1, $ver,$vers[0])
		EndIf

		If ($dRow[3] <> "http") Or ($dRow[3] = "http" And $dRow[4]) Then
			If Not $dRow[4] Then
				If StringInStr($dRow[3],"win") Or $dRow[3] = "nx" Then
					$UsernameLoad = $GGWinUser
				Else
					$UsernameLoad = $GGUser
				EndIf
			Else
				$UsernameLoad = $dRow[4]
			EndIf
			;Else
				;if ($dRow[3] = "win312" Or $dRow[3] = "win4") Then
				;	$UsernameLoad= $GGWINUser
				;Else
				;	$UsernameLoad = $dRow[4]
				;EndIf
			;EndIf
			;MsgBox(0,$UsernameLoad & " - " & $dRow[3],"##" & $GGWINuser & "## " & $GGUser & "  @@@")
			$ytop = $ytop+45
			$UserLabel = GUICtrlCreateLabel("Username:", $leftHostInfo+10,$ytop, 120)
			$User_ID = GUICtrlCreateInput($UsernameLoad, $leftHostInfo+10,$ytop+15, $InputLength1, 20)
			;If ($Application = "VNC" Or $Application = "RDP" ) Then
			If ($Application = "VNC") Then
				GUICtrlSetState($UserLabel, $GUI_HIDE)
				GUICtrlSetState($User_ID, $GUI_HIDE)
			EndIf

			$ytop = $ytop+45
			$PasswordLoad = $dRow[5]
			If $dRow[5] <> "" Then
				If $PassEncrypted = "1" Then $PasswordLoad = _StringEncrypt(0, $dRow[5], $EncryptPassword)
			Else
				;$PasswordLoad = $dRow[5]
				If $OldPassword And ($OldCustomerAndHost = $Customer & $Customer_host) Then $PasswordLoad = $OldPassword
			EndIf
			If $Application = "VNC" Then
				$VNC = "VNC "
				$l = 20
				;$PasswordLabel = GUICtrlCreateLabel($VNC & "Password: Show:", $xtop+10, $ytop, 110 )
			ElseIf $Application = "RDP" Then
				$VNC = "RDP "
				$l = 20
				;$PasswordLabel = GUICtrlCreateLabel($VNC & "Password: Show:", $xtop+10, $ytop, 110 )
			Else
				$VNC = ""
				$l = 0
				;$PasswordLabel = GUICtrlCreateLabel($VNC & "Password:        Show:", $xtop+10, $ytop, 104)
			EndIf
			$PasswordLabel = GUICtrlCreateLabel($VNC & "Password:", $leftHostInfo+10,$ytop, 104)
			GUICtrlDelete($ShowPasswd_ID)
			$ShowPasswdLabel = GUICtrlCreateLabel("show:", $leftHostInfo+10+$InputLength1-45, $ytop, 30)
			;$ShowPasswd_ID = GUICtrlCreateCheckbox("", $xtop+135, $ytop+19, 20, 20, $BS_RIGHT)
			$ShowPasswd_ID = GUICtrlCreateCheckbox("", $leftHostInfo+$InputLength1-4, $ytop, 15, 15, $BS_RIGHT)
			GUICtrlSetState($ShowPasswd_ID,$ShowPasswd)
			;MsgBox(0,"showpasswd",GUICtrlGetState($ShowPasswd_ID))
			$ShowPasswd = GUICtrlRead($ShowPasswd_ID)

			If ($ShowPasswd = 4 Or $ReadPW <> $EncryptPassword) Then
				GUICtrlDelete($Password_ID)
				$Password_ID = GUICtrlCreateInput($PasswordLoad, $leftHostInfo+10,$ytop+15, $InputLength1, 20,$ES_PASSWORD)
				sleep(200)
			EndIf
			If ($ShowPasswd = 1 And $ReadPW = $EncryptPassword) Then
				GUICtrlDelete($Password_ID)
				$Password_ID = GUICtrlCreateInput($PasswordLoad, $leftHostInfo+10,$ytop+15, $InputLength1, 20)
				sleep(200)
			EndIf
			$UseAsJumpHost_Group = GUICtrlCreateGroup("", $leftHostInfo+10, $ytop+40, $WidthHostInfo-20, 28)
			$UseHostAsHop_ID = GUICtrlCreateCheckbox("Use as Jump host.",$leftHostInfo+15,$ytop+48,$InputLength1-10,18)
			;GUISetState($UseHostAsHop_ID,$UseHostAsHop)
			$UseHostAsHop = GUICtrlRead($UseHostAsHop_ID)
			;If ($Application = "RDP") Then
		;		GUICtrlSetState($PasswordLabel, $GUI_HIDE)
		;		GUICtrlSetState($Password_ID, $GUI_HIDE)
		;	EndIf
		EndIf
	Else
		;MsgBox(0,"dfsdf","fdsdfsd")
	EndIf
EndIf
$LoadedItem = $item
EndFunc


Func GoNMS()
Local $Connected,$ggport,$telnetport, $IPnow, $GGnowUser, $GGnowPassword, $NMShost1, $tst1, $ParentHost1, $ParentHost_ID1,$ParentHost_ID2,$ParentHost2
Local $RASDIAL_Aventail_PID, $RAS_Aventail_Connected, $line, $file, $lineRAS, $l, $WriteToDB, $EncryptPasswd
Local $DBUpdateFile, $UpdateDBArray, $line, $DBUpdateFileTemp, $IPread, $RadioNewIP, $RadioEndIP, $GuiIP, $UseIPAnswer, $OKbutton, $IPmsg
$item = GUICtrlRead($treeview)
$nlsdh1_pass = GUICtrlRead($nlsdh1_passID)
$VPC_pass = GUICtrlRead($VPC_passID)
$DameWarePC = GUICtrlRead($DameWarePC_ID)


;MsgBox(0,"Items", $Item & " and " & $LoadedItem)
;MsgBox(0,"

;MsgBox(0,"uxversion: ", $uxversion)
;MsgBox(0,"other info: ", $HostA

If $Item = $LoadedItem Then
	$ApplicationVersion = GUICtrlRead($ApplicationVersion_ID)
Else
	$ApplicationVersion = $uxversion
EndIf

$VirtualPC = GUICtrlRead($VirtualPC_ID)
;MsgBox(0,"VirtualPC",$VirtualPC)
$UseHomeGW = GuiCtrlRead($UseHomeGW_ID)
$GGPassword = GuiCtrlRead($Password_ID)
$OldPassword = $GGPassword
$OldCustomerAndHost = $Customer & $Customer_host
$IPread = GuiCtrlRead($HostAddress_ID)
$GGUser = GuiCtrlRead($User_ID)
$version = $ApplicationVersion
;MsgBox(0,"version in GONMS",$version)
If ($version == 0) Then $version = $dRow[3]
_SQLite_QuerySingleRow($DBmem,"SELECT connected from hosts where hostid = '" & $item & "'",$hQuery4)
$Connected = $hQuery4[0]
$AllSessionPIDs = $AllSessionPIDs & $SessionPIDS
;MsgBox(0,$SessionPIDS, $AllSessionPIDs)
$SessionPIDS = ""
$ftpgw = ""
$RetryAnswer = "0"
If ($item = 0 or not $dRow[0]) Then
	MsgBox(64, "Nothing selected.", "No item currently selected")
	sleep(200)
Else
	$text = GUICtrlRead($item, 1) ; Get the text of the treeview item
	$state = GUICtrlRead($item)
	If $text == "" Then
		MsgBox(16, "Error", "Error while retrieving info about item")
	Else
		$NMShost1 = GUICtrlRead($item,1)
		$tst1 = _GUICtrlTreeView_GetParentParam($TreeView,$item)
		$ParentHost_ID1 = _GUICtrlTreeView_GetParentParam($TreeView, $tst1)
		$ParentHost_ID2 = _GUICtrlTreeView_GetParentParam($TreeView, $ParentHost_ID1)
		$ParentHost1 = GuiCtrlRead($ParentHost_ID2,1)
		$ParentHost2 = GuiCtrlRead($ParentHost_ID1,1)

		;If ($dRow[4] <> $GGUser) Or ($PasswordLoad <> $GGPassword) Or ($dRow[3] <> $version) Then
		If ($dRow[4] <> $GGUser) Or ($PasswordLoad <> $GGPassword) Then
		;If ($EmptyUser And ($GGUser or $GGPassword)) Then
			$WriteToDB = MsgBox(4,"Write data to database for " & $NMShost1 & ".","Write username/password/appversion to database ?")
			if $WriteToDB = "6" Then
				;MsgBox(0,"writing","update server set user = '" & $GGUser & "' where id = '" & $dRow[0] & "'")
				;$GGDB = _SQLite_Open($SQliteDB)
				$EncryptPasswd = $GGPassword
				If $PassEncrypted = "1" Then $EncryptPasswd = _StringEncrypt(1, $GGPassword, $EncryptPassword)
				If StringInStr($version,"ux") Then
					; Only ux version is allowed to be changed here.
					_SQLite_Exec($GGDB,"update server set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "', vertyp = '" & $version & "' where id = '" & $dRow[0] & "' and hostname = '" & $NMShost1 & "'")
					_SQLite_Exec($DBmem,"update hosts set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "', GGversion = '" & $version & "' where hostid = '" & $item & "'")
				Else
					_SQLite_Exec($GGDB,"update server set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "' where id = '" & $dRow[0] & "' and hostname = '" & $NMShost1 & "'")
					_SQLite_Exec($DBmem,"update hosts set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "' where hostid = '" & $item & "'")

				EndIf
				_SQLite_Exec($GGDB,"update comments set autor = '[" & $GGWINUser & "]', datum = '" & _Now() & "' where id = '1001'")
				;_SQLite_Close($GGDB)
				;FileDelete($UpdateUserPasswd_DB & "_tmp")
				$DBUpdateFileTemp = FileOpen($UpdateUserPasswd_DB & "_tmp",2)

				$DBUpdateFile = FileOpen($UpdateUserPasswd_DB,0)
				If $DBUpdateFile <> -1 Then
	;FileWrite($DBUpdateFile, $SQliteDB & ";" & $DBCountry & ";" & $DBid & ";" & "update server set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "' where id = '" & $dRow[0] & "' and hostname = '" & $NMShost1 & "'" & @CRLF)

	;$file = FileOpen ( $DBUpdateFile, 0 )
				While 1
					$line = FileReadLine($DBUpdateFile)
					If (@error = -1) Then ExitLoop
					;MsgBox(0,"line",$line)

					$UpdateDBArray = StringSplit($line,";")
					;MsgBox(0,"array",$UpdateDBArray[2] & " ## " & $UpdateDBArray[3] & " ## " & $UpdateDBArray[4] & " ## " & $UpdateDBArray[5])
					If ($UpdateDBArray[4] <> $Customer Or $UpdateDBArray[5] <> $NMShost1) Then
						;MsgBox(0,"Not selected now, so copy to temp",$line)
						FileWriteLine($DBUpdateFileTemp,$line)
					EndIf

			;MsgBox(0," "," ")
					;	_SQLite_Exec($GGDB,$UpdateDBArray[4])
					;EndIf

		;MsgBox(0, "Line read:", $line)
				Wend
				FileClose($DBUpdateFile)
				EndIf

				FileDelete($UpdateUserPasswd_DB)
				;FileClose($DBUpdateFileTemp)

				FileWrite($DBUpdateFileTemp, $SQliteDB & ";" & $DBCountry & ";" & $DBid & ";" & $Customer & ";" & $NMShost1 & ";" & $GGUser & ";" & $EncryptPasswd & ";" & "update server set user = '" & $GGUser & "', password = '" & $EncryptPasswd & "' where id = '" & $dRow[0] & "' and hostname = '" & $NMShost1 & "'" & @CRLF)
				FileClose($DBUpdateFileTemp)
				sleep(300)
				FileMove($UpdateUserPasswd_DB & "_tmp",$UpdateUserPasswd_DB)
			EndIf
		EndIf

		If ($ParentHost1 = "RAMSES" or $ParentHost2 = "RAMSES") Then
			;If FileExists($TEMPDIR & "rasAventail.txt") Then FileDelete($TEMPDIR & "rasAventail.txt")
			;$RASDIAL_Aventail_PID = RunWait(@ComSpec & ' /c ' & "rasdial.exe " & ' > ' & $TEMPDIR & 'rasAventail.txt',"",@SW_HIDE)

			;for $t = 1 to $RASDIAL_TIMEOUT
			;	If (FileExists($TEMPDIR & "rasAventail.txt") AND FileGetSize($TEMPDIR & "rasAventail.txt") > 0) Then ExitLoop
			;Next
			;$lineRAS = ""
			;$file = FileOpen($TEMPDIR & "rasAventail.txt", 0)

			;$lineRAS = FileReadLine($file,2)
			;StringStripCR ( $lineRAS )
			;FileClose($file)
			;If StringInStr($lineRAS,"RAMSES") Then $Aventail_DialUp = $lineRAS

			;MsgBox(0,$ParentHost1,$ParentHost2)
			;MsgBox(0,$Customer, $Customer_host)

			If $Customer_host = "VPN_Login" Then
				$CaptivePortal = "TRUE"
			EndIf
			If StringInStr($Customer_host,"Start_RAMSES") And $CaptivePortal = "FALSE" Then
				MsgBox(0,"RAMSES Captive WebPortal","Be sure you logged into the RAMSES Captive WebPortal first!" _
				& @CRLF & "The portal link: https://ramses-portal.alcatel-lucent.com/ ")

			EndIf
			;;$lineRAS = CheckRAMSESConnection()
			;;;MsgBox(0,"Aventail",$lineRAS)
			;;If (StringInStr($lineRAS,"Aventail VPN Connection") = 0 And StringInStr($lineRAS,"RAMSES",0) = 0 And Not ProcessExists("ngmonitor.exe")) Then
			;;	MsgBox(48,"No Aventail VPN Connection !","Setup an Aventail VPN Connection before proceeding !" & @CRLF & "               Press OK only when ready !               ")
			;;EndIf
			;MsgBox(0,"text",$lineRAS)
		EndIf
		If $IP = "Henk1" Then
;;		If $version = "http" Then
;;			MsgBox(0,"http", $dRow[7])
		  ;$HTTPPID = Run("""" & $HTTPDIR & " """ & $dRow[7],"")
;;		  $HTTPPID = Run("""" & $HTTPDIR & " """ & $IP,"")
	  ;ElseIf StringInStr($dRow[3],"tv") Then
		;  MsgBox(0,$Application,"test " & $TVDIR)
			;run($TVDIR)
		Else

			;MsgBox(0,"SSHTunnels",$SSHtunnels)
			;$SCPprivateKey = ""
			;If (StringInStr($Customer_host,"VirtualPC")) Then $SCPprivateKey = " /privatekey=" & """" & $SSHprivKey_VPC & """"
			Select
				; CONNECT VIA ALCANET NL
				case ($ConnectVia = "sdhswdl" or ($ConnectVia = "slsvho" And $SSHtunnels = "0"))
				; CONNECT VIA ALCANET NL
				;dRow[8]=<tunnel>
					If $SSHtunnels = "0" Then
					; NO TUNNELS; DIRECT START APPLICATION.
						Select
							Case $Application = "GG"
								$AppPort = "491"
							Case ($Application = "SSH" Or $Application = "SCP")
								$AppPort = 49000-22000+22
							Case $Application = "Telnet"
								$AppPort = 49000-23000+23
							Case $Application = "ftp"
								$AppPort = 49000-21000+21
							Case $Application = "WEB"
								$AppPort = 49000-8000+80
							Case $Application = "LanConsole"
								$AppPort = 49000-23025+23
							Case $Application = "WebConsole"
								$AppPort = 49000-8080+80
							Case $Application = "TelnetConsole"
								$AppPort = 49000-23023+23
							Case $Application = "VNC"
								$AppPort = 49000-59000+5900
							Case $Application = "RDP"
								$AppPort = 49000-33890+3389
							Case $Application = "NX"
								$AppPort = 49000-24200
						EndSelect
						if $version = "ramses" Then
							_SQLite_Query($GGDB,"SELECT Id, hostname, serverip, uxversion, ggport, telnetport, ftpport, ftpgw, sshport from ramses where Id = '" & $dRow[0] & "'",$hQuery4)
							While _SQLite_FetchData ($hQuery4, $eRow) = $SQLITE_OK
								$IP = $eRow[2]
								$uxversion = $eRow[3]
								$ggport = $eRow[4]
								$telnetport = $eRow[5]
								$ftpport = $eRow[6]
								$ftpgw = "@" & $eRow[7]
								$SSHport = $eRow[8]
							WEnd

							If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"Ramses","UX: " & $uxversion & " GGport: " & $ggport & " Telnetport: " & $telnetport & " GW: " & $ftpgw)
							Select
								Case $Application = "GG"
									$AppPort = $ggport
								Case ($Application = "SSH" Or $Application = "SCP")
									$AppPort = 49000-22000 + $SSHport
									;$AppPort = $ftpport
								Case ($Application = "ftp")
									$AppPort = 49000-21000+$ftpport
								Case $Application = "Telnet"
									$AppPort = 49000-23000+$telnetport
							EndSelect
						EndIf
						If $version = "ramses-KPN" Then
							;MsgBox(0,"KPN",$Application & " " & $Customer & " " & $IP & " " & $AppPort & " " & $dRow[0] & " " & $version & " " & $GGUser & " " & $GGPassword & " " & $SSHport & " " & $IPread & " " & $UseHostAsHop)
							$RamsesActive = CheckRAMSESActive()
							If $RamsesActive = "FALSE" Then
								WinWaitActive("Authentication","",30)
								MsgBox(48,"Login to Ramses","Please login into RAMSES and choose " & $Customer & " and open the connection.")
								WinActivate("Login to Ramses")
								If WinActive("RAMSES v") Then
									sleep(1500)
									SetInfoText("Please login into RAMSES, choose " & $Customer & " and open the connection.")
									WinActivate("Login to Ramses")
								EndIf
								Return
							EndIf
							OnCorrectURL()
						Else
							StartApplication($Application,$Customer,$IP,$AppPort,$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)
						EndIf
						;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
					Else
						; THERE ARE TUNNELS (SSH HOPS) TO TAKE, GOING VIA SWDL.
						;If $SwdlPID = "0" Then SSHviaSwdl()
						;MsgBox(0,"Customerhost",$Customer_host)
						$IPnow = "localhost"
						$AppPort = $dRow[0]
						$GGnowUser = $GGUser
						$GGnowPassword = $GGPassword
						;MsgBox(0,"CustomerHost",$Customer_host)
						If StringInStr($Customer_host,"VirtualPC") Then
							;DIRECT ROUTING TO VPNHOSTPC's IS POSSIBLE FROM THE ONDSWDL, SO GG FORWARDING CAN BE DONE AT THE ONDSWDL.
							SSHviaSwdlNew()
						Else
							;NEED ONE EXTRA SSH HOP TO NLSDH1 AND THERE FORWARD MY GG PORTS.
							SSHviaSwdl()


							;MsgBox(0,"Connected", $Connected)
							If ProcessExists($Connected) = "0" Then
								If ($SSHtunnels = "2" or $SSHtunnels = "3") or (($Customer_host = $VirtualPCsPC2 OR $Customer_host = $VirtualPCsPC1 OR $Customer_host = $VirtualPCsPC3 OR $Customer_host = $VirtualPCsPC4 ) AND $Application = "SCP") Then
									If ($Customer_host = $VirtualPCsPC2 OR $Customer_host = $VirtualPCsPC1 OR $Customer_host = $VirtualPCsPC3 OR $Customer_host = $VirtualPCsPC4) Then

										SSHtunnelCust($SSHlport2,"-L " & $SSHport & ":" & $IP & ":22",$Customer,"127.0.0.1")
										;MsgBox(0,"Just out",$RetryAnswer)
									Else
										SSHtunnelCust($SSHlport2,"-L 2223:" & $dRow[9] & ":22",$Customer,"127.0.0.1")
									EndIf
									If ($Customer_host = $VirtualPCsPC2 OR $Customer_host = $VirtualPCsPC1 OR $Customer_host = $VirtualPCsPC3 OR $Customer_host = $VirtualPCsPC4) Then
										If $Customer_host = $VirtualPCsPC2 Then
											$TunnelVPCs = " -L " & $dRow[0] & ":" & $IP & ":491" & " -L 22154:10.0.0.104:22 -L 22155:10.0.0.105:22 -L 22156:10.0.0.106:22"
										ElseIf $Customer_host = $VirtualPCsPC1 Then
											$TunnelVPCs = " -L " & $dRow[0] & ":" & $IP & ":491" & " -L 22151:10.0.0.101:22 -L 22152:10.0.0.102:22 -L 22153:10.0.0.103:22"
										ElseIf $Customer_host = $VirtualPCsPC4 Then
											$TunnelVPCs = " -L " & $dRow[0] & ":" & $IP & ":491" & " -L 22160:10.0.0.110:22 -L 22161:10.0.0.111:22 -L 22162:10.0.0.112:22"
										Else
											$TunnelVPCs = " -L " & $dRow[0] & ":" & $IP & ":491" & " -L 22157:10.0.0.107:22 -L 22158:10.0.0.108:22 -L 22159:10.0.0.109:22"
										EndIf
										;MsgBox(0,"Tunnelstring",$TunnelVPCs)
										;MsgBox(0,"Appport",$AppPort)
										OpenVPNHostPC($SSHport,"127.0.0.1",$TunnelVPCs,$Customer)
										$IPnow = "localhost"
										$GGnowUser = "alcatel"
										$GGnowPassword = "@lcatel12"
										Select
											Case $VirtualPC = "10.0.0.101"
												$AppPort = "49151"
											Case $VirtualPC = "10.0.0.102"
												$AppPort = "49152"
											Case $VirtualPC = "10.0.0.103"
												$AppPort = "49153"
											Case $VirtualPC = "10.0.0.104"
												$AppPort = "49154"
											Case $VirtualPC = "10.0.0.105"
												$AppPort = "49155"
											Case $VirtualPC = "10.0.0.106"
												$AppPort = "49156"
											Case $VirtualPC = "10.0.0.107"
												$AppPort = "49157"
											Case $VirtualPC = "10.0.0.108"
												$AppPort = "49158"
											Case $VirtualPC = "10.0.0.109"
												$AppPort = "49159"

										EndSelect
									else

										SSHviaEssentGateway("2223","127.0.0.1",$Tunnelstring,$Customer)
									EndIf
								Else
									SSHtunnelCust($SSHlport2,$Tunnelstring,$Customer,"127.0.0.1")
								EndIf
							EndIf
						EndIf
						;MsgBox(0,"StartApp via sdhsswdl and SSHTunnels",$Customer_host & " -- " & $SSHTunnels)
						StartApplication($Application,$Customer,$IPnow,$AppPort,$dRow[0],$version,$GGnowUser,$GGnowPassword,$SSHport,$IPread,$UseHostAsHop)
						;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
					EndIf

				case $ConnectVia = "slsvho" And $SSHtunnels <> "0"
				; CONNECT VIA ALCANET DE
					If $DBCountry = "DE_LAB" Then
						SSHviaSlsvhoNew()
						$IPnow = "localhost"
						$AppPort = $dRow[0]
						$GGnowUser = $GGUser
						$GGnowPassword = $GGPassword
						StartApplication($Application,$Customer,$IPnow,$AppPort,$dRow[0],$version,$GGnowUser,$GGnowPassword,$SSHport,$IPread,$UseHostAsHop)
					Else
						SSHviaSlsvho()
						;MsgBox(0,"SSHport for App tunneling", $SSHport)
						If ProcessExists($Connected) = "0" Then	SSHtunnelCust($SSHlport2,$Tunnelstring,$Customer,"127.0.0.1")
						;SSHtunnelCust($SSHport," -L 49490:62.40.120.53:491",$Customer,"127.0.0.1")
						StartApplication($Application,$Customer,"localhost",$dRow[0],$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)
					;	If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
					EndIf
				Case $ConnectVia = "Internet"
				; CONNECT VIA INTERNET
				    ;MsgBox(0,"# tunnels",$SSHtunnels)
					If $SSHtunnels = "0" Then
						;MsgBox(0,"VPC tunnel 0", $IP)
						Select
							Case $Application = "GG"
								$AppPort = "491"
							Case ($Application = "SSH" Or $Application = "SCP")
								$AppPort = 49000-22000+22
							Case $Application = "Telnet"
								$AppPort = 49000-23000+23
							Case $Application = "WEB"
								$AppPort = 49000-8000+80
							Case $Application = "LanConsole"
								$AppPort = 49000-23025+23
							Case $Application = "WebConsole"
								$AppPort = 49000-8080+80
							Case $Application = "TelnetConsole"
								$AppPort = 49000-23023+23
							Case $Application = "VNC"
								$AppPort = 49000-59000+5900
							Case $Application = "RDP"
								$AppPort = 49000-33890+3389
							Case $Application = "NX"
								$AppPort = 49000-24200+2222
						EndSelect
						;MsgBox(0,"Going to start application SSHtunnels = 0", $Application & " " & $Customer & " " & $IP  & " " & $AppPort & " " & $dRow[0] & " " & $dRow[3] & " " & $GGUser & " " & $GGPassword)
						StartApplication($Application,$Customer,$IP,$AppPort,$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)
						;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
					Else
						SSHviaInternet()
						If ($version <> "win312" And $version <> "win4" And $version <> "nx" And $version <> "rdp") Then
							;MsgBox(0,"not win and nx", $version)
							If ProcessExists($Connected) = "0" Then
							;If $Customer = "Ziggo-Essent" Then
								If ($SSHtunnels = "2" or $SSHtunnels = "3") Then
									SSHtunnelCust($SSHlport2,"-L 2223:" & $dRow[9] & ":22",$Customer,"127.0.0.1")
									SSHviaEssentGateway("2223","127.0.0.1",$Tunnelstring,$Customer)
								Else
									SSHtunnelCust($SSHlport2,$Tunnelstring,$Customer,"127.0.0.1")
								EndIf
							EndIf
							StartApplication($Application,$Customer,"localhost",$dRow[0],$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)
							;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
						Else
								StartApplication($Application,$Customer,"localhost",$dRow[0],$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)

						EndIf
					EndIf
					;RunGOGlobal($Customer,"localhost",$dRow[0],$dRow[3],$dRow[4],$dRow[5])

				Case $ConnectVia = "TTACVLAN"
				; CONNECT VIA TTAC-VLAN
					$IPnow = $IP
					Select
						Case $SSHtunnels = "3"
							If ProcessExists($Connected) = "0" Then
								SSHviaEssentGateway("22",$dRow[9],$Tunnelstring,$Customer)
							EndIf
							StartApplication($Application,$Customer,"localhost",$dRow[0],$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)
							;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
						Case $SSHtunnels = "2"
							If ProcessExists($Connected) = "0" Then
								;MsgBox(0,"going to SSHtunnelCust", $Customer)
								SSHtunnelCust("22","-L 2223:" & $dRow[9] & ":22",$Customer,$nlsdh1)
								SSHviaEssentGateway("2223","127.0.0.1",$Tunnelstring,$Customer)
							EndIf
							StartApplication($Application,$Customer,"localhost",$dRow[0],$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)
							;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
						Case Else
							$GGnowUser = $GGUser
							$GGnowPassword = $GGPassword
							Select
								Case $Application = "GG"
									$AppPort = "491"
								Case ($Application = "SSH" Or $Application = "SCP")
									If ($Customer_host = $VirtualPCsPC2 OR $Customer_host = $VirtualPCsPC1 or $Customer_host = $VirtualPCsPC3 or $Customer_host = $VirtualPCsPC4) Then
										If $Customer_host = $VirtualPCsPC2 Then
											$TunnelVPCs = " -L 22154:10.0.0.104:22 -L 22155:10.0.0.105:22 -L 22156:10.0.0.106:22"
										ElseIf $Customer_host = $VirtualPCsPC1 Then
											$TunnelVPCs = " -L 22151:10.0.0.101:22 -L 22152:10.0.0.102:22 -L 22153:10.0.0.103:22"
										ElseIf $Customer_host = $VirtualPCsPC4 Then
											$TunnelVPCs = " -L 22160:10.0.0.110:22 -L 22161:10.0.0.111:22 -L 22162:10.0.0.112:22"
										Else
											$TunnelVPCs = " -L 22157:10.0.0.107:22 -L 22158:10.0.0.108:22 -L 22159:10.0.0.109:22"
										EndIf
									;	OpenVPNHostPC("22",$dRow[1],$TunnelVPCs,$Customer)
									;	$IPnow = "localhost"
									;	$GGnowUser = "alcatel"
									;	$GGnowPassword = "@lcatel12"
										Select
											Case $VirtualPC = "10.0.0.101"
												$AppPort = "49151"
											Case $VirtualPC = "10.0.0.102"
												$AppPort = "49152"
											Case $VirtualPC = "10.0.0.103"
												$AppPort = "49153"
											Case $VirtualPC = "10.0.0.104"
												$AppPort = "49154"
											Case $VirtualPC = "10.0.0.105"
												$AppPort = "49155"
											Case $VirtualPC = "10.0.0.106"
												$AppPort = "49156"
											Case $VirtualPC = "10.0.0.107"
												$AppPort = "49157"
											Case $VirtualPC = "10.0.0.108"
												$AppPort = "49158"
											Case $VirtualPC = "10.0.0.109"
												$AppPort = "49159"
										EndSelect
									Else
										$AppPort = 49000-22000+22
									EndIf
									;If $DEBUG Then MsgBox(0,"AppPort", $AppPort)
								Case $Application = "Telnet"
									$AppPort = 49000-23000+23
								Case $Application = "WEB"
									$AppPort = 49000-8000+80
								Case $Application = "LanConsole"
									$AppPort = 49000-23025+23
								Case $Application = "WebConsole"
									$AppPort = 49000-8080+80
								Case $Application = "TelnetConsole"
									$AppPort = 49000-23023+23
								Case $Application = "VNC"
									$AppPort = 49000-59000+5900
								Case $Application = "RDP"
									$AppPort = 49000-33890+3389
								Case $Application = "NX"
									$AppPort = 49000-24200+2222
							EndSelect
							StartApplication($Application,$Customer,$IPnow,$AppPort,$dRow[0],$version,$GGnowUser,$GGnowPassword,$SSHport,$IPread,$UseHostAsHop)
							;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)
					EndSelect

				Case $ConnectVia = "DameWare"
				; CONNECT VIA DAMEWARE PC's ANTWERP
					SSHviaDameWare($Tunnelstring,$Customer)
					StartApplication($Application,$Customer,"localhost",$dRow[0],$dRow[0],$version,$GGUser,$GGPassword,$SSHport,$IPread,$UseHostAsHop)
					;If $UseHostAsHop Then TunnelviaNMS($SSHport,$IPread,$dRow[3],$GGUser,$GGPassword)

			EndSelect
		EndIf
		GUICtrlSetState($GObutton, $GUI_DISABLE)
	EndIf
EndIf
EndFunc ; GoNMS


Func show($sid,$TreeItem,$ParentTreeItem)
Local $aRow, $hQuery1, $hostname, $ServerId, 	$ServerIP, $GGversion, $User, $Password, $TelnetConsole, $WebConsole,$Tunnel, $TunnelIP, $Guiname
Local $NMShostid, $NMShost, $lport, $CustomerId, $DQuery, $tst, $tst2, $tst3, $tst22, $ParentHost, $ParentHost_ID, $comQuery, $NMtyp, $NMrelease
	if $sid Then
		_SQLite_Query($GGDB, $SQLquery_server & $sid & "'",$hQuery1)
		_SQLite_QuerySingleRow($GGDB,"SELECT comment from comments where serverid = '" & $sid & "'",$comQuery)
		;MsgBox(0,"SELECT comment from comments where serverid = '" & $sid & "'",$comQuery[0])



		While _SQLite_FetchData ($hQuery1, $aRow) = $SQLITE_OK ;
					$hostname = $aRow[1]
					$Guiname = $aRow[2]
					$ServerId = $aRow[0]
					$ServerIP = $aRow[4]
					$GGversion = $aRow[12]
					$User = $aRow[10]
					$Password = $aRow[11]
					$TelnetConsole = $aRow[7]
					$NMtyp = $aRow[8]
					$NMrelease = $aRow[9]
					$WebConsole = $aRow[5]
					$Tunnel = $aRow[14]
					$TunnelIP = $aRow[16]
					$Lanconsole = $aRow[17]
					$DameWareHostIP = ""
					If $ConnectVia = "DameWare" Then
						_SQLite_QuerySingleRow($GGDB,"SELECT IP from dameware where id = " & $ServerId,$DQuery)
						;MsgBox(0,"IP of Dameware","SELECT IP from dameware where id = " & $ServerId)
						$ServerIP = $DQuery[0]
						$DameWareHostIP = $DQuery[0]
						;MsgBox(0,"IP " & $hostname & " " & $ServerId,$DameWareHostIP)
					EndIf
					$lport = $aRow[15]
					If $ServerId < 49000 Then $ServerId = $ServerId + 49000
		WEnd
		$NMShostid = GUICtrlCreateTreeViewItem($hostname,$TreeItem)

		$NMShost = GUICtrlRead($NMShostId,1)
		$tst = _GUICtrlTreeView_GetParentParam($TreeView,$NMShostid)
		$ParentHost_ID = _GUICtrlTreeView_GetParentParam($TreeView, $tst)

		$ParentHost = GuiCtrlRead($ParentHost_ID,1)
		$nn=0
		GetCustomer($NMShostId)
		$Customer = $Custmr[3]
		;MsgBox(0,$Customer, _GUICtrlTreeView_GetText($TreeView, _GUICtrlTreeView_GetNext($TreeView, $CustmrId[3]) ))

		$CustomerId = $CustmrId[3]
		;If (($ConnectVia <> "DameWare" And Not $ServerIP) And $Customer <> "VPN_Customers") Then GUICtrlSetColor($CustomerId, 0xD0D0D0)
		If ($ConnectVia = "DameWare" Or $ConnectVia = "TTACVLAN" Or $ConnectVia = "Internet") And $Customer = "ALU_LABs" Then GUICtrlSetColor($CustomerId, 0x8080FF)
		;If ($ConnectVia = "DameWare" Or $ConnectVia = "TTACVLAN") And $Customer = "ALU_LAB" Then GUICtrlSetColor($NMShostid, 0xD0D0D0)
		If ($ConnectVia = "DameWare" And Not $DameWareHostIP) Then GUICtrlSetColor($CustomerId, 0xD0D0D0)
		;MsgBox(0,"show DBCountry en AlcanetGW",$DBCountry & "," & $AlcanetGW)
		If ($DBCountry = "DE_NOC" AND ($AlcanetGW = $AlcanetGWNL Or $ConnectVia = "Internet" or $ConnectVia = "TTACVLAN")) Then
			;If $DEBUG Then MsgBox(0,"Setting tunnels in DB " & $DBCountry,"Connecting via " & $ConnectVia & " and gateway = " & $AlcanetGW)
			If ($Tunnel = "1" and $lport = "0") Then
				$Tunnel = "2"
				$TunnelIP = $nautilus
			EndIf
			If ($Tunnel = "2" and $lport <> "0") Then
				$Tunnel = ""
				$TunnelIP = ""
			EndIf
		EndIf
		If (($ConnectVia <> "Internet" And $ConnectVia <> "slsvho" And $ConnectVia <> "sdhswdl") And StringInStr($GGversion,"tv")) Then GUICtrlSetColor($ParentHost_ID, 0xD0D0D0)
		;If (($ConnectVia = "Internet") And StringInStr($GGversion,"tv")) Then GUICtrlSetColor($ParentHost_ID, 0xFFD0D0)

		If ($DBCountry = "NL" AND ($ConnectVia = "Internet" or $ConnectVia = "TTACVLAN") AND $ParentHost = "ALU_LAB_Antwp") Then GUICtrlSetColor($ParentHost_ID, 0xD0D0D0)
		If ($DBCountry = "NL" AND ($ConnectVia = "Internet" or $ConnectVia = "TTACVLAN") AND $ParentHost = "RAMSES") Then GUICtrlSetColor($ParentHost_ID, 0xD0D0D0)
		If ($DBCountry = "NL" AND $ConnectVia = "TTACVLAN" AND $ParentHost = "WebPortals") Then GUICtrlSetColor($ParentHost_ID, 0xD0D0D0)
		If ($DBCountry = "NL" AND $ConnectVia = "Internet" AND $ParentHost = "ALU_LAB_Hfd") Then
			If $Tunnel = "0" Then $Tunnel = "1"
		EndIf
		_SQLite_Exec($DBmem,"INSERT INTO hosts (ServerId,CustId,Customer,HostId,Host,ServerIP,GGversion,User,Password,TelnetConsole,WebConsole,tunnel,tunnelip,lanconsole,DameWareIP,Comment,NMtyp,NMRelease) values ('" & $ServerId & "','" & $treeItem & "','" & $Customer & "','" & $NMShostId & "','" & $hostname & "','" & $ServerIP & "','" & $GGversion & "','" & $User & "','" & $Password & "','" & $TelnetConsole & "','" & $WebConsole & "','" & $Tunnel & "','" & $TunnelIP & "','" & $Lanconsole & "','" & $DameWareHostIP & "','" & $comQuery[0] & "','" & $NMtyp & "','" & $NMrelease & "') ;")

		;ViewDB()
	EndIf
EndFunc


Func tree ($id, $name, $link, $ebene, $typ, $vorebene, $pos,$x,$TreeItem)
Local $i, $n, $NextTreeItem, $ServerTreeItem
Local $newid[1000], $newname[1000], $newlink[1000], $newtyp[1000]
For $i = 0 To $x
	If $ebene = "treeMenu" Then
	EndIf
	If $typ[$i] = "server" Then
		$ServerTreeItem = GUICtrlCreateTreeViewItem($name[$i],$TreeItem)
		;$ServerTreeItem = GUICtrlCreateTreeViewItem($name[$i],$TreeView)
		show($id[$i],$ServerTreeItem,$TreeItem)
		;show($id[$i],$ServerTreeItem,$TreeView)
	Else
		If $typ[$i] <> "dialin" Then
			_SQLite_Query($GGDB,"SELECT * from tree where parentid = '" & $id[$i] & "' order by id",$hQuery2)
			;_SQLite_Query($GGDB,"SELECT * from tree where parentid = '" & $id[$i] & "'",$hQuery2)
			$n = 0
			While _SQLite_FetchData ($hQuery2, $bRow) = $SQLITE_OK ;
				$newid[$n] = $bRow[0]
				$newname[$n] = $bRow[2]
				$newlink[$n] = $bRow[3]
				$newtyp[$n] = $bRow[4]
				;$ebene = "treeMenu"
				$n =$n + 1;
			WEnd
			If $newid[0] Then
				$NextTreeItem = GUICtrlCreateTreeViewItem($name[$i],$TreeItem)
				;$NextTreeItem = GUICtrlCreateTreeViewItem($name[$i],$TreeView)
				If $ebene = "treeMenu" Then
					GUICtrlSetState($NextTreeItem, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))
					GUICtrlSetColor($NextTreeItem, 0x0000C0)
					;MsgBox(0,"before delete from hosts","dsfsdf")
					_SQLite_Exec($DBmem,"delete from hosts where ServerId = '" & $id[$i] & "'")
					_SQLite_Exec($DBmem,"UPDATE hosts set CustId = '" & $NextTreeItem & "' where ServerId = '" & $id[$i] & "'")
				Else
					GUICtrlSetState($NextTreeItem, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))
					GUICtrlSetColor($NextTreeItem, 0x040404)
				EndIf
			EndIf
			If $newid[0] Then tree($newid, $newname, $newlink, $name[$i], $newtyp, "blank", "blank",$n-1,$NextTreeItem)
			_ArrayDelete($newid,1000)
			_ArrayDelete($newname,1000)
			_ArrayDelete($newlink,1000)
		EndIf
	EndIf
Next
EndFunc


Func MyMenu($rootId)
Local $id[1000], $name[1000], $link[1000], $typ[1000], $ebene, $ParentName
;$treeview = GUICtrlCreateTreeView(6, 6, 160, 300, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE)
;_SQLite_Exec($DBmem,"DELETE FROM hosts;")
_SQLite_QuerySingleRow($GGDB,"SELECT name from tree where id = '" & $rootId & "'",$hQuery3)
$ParentName = $hQuery3[0]

$AllCustomers = GUICtrlCreateTreeViewItem($ParentName, $treeview)
	_SQLite_Query($GGDB,"SELECT * from tree where parentid = '" & $rootId & "' order by name",$hQuery3)
	;MsgBox(0,"sql","SELECT * from tree where parentid = '" & $rootId & "' order by name")
				$x = 0
				While _SQLite_FetchData ($hQuery3, $cRow) = $SQLITE_OK ;

					$id[$x] = $cRow[0]
					$name[$x] = $cRow[2]
					$link[$x] = $cRow[3]
					$typ[$x] = $cRow[4]
					$ebene = "treeMenu"
					$x =$x + 1;

				WEnd
				;MsgBox(0,"nr items", $x)
	tree($id, $name, $link, $ebene, $typ, "blank", "blank",$x-1,$AllCustomers)
	GuiCtrlSetState($AllCustomers, BitOr($GUI_FOCUS,$GUI_DEFBUTTON,$GUI_EXPAND))
EndFunc


Func StartMyMenu()
_PathSplit($SQliteDB, $szDrive,$szDir,$szFName,$szExt)
$DrvStatus = DriveGetSerial($szDrive)
If $DrvStatus Then
	If FileExists($SQliteDB) And FileGetSize($SQliteDB) > 0 Then
		EnableAllViaRadio()

		_SQLite_Exec($DBmem,"DELETE FROM hosts;")
		If _SQLite_QuerySingleRow($GGDB,"SELECT serverid, autor, datum, comment from comments where id = 24",$hQuery3) = $SQLITE_OK Then

		;If $SQLITE_OK Then

			$DBCountry = $hQuery3[1]
			$DBversion = $hQuery3[3]
			$DBident = $hQuery3[0]
			If $DBident = "160569" Then

				_SQLite_QuerySingleRow($GGDB,"SELECT autor from comments where id = 1001",$uQuery)
				$UserEdit = $uQuery[0]
				;MsgBox(0,"UserEdit",$UserEdit)

			;MsgBox(0,"DBCountry",$DBCountry)
				If $DBCountry = "" Then
					If $DBCountryBox Then
						$DBCountry = $DBCountryBox
						$DBCountryBox = ""
					Else
						$DBCountry = InputBox("Database identifier missing","Please give database identifier" & @CRLF & "(NL, DE_NOC, DE_LAB):","","",220,130)
					EndIf
					$DBversion = "?"
				EndIf

				_SQLite_QuerySingleRow($GGDB,"SELECT serverid, autor, datum, comment from comments where id = 1000",$hQuery3)
				$DBidentArray = StringSplit($hQuery3[1]," ")
				;MsgBox(0,"DBarray",$hQuery3[2])
				$DBid=$DBidentArray[1]
				;$DBident=$DBidentArray[1]
				;$DBpasswd = $DBidentArray[2]
				;$PassEncrypted = $DBpasswd
				$PassEncrypted = $DBidentArray[2]
				$DBParents = $hQuery3[3]
				$ArrayParents = StringSplit($hQuery3[3], ",")

				$PossibleDBparents = ""
				$ArrayParents = StringSplit($hQuery3[3], ",")
				_SQLite_Query($GGDB,"select id from tree where parentid=0",$hQuery3)
				While _SQLite_FetchData ($hQuery3, $dRow) = $SQLITE_OK ;
					$PossibleDBparents = $dRow[0] & " " & $PossibleDBparents
				WEnd
				;MsgBox(0,"Possible Parents",$PossibleDBparents)

				;MsgBox(0,"parents",$ArrayParents[1])
				;$DBversion = $hQuery3[1]
				;_SQLite_QuerySingleRow($GGDB,"SELECT autor from comments where id = 24",$hQuery3)
				;EndIf

				;If ($DBCountry = "DE_NOC" Or $DBCountry = "NL" or $DBCountry = "DE_LAB" Or $DBCountry = "IT_LAB" Or $DBCountry = "UK") Then
				;If $DBident = "160569" Then
				If StringInStr($DEBUG,"9") <> "0" Then MsgBox(0,"StartMyMenu for DB " & $DBCountry, $DBCountry & "SSH port " & $SSHlport2 & " and ISDNGW= " & $ISDNGW & " AlcanetGW= " & $AlcanetGW)
				Select
					Case $DBid = "01"
					;Case $DBCountry = "DE_NOC"
						;$ArrayParents = $DEArrayParents
						GUICtrlSetState($RadioDEGW, $GUI_ENABLE)
						GUICtrlSetState($RadioDame,$GUI_UNCHECKED)
						GUICtrlSetState($RadioDame, $GUI_DISABLE)
						;$PassEncrypted = "4"
						$SQLquery_server = "SELECT id,hostname,name,userlabel,serverip,webconsole,lanconsole,telnetconsole,NMtyp,release,user,password,vertyp,pass,tunnel,lport,tunnelip, lanconsole FROM server WHERE id = '"
						;Case $DBCountry = "DE_LAB"
					Case $DBid = "02"
						;$ArrayParents = $DE_LAB_ArrayParents
						GUICtrlSetState($RadioDEGW, $GUI_ENABLE)
						GUICtrlSetState($RadioDEGW, $GUI_CHECKED)
						$ConnectVia = "slsvho"
						GUICtrlSetState($RadioSwdl,$GUI_UNCHECKED)
						GUICtrlSetState($RadioSwdl, $GUI_DISABLE)
						GUICtrlSetState($RadioDame,$GUI_UNCHECKED)
						GUICtrlSetState($RadioDame, $GUI_DISABLE)
						GUICtrlSetState($RadioVLAN,$GUI_UNCHECKED)
						GUICtrlSetState($RadioVLAN, $GUI_DISABLE)
						GUICtrlSetState($RadioVPN,$GUI_UNCHECKED)
						GUICtrlSetState($RadioVPN, $GUI_DISABLE)
						;$PassEncrypted = "4"
						;$SQLquery_server = "SELECT id,hostname,name,userlabel,alcanetip,webconsole,lanconsole,telnetconsole,NMtyp,release,user,password,vertyp,pass,tunnel,lport,tunnelip, lanconsole FROM server WHERE id = '"
						; lport and tunnelip are removed from DE_LAB database; using twices, as dummy, the tunnel column to meet the number of colums to read.
						$SQLquery_server = "SELECT id,hostname,name,userlabel,alcanetip,webconsole,lanconsole,telnetconsole,NMtyp,release,user,password,vertyp,pass,tunnel,tunnel,tunnel,lanconsole FROM server WHERE id = '"
						;Case $DBCountry = "IT_LAB"
					Case $DBid = "03"
						;$ArrayParents = $IT_LAB_ArrayParents
						GUICtrlSetState($RadioDEGW, $GUI_DISABLE)
						GUICtrlSetState($RadioDame,$GUI_UNCHECKED)
						GUICtrlSetState($RadioDame, $GUI_DISABLE)
						;$PassEncrypted = "1"
						$SQLquery_server = "SELECT id,hostname,name,userlabel,serverip,webconsole,lanconsole,telnetconsole,NMtyp,release,user,password,vertyp,pass,tunnel,lport,tunnelip, lanconsole FROM server WHERE id = '"
					;Case $DBCountry = "UK"
					Case $DBid = "04"
						;$ArrayParents = $UK_ArrayParents
						GUICtrlSetState($RadioDEGW, $GUI_DISABLE)
						GUICtrlSetState($RadioDame,$GUI_UNCHECKED)
						GUICtrlSetState($RadioDame, $GUI_DISABLE)
						;$PassEncrypted = "1"
						$SQLquery_server = "SELECT id,hostname,name,userlabel,serverip,webconsole,lanconsole,telnetconsole,NMtyp,release,user,password,vertyp,pass,tunnel,lport,tunnelip, lanconsole FROM server WHERE id = '"
					;Case $DBCountry = "NL"
					Case $DBid = "00"
						;$ArrayParents = $NLArrayParents
						;$PassEncrypted = "1"
						; If NL database is choosen, it is not possible to connect via DE Alcanet gateway,
						; so gateway is set to NL.
						GUICtrlSetState($RadioDEGW, $GUI_UNCHECKED)
						GUICtrlSetState($RadioDEGW, $GUI_DISABLE)
						If $ConnectVia = "slsvho" Then
							;If $AlcanetGW = $AlcanetGWDE Then
							GUICtrlSetState($RadioSwdl, $GUI_CHECKED)
							$ConnectVia = "sdhswdl"
							GUICtrlSetState($RadioDEGW, $GUI_DISABLE)
							$AlcanetGW = $AlcanetGWNL
							$AlcanetGWUser = $AlcanetGWNLUser
							$AlcanetGWPasswd = $AlcanetGWNLPasswd
							$ISDNGW = $nlsdh1
						EndIf
						;$SQLquery_server = "SELECT id,hostname,name,userlabel,serverip,webconsole,lanconsole,telnetconsole,NMtyp,release,user,password,vertyp,pass,tunnel,lport,tunnelip, lanconsole, DameWareIP FROM server WHERE id = '"
						$SQLquery_server = "SELECT id,hostname,name,userlabel,serverip,webconsole,lanconsole,telnetconsole,NMtyp,release,user,password,vertyp,pass,tunnel,lport,tunnelip, lanconsole FROM server WHERE id = '"

				EndSelect

				IniWrite($INIDir & $INIFile, "SQLite Database", "PassEncrypted", $PassEncrypted)

				ReadAllDatabases()

				GUICtrlSetData($Database_ID, "","")
				GUICtrlSetData($Database_ID, $DBs,$Database)
				;GUICtrlSetState($Database_ID,$GUI_FOCUS)

				GUICtrlDelete($treeview)
				$treeview = GUICtrlCreateTreeView($leftDatabase + 7, 48, $WidthTreeView, $HeightTreeView-23, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $WS_DISABLED), $WS_EX_CLIENTEDGE)
				If $ViaSelected = "TRUE" Then GUICtrlSetStyle ( $treeview, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS) )
				For $par = 1 to $ArrayParents[0]
					MyMenu($ArrayParents[$par])
				Next
			Else
				MsgBox(16,"Database error 1","Incompatible or Database not found. Please update your database!")
			EndIf
		Else
			MsgBox(16,"Database error 2","Incompatible or Database not found. Please update your database!")

			ReadAllDatabases()
		EndIf
	EndIf
EndIf
;ViewDB()
EndFunc


Func ActivateGGGui()
	WinActivate($GuiTitle)
EndFunc

Func CheckApplicationBox()
		Select
			Case BitAND(GUICtrlRead($RadioGG), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "GG"

			Case BitAND(GUICtrlRead($RadioSSH), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "SSH"

			Case BitAND(GUICtrlRead($RadioSCP), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "SCP"

			Case BitAND(GUICtrlRead($Radioftp), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "ftp"

			Case BitAND(GUICtrlRead($RadioTelnet), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "Telnet"

			Case BitAND(GUICtrlRead($RadioLanConsole), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "LanConsole"

			Case BitAND(GUICtrlRead($RadioTelnetConsole), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "TelnetConsole"

			Case BitAND(GUICtrlRead($RadioWebConsole), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "WebConsole"

			Case BitAND(GUICtrlRead($RadioWeb), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "WEB"

			Case BitAND(GUICtrlRead($RadioVNC), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "VNC"

			Case BitAND(GUICtrlRead($RadioRDP), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "RDP"
			Case BitAND(GUICtrlRead($RadioNX), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "NX"
			Case BitAND(GUICtrlRead($RadioTV), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "TV"

		EndSelect
		;If $function <> "LoadNMS" Then LoadNMS($item,$msg)
EndFunc



;############ KPN-TPA ############################
;##########################################################################

Func OnUpdate()
	$sIP = GetActiveIP($sHostname)
	$sAventailIP = CheckAventailIP() ; => Global $sAventailIP
	ShowActiveGateway($sIP, $arrGW) ; => Global $sTPAgw, $sTPAhl
	$sFFhl = CheckFirefoxHyperlink()
	$sRAMSES = CheckRAMSES()
	$sFFProxy = CheckFFProxy()
	GUICtrlSetData($Input_AventailIP, $sAventailIP)
	GUICtrlSetData($Input_RAMSES, $sRAMSES)
	GUICtrlSetData($Input_ActiveGW, $sTPAgw)
	GUICtrlSetData($Input_ActiveGWHL, $sTPAhl)
	GUICtrlSetData($Input_Firefox, $sFFhl)
	GUICtrlSetData($Input_FF_Proxy, $sFFProxy)
EndFunc   ;==>OnUpdate

Func CheckAventailIP()
	;http://www.autoitscript.com/forum/topic/128276-display-ip-address-default-gateway-dns-servers/
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColItems = $oWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True", "WQL", 0x30)
	Local $oObjectItem, $sAventailActIP = "No Aventail SSL VPN active - Please Check"
	Local $sPostion
	If IsObj($oColItems) Then
		For $oObjectItem In $oColItems
			;Check that subrange is present
			;; Old part that did not take into account that substr might not start at 1
			;If (StringInStr($oObjectItem.IPAddress(0), "155.132.") Or _
			;		StringInStr($oObjectItem.IPAddress(0), "135.231.") Or _
			;		StringInStr($oObjectItem.IPAddress(0), "135.241.")) Then
			;	;MsgBox(0, "Aventail Check:", "Aventail Active:" & @CRLF & @CRLF  & _
			;	;$oObjectItem.IPAddress(0) & @CRLF)
			;	$sAventailActIP = $oObjectItem.IPAddress(0)
			;	ExitLoop
			;EndIf
			;; [MP20130202] replaced with better check (from first character)
			$sPostion = StringInStr($oObjectItem.IPAddress(0), "155.132.")
			If ($sPostion = 1) Then ; the IP address starts with this substring
				$sAventailActIP = $oObjectItem.IPAddress(0)
				ExitLoop
			EndIf
			$sPostion = StringInStr($oObjectItem.IPAddress(0), "135.231.")
			If ($sPostion = 1) Then ; the IP address starts with this substring
				$sAventailActIP = $oObjectItem.IPAddress(0)
				ExitLoop
			EndIf
			$sPostion = StringInStr($oObjectItem.IPAddress(0), "135.241.")
			If ($sPostion = 1) Then ; the IP address starts with this substring
				$sAventailActIP = $oObjectItem.IPAddress(0)
				ExitLoop
			EndIf
		Next
	EndIf
	;Return SetError(1, 0, $aReturn)
	Return $sAventailActIP
EndFunc   ;==>CheckAventailIP


;Get the active endpoint of the KPN TPA
;Used by Func ShowActiveGateway
Func GetActiveIP(ByRef $sHost)
	Local $sIP
	TCPStartup()
	$sIP = TCPNameToIP($sHost)
	If @error Then
		MsgBox(0, "TCPNameToIP()", "$sHostname = " & $sHost & @CRLF & _
				"gives us the following windows API WSAGetError return value " & _
				@CRLF & @CRLF & _
				"@error = " & @error & @CRLF & _
				"@extended = " & @extended)
		Exit (2)
	EndIf
	TCPShutdown()
	Return $sIP
EndFunc   ;==>GetActiveIP

;Show the correct Active Gateway based on $arrGW
;GW-KPN_Haarlem @ 139.156.76.1	=> https://139.156.76.1/appl
;GW-KPN_Aalsmeer @ 139.156.76.17 => https://139.156.76.17/appl
;MP20130131
Func ShowActiveGateway(ByRef $sGWIP, ByRef $arr)
	Local $iCount
	For $iCount = 0 To UBound($arr, 1) - 1
		If $arr[$iCount][0] = $sGWIP Then
			;ClipPut($arr[$iCount][2]) ; place hyperlink on Clipboard
			;MsgBox(0, "KPN GW IP is " & $sGWIP, _
			;		"Resolving " & $sHostname & @CRLF & @CRLF & _
			;		"Gateway: " & $arr[$iCount][1] & @CRLF & _
			;		"Hyperlink: " & $arr[$iCount][2] & @CRLF & @CRLF & _
			;		"Copied Hyperlink to the Clipboard.", 60)
			$sTPAgw = $arr[$iCount][1]
			$sTPAhl = $arr[$iCount][2]
			ClipPut($sTPAhl) ; place hyperlink on Clipboard
			Return
		EndIf
	Next
	MsgBox(0, 'Error', 'Did not find the gateway', 2)
EndFunc   ;==>ShowActiveGateway


Func CheckFirefoxHyperlink()
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColItems = $oWMIService.ExecQuery("Select * From Win32_Process", "WQL", 0x30)
	Local $oObjectItem
	Local $sHyperlink = "No (RAMSES) firefox running - Please Check"
	If IsObj($oColItems) Then
		For $oObjectItem In $oColItems
			;Search for firefox and check if ramses is in the command line.
			If (StringInStr($oObjectItem.Name, "firefox")) Then
				;only one (1) mozilla firefox should be running, the one started via RAMSES
				$sHyperlink = "Close firefox and start new one via RAMSES"
				If (StringInStr($oObjectItem.CommandLine, "ramses")) Then
					;MsgBox(0, "Search result:", "$oObjectItem.Name = " & $oObjectItem.Name & @CRLF & @CRLF  & _
					;"$oObjectItem.CommandLine = " & $oObjectItem.CommandLine & @CRLF)
					;$sHyperlink = $oObjectItem.CommandLine
					$sHyperlink = "RAMSES firefox running"
					; ------------------------------------------------------------
					; Add info on which FireFox is started, based on info found at 2013-01-31
					; Firefox Haarlem:
					; "C:\Program Files\Mozilla Firefox\firefox.exe"
					; -no-remote -p ramses2 -new-window "https://gw1gwkpn01:443"
					; Firefox Aalsmeer:
					; "C:\Program Files\Mozilla Firefox\firefox.exe"
					; -no-remote -p ramses2 -new-window "https://gw1gwkpn17:443"
					; ------------------------------------------------------------
					; Add info on which FireFoxPortable is started, based on info found at 2013-02-02
					;Firefox Haarlem:
					; "%USERPROFILE%\ramses\cache\tools\FirefoxPortable3_6_10\App\firefox\firefox4ramses.exe"
					; -profile "%USERPROFILE%\ramses\cache\tools\FirefoxPortable3_6_10\Data\profile"
					; "https://gw1gwkpn01:443" -no-remote
					; Firefox Aalsmeer:
					; "%USERPROFILE%\ramses\cache\tools\FirefoxPortable3_6_10\App\firefox\firefox4ramses.exe"
					; -profile "%USERPROFILE%\ramses\cache\tools\FirefoxPortable3_6_10\Data\profile"
					; "https://gw1gwkpn17:443" -no-remote
					; ------------------------------------------------------------
					If (StringInStr($oObjectItem.CommandLine, $arrGW[0][3])) Then
						$sHyperlink = "RAMSES firefox " & $arrGW[0][1] & " is present"
					ElseIf (StringInStr($oObjectItem.CommandLine, $arrGW[1][3])) Then
						$sHyperlink = "RAMSES firefox " & $arrGW[1][1] & " is present"
					EndIf
				EndIf
				ExitLoop
			EndIf
		Next
	EndIf
	Return $sHyperlink
EndFunc   ;==>CheckFirefoxHyperlink


Func CheckRAMSESActive()
	Local $RamsesQuery, $RAMSESURL
	Local $IsRamsesActive = "FALSE"
	If WinExists("RAMSES v") Then
		$IsRamsesActive = "TRUE"
	Else
		_SQLite_QuerySingleRow($GGDB,"SELECT webconsole from server where name= 'RAMSES'",$RamsesQuery)
		$RAMSESURL = $RamsesQuery[0]
		$HTTPPID = Run("""" & $HTTPDIR & " """ & $RAMSESURL,"")
	EndIf
	Return $IsRamsesActive
EndFunc


;Check if RAMSES is active
;MP20130131
Func CheckRAMSES()
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColItems = $oWMIService.ExecQuery("Select * From Win32_Process", "WQL", 0x30)
	Local $oObjectItem
	Local $sRAMSES = "No RAMSES application running - Please Check"
	If IsObj($oColItems) Then
		For $oObjectItem In $oColItems
			;Search for firefox and check if ramses is in the command line.
			If (StringInStr($oObjectItem.Name, "java")) Then
				$sRAMSES = "java running, but is it RAMSES?"
				If (StringInStr($oObjectItem.CommandLine, "ramses")) Then
					;MsgBox(0, "Search result:", "$oObjectItem.Name = " & $oObjectItem.Name & @CRLF & @CRLF  & _
					;"$oObjectItem.CommandLine = " & $oObjectItem.CommandLine & @CRLF)
					$sRAMSES = "RAMSES Active"
				EndIf
				ExitLoop
			EndIf
		Next
	EndIf
	Return $sRAMSES
EndFunc   ;==>CheckRAMSES

Func CheckFFProxy()
	Local $find = "network.proxy.ssl"
	Local $aRecords
	Local $array
	Local $sCompare
	; [MP20130202] - Adding extra check via %USERPROFILE%\ramses\ramses.cfg browser
	Local $sRamsesCfg = @UserProfileDir & "\ramses\ramses.cfg"
	Local $sBrowerCfg = "browser"
	If Not _FileReadToArray($sRamsesCfg, $aRecords) Then
		MsgBox(4096, "Error", "Error in getting " & $sBrowerCfg & _
				" info" & @CRLF & "from " & $sRamsesCfg)
		;Exit 	; Remove this Exit for something nicer
		Return "No info found. Could not locate " & $sRamsesCfg
	EndIf
	For $x = 1 To $aRecords[0]
		If StringInStr($aRecords[$x], $sBrowerCfg) Then
			;Check for local Firefox browser - no change needed then
			$sCompare = StringCompare($aRecords[$x], "browser=Firefox")
			If $sCompare = 0 Then
				ExitLoop ; nothing needs to change for $sFFprefs
			EndIf
			;Check for FirefoxPortable browser
			$sCompare = StringCompare($aRecords[$x], "browser=FirefoxPortable")
			If $sCompare = 0 Then
				; need to update $sFFprefs
				; "%USERPROFILE%\ramses\cache\tools\FirefoxPortable3_6_10\Data\profile\prefs.js"
				; Think the FirefoxPortableX_X_X can change, so do the search in two steps
				; Step 1 - Find FirefoxPortableX_X_X
				Local $searchThisDirRoot = @UserProfileDir & "\ramses\cache\tools\"
				Local $searchThisDir = $searchThisDirRoot & "FirefoxPortable*"
				Local $searchDir = FileFindFirstFile($searchThisDir)
				; Check if the search was successful
				If $searchDir = -1 Then
					MsgBox(0, "Error", "No directories matched the search pattern" & @CRLF & _
							$searchThisDir & @CRLF & @CRLF & _
							"Maybe change the" & @CRLF & _
							"RAMSES - Options - Configuration - Browser" & @CRLF & _
							"to Firefox" & @CRLF & _
							"-or-" & @CRLF & _
							"Allready start/activate the Firefox Browser from RAMSES.")
					;Exit
				EndIf
				While 1
					Local $fileDir = FileFindNextFile($searchDir)
					If @error Then ExitLoop
					;;MsgBox(4096, "Directory found:", $fileDir)	; MPTEST
					;First (and only?) FirefoxPortable* directory found
					;now check for the rest (Data\profile\prefs.js)
					Local $searchPrefsJsFile = $searchThisDirRoot & $fileDir & "\Data\profile\prefs.js"
					Local $searchPrefsJs = FileFindFirstFile($searchPrefsJsFile)
					; Check if the file is present
					If $searchPrefsJs = -1 Then
						MsgBox(0, "Error", "No prefs.js matched the search pattern" & @CRLF & _
								$searchPrefsJsFile & @CRLF & @CRLF & _
								"Maybe change the" & @CRLF & _
								"RAMSES - Options - Configuration - Browser" & @CRLF & _
								"to Firefox" & @CRLF & _
								"-or-" & @CRLF & _
								"Allready start/activate the Firefox Browser from RAMSES." & @CRLF & @CRLF & _
								"Continue checking...")
						;Exit
					EndIf
					While 1
						Local $filePrefsJs = FileFindNextFile($searchPrefsJs)
						#forceref $filePrefsJs ; only used to find the file.
						If @error Then ExitLoop
						;;MsgBox(4096, "File:", $filePrefsJs)	; MPTEST
						; found a FirefoxPortable prefs.js replacement for the default Firefox $sFFprefs
						$sFFprefs = $searchPrefsJsFile
						; we loop and go further..maybe more FirefoxPortableX_X_X available.
						; Higher number comes later, so updated version will be found.
					WEnd
					; Close the search handle
					FileClose($searchPrefsJs)
					;Exit ; MPTEST
					;ExitLoop
				WEnd

				; Close the search handle
				FileClose($searchDir)
				;Exit ; MPTEST
				;
				ExitLoop
			EndIf
			;Check for (very old) local Mozilla browser
			$sCompare = StringCompare($aRecords[$x], "browser=Mozilla")
			If $sCompare = 0 Then
				; need to update $sFFprefs (if I would check this option)
				; As we ignore it for now, just a popup
				MsgBox(0, "Error", "Ignoring Mozilla browser option." & @CRLF & _
						"Maybe change the RAMSES - Options - Configuration - Browser" & @CRLF & _
						"to Mozilla -or- start the Mozilla Browser from RAMSES.")
				ExitLoop
			EndIf
			;None of the three options worked?
			;Then just continue for the rest of the strings
			;MsgBox(0, "", $array[0])
			;ExitLoop
		EndIf
	Next
	; [MP20130202] - End of Extra ramses.cfg check
	; read $find = "network.proxy.ssl" line from prefs.js and get the IPv4 address
	If Not _FileReadToArray($sFFprefs, $aRecords) Then
		MsgBox(4096, "Error", "Error in getting " & $find & _
				" info" & @CRLF & " from " & $sFFprefs)
		;Exit 	; Remove this Exit for something nicer
		Return "No info found. Could not locate RAMSES prefs.js"
	EndIf
	For $x = 1 To $aRecords[0]
		If StringInStr($aRecords[$x], $find) Then
			;Option 2, single return, php/preg_match() style
			$array = StringRegExp($aRecords[$x], "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}", 2)
			;MsgBox(0, "", $array[0])
			ExitLoop
		EndIf
	Next
	Return $array[0] ; No extra check, return the first (and only) entry from array
EndFunc   ;==>CheckFFProxy


Func SetRamsesProxies()
	Local $FORWGUI,$RAMSESSetProxyButton ,$InternetSetProxybutton, $msg

	$FORWGUI = GUICreate("Setting LAN and RAMSES Dial-in proxies for KPN",350,50)
	GUISetState()

	$RAMSESSetProxyButton = GUICtrlCreateButton("Set KPN &Ramses proxies", 10,10)
	$InternetSetProxybutton = GUICtrlCreateButton("Set &ALU Internet proxies     ",150,10)
	If Not StringInStr(CheckRAMSESConnection(),"RAMSES")  Then
		GUICtrlSetState($RAMSESSetProxyButton, $GUI_DISABLE)
		GUICtrlSetState($InternetSetProxybutton, $GUI_DISABLE)
	EndIf
	;$ApplySetbutton = GUICtrlCreateButton("&Apply",240,200,70,20)
	GUISetState()
	While 1
		$msg = GUIGetMsg()
		Select
			Case ($msg = $RAMSESSetProxyButton)
				If StringInStr(CheckRAMSESConnection(),"RAMSES")  Then
					_ConfigLAN("UnCheck", "UnCheck", "Check")
					ExitLoop
				Else
					MsgBox(48,"RAMSES Dial-in","You are not connected to RAMSES Aventail.")
					ExitLoop
				EndIf
			Case $msg = $InternetSetProxybutton
				If StringInStr(CheckRAMSESConnection(),"RAMSES")  Then
					_ConfigLAN("Check", "Check", "UnCheck")
					ExitLoop
				Else
					MsgBox(48,"RAMSES Dial-in","You are not connected to RAMSES Aventail.")
					ExitLoop
				EndIf
			 Case $msg = $GUI_EVENT_CLOSE
				 ExitLoop

		EndSelect
	WEnd
	GUIDelete($FORWGUI)
EndFunc


Func _ConfigLAN($autoDetSettings, $useAutoConfigScript, $useProxyServer)
	Local $InternetProperties, $DialupConnections, $Settings, $AutomaticSettings, $ConfigScript, $UseAProxyServer, $LANSettings, $LANSettingsTitle, $UseProxyforLAN, $AventailDialupSettings
;	Local $DialupConnections, $AutomaticSettings, $ConfigScript, $UseAProxyServer, $LANSettings, $LANSettings, $UseProxyforLAN

	; Launch the Internet Explorer Control Panel, Internet Properties dialog displaying the Connections tab (tab # 4).
	Run(@ComSpec & " /c " & 'rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,4', "", "")

Select
	Case StringInStr("0409 0809 0c09 1009 1409 1809 1c09 2009 2409 2809 2c09 3009 3409", @OSLang)
		$InternetProperties = "Internet Properties"
		$DialupConnections = "Dial-up connections"
		$Settings = "Settings"
		;$SettingsFor = ""
		$AventailDialupSettings = $Aventail_DialUp & " settings"
		;MsgBox(0,"Dialup", $AventailDialupSettings)
		$AutomaticSettings = "&Automatically detect settings"
		$ConfigScript = "Use automatic configuration &script"
		$UseAProxyServer = "Use a pro&xy server for this connection (These settings will not apply to other connections)."
		$LANSettings = "&LAN settings"
		$LANSettingsTitle = "Local Area Network (LAN) Settings"
		$UseProxyforLAN = "Use a pro&xy server for your LAN (These settings will not apply to dial-up or VPN connections)."
	Case StringInStr("0413 0813", @OSLang)
		$InternetProperties = "Eigenschappen van Internet"
		$DialupConnections = "Inbelverbindingen"
		$Settings = "I&nstellingen"
		;SettingsFor = "Instellingen voor "
		$AventailDialupSettings = "Instellingen voor " & $Aventail_DialUp
		$AutomaticSettings = "Instellingen a&utomatisch detecteren"
		$ConfigScript = "Automatisch configuratie&script gebruiken"
		$UseAProxyServer = "Een pro&xyserver voor deze verbinding gebruiken (deze instellingen zijn niet van toepassing op andere verbindingen)"
		$LANSettings = "&LAN-instellingen"
		$LANSettingsTitle = "LAN-instellingen"
		$UseProxyforLAN = "Een pro&xyserver voor het LAN-netwerk gebruiken (deze instellingen zijn niet van toepassing op inbel- en VPN-verbindingen)."
	Case Else
		MsgBox(48,"Language not supported","Your system language is not supported for setting the proxies." & @CRLF & "Supported languages are Dutch and English." & @CRLF & "Please set the proxies manually.")
		Return False

EndSelect

;sleep(1000)
WinActivate($InternetProperties)
If WinWaitActive($InternetProperties,"",5) Then
; Click "LAN settings" Button.
ControlFocus($InternetProperties,$DialupConnections,"[CLASS:SysTreeView32; INSTANCE:1]")
ControlTreeView($InternetProperties,$DialupConnections,"[CLASS:SysTreeView32; INSTANCE:1]","Select",$Aventail_DialUp)
If ControlClick($InternetProperties, $Settings, "[CLASS:Button; INSTANCE:5]") Then
	WinActivate($AventailDialupSettings)
	If WinWaitActive($AventailDialupSettings) Then
		ControlCommand($AventailDialupSettings, "", "[CLASS:Button; TEXT:" & $AutomaticSettings & "]", $autoDetSettings)
		WinActivate($AventailDialupSettings)
		If WinWaitActive($AventailDialupSettings) Then
			ControlCommand($AventailDialupSettings, "", "[CLASS:Button; TEXT:" & $ConfigScript & "]", $useAutoConfigScript)
			WinActivate($AventailDialupSettings)
				If WinWaitActive($AventailDialupSettings) Then
					ControlCommand($AventailDialupSettings, "", "[CLASS:Button; TEXT:" & $UseAProxyServer & "]", $useProxyServer)

							WinActivate($AventailDialupSettings)
							WinWaitActive($AventailDialupSettings)
							If $useProxyServer = "Check" Then
								$OrgProxyAddress = ControlGetText($AventailDialupSettings, "", "[CLASS:Edit; INSTANCE:2]")
								$OrgProxyPort = ControlGetText($AventailDialupSettings, "", "[CLASS:Edit; INSTANCE:3]")
								ControlSetText($AventailDialupSettings, "", "[CLASS:Edit; INSTANCE:2]","155.132.138.166")
								ControlSetText($AventailDialupSettings, "", "[CLASS:Edit; INSTANCE:3]","8080")
							Else
								If $OrgProxyAddress Then ControlSetText($AventailDialupSettings, "", "[CLASS:Edit; INSTANCE:2]",$OrgProxyAddress)
								If $OrgProxyPort Then ControlSetText($AventailDialupSettings, "", "[CLASS:Edit; INSTANCE:3]",$OrgProxyPort)
							EndIf
							sleep(1000)

				EndIf
			EndIf
		EndIf
	EndIf
	ControlClick($AventailDialupSettings, "", "[CLASS:Button; TEXT:OK]", "main")
EndIf
;sleep(1000)
;Send("{TAB}")
;sleep(2000)
WinActivate($InternetProperties)
If WinWaitActive($InternetProperties,"",5) Then
	If ControlClick($InternetProperties, "", "[CLASS:Button; TEXT:" & $LANSettings & "]", "main") Then
		; Take action on the two Automatic configuration checkbox buttons and Proxy server button.)
		WinActivate($LANSettingsTitle)
		If WinWaitActive($LANSettingsTitle) Then
			ControlCommand($LANSettingsTitle, "", "[CLASS:Button; TEXT:" & $AutomaticSettings & "]", $autoDetSettings)
			If @error <> 1 Then
				WinActivate($LANSettingsTitle)
				If WinWaitActive($LANSettingsTitle) Then
					ControlCommand($LANSettingsTitle, "", "[CLASS:Button; TEXT:" & $ConfigScript & "]", $useAutoConfigScript)
					If @error <> 1 Then
						WinActivate($LANSettingsTitle)
						If WinWaitActive($LANSettingsTitle) Then
							;If ControlCommand($LANSettingsTitle, "", "[CLASS:Button; TEXT:" & $UseProxyforLAN & "]", "isChecked") = 1 Then
							ControlCommand($LANSettingsTitle, "", "[CLASS:Button; TEXT:" & $UseProxyforLAN & "]", $useProxyServer)
							;EndIf
							;ControlCommand("[CLASS:Edit; INSTANCE:2]", "","Edit2","EditPaste", "155.132.138.167")
							;WinActivate($LANSettingsTitle)
							;WinWaitActive($LANSettingsTitle)
							;ControlCommand($LANSettingsTitle, "", "[CLASS:Edit; INSTANCE:2]","DelString")
							;sleep(3000)
							WinActivate($LANSettingsTitle)
							WinWaitActive($LANSettingsTitle)
							If $useProxyServer = "Check" Then
								$OrgProxyAddress = ControlGetText($LANSettingsTitle, "", "[CLASS:Edit; INSTANCE:2]")
								$OrgProxyPort = ControlGetText($LANSettingsTitle, "", "[CLASS:Edit; INSTANCE:3]")
								ControlSetText($LANSettingsTitle, "", "[CLASS:Edit; INSTANCE:2]","155.132.138.166")
								ControlSetText($LANSettingsTitle, "", "[CLASS:Edit; INSTANCE:3]","8080")
							Else
								If $OrgProxyAddress Then ControlSetText($LANSettingsTitle, "", "[CLASS:Edit; INSTANCE:2]",$OrgProxyAddress)
								If $OrgProxyPort Then ControlSetText($LANSettingsTitle, "", "[CLASS:Edit; INSTANCE:3]",$OrgProxyPort)
							EndIf
							sleep(1000)

							;;ControlFocus($LANSettingsTitle, "", "[CLASS:Button; TEXT:" & $UseProxyforLAN & "]")

							;;sleep(1000)
							;;Send("{TAB}")
							;;sleep(1000)
							;;Send("155.132.138.166",1)
							;;Send("{TAB}")
							;;Send("8080",1)
							;;sleep(3000)
							;ControlCommand($LANSettingsTitle, "", "[CLASS:Button; TEXT:" & $UseProxyforLAN & "]", "GetSelected", "")
							If @error <> 1 Then
								; Success Setting the three checkbox buttons.
								; Click "OK" Button in LAN dialog.
								WinActivate($LANSettingsTitle)
								If WinWaitActive($LANSettingsTitle,"",5) Then
									If ControlClick($LANSettingsTitle, "", "[CLASS:Button; TEXT:OK]", "main") Then
										; Click "OK" Button in main Dialog.
										WinActivate($InternetProperties)
										If WinWaitActive($InternetProperties,"",5) Then
											If ControlClick($InternetProperties, "", "[CLASS:Button; TEXT:OK]", "main") Then
												; Success.
												Return True
											EndIf
										EndIf
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndIf

;EndIf
MsgBox(0, "IE LAN Settings - Error", "Script """ & @ScriptName & """ failed to: " & @CRLF & _
$autoDetSettings & " (Top one) - Automatically detect settings." & @CRLF & _
$useAutoConfigScript & " (Bottom one) - Use automatic configuration script.")
Return False
EndFunc ;==>_ConfigLAN


Func OnCorrectURL()
	Local $hMozilla = WinGetHandle("[REGEXPCLASS:Mozilla(UI)?WindowClass; REGEXPTITLE:irefox$]", "")
	Local $hURL = "https://139.156.76.1/appl"

	If Not WinExists("KPN Remote Access SSL VPN Service") Then
	;If @error Then
		MsgBox(16, "Error", "Failed to find Mozilla Firefox window for KPN Remote Access SSL VPN Service.")
		Return
	EndIf


	;WinActivate($hMozilla, "")
	;If WinWaitActive($hMozilla, "", 10) Then
	;WinActivate("KPN Remote Access SSL VPN Service - Wrong URL - Mozilla Firefox", "")
	;If WinWaitActive("KPN Remote Access SSL VPN Service - Wrong URL - Mozilla Firefox", "", 10) Then
	WinActivate("KPN Remote Access SSL VPN Service", "")
	If WinWaitActive("KPN Remote Access SSL VPN Service", "", 10) Then
		; correct hyperlink
		Send("^l{SPACE}") ; Go to TAB 1
		;;$sFFhl = CheckFirefoxHyperlink()
		;;RAMSES firefox GW-KPN_Haarlem is present << Main
		;;RAMSES firefox GW-KPN_Aalsmeer is present << Standby
		;MsgBox(0,"IP", "IP= " & $IP & " sFFhl= " & $sFFhl)
		;If (StringInStr($IP, $arrGW[0][1])) Then
		;	$hURL = $arrGW[0][2]
		;ElseIf (StringInStr($IP, $arrGW[1][1])) Then
		;	$hURL = $arrGW[1][2]
		;EndIf

		;If (StringInStr($sFFhl, $arrGW[0][1])) Then
		;	$hURL = $arrGW[0][2]
		;ElseIf (StringInStr($sFFhl, $arrGW[1][1])) Then
		;	$hURL = $arrGW[1][2]
		;EndIf
		sleep(600)
		Send($IP & "appl")
		Sleep(2000)
		Send("{ENTER}")
		Sleep(2000)

		If $GGUser Then
				sleep(2000)
				Send($GGUser,1)
				sleep(1000)
				Send("{TAB}")
		EndIf
		If $GGUser And $GGPassword Then
				;sleep(1000)
				Send($GGPassword,1)
				Send("{ENTER}")
				sleep(2000)
				WinActivate("KPN Remote Access SSL VPN Service - Mozilla Firefox")
					If WinWaitActive("KPN Remote Access SSL VPN Service - Mozilla Firefox","",10) Then
					sleep(1000)
					;Send("{TAB}")
					Send("{TAB 2}")
					sleep(1000)
					Send("{ENTER}")
					;EndIf
					sleep(2000)

					WinActivate("KPN Remote Access SSL VPN Service - Mozilla Firefox")
					If WinWaitActive("KPN Remote Access SSL VPN Service - Mozilla Firefox","",10) Then
						Send("^l{SPACE}")
			;ControlSetText("KPN Remote Access SSL VPN Service - Mozilla Firefox","","[CLASS:MozillaWindowClass; INSTANCE:1]",$IP & "+CSCO+1h75676763663A2F2F70766765766B2E78636161792E7962706E79++/Citrix/Proxy/")
						Send($IP & "+CSCO+1h75676763663A2F2F70766765766B2E78636161792E7962706E79++/Citrix/Proxy/",1)
			;MsgBox(0,"URL", $hURL & "+CSCO+1h75676763663A2F2F70766765766B2E78636161792E7962706E79++/Citrix/Proxy/")
						Sleep(3000)
						Send("{ENTER}")
			;If $GGUser Then
			;	sleep(2000)
			;	Send($GGUser,1)
			;	sleep(1000)
			;	Send("{TAB}")
			;EndIf
			;If $GGUser And $GGPassword Then
			;	;sleep(1000)
			;	Send($GGPassword,1)
			;	Send("{ENTER}")
			;	sleep(2000)
			;	WinActivate("KPN Remote Access SSL VPN Service - Mozilla Firefox")
			;	;sleep(1000)
			;	;If Not WinActive("KPN Remote Access SSL VPN Service - Mozilla Firefox") Then WinActivate("KPN Remote Access SSL VPN Service - Mozilla Firefox")
			;	;If WinWaitActive("KPN Remote Access SSL VPN Service - Mozilla Firefox") Then
			;	;Send("^l")
			;	If WinWaitActive("KPN Remote Access SSL VPN Service - Mozilla Firefox","",10) Then
			;		sleep(1000)
			;		;Send("{TAB}")
			;		Send("{TAB 6}")
			;		sleep(1000)
			;		Send("{ENTER}")
			;		;EndIf
					sleep(2000)
					WinActivate("Citrix XenApp - Logon - Mozilla Firefox")
					If WinWaitActive("Citrix XenApp - Logon - Mozilla Firefox","",30) Then
						sleep(1000)
						;If Not WinActive("Citrix XenApp - Logon - Mozilla Firefox") Then WinActivate("Citrix XenApp - Logon - Mozilla Firefox")
						;If WinWaitActive("Citrix XenApp - Logon - Mozilla Firefox", "") Then
						;sleep(1000)
						;Send("^l")
						;Send("{TAB 4}")
						;sleep(500)
						Send($GGUser & "{TAB}" & $GGPassword & "{ENTER}")
						;sleep(3000)
						;MsgBox(0,"Waiting","for xpire")
						WinActivate("Citrix XenApp - Password Expiry Warning - Mozilla Firefox")
						WinWaitActive("Citrix XenApp - Password Expiry Warning - Mozilla Firefox","",3)
						If Not WinExists("Citrix XenApp - Password Expiry Warning - Mozilla Firefox") Then
							WinActivate("Citrix XenApp - Applications - Mozilla Firefox")
							If WinWaitActive("Citrix XenApp - Applications - Mozilla Firefox","",10) Then
								_ConfigLAN("UnCheck", "UnCheck", "Check")
								WinActivate("Citrix XenApp - Applications - Mozilla Firefox")
								If WinWaitActive("Citrix XenApp - Applications - Mozilla Firefox","",10) Then
									;https://139.156.76.1/+CSCO+1075676763663A2F2F70766765766B2E78636161792E7962706E79++/Citrix/Proxy/site/-CSCO-3h--default.aspx?CTX_CurrentFolder=%5cDesktops
									;https://139.156.76.1/+CSCO+1075676763663A2F2F70766765766B2E78636161792E7962706E79++/Citrix/Proxy/site/-CSCO-30--launcher.aspx?CTX_Application=Citrix.MPS.App.SHR_P_XenApp6.Desktop%20SDH%20Alcatel%20-%20RESWM%20%7b411%7d&CTX_Token=08DCFF151A14C19E4F8584D56BEEAFC7&LaunchId=1372172530977
									;https://139.156.76.1/+CSCO+1075676763663A2F2F70766765766B2E78636161792E7962706E79++/Citrix/Proxy/site/-CSCO-3h--default.aspx?CTX_CurrentFolder=\Desktops
									Send("^l{SPACE}")
									Send($IP & "+CSCO+1075676763663A2F2F70766765766B2E78636161792E7962706E79++/Citrix/Proxy/site/-CSCO-3h--default.aspx?CTX_CurrentFolder=\Desktops",1)
									Send("{ENTER}")
									sleep(2000)
									Send("{TAB 11}")
									Send("{ENTER}")
									;Send("{TAB}")
									;Send("{ENTER}")
									;_ConfigLAN("UnCheck", "UnCheck", "Check")
									WinActivate("Opening launch.ica")
									If WinWaitActive("Opening launch.ica","",10) Then
										ControlClick("Opening launch.ica", "", "[CLASS:Button; TEXT:OK]", "main")
									EndIf
									WinActivate("Desktop SDH Alcatel ")
									WinWaitActive("Desktop SDH Alcatel ","",30)
									If WinWaitClose("Desktop SDH Alcatel ","",60) Then
										_ConfigLAN("Check", "Check", "UnCheck")
									EndIf
									If WinExists("Desktop SDH Alcatel ERROR","") Then
										MsgBox(48,"Desktop SDH Alcatel not started","Please check the proxy settings and start the 'Desktop SDH Alcatel agaim mannualy.")
									EndIf
									;USB/Other Devices Security - Citrix online plug-in
									;File Security - Citrix online plug-in
									;EndIf
									;MsgBox(64, "Success", "Activated Mozilla Firefox window: " & $hMozilla)
								EndIf
							EndIf
						Else
							MsgBox(16,"Login Password Expiry Warning.","Please continue with Login manually!" & @CRLF & "Don't forget to change the password also in the GGTunnelGUI!")
							WinActivate("Login Password Expiry Warning.")
						EndIf
					EndIf
				EndIf
			Else
				MsgBox(16,"No username and password provided.","Please continue with Login manually!")
				WinActivate("No username and password provided.")
			EndIf
		EndIf
	Else
		MsgBox(16, "Error", "Failed to activate Mozilla Firefox window.")
	EndIf
EndFunc   ;==>OnCorrectURL



;##################################################################################################################################
;##################################################################################################################################
Func Main()
	Local $generalitem, $displayitem, $aboutitem, $compitem, $bla, $bla2
	Local $useritem, $resitem, $otheritem, $startlabel, $aboutlabel, $compinfo
	Local $togglebutton,  $statebutton, $cancelbutton, $loadbutton
	Local $msg, $hItem, $newitem
	Local $pw
	Local $OptionsMenu, $SettingsItem, $ViewMenu, $DBItem,  $AppPort, $OldItem, $INIViewItem, $INIItem, $ConnectedItem, $LocalFWportsItem
	Local $CopyClip2VPCItem, $ConnectedPuTTYItem, $SharePointItem, $ShowSharedDrive, $SharedDriveItem, $CheckUsedVPCItem, $KPNRamsesProxy
	Local $HelpMenu, $UpdatesItem, $DocsItem, $WebItem, $SessionPID,  $Connected, $exititem, $GGGuiItem, $DDMItem, $DameWareItem, $DBold

	;Global $item, $text, $SSHport, $Webport, $Telnetport, $Tunnelstring, $Application, $GObutton, $GoState, $UsernameLoad, $PasswordLoad


	;SetConstants()
	SetDefaultSettings()
	ReadSettings()

	If Not FileExists($PSEXECDir & "sqlite3.dll") Then FileInstall("sqlite3.dll",$PSEXECDir & "sqlite3.dll")
	_SQLite_Startup($PSEXECDir & "sqlite3.dll")


	;CreateIconList()

	$IconFile = $GGtunnelDir & "\GGT.ico"
	FileInstall("GGT.ico",$IconFile)
	GUICreate($GuiTitle, $GUIwidth, $GUIheight)

	GUISetIcon($IconFile)



    TraySetState()
    TraySetToolTip("GOGlobalTunnelGui " & $Fileversion & @CRLF & "(C) Alcatel-Lucent, March 2010" & @CRLF & "Henk.hulst@alcatel-lucent.nl")
    TraySetIcon($IconFile,6)
	$SettingsItem = TrayCreateItem("Settings")
	TrayItemSetOnEvent(-1,"Settings")
	$INIItem = TrayCreateItem("Edit INI file")
	TrayItemSetOnEvent(-1,"ViewINI")
	TrayCreateItem("")
	$UpdatesItem = TrayCreateItem("Check for Updates")
	TrayItemSetOnEvent(-1,"DownloadGGUpdate")
	$WebItem = TrayCreateItem("Website")
	TrayItemSetOnEvent(-1,"GGWebpage")
	TrayCreateItem("")
	$GGGuiItem = TrayCreateItem("Bring to front")
	TrayItemSetOnEvent(-1,"ActivateGGGui")
	TrayCreateItem("")
	$ExitItem = TrayCreateItem("Exit")
	TrayItemSetOnEvent(-1,"ExitGG")

	$OptionsMenu = GUICtrlCreateMenu("&Options")
	$SettingsItem = GUICtrlCreateMenuItem("&Settings", $OptionsMenu)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	$ViewMenu = GUICtrlCreateMenu("&View")
	$DBItem = GUICtrlCreateMenuItem("&Database", $ViewMenu)
	$ConnectedItem = GUICtrlCreateMenuItem("&Application sessions", $ViewMenu)
	$ConnectedPuTTYItem = GUICtrlCreateMenuItem("&Tunnel sessions", $ViewMenu)
	$LocalFWportsItem = GUICtrlCreateMenuItem("&Forwarded ports", $ViewMenu)
	;$DameWareItem = GUICtrlCreateMenuItem("&Antwerp ISDN connections", $ViewMenu)
	$INIViewItem = GUICtrlCreateMenuItem("&Settings INI file", $ViewMenu)
	$ToolsMenu = GUICtrlCreateMenu("&Tools")
	;$DameWareItem = GUICtrlCreateMenuItem("&Antwerp ISDN connections", $ToolsMenu)
	$DBUpdateUserPasswdItem = GUICtrlCreateMenuItem("&Update User/pwd in new DB", $ToolsMenu)
	$INIItem = GUICtrlCreateMenuItem("Edit Settings &INI file", $ToolsMenu)
	$ForwardItem = GUICtrlCreateMenuItem("&Local Port forwarding", $ToolsMenu)
	$CopyClip2VPCItem = GUICtrlCreateMenuItem("&Copy Clipboard to VirtualPC", $ToolsMenu)
	$SharedDriveItem = GUICtrlCreateMenuItem("&VirtualPC Shared Drive", $ToolsMenu)
	$CheckUsedVPCItem = GUICtrlCreateMenuItem("Check Used Win7 &VPC's", $ToolsMenu)
	;$KPNRamsesProxy = GUICtrlCreateMenuItem("&KPN Ramses Proxy settings", $ToolsMenu)
	$HelpMenu = GUICtrlCreateMenu("&Help")
	$UpdatesItem = GUICtrlCreateMenuItem("Check for &Updates", $HelpMenu)
	$DocsItem = GUICtrlCreateMenuItem("&Online Documentation", $HelpMenu)
	;$DDMItem = GUICtrlCreateMenuItem("DD&M (Old Customer info)", $HelpMenu)
	$SharePointItem = GUICtrlCreateMenuItem("&SharePoint Customer info", $HelpMenu)
	$WebItem = GUICtrlCreateMenuItem("&Website", $HelpMenu)
	$AboutItem = GUICtrlCreateMenuItem("&About", $HelpMenu)
	$DBmem = _SQLite_Open()
	_SQLite_Exec (-1, "CREATE TABLE cust (Id,customer);")
	_SQLite_Exec (-1, "CREATE TABLE connections (ServerId,Customer,host,IP,ConnectVia,PID,starttime);")
	_SQLite_Exec (-1, "CREATE TABLE PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime);")
	_SQLite_Exec (-1, "CREATE TABLE hosts (ServerId,CustId,Customer,HostId,Host,ServerIP,DameWareIP,GGversion,User,Password,TelnetConsole,WebConsole, tunnel, tunnelip, connected, lanconsole, Comment, NMtyp, NMrelease);")

	$DBs=""
	$Database = ""
	$DBCountryBox = ""

	;If FileExists($SQliteDB) Then $GGDB = _SQLite_Open ($SQliteDB)
	_PathSplit($SQliteDB, $szDrive,$szDir,$szFName,$szExt)
	$DrvStatus = DriveGetSerial($szDrive)
	If $DrvStatus Then
		If FileExists($SQliteDB) Then
			;MsgBox(0,"Databasename",$SQliteDB)
			$GGDB = _SQLite_Open($SQliteDB)
			If @error Then MsgBox(48,"Database error","Database can not be loaded!")


			_SQLite_Exec($DBmem,"DELETE FROM hosts;")
			If _SQLite_QuerySingleRow($GGDB,"SELECT serverid, autor, datum, comment from comments where id = 24",$hQuery3) = $SQLITE_OK Then
				_SQLite_QuerySingleRow($GGDB,"SELECT autor from comments where id = 1001",$uQuery)
				$UserEdit = $uQuery[0]
				$DBident = $hQuery3[0]
				If $DBident = "160569" Then
					$DBCountry = $hQuery3[1]
					$DBversion = $hQuery3[3]

					;MsgBox(0,"DBCountry",$DBCountry)
					If $DBCountry = "" Then
						If $DBCountryBox Then
							$DBCountry = $DBCountryBox
							$DBCountryBox = ""
						Else
							$DBCountry = InputBox("Database identifier missing","Please give database identifier" & @CRLF & "(NL, DE_NOC, DE_LAB):","","",220,130)
						EndIf
						$DBversion = "?"
					EndIf
					_SQLite_QuerySingleRow($GGDB,"SELECT serverid, autor, datum, comment from comments where id = 1000",$hQuery3)
					$DBidentArray = StringSplit($hQuery3[1]," ")
					;MsgBox(0,"DBarray",$hQuery3[2])
					$DBid=$DBidentArray[1]
					;MsgBox(0,"DBid " & $DBCountry,$DBid)
					;$DBident=$DBidentArray[1]
					;$DBpasswd = $DBidentArray[2]
					;$PassEncrypted = $DBpasswd
					$PassEncrypted = $DBidentArray[2]
					$DBParents = $hQuery3[3]
					$PossibleDBparents = ""
					$ArrayParents = StringSplit($hQuery3[3], ",")
					_SQLite_Query($GGDB,"select id from tree where parentid=0",$hQuery3)
					While _SQLite_FetchData ($hQuery3, $dRow) = $SQLITE_OK ;
						$PossibleDBparents = $dRow[0] & " " & $PossibleDBparents
					WEnd
					;MsgBox(0,"Possible Parents",$PossibleDBparents)
					;MsgBox(0,"parents",$ArrayParents[1])
				Else
					_SQLite_Close($GGDB)
					;MsgBox(48,"Database","Problem reading database!")
				EndIf
				;ReadAllDatabases()
			EndIf
		EndIf
	EndIf

	;MsgBox(0,"Database=","##" & $Database & "##")
	;MsgBox(0,"LastreadDB=","##" & $LastReadDatabase & "##")
	;MsgBox(0,"DBs",$DBs)
	;If $Database = " database v" Then $Database = $LastReadDatabase
	;MsgBox(0,"MyMenu DBs (regel 3784)",$DBs)
	;MsgBox(0,"Database=",$Database)
	If ($Database = " database v " Or $Database = "") Then $Database = "Choose Database !"
	GUICtrlCreateGroup("Database:",$leftDatabase,$topDatabase,$WidthDatabase,$HeightDatabase)
	$Database_ID = GUICtrlCreateCombo($Database,$leftDatabase + 7 ,$topDatabase + 15,$WidthTreeView,100 )

	;MsgBox(0,"Database before Combo",$Database)
	;$Database_ID = GUICtrlCreateCombo($Database,12 ,20,$TreeviewWidth-6,20 )

    ;GUICtrlSetData(-1, $DBs,$Database)

	;GUICtrlSetState($Database_ID,$GUI_FOCUS)


   	GUICtrlCreateGroup("Connect via:", $leftConnectVia, $topConnectVia, $WidthConnectVia, $HeightConnectVia)
	$RadioVLAN = GUICtrlCreateRadio("VLAN Lab NL", $leftConnectVia+10, $topConnectVia + 20, 120, 20)
	$RadioSwdl = GUICtrlCreateRadio("OfficeLAN NL", $leftConnectVia+10, $topConnectVia + 38, 90, 20)
	$RadioDEGW = GUICtrlCreateRadio("OfficeLAN DE", $leftConnectVia+10, $topConnectVia + 56, 90, 20)
	$RadioVPN = GUICtrlCreateRadio("Internet", $leftConnectVia+10, $topConnectVia + 74, 70, 20)
	;$RadioDame = GUICtrlCreateRadio("Antwerp PC's", $leftConnectVia+10, $topConnectVia + 92, 120, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	GUICtrlCreateGroup("Application:", $leftApplication, $topApplication, $WidthApplication, $HeightApplication)
	$RadioGG = GUICtrlCreateRadio("GOGlobal", $leftApplication+10, $topApplication + 20, 120, 20)
	$RadioSSH = GUICtrlCreateRadio("SSH", $leftApplication+10, $topApplication + 38, 120, 20)
	$RadioTelnet = GUICtrlCreateRadio("Telnet", $leftApplication+10, $topApplication + 56, 120, 20)
	$RadioSCP = GUICtrlCreateRadio("(Win)SCP", $leftApplication+10, $topApplication + 74, 120, 20)
	$Radioftp = GUICtrlCreateRadio("Ftp", $leftApplication+10, $topApplication + 92, 120, 20)
	$RadioWeb = GUICtrlCreateRadio("WebBrowser", $leftApplication+10, $topApplication + 110, 120, 20)
	$RadioLanConsole = GUICtrlCreateRadio("LanConsole", $leftApplication+10, $topApplication + 128, 120, 20)
	$RadioWebConsole = GUICtrlCreateRadio("WebConsole", $leftApplication+10, $topApplication + 146, 120, 20)
	$RadioTelnetConsole = GUICtrlCreateRadio("TelnetConsole", $leftApplication+10, $topApplication + 164, 120, 20)
	$RadioVNC = GUICtrlCreateRadio("VNC", $leftApplication+10, $topApplication + 182, 120, 20)
	$RadioRDP = GUICtrlCreateRadio("Remote Desktop", $leftApplication+10, $topApplication + 200, 120, 20)
	$RadioNX = GUICtrlCreateRadio("freeNX", $leftApplication+10, $topApplication + 218, 120, 20)
	$RadioTV = GUICtrlCreateRadio("TeamViewer", $leftApplication+10, $topApplication + 236, 120, 20)

	GUICtrlSetState($RadioGG, $GUI_CHECKED)
	$Application = "GG"
	;$ybottom = $ytopHostInfo + 214
	;$ybottom = $SSHytop + 299
	GUICtrlCreateLabel("", 0, $topActionButtons-10, $GUIwidth , 2, $SS_SUNKEN)
	$statebutton = GUICtrlCreateButton("&Reset", $leftActionButtons + 158, $topActionButtons, 70, 20)
	$cancelbutton = GUICtrlCreateButton("&Exit", $leftActionButtons + 238, $topActionButtons, 70, 20)
	;$statebutton = GUICtrlCreateButton("&Reset", $x2, $topActionButtons, 70, 20)
	;$cancelbutton = GUICtrlCreateButton("&Exit", $x2+80, $topActionButtons, 70, 20)
	$loadbutton = GUICtrlCreateButton("&Load", $leftActionButtons, $topActionButtons, 70, 20)
	$GObutton = GUICtrlCreateButton("&GO!", $leftActionButtons + 80, $topActionButtons, 70, 20)
	GUICtrlSetState(-1,$GUI_DISABLE)
	$GoState = "DISABLED"
	$ViaSelected = "FALSE"

	$VNCbuttonID = GUICtrlCreateButton("", $xtop+105, $ytop+15, 22, 20)
	_GUICtrlButton_SetImageList($VNCbuttonID, $hImage)
	GUICtrlSetState($VNCbuttonID, $GUI_HIDE)
	$CheckDialinbutton = GUICtrlCreateButton("&Check dialin connections", $xtop, $ytop+55, 130, 20)
	GUICtrlSetState($CheckDialinbutton, $GUI_HIDE)
	;$JumpHostbutton = GUICtrlCreateButton("&JUMP", 6+10+130, $ytopHostInfo, 40, 20)
	;GUICtrlSetState($JumpHostbutton, $GUI_HIDE)

	;If $SQLITE_OK Then StartMyMenu()
	If $DBCountry Then StartMyMenu()
	;StartMyMenu()

	GUISetState()

	If $GGUpdateCheck = "1" Then DownloadGGUpdate()
	$olditem = "0"
	While 1
		$msg = GUIGetMsg()
		If Not InetGetInfo($httpDownlGG,2) AND $httpDownlGG Then
			;MsgBox(0,"download","##" & InetGetInfo($httpDownlGG,2) & "### " & $httpDownlGG)
			TrayTip("Downloading GGTunnelGui version " & $NewFileVersion, InetGetInfo($httpDownlGG,0) & " Bytes", 10, 16)
			Sleep(250)
		EndIf
		; 20120520 commented next line and replaced it for the next:
		;If (Not InetGetInfo($httpDownlGG,2)) AND $UpdateOnGoing = "TRUE"  Then
		If (InetGetInfo($httpDownlGG,2)) AND $UpdateOnGoing = "TRUE"  Then
			If $UpdateGGID = "6" Then
				MsgBox(48,"Download of GGTunnelGUI-v" & $NewFileVersion & "-Full-Installer.exe","Download of GGTunnel Installer version " & $NewFileVersion & " completed!" & @CRLF & "Please close the application and run the Installer" & @CRLF & "of the new version " & $NewFileVersion & " !!")
				ShellExecute($TEMPDIR & "\GGTunnelGUI-v" & $NewFileVersion & "-Full-Installer.exe","","","open")
			EndIf
			DownloadDBUpdate()
			$UpdateOnGoing = ""
		EndIf
		If (Not InetGetInfo($httpDownlDB,2)) AND $UpdateDBOnGoing = "TRUE" Then
			MsgBox(0,"Download DB","Download of DB version " & $NewFileVersion & " completed!" & @CRLF & "     The new database will be loaded.")
			$UpdateDBOnGoing = ""
			IniWrite($INIDir & $INIFile, "SQLite Database", "SQLiteDB", $SQliteDB)
			ReadSettings()
			;;;;;;;;;;;;_SQLite_Close()
			;_SQLite_Close($SQliteDB)
			_SQLite_Close($GGDB)
			;;;;;;;;;;;;;;;_SQLite_Shutdown ()
			;_SQLite_Shutdown()

			FileClose($GGDBold)
			;MsgBox(0,"old DB",$SQliteDB_old)
			FileMove($SQliteDB_old,$SQliteDB_old & ".old")
			;_SQLite_Startup()
			$GGDB = _SQLite_Open ($SQliteDB)
			;$DBmem = _SQLite_Open()
			;_SQLite_Exec (-1, "CREATE TABLE cust (Id,customer);")
			;_SQLite_Exec (-1, "CREATE TABLE hosts (ServerId,CustId,Customer,HostId,Host,ServerIP,DameWareIP,GGversion,User,Password,TelnetConsole,WebConsole, tunnel, tunnelip, connected, lanconsole);")
			;;;_SQLite_Exec (-1, "CREATE TABLE cust (Id,customer);")
			;_SQLite_Exec (-1, "CREATE TABLE connections (ServerId,Customer,host,IP,ConnectVia,PID,starttime);")
			;_SQLite_Exec (-1, "CREATE TABLE PuTTYconnections (PConn,Customer,host,IP,ConnectVia,PID,starttime);")
			;;;_SQLite_Exec (-1, "CREATE TABLE hosts (ServerId,CustId,Customer,HostId,Host,ServerIP,DameWareIP,GGversion,User,Password,TelnetConsole,WebConsole, tunnel, tunnelip, connected, lanconsole);")

			StartMyMenu()
		EndIf
		;CheckApplicationBox($msg,$item,"Main")
		Select
			Case $msg = $RadioSwdl And BitAND(GUICtrlRead($RadioSwdl), $GUI_CHECKED) = $GUI_CHECKED
				$ConnectVia = "sdhswdl"
				;ProcessClose($SwdlPID)
				;ProcessWaitClose($SwdlPID)
				$AlcanetGW = $AlcanetGWNL
				;MsgBox(0,"Main",$AlcanetGW)
				$AlcanetGWUser = $AlcanetGWNLUser
				$AlcanetGWPasswd = $AlcanetGWNLPasswd
				$ISDNGW = $nlsdh1
				$SSHlport2 = "2222"
				HideViaOptions()
				$ViaSelected = "TRUE"
				StartMyMenu()
			Case $msg = $RadioDEGW And BitAND(GUICtrlRead($RadioDEGW), $GUI_CHECKED) = $GUI_CHECKED
				$ConnectVia = "slsvho"
				;ProcessClose($SwdlPID)
				;ProcessWaitClose($SwdlPID)
				$AlcanetGW = $AlcanetGWDE
				$AlcanetGWUser = $AlcanetGWDEUser
				$AlcanetGWPasswd = $AlcanetGWDEPasswd
				$ISDNGW = $rmthtl
				$SSHlport2 = "2221"
				;MsgBox(0,"radioGWDE",$RadioDEGW & "," & $AlcanetGWDE)
				HideViaOptions()
				$ViaSelected = "TRUE"
				StartMyMenu()
			Case $msg = $RadioVPN And BitAND(GUICtrlRead($RadioVPN), $GUI_CHECKED) = $GUI_CHECKED
				$ConnectVia = "Internet"
				HideViaOptions()
				EnableAllApplications()
				$ViaSelected = "TRUE"
				StartMyMenu()
			Case $msg = $RadioDame And BitAND(GUICtrlRead($RadioDame), $GUI_CHECKED) = $GUI_CHECKED
				$ConnectVia = "DameWare"
				HideViaOptions()
				$ViaSelected = "TRUE"
				EnableAllApplications()
				StartMyMenu()
			Case $msg = $RadioVLAN And BitAND(GUICtrlRead($RadioVLAN), $GUI_CHECKED) = $GUI_CHECKED
				$ConnectVia = "TTACVLAN"
				HideViaOptions()
				EnableAllApplications()
				$ViaSelected = "TRUE"
				StartMyMenu()
			Case $msg = $RadioGG And BitAND(GUICtrlRead($RadioGG), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "GG"
				LoadNMS($item)
			Case $msg = $RadioSSH And BitAND(GUICtrlRead($RadioSSH), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "SSH"
				LoadNMS($item)
			Case $msg = $RadioSCP And BitAND(GUICtrlRead($RadioSCP), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "SCP"
				LoadNMS($item)
			Case $msg = $Radioftp And BitAND(GUICtrlRead($Radioftp), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "ftp"
				LoadNMS($item)
			Case $msg = $RadioTelnet And BitAND(GUICtrlRead($RadioTelnet), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "Telnet"
				LoadNMS($item)
			Case $msg = $RadioLanConsole And BitAND(GUICtrlRead($RadioLanConsole), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "LanConsole"
				LoadNMS($item)
			Case $msg = $RadioTelnetConsole And BitAND(GUICtrlRead($RadioTelnetConsole), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "TelnetConsole"
				LoadNMS($item)
			Case $msg = $RadioWebConsole And BitAND(GUICtrlRead($RadioWebConsole), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "WebConsole"
				LoadNMS($item)
			Case $msg = $RadioWeb And BitAND(GUICtrlRead($RadioWeb), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "WEB"
				LoadNMS($item)
			Case $msg = $RadioVNC And BitAND(GUICtrlRead($RadioVNC), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "VNC"
				LoadNMS($item)
			Case $msg = $RadioRDP And BitAND(GUICtrlRead($RadioRDP), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "RDP"
				LoadNMS($item)

			Case $msg = $RadioNX And BitAND(GUICtrlRead($RadioNX), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "NX"
				LoadNMS($item)
			Case $msg = $RadioTV And BitAND(GUICtrlRead($RadioTV), $GUI_CHECKED) = $GUI_CHECKED
				$Application = "TV"
				LoadNMS($item)
			Case $msg = $ShowPasswd_ID And BitAND(GUICtrlRead($ShowPasswd_ID), $GUI_UNCHECKED) = $GUI_UNCHECKED
				$GGPassword = GuiCtrlRead($Password_ID)
				$ShowPasswd = GUICtrlRead($ShowPasswd_ID)
				GUICtrlDelete($Password_ID)
				$Password_ID = GUICtrlCreateInput($GGPassword, $leftHostInfo+10,$ytop+15, $InputLength1, 20,$ES_PASSWORD)
			Case $msg = $ShowPasswd_ID And BitAND(GUICtrlRead($ShowPasswd_ID), $GUI_CHECKED) = $GUI_CHECKED
				$GGPassword = GuiCtrlRead($Password_ID)
				$ShowPasswd = GUICtrlRead($ShowPasswd_ID)
				$ReadPW = InputBox("Encryption password","Give password to decrypt the user-passwords: ","","*",280,120)
				Sleep(200)
				If $ReadPW = $EncryptPassword Then
					GUICtrlDelete($Password_ID)
					$Password_ID = GUICtrlCreateInput($GGPassword, $leftHostinfo+10,$ytop+15, $InputLength1, 20)
				EndIf
			Case $msg = $UseHostAsHop_ID And BitAND(GUICtrlRead($UseHostAsHop_ID), $GUI_CHECKED) = $GUI_CHECKED
				$UseHostAsHop = GUICtrlRead($UseHostAsHop_ID)
				;MsgBox(0,"UseasHop",$UseHostAsHop)  =1 if checked !
				JumpToHost()
			Case $msg = $UseHostAsHop_ID And BitAND(GUICtrlRead($UseHostAsHop_ID), $GUI_UNCHECKED) = $GUI_UNCHECKED
				$UseHostAsHop = GUICtrlRead($UseHostAsHop_ID)
				;MsgBox(0,"UseasHop",$UseHostAsHop)

			Case $msg = $loadbutton
				DelInfoText3()
				LoadNMS($item)
			Case ($msg = $GObutton Or  (_IsPressed("0D") And WinActive($GuiTitle)))
				GoNMS()
				If ($Application = "WEB" And (StringInStr($uxversion,"ux") > 0 Or StringInStr($uxversion,"win") > 0)) Then
					GUICtrlSetState ($RadioGG,$GUI_CHECKED)
					$Application = "GG"
				EndIf
			Case $msg = $cancelbutton
				ExitLoop
			;Case $msg = $JumpHostbutton
			;	JumpToHost()
			Case $msg = $GUI_EVENT_CLOSE
				If MsgBox(4,"Exit GGTunnelGui application","                        Are you sure?     ") = 6 Then ExitLoop
				sleep(200)
			Case $msg = $VNCbuttonID
				$DameWarePC = GUICtrlRead($DameWarePC_ID)
				$passPassword = ""
				If FileGetVersion($VNCDIR ,"ProductName" ) = "UltraVNC VNCViewer" Then $passPassword = " /password tcp"
				;If $VNCDIR = "C:\Program Files\UltraVNC\vncviewer.exe" Then $passPassword = " /password tcp"
				run("""" & $VNCDIR & """" & " " & $DameWarePC & $passPassword)
			Case $msg = $CheckDialinbutton
				ShowDialinStatus()
				;MsgBox(0,"End", "End of Dialin with button")
			Case $msg = $SettingsItem
				Settings()
			Case $msg = $DBItem
				ViewDB()
			Case $msg = $INIViewItem
				ViewINI()
			Case $msg = $INIItem
				$DBold = $SQliteDB
				EditINI()
				;SetConstants()
				SetDefaultSettings()
				ReadSettings()
				If $DBold <> $SQliteDB Then
					_SQLite_Close ($GGDB)
					$GGDB = _SQLite_Open ($SQliteDB)
					_SQLite_Exec ($DBmem, "DELETE FROM cust;")
					_SQLite_Exec ($DBmem, "DELETE FROM hosts;")
					StartMyMenu()
				EndIf
			Case $msg = $ConnectedItem
				ShowConnections()
			Case $msg = $ConnectedPuTTYItem
				ShowPuTTYConnections()
			Case $msg = $LocalFWportsItem
				ShowFWPorts()
			Case $msg = $CopyClip2VPCItem
				CopyClipboard2VPC()
			;Case $msg =	$DameWareItem
			;	ShowDialinStatus()
			;	;MsgBox(0,"End", "End of Dialin via menu")
			Case $msg = $UpdatesItem
				DownloadGGUpdate()
			Case $msg = $DocsItem
				ShowDocs()
			;Case $msg = $DDMItem
			;	ShowWebDDM()
			Case $msg = $SharePointItem
				ShowSharePoint()
			Case $msg = $SharedDriveItem
				ShowSharedDrive()
			Case $msg = $CheckUsedVPCItem
				ShowUsedVPCs()
			;Case $msg = $KPNRamsesProxy
			;	;_ConfigLAN()
			;	SetRamsesProxies()
			Case $msg = $WebItem
				GGWebpage()
			Case $msg = $ForwardItem
				LocalPortForward()
			Case $msg = $AboutItem
				HelpAbout()
			Case $msg = $statebutton
				SetInfoText("Resetting all SSH connections !")
				EndProcesses("reset")
				RemovePuTTYSessions()
				RemoveFwTunnelSessions()
				DelInfoText()
				MsgBox(64,"Reset processes","All processes killed!")
				sleep(300)
			; The following items will hide the other labels (1st and 2nd parameter) and then show the 'own' labels (3rd and 4th parameter)
			Case $msg = $generalitem
				GUIChangeItems($aboutlabel, $compinfo, $startlabel, $startlabel)
			Case $msg = $aboutitem
				GUICtrlSetState($compinfo, $GUI_HIDE)
				GUIChangeItems($startlabel, $startlabel, $aboutlabel, $aboutlabel)

			Case $msg = $compitem
				GUIChangeItems($startlabel, $aboutlabel, $compinfo, $compinfo)
			Case $msg = $Database_ID
				$Database = GUICtrlRead($Database_ID)
				$DB_Index =  _ArraySearch($Databases,$Database,0,0,0,1)
				$DB_file = StringSplit($Databases[$DB_Index],"|")
				_SQLite_Close ($GGDB)
				$SQliteDB = $DB_file[1]
				IniWrite($INIDir & $INIFile, "SQLite Database", "SQLiteDB", $SQliteDB)
				$GGDB = _SQLite_Open ($SQliteDB)
				_SQLite_Exec($DBmem, "DELETE from cust;")
				_SQLite_Exec($DBmem, "DELETE from hosts;")
				StartMyMenu()
			Case $msg = $DBUpdateUserPasswdItem
				UpdateDBUserPasswd()
		EndSelect
		;MsgBox(0,"End Select Mainloop",$msg)
		;sleep(5000)
		;$olditem = $item
	WEnd
	GUIDelete()
	EndProcesses("end")
	RemovePuTTYSessions()
	RemoveFwTunnelSessions()
	;SaveSessionsToFile()
	_SQLite_Close()
	;_SQLite_Close($SQliteDB)
	_SQLite_Close($GGDB)
	_SQLite_Shutdown ()
EndFunc


SetConstants()
Main()
