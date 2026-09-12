# .ExternalHelp psRadiantOne-help.xml
function Get-R1OidcDiscoveryInfo {
	[CmdletBinding()]
	[OutputType('psRadiantOne.OidcDiscoveryInfo')]
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

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "oidc_providers/discovery_info?discoveryUrl=$($discoveryUrl | Get-EscapedString)"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.OidcDiscoveryInfo

		}

	}#process

	End { }#end

}
