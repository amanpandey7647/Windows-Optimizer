@echo off
setlocal EnableDelayedExpansion

title Windows Optimizer

:: Script Information
echo.
echo   --------------------------------------------------------
echo     Windows Optimizer v6.1 (Ultimate Performance)
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
echo    1.  Clear Temporary Files
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

    ipconfig /flushdns

    :: --- System-wide Temporary Files ---
    del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1
    rd /s /q "%SystemRoot%\Temp" >nul 2>&1
    md "%SystemRoot%\Temp" >nul 2>&1

    del /q /f /s "%SystemRoot%\Prefetch\*" >nul 2>&1
    rd /s /q "%SystemRoot%\Prefetch" >nul 2>&1
    md "%SystemRoot%\Prefetch" >nul 2>&1 
    :: --- End System-wide Temporary Files ---

    :: Standard Temporary File Cleanup 
    /s /f /q c:\windows\temp\*.*
    rd /s /q c:\windows\temp
    md c:\windows\temp
    del /s /f /q C:\WINDOWS\Prefetch
    del /s /f /q %temp%\*.*
    rd /s /q %temp%
    md %temp%
    del /f /q c:\windows\tempor~1
    cls
    pause
    echo Wait for a While
    del /s /f /q C:\Windows\temp
    del /s /f /q %USERPROFILE%\AppData\Local\Temp\*.*
    del /s /f /q %USERPROFILE%\AppData\LocalLow\Temp\*.*
    del /s /f /q %USERPROFILE%\history
    del /s /f /q %USERPROFILE%\cookies
    del /s /f /q %USERPROFILE%\recent
    del /s /f /q %USERPROFILE%\printers
    del /s /f /q c:\WIN386.SWP

    ::  C:\Windows Targeted Cleanup (More Controlled) 
    echo Cleaning temporary files in C:\Windows...
    for %%a in ( "*.tmp", "*.temp", "*.log", "*.bak", "*.old" ) do ( 
        del /s /f /q "C:\Windows\%%a" 2>nul  
    ) 

    :: SoftwareDistribution Cleanup (with user prompt)
    echo.
    set /P "confirm=Clean up SoftwareDistribution\Download folder? (Y/N)? "
    if /i "%confirm%"=="Y" (
        echo Cleaning SoftwareDistribution\Download...
        del /s /f /q "C:\Windows\SoftwareDistribution\Download\*"  
        rd /s /q "C:\Windows\SoftwareDistribution\Download" 
        md "C:\Windows\SoftwareDistribution\Download" 
    ) else (
        echo Skipping SoftwareDistribution\Download cleanup.
    )

    echo.
    echo  --------------------------------------------------------
    echo   Temporary Files Cleared!
    echo  --------------------------------------------------------
    pause

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
    echo   Group Policy and Performance Optimizations
    echo  --------------------------------------------------------
    echo.
    echo  WARNING: Modifying system settings can impact stability. 
    echo  Proceed with caution and create a restore point if needed.
    echo.
    echo  Choose an optimization:
    echo    1.  Delay Automatic Windows Updates (Less Secure)
    echo    2.  Disable User Account Control (UAC) Prompts (Not Recommended - Reduces Security)
    echo    3.  Enable Fast Startup (with Hibernation Tweaks)
    echo    4.  Disable Visual Effects (for best performance)
    echo    5.  Adjust Processor Scheduling 
    echo    6.  Manage Services (Advanced Users Only!)
    echo    7.  Back to Main Menu
    echo.
    choice /c 12345678 /n /m "Enter your choice: "

    if errorlevel 7 goto :MAIN_MENU
    if errorlevel 6 goto :MANAGE_SERVICES
    if errorlevel 5 goto :PROCESSOR_SCHEDULING
    if errorlevel 4 goto :DISABLE_VISUAL_EFFECTS 
    if errorlevel 3 goto :ENABLE_FAST_STARTUP
    if errorlevel 2 goto :DISABLE_UAC_PROMPTS
    if errorlevel 1 goto :DELAY_UPDATES 

:DELAY_UPDATES 
    echo  --------------------------------------------------------
    echo   WARNING: Delaying updates still carries security risks!
    echo   Ensure you apply updates manually and regularly.
    echo  --------------------------------------------------------
    echo.
    set /p "delayDays=Enter the number of days to delay updates (max 35): "
    if %delayDays% gtr 35 set delayDays=35
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d %delayDays% /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DeferQualityUpdatesPeriodInDays" /t REG_DWORD /d %delayDays% /f >nul 2>&1
    echo  - Updates delayed. Remember to install them manually.
    pause
    goto :GPEDIT

:DISABLE_UAC_PROMPTS
    echo  --------------------------------------------------------
    echo   WARNING: Disabling UAC significantly reduces security!
    echo   Proceed only if you understand the risks.
    echo  --------------------------------------------------------
    echo.
    pause 
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul 2>&1
    echo  - UAC prompts disabled. A restart is required.
    pause
    goto :GPEDIT

:ENABLE_FAST_STARTUP 
    powercfg /hibernate on >nul 2>&1  
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
    echo  - Fast Startup (with Hibernation) enabled.
    pause
    goto :GPEDIT

:DISABLE_VISUAL_EFFECTS
    echo  Disabling visual effects...
    pause
    reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 90010000 /f >nul 2>&1
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f >nul 2>&1
    echo  - Visual effects settings applied.
    pause
    goto :GPEDIT

