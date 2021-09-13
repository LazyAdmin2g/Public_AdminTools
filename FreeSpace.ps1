if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$Servers = Get-Content "\\MAGVFS03\ShareFiles$\Scripts_AdminTool\FreeSpaceServerList.txt"
$Drives = "C:","D:","E:","F:"
 
$report = @()
 
#Looping each server
Foreach($Server in $Servers)
{
    $Server = $Server.trim()
    Write-Host "Processing $Server" -ForegroundColor Green
    Try
    {
        $Disks = Get-WmiObject -Class win32_logicaldisk -ComputerName $Server -ErrorAction Stop
    }
    Catch
    {
        $_.Exception.Message
        Continue
    }    
        If(!$Disks)
        {
            Write-Warning "Something went wrong"
        }
        Else
        {
            # Adding properties to object
            $Object = New-Object PSCustomObject
            $Object | Add-Member -Type NoteProperty -Name "ServerName" -Value $Server
         
            Foreach($Letter in $Drives)
            {
                Switch ($Letter)
                {
                    "C:"     { $Val = "OS (C:)"}
                    "D:"     { $Val = "Data (D:)"}
                    "E:"     { $Val = "Logs1 (E:)"}
                    "F:"     { $Val = "Logs2 (F:)"}
                }
 
                $FreeSpace = ($Disks | Where-Object {$_.DeviceID -eq "$Letter"} | Select-Object @{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}}).freespace 
                If($FreeSpace)
                {
                    $Value = "$Freespace" + " GB"
                    $Object | Add-Member -Type NoteProperty -Name "$Val" -Value $Value   
                }
                Else
                {
                    $Object | Add-Member -Type NoteProperty -Name "$Val" -Value "(not found)"
                }
            }
            $report += $object
        }
} 
 
#Display results
return $report
 
#Save results to CSV file
$report | Export-Csv -Path C:\Scripts\free_space.csv -NoTypeInformation -Force
pause