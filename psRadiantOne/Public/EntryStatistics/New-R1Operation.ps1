# .ExternalHelp psRadiantOne-help.xml
function New-R1Operation {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.RefreshOperation')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'operations'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Start Entry Statistics Refresh')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.RefreshOperation

			}

		}

	}#process

	End { }#end

}
