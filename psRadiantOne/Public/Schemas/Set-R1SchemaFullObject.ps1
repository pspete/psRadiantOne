# .ExternalHelp psRadiantOne-help.xml
function Set-R1SchemaFullObject {
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
		[object[]]$tablesWithFields,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$relationships,

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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/full_obj"

		#Retrieve the complete schema and send it back with the supplied values applied over it, so
		#a property left unspecified keeps its current value.
		$Existing = Get-R1SchemaFullObject -schemaName $schemaName

		$Template = [ordered]@{
			name             = $schemaName
			lastModified     = $null
			type             = $null
			dataSourceName   = $null
			baseDn           = $null
			publishToServer  = $false
			objects          = $null
			tablesWithFields = @()
			relationships    = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove schemaName) -Fallback $Existing

		#A null collection stays null. Wrapped, it becomes a collection holding nothing, which the API
		#can store and then never read back.
		foreach ($Collection in 'tablesWithFields', 'relationships') {

			if ($null -ne $Request[$Collection]) {

				$Request[$Collection] = @($Request[$Collection])

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty tablesWithFields, relationships

		if ($PSCmdlet.ShouldProcess($schemaName, 'Save Complete Schema')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
