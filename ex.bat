@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul

if "%1" == "" (
    set /p NUM=Enter the ex number [e.g. 04] : 
    set /p COUNT=Enter the number of files to generate : 
    set /p DIR=Enter the output directory path : 
) else (
    set NUM=%1
    set COUNT=%2
    set DIR=%3

    if "%3" == "" (
        set DIR=%cd%
    )
)

if not exist "%DIR%" (
    mkdir "%DIR%"
)

for /f "delims=" %%A in ('echo prompt $E$T ^| cmd') do set "TAB=	"

for /l %%i in (1,1,%COUNT%) do (
    set "IDX=0%%i"
    setlocal enabledelayedexpansion
    set "IDX=!IDX:~-2!"
    (
        echo /*
        echo  No.%NUM%   Q.!IDX!
        echo */
        echo #include ^<stdio.h^>
        echo.
        echo int main^(^)
        echo {
        echo.!TAB!
        echo.!TAB!
        echo.!TAB!
        echo.!TAB!return 0;
        echo }
        echo.
    ) > "%DIR%\ex%NUM%-!IDX!.c"
    powershell -NoProfile -Command "$path = '%DIR%\ex%NUM%-!IDX!.c'; $text = [System.IO.File]::ReadAllText($path); [System.IO.File]::WriteAllText($path, $text, [System.Text.UTF8Encoding]::new($false))"
    endlocal
)

echo Generation complete.