#Properties
#msDS-ExternalDirectoryObjectID

$OUListe = @(
"OU=Willich,OU=Mitarbeiter,OU=Benutzer,OU=merTens,DC=mertens,DC=ag",
"OU=Wiesbaden,OU=Mitarbeiter,OU=Benutzer,OU=merTens,DC=mertens,DC=ag",
"OU=Monteure,OU=Mitarbeiter,OU=Benutzer,OU=merTens,DC=mertens,DC=ag",
"OU=Berlin,OU=Mitarbeiter,OU=Benutzer,OU=merTens,DC=mertens,DC=ag",
"OU=AreaOFFICE,OU=Mitarbeiter,OU=Benutzer,OU=merTens,DC=mertens,DC=ag",
"OU=Mitarbeiter-Ausgeschieden,OU=Benutzer,OU=merTens,DC=mertens,DC=ag"
)

$ExcludeUser = "admin teos","admin.m365","Edward Rong","Ivan Tech", "i.tech", "norman rieger pro-data"

$results = foreach($OU in $OUListe)
{
    Get-ADUser -Filter * -SearchBase $OU -Properties name, givenname, surname, description,mail, samaccountname, msDS-ExternalDirectoryObjectID, enabled, office, mobile, telephoneNumber | where {$ExcludeUser -notcontains $_.name} | select givenname, surname, description,mail, samaccountname, msDS-ExternalDirectoryObjectID, enabled, office, mobile, telephoneNumber
}
$results | Export-CSV -Path "M:\00 IT\Projekte\Mitarbeiter Tool  myApp\merTensMitarbeiter_Exp.csv" -NoTypeInformation -Encoding UTF8