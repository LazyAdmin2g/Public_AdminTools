$ExchangeServer = "MAGVEX02"
$DCServer = "MAGVDC02"
$FileServer = "MAGVFS02"
$User = "mag\administrator"
$Pwd = Read-Host -AsSecureString "Bitte geben Sie das Adminkennwort ein, um sich mit allen benötigten Servern zu verbinden"
$SecCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pwd

#region Connections
#Verbindung mit Domaincontroller
if (!(Get-PSSession | Where { $_.ConfigurationName -eq "Microsoft.PowerShell" })) 
    { 
    $DCSession = New-PSSession -ComputerName $DCServer -Credential $SecCred
    Import-PSSession $DCSession -Module ActiveDirectory -ErrorAction SilentlyContinue -AllowClobber
    }
    else{"$DCServer ist bereits verbunden"}