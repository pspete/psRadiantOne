# .ExternalHelp psRadiantOne-help.xml
function Set-R1Schema {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$schemaName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('LDAP', 'DATABASE', 'CUSTOM')]
		[string]$type,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$dataSourceName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$baseDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$publishToServer
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)"

		#Retrieve the current properties and send them back with the supplied values applied over
		#them, so a property left unspecified keeps its current value.
		$Existing = Get-R1Schema -schemaName $schemaName

		#lastModified is maintained by the API and is sent back unchanged. objects is write only and
		#is documented as empty on update, so it is not sent.
		$Template = [ordered]@{
			name            = $schemaName
			lastModified    = $null
			type            = $null
			dataSourceName  = $null
			baseDn          = $null
			publishToServer = $false
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove schemaName) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($schemaName, 'Save Schema')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
