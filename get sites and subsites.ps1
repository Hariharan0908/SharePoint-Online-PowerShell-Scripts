Connect-PnPOnline -Url "https://atos90.sharepoint.com" -UseWebLogin
$results = @()
$allMySites = Get-PnPTenantSite

foreach ($SC in $allMySites) {
    Write-Host "Connecting to $($SC.Url)" -ForegroundColor Green
    try {
        Connect-PnPOnline -Url $SC.Url -UseWebLogin
    
        $SiteColTitle = $SC.Title
        $SiteColUrl = $SC.Url
        $Subsites = Get-PnPSubWebs
    
        $Properties = @{
            SiteColName = $SiteColTitle
            SiteColUrl  = $SiteColUrl
            SubsiteName = ($Subsites.Title | Out-String).Trim()
            SubsiteUrl  = ($Subsites.ServerRelativeUrl | Out-String).Trim()
        }
        $results += New-Object psobject -Property $Properties
    }
    catch {
        Write-Host "You don't have access to this Site Collection." -ForegroundColor Red
    }
}
$results | Select-Object SiteColName, SiteColUrl, SubsiteName, SubsiteUrl | Export-Csv -Path "E:\CSV FILES\SPOEmptyFolders.csv" -NoTypeInformation