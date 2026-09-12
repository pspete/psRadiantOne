# .ExternalHelp psRadiantOne-help.xml
function Get-R1ControlPanelConfiguration {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ControlPanelConfiguration')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'control_panel_configuration'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ControlPanelConfiguration

		}

	}#process

	End { }#end

}
