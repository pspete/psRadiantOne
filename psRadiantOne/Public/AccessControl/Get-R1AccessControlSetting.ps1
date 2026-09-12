# .ExternalHelp psRadiantOne-help.xml
function Get-R1AccessControlSetting {
	[CmdletBinding()]
	[OutputType('psRadiantOne.AccessControlSetting')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'access_control'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.AccessControlSetting

		}

	}#process

	End { }#end

}
