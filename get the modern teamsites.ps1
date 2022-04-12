Connect-PnPOnline -Url "https://atos90.sharepoint.com/" -UseWebLogin

Get-PnPTenantSite -Template GROUP#0
Write-Host "Retrieved all Modern Team Sites."