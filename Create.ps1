Install-Module -Name PnP.PowerShell

$SiteURL = "https://atos93.sharepoint.com/sites/pk"

#$ListName = "test"

#Get Credentials to connect
$Cred = Get-Credential

Connect-PnPOnline -Url $SiteURL -UseWebLogin
Get-PnPList
function Create-Mylib([string] $listName,[string] $listURL){
    if($listURL -eq ""){
        $listURL=$listName.Replace(" ","").ToLower()
       }

    New-PnPList -Title $listName -Url $listURL -Template Announcements
    Write-Host ("List" + $listName+ "has been created") -ForegroundColor Green
}
New-PnPList -Title $listName -Template DocumentLibrary -EnableVersioning -OnQuickLaunch

Create-Mylib -listName "Hello world3" 
Get-PnPList
function Remove-Mylib($listName){
    Remove-PnPList $listName -Force
    Write-Host ("List" + $listName+ "has been deleted") -ForegroundColor Green
}
Remove-Mylib -listName "Hello world2"

for($i=1;$i -lt 3;$i++){
    Create-Mylib -listName ("Hello world"+$i)
}

for($i=1;$i -lt 3;$i++){
    Remove-Mylib -listName ("Hello world"+$i) -Force

}

$Departments = 'HR','Marketing','IT','Sales','Engineering'
foreach($deps in $Departments){
    Create-Mylib -listName $deps
}

Get-PnPField -List "test" 
Add-PnPListItem -List "test" -Values @{"Title" = "Test Title"; "Name" = "Raj"}

Remove-PnPListItem -List "test" -Identity "4" -Force -Recycle

New-PnPList -Title "Helloworld" -Template GenericList 
Add-PnpListItem -List "Helloworld" -Values @{"Title" = "Test2" ; "SPSDep"="SharePoint"}
Add-PnPField -List "Helloworld" -DisplayName "Dep" -InternalName "SPSDep" -Type Choice -Group "Demo Group" -AddToDefaultView -Choices "SharePoint","Power Apps","Power Automate"
Get-PnPField -List/ "Helloworld"