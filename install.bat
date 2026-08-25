@echo off
rem Pick123_inputMethod portable installer.
rem Runs as Administrator:
rem   1) WeaselDeployer /install   -> deploys Rime data (user dir, schemas)
rem   2) WeaselSetupx64 /s         -> registers the IME/TSF into the Windows
rem                                    keyboard layout + language bar
rem   3) start WeaselServer        -> runs the server
rem Logs every step to install.log.
setlocal
set LOG=%~dp0install.log
echo [%date% %time%] Pick123 install START >> "%LOG%"

rem --- check admin -------------------------------------------------
net session >nul 2>&1
set ADMIN=0
if %errorlevel%==0 set ADMIN=1
echo [%date% %time%] ADMIN=%ADMIN% >> "%LOG%"

if not %ADMIN%==1 goto elevate

:run
echo [%date% %time%] Running as Administrator. >> "%LOG%"
cd /d "%~dp0"

echo [%date% %time%] stopping old server... >> "%LOG%"
call "%~dp0stop_service.bat" >> "%LOG%" 2>&1

echo [%date% %time%] step1: WeaselDeployer /install (deploy data)... >> "%LOG%"
"%~dp0WeaselDeployer.exe" /install >> "%LOG%" 2>&1
echo [%date% %time%] after deploy exit=%errorlevel% >> "%LOG%"

echo [%date% %time%] step2: WeaselSetupx64 /s (register IME into language bar)... >> "%LOG%"
"%~dp0WeaselSetupx64.exe" /s >> "%LOG%" 2>&1
echo [%date% %time%] after setup exit=%errorlevel% >> "%LOG%"

echo [%date% %time%] step3: start server... >> "%LOG%"
start "" "%~dp0WeaselServer.exe"
echo [%date% %time%] DONE >> "%LOG%"

echo.
echo ============================================================
echo  Pick123_inputMethod install finished.
echo  Now: log out / reboot once, then enable Pick123 (Weasel)
echo  in: Settings - Time & Language - Language - your language -
echo       keyboard - add a keyboard.
echo  See install.log in this folder for details.
echo ============================================================
echo.
pause
exit /b 0

:elevate
echo [%date% %time%] Not admin, requesting elevation... >> "%LOG%"
echo Requesting administrator privileges... A UAC prompt should appear.
echo If it does NOT, right-click this file and choose "Run as administrator".
if "%*"=="" (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
) else (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList '%*' -Verb RunAs"
)
echo [%date% %time%] Elevation launched. >> "%LOG%"
echo.
echo Launching elevated instance. Watch the NEW elevated window.
pause
exit /b 0
