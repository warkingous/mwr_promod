@echo off
setlocal enabledelayedexpansion

if not exist sounds2 mkdir sounds2

for /f "usebackq tokens=1,2 delims=," %%a in ("sounds.txt") do (
    set "jsonName=%%b"
    set "jsonName=!jsonName: =!"
    
    set "srcFile=sounds\!jsonName!.json"
    set "destFile=sounds2\!jsonName!.json"
    
    if exist "!srcFile!" (
        copy /Y "!srcFile!" "!destFile!" >nul

        rem Update volMin and volMax in the "head" array using a one-liner
        powershell -NoProfile -Command "(Get-Content '!destFile!' -Raw | ConvertFrom-Json) | ForEach-Object { foreach ($item in $_.head) { $item.volMin = 0; $item.volMax = 0 }; $_ } | ConvertTo-Json -Depth 10 | Set-Content '!destFile!'"
        
        echo Processed: !destFile!
    ) else (
        echo Source file not found: !srcFile!
    )
)

echo.
echo All JSON files processed.
pause
