# .ExternalHelp psRadiantOne-help.xml
function Search-R1DataSource {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DataSourceSearchResult')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$dataSourceFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$objectFilter
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'data_sources/.search'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DataSourceSearchResult

		}

	}#process

	End { }#end

}
