Install-Module -Name PnP.PowerShell
Connect-PnPOnline -Url "https://atos90.sharepoint.com/" -UseWebLogin
Remove-PnPTenantSite -Url https://atos90.sharepoint.com/sites/DemoTeamsites 
Write-Host "SharePoint Online Team site is removed"
