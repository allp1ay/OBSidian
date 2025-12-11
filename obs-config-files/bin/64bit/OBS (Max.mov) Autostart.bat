@echo off

REM
start "" /D "%~dp0" obs64.exe --minimize-to-tray --disable-updater --disable-shutdown-check --disable-missing-files-check

REM
start "" /D "%~dp0" ALT+Z.exe
