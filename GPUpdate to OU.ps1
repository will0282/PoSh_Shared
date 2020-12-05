<#
Script does a GPUpdate on all computer objects within the specified OU.
#>

Get-ADComputer –filter * -Searchbase "ou=LAB, dc=lab,dc=local" | foreach{ Invoke-GPUpdate –computer $_.name -force}
