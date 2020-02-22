$SourcePath = 'C:\temp\testFolder\'
$DestinationPath = 'C:\temp\'
$Logfile = 'C:\temp\TLog_transfer.txt'
$RobocopySwitches = '/E /ZB'

robocopy $SourcePath $DestinationPath $RobocopySwitches /LOG:$Logfile
