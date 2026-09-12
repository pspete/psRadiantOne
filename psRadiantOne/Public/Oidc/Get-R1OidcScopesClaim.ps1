# .ExternalHelp psRadiantOne-help.xml
function Get-R1OidcScopesClaim {
	[CmdletBinding()]
	[OutputType('psRadiantOne.OidcScopesClaims')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$discoveryUrl
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "oidc_providers/scopes_claims?discoveryUrl=$($discoveryUrl | Get-EscapedString)"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.OidcScopesClaims

		}

	}#process

	End { }#end

}
