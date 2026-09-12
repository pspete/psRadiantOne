# .ExternalHelp psRadiantOne-help.xml
function Get-R1DashboardLink {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DashboardLink')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'dashboard/links'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DashboardLink

		}

	}#process

	End { }#end

}
