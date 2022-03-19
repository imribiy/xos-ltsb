@echo off
title ShellExperienceHost Toggle Script

echo  This script will also break Task Scheduler, so dont use it if you need Task Scheduler!
echo.
echo.	Press [D] to Disable SEH
echo.	Press [E] to Enable SEH (XOS Default)
echo.
set /p c="What is your choice? "
if /i %c% equ D goto :disable
if /i %c% equ E goto :enable

:disable
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\ahcache" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\systemeventsbroker" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\samss" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\Schedule" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\timebrokersvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Schedule" /v "ErrorControl" /f
taskkill /f /im explorer.exe
taskkill /f /im runtimebroker.exe
cd C:\Windows\System32
takeown /f "runtimebroker.exe"
icacls "C:\Windows\System32\RuntimeBroker.exe" /grant Administrators:F
ren runtimebroker.exe runtimebroker.old
start explorer.exe
cls
echo Please reboot your system.
pause
exit

:enable
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\ahcache" /v "Start" /t REG_DWORD /d "1" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\systemeventsbroker" /v "Start" /t REG_DWORD /d "2" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\samss" /v "Start" /t REG_DWORD /d "2" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\TimeBrokerSvc" /v "Start" /t REG_DWORD /d "3" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\schedule" /v "Start" /t REG_DWORD /d "2" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\SYSTEM\CurrentControlSet\Services\schedule" /v "errorcontrol" /t REG_DWORD /d "1" /f
taskkill /f /im explorer.exe
cd C:\Windows\System32
takeown /f "runtimebroker.old"
icacls "C:\Windows\System32\RuntimeBroker.old" /grant Administrators:F
ren runtimebroker.old runtimebroker.exe
start explorer.exe
start runtimebroker.exe
cls
echo Please reboot your system.
pause
exit
