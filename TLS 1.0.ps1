<# 
This script checks for registry keys for TLS 1.0, 1.1, 1.2, RC4, Triple 3DES

Pre-Reqs:
-WinRM service must be running on remote endpoint.
-PSRemoting must be enabled on remote endpoint.
-Script must be run as ADM
#>

$Cred = 'DOMAIN\YourADMCredentials' #i.e. $Cred = 'microsoft\JSmithADM'
$pc = 'XXXXXCOMPUTER_Name'

Invoke-Command -ComputerName $pc -Credential $Cred -ScriptBlock {

## Check for Disable TLS 1.0
$RegistryPath1_0 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client'
$RegistryChecker1_0A = Get-ItemProperty -Path $RegistryPath1_0 -Name 'DisabledByDefault'
$RegistryChecker1_0B = Get-ItemProperty -Path $RegistryPath1_0 -Name 'Enabled'

## Check for Disable TLS 1.1
$RegistryPath1_1 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client'
$RegistryChecker1_1A = Get-ItemProperty -Path $RegistryPath1_1 -Name 'DisabledByDefault'
$RegistryChecker1_1B = Get-ItemProperty -Path $RegistryPath1_1 -Name 'Enabled'

## Check for Disable TLS 1.2
$RegistryPath1_2 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client'
$RegistryChecker1_2A = Get-ItemProperty -Path $RegistryPath1_2 -Name 'DisabledByDefault'
$RegistryChecker1_2B = Get-ItemProperty -Path $RegistryPath1_2 -Name 'Enabled'

## Check for Disable SSL 2.0
$RegistryPathSSLv2 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server'
$RegistryCheckerSSLv2 = Get-ItemProperty -Path $RegistryPathSSLv2 -Name 'DisabledByDefault'

## Check for Disable SSL 3.0
$RegistryPathSSLv3 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server'
$RegistryCheckerSSLv3 = Get-ItemProperty -Path $RegistryPathSSLv3 -Name 'DisabledByDefault'

## Check for Disable Triple 3DES
$RegistryPath3DES = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168'
$RegistryChecker3DES = Get-ItemProperty -Path $RegistryPath3DES -Name 'Enabled'

## Check for Disable RC4
$RegistryPathRC4_128 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128'
$RegistryCheckerRC4_128 = Get-ItemProperty -Path $RegistryPathRC4_128 -Name 'Enabled'

$RegistryPathRC4_40 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128'
$RegistryCheckerRC4_40 = Get-ItemProperty -Path $RegistryPathRC4_40 -Name 'Enabled'

$RegistryPathRC4_56 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128'
$RegistryCheckerRC4_56 = Get-ItemProperty -Path $RegistryPathRC4_56 -Name 'Enabled'



Clear-Host
$CompHost = $env:COMPUTERNAME
Write-Host $CompHost -ForegroundColor Yellow
##### TLS 1.0
    if($RegistryChecker1_0A.DisabledByDefault -eq 1){
        Write-Host "################################"
        Write-Host "TLS 1.0\Client\DisabledByDefault | Value = 1 | Registry Key exist" -ForegroundColor Green
    }Else{                
        Write-Host "################################"
        Write-Host "TLS 1.0 | TLS 1.0\Client\DisabledByDefault | Value = 1 | It does not exist" -ForegroundColor Red
    }

    if($RegistryChecker1_0B.Enabled -eq 0){        
        Write-Host "TLS 1.0 | TLS 1.0\Client\Enabled | Value = 0 | Registry Key exist" -ForegroundColor Green
        Write-Host "################################"
    }Else{        
        Write-Host "TLS 1.0 | TLS 1.0\Client\Enabled | Value = 0 | It does not exist" -ForegroundColor Red
        Write-Host "################################"
    }

#region TLS 1.1
    if($RegistryChecker1_1A.DisabledByDefault -eq 0){        
    Write-Host "################################"
        Write-Host "TLS 1.1 | TLS 1.1\Client\DisabledByDefault | Value = 0 | Registry Key exist" -ForegroundColor Green
    }Else{        
    Write-Host "################################"
        Write-Host "TLS 1.1 | TLS 1.1\Client\DisabledByDefault | Value = 0 | It does not exist" -ForegroundColor Red
    }
    if($RegistryChecker1_1B.Enabled -eq 1){            
        Write-Host "TLS 1.1 | TLS 1.1\Client\Enabled | Value = 1 | Registry Key exist" -ForegroundColor Green
        Write-Host "################################"
    }Else{        
        Write-Host "TLS 1.1 | TLS 1.1\Client\Enabled | Value = 1 | It does not exist" -ForegroundColor Red
        Write-Host "################################"
    }
#endregion TLS 1.1

##### TLS 1.2
    if($RegistryChecker1_2A.DisabledByDefault -eq 0){ 
    Write-Host "################################"       
        Write-Host "TLS 1.2 | TLS 1.2\Client\DisabledByDefault | Value = 0 | Registry Key exist" -ForegroundColor Green
    }Else{        
    Write-Host "################################"
        Write-Host "TLS 1.2 | TLS 1.2\Client\DisabledByDefault | Value = 0 | It does not exist" -ForegroundColor Red
    }
    if($RegistryChecker1_2B.Enabled -eq 1){        
        Write-Host "TLS 1.2 | TLS 1.2\Client\Enabled | Value = 1 | Registry Key exist" -ForegroundColor Green
        Write-Host "################################"
    }Else{        
        Write-Host "TLS 1.2 | TLS 1.2\Client\Enabled | Value = 1 | It does not exist" -ForegroundColor Red
        Write-Host "################################"
    }

##### SSLv2
    if($RegistryCheckerSSLv2.DisabledByDefault -eq 1){ 
    Write-Host "################################"       
        Write-Host "SSLv2 | SCHANNEL\Protocols\SSL 2.0\Server | Value = 1 | Registry Key exist" -ForegroundColor Green
        Write-Host "################################"       
    }Else{        
    Write-Host "################################"
        Write-Host "SSLv2 | SCHANNEL\Protocols\SSL 2.0\Server | Value = 1 | It does not exist" -ForegroundColor Red
        Write-Host "################################"       
    }

##### SSLv3
    if($RegistryCheckerSSLv2.DisabledByDefault -eq 1){ 
    Write-Host "################################"       
        Write-Host "SSLv3 | SCHANNEL\Protocols\SSL 3.0\Server | Value = 1 | Registry Key exist" -ForegroundColor Green
        Write-Host "################################"       
    }Else{        
    Write-Host "################################"
        Write-Host "SSLv3 | SCHANNEL\Protocols\SSL 3.0\Server | Value = 1 | It does not exist" -ForegroundColor Red
        Write-Host "################################"       
    }

##### Triple 3DES
    if($RegistryCheckerSSLv2.DisabledByDefault -eq 0){ 
    Write-Host "################################"       
        Write-Host "Triple 3DES | SCHANNEL\Ciphers\Triple DES 168 | Value = 0 | Registry Key exist" -ForegroundColor Green
        Write-Host "################################"       
    }Else{        
    Write-Host "################################"
        Write-Host "Triple 3DES | SCHANNEL\Ciphers\Triple DES 168 | Value = 0 | It does not exist" -ForegroundColor Red
        Write-Host "################################"       
    }

##### RC4
    if($RegistryCheckerRC4_128.Enabled -eq 0){ 
    Write-Host "################################"       
        Write-Host "RC4_128 | SCHANNEL\Ciphers\RC4 128/128 | Value = 0 | Registry Key exist" -ForegroundColor Green
    }Else{        
    Write-Host "################################"
        Write-Host "RC4_128 | SCHANNEL\Ciphers\RC4 128/128 | Value = 0 | It does not exist" -ForegroundColor Red
    }
    if($RegistryCheckerRC4_40.Enabled -eq 0){        
        Write-Host "RC4_40 | SCHANNEL\Ciphers\RC4 40/128 | Value = 0 | Registry Key exist" -ForegroundColor Green        
    }Else{        
        Write-Host "RC4_40 | SCHANNEL\Ciphers\RC4 40/128 | Value = 0 | It does not exist" -ForegroundColor Red        
    }
    if($RegistryCheckerRC4_56.Enabled -eq 0){        
        Write-Host "RC4_56 | SCHANNEL\Ciphers\RC4 56/128 | Value = 0 | Registry Key exist" -ForegroundColor Green
        Write-Host "################################"
    }Else{        
        Write-Host "RC4_56 | SCHANNEL\Ciphers\RC4 56/128 | Value = 0 | It does not exist" -ForegroundColor Red
        Write-Host "################################"
    }
}
