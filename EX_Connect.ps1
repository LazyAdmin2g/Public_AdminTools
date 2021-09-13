$ExchangeServer = "MAGVEX02"
$DCServer = "MAGVDC02"
$FileServer = "MAGVFS02"
$User = "mag\administrator"
$Pwd = Read-Host -AsSecureString "Bitte geben Sie das Adminkennwort ein, um sich mit allen benötigten Servern zu verbinden"
$SecCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pwd

#Verbindung mit Exchange
if (!(Get-PSSession | Where { $_.ConfigurationName -eq "Microsoft.Exchange" }))
    {
    $EXSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$ExchangeServer/PowerShell/ -Credential $SecCred -Authentication Kerberos 
    Import-PSSession $EXSession -DisableNameChecking -AllowClobber -ErrorAction SilentlyContinue    
    }
    else{"$ExchangeServer ist bereits verbunden"}