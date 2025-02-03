@echo off
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process cmd -Argument '%~s0' -Verb RunAs"
    exit /b
)

echo ===================================================
echo                Game Error Fixer Tool
echo  This fix will only work with R6 2018 Dodi Repacks
echo         for Dll errors and 0xc000007b error
echo                      By D4
echo ===================================================
echo.
echo Checking internet connection...(Press ctrl + C To Skip)
ping -n 1 google.com >nul 2>&1
if %errorLevel% NEQ 0 (
    echo You need an internet connection for this.
    pause
    exit /b
)
set "defaultDir=C:\Program Files (x86)\DODI-Repacks\Tom Clancys Rainbow Six Siege"
set "gameDir="

:askDefault
set /p "answer=Is the game installed in the default directory (Y/N)? "
if /I "%answer%"=="Y" (
    set "gameDir=%defaultDir%"
) else (
    set /p "gameDir=Please enter the game installation directory: "
)
if not exist "%gameDir%" (
    echo The specified directory does not exist. Please check the path.
    pause
    exit /b
)
set "assetsDir=%~dp0assets"
echo Installing DirectX...
echo This might take a while...
echo If some window opened and asked for restart press "NO"
start /wait "" "%assetsDir%\dxwebsetup.exe" /Q
echo Installing Visual C++ Redistributable...
start /wait "" "%assetsDir%\VisualCppRedist_AIO_x86_x64.exe" /aiA 
echo Installing .NET Runtime...
start /wait "" "%assetsDir%\windowsdesktop-runtime-9.0.1-win-x64.exe" /install /repair
echo Copying DLL files to the game directory...
copy "%assetsDir%\dll\*.dll" "%gameDir%"

echo Patched successfully!
echo Made by d4
pause