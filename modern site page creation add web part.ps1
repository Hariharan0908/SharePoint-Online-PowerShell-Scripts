Install-Module -Name SharePointPnPPowerShellOnline
$cred = Get-Credential  
Connect-PnPOnline -Url https://atos90.sharepoint.com/sites/PowerAppsSharePoint -Credential $cred  
Add-PnPClientSidePage  -Name “PowerPointSHarepoint Page”  
Add-PnPClientSidePage  -Name “Home Page” -LayoutType Home  
$page=Get-PnPClientSidePage -Identity "Home Page.aspx"

Add-PnPClientSideText -Page $page -Text "Welcomes To SharePoint" 
Add-PnPClientSideWebPart -Page $page -DefaultWebPartType “List” -WebPartProperties @{selectedListId="609f95e4-7022-417d-a57f-693673f7eff9"} 
$webParts = $page.Controls  
#if there are more than one webparts  
foreach($webpart in $webparts) {  
    Write - Host "WebPart Id "  
    $webpart.InstanceId  
    Write - Host "Title "  
    $webpart.Title  
}  