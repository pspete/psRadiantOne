# .ExternalHelp psRadiantOne-help.xml
function Set-R1NamingContextLdapProxyAdvanced {
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
		[bool]$joinOptimized,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$limitedAttributesRequested,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$useClientSizeLimit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 1000)]
		[AllowEmptyString()]
		[string]$preProcessingFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 1000)]
		[AllowEmptyString()]
		[string]$postProcessingFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$globalAttributesHandling,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$suffixBranchInclusion,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$suffixBranchExclusion,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$objectClassMapping,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('BIND', 'SEARCH', 'MODIFY', 'DELETE', 'ADD', 'SEARCH_RESULT_ENTRY_PROCESSING', 'COMPARE', 'SPECIAL_OPERATIONS')]
		[AllowEmptyCollection()]
		[string[]]$interceptOn
	)

	Begin {

		Assert-R1Session -RequireToken

		$ArrayProperties = 'globalAttributesHandling', 'suffixBranchInclusion', 'suffixBranchExclusion', 'objectClassMapping', 'interceptOn'

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/ldap_proxy/advanced"

		#Retrieve the current properties and send them back with the supplied values applied over
		#them, so a property left unspecified keeps its current value.
		$Existing = Get-R1NamingContextLdapProxyAdvanced -dn $dn

		#The script location is read as sourceLocation but sent as interceptionScriptFileName.
		#It and javaClass are maintained by the API and are sent back unchanged.
		$Fallback = [pscustomobject]@{
			interceptionScriptFileName = $Existing.sourceLocation
			javaClass                  = $Existing.javaClass
			joinOptimized              = $Existing.joinOptimized
			limitedAttributesRequested = $Existing.limitedAttributesRequested
			useClientSizeLimit         = $Existing.useClientSizeLimit
			preProcessingFilter        = $Existing.preProcessingFilter
			postProcessingFilter       = $Existing.postProcessingFilter
			globalAttributesHandling   = $Existing.globalAttributesHandling
			suffixBranchInclusion      = $Existing.suffixBranchInclusion
			suffixBranchExclusion      = $Existing.suffixBranchExclusion
			objectClassMapping         = $Existing.objectClassMapping
			interceptOn                = $Existing.interceptOn
		}

		$Template = [ordered]@{
			interceptionScriptFileName = $null
			javaClass                  = $null
			joinOptimized              = $false
			limitedAttributesRequested = $false
			useClientSizeLimit         = $false
			preProcessingFilter        = $null
			postProcessingFilter       = $null
			globalAttributesHandling   = @()
			suffixBranchInclusion      = @()
			suffixBranchExclusion      = @()
			objectClassMapping         = @()
			interceptOn                = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Fallback

		#An empty filter clears it
		foreach ($Property in 'preProcessingFilter', 'postProcessingFilter') {

			if ([string]::IsNullOrEmpty($Request[$Property])) {

				$Request[$Property] = $null

			}

		}

		foreach ($Property in $ArrayProperties) {

			$Request[$Property] = @($Request[$Property] | Where-Object { $null -ne $_ })

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty $ArrayProperties

		if ($PSCmdlet.ShouldProcess($dn, 'Update LDAP Proxy Advanced Properties')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
