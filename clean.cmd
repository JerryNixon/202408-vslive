@echo off

REM Define the files to exclude from deletion
set excludeFile1=setup.cmd
set excludeFile2=clean.cmd
set excludeFile3=mssql.cmd
set excludeFile4=mssql.sql
set excludeFile5=sqlcmd.exe

REM Loop through all files in the current directory
for %%i in (*.*) do (
    REM Check if the current file is not one of the excluded files
    if /i not "%%i"=="%excludeFile1%" if /i not "%%i"=="%excludeFile2%" if /i not "%%i"=="%excludeFile3%" if /i not "%%i"=="%excludeFile4%" if /i not "%%i"=="%excludeFile5%" (
        del /f /q "%%i" 2>nul
    )
)

REM Loop through all directories in the current directory
for /d %%i in (*) do (
    rmdir /s /q "%%i" 2>nul
)

echo Clean-up complete!
