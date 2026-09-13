# .ExternalHelp psRadiantOne-help.xml
function New-R1MigrationPlan {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.OperationStatus')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/plan'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Start Migration Plan')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.OperationStatus

			}

		}

	}#process

	End { }#end

}
