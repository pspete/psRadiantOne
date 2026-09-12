# .ExternalHelp psRadiantOne-help.xml
function Set-R1OidcProvider {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 100)]
		[ValidatePattern('^[a-zA-Z0-9\s_-]+$')]
		[string]$configurationName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('Apple', 'Google', 'Microsoft', 'Salesforce', 'Yahoo', 'Custom')]
		[string]$providerName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$discoveryUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$authorizationEndpointUri,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$tokenEndpointUri,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 5000)]
		[string]$clientId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$requestedScopes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$oidcToFidUserMappings,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[securestring]$clientSecret,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('CLIENT_SECRET_POST', 'CLIENT_SECRET_BASIC')]
		[string]$clientAuthenticationMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[switch]$useExistingCredentials
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "oidc_providers/$($configurationName | Get-EscapedString)"

		if ($useExistingCredentials) {

			$Path = "$Path`?useExistingCredentials=true"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		#Retrieve the provider and send it back with the supplied values applied over it, so a
		#property left unspecified keeps its current value.
		$Existing = Get-R1OidcProvider -configurationName $configurationName

		$Template = [ordered]@{
			configurationName          = $configurationName
			providerName               = $null
			enabled                    = $true
			discoveryUrl               = $null
			authorizationEndpointUri   = $null
			tokenEndpointUri           = $null
			clientId                   = $null
			clientAuthenticationMethod = $null
			oidcToFidUserMappings      = @()
			requestedScopes            = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove clientSecret, useExistingCredentials) -Fallback $Existing

		foreach ($Collection in 'requestedScopes', 'oidcToFidUserMappings') {

			$Request[$Collection] = @($Request[$Collection])

		}

		if ($PSBoundParameters.ContainsKey('clientSecret')) {

			#An absent clientSecret leaves the stored secret unchanged
			$Request['clientSecret'] = $clientSecret | ConvertTo-InsecureString

		}

		$Body = $Request | ConvertTo-R1SecretBody -EmptyArrayProperty requestedScopes, oidcToFidUserMappings

		if ($PSCmdlet.ShouldProcess($configurationName, 'Update OIDC Provider')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
