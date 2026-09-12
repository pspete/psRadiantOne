# .ExternalHelp psRadiantOne-help.xml
function Get-R1Dashboard {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DashboardItem')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'dashboard'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DashboardItem

		}

	}#process

	End { }#end

}
