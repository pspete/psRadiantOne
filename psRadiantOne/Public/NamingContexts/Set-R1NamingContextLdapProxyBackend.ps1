# .ExternalHelp psRadiantOne-help.xml
function Set-R1NamingContextLdapProxyBackend {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$datasource,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$baseDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('PASS_THROUGH', 'FILTER', 'STRICT')]
		[string]$schemaEnforcementMode,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isActive,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isDedicatedConnection,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isPassThroughAuthorization,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isProxyAuthorization
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/ldap_proxy/backend"

		#Retrieve the current properties and send them back with the supplied values applied over
		#them, so a property left unspecified keeps its current value.
		$Existing = Get-R1NamingContextLdapProxyBackend -dn $dn

		#namespaceDn is maintained by the API and is sent back unchanged
		$Template = [ordered]@{
			datasource                 = $null
			baseDn                     = $null
			schemaEnforcementMode      = 'PASS_THROUGH'
			isActive                   = $true
			isDedicatedConnection      = $false
			isPassThroughAuthorization = $false
			isProxyAuthorization       = $false
			namespaceDn                = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, 'Update LDAP Proxy Backend Properties')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
