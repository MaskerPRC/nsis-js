; Script generated by the HM NIS Edit Script Wizard.
RequestExecutionLevel admin

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "ruike"
!define PRODUCT_NAME_EN "ruike"
;!define SHORTCUT_NAME "睿课免费三分屏课件制作软件"
!define SHORTCUT_NAME "睿课"
!define VIDEOCLIPS_NAME "睿课课件编辑器"
!define PRODUCT_VERSION "6.0.1.0"
!define PRODUCT_PUBLISHER "网梯科技"
!define PRODUCT_DESCRIPTION "网梯课件制作系统"
!define COPYRIGHT "Beijing Whaty Info. and Tech. Development Co., Ltd."
!define PRODUCT_WEB_SITE "http://www.whaty.com"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"


VIProductVersion "${PRODUCT_VERSION}.1" ;必须4位
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "Comments" ""
VIAddVersionKey /LANG=2052 "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=2052 "ProductVersion" "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=2052 "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=2052 "FileDescription" "${PRODUCT_DESCRIPTION}"
VIAddVersionKey /LANG=2052 "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey /LANG=2052 "CompanyWebsite" "${PRODUCT_WEB_SITE}"

!include "WinVer.nsh"
; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "StrFunc.nsh"
!include "Library.nsh"
!include "LogicLib.nsh"
!include "nsDialogs.nsh"
!include "FileFunc.nsh"
!include "nsWindows.nsh"
!include "x64.nsh"

ReserveFile "${NSISDIR}\Plugins\nsTBCIASkinEngine.dll"

; handle variables
Var cp_Dialog
Var cp_Text_State

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "files\WhatyCwMaker.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

Page	custom		nsDialogsPage
Page    instfiles	""		InstallShow

; Language files
!insertmacro MUI_LANGUAGE "SimpChinese"
BrandingText "北京网梯科技发展有限公司"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "ruike_setup.exe"
InstallDir "$PROGRAMFILES\Whaty\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
;ShowInstDetails nevershow
;ShowUnInstDetails show

Section "MainSection" SEC01
    ;复制到安装目录
    SetOutPath "$INSTDIR"
    ;SetOverwrite try
    SetOverwrite on
    File "files\avcodec-57.dll"
    File "files\avdevice-57.dll"
    File "files\avfilter-6.dll"
    File "files\avformat-57.dll"
    File "files\avutil-55.dll"
    File "files\postproc-54.dll"
    File "files\SDL2.dll"
    File "files\swresample-2.dll"
    File "files\swscale-4.dll"
    File "files\WhatyCwMaker.exe"
	File "files\WhatyPPT.dll"
	File "files\WhatyPPT_x64.dll"
    File "files\libvlc.dll"
    File "files\libvlccore.dll"
	File "files\ZLibWrap.dll"
    File "files\NewVideoClips.exe"
	File "files\UpdateWindow.exe"
	File "files\CourseXMLConvert.exe"
    File "files\ffmpeg.exe"
	File "files\avcut.exe"
    File "files\uninst.exe"
	File "files\mfc100u.dll"
	File "files\mfc100.dll"
	File "files\vcomp100.dll"
	File "files\msvcr100.dll"
	File "files\msvcp100.dll"
    File "files\node.dll"
    File "files\mb.dll"
	;File "files\MP4Box.exe"
    ;文件夹
    
    ;复制miniblink模板文件
	RMDir /r "$INSTDIR\resources"
    SetOutPath "$INSTDIR\resources"
    File /r /x ".idea" "files\resources\*.*"
	;删除之间的安装记录
	Delete "$INSTDIR\localData"
	;删除之前模板
	RMDir /r "$INSTDIR\Template"
    SetOutPath "$INSTDIR\Template"
    File /r /x ".svn" "files\Template\*.*"
	SetOutPath "C:\Program Files (x86)\Whaty\WhatyView"
	File /r /x ".svn" "files\Template\WhatyView.exe"
	RMDir /r "$INSTDIR\avcut"
    SetOutPath "$INSTDIR\avcut"
    File /r /x ".svn" "files\avcut\*.*"
	RMDir /r "$INSTDIR\ruikeWebPlayer"
    SetOutPath "$INSTDIR\ruikeWebPlayer"
	File /r /x ".svn" "files\ruikeWebPlayer\*.*"
	SetOutPath "C:\Program Files (x86)\Whaty\ruikeWebPlayer"
    File /r /x ".svn" "files\ruikeWebPlayer\*.*"
	RMDir /r "$INSTDIR\images"
    SetOutPath "$INSTDIR\images"
    File /r /x ".svn" "files\images\*.*"
    SetOutPath "$INSTDIR\plugins"
	;删除无用插件
	RMDir /r "$INSTDIR\plugins"
    File /r /x ".svn" "files\plugins\*.*"
	RMDir /r "$INSTDIR\uires"
	;SetOutPath "$INSTDIR\virtualAudioCapturer"
	;RMDir /r "$INSTDIR\virtualAudioCapturer"
    ;File /r /x ".svn" "files\virtualAudioCapturer\*.*"

    SetOutPath "$INSTDIR"
    ;开始菜单与桌面快捷方式
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${SHORTCUT_NAME}.lnk" "$INSTDIR\WhatyCwMaker.exe"
    CreateShortCut "$DESKTOP\${SHORTCUT_NAME}.lnk" "$INSTDIR\WhatyCwMaker.exe"

    ;安装字体
    IfFileExists "$INSTDIR\font" PathGood
        RMDir /r "$INSTDIR\font"
        SetOutPath "$INSTDIR\font"
        File /r /x ".idea" "files\font\*.*"
        StrCpy $0 "$INSTDIR\font\PINGFANG MEDIUM.ttf"
        WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" "PINGFANG MEDIUM" "$0"
        System::Call "GDI32::AddFontResource(t) i ('$0') .s"
    PathGood:
	
    ;写入文件，标记保存路径
    FileOpen $4 "$INSTDIR\SavePath" w
    FileWrite $4 "$cp_Text_State"
    FileClose $4
    ; 创建课件保存目录
    SetOutPath "$cp_Text_State"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\卸载.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  ;WriteUninstaller "$INSTDIR\uninst.exe" ;卸载程序单独生成
  ;添加卸载信息到添加删除面板
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\WhatyCwMaker.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  ;以管理员身份运行
  WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\WhatyCwMaker.exe" "~ RUNASADMIN"
