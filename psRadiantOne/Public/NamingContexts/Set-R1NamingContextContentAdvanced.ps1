# .ExternalHelp psRadiantOne-help.xml
function Set-R1NamingContextContentAdvanced {
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
		[ValidateSet('BIND', 'SEARCH', 'MODIFY', 'DELETE', 'ADD', 'SEARCH_RESULT_ENTRY_PROCESSING', 'COMPARE', 'SPECIAL_OPERATIONS')]
		[AllowEmptyCollection()]
		[string[]]$interceptOn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 5000)]
		[string]$objectClassMapping,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$processJoinComputedAttrsNecessary,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$requestNecessaryAttrOnly,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$distinct,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$leftOuterJoin,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('AS_IS', 'IGNORE_CASE', 'TRANSLATE_TO_UPPER')]
		[string]$searchCaseSensitivity,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 10000)]
		[AllowEmptyString()]
		[string]$sqlWhereClause,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 1000)]
		[AllowEmptyString()]
		[string]$ldapFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$maxRequestedAttributes
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/content/advanced"

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1NamingContextContentAdvanced -dn $dn

		#interceptionScriptFileName, javaClass, objectClass, dataSourceType and ldapFilterAttributes
		#are maintained by the API and are sent back unchanged
		$Template = [ordered]@{
			interceptOn                       = @()
			interceptionScriptFileName        = $null
			javaClass                         = $null
			objectClass                       = $null
			processJoinComputedAttrsNecessary = $false
			objectClassMapping                = $null
			dataSourceType                    = $null
			requestNecessaryAttrOnly          = $false
			distinct                          = $false
			leftOuterJoin                     = $false
			searchCaseSensitivity             = 'AS_IS'
			sqlWhereClause                    = $null
			ldapFilter                        = $null
			maxRequestedAttributes            = 30
			ldapFilterAttributes              = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Existing

		$Request['interceptOn'] = @($Request['interceptOn'] | Where-Object { $null -ne $_ })

		#An empty clause or filter clears it
		foreach ($Property in 'sqlWhereClause', 'ldapFilter') {

			if ([string]::IsNullOrEmpty($Request[$Property])) {

				$Request[$Property] = $null

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty interceptOn

		if ($PSCmdlet.ShouldProcess($dn, 'Update Content Advanced Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
