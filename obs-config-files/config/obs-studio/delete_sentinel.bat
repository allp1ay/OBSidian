@echo off

REM
if exist "%~dp0.sentinel" (
    rmdir /s /q "%~dp0.sentinel"
)