SectionEnd

Section -RegisterComp
  ;安装目录 自注册
  RegDLL "$INSTDIR\WhatyPPT.dll"
  RegDLL "$INSTDIR\WhatyPPT_x64.dll"
  
  RegDLL "$INSTDIR\mfc100u.dll"
  RegDLL "$INSTDIR\mfc100.dll"
  RegDLL "$INSTDIR\vcomp100.dll"
  RegDLL "$INSTDIR\msvcr100.dll"
  RegDLL "$INSTDIR\msvcp100.dll"
  ;RegDLL "$INSTDIR\virtualAudioCapturer\audio_sniffer.dll"
  ;RegDLL "$INSTDIR\virtualAudioCapturer\audio_sniffer-x64.dll"
  
  UnRegDLL "$INSTDIR\WhatyAVRecorder.ocx"
  UnRegDLL "$INSTDIR\WhatyScreenCom.ocx"
  Delete "$INSTDIR\WhatyAVRecorder.ocx"
  Delete "$INSTDIR\WhatyScreenCom.ocx"
  
  /*${If} ${RunningX64}
	ExecWait '"$INSTDIR\virtualAudioCapturer\vcredist_x64.exe" /q'
  ${Else} 
	ExecWait '"$INSTDIR\virtualAudioCapturer\vcredist_x86.exe" /q'
  ${EndIf}*/
SectionEnd

/******************************
*  以下是安装程序的卸载部分  *
******************************/
Section Uninstall
  ;安装目录 反注册
  UnRegDLL "$INSTDIR\WhatyFlashPPT7.dll"
  UnRegDLL "$INSTDIR\WhatyPPT.dll"
  UnRegDLL "$INSTDIR\WhatyPPT_x64.dll"
  ;UnRegDLL "$INSTDIR\virtualAudioCapturer\audio_sniffer.dll"
  ;UnRegDLL "$INSTDIR\virtualAudioCapturer\audio_sniffer-x64.dll"
  ;删除文件、快捷方式
  Delete "$INSTDIR\WhatyCwMaker.exe"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  ;删除目录
  RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
  RMDir /r "$INSTDIR"
  ;删除注册表
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_UNINST_KEY}"
  ;自动退出
  SetAutoClose true
SectionEnd

/* 根据 NSIS 脚本编辑规则,所有 Function 区段必须放置在 Section 区段之后编写,以避免安装程序出现未可预知的问题. */

Var bIsFound
Function "FindHDD"
    ${If} $bIsFound != "Found"
        ${If} ${FileExists} "$9MyCourses"
            ;已经存在目录，优先级最高
            StrCpy $R2 $9
            StrCpy $bIsFound "Found"
        ${Else}
            ;获取查找到的驱动器盘符($9)可用空间(/D=F)单位兆(/S=M)
            ${DriveSpace} $9 "/D=F /S=M" $R0
            ${If} $R0 > $R1
                StrCpy $R1 $R0
                StrCpy $R2 $9
            ${EndIf}
            Push $0
        ${EndIf}
    ${EndIf}
FunctionEnd

