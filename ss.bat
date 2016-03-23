@echo off
Rem Start server to test sample

if m%1==m goto defaultSample
set HTTPSample=%1
if m%2==m goto defaultPath
set HTTPPath=%2
if m%3==m goto defaultPort
set HTTPPort=%3

:run
if not exist %HTTPPath%\%HTTPSample%\%HTTPSample%.html goto SSERROR
start python -m SimpleHTTPServer %HTTPPort%
start http://localhost:%HTTPPort%/%HTTPPath%/%HTTPSample%/%HTTPSample%.html
goto end

:defaultSample
set HTTPSample=omf
:defaultPath
set HTTPPath=oldstuff
:defaultPort
set HTTPPort=8000

goto run

:SSERROR
echo Sorry, but no sample named %HTTPSample% found. 
echo Usage: ss Sample Path Port
echo Sample: ss omf oldstuff 8000
echo         will run sample "omf" in path "oldstuff" at port 8000

:end
