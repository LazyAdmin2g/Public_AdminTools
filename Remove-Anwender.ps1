<#
    .DESCRIPTION
    Löscht den ausgewählten User aus der Registry, unter C:\Users und in der Computerverwaltung
#>

$UserAccount = Get-CimInstance Win32_UserProfile -Filter "Loaded = '$false'" | Select LocalPath, SID, Loaded | ogv -Title 'Wähle den zu löschenden User aus' -PassThru
$UserName = $UserAccount.LocalPath
$Ausgabe = $UserName.remove(0,9)
$Fenster = New-Object -ComObject wscript.shell

If($UserAccount -notin $Null, '')
{
    Do
    {
    $Answer = Read-Host "Wirklich $($Ausgabe) löschen? (J, N)"
    } Until ($Answer -in 'J' , 'N')
    If($Answer -eq 'N'){Return}
}else {Return}

Get-CimInstance Win32_UserProfile -Filter "SID = '$($UserAccount.SID)'" | Remove-CimInstance
$Fenster.popup("Das Profil $Ausgabe wurde gelöscht", 0,"Bestätigung",4096)

([ADSI] 'WinNT://localhost').delete('user', $Ausgabe)