# .ExternalHelp psRadiantOne-help.xml
function Clear-R1Migration {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType('psRadiantOne.OperationStatus')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'migration/clear'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Clear Migration Operation')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.OperationStatus

			}

		}

	}#process

	End { }#end

}
