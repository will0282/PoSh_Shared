#Enables/Disables NumLock
$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys('{NUMLOCK}')

break

#Enables/Disables CapsLock
$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys('{CAPSLOCK}')
