try {  
    $srcUrl = Read-Host "https://atos90.sharepoint.com/sites/PowerAppsSharePoint/"
    $destUrl = Read-Host "https://atos90.sharepoint.com/sites/PSTeam/" 
    $pageName = Read-Host "PowerPointSHarepoint Page"  
    $cred = Get-Credential  
    Connect-PnPOnline -Url $srcUrl -UseWebLogin 
    $tempFile = [System.IO.Path]::GetTempFileName();  
    Export-PnPClientSidePage -Force -Identity $pageName -Out $tempFile  
    Connect-PnPOnline -Url $destUrl -UseWebLogin 
    Apply-PnPProvisioningTemplate -Path $tempFile  
    Write-Host "ModernPage is successfully copied."  
    sleep 10  
} catch {  
    Write-Host -ForegroundColor Red 'Error ', ':'  
    $Error[0].ToString();  
    sleep 10  
}  