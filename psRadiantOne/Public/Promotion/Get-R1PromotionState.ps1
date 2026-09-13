# .ExternalHelp psRadiantOne-help.xml
function Get-R1PromotionState {
	[CmdletBinding()]
	[OutputType('psRadiantOne.PromotionState')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/state/auto'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.PromotionState

		}

	}#process

	End { }#end

}
