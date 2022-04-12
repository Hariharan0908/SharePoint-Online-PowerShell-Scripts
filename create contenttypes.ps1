#Config Variables
$SiteURL = "https://atos93.sharepoint.com/sites/pk"
$ContentTypeName ="UPS O365 Migration"
$ContentTypeDescription ="Base Content Type for UPS Template"
$ContentTypeGroupName = "UPS Content Types"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -UseWebLogin
 
#Create Content Type
Add-PnPContentType -Name $ContentTypeName -Description $ContentTypeDescription -Group $ContentTypeGroupName