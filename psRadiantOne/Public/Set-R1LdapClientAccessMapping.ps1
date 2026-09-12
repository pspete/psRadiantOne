# .ExternalHelp psRadiantOne-help.xml
function Set-R1LdapClientAccessMapping {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[AllowEmptyCollection()]
		[hashtable[]]$mappings
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'client_access/ldap/mappings'

		if ($mappings.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($mappings)

		}

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, "Replace LDAP Client Access Mappings ($($mappings.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
