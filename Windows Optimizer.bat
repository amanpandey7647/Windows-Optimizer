@echo off
setlocal EnableDelayedExpansion

title Windows Optimizer

:: Script Information
echo.
echo   --------------------------------------------------------
echo     Windows Optimizer v6.0 (Ultimate Performance)
echo     Copyright (C) 2021-2025 Aman Pandey
echo   --------------------------------------------------------
echo.
pause
cls

:: Check for Administrator privileges
net session >nul 2>&1
IF NOT %errorLevel% == 0 (
    COLOR C
    CLS
    ECHO   Error: Please run this script as Administrator.
    PAUSE > NUL
    EXIT /B  
)

:: Color Scheme
color 0A

:: --------------------------------------
:: MAIN MENU
:: --------------------------------------
:MAIN_MENU
cls
echo  --------------------------------------------------------
echo   Windows Optimizer - Main Menu
echo  --------------------------------------------------------
echo.
echo  Choose an optimization option:
echo    1.  Clear Temporary Files (time consuming so start in last)
echo    2.  Restart Tasks
echo    3.  Defragment Disk (HDD Only)
echo    4.  Clear Event Logs
echo    5.  Optimize Network Settings
echo    6.  Registry Optimizations (Advanced)
echo    7.  Group Policy Optimizations (Advanced)
echo    8.  Ultimate Performance Mode (Advanced)
echo    9.  Maximum Responsiveness Mode (Advanced)
echo   10.  Gaming Tweaks
echo   11.  Exit 
echo.
choice /c 123456789AB /n /m "Enter your choice: "
if errorlevel 11 goto :eof 
if errorlevel 10 goto :GAMING_TWEAKS
if errorlevel 9 goto :MAX_RESPONSIVENESS
if errorlevel 8 goto :ULTIMATE_PERFORMANCE
if errorlevel 7 goto :GPEDIT
if errorlevel 6 goto :REGISTRY
if errorlevel 5 goto :NETWORK_OPTIMIZE
if errorlevel 4 goto :CLEAREVENTS
if errorlevel 3 goto :DEFRAG
if errorlevel 2 goto :STARTUP
if errorlevel 1 goto :CLEANTEMP

:: --------------------------------------
:: OPTIMIZATION MODULES
:: --------------------------------------

:: 1. Clear Temporary Files and Caches
:CLEANTEMP
    echo.
    echo  --------------------------------------------------------
    echo   Clearing Temporary Files & Caches... 
    echo  --------------------------------------------------------
    echo.
    del /f /q /s c:\windows\temp\*.* >nul 2>&1
    rd /s /q c:\windows\temp >nul 2>&1
    md c:\windows\temp

    del /f /q /s C:\WINDOWS\Prefetch\*.* >nul 2>&1
    del /f /q /s "%temp%\*.*" >nul 2>&1
    rd /s /q "%temp%" >nul 2>&1
    md "%temp%"

    del /f /q c:\windows\tempor~1 >nul 2>&1

    for /f "delims=" %%a in ('dir /b /s /ad C:\Users\*') do (
        if exist "%%a\AppData\Local\Temp" (
            del /f /q /s "%%a\AppData\Local\Temp\*.*" >nul 2>&1
            rd /s /q "%%a\AppData\Local\Temp" >nul 2>&1
            md "%%a\AppData\Local\Temp"
        )
        del /f /q /s "%%a\history\*.*" >nul 2>&1
        del /f /q /s "%%a\cookies\*.*" >nul 2>&1
        del /f /q /s "%%a\recent\*.*" >nul 2>&1
        del /f /q /s "%%a\Printers\*.*" >nul 2>&1
        timeout /t 0 >nul 2>&1 
    )

    echo  - Temporary files cleared successfully.
    pause
    goto :MAIN_MENU

:: 2. Manage Startup Programs
:STARTUP
    echo.
    echo  --------------------------------------------------------
    echo   Restarting explorer and dwm
    echo  --------------------------------------------------------
    echo.
    echo  Opening System Configuration...
    TASKKILL /F /IM dwm.exe
	start dwm.exe
	TASKKILL /F /IM explorer.exe
	start explorer.exe
    goto :MAIN_MENU

:: 3. Defragment Disk (HDD only)
:DEFRAG
    echo.
    echo  --------------------------------------------------------
    echo   Defragmenting Disk (HDD Only)...  
    echo  --------------------------------------------------------
    echo.
    echo  WARNING: This will defragment your C: drive. 
    echo           If you have an SSD, skip this step!
    echo.
    pause
    defrag c: /u /v
    goto :MAIN_MENU

:: 4. Clear Event Logs
:CLEAREVENTS
    echo.
    echo  --------------------------------------------------------
    echo   Clearing Event Logs...
    echo  --------------------------------------------------------
    echo.
    for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :delfile "%%G")
    echo  - Event logs cleared.
    pause
    goto :MAIN_MENU

:delfile 
    wevtutil.exe cl %1 >nul 2>&1
    goto :eof

