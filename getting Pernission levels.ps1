Connect-PnPOnline -Url "https://atos90.sharepoint.com" -UseWebLogin
$sites = Get-PnPTenantSite | where {$_.Url -like "*atos90.sharepoint.com/sites/*" -or $_.Url -like "*atos90.sharepoint.com/teams/*"}
foreach($site in $sites) {
	Connect-PnPOnline -Url $site.Url -UseWebLogin
	$ctx = Get-PnPContext
	$roleDefs = (Get-PnPWeb).RoleDefinitions
	$ctx.Load($roleDefs)
	$ctx.ExecuteQuery()
	foreach($rd in $roleDefs) {
		Add-Content ".\permissionlevels.csv" "$($site.url), $($rd.Name)"
	}
}