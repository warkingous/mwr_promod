@echo off
setlocal enabledelayedexpansion

rem Source file to copy – make sure test.flac is in the current directory
set "src=test.flac"

rem Loop over each line of loaded_sounds.txt
rem We use tokens=1,2,3 with comma as delimiter.
rem For lines with a single comma, token2 will have the path.
rem For lines with two commas, token2 is empty and token3 holds the path.
for /f "usebackq tokens=1,2,3 delims=," %%a in ("loaded_sounds.txt") do (
    rem Choose the nonempty token: if token2 (%%b) is empty, use token3 (%%c)
    set "relpath=%%b"
    if "%%b"=="" set "relpath=%%c"
    
    rem Replace forward slashes with backslashes for Windows paths
    set "relpath=!relpath:/=\!"
    
    rem Extract the directory (folder) and file name (without extension)
    for %%F in ("!relpath!") do (
        set "folder=%%~dpF"
        set "fname=%%~nF"
    )
    
    rem Remove a trailing backslash from the folder path if it exists
    if "!folder:~-1!"=="\" set "folder=!folder:~0,-1!"
    
    rem Create the directory (mkdir will create any necessary intermediate folders)
    mkdir "!folder!" 2>nul
    
    rem Copy the source file to the new location, renaming it with a .flac extension
    copy "%src%" "!folder!\!fname!.flac" >nul
    
    rem (Optional) Echo the action for confirmation:
    echo Copied "%src%" to "!folder!\!fname!.flac"
)

endlocal
echo.
echo All files created.
pause
