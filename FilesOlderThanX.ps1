$Source = "D:\" # Quelle. Muss mit "\" enden.
$Days = 180     # Anzahl der Tage
$log = "$Source$(get-date -format yymmddHHmm).txt"
$DateBeforeXDays = (Get-Date).AddDays(-$Days)

#Start Script
Start-Transcript $log
Write-Host "---------------------------------------------------------"
Write-Host "Auflisten aller Dateien älter als $Days im Ordner $Source"
Write-Host "---------------------------------------------------------"
Get-ChildItem $Source -Recurse | where {$_.LastAccessTime -lt $DateBeforeXDays}
Stop-Transcript