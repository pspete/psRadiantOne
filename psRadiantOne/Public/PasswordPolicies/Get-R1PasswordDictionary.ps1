# .ExternalHelp psRadiantOne-help.xml
function Get-R1PasswordDictionary {
	[CmdletBinding()]
	[OutputType('System.String')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'password_policies/dictionary'

		Invoke-R1RestMethod -Uri $URI -Method GET

	}#process

	End { }#end

}
