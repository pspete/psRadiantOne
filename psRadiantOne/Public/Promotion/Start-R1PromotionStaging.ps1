# .ExternalHelp psRadiantOne-help.xml
function Start-R1PromotionStaging {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/export/auto/stage'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Stage Resources For Export')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
