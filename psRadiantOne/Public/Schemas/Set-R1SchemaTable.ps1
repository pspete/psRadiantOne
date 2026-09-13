# .ExternalHelp psRadiantOne-help.xml
function Set-R1SchemaTable {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('schema')]
		[string]$schemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$tableName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$objectClass,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$baseTable,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$candidateKeyName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$candidateKeys,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$owner,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$primaryKeys,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isTable
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/tables/$($tableName | Get-EscapedString)"

		#Retrieve the current table and send it back with the supplied values applied over it, so a
		#property left unspecified keeps its current value.
		$Existing = Get-R1SchemaTable -schemaName $schemaName -tableName $tableName

		$Template = [ordered]@{
			baseTable        = $null
			candidateKeyName = $null
			candidateKeys    = @()
			name             = $tableName
			parent           = $null
			objectClass      = $null
			owner            = $null
			primaryKeys      = @()
			isTable          = $true
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove schemaName, tableName) -Fallback $Existing

		foreach ($Collection in 'candidateKeys', 'primaryKeys') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty candidateKeys, primaryKeys

		if ($PSCmdlet.ShouldProcess($tableName, 'Update Table View')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
