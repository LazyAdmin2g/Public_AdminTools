cls
<#
 # First Idea comes from here                    ==>  
 # How to Enter Netflix's Secret Codes           ==> https://www.makeuseof.com/tag/enter-netflix-secret-codes/?utm_source=MUO-NL-RP&utm_medium=newsletter
 # Second Idea for building an Easy Menu         ==> https://www.reddit.com/r/PowerShell/comments/9plt0b/easy_tool_menu/
 # Third  Idea for multiple-foreground-colors    ==> https://stackoverflow.com/questions/2688547/multiple-foreground-colors-in-powershell-in-one-command#6794939
#>
############# Playing Music in Background just for relax and have fun #################
Add-Type –assemblyName PresentationFramework
Function Start-Music {
  $code = {
  $Radios_Stations_Array = @(
  "http://retro.dancewave.online/retrodance.mp3",
  "http://www.leeholmes.com/projects/ps_html5/background.mp3",
  "http://94.23.221.158:9197/stream",
  "http://streaming2.toutech.net:8000/jfmweb4",
  "http://streaming2.toutech.net:8000/jfmweb3",
  "http://radio.mosaiquefm.net:8000/mosagold",
  "http://radio.mosaiquefm.net:8000/mosadj",
  "https://stream.initialradio.fr:8443/djbuzz-192k.mp3",
  "http://audio1.maxi80.com"
  )
                       
    $MyShuffledList = $Radios_Stations_Array | Sort {Get-Random}
    $url = $MyShuffledList[1]
    $player = New-Object -ComObject 'MediaPlayer.MediaPlayer'
    $player.Open($url)
    $player
  }
 
  $script:ps = [PowerShell]::Create()
  $script:player = @($ps.AddScript($code).Invoke())[0]
}
#######################################################################################
Function Stop-Music
{
  if ($script:player -ne $null)
  {
    $script:player.Stop()
    Remove-Variable -Name player -Scope script
  }
  if ($script:ps -ne $null)
  {
    $script:ps.Runspace.Close()
    $script:ps.Dispose()
    Remove-Variable -Name ps -Scope script
  }
}
#######################################################################################
Function Write-Color([String[]]$Text, [ConsoleColor[]]$ForeGroundColor, [ConsoleColor[]]$BackGroundColor) {
    for ($i = 0; $i -lt $Text.Length; $i++) {
        $Color = @{}
        if ($ForeGroundColor -and $BackGroundColor){
            $Color = @{
                ForegroundColor = $ForeGroundColor[$i%($ForeGroundColor.count)]
                BackgroundColor = $BackGroundColor[$i%($BackGroundColor.count)]
            }
        } elseif ($ForeGroundColor) {
            $Color = @{
                ForegroundColor = $ForeGroundColor[$i%($ForeGroundColor.count)]
            }
        } elseif ($BackGroundColor) {
            $Color = @{
                BackgroundColor = $BackGroundColor[$i%($BackGroundColor.count)]
            }
        }
        Write-Host $Text[$i] @color -NoNewLine
    }
    Write-Host
}
#######################################################################################
$Hidden_Codes = @("1365","7424","11177","7687","11559","9434","384","10398","8195","32392","10702","1492","31851","5505")
 
$Genres = @("Action and Adventure","Anime","TV Cartoons","Film Noir","Stand-up Comedy","Cult Comedies","Independent Dramas","Japanese Movies",
"B-Horror Movies","Classic Musicals","Spy Action and Adventure","Sci-Fi and Fantasy","Gangster Movies","Psychological Thrillers")
 
$dico = New-Object 'system.collections.generic.dictionary[string,string]'
 
# Fill our dictionary with informations keys and their Values
for($i=0;$i-le $Hidden_Codes.length-1;$i++) {
        $dico.Add($Hidden_Codes[$i],$Genres[$i])
}
#######################################################################################
# Main menu, allowing user selection
Function Show-Menu
{
     param (
           [string]$Title = 'Hidden Codes for NetFlix'
     )
        cls
        Write-Host "================ $Title ================" -fore Cyan
     
    # Show Results
    foreach ($key in $dico.Keys) { 
        Write-Color $key.PadRight(17) , $($dico[$key]) -fore Magenta,Cyan
    } 
        Write-Host "==========================================================" -fore Cyan
        Write-Color "By Hackoo".PadRight(16), '[', ' Q : Press "Q" to quit !', ']' -fore Yellow,Magenta,Cyan
        Write-Host "==========================================================" -fore Cyan
        Write-Color ""
}
#######################################################################################
$url = "https://www.netflix.com/browse/genre/"
Start-Music
#Main menu loop
Do
{
     Show-Menu
     Write-Color "Please just type the numeric hidden code correspondent : " -Fore Cyan
     $input = Read-Host
     switch ($input)
     {
           '1365' {
                cls
                Write-Color "Action and Adventure" -Fore Cyan
                saps $url$input 
                
           } '7424' {
                cls
                Write-Color "Anime" -Fore Cyan
                saps $url$input
                
           } '11177' {
                cls
                Write-Color "TV Cartoons" -Fore Cyan
                saps $url$input
 
           } '7687' {
                cls
                Write-Color "Film Noir" -Fore Cyan
                saps $url$input
           } '11559' {
                cls
                Write-Color "Stand-up Comedy" -Fore Cyan
                saps $url$input
           } '9434' {
                cls
                Write-Color "Cult Comedies" -Fore Cyan
                saps $url$input
           } '384' {
                cls
                Write-Color "Independent Dramas" -Fore Cyan
                saps $url$input
           } '10398' {
                cls
                Write-Color "Japanese Movies" -Fore Cyan
                saps $url$input
           } '8195' {
                cls
                Write-Color "B-Horror Movies" -Fore Cyan
                saps $url$input
           } '32392' {
                cls
                Write-Color "Classic Musicals" -Fore Cyan
                saps $url$input 
           } '10702' {
                cls
                Write-Color "Spy Action and Adventure" -Fore Cyan
                saps $url$input  
           } '1492' {
                cls
                Write-Color "Sci-Fi and Fantasy" -Fore Cyan
                saps $url$input  
           } '31851' {
                cls
                Write-Color "Gangster Movies" -Fore Cyan
                saps $url$input  
           } '5505' {
                cls
                Write-Color "Psychological Thrillers" -Fore Cyan
                saps $url$input                               
           } 'q' {
                Stop-Music
                return
           }
     }
     pause
}
until ($input -eq 'q')