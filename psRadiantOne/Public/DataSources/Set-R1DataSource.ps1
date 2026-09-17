# .ExternalHelp psRadiantOne-help.xml
function Set-R1DataSource {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$defaultSchema,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$addedSchemas,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[Alias('host')]
		[string]$hostName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$port,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$ssl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$bindDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$baseDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$url,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$username,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$customProps,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[hashtable]$sdcMappings,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'NewPassword'
		)]
		[securestring]$password,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'ExistingCredentials'
		)]
		[switch]$useExistingCredentials
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		#Retrieve the data source and send it back with the supplied values applied over it, so a
		#property left unspecified keeps its current value.
		$Existing = Get-R1DataSource -name $name

		#The shape differs by category, so the template is built from what the API returned rather
		#than from a fixed list of properties.
		$Template = [ordered]@{ }

		foreach ($Property in $Existing.psobject.Properties) {

			$Template[$Property.Name] = $Property.Value

		}

		$Bound = $PSBoundParameters | Get-Parameter -ParametersToRemove password, useExistingCredentials

		if ($Bound.Contains('hostName')) {

			$Bound['host'] = $Bound['hostName']
			$null = $Bound.Remove('hostName')

		}

		foreach ($Key in $Bound.Keys) {

			$Template[$Key] = $Bound[$Key]

		}

		#A schema field the API reads back as null is left out of the update, as the control panel
		#leaves it out. A null addedSchemas sent as a collection is one the API stores and can then
		#never read back: one such record makes every later read of the collection fail.
		foreach ($Property in 'defaultSchema', 'addedSchemas') {

			if ($Template.Contains($Property) -and $null -eq $Template[$Property]) {

				$Template.Remove($Property)

			}

		}

		#A single schema name has to reach the API as a collection.
		if ($Template.Contains('addedSchemas')) {

			$Template['addedSchemas'] = @($Template['addedSchemas'])

		}

		#The connector mappings are the one property the API will not take null for, so where it reads
		#one back the empty map the control panel sends goes instead. Every other property is left as
		#it was read, so an update carries back what it was given.
		if ($Template.Contains('sdcMappings') -and $null -eq $Template['sdcMappings']) {

			$Template['sdcMappings'] = @{ }

		}

		#A password read back from the API is an empty string when one is set, which the API would
		#read as an instruction to clear it. Null is only understood as leave it alone for the fields
		#of a custom data source, so the query parameter is what keeps an LDAP or database password.
		if ($PSCmdlet.ParameterSetName -eq 'NewPassword') {

			$Template['password'] = $password | ConvertTo-InsecureString

		} elseif ($Template.Contains('password')) {

			$Template['password'] = $null

		}

		$Path = "data_sources/$($name | Get-EscapedString)"

		if ($PSCmdlet.ParameterSetName -eq 'ExistingCredentials') {

			$Path = "$Path`?useExistingCredentials=true"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		$Body = $Template | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($name, 'Update Data Source')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
