<#
DESC.
Script searches all OUs and displays in out-grid the users' [PasswordLastSet] and [LastLogonTimestamp] timestamps for accounts that have not logging OR set the passwords in the (X) days.
#>

#Gets - Modules
Import-Module ActiveDirectory

#Sets - variable to Date back (x) amount of days
$d = [DateTime]::Today.AddDays(-90)

#Gets - Checks all OUs and displays in Out-Grid all user account information for the report.
Get-ADUser -Filter '(PasswordLastSet -lt $d) -or (LastLogonTimestamp -lt $d)' -Properties PasswordLastSet,LastLogonTimestamp,Title,Department,Manager | select Name,PasswordLastSet,@{N="LastLogonTimestamp";E={[datetime]::FromFileTime($_.LastLogonTimestamp)}},Title, Department, @{n="ManagerName";e={get-aduser $_.manager `
| select -ExpandProperty name}}, @{n="ManagerMail";e={get-aduser $_.manager -properties mail | select -ExpandProperty mail}} | Out-GridView -Title 'Report created for Ed: Display Enabled Users Account and their password expiration.'

#END OF SCRIPT**************************************
