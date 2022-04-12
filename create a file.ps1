$Files = Get-childItem "F:\New folder (3)"
foreach($File in $Files){
    #$File=$Files[0]
    Add-PnPFile -Folder "Shared%20Documents" -Path $File.FullName
}
#Get-PnPFolder -Url "https://atos93.sharepoint.com/sites/pk/Shared%20Documents"
Get-PnPFolder -url "Shared Documents"