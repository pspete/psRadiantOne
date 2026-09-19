# .ExternalHelp psRadiantOne-help.xml
function Get-R1CacheRealTimeConnectorType {
	[CmdletBinding()]
	[OutputType('psRadiantOne.CacheRealTimeConnectorType')]
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
		[string]$connectorId
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/refresh/real_time_connectors/$($connectorId | Get-EscapedString)/types"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.CacheRealTimeConnectorType

		}

	}#process

	End { }#end

}