:PROCESSOR_SCHEDULING
    echo.
    echo  --------------------------------------------------------
    echo   Processor scheduling options:
    echo     1. Optimize for Background Processes 
    echo     2. Optimize for Programs
    echo     3. Back to Previous Menu
    echo  --------------------------------------------------------
    echo.
    choice /c 123 /n /m "Enter your choice: "

    if errorlevel 3 goto :GPEDIT 
    if errorlevel 2 (
        powercfg /SETDCVALUEINDEX SCHEME_CURRENT 0b621858-018a-4bbb-a0e7-0e7f60eeec18 75b0ae3f-bce0-45ca-8c62-87d78b76c147 0
    ) else (
       powercfg /SETDCVALUEINDEX SCHEME_CURRENT 0b621858-018a-4bbb-a0e7-0e7f60eeec18 75b0ae3f-bce0-45ca-8c62-87d78b76c147 1
    )
    powercfg /SETACVALUEINDEX SCHEME_CURRENT 0b621858-018a-4bbb-a0e7-0e7f60eeec18 75b0ae3f-bce0-45ca-8c62-87d78b76c147 1
    echo  - Processor scheduling changed.
    pause
    goto :GPEDIT

:MANAGE_SERVICES
    echo.
    echo  --------------------------------------------------------
    echo   WARNING: Modifying services can make your system unstable!
    echo   Proceed with EXTREME CAUTION and only if you know 
    echo   exactly what you're doing. 
    echo  --------------------------------------------------------
    echo.
    pause

    echo  --------------------------------------------------------
    echo   Choose an action:
    echo      1. List All Services
    echo      2. Disable a Service (Recommended List)
    echo      3. Enable a Service
    echo      4. Set a Service to Manual (Start Only When Needed) 
    echo      5. Back to Previous Menu
    echo  --------------------------------------------------------
    choice /c 12345 /n /m "Enter your choice: "

    if errorlevel 5 goto :GPEDIT
    if errorlevel 4 goto :SET_SERVICE_MANUAL
    if errorlevel 3 goto :ENABLE_SERVICE
    if errorlevel 2 goto :DISABLE_RECOMMENDED_SERVICE 
    if errorlevel 1 goto :LIST_SERVICES

:LIST_SERVICES
    echo.
    echo  Listing services... (This might take a moment)
    echo.
    sc query type= service state= all | more
    pause
    goto :MANAGE_SERVICES

:DISABLE_RECOMMENDED_SERVICE
    echo.
    echo  --------------------------------------------------------
    echo   Potentially Safe Services to Disable (But Research First!):
    echo      1. Bluetooth Support Service (bthserv)
    echo      2. Fax 
    echo      3. Print Spooler (Spooler)
    echo      4. Windows Media Player Network Sharing Service
    echo      5. Downloaded Maps Manager (MapsBroker)
    echo      6. Offline Files (CscService)
    echo      7. Secondary Logon (seclogon)
    echo      8. Windows Error Reporting Service (WerSvc)
    echo      9. Back to Service Menu
    echo  --------------------------------------------------------
    choice /c 123456789 /n /m "Enter your choice (or 9 to go back): "

    if errorlevel 9 goto :MANAGE_SERVICES
    if errorlevel 8 set serviceName="WerSvc"
    if errorlevel 7 set serviceName="seclogon"
    if errorlevel 6 set serviceName="CscService" 
    if errorlevel 5 set serviceName="MapsBroker"
    if errorlevel 4 set serviceName="WMPNetworkSvc"
    if errorlevel 3 set serviceName="Spooler"
    if errorlevel 2 set serviceName="Fax"
    if errorlevel 1 set serviceName="bthserv"

    sc config "%serviceName%" start= disabled >nul 2>&1
    if %errorlevel% == 0 (
        echo  - Service "%serviceName%" disabled. 
    ) else (
        echo  - Error disabling service "%serviceName%". Make sure the name is correct.
    )
    pause
    goto :MANAGE_SERVICES

:ENABLE_SERVICE
    echo.
    set /p "serviceName=Enter the EXACT name of the service to enable: "
    sc config "%serviceName%" start= auto >nul 2>&1 
    if %errorlevel% == 0 (
        echo  - Service "%serviceName%" set to start automatically. 
    ) else (
        echo  - Error enabling service "%serviceName%". Make sure the name is correct.
    )
    pause
    goto :MANAGE_SERVICES

:SET_SERVICE_MANUAL
    echo.
    echo  --------------------------------------------------------
    echo   Services You Might Consider Setting to Manual: 
    echo      1. Application Identity (AppIDSvc)
    echo      2. Superfetch (SysMain) 
    echo      3. Back to Service Menu
    echo  --------------------------------------------------------
    choice /c 123 /n /m "Enter your choice (or 3 to go back): "

    if errorlevel 3 goto :MANAGE_SERVICES
    if errorlevel 2 set serviceName="SysMain"
    if errorlevel 1 set serviceName="AppIDSvc"

    sc config "%serviceName%" start= demand >nul 2>&1 
    if %errorlevel% == 0 (
        echo  - Service "%serviceName%" set to start manually (on demand).
    ) else (
        echo  - Error setting service "%serviceName%" to manual. Make sure the name is correct.
    )
    pause
    goto :MANAGE_SERVICES
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
