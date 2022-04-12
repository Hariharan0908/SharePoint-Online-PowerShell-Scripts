$SiteURL = "https://atos87.sharepoint.com/sites/DemoPnP"
#Get Credentials to connect
$Cred = Get-Credential
Connect-PnPOnline -Url $SiteURL -UseWebLogin
Add-PnPNavigationNode -Title "Wiki2" -Location "QuickLaunch" -Url "https://google.com"  

    