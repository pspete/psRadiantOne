# .ExternalHelp psRadiantOne-help.xml
function Get-R1MigrationPlan {
	[CmdletBinding()]
	[OutputType('psRadiantOne.MigrationPlan')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/plan'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.MigrationPlan

		}

	}#process

	End { }#end

}
