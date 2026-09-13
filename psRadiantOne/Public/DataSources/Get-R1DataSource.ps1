# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSource {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.DataSource')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Name'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[bool]$activeOnly,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[string]$filter,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[string]$type,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[string]$sortBy,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateSet('ASC', 'DESC')]
		[string]$sortOrder,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateRange(1, 10000)]
		[int]$pageSize
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Name') {

			$URI = Resolve-R1ServiceUrl -Service Catalog -Path "data_sources/$($name | Get-EscapedString)"

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.DataSource

			}

		} else {

			$Query = $PSBoundParameters | Get-Parameter

			if ($Query.ContainsKey('activeOnly')) {

				#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
				$Query['activeOnly'] = "$($Query['activeOnly'])".ToLowerInvariant()

			}

			$PageNumber = 1

			do {

				$Query['pageNumber'] = $PageNumber

				$URI = Resolve-R1ServiceUrl -Service Catalog -Path "data_sources`?$($Query | ConvertTo-QueryString)"

				$Result = Invoke-R1RestMethod -Uri $URI -Method GET

				if ($null -ne $Result.result) {

					$Result.result | Add-CustomType -Type psRadiantOne.DataSource

				}

				$PageNumber++

			} while ($PageNumber -le $Result.totalPages)

		}

	}#process

	End { }#end

}
