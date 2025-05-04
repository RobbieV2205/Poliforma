#
# Windows PowerShell script for AD DS Deployment
#
install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature -Name DNS -IncludeManagementTools
Install-WindowsFeature DHCP -IncludeManagementTools
Install-WindowsFeature Routing -IncludeManagementTools

Import-Module ADDSDeployment
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-Credential (Get-Credential) `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "poliforma.local" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-ReplicationSourceDC "PFSV1.poliforma.local" `
-SiteName "PFBudel" `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

