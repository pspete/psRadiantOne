# .ExternalHelp psRadiantOne-help.xml
function Test-R1DataSourceConnection {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ConnectionTestResult')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[object]$DataSource,

		[parameter(Mandatory = $false)]
		[switch]$useExistingCredentials
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'data_sources/test_connection'

		if ($useExistingCredentials) {

			$Path = "$Path`?useExistingCredentials=true"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		$Body = $DataSource | ConvertTo-R1SecretBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ConnectionTestResult

		}

	}#process

	End { }#end

}
