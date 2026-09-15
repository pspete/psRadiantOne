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
		[string]$catalogName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$schemaName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$tablePattern
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'data_sources/utils/database_tables'

		$Request = $PSBoundParameters | Get-Parameter

		#The request body is one of two shapes and existingDataSource is the discriminator the API
		#picks between them with. Without it the request is rejected as unconvertible, whatever else
		#it carries. This command names an existing data source, never a new connection.
		$Request['existingDataSource'] = $true

		$Body = $Request | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DatabaseTable

		}

	}#process

	End { }#end

}
