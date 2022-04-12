$SiteURL = "https://atos93.sharepoint.com/sites/pk"

#Get Credentials to connect
$Cred = Get-Credential

Connect-PnPOnline -Url $SiteURL -UseWebLogin
Set-PnPSite -Identity $SiteURL -LockState "Unlock"
$listName="Issue tracker"
$list = Get-PnPList -Identity $listTitle  
If($list.Title -eq $listName)  
        {  
           write-Host  ("SharePoint List is already exists")   
        }  
        else 
        {
            Connect-PnPOnline -Url $SiteURL -Credentials $cred            
            New-PnPList -Title $listName  -Template GenericList
            Write-Host ("SharePoint List is created")
        }


