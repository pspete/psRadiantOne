# .ExternalHelp psRadiantOne-help.xml
function Export-R1MigrationData {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.OperationStatus')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/export'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Start Migration Export')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.OperationStatus

			}

		}

	}#process

	End { }#end

}
