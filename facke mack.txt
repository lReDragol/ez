$adapter = Get-NetAdapter -Name "Ethernet"
while ($true) {
    $randomMAC = -join ((48..57) + (65..70) | Get-Random -Count 12 | % {[char]$_})
    $adapter | Set-NetAdapter -MacAddress $randomMAC
    Start-Sleep -Milliseconds 100
}
