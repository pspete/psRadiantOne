# .ExternalHelp psRadiantOne-help.xml
function Get-R1MigrationExport {
	[CmdletBinding()]
	[OutputType('psRadiantOne.MigrationData')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/export'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.MigrationData

		}

	}#process

	End { }#end

}
