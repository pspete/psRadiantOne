# .ExternalHelp psRadiantOne-help.xml
function Remove-R1NamingContextMergedBackend {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$radiantoneNamespaceDn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dataSource,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$remoteBaseDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/ldap_proxy/backend/merged_backends/delete"

		$Body = [ordered]@{
			radiantoneNamespaceDn = $radiantoneNamespaceDn
			dataSource            = $dataSource
			remoteBaseDn          = $remoteBaseDn
		} | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, "Remove Merged Backend '$radiantoneNamespaceDn'")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
