Rename-Computer -NewName "PFSV2" -Force

Rename-NetAdapter -Name "Ethernet0" -NewName "LAN"

New-NetIPAddress -IPAddress 192.168.101.12 -InterfaceAlias "LAN" -AddressFamily IPv4 -PrefixLength 24 -DefaultGateway 192.168.101.11
Set-DnsClientServerAddress -InterfaceAlias "LAN" -ServerAddresses ("192.168.101.11")

install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature -Name DNS -IncludeManagementTools
Install-WindowsFeature DHCP -IncludeManagementTools
Install-WindowsFeature Routing -IncludeManagementTools


Set-TimeZone -Id "W. Europe Standard Time"

restart-computer -Force