:: 5. Network Optimizations
:NETWORK_OPTIMIZE
    echo.
    echo  --------------------------------------------------------
    echo   Optimizing Network Settings...
    echo  --------------------------------------------------------
    echo.
	ipconfig /flushdns
    
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DefaultTTL set to 64. 
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d 65535 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\GlobalMaxTcpWindowSize set to 65535.
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\MaxUserPort set to 65534.
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Tcp1323Opts set to 1. 
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d 2 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\TcpMaxDupAcks set to 2.
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPTimedWaitDelay" /t REG_DWORD /d 30 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\TCPTimedWaitDelay set to 30. 

    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d ffffffff /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\NetworkThrottlingIndex set to ffffffff. 
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d 0 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583\Attributes set to 0. 
    
    echo  - Network settings optimized. Some changes require a restart. 
    pause
    goto :MAIN_MENU

:: 6. Registry Optimizations (Advanced)
:REGISTRY
    cls
    echo  --------------------------------------------------------
    echo   Registry Optimizations (Advanced)
    echo  --------------------------------------------------------
    echo.
    echo  WARNING: Create a system restore point before proceeding!
    echo.
    echo  Choose a registry optimization:
    echo    1.  Disable Unnecessary Visual Effects 
    echo    2.  Disable Windows Defender (Not Recommended!)
    echo    3.  Enable "Ultimate Performance" Power Plan 
    echo    4.  Disable Superfetch Service 
    echo    5.  Disable Prefetch 
    echo    6.  Boost Menu Responsiveness 
    echo    7.  Back to Main Menu 
    echo.
    choice /c 1234567 /n /m "Enter your choice: "

    if errorlevel 7 goto :MAIN_MENU
    if errorlevel 6 goto :BOOST_MENU
    if errorlevel 5 goto :DISABLE_PREFETCH
    if errorlevel 4 goto :DISABLE_SUPERFETCH
    if errorlevel 3 goto :ENABLE_ULTIMATE_REG
    if errorlevel 2 goto :DISABLE_DEFENDER
    if errorlevel 1 goto :DISABLE_VISUAL_EFFECTS

:DISABLE_VISUAL_EFFECTS
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
    echo  - Registry key HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\VisualFXSetting set to 2.
    echo  - Unnecessary visual effects disabled. 
    pause
    goto :REGISTRY 

:DISABLE_DEFENDER
    echo.
    echo  --------------------------------------------------------
    echo   WARNING: Disabling Windows Defender is NOT recommended 
    echo   unless you have another antivirus installed and active! 
    echo  --------------------------------------------------------
    echo.
    pause 

   reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware set to 1.
    echo  - Windows Defender disabled. A restart might be required.
    pause
    goto :REGISTRY

:ENABLE_ULTIMATE_REG
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\75b0ae3f-bce0-45a7-8c89-c9611c224f84" /v "Attributes" /t REG_DWORD /d 2 /f >nul 2>&1
    echo  - Registry key HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\75b0ae3f-bce0-45a7-8c89-c9611c224f84\Attributes set to 2.
    echo  - "Ultimate Performance" power plan enabled in the registry.
    pause
    goto :REGISTRY

:DISABLE_SUPERFETCH
    sc config "SysMain" start= disabled >nul 2>&1
    net stop "SysMain" >nul 2>&1
    echo  - Service "SysMain" disabled.
    echo  - Superfetch service disabled.
    pause
    goto :REGISTRY

:DISABLE_PREFETCH
   reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters\EnablePrefetcher set to 0. 
    echo  - Prefetch disabled. 
    pause
    goto :REGISTRY

:BOOST_MENU
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 1 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\SystemResponsiveness set to 1. 
    echo  - Menu responsiveness boosted. 
    pause
    goto :REGISTRY

:: 7. Group Policy Optimizations (Advanced)
:GPEDIT
    cls 
    echo  --------------------------------------------------------
    echo   Group Policy Optimizations (Advanced)
    echo  --------------------------------------------------------
    echo.
    echo  WARNING: Modifying Group Policy settings can significantly 
    echo  impact your system. Proceed with extreme caution! 
    echo.
    echo  Choose a Group Policy optimization:
    echo    1.  Disable Automatic Windows Updates (Not Recommended!)
    echo    2.  Configure for Best Performance
    echo    3.  Disable User Account Control (UAC) Prompts (Not Recommended - Reduces Security)
    echo    4.  Back to Main Menu
    echo.
    choice /c 1234 /n /m "Enter your choice: "

    if errorlevel 4 goto :MAIN_MENU
    if errorlevel 3 goto :DISABLE_UAC_PROMPTS
    if errorlevel 2 goto :BEST_PERFORMANCE
    if errorlevel 1 goto :DISABLE_AUTO_UPDATES

:DISABLE_AUTO_UPDATES
    echo  --------------------------------------------------------
    echo   WARNING: Disabling automatic updates is NOT recommended!
    echo   It leaves your system vulnerable to security threats.
    echo  --------------------------------------------------------
    echo.
    pause 
    
    REM --- Add Group Policy commands to disable auto-updates here ---
    gpupdate /force
    echo  - Group Policy settings applied. 
    pause
    goto :GPEDIT

