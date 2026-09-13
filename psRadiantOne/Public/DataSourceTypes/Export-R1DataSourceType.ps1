# .ExternalHelp psRadiantOne-help.xml
function Export-R1DataSourceType {
	[CmdletBinding()]
	[OutputType('System.IO.FileInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string[]]$templates,

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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'meta/export'

		$Body = @{ templates = @($templates) } | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$OutputFile = Join-Path -Path $Path -ChildPath 'templates.zip'

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
