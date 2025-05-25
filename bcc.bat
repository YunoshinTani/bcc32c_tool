@echo off
setlocal EnableDelayedExpansion

REM ビルド対象ファイル（引数）
set SRCFILE=%1

REM コマンド説明
if "%SRCFILE%" == "" (
    echo このコマンドの使い方:  bcc.bat  [ソースファイル名]  run任意
    echo 第2引数 run に何かしら入力すると.exeが実行されます。
    echo 必ず [親ディレクトリ]/[src] フォルダー上で実行してください。
    echo ソースコードは [親ディレクトリ]\[src] に入れるのを想定しています。
    echo 生成ファイル .exe は [親ディレクトリ]\bin に入れられます。ない場合は生成するか選べます。
    exit /b
)
if "%SRCFILE%" == "help" (
    echo このコマンドの使い方:  bcc.bat  [ソースファイル名]  run任意
    echo 第2引数 run に何かしら入力すると.exeが実行されます。
    echo 必ず [親ディレクトリ]/[src] フォルダー上で実行してください。
    echo ソースコードは [親ディレクトリ]\[src] に入れるのを想定しています。
    echo 生成ファイル .exe は [親ディレクトリ]\bin に入れられます。ない場合は生成するか選べます。
    exit /b
)

REM 呼び出し元のカレントディレクトリを取得
set SRCDIR=%cd%

REM SRCDIRから1階層上のディレクトリを取得
for %%I in ("%SRCDIR%\..") do set "PROJECTDIR=%%~fI"

REM 拡張子なしで出力ファイル名を取得
for %%f in (%SRCFILE%) do set OUTFILE=%%~nf

REM 出力先フォルダがなかったら
if not exist "%PROJECTDIR%\bin" (
    set /p ANSWER=bin フォルダが存在しません。作成しますか? [y/n] 
    if /i "!ANSWER!" == "y" (
        mkdir "%PROJECTDIR%\bin"
    ) else (
        echo bin フォルダが存在しないため、処理を中止します。
        exit /b
    )
)

REM コンパイル
bcc32c %SRCDIR%\%SRCFILE% -o %PROJECTDIR%\bin\%OUTFILE%.exe

REM コンパイル結果を確認
if errorlevel 1 (
    echo コンパイルに失敗しました。ざーこざーこ。
    exit /b
)

REM 第2引数があったら生成ファイル実行
if not "%2" == "" (
    echo ^>^>^>
    echo 実行 : [ %OUTFILE%.exe ]
    %PROJECTDIR%\bin\%OUTFILE%.exe
)

exit /b