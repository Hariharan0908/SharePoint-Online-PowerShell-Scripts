Install-Module -Name PnP.PowerShell
#$SiteURL ="https://atos90.sharepoint.com/"
Connect-PnPOnline -Url https://atos90.sharepoint.com/ -UseWebLogin
$mySites = Import-Csv -Path 'E:\CSV FILES\Book1.csv'

#Create all for each site
foreach ($site in $mySites) {
    
    #Connect to each site
    Write-Host "Connecting to $($site.$SiteURL)" -ForegroundColor Green
    Connect-PnPOnline -Url https://atos90.sharepoint.com/ -UseWebLogin
    
    #Create the NEW permission level (clone the 'READ' default permissions)
    $PermToClone = Get-PnPRoleDefinition -Identity "Read"
    $addPnPRoleDefinitionSplat = @{
        Include     = 'ManagePersonalViews', 'UpdatePersonalWebParts', 'AddDelPrivateWebParts'
        Description = "Copy of Read + Personal Permissions"
        RoleName    = "myCustomPermLevel"
        Clone       = $PermToClone
    }
    Add-PnPRoleDefinition @addPnPRoleDefinitionSplat
}