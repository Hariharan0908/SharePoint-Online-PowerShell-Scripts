$url="https://atos93.sharepoint.com/sites/USTeams"
Connect-PnPOnline -Url $url -UseWebLogin  
$newFile = Add-PnPFile -Path "E:\Files.docx" -Folder "/SPDocuments/Folder4" -Publish -PublishComment "Published1"  
Write-Host "Title : " $newFile.Name  
Write-Host "URL   : " $newFile.ServerRelativeUrl 
$files = Find-PnPFile -Match *.docx  
foreach($file in $files){  
    Write-Host "Title : " $file.Name  
    Write-Host "URL   : " $file.ServerRelativeUrl  
    Write-Host "-----------------------------------"          
}  
Get-PnPFile -ServerRelativeUrl /SPDocuments/Folder4/Files.docx -Path E:\ -FileName SharePointFile.docx  

Set-PnPFileCheckedOut -Url "/SPDocuments/Folder4/Files.docx"  
Set-PnPFileCheckedIn -Url "/SPDocuments/Folder4/Files.docx" -CheckinType MajorCheckIn -Comment "Check"   