Function .onInit
    UserInfo::GetAccountType
    pop $0
    ;MessageBox MB_ICONINFORMATION "当前用户角色为$0"
    ${If} $0 != "admin" ;Require admin rights on NT4+
        MessageBox MB_ICONINFORMATION "请使用右键“以管理员身份运行”"
        SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        Quit
    ${EndIf}

  GetTempFileName $0

  SetOutPath $temp\${PRODUCT_NAME_EN}Setup\res
  File ".\setup res\*.png"
  File ".\setup res\*.xml"
  
  checkruikeplayer:
  FindProcDLL::FindProc "ruike-player.exe"
  StrCmp $R0 1 killruikeplayer checkwhaty
  killruikeplayer:
  KillProcDLL::KillProc "ruike-player.exe"
  FindProcDLL::FindProc "ruike-player.exe"
  StrCmp $R0 1 checkruikeplayer checkwhaty
  checkwhaty:
  FindProcDLL::FindProc "WhatyCwMaker.exe"
  StrCmp $R0 1 kill no_run

  kill:
    MessageBox MB_yesno  "安装程序检测到'${PRODUCT_NAME}'正在运行!$\n是否关闭'${PRODUCT_NAME}'以继续安装?" idyes continue idno abort
  	abort:
  	Quit
  	continue:
      KillProcDLL::KillProc "NewVideoClips.exe"
      KillProcDLL::KillProc "WhatyCwMaker.exe"
  no_run:
 ;禁止多次打开安装实例
 System::Call 'kernel32::CreateMutexA(i 0, i 0, t "WhatyCwMakerMutex") i .r1 ?e'
 Pop $R0

 StrCmp $R0 0 +3
   MessageBox MB_OK|MB_ICONEXCLAMATION "安装程序已经运行。"
   Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow

  IfFileExists "$TEMP\UninstallFirst" endFunc

  MessageBox MB_ICONINFORMATION|MB_OK "'${PRODUCT_NAME}'已成功地从你的计算机移除。"
  ExecShell "open" "iexplore.exe" " http://www.wenjuan.com/s/32Mnmy/"
endFunc:
FunctionEnd

Function un.onInit
  checkruikeplayer:
  FindProcDLL::FindProc "ruike-player.exe"
  StrCmp $R0 1 killruikeplayer checkwhaty
  killruikeplayer:
  KillProcDLL::KillProc "ruike-player.exe"
  FindProcDLL::FindProc "ruike-player.exe"
  StrCmp $R0 1 checkruikeplayer checkwhaty
  checkwhaty:
  FindProcDLL::FindProc "WhatyCwMaker.exe"
  StrCmp $R0 1 kill no_run
  kill:
    MessageBox MB_yesno  "安装程序检测到'${PRODUCT_NAME}'正在运行!$\n是否关闭'${PRODUCT_NAME}'以继续卸载?" idyes continue idno abort
  	abort:
  	Quit
  	continue:
      KillProcDLL::KillProc "NewVideoClips.exe"
      KillProcDLL::KillProc "WhatyCwMaker.exe"
  no_run:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "你确实要完全移除'${PRODUCT_NAME}'，其及所有的组件？$\n" IDYES +2
  Abort
FunctionEnd

