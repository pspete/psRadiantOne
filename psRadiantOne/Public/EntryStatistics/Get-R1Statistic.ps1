# .ExternalHelp psRadiantOne-help.xml
function Get-R1Statistic {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Statistics')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'statistics'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Statistics

		}

	}#process

	End { }#end

}
