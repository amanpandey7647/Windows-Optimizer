@echo off
echo Windows Optimizer
echo Script Made By Aman Pandey
echo (C) [COPYRIGHT] Aman Pandey 2021 - 2025
echo [VERSION] 5.1
echo [Edition] Performance Boost
pause
cls
color 44
echo whats new in this version
echo Fixed Error of Run As Admin
echo reduced long runtimes
echo **Extra Layer of Cleaning [ADDED]**
echo fixed modules in this script
pause
color b

GOTO ADMIN_CHECK

:ADMIN_CHECK
	net session >nul 2>&1
	IF NOT %errorLevel% == 0 (
		COLOR C
		CLS
		ECHO Please run this script as Administrator
		PAUSE > NUL
		EXIT
	)
cls   												
echo Refreshing Windows For Smoother UX/UI
pause
ipconfig /flushdns
ipconfig /flushdns
ipconfig /flushdns
ipconfig /flushdns
ipconfig /flushdns
TASKKILL /F /IM dwm.exe
start dwm.exe
TASKKILL /F /IM explorer.exe
start explorer.exe
cls
tree
cls
/s /f /q c:\windows\temp\*.*
rd /s /q c:\windows\temp
md c:\windows\temp
del /s /f /q C:\WINDOWS\Prefetch
del /s /f /q %temp%\*.*
rd /s /q %temp%
md %temp%
del /f /q c:\windows\tempor~1
cls
echo Wait for a While
del /s /f /q C:\Windows\temp
del /s /f /q C:\Users\admin\AppData\Local\Temp\*.*
del /s /f /q c:\users\admin\history
del /s /f /q c:\users\admin\cookies
del /s /f /q c:\users\admin\recent
del /s /f /q c:\users\admin\printers
del /s /f /q c:\WIN386.SWP
echo Temporary Files cleared with success
for /F " tokens=*" %%G in ('wevtutil.exe el') DO (call :delfile "%%G")
echo Event Logs have been cleared! ^<press any key^>
pause
:delfile
echo CLEANING EVENTS %1
wevtutil.exe cl %1
goto :eof

:eof
exit