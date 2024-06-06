@echo off
setlocal enabledelayedexpansion

REM Specify the range of IP addresses to scan
set "network=192.168.1."
set "start=1"
set "end=6"

REM Create a file to store active IP addresses
set "active_ips=active_ips.txt"
if exist %active_ips% del %active_ips%

echo ==================================================
echo Scanning IP addresses in range %network%%start%-%network%%end%...
echo ==================================================

for /L %%i in (%start%,1,%end%) do (
    echo Pinging %network%%%i...
    ping -n 1 -w 1000 %network%%%i | find "TTL=" >nul
    if !errorlevel! == 0 (
        echo %network%%%i is up
        echo %network%%%i >> %active_ips%
    ) else (
        echo %network%%%i is down
    )
)

REM Check for active IP addresses
if not exist %active_ips% (
    echo No active IP addresses found.
    exit /b 1
)

echo ==================================================
echo Found active IP addresses:
echo ==================================================
type %active_ips%

echo ==================================================
echo Creating network load on found IP addresses...
echo ==================================================

REM Start network load on found IP addresses
for /f %%i in (%active_ips%) do (
    echo Creating load on %%i...
    start "Ping %%i" cmd /c "ping -t %%i > nul"
    start "Load %%i" powershell -Command "while ($true) { Invoke-WebRequest -Uri 'https://ash-speed.hetzner.com/100MB.bin' -OutFile '%TEMP%\largefile.bin'; Remove-Item '%TEMP%\largefile.bin' }"
)

echo ==================================================
echo Network load created on found IP addresses.
echo ==================================================
pause
