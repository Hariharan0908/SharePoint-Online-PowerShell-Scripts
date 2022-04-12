
Connect-PnPOnline -Url https://atos93.sharepoint.com/sites/pk -UseWebLogin

#Output path
$outputPath = "E:\CSV FILES\specificFiles.csv"

#Store in variable all the document libraries in the site
$DocLibs = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 } 

#Loop thru each document library & folders
$results = @()
foreach ($DocLib in $DocLibs) {
    $AllItems = Get-PnPListItem -List $DocLib -Fields "FileRef", "File_x0020_Type", "FileLeafRef"
    
    #Loop through each item
    foreach ($Item in $AllItems) {
        ## Change *ABC* and *BCD* to your own requirements
        if (($Item["FileLeafRef"] -like "*ABC*") -or ($Item["FileLeafRef"] -like "*BCD*")) {
            Write-Host "File found. Path:" $Item["FileRef"] -ForegroundColor Green
            
            #Creating new object to export in .csv file
            $results += New-Object PSObject -Property @{
                Path          = $Item["FileRef"]
                FileName      = $Item["FileLeafRef"]
                FileExtension = $Item["File_x0020_Type"]
            }
        }
    }
}
$results | Export-Csv -Path $outputPath -NoTypeInformation