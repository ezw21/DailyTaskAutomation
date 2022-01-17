$LogPath = "C:\Users\exw\Desktop\NotServer\edw_x_Launch.txt"
$XLauncherPath = "C:\Users\exw\Desktop\config.xlaunch"

("Local Time " + (Get-Date -UFormat "%A %m/%d/%Y %R").ToString()) | Format-List >> $LogPath

"STOP"  | Format-List >> $LogPath
Stop-Process -Name vcxsrv -PassThru -ErrorAction Ignore | Format-List >> $LogPath
"Start" | Format-List >> $LogPath
Start-Process -FilePath $XLauncherPath -PassThru | Format-List >> $LogPath

$PROC = Get-Process -Name vcxsrv -ErrorAction Ignore
("isResponding : $($PROC.Responding)") | Format-List >> $LogPath

$PROC | Format-Table `
@{Label = "NPM(K)"  ; Expression = { [int]($_.NPM / 1024) } },
@{Label = "PM(K)"   ; Expression = { [int]($_.PM / 1024) } },
@{Label = "WS(K)"   ; Expression = { [int]($_.WS / 1024) } },
@{Label = "VM(M)"   ; Expression = { [int]($_.VM / 1MB) } },
@{Label = "CPU(s)"  ; Expression = { if ($_.CPU) { $_.CPU.ToString("N") } } },
Id, MachineName, ProcessName -AutoSize >> $LogPath
Read-Host -Prompt "Press any key to exit"