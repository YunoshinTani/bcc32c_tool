@echo off
setlocal EnableDelayedExpansion

REM �r���h�Ώۃt�@�C���i�����j
set SRCFILE=%1

REM �R�}���h����
if "%SRCFILE%" == "" (
    echo ���̃R�}���h�̎g����:  bcc.bat  [�\�[�X�t�@�C����]  run�C��
    echo ��2���� run �ɉ���������͂����.exe�����s����܂��B
    echo �K�� [�e�f�B���N�g��]/[src] �t�H���_�[��Ŏ��s���Ă��������B
    echo �\�[�X�R�[�h�� [�e�f�B���N�g��]\[src] �ɓ����̂�z�肵�Ă��܂��B
    echo �����t�@�C�� .exe �� [�e�f�B���N�g��]\bin �ɓ�����܂��B�Ȃ��ꍇ�͐������邩�I�ׂ܂��B
    exit /b
)
if "%SRCFILE%" == "help" (
    echo ���̃R�}���h�̎g����:  bcc.bat  [�\�[�X�t�@�C����]  run�C��
    echo ��2���� run �ɉ���������͂����.exe�����s����܂��B
    echo �K�� [�e�f�B���N�g��]/[src] �t�H���_�[��Ŏ��s���Ă��������B
    echo �\�[�X�R�[�h�� [�e�f�B���N�g��]\[src] �ɓ����̂�z�肵�Ă��܂��B
    echo �����t�@�C�� .exe �� [�e�f�B���N�g��]\bin �ɓ�����܂��B�Ȃ��ꍇ�͐������邩�I�ׂ܂��B
    exit /b
)

REM �Ăяo�����̃J�����g�f�B���N�g�����擾
set SRCDIR=%cd%

REM SRCDIR����1�K�w��̃f�B���N�g�����擾
for %%I in ("%SRCDIR%\..") do set "PROJECTDIR=%%~fI"

REM �g���q�Ȃ��ŏo�̓t�@�C�������擾
for %%f in (%SRCFILE%) do set OUTFILE=%%~nf

REM �o�͐�t�H���_���Ȃ�������
if not exist "%PROJECTDIR%\bin" (
    set /p ANSWER=bin �t�H���_�����݂��܂���B�쐬���܂���? [y/n] 
    if /i "!ANSWER!" == "y" (
        mkdir "%PROJECTDIR%\bin"
    ) else (
        echo bin �t�H���_�����݂��Ȃ����߁A�����𒆎~���܂��B
        exit /b
    )
)

REM �R���p�C��
bcc32c %SRCDIR%\%SRCFILE% -o %PROJECTDIR%\bin\%OUTFILE%.exe

REM �R���p�C�����ʂ��m�F
if errorlevel 1 (
    echo �R���p�C���Ɏ��s���܂����B���[�����[���B
    exit /b
)

REM ��2�������������琶���t�@�C�����s
if not "%2" == "" (
    echo ^>^>^>
    echo ���s : [ %OUTFILE%.exe ]
    %PROJECTDIR%\bin\%OUTFILE%.exe
)

exit /b