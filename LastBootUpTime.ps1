if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$CPU = Read-Host 'Bitte CPU Nummer eintragen (CPU000XXX)'
Get-WinEvent -ProviderName eventlog -Computername "$CPU" | Where-Object {$_.Id -eq 6005} | Select-Object -First 1
Read-Host -Prompt "Bitte eine beliebige Taste zum Beenden drücken ..."