@echo off
if m%1==m goto defaultName
set packName=%1
if m%2==m goto defaultPath
set packPath=%2
if m%3==m goto defaultStart
set packStart=%3

:pack
if not exist %packPath% goto SSERROR
if not exist %packPath%\%packStart% goto SSERROR
python packager.py %packName% %packPath% %packStart%
if errorlevel == 0 goto SUCCESS
goto end

:defaultName
goto SSERROR
:defaultPath
goto SSERROR
:defaultStart
goto SSERROR

:SSERROR
echo Sorry, but ERROR. 
echo Usage: pack Sample Path StartCommand
echo Sample: pack QB45 BASIC\QB45 QB.EXE
echo         will pack to "QB45" with the dir "BASIC\QB45" and start with "QB.EXE"
goto end

:SUCCESS
echo Pack SUCCESS
if not exist packages\%packName% mkdir packages\%packName%
echo y|move %packName%.* packages\%packName%
echo Now press ANY key to start test, ctrl-c to stop.
pause
call ss %packName% packages 8000

:end

