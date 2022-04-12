$Siteurl="https://atos93.sharepoint.com/sites/pk"
Connect-PnPOnline -Url $Siteurl -UseWebLogin
$Page = Add-PnPClientSidePage -Name "Demo News3" -LayoutType Article
 
#Set Page properties
Set-PnPClientSidePage -Identity $Page -Title "News" -CommentsEnabled:$False -HeaderType Default
 
#Add Section to the Page
Add-PnPClientSidePageSection -Page $Page -SectionTemplate OneColumn
 
#Add Text to Page
Add-PnPClientSideText -Page $Page -Text "Welcome To News Portal" -Section 1 -Column 1
 
#Add News web part to the section
Add-PnPClientSideWebPart -Page $Page -DefaultWebPartType News -Section 1 -Column 1
 
#Add List to Page
Add-PnPClientSideWebPart -Page $Page -DefaultWebPartType List -Section 1 -Column 1 -WebPartProperties @{ selectedListId = "7Bfce011d6-0638-49a8-b566-ba7ae6cf74cf%7D"}
 
#Publish the page
$Page.Publish()


#Read more: https://www.sharepointdiary.com/2019/08/create-modern-page-in-sharepoint-online-using-powershell.html#ixzz7PeJXBuVt