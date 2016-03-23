@echo off
cls
if "%ramdrive%"=="" goto _twer
if "%1"=="/q" goto qtw
if "%1"=="/Q" goto qtw
if "%1"=="/s" goto sl
if "%1"=="/S" goto sl
pkunzip -O A:\soft\twx.zip %ramdrive%\ >NUL
lh %ramdrive%\tway >nul
echo.
echo 天汇中文载入成功,右Shift显示或隐藏状态栏,使用TW /S 加载输入法. TW /Q 退出.
goto end 

:_twer
echo Error: Not found Ramdrive,Procedures not running!
goto end

:qtw
tway /q >nul
goto end

:sl
quit >nul
pkunzip -O A:\soft\twx.zip %ramdrive%\ >NUL
if not exist %ramdrive%\data md %ramdrive%\data >nul
copy /y %ramdrive%\py.mb %ramdrive%\data >nul
copy /y %ramdrive%\wb.mb %ramdrive%\data >nul
lh %ramdrive%\tway >nul
%ramdrive%\key py wb >nul
echo.
echo 中文支持系统及中文输入法载入成功. TW /Q 退出中文支持.
echo 输入法切换:  Alt +  F1 区位   F2 英文   F3 拼音   F4 五笔   F5 双拼

:end