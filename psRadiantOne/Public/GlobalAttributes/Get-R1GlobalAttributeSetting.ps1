# .ExternalHelp psRadiantOne-help.xml
function Get-R1GlobalAttributeSetting {
	[CmdletBinding()]
	[OutputType('psRadiantOne.GlobalAttributes')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'global_attributes/settings'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.GlobalAttributes

		}

	}#process

	End { }#end

}
