Rename-Computer -NewName "PFSV1" -Force

# initialiseer de schijf en patitioneer deze
Initialize-Disk -Number 1 -PartitionStyle GPT

New-Partition -DiskNumber 1 -Size 10GB -DriveLetter F
New-Partition -DiskNumber 1 -Size 10GB -DriveLetter G
New-Partition -DiskNumber 1 -Size 10GB -DriveLetter H

Format-Volume -DriveLetter F -FileSystem NTFS -Full -Force
Format-Volume -DriveLetter G -FileSystem NTFS -Full -Force
Format-Volume -DriveLetter H -FileSystem NTFS -Full -Force


# maak de mappen en shares aan
New-Item -ItemType Directory -Path F:\UserFiles
New-Item -ItemType Directory -Path F:\UserProfiles

$Parameters = @{
    Name = 'UserFiles'
    Path = 'D:\UserFiles'
    FullAccess = 'Poliforma\Domain Admins', 'Poliforma\Domain Users' 
}
New-SmbShare @Parameters

$Parameters1 = @{
    Name = 'UserProfiles'
    Path = 'F:\UserProfiles'
    FullAccess = 'Poliforma\Domain Admins', 'Poliforma\Domain Users'
}
New-SmbShare @Parameters1


# voeg een primaire zone toe aan de DNS server
Add-DnsServerPrimaryZone -NetworkID "192.168.101.0/24" -ReplicationScope "Forest"

#configure de DHCP scope
Add-DhcpServerv4Scope -Name "Scope01" -StartRange 192.168.101.31 -EndRange 192.168.101.130 -SubnetMask 255.255.255.0
Add-Dhcpserverv4ExclusionRange -ScopeId 192.168.101.0 -StartRange 192.168.101.81 -EndRange 192.168.101.130
Set-DhcpServerv4OptionValue -ScopeId 192.168.101.0 -DnsServer 192.168.101.11
Set-DhcpServerv4OptionValue -ScopeId 192.168.101.0 -Router 192.168.101.11


# maak alles ou's aan
New-ADOrganizationalUnit -Name "PFAfdelingen" -Path "DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Directie" -Path "OU=PFAfdelingen,DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Staf" -Path "OU=PFAfdelingen,DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Verkoop" -Path "OU=PFAfdelingen,DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Administratie" -Path "OU=PFAfdelingen,DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Productie" -Path "OU=PFAfdelingen,DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Fabricage" -Path "OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False
New-ADOrganizationalUnit -Name "Automatisering" -Path "OU=PFAfdelingen,DC=poliforma,DC=local" -ProtectedFromAccidentalDeletion $False


# Directie
New-ADUser -Name "Henk Pell" -GivenName "Henk" -Surname "Pell" -SamAccountName "henk.pell" -UserPrincipalName "henk.pell@poliforma.local" -Path "OU=Directie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Adjunct Verkoop" -Title "Adjunct-directeur" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\henk.pell" -HomeDirectory "\\pfsv1\UserFolders\henk.pell" -HomeDrive "Z"
New-ADUser -Name "Teus de Jong" -GivenName "Teus" -Surname "de Jong" -SamAccountName "teus.dejong" -UserPrincipalName "teus.dejong@poliforma.local" -Path "OU=Directie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Adjunct Administratie" -Title "Adjunct-directeur" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\teus.dejong" -HomeDirectory "\\pfsv1\UserFolders\teus.dejong" -HomeDrive "Z"
New-ADUser -Name "Dick Brinkman" -GivenName "Dick" -Surname "Brinkman" -SamAccountName "dick.brinkman" -UserPrincipalName "dick.brinkman@poliforma.local" -Path "OU=Directie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Adjunct Productie" -Title "Adjunct-directeur" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\dick.brinkman" -HomeDirectory "\\pfsv1\UserFolders\dick.brinkman" -HomeDrive "Z"

# Staf
New-ADUser -Name "Danique Voss" -GivenName "Danique" -Surname "Voss" -SamAccountName "danique.voss" -UserPrincipalName "danique.voss@poliforma.local" -Path "OU=Staf,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Hoofd Staf" -Title "Hoofd" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\danique.voss" -HomeDirectory "\\pfsv1\UserFolders\danique.voss" -HomeDrive "Z"
New-ADUser -Name "Loes Heijnen" -GivenName "Loes" -Surname "Heijnen" -SamAccountName "loes.heijnen" -UserPrincipalName "loes.heijnen@poliforma.local" -Path "OU=Staf,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Receptioniste/Telefoniste" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\loes.heijnen" -HomeDirectory "\\pfsv1\UserFolders\loes.heijnen" -HomeDrive "Z"

# Verkoop
New-ADUser -Name "Wiel Nouwen" -GivenName "Wiel" -Surname "Nouwen" -SamAccountName "wiel.nouwen" -UserPrincipalName "wiel.nouwen@poliforma.local" -Path "OU=Verkoop,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Accountmanager" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\wiel.nouwen" -HomeDirectory "\\pfsv1\UserFolders\wiel.nouwen" -HomeDrive "Z"

