Connect-PnPOnline -Url "https://atos93.sharepoint.com/sites/pk" -UseWebLogin
Add-PnPClientSideWebPart -Page "Demo News" -DefaultWebPartType QuickLinks -WebPartProperties $jsonProps -Section 1 -Column 1 -Order 1
Add-PnPClientSideWebPart -Page "Demo News" -DefaultWebPartType Image -WebPartProperties @{imageSource="https://atos93.sharepoint.com/sites/pk/Shared%20Documents/download(2).jpg"}

Get-PnPClientSideComponent -Page "Demo News"
#Set-PnPClientSideWebPart -Page "News" -Identity "ee304f09-289d-4439-95df-6d798a372657" -PropertiesJson $jsonString
Set-PnPClientSideWebPart -Page "Demo News" 

Export-PnPClientSidePage -Identity "Demo News.aspx" -Out "page_template.xml"Connect-PnPOnline -Url "https://atos90.sharepoint.com/sites/PowerAppsSharePoint/" -UseWebLogin
