$startTime = "{0:G}" -f (Get-date)
Write-Host "*** Script started on $startTime ***" -f Black -b DarkYellow

# +++ CHANGE TO YOUR VALUES +++
#$tenantName = "https://atos93.sharepoint.com/sites/pk"
#$sitesCSV = "E:\CSV FILES\Book1.csv"


#Connect to SPO Admin Center
Connect-PnPOnline -Url "https://atos93.sharepoint.com/sites/pk" -UseWebLogin

$result = @()
#$allSites = Import-Csv -Path $sitesCSV
$logFile = "E:\CSV FILES\Checkedout files.csv"

    #Get all libraries
    $allLists = Get-PnPList  | Where-Object {( $_.BaseTemplate -eq 101)}
    
    foreach ($list in $allLists) {
        $allDocs = (Get-PnPListItem -List $list) 
    
        foreach ($doc in $allDocs) {

            if ($null -ne $doc.FieldValues.CheckoutUser.LookupValue) {
                $result += [PSCustomObject][ordered]@{
                    Site         = $site.SiteName
                    Library      = $list.Title
                    FileName     = $doc["FileLeafRef"]
                    CheckedOutTo = $doc.FieldValues.CheckoutUser.LookupValue
                    FullLocation = $doc["FileRef"]
                }
            }
        }
    }

$result | Export-Csv -Path $logFile -NoTypeInformation

#End Time
$endTime = "{0:G}" -f (Get-date)
Write-Host "*** Script finished on $endTime ***" -f Black -b DarkYellow
Write-Host "Time elapsed: $(New-Timespan $startTime $endTime)" -f White -b DarkRed
