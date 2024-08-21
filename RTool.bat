@echo off

title RTOOL

:splash
color 0e
cls
echo.
echo ####################
echo.
echo      R R R R R 
echo      R        R 
echo      R R R R R   
echo      R R
echo      R   R
echo      R     R
echo      R       R
echo.
echo ####################
echo.
echo The Omni-Tool For IT and Tinkerers
echo.
echo ####################
echo.
timeout 3 /nobreak >nul
cls
color 06
echo.
echo Welcome to RTOOL!
echo.
echo Options:

:menu
echo.
echo Main:
echo.
echo 1. Show Physical Addresses   2. Show IP Addresses
echo 3. Show users on your PC   4. Check if program is admin
echo 5. Check if DHCP is enabled   6.  Ping an IP or Domain
echo 7. Get CPU, Disk Space, and Memory Usage 	8. Show BIOS version
echo 9. List System I/O Ports   10. Show connection speeds of all Networks
echo 11. Exit
echo.
echo Fun Stuff:
echo.
echo 12. Spawn a Message Box with your custom text   13. Show splash again

set /p choice="Enter an option:"

if "%choice%"=="1" goto macaddr
if "%choice%"=="2" goto ipaddr
if "%choice%"=="3" goto showusr
if "%choice%"=="4" goto checkadmin
if "%choice%"=="5" goto checkdhcp
if "%choice%"=="6" goto pingip
if "%choice%"=="7" goto checkcpumemdisk
if "%choice%"=="8" goto biosver
if "%choice%"=="9" goto ioport
if "%choice%"=="10" goto netspeed
if "%choice%"=="11" goto exitprog
if "%choice%"=="12" goto msgboxshow
if "%choice%"=="13" goto splash

:macaddr
cls
echo.
echo Running getmac to find Physical Addresses...
getmac /v
goto menu

:ipaddr
cls
echo.
echo Finding IP Addresses...
echo.
ipconfig | findstr "IPv"
goto menu

:showusr
cls
echo.
echo Showing users...
echo.
wmic useraccount get name,SID
goto menu

:checkadmin
cls
echo.
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo You are not running the program as admin.
) else (
    echo You are running the program as admin.
)
goto menu

:checkdhcp
cls
echo.
echo Checking if DHCP is enabled...
echo If all of these entries say No, DHCP is not enabled. If all of them say Yes, DHCP is enabled, for some entries with letters and numbers as opposed to yes or no statements, this ruleset will not apply.
echo.
ipconfig /all | findstr "DHCP"
goto menu

:pingip
cls
echo.
set /p pingtarget="Enter an IP address or domain to ping: "
echo Pinging %pingtarget%...
ping %pingtarget%
goto menu

:checkcpumemdisk
cls
echo. 
echo CPU Info:
wmic cpu get name,CurrentClockSpeed,MaxClockSpeed
echo.
echo Memory Usage:
wmic os get FreePhysicalMemory,TotalVisibleMemorySize
echo.
echo Disk Space:
wmic logicaldisk get name,size,freespace
goto menu

:biosver
cls
echo.
wmic bios get version
goto menu

:ioport
cls
echo.
wmic port get name
goto menu

:netspeed
cls
echo.
wmic nic get name,speed
goto menu

:msgboxshow
cls
echo.
set /p msgboxicon="Input icon (16 = Error, 32 = Question, 48 = Warning, 64 = Info): "
set /p msgboxbuttons="Input a number for the buttons (0 = OK Only, 1 = OK and Cancel, 2 = Abort, Retry, and Ignore, 3 = Yes, No, and Cancel, 4 = Yes and No, 5 = Retry and Cancel): "
set /p msgboxtext="Input custom text: "
set /p msgboxtitle="Input custom title: "
cls
echo.
echo Creating VBS file...
echo x=msgbox("%msgboxtext%" ,%msgboxbuttons%+%msgboxicon%, "%msgboxtitle%") > temporary.vbs
echo Starting VBS file...
start temporary.vbs
timeout 2 /nobreak >nul
echo Deleting VBS file...
del temporary.vbs
cls
goto menu

:exitprog
exit /b