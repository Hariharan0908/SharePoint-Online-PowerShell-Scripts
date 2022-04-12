$siteurl = "https://atos90.sharepoint.com/sites/PowerAppsSharePoint"
#User Credentials  
#$credential = Get-Credential # Connects and Creates Context  
Connect-PnPOnline -Url "https://atos93.sharepoint.com/sites/pk" -UseWebLogin 

# Retrive List Item  
$listItems = Get-PnPListItem -List "Issue tracker" -Fields "Title"
foreach($listItem in $listItems) {  
    Write-Host "Id : "  
    $listItem["ID"]  
    Write-Host "Title : "  
    $listItem["Title"]  
    #Write-Host "Phone Number : "  
    #$listItem["Phone Number"]  
    Write-Host "------------------------------------"  
}  
  
# Retrive List Item Using CAML Query  
$listItems = Get-PnPListItem -List "Client Details" -Query "<View><Query><Where><Eq><FieldRef Name='Title'/><Value Type='Text'>Title 1</Value></Eq></Where></Query></View>"  
foreach($listItem in $listItems) {  
    Write-Host "Id : "  
    $listItem["ID"]  
    Write-Host "Title : "  
    $listItem["Title"]  
   # Write - Host "Phone Number : "  
    #$listItem["Phone Number"]  
    Write-Host "------------------------------------"  
}  
 
# Add List Item  
Add-PnPListItem -List "Issue tracker" -Values @{  
    "Title" = "Added Title from Powershell"; 
     
}  
   
# Update List Item Using Item ID  
Set-PnPListItem -List "Issue tracker" -Identity 2 -Values  @{  
    "Title" = "Updated Title from Powershell"  
}  
  
# Update List Item Using CAML Query  
$item = Get-PnPListItem -List "Issue tracker" -Query "<View><Query><Where><Eq><FieldRef Name='Title'/><Value Type='Text'>Title 1</Value></Eq></Where></Query></View>"  
if ($item -ne $null) {  
    Set-PnPListItem -List "Issue tracker" -Identity $item -Values @{  
        "Title" = "Updated Title"  
    }  
}  
  
#Delete List Item  
Remove-PnPListItem -List "Issue tracker" -Identity 2 -Force  