# Administratie
New-ADUser -Name "Dirk Bogert" -GivenName "Dirk" -Surname "Bogert" -SamAccountName "dirk.bogert" -UserPrincipalName "dirk.bogert@poliforma.local" -Path "OU=Administratie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Boekhouder" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\dirk.bogert" -HomeDirectory "\\pfsv1\UserFolders\dirk.bogert" -HomeDrive "Z"

# Productie
New-ADUser -Name "Karin Visse" -GivenName "Karin" -Surname "Visse" -SamAccountName "karin.visse" -UserPrincipalName "karin.visse@poliforma.local" -Path "OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Secretaresse" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\karin.visse" -HomeDirectory "\\pfsv1\UserFolders\karin.visse" -HomeDrive "Z"
New-ADUser -Name "Herman Bommel" -GivenName "Herman" -Surname "Bommel" -SamAccountName "herman.bommel" -UserPrincipalName "herman.bommel@poliforma.local" -Path "OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Inkoper/Magazijnbeheerder" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\herman.bommel" -HomeDirectory "\\pfsv1\UserFolders\herman.bommel" -HomeDrive "Z"
New-ADUser -Name "Doortje Heijnen" -GivenName "Doortje" -Surname "Heijnen" -SamAccountName "doortje.heijnen" -UserPrincipalName "doortje.heijnen@poliforma.local" -Path "OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Productontwikkelaar" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\doortje.heijnen" -HomeDirectory "\\pfsv1\UserFolders\doortje.heijnen" -HomeDrive "Z"
New-ADUser -Name "Peter Caprieaux" -GivenName "Peter" -Surname "Caprieaux" -SamAccountName "peter.caprieaux" -UserPrincipalName "peter.caprieaux@poliforma.local" -Path "OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Hoofd Fabricage" -Title "Hoofd" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\peter.caprieaux" -HomeDirectory "\\pfsv1\UserFolders\peter.caprieaux" -HomeDrive "Z"

# Fabricage (sub-OU van Productie)
New-ADUser -Name "Will Snellen" -GivenName "Will" -Surname "Snellen" -SamAccountName "will.snellen" -UserPrincipalName "will.snellen@poliforma.local" -Path "OU=Fabricage,OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Chef Werkplaats" -Title "Chef" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\will.snellen" -HomeDirectory "\\pfsv1\UserFolders\will.snellen" -HomeDrive "Z"
New-ADUser -Name "Niels Smets" -GivenName "Niels" -Surname "Smets" -SamAccountName "niels.smets" -UserPrincipalName "niels.smets@poliforma.local" -Path "OU=Fabricage,OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Productcontroleur" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\niels.smets" -HomeDirectory "\\pfsv1\UserFolders\niels.smets" -HomeDrive "Z"
New-ADUser -Name "Floris Flipse" -GivenName "Floris" -Surname "Flipse" -SamAccountName "floris.flipse" -UserPrincipalName "floris.flipse@poliforma.local" -Path "OU=Fabricage,OU=Productie,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "Chef Onderhoud" -Title "Chef" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\floris.flipse" -HomeDirectory "\\pfsv1\UserFolders\floris.flipse" -HomeDrive "Z"

# Automatisering
New-ADUser -Name "Fons Willemsen" -GivenName "Fons" -Surname "Willemsen" -SamAccountName "fons.willemsen" -UserPrincipalName "fons.willemsen@poliforma.local" -Path "OU=Automatisering,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "CNC-programmeur" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\fons.willemsen" -HomeDirectory "\\pfsv1\UserFolders\fons.willemsen" -HomeDrive "Z"
New-ADUser -Name "Robbie Vos" -GivenName "Robbie" -Surname "Vos" -SamAccountName "robbie.vos" -UserPrincipalName "robbie.vos@poliforma.local" -Path "OU=Automatisering,OU=PFAfdelingen,DC=poliforma,DC=local" -Description "ICT- en Netwerkbeheerder" -Title "Medewerker" -AccountPassword (ConvertTo-SecureString "Welkom01!" -AsPlainText -Force) -Enabled $true -ProfilePath "\\pfsv1\UserProfiles\robbie.vos" -HomeDirectory "\\pfsv1\UserFolders\robbie.vos" -HomeDrive "Z"

$groepen = @("Administrators", "Domain Admins")
foreach ($groep in $groepen) {
    Add-ADGroupMember -Identity $groep -Members "robbie.vos"
}

Rename-ADObject -Identity "CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=poliforma,DC=local" -NewName "PFBudel"
Set-ADObject -Identity "CN=PFBudel,CN=Sites,CN=Configuration,DC=poliforma,DC=local" -Replace @{location="pf budel"}
New-ADReplicationSubnet -Name "192.168.101.0/24" -Site "PFBudel"

restart-computer -Force

