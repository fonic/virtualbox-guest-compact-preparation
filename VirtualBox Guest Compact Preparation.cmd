@echo off

REM ----------------------------------------------------------------------------
REM -                                                                          -
REM - VirtualBox Guest Compact Preparation                                     -
REM -                                                                          -
REM - Created by Fonic (https://github.com/fonic)                              -
REM - Date: 09/07/19 - 06/21/20                                                -
REM -                                                                          -
REM ----------------------------------------------------------------------------


REM ------------------------------------
REM -                                  -
REM - Globals                          -
REM -                                  -
REM ------------------------------------
:globals

REM Enter local environment scope
setlocal

REM Define globals
set SCRIPT_TITLE=VirtualBox Guest Compact Preparation
set SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%
set DSKCLN_EXEC=%SystemRoot%\System32\cleanmgr.exe
set DSKCLN_REG=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches
set DSKCLN_TASK=9999
set DISM_EXEC=%SystemRoot%\System32\Dism.exe
set DEFRAG_EXEC=%SystemRoot%\System32\Defrag.exe
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (set SDEL_EXEC=%SCRIPT_DIR%\sdelete\sdelete64.exe) else (set SDEL_EXEC=%SCRIPT_DIR%\sdelete\sdelete.exe)

REM Determine if script is running with administrator privileges
(net session >NUL 2>&1) && (set IS_ADMINISTRATOR=true) || (set IS_ADMINISTRATOR=false)

REM Determine if script was called from an interactive shell
(echo %CMDCMDLINE% | find /i "%~0" >NUL 2>&1) && (set IS_INTERACTIVE=false) || (set IS_INTERACTIVE=true)


REM ------------------------------------
REM -                                  -
REM - Main                             -
REM -                                  -
REM ------------------------------------
:main

REM Set window title, clear screen, print title
if "%IS_INTERACTIVE%" == "false" (
	title %SCRIPT_TITLE%
	cls
)
echo.
echo ---=== %SCRIPT_TITLE% ===---
echo.

REM Abort if not running with administrator privileges
if "%IS_ADMINISTRATOR%" == "false" (
	echo Error: this script needs to be run as administrator
	goto exit
)

REM Advise user to abort if guest is not up to date
echo If Windows guest is currently not up to date, please abort
echo now, perform update installation and run this script again.
echo.
choice /c yn /n /m "Continue [Y,N]?"
if %ERRORLEVEL% == 2 goto exit

REM Create disk cleanup task (same as GUI-based 'cleanmgr.exe /sageset:n')
echo.
echo Creating disk cleanup task...
reg query "%DSKCLN_REG%\Active Setup Temp Folders" >NUL 2>&1 && reg add "%DSKCLN_REG%\Active Setup Temp Folders" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\BranchCache" >NUL 2>&1 && reg add "%DSKCLN_REG%\BranchCache" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Content Indexer Cleaner" >NUL 2>&1 && reg add "%DSKCLN_REG%\Content Indexer Cleaner" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\D3D Shader Cache" >NUL 2>&1 && reg add "%DSKCLN_REG%\D3D Shader Cache" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Delivery Optimization Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Delivery Optimization Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Device Driver Packages" >NUL 2>&1 && reg add "%DSKCLN_REG%\Device Driver Packages" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Diagnostic Data Viewer database files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Diagnostic Data Viewer database files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Downloaded Program Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Downloaded Program Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\DownloadsFolder" >NUL 2>&1 && reg add "%DSKCLN_REG%\DownloadsFolder" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\GameNewsFiles" >NUL 2>&1 && reg add "%DSKCLN_REG%\GameNewsFiles" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\GameStatisticsFiles" >NUL 2>&1 && reg add "%DSKCLN_REG%\GameStatisticsFiles" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\GameUpdateFiles" >NUL 2>&1 && reg add "%DSKCLN_REG%\GameUpdateFiles" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Internet Cache Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Internet Cache Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Language Pack" >NUL 2>&1 && reg add "%DSKCLN_REG%\Language Pack" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Memory Dump Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Memory Dump Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Offline Pages Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Offline Pages Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Old ChkDsk Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Old ChkDsk Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Previous Installations" >NUL 2>&1 && reg add "%DSKCLN_REG%\Previous Installations" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Recycle Bin" >NUL 2>&1 && reg add "%DSKCLN_REG%\Recycle Bin" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\RetailDemo Offline Content" >NUL 2>&1 && reg add "%DSKCLN_REG%\RetailDemo Offline Content" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Service Pack Cleanup" >NUL 2>&1 && reg add "%DSKCLN_REG%\Service Pack Cleanup" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Setup Log Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Setup Log Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\System error memory dump files" >NUL 2>&1 && reg add "%DSKCLN_REG%\System error memory dump files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\System error minidump files" >NUL 2>&1 && reg add "%DSKCLN_REG%\System error minidump files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Temporary Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Temporary Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Temporary Setup Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Temporary Setup Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Temporary Sync Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Temporary Sync Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Thumbnail Cache" >NUL 2>&1 && reg add "%DSKCLN_REG%\Thumbnail Cache" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Update Cleanup" >NUL 2>&1 && reg add "%DSKCLN_REG%\Update Cleanup" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Upgrade Discarded Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Upgrade Discarded Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\User file versions" >NUL 2>&1 && reg add "%DSKCLN_REG%\User file versions" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows Defender" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows Defender" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows ESD installation files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows ESD installation files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows Error Reporting Archive Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows Error Reporting Archive Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows Error Reporting Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows Error Reporting Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows Error Reporting Queue Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows Error Reporting Queue Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows Error Reporting System Archive Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows Error Reporting System Archive Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows Error Reporting System Queue Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows Error Reporting System Queue Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1
reg query "%DSKCLN_REG%\Windows Upgrade Log Files" >NUL 2>&1 && reg add "%DSKCLN_REG%\Windows Upgrade Log Files" /v "StateFlags%DSKCLN_TASK%" /d 2 /t REG_DWORD /f >NUL 2>&1

REM Run disk cleanup task (will process all available disks)
echo Running disk cleanup task...
start /wait "" "%DSKCLN_EXEC%" /sagerun:%DSKCLN_TASK%

REM Remove disk cleanup task
echo Removing disk cleanup task...
reg delete "%DSKCLN_REG%\Active Setup Temp Folders" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\BranchCache" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Content Indexer Cleaner" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\D3D Shader Cache" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Delivery Optimization Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Device Driver Packages" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Diagnostic Data Viewer database files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Downloaded Program Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\DownloadsFolder" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\GameNewsFiles" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\GameStatisticsFiles" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\GameUpdateFiles" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Internet Cache Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Language Pack" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Memory Dump Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Offline Pages Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Old ChkDsk Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Previous Installations" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Recycle Bin" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\RetailDemo Offline Content" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Service Pack Cleanup" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Setup Log Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\System error memory dump files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\System error minidump files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Temporary Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Temporary Setup Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Temporary Sync Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Thumbnail Cache" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Update Cleanup" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Upgrade Discarded Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\User file versions" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows Defender" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows ESD installation files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows Error Reporting Archive Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows Error Reporting Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows Error Reporting Queue Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows Error Reporting System Archive Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows Error Reporting System Queue Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1
reg delete "%DSKCLN_REG%\Windows Upgrade Log Files" /v "StateFlags%DSKCLN_TASK%" /f >NUL 2>&1

REM Run DISM for in-depth cleanup of WinSxS folder to free additional space
echo.
echo Performing in-depth cleanup of WinSxS folder...
"%DISM_EXEC%" /Online /Cleanup-Image /StartComponentCleanup /ResetBase

REM Run drive optimizer to defragment used space and consolidate free space
REM ('/d' == normal defragmentation, '/h' == normal process priority instead
REM of low, '/u' == display progress; not using '/c' == process all available
REM volumes, for some reason this will skip the system drive)
echo.
echo Defragmenting disks...
for /f "skip=1 tokens=1" %%d in ('wmic logicaldisk where "DriveType=3" get deviceid 2^>NUL ^| findstr /r /v "^$"') do (
	"%DEFRAG_EXEC%" %%d /d /h /u
)

REM Run sdelete to zero free space
echo.
echo Zeroing free space...
for /f "skip=1 tokens=1" %%d in ('wmic logicaldisk where "DriveType=3" get deviceid 2^>NUL ^| findstr /r /v "^$"') do (
	"%SDEL_EXEC%" -z -nobanner %%d
)

REM All done
echo.
echo Windows guest prepared for compacting.


REM ------------------------------------
REM -                                  -
REM - Exit                             -
REM -                                  -
REM ------------------------------------
:exit

REM Wait for keystroke
if "%IS_INTERACTIVE%" == "false" (
	echo.
	echo Hit any key to close.
	pause >NUL 2>&1
)

REM Exit local environment scope
endlocal

REM Exit gracefully
exit /b
