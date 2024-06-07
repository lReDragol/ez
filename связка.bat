@echo off
REM Disable the Ethernet interface
netsh interface set interface name="Ethernet" admin=disabled

REM Rename the interface (only if necessary, typically not required for the same adapter)
netsh interface set interface name="Ethernet" newname="Ethernet0"

REM Enable the Ethernet interface
netsh interface set interface name="Ethernet0" admin=enabled

REM Assign IP address to the Ethernet adapter
netsh interface ip set address name="Ethernet0" static 192.168.1.2 255.255.255.0

REM Create a network bridge
netsh bridge install

REM Add the Ethernet adapter to the network bridge
netsh bridge set adapter 1 enable

echo Network bridge created.
pause
