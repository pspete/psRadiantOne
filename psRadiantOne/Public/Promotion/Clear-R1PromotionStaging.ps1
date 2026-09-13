# .ExternalHelp psRadiantOne-help.xml
function Clear-R1PromotionStaging {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/export/auto/stage'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Unstage Resources For Export')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
