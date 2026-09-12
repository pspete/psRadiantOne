# .ExternalHelp psRadiantOne-help.xml
function Get-R1GlobalInterceptionSetting {
	[CmdletBinding()]
	[OutputType('psRadiantOne.GlobalInterceptionSettings')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'global_interception_settings'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.GlobalInterceptionSettings

		}

	}#process

	End { }#end

}
