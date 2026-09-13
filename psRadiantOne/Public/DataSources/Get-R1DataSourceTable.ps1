# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSourceTable {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DatabaseTable')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$dataSourceName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$catalog,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$schemaPattern,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$tableNamePattern
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'data_sources/utils/database_tables'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DatabaseTable

		}

	}#process

	End { }#end

}