Function nsDialogsPage
	nsTBCIASkinEngine::InitTBCIASkinEngine /NOUNLOAD "$temp\${PRODUCT_NAME_EN}Setup\res" "InstallPackages.xml" "WizardTab" "${SHORTCUT_NAME} ${PRODUCT_VERSION}安装程序"
	Pop $cp_Dialog

	;全局按钮绑定函数
	;最小化按钮绑定函数
	GetFunctionAddress $0 OnGlobalMinFunc
	nsTBCIASkinEngine::OnControlBindNSISScript "minbtn1" $0
	nsTBCIASkinEngine::OnControlBindNSISScript "minbtn2" $0
	nsTBCIASkinEngine::OnControlBindNSISScript "minbtn3" $0
	;关闭按钮绑定函数
	GetFunctionAddress $0 OnGlobalCancelFunc
	nsTBCIASkinEngine::OnControlBindNSISScript "closebtn1" $0
	nsTBCIASkinEngine::OnControlBindNSISScript "closebtn2" $0
	nsTBCIASkinEngine::OnControlBindNSISScript "closebtn3" $0

	;----------------------------第一个页面-----------------------------------------------
	;开始安装按钮
	nsTBCIASkinEngine::FindControl "start_btn"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have start_btn button"
	${Else}
		GetFunctionAddress $0 OnStartInstallBtnFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "start_btn"  $0
	${EndIf}

	;安装路径编辑框设定数据
	nsTBCIASkinEngine::FindControl "installpath_edit"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have installpath_edit"
	${Else}
		nsTBCIASkinEngine::SetControlData "installpath_edit"  $INSTDIR "text"
		GetFunctionAddress $0 OnInstallTextChangeFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "installpath_edit" $0
	${EndIf}
	;安装路径浏览按钮
	nsTBCIASkinEngine::FindControl "browse_installpath_btn"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have browse_installpath_btn button"
	${Else}
		GetFunctionAddress $0 fnc_cp_FileRequest_Click
		nsTBCIASkinEngine::OnControlBindNSISScript "browse_installpath_btn"  $0
	${EndIf}

	${GetDrives} "HDD" "FindHDD"
	StrCpy $cp_Text_State "$R2MyCourses"
	;课件保存路径编辑框设定数据
	nsTBCIASkinEngine::FindControl "datapath_edit"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have datapath_edit"
	${Else}
		nsTBCIASkinEngine::SetControlData "datapath_edit"  $cp_Text_State "text"
		GetFunctionAddress $0 OnDataTextChangeFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "datapath_edit" $0
	${EndIf}
	;课件保存路径浏览按钮
	nsTBCIASkinEngine::FindControl "browse_datapath_btn"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have browse_datapath_btn button"
	${Else}
		GetFunctionAddress $0 fnc_cp_DataPath_Click
		nsTBCIASkinEngine::OnControlBindNSISScript "browse_datapath_btn"  $0
	${EndIf}


	;----------------------------第三个页面-----------------------------------------------

	;完成按钮绑定函数
	nsTBCIASkinEngine::FindControl "run_btn"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have run_btn button"
	${Else}
		GetFunctionAddress $0 OnFinishedBtnFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "run_btn"  $0
	${EndIf}

	;---------------------------------显示------------------------------------------------
	nsTBCIASkinEngine::ShowPage


FunctionEnd


; 安装路径按钮点击事件
Function fnc_cp_FileRequest_Click
	nsDialogs::SelectFolderDialog /NOUNLOAD "请选择安装目录" "$R0"
	Pop $R0
	${If} "$R0" != "error"
		StrCpy $INSTDIR "$R0\${PRODUCT_NAME}"
		nsTBCIASkinEngine::SetControlData "installpath_edit"  $INSTDIR  "text"
	${EndIf}
FunctionEnd

; 课件保存路径按钮点击事件
Function fnc_cp_DataPath_Click
	nsDialogs::SelectFolderDialog /NOUNLOAD "请选择课件保存位置" "$R0"
	Pop $R0
	${If} "$R0" != "error"
		StrCpy $cp_Text_State $R0
		nsTBCIASkinEngine::SetControlData "datapath_edit"  $cp_Text_State  "text"
	${EndIf}
FunctionEnd

;安装过程函数
Function OnStartInstallBtnFunc
   nsTBCIASkinEngine::GetControlData installpath_edit "text"
   Pop $0
   StrCpy $INSTDIR $0
   nsTBCIASkinEngine::TBCIASendMessage $cp_Dialog WM_TBCIASTARTINSTALL
FunctionEnd

Function OnInstallTextChangeFunc
   nsTBCIASkinEngine::GetControlData installpath_edit "text"
   Pop $0
   ;MessageBox MB_OK $0
   StrCpy $INSTDIR $0
FunctionEnd

Function OnDataTextChangeFunc
   nsTBCIASkinEngine::GetControlData datapath_edit "text"
   Pop $0
   ;MessageBox MB_OK $0
   StrCpy $cp_Text_State $0
FunctionEnd

Function InstallShow
   ;进度条绑定函数
   ShowWindow $HWNDPARENT ${SW_HIDE}
   ${NSW_SetWindowSize} $HWNDPARENT 0 0 ;改变自定义窗体大小

   nsTBCIASkinEngine::FindControl "progress_bar"
   Pop $0
   ${If} $0 == "-1"
	MessageBox MB_OK "Do not have progress_bar"
   ${Else}
	nsTBCIASkinEngine::ResizeWindow 529 377
	nsTBCIASkinEngine::StartInstall  progress_bar  percent_label  "安装中:%.0f%%"
   ${EndIf}
FunctionEnd

Function OnGlobalMinFunc
   nsTBCIASkinEngine::TBCIASendMessage $cp_Dialog WM_TBCIAMIN
FunctionEnd

Function OnGlobalCancelFunc
   nsTBCIASkinEngine::TBCIASendMessage $cp_Dialog WM_TBCIACANCEL "${SHORTCUT_NAME}安装" "确定要退出睿课安装？"
   Pop $0
   ${If} $0 == "0"
     nsTBCIASkinEngine::ExitTBCIASkinEngine
   ${EndIf}
FunctionEnd

Function OnFinishedBtnFunc
	 Exec '"$INSTDIR\WhatyCwMaker.exe"'
	 nsTBCIASkinEngine::ExitTBCIASkinEngine
FunctionEnd
