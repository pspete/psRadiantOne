# .ExternalHelp psRadiantOne-help.xml
function Set-R1CacheProperty {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isActive,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isFullTextSearch,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[ValidateLength(0, 1000)]
		[AllowEmptyString()]
		[string]$storageLocation,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isUseCacheForAuth,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isLocalBindOnly,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isDelegateOnFailure,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isEnablePasswordPolicyEnforcement,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isPasswordWriteBack,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isOptimizeLinkedAttributes,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$caseSensitiveAttributesCompare,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$caseSensitiveAttributes,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$nonIndexedAttributes,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$sortedAttributes,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$encryptedAttributes,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$extensionAttributes,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyString()]
		[string]$invariantAttribute,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isInterClusterReplication,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isEnsurePushMode,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$pushModeDataSources,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$replicationExcludedAttributes,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$isAcceptChangesFromReplicas,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[AllowEmptyCollection()]
		[string[]]$updatableAttributesFromReplicas,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$changeLogEnabled,

		[parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[bool]$asyncIndexingEnabled
	)

	Begin {

		Assert-R1Session -RequireToken

		$ArrayProperties = 'caseSensitiveAttributes', 'nonIndexedAttributes', 'sortedAttributes', 'encryptedAttributes', 'extensionAttributes', 'pushModeDataSources', 'replicationExcludedAttributes', 'updatableAttributesFromReplicas'

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/properties"

		#Retrieve the current properties and send them back with the supplied values applied over
		#them, so a property left unspecified keeps its current value.
		$Existing = Get-R1CacheProperty -dn $dn

		#isConfigured, isInitialized and the suffixes are maintained by the API and are sent back
		#unchanged
		$Template = [ordered]@{
			isActive                          = $true
			isConfigured                      = $false
			isInitialized                     = $false
			startingSuffix                    = $null
			internalSuffix                    = $null
			isFullTextSearch                  = $false
			storageLocation                   = $null
			isUseCacheForAuth                 = $false
			isLocalBindOnly                   = $false
			isDelegateOnFailure               = $false
			isEnablePasswordPolicyEnforcement = $false
			isPasswordWriteBack               = $false
			isOptimizeLinkedAttributes        = $false
			caseSensitiveAttributesCompare    = $false
			caseSensitiveAttributes           = @()
			nonIndexedAttributes              = @()
			sortedAttributes                  = @()
			encryptedAttributes               = @()
			extensionAttributes               = @()
			invariantAttribute                = $null
			isInterClusterReplication         = $false
			isEnsurePushMode                  = $false
			pushModeDataSources               = @()
			replicationExcludedAttributes     = @()
			isAcceptChangesFromReplicas       = $false
			updatableAttributesFromReplicas   = @()
			changeLogEnabled                  = $false
			asyncIndexingEnabled              = $false
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Existing

		foreach ($Property in $ArrayProperties) {

			$Request[$Property] = [string[]]@($Request[$Property] | Where-Object { $null -ne $_ })

		}

		foreach ($Property in 'storageLocation', 'invariantAttribute') {

			if ([string]::IsNullOrEmpty($Request[$Property])) {

				$Request[$Property] = $null

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty $ArrayProperties

		if ($PSCmdlet.ShouldProcess($dn, 'Update Persistent Cache Properties')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
