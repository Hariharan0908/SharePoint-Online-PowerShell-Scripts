
#The below script will create a Content Type in SharePoint online using PowerShell and PnP PowerShell which will take site URL, document library name, UserName and Password as paramaters.
#Load SharePoint CSOM Assemblies
#Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
#Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

 
$fileName = "Create_ContentType_Report"
#'yyyyMMddhhmm yyyyMMdd
$enddate = (Get-Date).tostring("yyyyMMddhhmmss")
#$filename = $enddate + '_VMReport.doc'
$logFileName = $fileName +"_"+ $enddate+"_Log.txt"
$invocation = (Get-Variable MyInvocation).Value
Split-Path $invocation.MyCommand.Definition
 
$directoryPathForLog="Split-Path $invocation.MyCommand.Definition "+"\"+"LogFiles"
if(!(Test-Path -path $directoryPathForLog))
{
New-Item -ItemType directory -Path $directoryPathForLog
#Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}
#$logPath = $directoryPath + "\" + $logFileName
 
$logPath = $directoryPathForLog + "\" + $logFileName
 
$isLogFileCreated = $False
 
#DLL location
 
$directoryPathForDLL="Split-Path $invocation.MyCommand.Definition "+"\"+"Dependency Files"
if(!(Test-Path -path $directoryPathForDLL))
{
New-Item -ItemType directory -Path $directoryPathForDLL
#Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}
 
#DLL location
#$clientDLL=$directoryPathForDLL+"\"+"Microsoft.SharePoint.Client.dll"
#$clientDLLRuntime=$directoryPathForDLL+"\"+"Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
 
#Add-Type -Path $clientDLL
#Add-Type -Path $clientDLLRuntime
#File Download location
 
$directoryPathForFileDownloadLocation="Split-Path $invocation.MyCommand.Definition "+"\"+"Downloaded Files"
if(!(Test-Path -path $directoryPathForFileDownloadLocation))
{
New-Item -ItemType directory -Path $directoryPathForFileDownloadLocation
#Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}
 
#File Download location
 
function Write-Log([string]$logMsg)
{
if(!$isLogFileCreated){
Write-Host "Creating Log File..."
if(!(Test-Path -path $directoryPath))
{
Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}
else
{
$script:isLogFileCreated = $True
Write-Host "Log File ($logFileName) Created..."
[string]$logMessage = [System.String]::Format("[$(Get-Date)] - {0}", $logMsg)
Add-Content -Path $logPath -Value $logMessage
}
}
else
{
[string]$logMessage = [System.String]::Format("[$(Get-Date)] - {0}", $logMsg)
Add-Content -Path $logPath -Value $logMessage
}
}
 
#The below function will create a content type in SharePoint Online which will take siteURL, ContentTypeName,ContentTypeyDescription, ParentContentTypeName, ContentTypeGroup,UserName and Password as paramaters.
Function CreateContentTypeInSPO()
{
param
(
[Parameter(Mandatory=$true)] [string] $SPOSiteURL,
[Parameter(Mandatory=$true)] [string] $ContentTypeName,
[Parameter(Mandatory=$false)][string] $ContentTypeyDescription,
[Parameter(Mandatory=$true)] [string] $ContentTypeGroup,
[Parameter(Mandatory=$true)] [string] $ParentContentTypeName,
[Parameter(Mandatory=$true)] [string] $UserName,
[Parameter(Mandatory=$true)] [string] $Password
)
 
Try
{
 
$securePassword= $Password | ConvertTo-SecureString -AsPlainText -Force
#Setting up the Context
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SPOSiteURL)
$ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $securePassword)
#Getting all content types from the site collection
$ContentTypeCollection = $ctx.web.ContentTypes
$ctx.Load($ContentTypeCollection)
$ctx.ExecuteQuery()
 
#Getting the parent content type
$ParentCTypeName = $ContentTypeCollection| Where {$_.Name -eq $ParentContentTypeName}
 
#Check if content type exists already
$ContentTypeToCreate = $ContentTypeCollection| Where {$_.Name -eq $ContentTypeName}
 
#Before creating a content type, check whether the content type exists or not, if not create a new one.
If($ContentTypeToCreate -ne $Null)
{
Write-host "Content type '$ContentTypeName' already exists!" -ForegroundColor Yellow
}
else
{
#List of properties for the new content type.
$ContentTypeCreationInfo=New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
$ContentTypeCreationInfo.Name=$ContentTypeName
$ContentTypeCreationInfo.Description=$ContentTypeyDescription
$ContentTypeCreationInfo.Group=$ContentTypeGroup
$ContentTypeCreationInfo.ParentContentType=$ParentCTypeName
 
#Adding the new content type to the collecction.
$ContentType=$ContentTypeCollection.Add($ContentTypeCreationInfo)
$ctx.ExecuteQuery()
 
Write-host "The content Type '$ContentTypeName' has been created successfully!" -ForegroundColor Green
 
}
}
Catch
{
 
$ErrorMessage = $_.Exception.Message +"in creating Content Type in SPO!:"
Write-Host $ErrorMessage -BackgroundColor Red
Write-Log $ErrorMessage
 
}
 
}
#############Testing the CreateContentTypeInSPO function ############################################################
 
#Parameters value
$siteURL="https://atos93.sharepoint.com/sites/pk"
$ContentTypeNameToCreate="CT Created by PowerShell"
$ContentTypeNameToCreateDescription="This is a test content type"
$ParentCTypeName="Item"
$CTypeGroup="Finance Test Group"
$userName = "hariharant@atos93.onmicrosoft.com"
$passWord = "Nature@0908"