@echo off
setlocal EnableDelayedExpansion

REM �r���h�Ώۃt�@�C���i�����j
set SRCFILE=%1

REM �R�}���h����
if "%SRCFILE%" == "" (
    echo ���̃R�}���h�̎g����:  bccs.bat  [�\�[�X�t�@�C����]  run�C��
    echo ��2���� run �ɉ���������͂����.exe�����s����܂��B
    echo �����t�@�C�� .exe �� [���݂̃f�B���N�g��]\bin �ɓ�����܂��B�Ȃ��ꍇ�͐������邩�I�ׂ܂��B
    exit /b
)
if "%SRCFILE%" == "help" (
    echo ���̃R�}���h�̎g����:  bccs.bat  [�\�[�X�t�@�C����]  run�C��
    echo ��2���� run �ɉ���������͂����.exe�����s����܂��B
    echo �����t�@�C�� .exe �� [���݂̃f�B���N�g��]\bin �ɓ�����܂��B�Ȃ��ꍇ�͐������邩�I�ׂ܂��B
    exit /b
)

REM �Ăяo�����̃J�����g�f�B���N�g�����擾
set SRCDIR=%cd%

REM �g���q�Ȃ��ŏo�̓t�@�C�������擾
for %%f in (%SRCFILE%) do set OUTFILE=%%~nf

REM �o�͐�t�H���_���Ȃ�������
if not exist "%SRCDIR%\bin" (
    set /p ANSWER=bin �t�H���_�����݂��܂���B�쐬���܂���? [y/n] 
    if /i "!ANSWER!" == "y" (
        mkdir "%SRCDIR%\bin"
    ) else (
        echo bin �t�H���_�����݂��Ȃ����߁A�����𒆎~���܂��B
        exit /b
    )
)

REM �R���p�C��
bcc32c %SRCDIR%\%SRCFILE% -o %SRCDIR%\bin\%OUTFILE%.exe

REM �R���p�C�����ʂ��m�F
if errorlevel 1 (
    echo �R���p�C���Ɏ��s���܂����B�ǂ�܂��A����Ȃ��Ƃ����邳�B
    exit /b
)

REM ��2�������������琶���t�@�C�����s
if not "%2" == "" (
    echo ^>^>^>
    echo ���s : [ %OUTFILE%.exe ]
    %SRCDIR%\bin\%OUTFILE%.exe
)

exit /b