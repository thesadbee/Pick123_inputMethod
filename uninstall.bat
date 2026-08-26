@echo off
rem Pick123_inputMethod uninstaller.
rem Runs as Administrator:
rem   1) stop WeaselServer
rem   2) WeaselSetupx64 /u  -> unregister the IME/TSF from the language bar
rem   3) remove registry keys (HKLM Software\Rime, autorun)
rem   4) optionally delete the Rime user data folder
rem Logs every step to uninstall.log.
setlocal
set LOG=%~dp0uninstall.log
echo [%date% %time%] Pick123 uninstall START >> "%LOG%"

net session >nul 2>&1
set ADMIN=0
if %errorlevel%==0 set ADMIN=1
echo [%date% %time%] ADMIN=%ADMIN% >> "%LOG%"
if not %ADMIN%==1 goto elevate

:run
echo [%date% %time%] Running as Administrator. >> "%LOG%"
cd /d "%~dp0"

echo [%date% %time%] stopping server... >> "%LOG%"
call "%~dp0stop_service.bat" >> "%LOG%" 2>&1

echo [%date% %time%] unregister IME/TSF (WeaselSetupx64 /u)... >> "%LOG%"
"%~dp0WeaselSetupx64.exe" /u >> "%LOG%" 2>&1
set UNREGISTER_EXIT=%errorlevel%
echo [%date% %time%] after setup /u exit=%UNREGISTER_EXIT% >> "%LOG%"
if not "%UNREGISTER_EXIT%"=="0" goto unregister_failed

echo [%date% %time%] removing registry keys... >> "%LOG%"
reg delete "HKLM\Software\Rime" /f >> "%LOG%" 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v WeaselServer /f >> "%LOG%" 2>&1

echo [%date% %time%] DONE >> "%LOG%"

echo.
echo ============================================================
echo  Pick123_inputMethod uninstall finished.
echo  The IME has been unregistered from the language bar.
echo  You may now delete this folder.
echo.
echo  Optional: the Rime user data (your custom dictionaries) is in
echo  %APPDATA%\Rime. Delete it if you no longer need it.
echo  See uninstall.log in this folder for details.
echo ============================================================
echo.
pause
exit /b 0

:unregister_failed
echo [%date% %time%] ERROR: unregister failed with exit=%UNREGISTER_EXIT% >> "%LOG%"
echo.
echo ERROR: WeaselSetupx64.exe /u failed with exit code %UNREGISTER_EXIT%.
echo Uninstall stopped. See uninstall.log in this folder for details.
echo.
pause
exit /b %UNREGISTER_EXIT%

:elevate
echo [%date% %time%] Not admin, requesting elevation... >> "%LOG%"
echo Requesting administrator privileges... A UAC prompt should appear.
echo If it does NOT, right-click this file and choose "Run as administrator".
if "%*%"=="" (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
) else (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList '%*%' -Verb RunAs"
)
echo [%date% %time%] Elevation launched. >> "%LOG%"
echo.
echo Launching elevated instance. Watch the NEW elevated window.
pause
exit /b 0
