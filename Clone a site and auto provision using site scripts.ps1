#Install-Module -Name PnP.PowerShell
$SiteURL="https://atos93.sharepoint.com/sites/pk"
$relativesiteURl="/Lists/Issue tracker","/Lists/Helloworld"
Connect-PnPOnline -Url $SiteURL -UseWebLogin
$export=Get-PnPSiteScriptFromWeb -Url $SiteURL -IncludeBranding -IncludeLinksToExportedItems  -Lists $relativesiteURl
Add-PnPSiteScript -Title "USTeams" -Description " This is a copy of a site collection." -Content $export
Add-PnPSiteDesign -Title "USTeams " -WebTemplate "64" -SiteScriptIds "cf2709f2-7f35-47d3-bdb4-86a0d0d253a8 " -Description "Applying Team Site"

