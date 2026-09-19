# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextLdapProxyAdvanced {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LdapProxyAdvanced')]
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

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/ldap_proxy/advanced"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LdapProxyAdvanced

		}

	}#process

	End { }#end

}
