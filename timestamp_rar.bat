@echo off
setlocal enabledelayedexpansion

:: Get full folder path from argument
set "folder=%~1"

:: Extract folder name and parent directory
for %%F in ("%folder%") do (
    set "name=%%~nxF"
    set "parent=%%~dpF"
)

:: Format timestamp (YYYYMMDD_HHMM)
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%"
set "timestamp=%timestamp: =0%"

:: Build archive path (same level as folder)
set "archive=!parent!!name!_!timestamp!.zip"

powershell -NoProfile -Command "Add-Type -Assembly System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('!folder!', '!archive!')"

endlocal
