# .ExternalHelp psRadiantOne-help.xml
function Get-R1PromotionStagedResource {
	[CmdletBinding()]
	[OutputType('psRadiantOne.StagedResources')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/export/auto/stage'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.StagedResources

		}

	}#process

	End { }#end

}
