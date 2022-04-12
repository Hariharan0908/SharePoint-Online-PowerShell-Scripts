Connect-PnPOnline -Url "https://atos93.sharepoint.com/sites/pk" -UseWebLogin

#Store in variable all the document libraries in the site
$DocLibrary = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 } 
$LogFile = "E:\CSV FILES\SPOLargeFiles.csv"

$results = @()
foreach ($DocLib in $DocLibrary) {
    #Get list of all folders in the document library
    $AllItems = Get-PnPListItem -List $DocLib -Fields "SMTotalFileStreamSize"
    
    #Loop through each files/folders in the document library for >50Mb
    foreach ($Item in $AllItems) {
        if ((([int]$Item["SMTotalFileStreamSize"]) -ge 50000000) -and ($Item["FileLeafRef"] -like "*.*")) {
            Write-Host "File found:" $Item["FileLeafRef"] -ForegroundColor Yellow
        
            #Creating new object to export in .csv file
            $results += [pscustomobject] @{
                FileName         = $Item["FileLeafRef"] 
                FilePath         = $Item["FileRef"]
                SizeInMB         = ($Item["SMTotalFileStreamSize"] / 1MB).ToString("N")
                LastModifiedBy   = $Item.FieldValues.Editor.LookupValue
                EditorEmail      = $Item.FieldValues.Editor.Email
                LastModifiedDate = [DateTime]$Item["Modified"]
            }
        }#end of IF statement
    }
}
$results | Export-Csv -Path $LogFile -NoTypeInformation
