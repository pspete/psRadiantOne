# .ExternalHelp psRadiantOne-help.xml
function Get-R1AciLocation {
	[CmdletBinding()]
	[OutputType('System.String')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'access_control/acis/locations'

		Invoke-R1RestMethod -Uri $URI -Method GET

	}#process

	End { }#end

}
