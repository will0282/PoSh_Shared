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

# Define the variables. Input the values from SEPM or updated endpoint.
$VSP_1 = "2020-05-18 r 22"
$VSP_2 = "2020-05-11 r 006"
$VSP_3 = "2020-05-18 r 061"
#############################################################################
# Virus and Spyware Protection
$virusSpyware_1 = Get-ItemProperty -Path "hklm:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" -name LatestVirusDefsDate #This is the Date
$virusSpyware_2 = Get-ItemProperty -Path "hklm:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" -name LatestVirusDefsRevision #This is the Release version
#############################################################################
# Proactive Threat Protection
$PTP = Get-ItemProperty -Path "HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\SharedDefs\BASHDefs" -name BASH
$PTP_SubString_D = ($PTP.BASH.Substring($PTP.BASH.Length -12)) 
$PTP_SubString_R = ($PTP.BASH.Substring($PTP.BASH.Length -3)) 

$PTP_Date = $PTP_Substring_D.Substring(0,8) #Shows the date of the update
$PTP_Release = $PTP_Substring_R.Substring(0,3) #Shows the Release version

#######
#YEAR - Gets the Year on the string
$PTP_YR = $PTP_Date.Remove('4')

#MONTH - Gets the month on the string
$MM_Part1 = ($PTP_Date.Substring($PTP_Date.Length -4))
$PTP_MM = ($MM_Part1.Remove('2'))

#######
#Day - Gets the day on the string
$PTP_DD = ($PTP_Date.Substring($PTP_Date.Length -2))

#############################################################################
# Network and Host Exploit Mitigation
$NHEM = Get-ItemProperty -Path "HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\SharedDefs\IPSDefs" -name "Internet Security"
$NHEM_SubString_D = ($NHEM.'Internet Security'.Substring($NHEM.'Internet Security'.Length -12)) 
$NHEM_SubString_R = ($NHEM.'Internet Security'.Substring($NHEM.'Internet Security'.Length -3)) 

$NHEM_Date = $NHEM_Substring_D.Substring(0,8) #Shows the date of the update
$NHEM_Release = $NHEM_Substring_R.Substring(0,3) #Shows the Relea

# String Manipulation
$yolo = ($NHEM.'Internet Security'.Substring($NHEM.'Internet Security'.Length -12))
$FullString = ($yolo.ToString())

# String Split
$Inputstring = $yolo
$CharArray =$InputString.Split(".")
$StringPartOne = ($CharArray[0].ToString())
$stringPartTwo = ($CharArray[1].ToString())

#######
#YEAR - Gets the Year on the string
$FullString_YR = $StringPartOne.Remove('4')

#######
#MONTH - Gets the month on the string
$montPart1 = ($StringPartOne.Substring($StringPartOne.Length -4))
$FullString_MM = ($montPart1.Remove('2'))

#######
#Day - Gets the day on the string
$FullString_DD = ($StringPartOne.Substring($StringPartOne.Length -2))

#Display Definitions:
Write-Host "------------------------------"
Write-Host $env:COMPUTERNAME -ForegroundColor Cyan
Write-Host "Virus and Spyware Protection ||| (Antivirus Content)"
Write-Host "Server Definitions:   "$VSP_1 -ForegroundColor Green
Write-Host "Endpoint Definitions: " $virusSpyware_1.LatestVirusDefsDate "r" $virusSpyware_2.LatestVirusDefsRevision -ForegroundColor Gray
Write-Host "------------------------------"
Write-Host "Proactive Threat Protection ||| (SONAR Content)"
Write-Host "Server Definitions:   "$VSP_2 -ForegroundColor Green
Write-Host "Endpoint Definitions: " $PTP_YR"-"$PTP_MM"-"$PTP_DD "r" $PTP_Release -ForegroundColor Gray
Write-Host "------------------------------"
Write-Host "Network and Host Exploit Mitigation"
Write-Host "Server Definitions:   "$VSP_3 -ForegroundColor Green
Write-Host "Endpoint Definitions: "$FullString_YR"-"$FullString_MM"-"$FullString_DD "r" $NHEM_Release -ForegroundColor Gray
Write-Host "------------------------------"

}
