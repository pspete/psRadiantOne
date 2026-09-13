# .ExternalHelp psRadiantOne-help.xml
function Import-R1Configuration {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$apply
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/import/auto'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		$Action = if ($apply) { 'Import Configuration' } else { 'Import Configuration (dry run)' }

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, $Action)) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
