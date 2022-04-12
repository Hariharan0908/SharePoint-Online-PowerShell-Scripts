Connect-PnPOnline -Url "https://atos90.sharepoint.com" -UseWebLogin
$allDeletedItems = Get-PnPRecycleBinItem
$results = @()

foreach($item in $allDeletedItems){
    $userID = (Get-PnPAzureADUser | Where-Object {$_.DisplayName -match $item.DeletedByName}).Id
    
    $results += [pscustomobject]@{
        fileName = $item.LeafName
        deletedBy = $item.DeletedByName
        deletedDate = $item.DeletedDate
        userID = $userID
    }
}
$results



$results = @()
$allLists = Get-PnPList | Where-Object { $_.BaseTemplate -eq 100 }

#Loop thru each lists
foreach ($list in $allLists) {
    $allItems = Get-PnPListItem -List $list.Title
    
    #Loop thru thru each item in the list(s)
    foreach ($item in $allItems) {
        $allProps = Get-PnPProperty -ClientObject $item -Property "AttachmentFiles"
        
        #Loop thru each property and grab the ones we want!
        foreach ($prop in $allProps) {
            $results += [pscustomobject][ordered]@{
                ListName           = $list.Title
                ItemName           = $item["Title"]
                ItemCreatedBy      = $item.FieldValues.Author.LookupValue
                ItemLastModifiedBy = $item.FieldValues.Editor.LookupValue
                AttachmentNames    = $prop.FileName
                ServerRelativeUrl  = $prop.ServerRelativeUrl
            }
        }
    }
}
$results | Export-Csv -Path "E:\CSV FILES\SPOEmptyFolders" -NoTypeInformation