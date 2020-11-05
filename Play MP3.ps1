# Play a single file
Add-Type -AssemblyName presentationCore
$mediaPlayer = New-Object system.windows.media.mediaplayer
$mediaPlayer.open('C:\Users\XXXXXXXXXXXXX\Desktop\Goat Scream.mp3')
$mediaPlayer.Play()
