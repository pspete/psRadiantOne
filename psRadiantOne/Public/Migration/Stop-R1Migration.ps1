# .ExternalHelp psRadiantOne-help.xml
function Stop-R1Migration {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType('psRadiantOne.OperationStatus')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/cancel'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Cancel Migration Operation')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.OperationStatus

			}

		}

	}#process

	End { }#end

}
