; Script generated by the HM NIS Edit Script Wizard.
RequestExecutionLevel admin

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "卸载睿课"
;!define SHORTCUT_NAME "睿课免费三分屏课件制作软件"
!define SHORTCUT_NAME "睿课"
!define PRODUCT_NAME_EN "ruike"
!define PRODUCT_VERSION "6.0.1.0"
!define PRODUCT_PUBLISHER "网梯科技"
!define PRODUCT_DESCRIPTION "网梯课件制作系统卸载工具"
!define COPYRIGHT "Beijing Whaty Info. and Tech. Development Co., Ltd."
!define PRODUCT_WEB_SITE "http://www.whaty.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\WhatyCwMaker.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${SHORTCUT_NAME}"
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


!include "MUI.nsh"
!include "nsDialogs.nsh"
!include "nsWindows.nsh"

ReserveFile "${NSISDIR}\Plugins\nsTBCIASkinEngine.dll"

; handle variables
Var UninstDlg
Var UninstDlg_txtUninst
Var UninstDlg_lblUninst
Var UninstDlg_chbxDeleteConfig
Var UninstDlg_chbx_state

; MUI Settings
!define MUI_ABORTWARNING
;!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_UNICON "files\uninst.ico"

UninstPage custom un.nsDialogsPage un.nsDialogsPageLeave
; Uninstaller pages
UninstPage    instfiles	""		un.UnInstallShow
; Language files
!insertmacro MUI_LANGUAGE "SimpChinese"
;BrandingText "Whaty WhatyCwMaker"
BrandingText "北京网梯科技发展有限公司"


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "temp_setup.exe"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""

SilentInstall silent
;ShowInstDetails hide
ShowUninstDetails hide

Section -Post
  WriteUninstaller "$TEMP\uninst.exe"
SectionEnd


Function un.onUninstSuccess
  HideWindow

  IfFileExists "$TEMP\UninstallFirst" endFunc

  MessageBox MB_ICONINFORMATION|MB_OK "'${SHORTCUT_NAME}'已成功地从你的计算机移除。"
  ;ExecShell "open" "iexplore.exe" " http://www.wenjuan.com/s/32Mnmy/"
endFunc:
FunctionEnd


Function un.onInit
  SetOutPath $temp\${PRODUCT_NAME_EN}Setup\res
  File ".\setup res\*.png"
  File ".\setup res\*.xml"

  StrCpy $UninstDlg_chbx_state "0"
  
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
    MessageBox MB_yesno  "安装程序检测到'${SHORTCUT_NAME}'正在运行!$\n是否关闭'${SHORTCUT_NAME}'以继续卸载?" idyes continue idno abort
  	abort:
  	Quit
  	continue:
      KillProcDLL::KillProc "WhatyCwMaker.exe"
  no_run:

FunctionEnd

Section Uninstall
  checkruikeplayer:
  FindProcDLL::FindProc "ruike-player.exe"
  StrCmp $R0 1 killruikeplayer checkwhaty
  killruikeplayer:
  KillProcDLL::KillProc "ruike-player.exe"
  FindProcDLL::FindProc "ruike-player.exe"
  StrCmp $R0 1 checkruikeplayer checkwhaty
  checkwhaty:

  ;安装目录 反注册
  UnRegDLL "$INSTDIR\WhatyAVRecorder.ocx"
  UnRegDLL "$INSTDIR\WhatyFlashPPT7.dll"
  UnRegDLL "$INSTDIR\WhatyPPT.dll"
  UnRegDLL "$INSTDIR\WhatyScreenCom.ocx"
  ;删除文件、快捷方式
  Delete "$INSTDIR\WhatyCwMaker.exe"
  ;SetShellVarContext all
  Delete "$DESKTOP\${SHORTCUT_NAME}.lnk"
  RMDir /r "$SMPROGRAMS\${SHORTCUT_NAME}"
  ;SetShellVarContext current
  ;删除目录
  RMDir /r "$INSTDIR"




  ${If} $UninstDlg_chbx_state != 0
    Delete "$APPDATA\Whaty\config.xml"
    Delete "$APPDATA\Whaty\courses.xml"
  ${EndIf}

  ;删除注册表
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  ;自动退出
  SetAutoClose true
SectionEnd

