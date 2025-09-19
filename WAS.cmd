@ECHO OFF
setlocal EnableDelayedExpansion

:: Auto elevation code taken from the following answer-
:: https://stackoverflow.com/a/28467343/14312937

:: net file to test privileges, 1>NUL redirects output, 2>NUL redirects errors
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto START ) else ( goto getPrivileges ) 

:getPrivileges
if '%1'=='ELEV' ( goto START )

set "batchPath=%~f0"
set "batchArgs=ELEV"

:: Add quotes to the batch path, if needed
set "script=%0"
set script=%script:"=%
IF '%0'=='!script!' ( GOTO PathQuotesDone )
    set "batchPath=""%batchPath%"""
:PathQuotesDone

:: Add quotes to the arguments, if needed
:ArgLoop
IF '%1'=='' ( GOTO EndArgLoop ) else ( GOTO AddArg )
    :AddArg
    set "arg=%1"
    set arg=%arg:"=%
    IF '%1'=='!arg!' ( GOTO NoQuotes )
        set "batchArgs=%batchArgs% "%1""
        GOTO QuotesDone
        :NoQuotes
        set "batchArgs=%batchArgs% %1"
    :QuotesDone
    shift
    GOTO ArgLoop
:EndArgLoop

:: Create and run the vb script to elevate the batch file
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "cmd", "/c ""!batchPath! !batchArgs!""", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs" 
exit /B

:START
:: Remove the elevation tag and set the correct working directory
IF '%1'=='ELEV' ( shift /1 )
cd /d %~dp0

:: Main script here

set "_onetitle=WinRAR Activator"

cls
mode 76, 30
title %_onetitle% by CaptainFahim
echo %_onetitle%
echo Created by CaptainFahim
echo https://github.com/CaptainFahim7/WinRAR_Activator
echo:

call :RARBIT
echo:
call :CLEANUP
echo:
echo ^- Starting WinRAR once to ensure file presence.
call :INITIATE
echo:
call :PAUSEWAIT
echo:
call :TERMINATE
echo:
call :SETKEY
echo:
echo ^- Registration complete. Starting WinRAR.
call :INITIATE
echo:
call :PAUSEWAIT
echo:
taskkill /f /im WinRAR.exe /t
echo ^- This script will now end.
goto FINISH

:RARBIT
echo ^- Determining WinRAR location...
echo:
set "rarbit=unknown"
if exist "%SystemDrive%\Program Files (x86)\WinRAR\WinRAR.exe" set "rarbit=%SystemDrive%\Program Files (x86)\WinRAR"
if exist "%SystemDrive%\Program Files\WinRAR\WinRAR.exe" set "rarbit=%SystemDrive%\Program Files\WinRAR"
if "%rarbit%" EQU "unknown" (
  echo ^- WinRAR was not found in the default directories.
  echo:
  pause
  goto FINISH
) else (
  echo ^- WinRAR was found in "%rarbit%".
)
exit /b

:CLEANUP
echo ^- Cleaning up any existing registration keys.
if exist "%rarbit%\rarreg.key" (
  del /f /q "%rarbit%\rarreg.key" 1>nul
)
exit /b

:INITIATE
start /b "" "%rarbit%\WinRAR.exe"
exit /b

:TERMINATE
echo ^- Closing all open WinRAR processes.
taskkill /f /im WinRAR.exe /t
exit /b

:PAUSEWAIT
echo ^- Please wait a moment.
timeout /t 3 /nobreak > nul
exit /b

:SETKEY
echo ^- Registering your copy of WinRAR.
(
  echo RAR registration data
  echo Captain Fahim
  echo bio.link/captainfahim
  echo UID=647cabf9a01033d47510
  echo 641221225075101548d3149e83ae06420f113c2e2eeceaec1185bb
  echo 9d85f8bcc6e196c5bb1c607f9b1371a536c3a5dc46479421dbe06a
  echo 7ca9073696549de795c794088dc01f4926bc96283e295fc4f48fa2
  echo b9c0d0bb63dd2f4c54c6a84d22ba39238b60b28f62a1a234bbb450
  echo 7db5452d899824029536499085495016dfee656779c4832d2b652a
  echo bc152a7a49ec2f22650b23543d0c0539ba54d507d1036fc960d8b0
  echo 8c149de8f582d76a8e5b8b85a35f4aca60b60be9f3202898775143
  echo ------------------------------------------------------
) > "%rarbit%\rarreg.key"
exit /b

:FINISH
timeout /t 3 /nobreak > nul
exit
