# .ExternalHelp psRadiantOne-help.xml
function Get-R1LdapClientAccessMapping {
	[CmdletBinding()]
	[OutputType('psRadiantOne.UserToDnMapping')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'client_access/ldap/mappings'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.UserToDnMapping

		}

	}#process

	End { }#end

}
