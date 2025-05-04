Rename-NetAdapter -Name "Ethernet0" -NewName "WAN-Internet"
Rename-NetAdapter -Name "Ethernet1" -NewName "LAN"

New-NetIPAddress -IPAddress 192.168.101.11 -InterfaceAlias "LAN" -AddressFamily IPv4 -PrefixLength 24


Set-TimeZone -Id "W. Europe Standard Time"

install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature DHCP -IncludeManagementTools
Install-WindowsFeature Routing -IncludeManagementTools

Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "Default" `
-DomainName "poliforma.local" `
-DomainNetbiosName "POLIFORMA" `
-ForestMode "Default" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

