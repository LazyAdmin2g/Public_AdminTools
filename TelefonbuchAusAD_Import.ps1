get-aduser -properties * -filter {Mobile -Like "*" -or officephone -Like "*"} -Searchbase "OU=Mitarbeiter,OU=Benutzer,OU=merTens,DC=mertens,DC=ag" | 
select name, emailaddress,officephone,mobile,Description,l |
export-csv "M:\00 IT\Projekte\Mitarbeiter Tool  myApp\Import_Files\telefonbuch.csv" -NoTypeInformation -encoding "unicode"
