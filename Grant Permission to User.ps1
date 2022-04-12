$SiteURL = "https://atos93.sharepoint.com/sites/pk"
$UserAccount = "haripriya@atos93.onmicrosoft.com"
$PermissionLevel = "Contribute"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -UseWebLogin 
 
#grant access to sharepoint online site with powershell
Set-PnPWebPermission -User $UserAccount -AddRole $PermissionLevel


#Read more: https://www.sharepointdiary.com/2020/04/sharepoint-online-powershell-to-grant-site-permissions-to-user.html#ixzz7PqM8HbYk