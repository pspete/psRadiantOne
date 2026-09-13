# .ExternalHelp psRadiantOne-help.xml
function Get-R1MigrationLog {
	[CmdletBinding()]
	[OutputType('psRadiantOne.MigrationLog')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/log'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.MigrationLog

		}

	}#process

	End { }#end

}
