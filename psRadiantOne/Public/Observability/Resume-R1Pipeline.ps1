# .ExternalHelp psRadiantOne-help.xml
function Resume-R1Pipeline {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
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

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "identity_observability/$($pipelineId | Get-EscapedString)/resume"

		if ($PSCmdlet.ShouldProcess($pipelineId, 'Resume Pipeline')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