:BEST_PERFORMANCE
    echo  - Opening Group Policy Editor for performance settings...
    gpedit.msc /s ComputerConfiguration.AdministrativeTemplates.System.Performance
    pause
    goto :GPEDIT

:DISABLE_UAC_PROMPTS
    echo.
    echo  --------------------------------------------------------
    echo   WARNING: Disabling UAC prompts significantly reduces 
    echo   your system's security. It is NOT recommended!
    echo  --------------------------------------------------------
    echo.
    pause 

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul 2>&1
    echo  - Registry key HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA set to 0. 
    echo  - UAC prompts disabled. A restart is required.
    pause
    goto :GPEDIT

:: 8. Ultimate Performance Mode (Advanced)
:ULTIMATE_PERFORMANCE
    cls
    echo  --------------------------------------------------------
    echo   Ultimate Performance Mode (Advanced)
    echo  --------------------------------------------------------
    echo.
    echo  WARNING: Enabling Ultimate Performance Mode may increase 
    echo  power consumption and potentially impact hardware longevity. 
    echo  Use with caution!
    echo.
    echo  This option will:
    echo    - Enable the "Ultimate Performance" power plan.
    echo    - Apply additional system tweaks for maximum performance. 
    echo. 
    echo  Do you want to proceed?
    echo    1. Yes
    echo    2. No
    echo.
    choice /c 12 /n /m "Enter your choice: "

    if errorlevel 2 goto :MAIN_MENU

    echo  --------------------------------------------------------
    echo   Enabling Ultimate Performance Mode...
    echo  --------------------------------------------------------
    echo.

    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1 
    powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1

    REM --- AHCI Configuration (Check for IDE Mode first)
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\msahci" /v "Start" | find "0x00000003" >nul
    if %errorlevel% == 0 ( 
        echo  - AHCI is already enabled.
    ) else (
        REM --- AHCI is not enabled, provide instructions or attempt to enable it ---
        echo  - WARNING: Enabling AHCI requires additional steps in the BIOS 
        echo    and Registry. Make sure you understand the process before proceeding.
        echo  - For safety, this script will NOT automatically enable AHCI. 
        pause
    )

    REM --- Additional Performance Tweaks ---

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul 2>&1 
    echo  - Registry key HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\GlobalUserDisabled set to 1. 
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul 2>&1

    echo  - Ultimate Performance Mode enabled!
    pause
    goto :MAIN_MENU

:: 9. Maximum Responsiveness Mode (Advanced)
:MAX_RESPONSIVENESS
    cls
    echo  --------------------------------------------------------
    echo   Maximum Responsiveness Mode (Advanced)
    echo  --------------------------------------------------------
    echo.
    echo  WARNING: This mode applies aggressive optimizations,
    echo  which may impact stability or have unintended side effects. 
    echo  Create a system restore point before proceeding!
    echo.
    echo  This option will:
    echo    - Disable unnecessary services.
    echo    - Prioritize applications over background processes.
    echo    - Adjust visual effects for minimal overhead.
    echo    - And more... 
    echo.
    echo  Are you sure you want to proceed?
    echo    1. Yes, I understand the risks
    echo    2. No, take me back
    echo.
    choice /c 12 /n /m "Enter your choice: "
    if errorlevel 2 goto :MAIN_MENU

    echo  --------------------------------------------------------
    echo   Enabling Maximum Responsiveness Mode...
    echo  --------------------------------------------------------
    echo.

    sc config "SysMain" start= disabled >nul 2>&1
    net stop "SysMain" >nul 2>&1
    echo  - Service "SysMain" disabled.
    REM sc config "Spooler" start= disabled >nul 2>&1
    REM net stop "Spooler" >nul 2>&1
    REM echo  - Service "Spooler" disabled. (Only disable if you don't use a printer)

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f >nul 2>&1
    echo  - Registry key HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl\Win32PrioritySeparation set to 2.
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
    echo  - Registry key HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\VisualFXSetting set to 2. 

    echo  - Maximum Responsiveness Mode applied! A PC restart is recommended.
    pause
    goto :MAIN_MENU

:: 10. Gaming Tweaks
:GAMING_TWEAKS
    echo.
    echo  --------------------------------------------------------
    echo   Applying Gaming Tweaks...
    echo  --------------------------------------------------------
    echo.

    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling\PowerThrottlingOff set to 1.

    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d f /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Affinity set to f.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_DWORD /d 0 /f >nul 2>&1 
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Background Only set to 0.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Priority" /t REG_DWORD /d 1 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Background Priority set to 1.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\GPU Priority set to 8. 
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Priority set to 6.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Scheduling Category set to High. 
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1 
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\SFIO Priority set to High.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Rate" /t REG_DWORD /d 4 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\SFIO Rate set to 4.

    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Direct3D" /v "MaxPreRenderedFrames" /t REG_DWORD /d 1 /f >nul 2>&1
    echo  - Registry key HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Direct3D\MaxPreRenderedFrames set to 1.

    echo  - Gaming tweaks applied!
    pause
    goto :MAIN_MENU 

endlocal
exit /B 