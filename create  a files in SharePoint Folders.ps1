$Files = Get-childItem "F:\New folder (3)"
foreach($File in $Files){
    #$File=$Files[0]
    Add-PnPFile -Folder "Shared Documents" -Path $File.FullName
}
Get-PnPFolder -Url "/sites/demo/Shared Documents"
Get-PnPFolder -url "Shared Documents"