@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul

REM Input source file
set SRCFILE=%1

REM Usage
if "%SRCFILE%" == "" (
    echo Usage: bcc.bat [source file] [run]
    echo If you pass any second argument, the generated .exe will run.
    echo Run this from any folder under the src tree.
    echo Source files are expected to live under the project src folder.
    echo The generated .exe is placed in the project build folder.
    exit /b
)
if "%SRCFILE%" == "help" (
    echo Usage: bcc.bat [source file] [run]
    echo If you pass any second argument, the generated .exe will run.
    echo Run this from any folder under the src tree.
    echo Source files are expected to live under the project src folder.
    echo The generated .exe is placed in the project build folder.
    exit /b
)

REM Current working directory
set SRCDIR=%cd%

REM Walk upward until app\bcc.bat is found, then treat that as the project root
set "SEARCHDIR=%SRCDIR%"

:FIND_PROJECT_ROOT
if exist "%SEARCHDIR%\app\bcc.bat" (
    set "PROJECTDIR=%SEARCHDIR%"
    goto PROJECT_ROOT_FOUND
)

for %%I in ("%SEARCHDIR%\..") do set "PARENTDIR=%%~fI"
if /i "%PARENTDIR%"=="%SEARCHDIR%" (
    echo Could not find the project root. Run this from under the src tree.
    exit /b
)

set "SEARCHDIR=%PARENTDIR%"
goto FIND_PROJECT_ROOT

:PROJECT_ROOT_FOUND

REM Strip extension from the source file name
for %%f in (%SRCFILE%) do (
    set "SRCNAME=%%~nf"
)

REM Build a hyphenated prefix from the path below src (e.g. src\02\no2 -> 02-no2)
set "AFTER=!SRCDIR:%PROJECTDIR%\src\=!"
if "!AFTER!"=="!SRCDIR!" (
    set "PREFIX="
) else (
    set "AFTER=!AFTER:\=-!"
    set "PREFIX=!AFTER!-"
)

set "OUTFILE=!PREFIX!!SRCNAME!"

REM Create build if needed
if not exist "%PROJECTDIR%\build" (
    set /p ANSWER=build folder does not exist. Create it? [y/n] 
    if /i "!ANSWER!" == "y" (
        mkdir "%PROJECTDIR%\build"
    ) else (
        echo build folder does not exist. Aborting.
        exit /b
    )
)

REM Compile
bcc32c "%SRCDIR%\%SRCFILE%" -o "%PROJECTDIR%\build\!OUTFILE!.exe"

REM Check compile result
if errorlevel 1 (
    echo Compile failed.
    exit /b
)

REM Run the generated file if a second argument was provided
if not "%2" == "" (
    echo ^>^>^>
    echo Run: [ !OUTFILE!.exe ]
    "%PROJECTDIR%\build\!OUTFILE!.exe"
)

exit /b