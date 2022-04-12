
param(
    [Parameter(Mandatory=$true,HelpMessage="This is the name of the O365 tenant",Position=1)] 
    [string]$TenantName,    
    [Parameter(Mandatory=$true,HelpMessage="This is the O365 Admin account to log into the tenant",Position=2)] 
    [string]$AdminAcct,
    [Parameter(Mandatory=$true,HelpMessage="This is the account to ADD on each ODFB",Position=3)] 
    [string]$SecondAdmin,
    [Parameter(Mandatory=$true,HelpMessage="This is the CSV file containing the ODFB Urls",Position=4)] 
    [string]$ODFBCsvFile    
)
# URL for your organization's SPO admin service
$AdminURI = "https://atos93.sharepoint.com"

#Import Urls
$UrlLocation = Import-Csv $ODFBCsvFile

#Connect to SPO
Connect-PnPOnline -Url $AdminURI -UseWebLogin
Write-Host "Connected to SharePoint Online" -f Green

foreach($Url in $UrlLocation){
    $CorrectSitePath = ($Url.OneDriveUrl).trimend("/")
    Set-SPOUser -Site $CorrectSitePath -LoginName $SecondAdmin -IsSiteCollectionAdmin $true 
}

Write-Host "Account $SecondAdmin added." -f Green