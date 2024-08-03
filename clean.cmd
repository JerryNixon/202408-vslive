@echo off
setlocal enabledelayedexpansion

REM Define the files to exclude from deletion as a space-separated list
set excludeFiles=setup.cmd clean.cmd mssql.cmd sqlcmd.exe HR.bak

REM Loop through all files in the current directory
for %%i in (*.*) do (
    REM Initialize a flag to check if the file is excluded
    set "isExcluded=0"
    REM Loop through each file in the exclude list
    for %%j in (%excludeFiles%) do (
        REM Check if the current file matches an excluded file
        if /i "%%i"=="%%j" set "isExcluded=1"
    )
    REM If the file is not excluded, delete it
    if "!isExcluded!"=="0" (
        del /f /q "%%i" 2>nul
    )
)

REM Loop through all directories in the current directory, including hidden
for /d %%i in (*) do (
    rmdir /s /q "%%i" 2>nul
)

echo Clean-up complete!
