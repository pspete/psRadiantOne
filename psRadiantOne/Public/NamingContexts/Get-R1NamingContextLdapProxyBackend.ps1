# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextLdapProxyBackend {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LdapProxyBackend')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/ldap_proxy/backend"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LdapProxyBackend

		}

	}#process

	End { }#end

}
