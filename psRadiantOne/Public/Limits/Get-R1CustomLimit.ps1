# .ExternalHelp psRadiantOne-help.xml
function Get-R1CustomLimit {
	[CmdletBinding()]
	[OutputType('psRadiantOne.CustomLimit')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'limits/custom'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.CustomLimit

		}

	}#process

	End { }#end

}
