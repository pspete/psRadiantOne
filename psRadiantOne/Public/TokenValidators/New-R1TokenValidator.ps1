# .ExternalHelp psRadiantOne-help.xml
function New-R1TokenValidator {
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
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 500)]
		[string]$jsonWebKeySetUri,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enabled = $true,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('REST(adap)', 'SCIM')]
		[string]$apiService,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('Apple', 'Google', 'Microsoft', 'Salesforce', 'Yahoo', 'Custom')]
		[string]$oidcProvider,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 500)]
		[string]$oidcDiscoveryUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$scopeClaimName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$expectedAudience,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$expectedScope,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, 3600)]
		[int]$jwtValidationClock,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$claimsExpressionList
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'external_token_validators'

		$Request = $PSBoundParameters | Get-Parameter -ParametersToRemove claimsExpressionList

		#claimsMapper wraps a single list, so the list is taken directly and the object built here
		$Request['claimsMapper'] = @{
			claimsExpressionList = @($claimsExpressionList)
		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty claimsExpressionList

		if ($PSCmdlet.ShouldProcess($name, 'Create External Token Validator')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
