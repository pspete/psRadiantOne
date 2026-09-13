# .ExternalHelp psRadiantOne-help.xml
function Get-R1MigrationStatus {
	[CmdletBinding()]
	[OutputType('psRadiantOne.OperationStatus')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/status'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.OperationStatus

		}

	}#process

	End { }#end

}
