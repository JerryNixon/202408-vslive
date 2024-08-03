@echo off
setlocal enabledelayedexpansion

cd..

for %%i in (*.sln) do (
    del /f /q "%%i" 2>nul
)

for /d %%i in (*) do (
    if /i not "%%i"=="demo" (
        rmdir /s /q "%%i" 2>nul
    )
)

echo Clean-up complete!
