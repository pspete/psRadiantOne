# .ExternalHelp psRadiantOne-help.xml
function Set-R1StoreProperty {
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
		[bool]$isActive,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isSchemaChecking,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isEnsureSuperiorObjectClasses,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isNormalizeAttributeNames,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$indexedAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$nonIndexedAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$sortedAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$encryptedAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isFullTextSearchEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isOptimizeLinkAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enableChangelog,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$asyncIndexing,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isInterClusterRep,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$replicationExcludedAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 1000)]
		[AllowEmptyString()]
		[string]$storageLocation,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isEnsurePushModeEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$pushModeDataSources
	)

	Begin {

		Assert-R1Session -RequireToken

		$ArrayProperties = 'indexedAttributes', 'nonIndexedAttributes', 'sortedAttributes', 'encryptedAttributes', 'replicationExcludedAttributes', 'pushModeDataSources'

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/store/properties"

		#Retrieve the current properties and send them back with the supplied values applied over
		#them, so a property left unspecified keeps its current value.
		$Existing = Get-R1StoreProperty -dn $dn

		#type, namingContext and withoutCacheRefresh are not returned by the API but are sent as the
		#control panel sends them for a RadiantOne Directory store
		$Template = [ordered]@{
			type                          = 'RadiantOne Directory'
			namingContext                 = $dn
			isSchemaChecking              = $false
			isEnsureSuperiorObjectClasses = $false
			isNormalizeAttributeNames     = $false
			indexedAttributes             = @()
			nonIndexedAttributes          = @()
			sortedAttributes              = @()
			encryptedAttributes           = @()
			isFullTextSearchEnabled       = $false
			isActive                      = $true
			isOptimizeLinkAttributes      = $false
			enableChangelog               = $false
			asyncIndexing                 = $false
			isInterClusterRep             = $false
			replicationExcludedAttributes = @()
			storageLocation               = $null
			isEnsurePushModeEnabled       = $false
			pushModeDataSources           = @()
			withoutCacheRefresh           = $true
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Existing

		foreach ($Property in 'type', 'namingContext', 'withoutCacheRefresh') {

			$Request[$Property] = $Template[$Property]

		}

		foreach ($Property in $ArrayProperties) {

			$Request[$Property] = [string[]]@($Request[$Property] | Where-Object { $null -ne $_ })

		}

		if ([string]::IsNullOrEmpty($Request['storageLocation'])) {

			$Request['storageLocation'] = $null

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty $ArrayProperties

		if ($PSCmdlet.ShouldProcess($dn, 'Update Directory Store Properties')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
