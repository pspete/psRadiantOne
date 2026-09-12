# .ExternalHelp psRadiantOne-help.xml
function Reset-R1PipelineConnector {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
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

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "identity_observability/$($pipelineId | Get-EscapedString)/connector_reset"

		if ($PSCmdlet.ShouldProcess($pipelineId, 'Reset Pipeline Connector Cursor')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
