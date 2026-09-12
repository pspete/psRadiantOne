# .ExternalHelp psRadiantOne-help.xml
function Get-R1AccessRegulationLimit {
	[CmdletBinding()]
	[OutputType('psRadiantOne.AccessRegulationLimits')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'limits/access_regulation'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.AccessRegulationLimits

		}

	}#process

	End { }#end

}
