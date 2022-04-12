$Siteurl="https://atos93.sharepoint.com/sites/pk"
Connect-PnPOnline -Url $Siteurl -UseWebLogin
$CSV = import-csv -Path "E:\Book1.csv"

# set the path to my SharePoint sites Site Pages folder
$sitePath = '/sites/SiteName/SitePages/'

# load the page template we created earlier
$template = Get-PnPClientSidePage -Identity "News"

# loop over all the rows in the CSV file
foreach ($row in $CSV) {

   # set the full file name from the FileTitle in the CSV and add .aspx
   $fullFileName = $row.FileName + '.aspx'

   # create a variable for the full path to the file
   $fileURL = $sitePath + $fullFileName

   # save a new SharePoint Page based on the Page Template we loaded earlier
   $template.Save($fullFileName)

   # run Set-PnPClientSidePage using the identity of the file we just saved to set the title and
   # publish the page which is required before creating a navigation node
   Set-PnPClientSidePage -Identity $fullFileName -Title $row.PageTitle -Publish

   # add the page to the QuickLaunch navigation which is at the top of Communication sites
   $nav = Add-PnPNavigationNode -Title $row.NavTitle -Url $fileURL -Location "QuickLaunch"
}