Connect-PnPOnline -Url "https://atos90.sharepoint.com/sites/PowerAppsSharePoint/" -UseWebLogin
$textWebpart = Get-PnPClientSideComponent -Page "Article Page" -InstanceId 5983608d-ebb6-4fa7-8665-7e113f8a9f06
#$textWebpart.Text | clip
$htmlToInject = '
<div class="canvasRteResponsiveTable">
<div class="tableWrapper">
<table title="Table">
	<tbody>
		<tr>
			<td>Name</td>
			<td>Dept</td>
			<td>City</td>
		</tr>
		<tr>
			<td>Hari</td>
			<td>SharePoint</td>
			<td><img src="https://atos90.sharepoint.com/sites/PowerAppsSharePoint/Shared%20Documents/download.png" ></td>
		</tr>
		<tr>
			<td>Sai</td>
			<td>Power Platform</td>
			<td><img src="https://atos90.sharepoint.com/sites/PowerAppsSharePoint/Shared%20Documents/download.png" ></td>
		</tr>
	</tbody>
</table>
</div>
</div>
'
Set-PnPClientSideText -Page "Article Page" -InstanceId 5983608d-ebb6-4fa7-8665-7e113f8a9f06 -Text $htmlToInject

Get-PnPClientSidePage -Identity "Article Page"