Install-Module -Name PnP.PowerShell
#$userName = "hariharant@atos93.onmicrosoft.com"
#$passWord = "**********"
#$encPassWord = convertto-securestring -String $passWord -AsPlainText -Force
#$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $userName, $encPassWord
Connect-PnPOnline -Url "https://atos93.sharepoint.com/pk" -UseWebLogin

New-PnPTenantSite `
  -Title " Modern Team Without Group" `
  -Url "https://atos93.sharepoint.com/sites/HHInfoModernTeamWithoutGroup" `
  -Description "Modern Site" `
  -Owner "hariharant@atos93.onmicrosoft.com" `
  -Lcid 1033 `
  -Template "STS#3" `
  -TimeZone 10 `
  -Wait
Write-Host "The modern team site without Office 365 Group has been created successfully."