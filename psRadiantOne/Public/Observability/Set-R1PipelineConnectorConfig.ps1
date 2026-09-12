# .ExternalHelp psRadiantOne-help.xml
function Set-R1PipelineConnectorConfig {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$pipelineId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable[]]$properties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$type
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "identity_observability/$($pipelineId | Get-EscapedString)/connector_config"

		#Retrieve the connector configuration so the type is preserved when only the properties are
		#being changed.
		$Existing = Get-R1PipelineConnectorConfig -pipelineId $pipelineId

		$Template = [ordered]@{
			type       = $null
			properties = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove pipelineId) -Fallback $Existing
		$Request['properties'] = @($Request['properties'])

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty properties

		if ($PSCmdlet.ShouldProcess($pipelineId, 'Update Pipeline Connector Configuration')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
