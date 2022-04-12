Install-Module -Name PnP.PowerShell
#$userName = "preeti@tenant.onmicrosoft.com"
#$passWord = "**********"
#$encPassWord = convertto-securestring -String $passWord -AsPlainText -Force
#$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $userName, $encPassWord
Connect-PnPOnline -Url "https://atos90.sharepoint.com/" -UseWebLogin

New-PnPTenantSite `
  -Title "PS Modern Team Without Group" `
  -Url "https://atos90.sharepoint.com/sites/PSInfoModernTeamWithoutGroup" `
  -Description "Modern Site" `
  -Owner "hariharant@atos90.onmicrosoft.com" `
  -Lcid 1033 `
  -Template "STS#3" `
  -TimeZone 10 `
  -Wait
Write-Host "The modern team site without Office 365 Group has been created successfully."