@echo off
REM Create two virtual network adapters
netsh interface ipv4 set interface "Ethernet" admin=disabled
netsh interface set interface name="Ethernet" newname="Ethernet0"
netsh interface set interface name="Ethernet0" newname="Ethernet1"
netsh interface ipv4 set interface "Ethernet0" admin=enabled
netsh interface ipv4 set interface "Ethernet1" admin=enabled

REM Assign IP addresses to the virtual network adapters
netsh interface ip set address "Ethernet0" static 192.168.1.2 255.255.255.0
netsh interface ip set address "Ethernet1" static 192.168.1.3 255.255.255.0

REM Enable bridging between the two interfaces
netsh bridge set adapter 1 forcecompatmode=enable
netsh bridge set adapter 2 forcecompatmode=enable
netsh bridge set adapter 1 priority=0
netsh bridge set adapter 2 priority=1

REM Create the network bridge
netsh bridge install

REM Add both adapters to the network bridge
netsh bridge set adapter 1 enable
netsh bridge set adapter 2 enable

echo Network loop created.
pause