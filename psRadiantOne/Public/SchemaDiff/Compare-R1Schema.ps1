# .ExternalHelp psRadiantOne-help.xml
function Compare-R1Schema {
	[CmdletBinding()]
	[OutputType('psRadiantOne.SchemaDiffTree')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('schemaName')]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dataSourceName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$ldap,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$objects
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'schema_diff/generate'

		$Request = $PSBoundParameters | Get-Parameter

		$Request['objects'] = @($Request['objects'])

		$Body = $Request | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.SchemaDiffTree

		}

	}#process

	End { }#end

}
