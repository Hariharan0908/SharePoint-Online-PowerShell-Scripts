$SiteURL = "https://atos93.sharepoint.com/"

#Get Credentials to connect
$Cred = Get-Credential

Connect-PnPOnline -Url $SiteURL -UseWebLogin
$web=Get-PnPWeb -Includes Created
write-host $web.Created