Connect-PnPOnline -Url "https://atos93.sharepoint.com/sites/pk"

#Target multiple lists 
$allLists = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 }

#Store the results
$results = @()

foreach ($row in $allLists) {
    $allItems = Get-PnPListItem -List $row.Title -Fields "FileLeafRef", "SMTotalFileStreamSize", "FileDirRef", "FolderChildCount", "ItemChildCount"
    
    foreach ($item in $allItems) {
        
        #Narrow down to folder type only
        if (($item.FileSystemObjectType) -eq "Folder") {
            $results += New-Object psobject -Property @{
                FileType          = $item.FileSystemObjectType  #This will return a column with "Folder"
                RootFolder        = $item["FileDirRef"] 
                LibraryName       = $row.Title
                FolderName        = $item["FileLeafRef"]
                FullPath          = $item["FileRef"]
                FolderSizeInMB    = ($item["SMTotalFileStreamSize"] / 1MB).ToString("N")
                NbOfNestedFolders = $item["FolderChildCount"]
                NbOfFiles         = $item["ItemChildCount"]
            }
        }
    }
}
#Export the results
$results | Export-Csv -Path "E:\CSV FILES\GetNetsedFilesandFolders.csv" -NoTypeInformation