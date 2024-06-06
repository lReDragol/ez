while ($true) {
    New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 0.0.0.0 -PrefixLength 24
    Start-Sleep -Milliseconds 100
}
