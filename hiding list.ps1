Connect-PnPOnline -Url "https://atos90.sharepoint.com/sites/PowerAppsSharePoint" -UseWebLogin
$ListName="Exception Handling"
Set-PnPList -Identity $ListName -Hidden $false