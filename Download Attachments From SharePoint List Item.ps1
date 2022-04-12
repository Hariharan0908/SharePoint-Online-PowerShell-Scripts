$SiteURL = "https://atos87.sharepoint.com/sites/DemoPnP"
#Get Credentials to connect
$Cred = Get-Credential
Connect-PnPOnline -Url $SiteURL -UseWebLogin
$listitem = Get-PnPListItem -List Helloworld -Id 4
$attachments = ForEach-Object{Get-PnPProperty -ClientObject $listitem -Property "AttachmentFiles"}  

$attachments | ForEach-Object { Get-PnPFile -Url $_.ServerRelativeUrl -FileName $_.FileName -Path "E:\Resume" -AsFile } 