# .ExternalHelp psRadiantOne-help.xml
function Get-R1SpecialGroup {
	[CmdletBinding()]
	[OutputType('psRadiantOne.SpecialGroups')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'special_groups'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.SpecialGroups

		}

	}#process

	End { }#end

}
