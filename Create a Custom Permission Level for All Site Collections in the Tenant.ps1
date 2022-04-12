$Domain =  "Atos93" #Domain Name in SharePoint Online. E.g. https://Crescent.sharepoint.com
$NewPermissionLevelName = "Contribute without Delete"
$BasePermissionLevelName = "Contribute"
    
#Frame Tenant URL and Tenant Admin URL
$TenantURL = "https://atos93.sharepoint.com/sites/USTeams"
$TenantAdminURL = "https://$Domain-Admin.SharePoint.com"
 
#Get Credentials to connect
#$Cred = Get-Credential
 
#Connect to Admin Center
Connect-PnPOnline -Url $TenantAdminURL -UseWebLogin
    
#Get All Site collections - Filter BOT and MySite Host
$Sites = Get-PnPTenantSite -Filter "Url -like '$TenantURL'"
   
#Iterate through all site collections
$Sites | ForEach-Object {
    #Connect to each site collection
    $SiteConn = Connect-PnPOnline -Url $_.URL -UseWebLogin
  
    #check if the given permission level exists already!
    $NewPermissionLevel = Get-PnPRoleDefinition | Where-Object { $_.Name -eq $NewPermissionLevelName } 
    If($NewPermissionLevel -eq $null)
    {
        #Get Permission level to copy
        $BaseRoleDefinition = Get-PnPRoleDefinition -Identity $BasePermissionLevelName
  
        #Create a custom Permission level and exclude delete from contribute 
        Add-PnPRoleDefinition -RoleName $NewPermissionLevelName -Clone $BaseRoleDefinition -Exclude DeleteListItems, DeleteVersions -Description "Contribute without delete permission" | Out-Null
        Write-host "Created Permission Level at $($_.URL)" -f Green
    }
    Else
    {
        Write-host "Permission Level Already Exists at $($_.URL)" -ForegroundColor Yellow
    }
    Disconnect-PnPOnline -Connection $SiteConn
}
