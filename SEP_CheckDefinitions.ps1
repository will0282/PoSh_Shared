$cred = Get-Credential -Credential DOMAIN\usernameADM
Invoke-Command -ComputerName 'Server01' -Credential $cred -ScriptBlock {

#Define Variables
$virusSpyware_1 = $null
$virusSpyware_2 = $null
$PTP = $null
$PTP_SubString_D = $null
$PTP_SubString_R = $null
$PTP_Date = $null
$PTP_Release = $null
$NHEM = $null
$NHEM_SubString_D = $null
$NHEM_SubString_R = $null
$NHEM_Date = $null
$NHEM_Release = $null
$NHEM_TOTAL = $null
#$env:COMPUTERNAME = $null

# Variables to define test values
$VSP_1 = "2020-05-18 r 22"
$VSP_2 = "20200511 r 006"
$VSP_3 = "20200518 r 061"

# Virus and Spyware Protection
$virusSpyware_1 = Get-ItemProperty -Path "hklm:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" -name LatestVirusDefsDate #This is the Date
$virusSpyware_2 = Get-ItemProperty -Path "hklm:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" -name LatestVirusDefsRevision #This is the Release version
# Proactive Threat Protection
$PTP = Get-ItemProperty -Path "HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\SharedDefs\BASHDefs" -name BASH
$PTP_SubString_D = ($PTP.BASH.Substring($PTP.BASH.Length -12)) 
$PTP_SubString_R = ($PTP.BASH.Substring($PTP.BASH.Length -3)) 

$PTP_Date = $PTP_Substring_D.Substring(0,8) #Shows the date of the update
$PTP_Release = $PTP_Substring_R.Substring(0,3) #Shows the Release version

# Network and Host Exploit Mitigation
$NHEM = Get-ItemProperty -Path "HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\SharedDefs\IPSDefs" -name "Internet Security"
$NHEM_SubString_D = ($NHEM.'Internet Security'.Substring($NHEM.'Internet Security'.Length -12)) 
$NHEM_SubString_R = ($NHEM.'Internet Security'.Substring($NHEM.'Internet Security'.Length -3)) 

$NHEM_Date = $NHEM_Substring_D.Substring(0,8) #Shows the date of the update
$NHEM_Release = $NHEM_Substring_R.Substring(0,3) #Shows the Relea

#$NHEM_TOTAL = 

#Definitions:
Write-Host "------------------------------"
Write-Host $env:COMPUTERNAME -ForegroundColor Yellow
Write-Host "Virus and Spyware Protection ||| (Antivirus Content)"
Write-Host "Definitions: " $virusSpyware_1.LatestVirusDefsDate " r" $virusSpyware_2.LatestVirusDefsRevision " || Compare to server --> || " $VSP_1
Write-Host "------------------------------"
Write-Host "Proactive Threat Protection ||| (SONAR Content)"
Write-Host "Definitions: " $PTP_Date " r" $PTP_Release " || Compare to server --> || " $VSP_2
Write-Host "------------------------------"
Write-Host "Network and Host Exploit Mitigation ||| "
Write-Host "Definitions: " $NHEM_Date " r" $NHEM_Release " || Compare to server --> || " $VSP_3
#Write-Host "Value: " $NHEM.'Internet Security'.Substring(20,
Write-Host "------------------------------"
Write-Host "------------------------------"

}
