clear-host

Function Get-InstalledPrinter
{
<#
.SYNOPSIS
Uses Get-WMIObject Win32_Printer to list all printers installed.
 
.DESCRIPTION
Uses Get-WMIObject Win32_Printer to list all printers installed.

.PARAMETER ComputerName
Accepts input for one or more computer names.

.EXAMPLE
Get-InstalledPrinter -ComputerName computername1

.EXAMPLE
"computername1" | Get-InstalledPrinter

.EXAMPLE
Run on a local computer
Get-InstalledPrinter
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,
                    ValueFromPipeline=$True,
                    ValueFromPipelinebyPropertyName=$True)]
        [string[]]$ComputerName
    )

    BEGIN
    {
		Write-Output "`nGetting all installed printers ...`n"
    }

    PROCESS
    {
        foreach ($Computer in $ComputerName)
        {
            if ( Test-Connection -ComputerName $computer -Count 1 -ErrorAction SilentlyContinue )
            {
                Write-Output "$Computer"
                $printer = Get-WMIObject Win32_Printer -ComputerName $Computer | Select-Object Name,PortName #Try Caption instead of Name
                #Export-Csv $printer -Path C:\Scripts\printers\store_printers.csv

                #Creates VAR for file location
                $fileName = "C:\temp\"+$ComputerName+".txt"
                #Timer waits for 2 seconds
                Start-Sleep 2
                #Creates a single file & add the results of the query to the file.
                Add-Content -Path $fileName -Value (Get-WMIObject Win32_Printer -ComputerName $Computer | Select-Object Name,PortName)
                
            }
            else
            {
                Write-Warning "$Computer is not pingable ..."
            }
        }
    }

    END
    {
        Write-Output "The script is complete!  Check over output for any warnings."
    }

}
