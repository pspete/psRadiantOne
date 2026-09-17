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
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateScript({
				#Either an existing directory, or the full path of a file in one
				$Directory = if (Test-Path -LiteralPath $PSItem -PathType Container) { $PSItem } else { Split-Path -Path $PSItem -Parent }

				if ((-not ([string]::IsNullOrEmpty($Directory))) -and (-not (Test-Path -LiteralPath $Directory -PathType Container))) {

					throw "Directory not found: $Directory"

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

		#A single file comes back as itself; several come back as an archive
		$OutputName = if ($files.Count -eq 1) { Split-Path -Path $files[0] -Leaf } else { 'files.zip' }

		$Download = @{
			Uri         = $URI
			Method      = 'POST'
			Body        = $Body
			DefaultName = $OutputName
		}

		if ($PSBoundParameters.ContainsKey('Path')) {

			$Download['Path'] = $Path

		}

		Save-R1Download @Download

	}#process

	End { }#end

}
