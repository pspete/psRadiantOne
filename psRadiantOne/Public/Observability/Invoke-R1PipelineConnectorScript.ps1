# .ExternalHelp psRadiantOne-help.xml
function Invoke-R1PipelineConnectorScript {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType('System.Object')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$pipelineId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('CONFIGURE', 'DECONFIGURE')]
		[string]$operation
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "identity_observability/$($pipelineId | Get-EscapedString)/connector_scripts"

		$Body = $PSBoundParameters | Get-Parameter -ParametersToRemove pipelineId | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($pipelineId, "Execute Connector Scripts ($operation)")) {

			Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
