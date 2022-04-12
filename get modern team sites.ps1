Connect-PnPOnline -Url "https://atos87.sharepoint.com/" -Credentials $cred

Get-PnPTenantSite -Template GROUP#0
Write-Host "Retrieved all Modern Team Sites.