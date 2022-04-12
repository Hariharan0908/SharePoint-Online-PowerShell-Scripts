$TenantURL = "https://atos93-admin.sharepoint.com"
$SiteURL = "https://atos93.sharepoint.com/sites/USTeams"
 
Try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $TenantURL -UseWebLogin
 
    #Set Site to Read-only
    Set-PnPTenantSite -Url $SiteURL -LockState ReadOnly
    Write-Host "Site set to Read-Only Mode Successfully!" -f Green 
}
Catch {
    Write-Host -f Red "Error:"$_.Exception.Message
 }


#Read more: https://www.sharepointdiary.com/2019/02/set-sharepoint-online-site-to-read-only-using-powershell.html#ixzz7PqH3BkZ9