Function un.nsDialogsPage
	nsTBCIASkinEngine::InitTBCIASkinEngine /NOUNLOAD "$temp\${PRODUCT_NAME_EN}Setup\res" "UnInstallPackages.xml" "WizardTab" "${SHORTCUT_NAME}卸载程序"
	Pop $UninstDlg


	;全局按钮绑定函数
	;最小化按钮绑定函数
	GetFunctionAddress $0 un.OnGlobalMinFunc
	nsTBCIASkinEngine::OnControlBindNSISScript "minbtn" $0
	;关闭按钮绑定函数
	GetFunctionAddress $0 un.OnGlobalCancelFunc
	nsTBCIASkinEngine::OnControlBindNSISScript "closebtn" $0


	;----------------------------第一个页面-----------------------------------------------
	;开始卸载按钮
	nsTBCIASkinEngine::FindControl "uninstall_btn"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have uninstall_btn button"
	${Else}
		GetFunctionAddress $0 un.OnStartUnInstallBtnFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "uninstall_btn"  $0
	${EndIf}

	;反馈按钮
	nsTBCIASkinEngine::FindControl "feedback_btn"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have feedback_btn"
	${Else}
		GetFunctionAddress $0 un.OnFeedBackBtnFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "feedback_btn" $0
	${EndIf}

	;删除配置文件check
	nsTBCIASkinEngine::FindControl "delcfg_check"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have delcfg_check"
	${Else}
		GetFunctionAddress $0 un.OnDelcfgStateFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "delcfg_check" $0
	${EndIf}
	;----------------------------第三个页面-----------------------------------------------
	;完成按钮绑定函数
	nsTBCIASkinEngine::FindControl "ok_btn"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK "Do not have ok_btn button"
	${Else}
		GetFunctionAddress $0 un.OnFinishedBtnFunc
		nsTBCIASkinEngine::OnControlBindNSISScript "ok_btn"  $0
	${EndIf}

	;---------------------------------显示------------------------------------------------
	nsTBCIASkinEngine::ShowPage


FunctionEnd

Function un.nsDialogsPageLeave
  ; ${NSD_GetState} $UninstDlg_chbxDeleteConfig $UninstDlg_chbx_state
FunctionEnd


Function un.UnInstallShow
   ;进度条绑定函数
   ShowWindow $HWNDPARENT ${SW_HIDE}
   ${NSW_SetWindowSize} $HWNDPARENT 0 0 ;改变自定义窗体大小

   nsTBCIASkinEngine::FindControl "progress_bar"
   Pop $0
   ${If} $0 == "-1"
	MessageBox MB_OK "Do not have progress_bar"
   ${Else}
	nsTBCIASkinEngine::StartUninstall  progress_bar  percent_label "${SHORTCUT_NAME}卸载中 %.0f%%"
   ${EndIf}
FunctionEnd

;开始卸载按钮
Function un.OnStartUnInstallBtnFunc
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "你确实要完全移除'${SHORTCUT_NAME}'，其及所有的组件？$\n" IDNO +3
	nsTBCIASkinEngine::TBCIASendMessage $UninstDlg WM_TBCIASTARTUNINSTALL
	nsTBCIASkinEngine::ResizeWindow 529 600

FunctionEnd

;反馈按钮
Function un.OnFeedBackBtnFunc
	ExecShell "open" "iexplore.exe" "http://www.wenjuan.com/s/32Mnmy/"
	nsTBCIASkinEngine::ExitTBCIASkinEngine
FunctionEnd

;卸载完成按钮
Function un.OnFinishedBtnFunc
	nsTBCIASkinEngine::ExitTBCIASkinEngine
FunctionEnd

Function un.OnGlobalMinFunc
	nsTBCIASkinEngine::TBCIASendMessage $UninstDlg WM_TBCIAMIN
FunctionEnd

Function un.OnGlobalCancelFunc
    nsTBCIASkinEngine::ExitTBCIASkinEngine
FunctionEnd

Function un.OnDelcfgStateFunc
  nsTBCIASkinEngine::TBCIASendMessage $UninstDlg WM_TBCIAOPTIONSTATE "delcfg_check" ""
   Pop $1
   ${If} $1 == "1"
      StrCpy $UninstDlg_chbx_state "1"
   ${Else}
      StrCpy $UninstDlg_chbx_state "0"
   ${EndIf}
FunctionEnd