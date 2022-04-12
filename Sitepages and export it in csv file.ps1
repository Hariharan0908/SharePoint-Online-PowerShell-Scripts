Install-Module -Name PnP.PowerShell
$SiteURL="https://atos90.sharepoint.com/sites/PowerAppsSharePoint"
$CSVFiles="E:\CSV FILES\mycsvfile.csv"
Connect-PnPOnline -Url $SiteURL -UseWebLogin
$SitePages = Get-PnPListItem -List "Site Pages"

 
$PagesDataColl = @()
#Collect Site Pages data
ForEach($Page in $SitePages)
{
    $Data = New-Object PSObject -Property ([Ordered] @{
        PageName  = $Page.FieldValues.Title
        RelativeURL = $Page.FieldValues.FileRef     
        CreatedOn = $Page.FieldValues.Created_x0020_Date
        ModifiedOn = $Page.FieldValues.Last_x0020_Modified
        Editor =  $Page.FieldValues.Editor.Email
        ID = $Page.ID
    })
    $PagesDataColl += $Data
}
 
$PagesDataColl
$PagesDataColl | Export-Csv -Path $CSVFiles -NoTypeInformation