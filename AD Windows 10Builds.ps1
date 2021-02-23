<# 
Reference Link: https://evotec.xyz/getting-windows-10-build-version-from-active-directory/

Run as ADM

This script check all computers in AD for their current Windows 10 Build and returns a total machines in each build and a list of those machines.

#>

$Computers = Get-ADComputer -Filter * -properties Name, OperatingSystem, OperatingSystemVersion, LastLogonDate
$ComputerList = foreach ($_ in $Computers) {
    [PSCustomObject] @{
        Name                   = $_.Name
        OperatingSystem        = $_.OperatingSystem
        OperatingSystemVersion = $_.OperatingSystemVersion
        System                 = ConvertTo-OperatingSystem -OperatingSystem $_.OperatingSystem -OperatingSystemVersion $_.OperatingSystemVersion
        LastLogonDate          = $_.LastLogonDate
        
    }
}

Clear-Host
$ComputerList | Group-Object -Property System | Format-Table -Property Name, Count
$ComputerList | Format-Table -AutoSize
