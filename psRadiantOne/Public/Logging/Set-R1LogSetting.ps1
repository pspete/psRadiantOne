# .ExternalHelp psRadiantOne-help.xml
function Set-R1LogSetting {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Component')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Component'
		)]
		[ValidateSet(
			'RadiantOne Server',
			'Persistent Cache Periodic Refresh',
			'ADAP Access',
			'Sync Engine',
			'SCIM',
			'Scheduler Server',
			'Scheduler Tasks',
			'Control Panel Server',
			'Control Panel Access',
			'Control Panel Context Builder Audit',
			'Common User',
			'Sync Agents',
			'RadiantOne LDAP Access'
		)]
		[string]$component,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DataSource'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dsName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Plugin'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$pluginName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('OFF', 'FATAL', 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE')]
		[string]$logLevel,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$rolloverSize,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(1, [int64]::MaxValue)]
		[int64]$archiveMaxFileCount,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$integrityAssurance,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$advancedProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enableDebugSSL,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$logNotificationFailure,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$accessLogTextFormat,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$accessLogCsvFormat,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$addColumnNamesHeadersToCsv,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$ignoreAccessLogsNamingContext,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$textDestination,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$textRolloverDestination,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$textDeleteGlob,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$scanFolder,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$csvDestination,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$csvRolloverDestination,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$csvDeleteGlob,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$bufferSizeForFileLogging,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$useIsoFormat,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$timezone
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = switch ($PSCmdlet.ParameterSetName) {

			'DataSource' { "log_settings/datasources/$($dsName | Get-EscapedString)" }
			'Plugin' { "log_settings/plugins/$($pluginName | Get-EscapedString)" }
			default { "log_settings/$($component | Get-EscapedString)" }

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		#Log settings are polymorphic: each component carries a different set of properties, keyed by
		#logSettingsComponent. Rather than model all seven variants, retrieve whichever one this
		#component uses and apply the supplied values over it, so the properties belonging to that
		#variant are preserved and no property foreign to it is introduced.
		$Identity = switch ($PSCmdlet.ParameterSetName) {
			'DataSource' { @{ dsName = $dsName } }
			'Plugin' { @{ pluginName = $pluginName } }
			default { @{ component = $component } }
		}

		$Target = $Identity.Values | Select-Object -First 1

		$Existing = Get-R1LogSetting @Identity -ErrorAction Stop | Select-Object -First 1

		if ($null -eq $Existing) {

			throw "No log settings found for '$Target'"

		}

		$Request = [ordered]@{ }

		foreach ($Property in $Existing.psobject.Properties) {

			$Request[$Property.Name] = $Property.Value

		}

		$Supplied = $PSBoundParameters | Get-Parameter -ParametersToRemove component, dsName, pluginName

		foreach ($Key in $Supplied.Keys) {

			$Request[$Key] = $Supplied[$Key]

		}

		if ($Request.Contains('advancedProperties')) {

			$Request['advancedProperties'] = @(ConvertTo-R1NameValueList -InputObject $Request['advancedProperties'] -KeyName key)

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty advancedProperties

		if ($PSCmdlet.ShouldProcess($Target, 'Update Log Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
