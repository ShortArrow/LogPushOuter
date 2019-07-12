@echo off
echo "Let's Push Out the BackUp"
pushd %~dp0
pwsh -NoProfile -ExecutionPolicy Unrestricted "./main.ps1"
pause > nul
exit