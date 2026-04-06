@echo off
setlocal
REM Infographic screenshot via Chrome/Edge headless — no Node.js required.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0screenshot.ps1" %*
exit /b %ERRORLEVEL%
