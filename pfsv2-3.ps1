
Add-DnsServerPrimaryZone -NetworkID "192.168.101.0/24" -ReplicationScope "Forest"

Add-DhcpServerv4Scope -Name "Scop01" -StartRange 192.168.101.31 -EndRange 192.168.101.130 -SubnetMask 255.255.255.0
Set-DhcpServerv4OptionValue -ScopeId 192.168.101.0 -DnsServer 192.168.101.11
Set-DhcpServerv4OptionValue -ScopeId 192.168.101.0 -Router 192.168.101.11
Add-DhcpServerInDC -DnsName "pfsv2" -IPAddress 192.168.101.12

restart-computer -Force
