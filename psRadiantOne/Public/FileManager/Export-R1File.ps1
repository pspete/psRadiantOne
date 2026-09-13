# .ExternalHelp psRadiantOne-help.xml
function Export-R1File {
	[CmdletBinding()]
	[OutputType('System.IO.FileInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('file')]
		[string[]]$files,

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

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'file_manager/files/download'

		$Body = @{ files = @($files) } | ConvertTo-R1JsonBody -EmptyArrayProperty files

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			#A single file comes back as itself; several come back as an archive
			$OutputName = if ($files.Count -eq 1) { Split-Path -Path $files[0] -Leaf } else { 'files.zip' }

			$OutputFile = Join-Path -Path $Path -ChildPath $OutputName

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
