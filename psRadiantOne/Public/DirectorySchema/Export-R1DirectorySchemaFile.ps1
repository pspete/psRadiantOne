# .ExternalHelp psRadiantOne-help.xml
function Export-R1DirectorySchemaFile {
	[CmdletBinding()]
	[OutputType('System.IO.FileInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidatePattern('^[\w,\s-]+\.(?i)(ldif|ldifz)$')]
		[string]$fileName,

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

		$URI = Resolve-R1ServiceUrl -Service Schema -Path "files/$($fileName | Get-EscapedString)/download"

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST

		if ($null -ne $Result) {

			$OutputFile = Join-Path -Path $Path -ChildPath $fileName

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
