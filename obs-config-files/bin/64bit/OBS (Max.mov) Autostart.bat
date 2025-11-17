@echo off

REM
if exist "%~dp0.sentinel" (
    rmdir /s /q "%~dp0.sentinel"
)

REM
start "" /D "%~dp0" obs64.exe --minimize-to-tray --disable-updater --disable-shutdown-check --disable-missing-files-check

REM
start "" /D "%~dp0" ALT+Z.exe
