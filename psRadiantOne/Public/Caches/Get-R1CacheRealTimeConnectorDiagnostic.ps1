# .ExternalHelp psRadiantOne-help.xml
function Get-R1CacheRealTimeConnectorDiagnostic {
	[CmdletBinding()]
	[OutputType('psRadiantOne.CacheRealTimeConnectorDiagnostic')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/refresh/real_time_connectors/diagnostics"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.CacheRealTimeConnectorDiagnostic

		}

	}#process

	End { }#end

}
