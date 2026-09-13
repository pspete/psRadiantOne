# .ExternalHelp psRadiantOne-help.xml
function Export-R1Configuration {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'All')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$force,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Staged'
		)]
		[ValidateNotNull()]
		[object]$stagedResources
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/export/auto'

		$Request = $PSBoundParameters | Get-Parameter

		#mode decides whether everything is exported or only what was staged
		$Request['mode'] = if ($PSCmdlet.ParameterSetName -eq 'Staged') { 'STAGED' } else { 'ALL' }

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, "Export Configuration ($($Request['mode']))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
