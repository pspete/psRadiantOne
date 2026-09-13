# .ExternalHelp psRadiantOne-help.xml
function Get-R1JdbcDriverFile {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DriverFileClassName')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'jdbc_drivers/files'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DriverFileClassName

		}

	}#process

	End { }#end

}
