# .ExternalHelp psRadiantOne-help.xml
function Get-R1LdapClientAccess {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LdapClientAccess')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'client_access/ldap'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LdapClientAccess

		}

	}#process

	End { }#end

}
