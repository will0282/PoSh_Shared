Get-GPO -All -Domain Reskit.Org |
Sort-Object -Property DisplayName |
Format-Table -Property Displayname, Description, GpoStatus
