$imgPath =  "Downloads\download.png";
$pathImg = ""
$librarytitle = "Design Package";
$libraryurl = "Designpackage"

#Connect SharePoint Online site
Connect-PnPOnline -Url "https://atos90.sharepoint.com/sites/PowerAppsSharePoint" -UseWebLogin

#Create library to maintain all design packages
New-PnPList -Title $librarytitle -Template DocumentLibrary  -Url $libraryurl -ErrorAction SilentlyContinue

#Create folder inside library to maintain all images
Add-PnPFolder -Name imagess -Folder $libraryurl

#Upload logo file under folder
Add-PnPFile -Path $imgPath -Folder $libraryurl/imagess -ErrorAction Stop
Write-Host "Uploaded Logo file to : "$libraryurl

#Split file name from path
$imgName = $imgPath | Split-Path -Leaf

#get uploaded file path
$pathImg = (Get-PnPListItem -List $libraryurl -Fields FileRef).FieldValues | Where-Object {$_.FileRef -match $imgName}

#Update site collection logo
Set-PnPWeb -SiteLogoUrl $pathImg.FileRef

Write-Host "Updated Logo of: "$currentsite

#Get all subistes under site collection and update logo of all subsites
$subsites = Get-PnPSubWebs -Recurse
foreach ($site in $subsites){
   Connect-PnPOnline -Url $site.url -UseWebLogin
   Set-PnPWeb -SiteLogoUrl $pathImg.FileRef
   Write-Host "Updated Logo of: "$site.url
}