Install-Module -Name PnP.PowerShell
Connect-PnPOnline -Url "https://atos90.sharepoint.com/" -UseWebLogin
Add-PnPUserToGroup -LoginName bhanusaikumar@atos90.onmicrosoft.com -Identity 'PSTeam'
Write-Host "A user is added to the SharePoint Group."
