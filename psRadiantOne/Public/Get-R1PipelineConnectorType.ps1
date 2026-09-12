# .ExternalHelp psRadiantOne-help.xml
function Get-R1PipelineConnectorType {
	[CmdletBinding()]
	[OutputType('System.Object')]
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

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "identity_observability/$($pipelineId | Get-EscapedString)/connector_types"

		Invoke-R1RestMethod -Uri $URI -Method GET

	}#process

	End { }#end

}
