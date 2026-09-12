# .ExternalHelp psRadiantOne-help.xml
function Get-R1LogSetting {
	[CmdletBinding(DefaultParameterSetName = 'Component')]
	[OutputType('psRadiantOne.LogSettings')]
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
		[string]$pluginName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		#The component names carry spaces, so they are escaped into the path
		$Path = switch ($PSCmdlet.ParameterSetName) {

			'DataSource' { "log_settings/datasources/$($dsName | Get-EscapedString)" }
			'Plugin' { "log_settings/plugins/$($pluginName | Get-EscapedString)" }
			default { "log_settings/$($component | Get-EscapedString)" }

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LogSettings

		}

	}#process

	End { }#end

}
