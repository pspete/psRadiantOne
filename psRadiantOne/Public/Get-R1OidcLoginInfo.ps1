# .ExternalHelp psRadiantOne-help.xml
function Get-R1OidcLoginInfo {
	[CmdletBinding()]
	[OutputType('psRadiantOne.OidcLoginInfo')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'oidc_providers/login_info'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.OidcLoginInfo

		}

	}#process

	End { }#end

}
