# .ExternalHelp psRadiantOne-help.xml
function Get-R1LoginPageInfo {
	[CmdletBinding()]
	[OutputType('System.Object')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path ''

		Invoke-R1RestMethod -Uri $URI -Method GET

	}#process

	End { }#end

}
