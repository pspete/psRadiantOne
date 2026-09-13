# .ExternalHelp psRadiantOne-help.xml
function Get-R1PromotionSetting {
	[CmdletBinding()]
	[OutputType('psRadiantOne.PromotionSettings')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/settings'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.PromotionSettings

		}

	}#process

	End { }#end

}
