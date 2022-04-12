$SiteURL = "https://atos87.sharepoint.com/sites/DemoPnP"
#Get Credentials to connect
$Cred = Get-Credential
Connect-PnPOnline -Url $SiteURL -UseWebLogin
#$ListName = "Helloworld2"  
#Hide the list using PnP PowerShell  
Set-PnPList -Identity "Helloworld2" -Hidden 1
Disconnect-PnPOnline  