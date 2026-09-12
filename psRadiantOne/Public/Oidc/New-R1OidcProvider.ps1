# .ExternalHelp psRadiantOne-help.xml
function New-R1OidcProvider {
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
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('Apple', 'Google', 'Microsoft', 'Salesforce', 'Yahoo', 'Custom')]
		[string]$providerName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$discoveryUrl,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$authorizationEndpointUri,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$tokenEndpointUri,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 5000)]
		[string]$clientId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$requestedScopes,

		[parameter(
			Mandatory = $true,
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
		[bool]$enabled = $true,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('CLIENT_SECRET_POST', 'CLIENT_SECRET_BASIC')]
		[string]$clientAuthenticationMethod
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'oidc_providers'

		$Request = $PSBoundParameters | Get-Parameter -ParametersToRemove clientSecret
		$Request['requestedScopes'] = @($requestedScopes)
		$Request['oidcToFidUserMappings'] = @($oidcToFidUserMappings)

		if ($PSBoundParameters.ContainsKey('clientSecret')) {

			$Request['clientSecret'] = $clientSecret | ConvertTo-InsecureString

		}

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($configurationName, 'Create OIDC Provider')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
