@echo off
setlocal enabledelayedexpansion

cd..

REM Loop through all directories in the current directory, including hidden
for /d %%i in (*) do (
    REM Check if the directory is not /demo
    if /i not "%%i"=="demo" (
        rmdir /s /q "%%i" 2>nul
    )
)

echo Clean-up complete!
