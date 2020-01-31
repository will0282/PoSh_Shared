#Change the Xs & Ys for the correct input information. This means your email account at O365
$emailFROM = "XXXXXXXXXXXXXX@AAAAAAAAAAA.org"
#Change the Ys & As for the correct information. This means the email of the person who will recive the email.
$emailTO = "YYYYYYYYYYY@AAAAAAAAAA.com"

Send-MailMessage -From $emailFROM -Subject "Test007" -To $emailTO -Body "This is another test of powershell sending emails." -Credential $emailFROM  -Port 587 -SmtpServer smtp.office365.com -UseSsl
