# .ExternalHelp psRadiantOne-help.xml
function Test-R1CallerPrivilege {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'access_tokens/caller_privileged'

		Invoke-R1RestMethod -Uri $URI -Method GET

	}#process

	End { }#end

}
