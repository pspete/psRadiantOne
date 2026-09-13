# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSourcePlugin {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DataSourcePlugin')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'meta/plugins'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DataSourcePlugin

		}

	}#process

	End { }#end

}
