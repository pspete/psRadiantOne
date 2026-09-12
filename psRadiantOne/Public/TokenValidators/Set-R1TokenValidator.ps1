# .ExternalHelp psRadiantOne-help.xml
function Set-R1TokenValidator {
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
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$jsonWebKeySetUri,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enabled,

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

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "external_token_validators/$($name | Get-EscapedString)"

		#Retrieve the validator and send it back with the supplied values applied over it, so a
		#property left unspecified keeps its current value.
		$Existing = Get-R1TokenValidator -name $name

		$Template = [ordered]@{
			name               = $name
			enabled            = $true
			oidcProvider       = $null
			apiService         = $null
			oidcDiscoveryUrl   = $null
			jsonWebKeySetUri   = $null
			scopeClaimName     = $null
			expectedAudience   = $null
			expectedScope      = $null
			jwtValidationClock = 0
			claimsMapper       = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove claimsExpressionList) -Fallback $Existing

		if ($PSBoundParameters.ContainsKey('claimsExpressionList')) {

			#claimsMapper wraps a single list, so the list is taken directly and the object built here
			$Request['claimsMapper'] = @{
				claimsExpressionList = @($claimsExpressionList)
			}

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty claimsExpressionList

		if ($PSCmdlet.ShouldProcess($name, 'Update External Token Validator')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
