# .ExternalHelp psRadiantOne-help.xml
function Export-R1DataSource {
	[CmdletBinding()]
	[OutputType('System.IO.FileInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string[]]$dataSources,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateScript({
				if (-not (Test-Path -Path $PSItem -PathType Container)) {

					throw "Directory not found: $PSItem"

				}
				$true
			})]
		[string]$Path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ dataSources = @($dataSources) } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "data_sources/export`?$Query"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$OutputFile = Join-Path -Path $Path -ChildPath 'datasources.zip'

			if ($Result -is [byte[]]) {

				[System.IO.File]::WriteAllBytes($OutputFile, $Result)

			} else {

				[System.IO.File]::WriteAllText($OutputFile, $Result)

			}

			Get-Item -Path $OutputFile

		}

	}#process

	End { }#end

}
