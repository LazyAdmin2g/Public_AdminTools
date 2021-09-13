    #Zu prüfendes Verzeichnis oder Volume:
    $Verzeichnis = „M:\10 Projekte“

    #Pfad zur CSV-Datei für den Export:
    $CSV = „d:\temp\export.csv“

    #Warnstufe für Pfade über XX Zeichen Laenge in CSV schreiben
    $Warninglevel = „250“

    #———————————————–
    „Pfad;Laenge“ | set-content „$CSV“
    $dirlist = Get-ChildItem „$Verzeichnis“ -recurse | foreach {$_.Fullname}
    foreach ($dir in $dirlist)
    {
    $a = $dir | Measure-Object -Character
    $length = $a.characters

    if ($length -gt $Warninglevel)
    {
    „$dir;$length“ | add-content „$CSV“
    }
    }
    $sort = import-csv „$CSV“ -delimiter „;“ | Sort-Object -Property Laenge -Descending
    „“ | set-content „$CSV“
    $sort | export-csv „$CSV“ -delimiter „;“ –NoTypeInformation