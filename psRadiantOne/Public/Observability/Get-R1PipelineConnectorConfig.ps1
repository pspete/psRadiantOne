# .ExternalHelp psRadiantOne-help.xml
function Get-R1PipelineConnectorConfig {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ConnectorConfig')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$pipelineId
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "identity_observability/$($pipelineId | Get-EscapedString)/connector_config"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ConnectorConfig

		}

	}#process

	End { }#end

}
