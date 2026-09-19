# .ExternalHelp psRadiantOne-help.xml
function Invoke-R1CacheRealTimeConnectorScript {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType('psRadiantOne.ScriptExecutionResult')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$connectorId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateSet('CONFIGURE', 'DECONFIGURE')]
		[string]$action
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ action = $action } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/refresh/real_time_connectors/$($connectorId | Get-EscapedString)/scripts/execute`?$Query"

		if ($PSCmdlet.ShouldProcess("$dn ($connectorId)", "Run the $action Scripts on the Data Source")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.ScriptExecutionResult

			}

		}

	}#process

	End { }#end

}
