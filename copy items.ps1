Install-Module -Name PnP.Powershell
$sourceurl="https://atos90.sharepoint.com/sites/PowerAppsSharePoint/"
$destinationurl="https://atos90.sharepoint.com/sites/PSTeam/"
Connect-PnPOnline -Url $sourceurl -UseWebLogin
$Listname="Issue tracker"
$Fieldname="Title","Issue description","Priority","Status"
$listItems = Get-PnPListItem -List $Listname -Fields $Fieldname
Connect-PnPOnline -Url $destinationurl -UseWebLogin
foreach($listItem in $listItems) {  
    $itemValues = @{  
        "Title" = $listItem["Title"];  
        "Issue description" = $listItem["Issue description"];  
        "Priority" = $listItem["Priority"]  
        "Status" = $listItem["Status"]
    }  
    Add-PnPListItem -List $listName -Values $itemValues  
}  