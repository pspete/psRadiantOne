# .ExternalHelp psRadiantOne-help.xml
function Export-R1CacheRealTimeConnectorScript {
	[CmdletBinding()]
	[OutputType('System.IO.FileInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$connectorId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateSet('CONFIGURE', 'DECONFIGURE')]
		[string]$action,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ action = $action } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/refresh/real_time_connectors/$($connectorId | Get-EscapedString)/scripts/download`?$Query"

		$Download = @{
			Uri         = $URI
			Method      = 'GET'
			DefaultName = "$connectorId-$($action.ToLower()).zip"
		}

		if ($PSBoundParameters.ContainsKey('Path')) {

			$Download['Path'] = $Path

		}

		Save-R1Download @Download

	}#process

	End { }#end

}
