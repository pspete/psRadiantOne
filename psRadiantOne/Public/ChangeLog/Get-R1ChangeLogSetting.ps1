# .ExternalHelp psRadiantOne-help.xml
function Get-R1ChangeLogSetting {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ChangeLogSettings')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'change_log/settings'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ChangeLogSettings

		}

	}#process

	End { }#end

}
