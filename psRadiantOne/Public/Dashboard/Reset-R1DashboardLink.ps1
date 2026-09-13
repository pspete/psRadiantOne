# .ExternalHelp psRadiantOne-help.xml
function Reset-R1DashboardLink {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.DashboardLink')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'dashboard/links/restore_defaults'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Restore Default Dashboard Links')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method PUT

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.DashboardLink

			}

		}

	}#process

	End { }#end

}
