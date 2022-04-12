#Function to Copy All libraries from One Site to another
Function Copy-PnPAllLibraries
{
    param (
    [parameter(Mandatory=$true, ValueFromPipeline=$true)][string]$SourceSiteURL,
    [parameter(Mandatory=$true, ValueFromPipeline=$true)][string]$DestinationSiteURL
    )
  
    Try {
    #Connect to the Source Site and Get the List Templates
    $SourceConn = Connect-PnPOnline -URL $SourceSiteURL -UseWebLogin -ReturnConnection
    $SourceCtx = $SourceConn.Context
    $SourceRootWeb = $SourceCtx.Site.RootWeb
    $SourceListTemplates = $SourceCtx.Site.GetCustomListTemplates($SourceRootWeb)
    $SourceCtx.Load($SourceRootWeb)
    $SourceCtx.Load($SourceListTemplates)
    $SourceCtx.ExecuteQuery()
  
    #Connect to the Destination Site and Get the List Templates
    $DestinationConn = Connect-PnPOnline -URL $DestinationSiteURL -UseWebLogin -ReturnConnection
    $DestinationCtx = $DestinationConn.Context
    $DestinationRootWeb = $DestinationCtx.Site.RootWeb
    $DestinationListTemplates = $DestinationCtx.Site.GetCustomListTemplates($DestinationRootWeb)
    $DestinationCtx.Load($DestinationRootWeb)
    $DestinationCtx.Load($DestinationListTemplates)
    $DestinationCtx.ExecuteQuery()
  
    #Exclude certain libraries
    $ExcludedLibraries =  @("Style Library","Preservation Hold Library", "Site Pages", "Site Assets","Form Templates", "Site Collection Images","Site Collection Documents")
      
    #Get Libraries from Source site - Skip hidden and certain libraries
    $SourceLibraries =  Get-PnPList -Includes RootFolder -Connection $SourceConn | Where {$_.BaseType -eq "DocumentLibrary" -and $_.Hidden -eq $False -and $_.Title -notin $ExcludedLibraries}
  
    #Iterate through each library in the source
    ForEach($SourceLibrary in $SourceLibraries)
    {
        Write-host "Copying library:"$SourceLibrary.Title -f Green
  
        #Remove the List template if exists
        $SourceListTemplate = $SourceListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
        $SourceListTemplateURL = $SourceRootWeb.ServerRelativeUrl+"/_catalogs/lt/"+$SourceLibrary.id.Guid+".stp"
        If($SourceListTemplate)
        {
            Remove-PnPFile -ServerRelativeUrl $SourceListTemplateURL -Recycle -Force -Connection $SourceConn
        }
        Write-host "Creating List Template from Source Library..." -f Yellow -NoNewline
        $SourceLibrary.SaveAsTemplate($SourceLibrary.id.Guid, $SourceLibrary.id.Guid, [string]::Empty, $False)
        $SourceCtx.ExecuteQuery()
        Write-host "Done!" -f Green
  
        #Reload List Templates to Get Newly created List Template
        $SourceListTemplates = $SourceCtx.Site.GetCustomListTemplates($SourceRootWeb)
        $SourceCtx.Load($SourceListTemplates)
        $SourceCtx.ExecuteQuery()
        $SourceListTemplate = $SourceListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
  
        #Remove the List template if exists in destination
        $DestinationListTemplate = $DestinationListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
        $DestinationListTemplateURL = $DestinationRootWeb.ServerRelativeUrl+"/_catalogs/lt/"+$SourceLibrary.id.Guid+".stp"
        If($DestinationListTemplate)
        {
            Remove-PnPFile -ServerRelativeUrl $DestinationListTemplateURL -Recycle -Force -Connection $DestinationConn
        }
  
        #Copy List Template from source to the destination site
        Write-host "Copying List Template from Source to Destination Site..." -f Yellow -NoNewline
        Copy-PnPFile -SourceUrl $SourceListTemplateURL -TargetUrl $DestinationListTemplateURL -SkipSourceFolderName -Force -OverwriteIfAlreadyExists
        Write-host "Done!" -f Green
  
        #Reload List Templates to Get Newly created List Template
        $DestinationListTemplates = $DestinationCtx.Site.GetCustomListTemplates($DestinationRootWeb)
        $DestinationCtx.Load($DestinationListTemplates)
        $DestinationCtx.ExecuteQuery()
        $DestinationListTemplate = $DestinationListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
  
        #Create the destination library from the list template
        Write-host "Creating New Library in the Destination Site..." -f Yellow -NoNewline
        If(!(Get-PnPList -Identity $SourceLibrary.Title -Connection $DestinationConn))
        {
            #Create the destination library
            $ListCreation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
            $ListCreation.Title = $SourceLibrary.Title
            $ListCreation.ListTemplate = $DestinationListTemplate
            $DestinationList = $DestinationCtx.Web.Lists.Add($ListCreation)
            $DestinationCtx.ExecuteQuery()
            Write-host "Library '$($SourceLibrary.Title)' created successfully!" -f Green
        }
        Else
        {
            Write-host "Library '$($SourceLibrary.Title)' already exists!" -f Yellow
        }
      
        #Copy content from Source to destination library
        $SourceLibraryURL = $SourceLibrary.RootFolder.ServerRelativeUrl
        $DestinationLibrary = Get-PnPList $SourceLibrary.Title -Includes RootFolder -Connection $DestinationConn
        $DestinationLibraryURL = $DestinationLibrary.RootFolder.ServerRelativeUrl
        Write-host "`Copying Content from $SourceLibraryURL to $DestinationLibraryURL..." -f Yellow -NoNewline
  
        #Copy All Content from Source Library to the Destination Library
        Copy-PnPFile -SourceUrl $SourceLibraryURL -TargetUrl $DestinationLibraryURL -SkipSourceFolderName -Force -OverwriteIfAlreadyExists
        Write-host "`tContent Copied Successfully!" -f Green
  
        #Cleanup List Templates in source and destination sites
        Remove-PnPFile -ServerRelativeUrl $SourceListTemplateURL -Recycle -Force -Connection $SourceConn
        Remove-PnPFile -ServerRelativeUrl $DestinationListTemplateURL -Recycle -Force -Connection $DestinationConn
        }
    }
    Catch {
        write-host -f Red "Error:" $_.Exception.Message
    }
}
  
#Parameters
$SourceSiteURL = "https://atos90.sharepoint.com/sites/PowerAppsSharePoint"
$DestinationSiteURL = "https://atos90.sharepoint.com/sites/PSInfoModernTeamWithoutGroup"

  
#Call the function to copy libraries to another site
Copy-PnPAllLibraries -SourceSiteURL $SourceSiteURL -DestinationSiteURL $DestinationSiteURL
 